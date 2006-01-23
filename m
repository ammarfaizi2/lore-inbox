Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWAWL7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWAWL7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 06:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAWL7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 06:59:45 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:16334 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751292AbWAWL7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 06:59:44 -0500
Date: Mon, 23 Jan 2006 12:58:18 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] s390: New default configuration.
Message-ID: <20060123115818.GC9241@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

New default configuration.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/defconfig |   40 +++++++++++++++++++++++++++-------------
 1 files changed, 27 insertions(+), 13 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2006-01-23 10:04:56.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2006-01-23 10:05:20.000000000 +0100
@@ -1,13 +1,12 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.15-rc2
-# Mon Nov 21 13:51:30 2005
+# Linux kernel version: 2.6.16-rc1
+# Thu Jan 19 10:58:53 2006
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_S390=y
-CONFIG_UID16=y
 
 #
 # Code maturity level options
@@ -29,18 +28,20 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 # CONFIG_AUDITSYSCALL is not set
-CONFIG_HOTPLUG=y
-CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_UID16=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
+CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -49,8 +50,10 @@ CONFIG_CC_ALIGN_FUNCTIONS=0
 CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -76,11 +79,11 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
-# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_AS is not set
+CONFIG_DEFAULT_DEADLINE=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_IOSCHED="deadline"
 
 #
 # Base setup
@@ -193,6 +196,11 @@ CONFIG_IPV6=y
 # SCTP Configuration (EXPERIMENTAL)
 #
 # CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
@@ -362,6 +370,7 @@ CONFIG_DM_MULTIPATH=y
 #
 CONFIG_UNIX98_PTYS=y
 CONFIG_UNIX98_PTY_COUNT=2048
+# CONFIG_HANGCHECK_TIMER is not set
 
 #
 # Watchdog Cards
@@ -488,6 +497,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
@@ -520,6 +530,7 @@ CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_RELAYFS_FS is not set
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -584,6 +595,7 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 
 #
@@ -592,7 +604,7 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 
 #
-# Profiling support
+# Instrumentation Support
 #
 # CONFIG_PROFILING is not set
 
@@ -600,19 +612,21 @@ CONFIG_MSDOS_PARTITION=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
-CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=17
-CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
-CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
-CONFIG_DEBUG_FS=y
+# CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
 
 #
