OWNER ?= ociscloud
CPU_ARCH ?= amd64
OS ?= ubuntu

PROTOBUF_IMAGE_NAME ?= protobuf
GOLANG_IMAGE_NAME ?= golang
GOLANG_VERSION ?= 1.22.4

.PHONY: release-image-5.27
release-image-5.27: release-image-golang
	docker build \
	--build-arg PROTOC_VER=27.2 \
	--build-arg PROTOC_GEN_GO_VER=1.34.2 \
	--build-arg PROTOC_GEN_GO_GRPC_VER=1.5.1 \
	--build-arg PROTOC_GO_INJECT_TAG_VER=1.4.0 \
	-f protocbuffer/Dockerfile \
	-t $(OWNER)/$(PROTOBUF_IMAGE_NAME):5.27.2-$(OS) .

.PHONY: release-image-5.28
release-image-5.28: release-image-golang
	docker build \
	--build-arg PROTOC_VER=28.0 \
	--build-arg PROTOC_GEN_GO_VER=1.34.2 \
	--build-arg PROTOC_GEN_GO_GRPC_VER=1.5.1 \
	--build-arg PROTOC_GO_INJECT_TAG_VER=1.4.0 \
	-f protocbuffer/Dockerfile \
	-t $(OWNER)/$(PROTOBUF_IMAGE_NAME):5.28.0-$(OS) .

.PHONY: release-image-4.22
release-image-4.22: release-image-golang
	docker build \
	--build-arg PROTOC_VER=22.0 \
	--build-arg PROTOC_GEN_GO_VER=1.28.1 \
	--build-arg PROTOC_GEN_GO_GRPC_VER=1.3.0 \
	--build-arg PROTOC_GO_INJECT_TAG_VER=1.4.0 \
	-f protocbuffer/Dockerfile \
	-t $(OWNER)/$(PROTOBUF_IMAGE_NAME):4.22.0-$(OS) .


.PHONY: release-image-golang
release-image-golang:
	docker build \
	--platform linux/$(CPU_ARCH) \
	--build-arg BUILDPLATFORM=linux/$(CPU_ARCH)  \
	--build-arg GOLANG_VERSION=$(GOLANG_VERSION) \
	-f golang/Dockerfile \
	-t $(OWNER)/golang:$(GOLANG_VERSION)-$(OS)-${CPU_ARCH} .


.PHONY: release-image
release-image: release-image-5.27 release-image-5.28 release-image-4.22 release-image-golang
