Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWDCRVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWDCRVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWDCRVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:21:17 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:39118 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932350AbWDCRVR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:21:17 -0400
Date: Mon, 3 Apr 2006 19:21:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/9] s390: Update default configuration.
Message-ID: <20060403172115.GA11049@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 1/9] s390: Update default configuration.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/defconfig |   48 ++++++++++++++++++++++++++++--------------------
 1 files changed, 28 insertions(+), 20 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2006-04-03 18:46:34.000000000 +0200
@@ -1,10 +1,11 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16-rc2
-# Wed Feb  8 10:44:39 2006
+# Linux kernel version: 2.6.17-rc1
+# Mon Apr  3 14:34:15 2006
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_S390=y
 
@@ -30,8 +31,8 @@ CONFIG_AUDIT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
-CONFIG_UID16=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
@@ -45,10 +46,6 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -60,7 +57,6 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 CONFIG_MODVERSIONS=y
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
@@ -69,7 +65,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
-# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
 # IO Schedulers
@@ -91,17 +87,20 @@ CONFIG_DEFAULT_IOSCHED="deadline"
 #
 # Processor type and features
 #
-# CONFIG_64BIT is not set
+CONFIG_64BIT=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
 CONFIG_HOTPLUG_CPU=y
-CONFIG_MATHEMU=y
+CONFIG_DEFAULT_MIGRATION_COST=1000000
+CONFIG_COMPAT=y
+CONFIG_SYSVIPC_COMPAT=y
+CONFIG_BINFMT_ELF32=y
 
 #
 # Code generation options
 #
-CONFIG_MARCH_G5=y
-# CONFIG_MARCH_Z900 is not set
+# CONFIG_MARCH_G5 is not set
+CONFIG_MARCH_Z900=y
 # CONFIG_MARCH_Z990 is not set
 CONFIG_PACK_STACK=y
 # CONFIG_SMALL_STACK is not set
@@ -143,7 +142,7 @@ CONFIG_VIRT_CPU_ACCOUNTING=y
 # CONFIG_APPLDATA_BASE is not set
 CONFIG_NO_IDLE_HZ=y
 CONFIG_NO_IDLE_HZ_INIT=y
-# CONFIG_KEXEC is not set
+CONFIG_KEXEC=y
 
 #
 # Networking
@@ -173,6 +172,7 @@ CONFIG_IP_FIB_HASH=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
@@ -180,9 +180,11 @@ CONFIG_INET_TCP_DIAG=y
 CONFIG_TCP_CONG_BIC=y
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
+# CONFIG_IPV6_ROUTER_PREF is not set
 # CONFIG_INET6_AH is not set
 # CONFIG_INET6_ESP is not set
 # CONFIG_INET6_IPCOMP is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_NETFILTER is not set
@@ -276,6 +278,11 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 
 #
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
@@ -340,8 +347,7 @@ CONFIG_DASD_PROFILE=y
 CONFIG_DASD_ECKD=y
 CONFIG_DASD_FBA=y
 CONFIG_DASD_DIAG=y
-CONFIG_DASD_EER=m
-# CONFIG_DASD_CMB is not set
+CONFIG_DASD_EER=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
@@ -354,6 +360,7 @@ CONFIG_MD_RAID0=m
 CONFIG_MD_RAID1=m
 # CONFIG_MD_RAID10 is not set
 CONFIG_MD_RAID5=m
+# CONFIG_MD_RAID5_RESHAPE is not set
 # CONFIG_MD_RAID6 is not set
 CONFIG_MD_MULTIPATH=m
 # CONFIG_MD_FAULTY is not set
@@ -404,6 +411,7 @@ CONFIG_S390_TAPE_BLOCK=y
 # S/390 tape hardware support
 #
 CONFIG_S390_TAPE_34XX=m
+# CONFIG_S390_TAPE_3590 is not set
 # CONFIG_VMLOGRDR is not set
 # CONFIG_VMCP is not set
 # CONFIG_MONREADER is not set
@@ -529,7 +537,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -619,14 +626,15 @@ CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
-# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_DEBUG_PREEMPT=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_SPINLOCK is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
 
