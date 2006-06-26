Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWFZBIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWFZBIg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWFZA6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:47 -0400
Received: from terminus.zytor.com ([192.83.249.54]:14223 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964971AbWFZA6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:16 -0400
Date: Sun, 25 Jun 2006 17:57:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 05/43] Need to export RANLIB from the top Makefile
Message-Id: <klibc.200606251757.05@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

klibc needs RANLIB, and since KLIBCRANLIB is now generated from RANLIB,
we need to actually define RANLIB.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit f3e41698e540a7d39658d6590fde1379c0f5bab0
tree 2c41ad2f69c0ba17652e90d6cee122675727dc1d
parent 5ad9bee01be52a0593fedcf905ae26ef4fd65007
author H. Peter Anvin <hpa@zytor.com> Thu, 06 Apr 2006 11:33:35 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:46:08 -0700

 Makefile |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 889ee38..897e647 100644
--- a/Makefile
+++ b/Makefile
@@ -280,6 +280,7 @@ LD		= $(CROSS_COMPILE)ld
 CC		= $(CROSS_COMPILE)gcc
 CPP		= $(CC) -E
 AR		= $(CROSS_COMPILE)ar
+RANLIB		= $(CROSS_COMPILE)ranlib
 NM		= $(CROSS_COMPILE)nm
 STRIP		= $(CROSS_COMPILE)strip
 OBJCOPY		= $(CROSS_COMPILE)objcopy
@@ -316,10 +317,11 @@ # Read KERNELRELEASE from .kernelrelease
 KERNELRELEASE = $(shell cat .kernelrelease 2> /dev/null)
 KERNELVERSION = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
-export	VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION \
-	ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
-	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
-	HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS KLIBCARCH
+export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION ARCH
+export KLIBCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD
+export CC CPP AR RANLIB NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS
+export PERL UTS_MACHINE HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK
+export CHECKFLAGS
 
 export CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
