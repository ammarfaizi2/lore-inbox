Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269702AbUJGF1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269702AbUJGF1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 01:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269703AbUJGF1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 01:27:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:34972 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269702AbUJGF1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 01:27:49 -0400
Subject: [PATCH] ppc64: update g5_defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097126467.4954.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 15:21:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

This patch updates the g5_defconfig, among others, it adds irq stacks, hugetlbfs and
cramfs (later is needed for ppl trying to install fedora, and so often forgotten that
I prefer adding it to the defconfig).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc64/configs/g5_defconfig 1.9 vs edited =====
--- 1.9/arch/ppc64/configs/g5_defconfig	2004-09-23 17:38:47 +10:00
+++ edited/arch/ppc64/configs/g5_defconfig	2004-10-07 15:18:57 +10:00
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.9-rc2
-# Thu Sep 23 17:07:00 2004
+# Linux kernel version: 2.6.9-rc3
+# Thu Oct  7 15:18:38 2004
 #
 CONFIG_64BIT=y
 CONFIG_MMU=y
@@ -69,7 +69,7 @@
 CONFIG_PPC64=y
 CONFIG_PPC_OF=y
 CONFIG_ALTIVEC=y
-CONFIG_PMAC_DART=y
+CONFIG_U3_DART=y
 CONFIG_PPC_PMAC64=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_POWER4_ONLY=y
@@ -428,6 +428,7 @@
 # CONFIG_IP_NF_MATCH_ADDRTYPE is not set
 # CONFIG_IP_NF_MATCH_REALM is not set
 # CONFIG_IP_NF_MATCH_SCTP is not set
+# CONFIG_IP_NF_MATCH_COMMENT is not set
 CONFIG_IP_NF_FILTER=y
 CONFIG_IP_NF_TARGET_REJECT=y
 CONFIG_IP_NF_TARGET_LOG=y
@@ -1044,8 +1045,8 @@
 CONFIG_DEVPTS_FS_XATTR=y
 # CONFIG_DEVPTS_FS_SECURITY is not set
 CONFIG_TMPFS=y
-# CONFIG_HUGETLBFS is not set
-# CONFIG_HUGETLB_PAGE is not set
+CONFIG_HUGETLBFS=y
+CONFIG_HUGETLB_PAGE=y
 CONFIG_RAMFS=y
 
 #
@@ -1058,7 +1059,7 @@
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_CRAMFS is not set
+CONFIG_CRAMFS=y
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
@@ -1174,7 +1175,7 @@
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_PPCDBG is not set
-# CONFIG_IRQSTACKS is not set
+CONFIG_IRQSTACKS=y
 # CONFIG_SCHEDSTATS is not set
 
 #
@@ -1193,7 +1194,7 @@
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
-# CONFIG_CRYPTO_WHIRLPOOL is not set
+# CONFIG_CRYPTO_WP512 is not set
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
@@ -1215,5 +1216,5 @@
 CONFIG_CRC_CCITT=m
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
-CONFIG_ZLIB_INFLATE=m
+CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m


