# Build Stage
FROM node:20-alpine AS builder

WORKDIR /app
COPY . .

RUN npm install && npm run build

# Production Stage
FROM node:20-alpine

WORKDIR /app

# Kopiere nur das Gebaute
COPY --from=builder /app/build ./build
COPY --from=builder /app/package.json /app/package-lock.json ./
RUN npm install --omit=dev

# Set environment defaults
ENV NODE_ENV=production

CMD ["node", "build/index.js"]
