Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266156AbUF3AcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUF3AcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 20:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUF3Aby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 20:31:54 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:30921 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S266161AbUF3Aar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 20:30:47 -0400
Date: Tue, 29 Jun 2004 17:30:32 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PPC44x updates
Message-ID: <20040629173032.F27896@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update PPC44x defconfigs and some fixes.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/configs/ebony_defconfig 1.6 vs edited =====
--- 1.6/arch/ppc/configs/ebony_defconfig	Tue May 18 07:48:09 2004
+++ edited/arch/ppc/configs/ebony_defconfig	Tue Jun 29 15:40:57 2004
@@ -30,6 +30,7 @@
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
 CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_IOSCHED_NOOP=y
@@ -56,6 +57,8 @@
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_E500 is not set
+CONFIG_BOOKE=y
 CONFIG_PTE_64BIT=y
 # CONFIG_MATH_EMULATION is not set
 # CONFIG_CPU_FREQ is not set
@@ -68,7 +71,6 @@
 # CONFIG_OCOTEA is not set
 CONFIG_440GP=y
 CONFIG_440=y
-CONFIG_BOOKE=y
 CONFIG_IBM_OCP=y
 # CONFIG_PM is not set
 CONFIG_NOT_COHERENT_CACHE=y
@@ -106,6 +108,8 @@
 CONFIG_LOWMEM_SIZE=0x30000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_TASK_SIZE=0x80000000
+CONFIG_CONSISTENT_START=0xff100000
+CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_BOOT_LOAD=0x01000000
 
 #
@@ -115,6 +119,7 @@
 #
 # Generic Driver Options
 #
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -141,7 +146,7 @@
 # CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_CARMEL is not set
+# CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_RAM is not set
 CONFIG_LBD=y
 
@@ -247,6 +252,7 @@
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -272,6 +278,12 @@
 # Ethernet (10 or 100Mbit)
 #
 # CONFIG_NET_ETHERNET is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=64
+CONFIG_IBM_EMAC_TXB=8
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
 
 #
 # Ethernet (1000 Mbit)
@@ -310,7 +322,6 @@
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-# CONFIG_RCPCI is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 
@@ -543,6 +554,11 @@
 #
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
 
 #
 # Kernel hacking
===== arch/ppc/configs/ocotea_defconfig 1.4 vs edited =====
--- 1.4/arch/ppc/configs/ocotea_defconfig	Fri May 14 19:00:24 2004
+++ edited/arch/ppc/configs/ocotea_defconfig	Mon Jun 28 13:16:56 2004
@@ -21,18 +21,22 @@
 #
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_HOTPLUG is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
 CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
@@ -54,6 +58,8 @@
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_E500 is not set
+CONFIG_BOOKE=y
 CONFIG_PTE_64BIT=y
 # CONFIG_MATH_EMULATION is not set
 # CONFIG_CPU_FREQ is not set
@@ -66,9 +72,7 @@
 CONFIG_OCOTEA=y
 CONFIG_440GX=y
 CONFIG_440A=y
-CONFIG_BOOKE=y
 CONFIG_IBM_OCP=y
-CONFIG_PPC_OCP=y
 CONFIG_IBM_EMAC4=y
 # CONFIG_PM is not set
 CONFIG_NOT_COHERENT_CACHE=y
@@ -106,6 +110,8 @@
 CONFIG_LOWMEM_SIZE=0x30000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_TASK_SIZE=0x80000000
+CONFIG_CONSISTENT_START=0xff100000
+CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_BOOT_LOAD=0x01000000
 
 #
@@ -115,6 +121,7 @@
 #
 # Generic Driver Options
 #
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -141,7 +148,7 @@
 # CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_CARMEL is not set
+# CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_LBD is not set
 
@@ -163,7 +170,6 @@
 #
 # Fusion MPT device support
 #
-# CONFIG_FUSION is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -212,8 +218,6 @@
 #
 # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
-# CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
 
@@ -232,7 +236,9 @@
 #
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
@@ -248,21 +254,27 @@
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
 CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
 
 #
 # ARCnet devices
 #
 # CONFIG_ARCNET is not set
-# CONFIG_DUMMY is not set
-# CONFIG_BONDING is not set
-# CONFIG_EQUALIZER is not set
-# CONFIG_TUN is not set
 
 #
 # Ethernet (10 or 100Mbit)
@@ -279,6 +291,12 @@
 #
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=128
+CONFIG_IBM_EMAC_TXB=128
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
 # CONFIG_NET_PCI is not set
 
 #
@@ -291,7 +309,6 @@
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
-# CONFIG_SIS190 is not set
 # CONFIG_SK98LIN is not set
 # CONFIG_TIGON3 is not set
 
@@ -299,51 +316,28 @@
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
-CONFIG_IBM_EMAC=y
-# CONFIG_IBM_EMAC_ERRMSG is not set
-CONFIG_IBM_EMAC_RXB=128
-CONFIG_IBM_EMAC_TXB=128
-CONFIG_IBM_EMAC_FGAP=8
-CONFIG_IBM_EMAC_SKBRES=0
-# CONFIG_FDDI is not set
-# CONFIG_HIPPI is not set
-# CONFIG_PPP is not set
-# CONFIG_SLIP is not set
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
+# CONFIG_S2IO is not set
 
 #
 # Token Ring devices
 #
 # CONFIG_TR is not set
-# CONFIG_RCPCI is not set
-# CONFIG_SHAPER is not set
-# CONFIG_NETCONSOLE is not set
-
-#
-# Wan interfaces
-#
-# CONFIG_WAN is not set
 
 #
-# Amateur Radio support
-#
-# CONFIG_HAMRADIO is not set
-
-#
-# IrDA (infrared) support
+# Wireless LAN (non-hamradio)
 #
-# CONFIG_IRDA is not set
+# CONFIG_NET_RADIO is not set
 
 #
-# Bluetooth support
+# Wan interfaces
 #
-# CONFIG_BT is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # ISDN subsystem
@@ -515,6 +509,7 @@
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
 # CONFIG_DEVFS_FS is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 # CONFIG_TMPFS is not set
@@ -555,7 +550,6 @@
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
-# CONFIG_INTERMEZZO_FS is not set
 # CONFIG_AFS_FS is not set
 
 #
@@ -573,6 +567,12 @@
 # Library routines
 #
 CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
 
 #
 # Kernel hacking
@@ -587,7 +587,7 @@
 CONFIG_BDI_SWITCH=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_SERIAL_TEXT_DEBUG is not set
-CONFIG_OCP=y
+CONFIG_PPC_OCP=y
 
 #
 # Security options
===== arch/ppc/kernel/head_44x.S 1.9 vs edited =====
--- 1.9/arch/ppc/kernel/head_44x.S	Sat May 29 00:26:35 2004
+++ edited/arch/ppc/kernel/head_44x.S	Tue Jun 29 15:38:10 2004
@@ -177,11 +177,11 @@
 	rfi
 
 	/* If necessary, invalidate original entry we used */
-3:	cmpwi	r23,62
+3:	cmpwi	r23,63
 	beq	4f
 	li	r6,0
 	tlbwe   r6,r23,PPC44x_TLB_PAGEID
-	sync
+	isync
 
 4:
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
===== arch/ppc/syslib/ibm440gp_common.c 1.4 vs edited =====
--- 1.4/arch/ppc/syslib/ibm440gp_common.c	Fri May 14 19:00:24 2004
+++ edited/arch/ppc/syslib/ibm440gp_common.c	Tue Jun 29 16:48:45 2004
@@ -30,7 +30,8 @@
 {
 	u32 cpc0_sys0 = mfdcr(DCRN_CPC0_SYS0);
 	u32 cpc0_cr0 = mfdcr(DCRN_CPC0_CR0);
-	u32 opdv, epdv;
+	u32 opdv = ((cpc0_sys0 >> 10) & 0x3) + 1;
+	u32 epdv = ((cpc0_sys0 >> 8) & 0x3) + 1;
 
 	if (cpc0_sys0 & 0x2){
 		/* Bypass system PLL */
@@ -59,9 +60,6 @@
 		p->cpu = vco / fwdva;
 		p->plb = vco / fwdvb;
 	}
-
-	opdv = ((cpc0_sys0 >> 10) & 0x3) + 1;
-	epdv = ((cpc0_sys0 >> 8) & 0x3) + 1;
 
 	p->opb = p->plb / opdv;
 	p->ebc = p->opb / epdv;
