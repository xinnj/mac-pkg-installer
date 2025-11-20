#! /bin/bash
set -euaxo pipefail

component_path_arm64="<your arm64 version app bundle path here>"
component_path_x86_64="<your x86_64 version app bundle path here>"

mkdir -p pkg-tmp

rm -rf pkg-tmp/*
pkgbuild --scripts installer/Scripts-arm64 --component "${component_path_arm64}" --install-location /Applications \
  pkg-tmp/app.pkg
productbuild --sign '<your mac installer sign cert>' --timestamp=none --resources installer/Resources \
  --distribution installer/Distribution.xml --package-path pkg-tmp my-product-arm64.pkg

rm -rf pkg-tmp/*
pkgbuild --scripts installer/Scripts-x86_64 --component "${component_path_x86_64}" --install-location /Applications \
  pkg-tmp/app.pkg
productbuild --sign '<your mac installer sign cert>' --timestamp=none --resources installer/Resources \
  --distribution installer/Distribution.xml --package-path pkg-tmp my-product-x86_64.pkg