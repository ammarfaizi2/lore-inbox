Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWDXVZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWDXVZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWDXVXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:54 -0400
Received: from mx.pathscale.com ([64.160.42.68]:36803 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751296AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 13 of 13] ipath - tidy up white space in a few files
X-Mercurial-Node: 895650567032e5b481535a9512033fb24a222441
Message-Id: <895650567032e5b48153.1145913789@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:23:09 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r e3f1bfd7ce46 -r 895650567032 drivers/infiniband/hw/ipath/ipath_debug.h
--- a/drivers/infiniband/hw/ipath/ipath_debug.h	Mon Apr 24 14:21:04 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_debug.h	Mon Apr 24 14:21:04 2006 -0700
@@ -60,11 +60,11 @@
 #define __IPATH_KERNEL_SEND 0x2000	/* use kernel mode send */
 #define __IPATH_EPKTDBG     0x4000	/* print ethernet packet data */
 #define __IPATH_SMADBG      0x8000	/* sma packet debug */
-#define __IPATH_IPATHDBG    0x10000	/* Ethernet (IPATH) general debug on */
-#define __IPATH_IPATHWARN   0x20000	/* Ethernet (IPATH) warnings on */
-#define __IPATH_IPATHERR    0x40000	/* Ethernet (IPATH) errors on */
-#define __IPATH_IPATHPD     0x80000	/* Ethernet (IPATH) packet dump on */
-#define __IPATH_IPATHTABLE  0x100000	/* Ethernet (IPATH) table dump on */
+#define __IPATH_IPATHDBG    0x10000	/* Ethernet (IPATH) gen debug */
+#define __IPATH_IPATHWARN   0x20000	/* Ethernet (IPATH) warnings */
+#define __IPATH_IPATHERR    0x40000	/* Ethernet (IPATH) errors */
+#define __IPATH_IPATHPD     0x80000	/* Ethernet (IPATH) packet dump */
+#define __IPATH_IPATHTABLE  0x100000	/* Ethernet (IPATH) table dump */
 
 #else				/* _IPATH_DEBUGGING */
 
@@ -79,11 +79,12 @@
 #define __IPATH_TRSAMPLE  0x0	/* generate trace buffer sample entries */
 #define __IPATH_VERBDBG   0x0	/* very verbose debug */
 #define __IPATH_PKTDBG    0x0	/* print packet data */
-#define __IPATH_PROCDBG   0x0	/* print process startup (init)/exit messages */
+#define __IPATH_PROCDBG   0x0	/* process startup (init)/exit messages */
 /* print mmap/nopage stuff, not using VDBG any more */
 #define __IPATH_MMDBG     0x0
 #define __IPATH_EPKTDBG   0x0	/* print ethernet packet data */
-#define __IPATH_SMADBG    0x0   /* print process startup (init)/exit messages */#define __IPATH_IPATHDBG  0x0	/* Ethernet (IPATH) table dump on */
+#define __IPATH_SMADBG    0x0   /* process startup (init)/exit messages */
+#define __IPATH_IPATHDBG  0x0	/* Ethernet (IPATH) table dump on */
 #define __IPATH_IPATHWARN 0x0	/* Ethernet (IPATH) warnings on   */
 #define __IPATH_IPATHERR  0x0	/* Ethernet (IPATH) errors on   */
 #define __IPATH_IPATHPD   0x0	/* Ethernet (IPATH) packet dump on   */
diff -r e3f1bfd7ce46 -r 895650567032 drivers/infiniband/hw/ipath/ipath_registers.h
--- a/drivers/infiniband/hw/ipath/ipath_registers.h	Mon Apr 24 14:21:04 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_registers.h	Mon Apr 24 14:21:04 2006 -0700
@@ -34,8 +34,9 @@
 #define _IPATH_REGISTERS_H
 
 /*
- * This file should only be included by kernel source, and by the diags.
- * It defines the registers, and their contents, for the InfiniPath HT-400 chip
+ * This file should only be included by kernel source, and by the diags.  It
+ * defines the registers, and their contents, for the InfiniPath HT-400
+ * chip.
  */
 
 /*
@@ -156,8 +157,10 @@
 #define INFINIPATH_IBCC_FLOWCTRLWATERMARK_SHIFT 8
 #define INFINIPATH_IBCC_LINKINITCMD_MASK 0x3ULL
 #define INFINIPATH_IBCC_LINKINITCMD_DISABLE 1
-#define INFINIPATH_IBCC_LINKINITCMD_POLL 2	/* cycle through TS1/TS2 till OK */
-#define INFINIPATH_IBCC_LINKINITCMD_SLEEP 3	/* wait for TS1, then go on */
+/* cycle through TS1/TS2 till OK */
+#define INFINIPATH_IBCC_LINKINITCMD_POLL 2
+/* wait for TS1, then go on */
+#define INFINIPATH_IBCC_LINKINITCMD_SLEEP 3
 #define INFINIPATH_IBCC_LINKINITCMD_SHIFT 16
 #define INFINIPATH_IBCC_LINKCMD_MASK 0x3ULL
 #define INFINIPATH_IBCC_LINKCMD_INIT 1	/* move to 0x11 */
@@ -182,7 +185,8 @@
 #define INFINIPATH_IBCS_LINKSTATE_SHIFT 4
 #define INFINIPATH_IBCS_TXREADY       0x40000000
 #define INFINIPATH_IBCS_TXCREDITOK    0x80000000
-/* link training states (shift by INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) */
+/* link training states (shift by
+   INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) */
 #define INFINIPATH_IBCS_LT_STATE_DISABLED	0x00
 #define INFINIPATH_IBCS_LT_STATE_LINKUP		0x01
 #define INFINIPATH_IBCS_LT_STATE_POLLACTIVE	0x02
@@ -267,10 +271,12 @@
 /* kr_serdesconfig0 bits */
 #define INFINIPATH_SERDC0_RESET_MASK  0xfULL	/* overal reset bits */
 #define INFINIPATH_SERDC0_RESET_PLL   0x10000000ULL	/* pll reset */
-#define INFINIPATH_SERDC0_TXIDLE      0xF000ULL	/* tx idle enables (per lane) */
-#define INFINIPATH_SERDC0_RXDETECT_EN 0xF0000ULL	/* rx detect enables (per lane) */
-#define INFINIPATH_SERDC0_L1PWR_DN	 0xF0ULL	/* L1 Power down; use with RXDETECT,
-							   Otherwise not used on IB side */
+/* tx idle enables (per lane) */
+#define INFINIPATH_SERDC0_TXIDLE      0xF000ULL
+/* rx detect enables (per lane) */
+#define INFINIPATH_SERDC0_RXDETECT_EN 0xF0000ULL
+/* L1 Power down; use with RXDETECT, Otherwise not used on IB side */
+#define INFINIPATH_SERDC0_L1PWR_DN	 0xF0ULL
 
 /* kr_xgxsconfig bits */
 #define INFINIPATH_XGXS_RESET          0x7ULL
@@ -390,12 +396,13 @@ struct ipath_kregs {
 	ipath_kreg kr_txintmemsize;
 	ipath_kreg kr_xgxsconfig;
 	ipath_kreg kr_ibpllcfg;
-	/* use these two (and the following N ports) only with ipath_k*_kreg64_port();
-	 * not *kreg64() */
+	/* use these two (and the following N ports) only with
+	 * ipath_k*_kreg64_port(); not *kreg64() */
 	ipath_kreg kr_rcvhdraddr;
 	ipath_kreg kr_rcvhdrtailaddr;
 
-	/* remaining registers are not present on all types of infinipath chips  */
+	/* remaining registers are not present on all types of infinipath
+	   chips  */
 	ipath_kreg kr_rcvpktledcnt;
 	ipath_kreg kr_pcierbuftestreg0;
 	ipath_kreg kr_pcierbuftestreg1;
diff -r e3f1bfd7ce46 -r 895650567032 drivers/infiniband/hw/ipath/ipath_ud.c
--- a/drivers/infiniband/hw/ipath/ipath_ud.c	Mon Apr 24 14:21:04 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c	Mon Apr 24 14:21:04 2006 -0700
@@ -46,8 +46,10 @@
  * This is called from ipath_post_ud_send() to forward a WQE addressed
  * to the same HCA.
  */
-static void ipath_ud_loopback(struct ipath_qp *sqp, struct ipath_sge_state *ss,
-			      u32 length, struct ib_send_wr *wr, struct ib_wc *wc)
+static void ipath_ud_loopback(struct ipath_qp *sqp,
+			      struct ipath_sge_state *ss,
+			      u32 length, struct ib_send_wr *wr,
+			      struct ib_wc *wc)
 {
 	struct ipath_ibdev *dev = to_idev(sqp->ibqp.device);
 	struct ipath_qp *qp;
