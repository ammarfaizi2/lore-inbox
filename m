Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVK0QLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVK0QLY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 11:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVK0QLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 11:11:24 -0500
Received: from quark.didntduck.org ([69.55.226.66]:25553 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751091AbVK0QLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 11:11:23 -0500
Message-ID: <4389DB56.5060207@didntduck.org>
Date: Sun, 27 Nov 2005 11:14:14 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use KERNELRELEASE
Content-Type: multipart/mixed;
 boundary="------------050306010500090009070907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050306010500090009070907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Clean up two more open-coded uses of KERNELRELEASE.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------050306010500090009070907
Content-Type: text/plain;
 name="kernelrelease"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernelrelease"

diff --git a/arch/frv/boot/Makefile b/arch/frv/boot/Makefile
index d75e0d7..5dfc93f 100644
--- a/arch/frv/boot/Makefile
+++ b/arch/frv/boot/Makefile
@@ -57,10 +57,10 @@ initrd:
 # installation
 #
 install: $(CONFIGURE) Image
-	sh ./install.sh $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) Image $(TOPDIR)/System.map "$(INSTALL_PATH)"
+	sh ./install.sh $(KERNELRELEASE) Image $(TOPDIR)/System.map "$(INSTALL_PATH)"
 
 zinstall: $(CONFIGURE) zImage
-	sh ./install.sh $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) zImage $(TOPDIR)/System.map "$(INSTALL_PATH)"
+	sh ./install.sh $(KERNELRELEASE) zImage $(TOPDIR)/System.map "$(INSTALL_PATH)"
 
 #
 # miscellany
diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index d8fffe6..8f709ab 100644
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -15,7 +15,7 @@ set -e
 #
 # Some variables and settings used throughout the script
 #
-version="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}${EXTRANAME}"
+version="${KERNELRELEASE}${EXTRANAME}"
 tmpdir="${objtree}/tar-install"
 tarball="${objtree}/linux-${version}.tar"
 

--------------050306010500090009070907--
