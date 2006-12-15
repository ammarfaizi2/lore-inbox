Return-Path: <linux-kernel-owner+w=401wt.eu-S1752816AbWLOQUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbWLOQUx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbWLOQUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:20:53 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:65224 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbWLOQUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:20:52 -0500
Date: Fri, 15 Dec 2006 17:20:09 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] update default configuration
Message-ID: <20061215162009.GA4920@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] update default configuration

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/defconfig |   47 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 34 insertions(+), 13 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2006-12-15 16:54:49.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2006-12-15 16:55:05.000000000 +0100
@@ -1,14 +1,15 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.19-rc2
-# Wed Oct 18 17:11:10 2006
+# Linux kernel version: 2.6.20-rc1
+# Fri Dec 15 16:52:28 2006
 #
 CONFIG_MMU=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
-CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_TIME=y
 CONFIG_S390=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
@@ -37,12 +38,13 @@ CONFIG_AUDIT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
-# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -119,6 +121,7 @@ CONFIG_PACK_STACK=y
 CONFIG_CHECK_STACK=y
 CONFIG_STACK_GUARD=256
 # CONFIG_WARN_STACK is not set
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -128,6 +131,7 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
+CONFIG_HOLES_IN_ZONE=y
 
 #
 # I/O subsystem configuration
@@ -196,6 +200,7 @@ CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_IPV6_ROUTER_PREF is not set
@@ -211,7 +216,6 @@ CONFIG_INET6_XFRM_MODE_BEET=y
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
 CONFIG_IPV6_SIT=y
 # CONFIG_IPV6_TUNNEL is not set
-# CONFIG_IPV6_SUBTREES is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
@@ -246,6 +250,7 @@ CONFIG_IPV6_SIT=y
 # QoS and/or fair queueing
 #
 CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_FIFO=y
 CONFIG_NET_SCH_CLK_JIFFIES=y
 # CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
 # CONFIG_NET_SCH_CLK_CPU is not set
@@ -277,6 +282,7 @@ CONFIG_NET_CLS_ROUTE=y
 CONFIG_NET_CLS_FW=m
 CONFIG_NET_CLS_U32=m
 # CONFIG_CLS_U32_PERF is not set
+CONFIG_CLS_U32_MARK=y
 CONFIG_NET_CLS_RSVP=m
 CONFIG_NET_CLS_RSVP6=m
 # CONFIG_NET_EMATCH is not set
@@ -315,6 +321,7 @@ CONFIG_SYS_HYPERVISOR=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
 CONFIG_SCSI_NETLINK=y
 CONFIG_SCSI_PROC_FS=y
 
@@ -335,6 +342,7 @@ CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
+CONFIG_SCSI_SCAN_ASYNC=y
 
 #
 # SCSI Transports
@@ -546,6 +554,7 @@ CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
+CONFIG_GENERIC_ACL=y
 
 #
 # CD-ROM/DVD Filesystems
@@ -571,7 +580,7 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_CONFIGFS_FS is not set
+CONFIG_CONFIGFS_FS=m
 
 #
 # Miscellaneous filesystems
@@ -616,7 +625,6 @@ CONFIG_SUNRPC=y
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
 # CONFIG_9P_FS is not set
-CONFIG_GENERIC_ACL=y
 
 #
 # Partition Types
@@ -646,6 +654,14 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+CONFIG_DLM=m
+CONFIG_DLM_TCP=y
+# CONFIG_DLM_SCTP is not set
+# CONFIG_DLM_DEBUG is not set
+
+#
 # Instrumentation Support
 #
 
@@ -663,6 +679,8 @@ CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+CONFIG_HEADERS_CHECK=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_SCHEDSTATS is not set
@@ -679,13 +697,11 @@ CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
-CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_FRAME_POINTER is not set
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
-CONFIG_HEADERS_CHECK=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_LKDTM is not set
 
@@ -699,10 +715,11 @@ CONFIG_HEADERS_CHECK=y
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=m
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_MANAGER=m
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
@@ -713,8 +730,10 @@ CONFIG_CRYPTO_MANAGER=m
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=m
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_LRW is not set
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_DES_S390 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
@@ -740,8 +759,10 @@ CONFIG_CRYPTO_CBC=m
 #
 # Library routines
 #
+CONFIG_BITREVERSE=m
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=m
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
+CONFIG_IOMAP_COPY=y
