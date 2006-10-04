Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030726AbWJDR5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030726AbWJDR5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030733AbWJDR5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:57:47 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:43085 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030726AbWJDR5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:57:30 -0400
Date: Wed, 4 Oct 2006 19:57:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] update default configuration
Message-ID: <20061004175732.GA26756@skybase>
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

 arch/s390/defconfig |   56 ++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 44 insertions(+), 12 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2006-10-04 19:53:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2006-10-04 19:53:43.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc2
-# Thu Jul 27 13:51:07 2006
+# Linux kernel version: 2.6.18
+# Wed Oct  4 19:45:46 2006
 #
 CONFIG_MMU=y
 CONFIG_LOCKDEP_SUPPORT=y
@@ -26,10 +26,11 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 CONFIG_AUDIT=y
 # CONFIG_AUDITSYSCALL is not set
 CONFIG_IKCONFIG=y
@@ -38,7 +39,9 @@ CONFIG_IKCONFIG_PROC=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -47,12 +50,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -71,6 +74,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
@@ -100,6 +104,7 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_DEFAULT_MIGRATION_COST=1000000
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
+CONFIG_AUDIT_ARCH=y
 
 #
 # Code generation options
@@ -107,6 +112,7 @@ CONFIG_SYSVIPC_COMPAT=y
 # CONFIG_MARCH_G5 is not set
 CONFIG_MARCH_Z900=y
 # CONFIG_MARCH_Z990 is not set
+# CONFIG_MARCH_Z9_109 is not set
 CONFIG_PACK_STACK=y
 # CONFIG_SMALL_STACK is not set
 CONFIG_CHECK_STACK=y
@@ -165,6 +171,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
 CONFIG_NET_KEY=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -183,21 +190,28 @@ CONFIG_IP_FIB_HASH=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_IPV6_ROUTER_PREF is not set
 # CONFIG_INET6_AH is not set
 # CONFIG_INET6_ESP is not set
 # CONFIG_INET6_IPCOMP is not set
+# CONFIG_IPV6_MIP6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
 CONFIG_INET6_XFRM_MODE_TRANSPORT=y
 CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
 # CONFIG_IPV6_TUNNEL is not set
+# CONFIG_IPV6_SUBTREES is not set
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 
@@ -224,7 +238,6 @@ CONFIG_INET6_XFRM_MODE_TUNNEL=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -301,6 +314,7 @@ CONFIG_SYS_HYPERVISOR=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_NETLINK=y
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -322,18 +336,18 @@ CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 CONFIG_SCSI_FC_ATTRS=y
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
 CONFIG_CCW=y
@@ -378,6 +392,7 @@ CONFIG_MD_RAID1=m
 CONFIG_MD_MULTIPATH=m
 # CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=y
+# CONFIG_DM_DEBUG is not set
 CONFIG_DM_CRYPT=y
 CONFIG_DM_SNAPSHOT=y
 CONFIG_DM_MIRROR=y
@@ -487,14 +502,12 @@ CONFIG_IUCV=m
 # CONFIG_NETIUCV is not set
 # CONFIG_SMSGIUCV is not set
 # CONFIG_CLAW is not set
-# CONFIG_MPC is not set
 CONFIG_QETH=y
 
 #
 # Gigabit Ethernet default settings
 #
 # CONFIG_QETH_IPV6 is not set
-# CONFIG_QETH_PERF_STATS is not set
 CONFIG_CCWGROUP=y
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -518,8 +531,9 @@ CONFIG_JBD=y
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -549,8 +563,10 @@ CONFIG_DNOTIFY=y
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -598,6 +614,7 @@ CONFIG_SUNRPC=y
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
 # CONFIG_9P_FS is not set
+CONFIG_GENERIC_ACL=y
 
 #
 # Partition Types
@@ -627,10 +644,17 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+
+#
 # Instrumentation Support
 #
+
+#
+# Profiling support
+#
 # CONFIG_PROFILING is not set
-CONFIG_STATISTICS=y
 CONFIG_KPROBES=y
 
 #
@@ -638,6 +662,7 @@ CONFIG_KPROBES=y
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -659,10 +684,12 @@ CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 # CONFIG_FRAME_POINTER is not set
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_LKDTM is not set
 
 #
 # Security options
@@ -674,6 +701,9 @@ CONFIG_FORCED_INLINING=y
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=m
+CONFIG_CRYPTO_BLKCIPHER=m
+CONFIG_CRYPTO_MANAGER=m
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
@@ -685,6 +715,8 @@ CONFIG_CRYPTO=y
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=m
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_DES_S390 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
