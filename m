Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVI1V6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVI1V6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVI1V6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:58:30 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:37893 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751055AbVI1VyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:54:02 -0400
Date: Wed, 28 Sep 2005 17:50:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, leonid.grossman@neterion.com
Subject: [patch 2.6.14-rc2 2/2] s2io: add MODULE_VERSION to s2io driver
Message-ID: <09282005175052.10818@bilbo.tuxdriver.com>
In-Reply-To: <09282005175051.10754@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a MODULE_VERSION entry for the s2io driver.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/s2io.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -65,9 +65,11 @@
 #include "s2io.h"
 #include "s2io-regs.h"
 
+#define DRV_VERSION "2.0.8.1"
+
 /* S2io Driver name & version. */
 static char s2io_driver_name[] = "Neterion";
-static char s2io_driver_version[] = "Version 2.0.8.1";
+static char s2io_driver_version[] = DRV_VERSION;
 
 static inline int RXD_IS_UP2DT(RxD_t *rxdp)
 {
@@ -5227,6 +5229,8 @@ static void s2io_init_pci(nic_t * sp)
 
 MODULE_AUTHOR("Raghavendra Koushik <raghavendra.koushik@neterion.com>");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
 module_param(tx_fifo_num, int, 0);
 module_param(rx_ring_num, int, 0);
 module_param_array(tx_fifo_len, uint, NULL, 0);
@@ -5570,7 +5574,7 @@ s2io_init_nic(struct pci_dev *pdev, cons
 	if (sp->device_type & XFRAME_II_DEVICE) {
 		DBG_PRINT(ERR_DBG, "%s: Neterion Xframe II 10GbE adapter ",
 			  dev->name);
-		DBG_PRINT(ERR_DBG, "(rev %d), %s",
+		DBG_PRINT(ERR_DBG, "(rev %d), Version %s",
 				get_xena_rev_id(sp->pdev),
 				s2io_driver_version);
 #ifdef CONFIG_2BUFF_MODE
@@ -5594,7 +5598,7 @@ s2io_init_nic(struct pci_dev *pdev, cons
 	} else {
 		DBG_PRINT(ERR_DBG, "%s: Neterion Xframe I 10GbE adapter ",
 			  dev->name);
-		DBG_PRINT(ERR_DBG, "(rev %d), %s",
+		DBG_PRINT(ERR_DBG, "(rev %d), Version %s",
 					get_xena_rev_id(sp->pdev),
 					s2io_driver_version);
 #ifdef CONFIG_2BUFF_MODE
