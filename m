Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVCGSIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVCGSIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 13:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVCGSIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 13:08:16 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:56836 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261201AbVCGSHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 13:07:22 -0500
Message-Id: <200503072037.j27KbGbc003947@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/16] UML - Update defconfig
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:37:16 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/defconfig
===================================================================
--- linux-2.6.11.orig/arch/um/defconfig	2005-03-04 15:38:37.000000000 -0500
+++ linux-2.6.11/arch/um/defconfig	2005-03-04 15:39:48.000000000 -0500
@@ -1,13 +1,11 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-mm4
-# Wed Dec  1 13:45:40 2004
+# Linux kernel version: 2.6.11
+# Fri Mar  4 15:38:53 2005
 #
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_USERMODE=y
 CONFIG_MMU=y
-# CONFIG_64_BIT is not set
-CONFIG_TOP_ADDR=0xc0000000
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
@@ -17,17 +15,22 @@
 #
 CONFIG_MODE_TT=y
 CONFIG_MODE_SKAS=y
+# CONFIG_64_BIT is not set
+CONFIG_TOP_ADDR=0xc0000000
 # CONFIG_3_LEVEL_PGTABLES is not set
+CONFIG_ARCH_HAS_SC_SIGNALS=y
+CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA=y
+CONFIG_LD_SCRIPT_STATIC=y
 CONFIG_NET=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
 CONFIG_HOSTFS=y
 CONFIG_MCONSOLE=y
+# CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_HOST_2G_2G is not set
 # CONFIG_SMP is not set
 CONFIG_NEST_LEVEL=0
 CONFIG_KERNEL_HALF_GIGS=1
-# CONFIG_HIGHMEM is not set
 CONFIG_KERNEL_STACK_ORDER=2
 CONFIG_UML_REAL_TIME_CLOCK=y
 
@@ -75,7 +78,6 @@
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
-# CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
@@ -84,6 +86,7 @@
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -97,7 +100,7 @@
 CONFIG_PTY_CHAN=y
 CONFIG_TTY_CHAN=y
 CONFIG_XTERM_CHAN=y
-CONFIG_NOCONFIG_CHAN=y
+# CONFIG_NOCONFIG_CHAN is not set
 CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
 CONFIG_CON_CHAN="xterm"
 CONFIG_SSL_CHAN="pty"
@@ -110,15 +113,18 @@
 CONFIG_HOSTAUDIO=m
 
 #
-# Block Devices
+# Block devices
 #
 CONFIG_BLK_DEV_UBD=y
 CONFIG_BLK_DEV_UBD_SYNC=y
 CONFIG_BLK_DEV_COW_COMMON=y
 CONFIG_BLK_DEV_LOOP=m
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
 # CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
 
 #
 # IO Schedulers
@@ -127,6 +133,7 @@
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 CONFIG_NETDEVICES=y
 
 #
@@ -196,10 +203,7 @@
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
-# CONFIG_KGDBOE is not set
 # CONFIG_NETPOLL is not set
-# CONFIG_NETPOLL_RX is not set
-# CONFIG_NETPOLL_TRAP is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
@@ -232,6 +236,11 @@
 # CONFIG_NET_RADIO is not set
 
 #
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
 # Wan interfaces
 #
 # CONFIG_WAN is not set
@@ -259,12 +268,15 @@
 # CONFIG_EXT3_FS_XATTR is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
-# CONFIG_REISER4_FS is not set
 CONFIG_REISERFS_FS=y
 # CONFIG_REISERFS_CHECK is not set
 # CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_REISERFS_FS_XATTR is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -277,11 +289,6 @@
 CONFIG_AUTOFS4_FS=m
 
 #
-# Caches
-#
-# CONFIG_FSCACHE is not set
-
-#
 # CD-ROM/DVD Filesystems
 #
 CONFIG_ISO9660_FS=m
@@ -331,7 +338,6 @@
 #
 # CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
-# CONFIG_EXPORTFS is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -400,10 +406,14 @@
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
-# CONFIG_CRC32 is not set
+CONFIG_CRC32=m
 # CONFIG_LIBCRC32C is not set
 
 #
@@ -416,13 +426,13 @@
 # Kernel hacking
 #
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
 CONFIG_FRAME_POINTER=y
 CONFIG_PT_PROXY=y
 # CONFIG_GPROF is not set

