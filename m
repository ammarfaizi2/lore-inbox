Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbUKNUyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbUKNUyK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 15:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbUKNUw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 15:52:29 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:14852
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261373AbUKNUvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 15:51:18 -0500
Message-Id: <200411142304.iAEN4fbV013376@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - UML - defconfig update
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Nov 2004 18:04:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update defconfig for 2.6.10-rc1-mm5.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/defconfig
===================================================================
--- 2.6.9.orig/arch/um/defconfig	2004-11-14 15:31:23.000000000 -0500
+++ 2.6.9/arch/um/defconfig	2004-11-14 15:31:38.000000000 -0500
@@ -1,12 +1,14 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.9-bk4
-# Thu Oct 21 01:09:54 2004
+# Linux kernel version: 2.6.10-rc1-mm5
+# Sun Nov 14 15:27:58 2004
 #
+CONFIG_GENERIC_HARDIRQS=y
 CONFIG_USERMODE=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # UML-specific options
@@ -54,12 +56,12 @@
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -70,6 +72,7 @@
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
 #
@@ -113,6 +116,15 @@
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 CONFIG_NETDEVICES=y
 
 #
@@ -150,6 +162,8 @@
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -169,7 +183,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -181,7 +194,10 @@
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+# CONFIG_KGDBOE is not set
 # CONFIG_NETPOLL is not set
+# CONFIG_NETPOLL_RX is not set
+# CONFIG_NETPOLL_TRAP is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
@@ -241,6 +257,7 @@
 # CONFIG_EXT3_FS_XATTR is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
+# CONFIG_REISER4_FS is not set
 CONFIG_REISERFS_FS=y
 # CONFIG_REISERFS_CHECK is not set
 # CONFIG_REISERFS_PROC_INFO is not set
@@ -253,10 +270,16 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
 #
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
 # CD-ROM/DVD Filesystems
 #
 CONFIG_ISO9660_FS=m
@@ -391,8 +414,12 @@
 # Kernel hacking
 #
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_POINTER=y
 CONFIG_PT_PROXY=y

