Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278068AbRJIXoV>; Tue, 9 Oct 2001 19:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278065AbRJIXoQ>; Tue, 9 Oct 2001 19:44:16 -0400
Received: from sushi.toad.net ([162.33.130.105]:2978 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S278064AbRJIXnO>;
	Tue, 9 Oct 2001 19:43:14 -0400
Subject: [PATCH] parport_pc.c bugfix
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 09 Oct 2001 19:43:16 -0400
Message-Id: <1002670998.763.29.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Self-explanatory patch:

--- linux-2.4.10-ac10/drivers/parport/parport_pc.c	Mon Oct  8 22:41:14 2001
+++ linux-2.4.10-ac10-fix/drivers/parport/parport_pc.c	Tue Oct  9 19:36:58 2001
@@ -2826,7 +2826,7 @@
 	if ( UNSET(dev->irq_resource[0]) ) {
 		irq = PARPORT_IRQ_NONE;
 	} else {
-		if ( dev->irq_resource[0].start == -1 ) {
+		if ( dev->irq_resource[0].start == (unsigned long)-1 ) {
 			irq = PARPORT_IRQ_NONE;
 			printk(", irq disabled");
 		} else {
@@ -2838,12 +2838,12 @@
 	if ( UNSET(dev->dma_resource[0]) ) {
 		dma = PARPORT_DMA_NONE;
 	} else {
-		if ( dev->dma_resource[0].start == -1 ) {
+		if ( dev->dma_resource[0].start == (unsigned long)-1 ) {
 			dma = PARPORT_DMA_NONE;
 			printk(", dma disabled");
 		} else {
 			dma = dev->dma_resource[0].start;
-			printk(", dma %d",irq);
+			printk(", dma %d",dma);
 		}
 	}
 

