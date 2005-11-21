Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVKURt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVKURt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVKURt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:49:58 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:8348 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932437AbVKURti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:49:38 -0500
Date: Mon, 21 Nov 2005 18:48:57 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 5/5] s390: update default configuration.
Message-ID: <20051121174857.GE9638@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 5/5] s390: update default configuration.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/defconfig |   55 ++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 39 insertions(+), 16 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2005-11-21 18:40:08.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.14-rc1
-# Wed Sep 14 16:46:19 2005
+# Linux kernel version: 2.6.15-rc2
+# Mon Nov 21 13:51:30 2005
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -65,6 +65,24 @@ CONFIG_KMOD=y
 CONFIG_STOP_MACHINE=y
 
 #
+# Block layer
+#
+# CONFIG_LBD is not set
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
 # Base setup
 #
 
@@ -97,6 +115,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
 
 #
 # I/O subsystem configuration
@@ -188,10 +207,18 @@ CONFIG_IPV6=y
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CLK_JIFFIES=y
 # CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
 # CONFIG_NET_SCH_CLK_CPU is not set
+
+#
+# Queueing/Scheduling
+#
 CONFIG_NET_SCH_CBQ=m
 # CONFIG_NET_SCH_HTB is not set
 # CONFIG_NET_SCH_HFSC is not set
@@ -204,8 +231,10 @@ CONFIG_NET_SCH_GRED=m
 CONFIG_NET_SCH_DSMARK=m
 # CONFIG_NET_SCH_NETEM is not set
 # CONFIG_NET_SCH_INGRESS is not set
-CONFIG_NET_QOS=y
-CONFIG_NET_ESTIMATOR=y
+
+#
+# Classification
+#
 CONFIG_NET_CLS=y
 # CONFIG_NET_CLS_BASIC is not set
 CONFIG_NET_CLS_TCINDEX=m
@@ -214,18 +243,18 @@ CONFIG_NET_CLS_ROUTE=y
 CONFIG_NET_CLS_FW=m
 CONFIG_NET_CLS_U32=m
 # CONFIG_CLS_U32_PERF is not set
-# CONFIG_NET_CLS_IND is not set
 CONFIG_NET_CLS_RSVP=m
 CONFIG_NET_CLS_RSVP6=m
 # CONFIG_NET_EMATCH is not set
 # CONFIG_NET_CLS_ACT is not set
 CONFIG_NET_CLS_POLICE=y
+# CONFIG_NET_CLS_IND is not set
+CONFIG_NET_ESTIMATOR=y
 
 #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
-# CONFIG_NETFILTER_NETLINK is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
@@ -276,6 +305,7 @@ CONFIG_SCSI_FC_ATTRS=y
 #
 # SCSI low-level drivers
 #
+# CONFIG_ISCSI_TCP is not set
 # CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
@@ -292,7 +322,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_LBD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 
 #
@@ -305,15 +334,8 @@ CONFIG_DASD_PROFILE=y
 CONFIG_DASD_ECKD=y
 CONFIG_DASD_FBA=y
 CONFIG_DASD_DIAG=y
+CONFIG_DASD_EER=m
 # CONFIG_DASD_CMB is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
@@ -378,7 +400,6 @@ CONFIG_S390_TAPE_34XX=m
 # CONFIG_VMLOGRDR is not set
 # CONFIG_VMCP is not set
 # CONFIG_MONREADER is not set
-# CONFIG_DCSS_SHM is not set
 
 #
 # Cryptographic devices
@@ -593,6 +614,8 @@ CONFIG_DEBUG_PREEMPT=y
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_RCU_TORTURE_TEST is not set
 
 #
 # Security options
