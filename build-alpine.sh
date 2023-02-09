#!/bin/sh

set -eu

apk upgrade
apk add \
  alpine-sdk \
  clang15 \
  cmake \
  git \
  lld \
  samurai

cmake \
  -Bbuild \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DCMAKE_C_FLAGS="-flto=thin -fsplit-lto-unit" \
  -DCMAKE_CXX_FLAGS="-flto=thin -fsplit-lto-unit" \
  -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld -s -static" \
  -G Ninja

cmake --build build
