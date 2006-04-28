Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751833AbWD1RB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWD1RB0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWD1RBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:01:00 -0400
Received: from [198.99.130.12] ([198.99.130.12]:32728 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751425AbWD1RAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:00:30 -0400
Message-Id: <200604281601.k3SG1959007537@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/6] UML - update defconfig
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Apr 2006 12:01:09 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bring defconfig up to date.
Also disable CONFIG_BLK_DEV_UBD_SYNC by default.  By performing
synchronous I/O to the host, it slows things down, only protects
against host crashes, and can make a UML appear to hang while it
waits for the host's disk.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/defconfig
===================================================================
--- linux-2.6.16.orig/arch/um/defconfig	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.16/arch/um/defconfig	2006-04-28 09:31:35.000000000 -0400
@@ -1,14 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc6-mm1
-# Tue Jun 14 18:22:21 2005
+# Linux kernel version: 2.6.17-rc3
+# Fri Apr 28 09:31:20 2006
 #
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_UML=y
 CONFIG_MMU=y
-CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_IRQ_RELEASE_METHOD=y
 
 #
 # UML-specific options
@@ -16,8 +15,50 @@ CONFIG_GENERIC_CALIBRATE_DELAY=y
 # CONFIG_MODE_TT is not set
 # CONFIG_STATIC_LINK is not set
 CONFIG_MODE_SKAS=y
+
+#
+# Host processor type and features
+#
+# CONFIG_M386 is not set
+# CONFIG_M486 is not set
+# CONFIG_M586 is not set
+# CONFIG_M586TSC is not set
+# CONFIG_M586MMX is not set
+CONFIG_M686=y
+# CONFIG_MPENTIUMII is not set
+# CONFIG_MPENTIUMIII is not set
+# CONFIG_MPENTIUMM is not set
+# CONFIG_MPENTIUM4 is not set
+# CONFIG_MK6 is not set
+# CONFIG_MK7 is not set
+# CONFIG_MK8 is not set
+# CONFIG_MCRUSOE is not set
+# CONFIG_MEFFICEON is not set
+# CONFIG_MWINCHIPC6 is not set
+# CONFIG_MWINCHIP2 is not set
+# CONFIG_MWINCHIP3D is not set
+# CONFIG_MGEODEGX1 is not set
+# CONFIG_MGEODE_LX is not set
+# CONFIG_MCYRIXIII is not set
+# CONFIG_MVIAC3_2 is not set
+# CONFIG_X86_GENERIC is not set
+CONFIG_X86_CMPXCHG=y
+CONFIG_X86_XADD=y
+CONFIG_X86_L1_CACHE_SHIFT=5
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_X86_PPRO_FENCE=y
+CONFIG_X86_WP_WORKS_OK=y
+CONFIG_X86_INVLPG=y
+CONFIG_X86_BSWAP=y
+CONFIG_X86_POPAD_OK=y
+CONFIG_X86_CMPXCHG64=y
+CONFIG_X86_GOOD_APIC=y
+CONFIG_X86_USE_PPRO_CHECKSUM=y
+CONFIG_X86_TSC=y
 CONFIG_UML_X86=y
 # CONFIG_64BIT is not set
+CONFIG_SEMAPHORE_SLEEPERS=y
+# CONFIG_HOST_2G_2G is not set
 CONFIG_TOP_ADDR=0xc0000000
 # CONFIG_3_LEVEL_PGTABLES is not set
 CONFIG_STUB_CODE=0xbfffe000
@@ -25,22 +66,24 @@ CONFIG_STUB_DATA=0xbffff000
 CONFIG_STUB_START=0xbfffe000
 CONFIG_ARCH_HAS_SC_SIGNALS=y
 CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_LD_SCRIPT_DYN=y
 CONFIG_NET=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
 # CONFIG_HOSTFS is not set
+# CONFIG_HPPFS is not set
 CONFIG_MCONSOLE=y
 # CONFIG_MAGIC_SYSRQ is not set
-# CONFIG_HOST_2G_2G is not set
 CONFIG_NEST_LEVEL=0
-CONFIG_KERNEL_HALF_GIGS=1
 # CONFIG_HIGHMEM is not set
 CONFIG_KERNEL_STACK_ORDER=2
 CONFIG_UML_REAL_TIME_CLOCK=y
@@ -49,7 +92,6 @@ CONFIG_UML_REAL_TIME_CLOCK=y
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
@@ -57,6 +99,7 @@ CONFIG_INIT_ENV_ARG_LIMIT=32
 # General setup
 #
 CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -64,26 +107,28 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-# CONFIG_HOTPLUG is not set
-CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_UID16=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
+CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -91,18 +136,43 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
 #
-# Generic Driver Options
+# Block layer
 #
-CONFIG_STANDALONE=y
-CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
-# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
+# Block devices
+#
+CONFIG_BLK_DEV_UBD=y
+# CONFIG_BLK_DEV_UBD_SYNC is not set
+CONFIG_BLK_DEV_COW_COMMON=y
+# CONFIG_MMAPPER is not set
+CONFIG_BLK_DEV_LOOP=m
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+CONFIG_BLK_DEV_NBD=m
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # Character Devices
@@ -127,50 +197,23 @@ CONFIG_UML_SOUND=m
 CONFIG_SOUND=m
 CONFIG_HOSTAUDIO=m
 CONFIG_UML_RANDOM=y
-# CONFIG_MMAPPER is not set
-
-#
-# Block devices
-#
-CONFIG_BLK_DEV_UBD=y
-CONFIG_BLK_DEV_UBD_SYNC=y
-CONFIG_BLK_DEV_COW_COMMON=y
-CONFIG_BLK_DEV_LOOP=m
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-CONFIG_BLK_DEV_NBD=m
-# CONFIG_BLK_DEV_RAM is not set
-CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_INITRAMFS_SOURCE=""
-# CONFIG_LBD is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-# CONFIG_ATA_OVER_ETH is not set
-CONFIG_NETDEVICES=y
 
 #
-# UML Network Devices
+# Generic Driver Options
 #
-CONFIG_UML_NET=y
-CONFIG_UML_NET_ETHERTAP=y
-CONFIG_UML_NET_TUNTAP=y
-CONFIG_UML_NET_SLIP=y
-CONFIG_UML_NET_DAEMON=y
-CONFIG_UML_NET_MCAST=y
-CONFIG_UML_NET_SLIRP=y
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
 
 #
-# Networking support
+# Networking
 #
 
 #
 # Networking options
 #
+# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
@@ -178,6 +221,7 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
 # CONFIG_IP_PNP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
@@ -186,27 +230,31 @@ CONFIG_INET=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_IP_TCPDIAG=y
-# CONFIG_IP_TCPDIAG_IPV6 is not set
-
-#
-# TCP congestion control
-#
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_BIC=y
-CONFIG_TCP_CONG_WESTWOOD=y
-CONFIG_TCP_CONG_HTCP=y
-# CONFIG_TCP_CONG_HSTCP is not set
-# CONFIG_TCP_CONG_HYBLA is not set
-# CONFIG_TCP_CONG_VEGAS is not set
-# CONFIG_TCP_CONG_SCALABLE is not set
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETFILTER is not set
 
 #
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
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
@@ -224,27 +272,47 @@ CONFIG_TCP_CONG_HTCP=y
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
-# CONFIG_KGDBOE is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NETPOLL_RX is not set
-# CONFIG_NETPOLL_TRAP is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_IEEE80211 is not set
+
+#
+# UML Network Devices
+#
+CONFIG_UML_NET=y
+CONFIG_UML_NET_ETHERTAP=y
+CONFIG_UML_NET_TUNTAP=y
+CONFIG_UML_NET_SLIP=y
+CONFIG_UML_NET_DAEMON=y
+CONFIG_UML_NET_MCAST=y
+# CONFIG_UML_NET_PCAP is not set
+CONFIG_UML_NET_SLIRP=y
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 CONFIG_TUN=m
 
 #
+# PHY device support
+#
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
 # Wan interfaces
 #
 # CONFIG_WAN is not set
@@ -263,6 +331,13 @@ CONFIG_SLIP=m
 # CONFIG_SLIP_MODE_SLIP6 is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
 
 #
 # File systems
@@ -274,17 +349,14 @@ CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
-# CONFIG_REISER4_FS is not set
 CONFIG_REISERFS_FS=y
 # CONFIG_REISERFS_CHECK is not set
 # CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_REISERFS_FS_XATTR is not set
 # CONFIG_JFS_FS is not set
-
-#
-# XFS support
-#
+# CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
@@ -295,11 +367,6 @@ CONFIG_QUOTACTL=y
 CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
-
-#
-# Caches
-#
-# CONFIG_FSCACHE is not set
 # CONFIG_FUSE_FS is not set
 
 #
@@ -323,14 +390,10 @@ CONFIG_JOLIET=y
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_DEVFS_FS is not set
-# CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
-# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
-# CONFIG_RELAYFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -430,6 +493,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
 CONFIG_CRC32=m
 # CONFIG_LIBCRC32C is not set
 
@@ -448,12 +512,18 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 CONFIG_DEBUG_SLAB=y
+# CONFIG_DEBUG_SLAB_LEAK is not set
+# CONFIG_DEBUG_MUTEXES is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
 CONFIG_FRAME_POINTER=y
+# CONFIG_UNWIND_INFO is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_GPROF is not set
 # CONFIG_GCOV is not set
 # CONFIG_SYSCALL_DEBUG is not set

