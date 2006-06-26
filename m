Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWFZA7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWFZA7O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWFZA6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:53 -0400
Received: from terminus.zytor.com ([192.83.249.54]:17551 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964985AbWFZA6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:35 -0400
Date: Sun, 25 Jun 2006 17:58:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 12/43] Enable CONFIG_KLIBC_ZLIB (now required to build kinit)
Message-Id: <klibc.200606251757.12@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After removing the private copy of zlib in kinit, we need
CONFIG_KLIBC_ZLIB in order to build klibc.  zlib is required in order
to decompress classical ramdisks.

In the future this should maybe be made conditional on CONFIG_BLK_DEV_RAM.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit baacd5d81ff7151e8df3893850ec363441886a1e
tree 0075da4cf5c328f29a89c98e053a5b2cd5e50afe
parent d669be433cc9bc413d958e140f8ec47211498a2a
author H. Peter Anvin <hpa@zytor.com> Mon, 01 May 2006 02:51:52 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:47:36 -0700

 usr/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/usr/Kconfig b/usr/Kconfig
index ea3b520..4103a02 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -48,3 +48,7 @@ config INITRAMFS_ROOT_GID
 config KLIBC_ERRLIST
 	bool
 	default y
+
+config KLIBC_ZLIB
+	bool
+	default y
