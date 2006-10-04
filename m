Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161576AbWJDQd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161576AbWJDQd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161571AbWJDQc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:32:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:60382 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161566AbWJDQbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:31:34 -0400
Message-Id: <20061004161510.712722000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:22 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 12/14] powerpc: update cell_defconfig
Content-Disposition: inline; filename=cell-defconfig-2.6.19.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds defaults for new configuration options added since
2.6.18 and it enables the option for 64kb pages by default.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/arch/powerpc/configs/cell_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/cell_defconfig
+++ linux-2.6/arch/powerpc/configs/cell_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:20:32 2006
+# Linux kernel version: 2.6.18
+# Wed Oct  4 15:30:50 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -22,6 +22,7 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
 # CONFIG_DEFAULT_UIMAGE is not set
 
 #
@@ -52,10 +53,11 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
@@ -63,7 +65,9 @@ CONFIG_CPUSETS=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -72,12 +76,12 @@ CONFIG_PRINTK=y
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
@@ -96,6 +100,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
@@ -115,12 +120,13 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
-# CONFIG_PPC_ISERIES is not set
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
 # CONFIG_PPC_PSERIES is not set
+# CONFIG_PPC_ISERIES is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
+# CONFIG_PPC_PASEMI is not set
 CONFIG_PPC_CELL=y
 CONFIG_PPC_CELL_NATIVE=y
 CONFIG_PPC_IBM_CELL_BLADE=y
@@ -142,7 +148,6 @@ CONFIG_MMIO_NVRAM=y
 #
 CONFIG_SPU_FS=m
 CONFIG_SPU_BASE=y
-CONFIG_SPUFS_MMAP=y
 CONFIG_CBE_RAS=y
 
 #
@@ -158,7 +163,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_BKL=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
-CONFIG_FORCE_MAX_ZONEORDER=13
+CONFIG_FORCE_MAX_ZONEORDER=9
 # CONFIG_IOMMU_VMERGE is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_KEXEC=y
@@ -168,6 +173,7 @@ CONFIG_NUMA=y
 CONFIG_NODES_SHIFT=4
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 # CONFIG_FLATMEM_MANUAL is not set
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -178,12 +184,12 @@ CONFIG_HAVE_MEMORY_PRESENT=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPARSEMEM_EXTREME=y
 CONFIG_MEMORY_HOTPLUG=y
+CONFIG_MEMORY_HOTPLUG_SPARSE=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_MIGRATION=y
 CONFIG_RESOURCES_64BIT=y
-CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
 CONFIG_ARCH_MEMORY_PROBE=y
-# CONFIG_PPC_64K_PAGES is not set
+CONFIG_PPC_64K_PAGES=y
 CONFIG_SCHED_SMT=y
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
@@ -201,6 +207,7 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCIEPORTBUS=y
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -228,6 +235,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -249,7 +257,8 @@ CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
 
 #
 # IP: Virtual Server Configuration
@@ -261,11 +270,15 @@ CONFIG_IPV6=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
+# CONFIG_IPV6_MIP6 is not set
 CONFIG_INET6_XFRM_TUNNEL=m
 CONFIG_INET6_TUNNEL=m
 CONFIG_INET6_XFRM_MODE_TRANSPORT=y
 CONFIG_INET6_XFRM_MODE_TUNNEL=y
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
 CONFIG_IPV6_TUNNEL=m
+# CONFIG_IPV6_SUBTREES is not set
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
 # CONFIG_NETWORK_SECMARK is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
@@ -322,7 +335,6 @@ CONFIG_IP_NF_QUEUE=m
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -434,6 +446,7 @@ CONFIG_BLK_DEV_AEC62XX=y
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_IT821X is not set
@@ -456,6 +469,12 @@ CONFIG_IDEDMA_AUTO=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -470,6 +489,7 @@ CONFIG_MD_RAID1=m
 # CONFIG_MD_MULTIPATH is not set
 # CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
+# CONFIG_DM_DEBUG is not set
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
@@ -504,7 +524,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 CONFIG_BONDING=y
 # CONFIG_EQUALIZER is not set
-# CONFIG_TUN is not set
+CONFIG_TUN=y
 
 #
 # ARCnet devices
@@ -552,7 +572,7 @@ CONFIG_SKGE=m
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
 CONFIG_SPIDER_NET=m
-# CONFIG_MV643XX_ETH is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -599,6 +619,7 @@ CONFIG_SPIDER_NET=m
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -865,6 +886,7 @@ CONFIG_INFINIBAND_USER_ACCESS=m
 CONFIG_INFINIBAND_ADDR_TRANS=y
 CONFIG_INFINIBAND_MTHCA=m
 CONFIG_INFINIBAND_MTHCA_DEBUG=y
+# CONFIG_INFINIBAND_AMSO1100 is not set
 CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_DEBUG=y
 CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
@@ -916,7 +938,7 @@ CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
-# CONFIG_AUTOFS4_FS is not set
+CONFIG_AUTOFS4_FS=m
 # CONFIG_FUSE_FS is not set
 
 #
@@ -943,8 +965,10 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 CONFIG_HUGETLBFS=y
 CONFIG_HUGETLB_PAGE=y
 CONFIG_RAMFS=y
@@ -1084,6 +1108,7 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -1102,6 +1127,7 @@ CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 # CONFIG_FORCED_INLINING is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
@@ -1123,6 +1149,10 @@ CONFIG_IRQSTACKS=y
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=m
+CONFIG_CRYPTO_HASH=y
+# CONFIG_CRYPTO_MANAGER is not set
 CONFIG_CRYPTO_HMAC=y
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
@@ -1132,6 +1162,8 @@ CONFIG_CRYPTO_SHA1=m
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_DES=m
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set

--

