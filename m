Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUIOBpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUIOBpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUIOBpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:45:42 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:32135 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S266595AbUIOBpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:45:38 -0400
Message-ID: <41479EB7.1010809@am.sony.com>
Date: Tue, 14 Sep 2004 18:45:27 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.8.1] ppc32: Cleanup ppc4xx_pic debug output
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple patch that cleans up the ppc4xx_pic debug output.
 
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF
---

 ppc4xx_pic.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2.6.8.1.orig/arch/ppc/syslib/ppc4xx_pic.c	2004-08-14 03:54:46.000000000 -0700
+++ gpio-test/arch/ppc/syslib/ppc4xx_pic.c	2004-09-14 12:10:39.000000000 -0700
@@ -425,8 +428,9 @@
 		    (irq <
 		     ibm4xxPIC_NumInitSenses) ? ibm4xxPIC_InitSenses[irq] : 3;
 #ifdef PPC4xx_PIC_DEBUG
-		printk("PPC4xx_picext %d word:%x bit:%x sense:%x", irq, word,
-		       bit, sense);
+		printk("ppc4xx_extpic_init: "
+			"irq:%2.2d word:%x bit:%2.2x sense:%x ", 
+			irq, word, bit, sense);
 #endif
 		ppc_cached_sense_mask[word] |=
 		    (~sense & IRQ_SENSE_MASK) << (31 - bit);
@@ -435,8 +439,8 @@
 		switch (word) {
 		case 0:
 #ifdef PPC4xx_PIC_DEBUG
-			printk("Pol %x ", mfdcr(DCRN_UIC_PR(UIC0)));
-			printk("Level %x\n", mfdcr(DCRN_UIC_TR(UIC0)));
+			printk("pol:%8.8x ", mfdcr(DCRN_UIC_PR(UIC0)));
+			printk("level:%8.8x\n", mfdcr(DCRN_UIC_TR(UIC0)));
 #endif
 			/* polarity  setting */
 			mtdcr(DCRN_UIC_PR(UIC0), ppc_cached_pol_mask[word]);
@@ -447,8 +451,8 @@
 			break;
 		case 1:
 #ifdef PPC4xx_PIC_DEBUG
-			printk("Pol %x ", mfdcr(DCRN_UIC_PR(UIC1)));
-			printk("Level %x\n", mfdcr(DCRN_UIC_TR(UIC1)));
+			printk("pol:%8.8x ", mfdcr(DCRN_UIC_PR(UIC1)));
+			printk("level:%8.8x\n", mfdcr(DCRN_UIC_TR(UIC1)));
 #endif
 			/* polarity  setting */
 			mtdcr(DCRN_UIC_PR(UIC1), ppc_cached_pol_mask[word]);
@@ -459,8 +463,8 @@
 			break;
 		case 2:
 #ifdef PPC4xx_PIC_DEBUG
-			printk("Pol %x ", mfdcr(DCRN_UIC_PR(UIC2)));
-			printk("Level %x\n", mfdcr(DCRN_UIC_TR(UIC2)));
+			printk("pol:%8.8x ", mfdcr(DCRN_UIC_PR(UIC2)));
+			printk("level:%8.8x\n", mfdcr(DCRN_UIC_TR(UIC2)));
 #endif
 			/* polarity  setting */
 			mtdcr(DCRN_UIC_PR(UIC2), ppc_cached_pol_mask[word]);

-EOF

