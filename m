Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263935AbTCVWhw>; Sat, 22 Mar 2003 17:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263937AbTCVWhw>; Sat, 22 Mar 2003 17:37:52 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9349
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263935AbTCVWhs>; Sat, 22 Mar 2003 17:37:48 -0500
Date: Sat, 22 Mar 2003 23:53:29 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303222353.h2MNrT7F020685@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: make opl3sa2 build again
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/sound/oss/opl3sa2.c linux-2.5.65-ac3/sound/oss/opl3sa2.c
--- linux-2.5.65-bk3/sound/oss/opl3sa2.c	2003-03-22 19:34:19.000000000 +0000
+++ linux-2.5.65-ac3/sound/oss/opl3sa2.c	2003-03-22 20:43:27.000000000 +0000
@@ -851,20 +851,20 @@
 	opl3sa2_activated[card] = 1;
 
 	/* Our own config: */
-	cfg[card].io_base = dev->io_resource[4].start;
-	cfg[card].irq     = dev->irq_resource[0].start;
-	cfg[card].dma     = dev->dma_resource[0].start;
-	cfg[card].dma2    = dev->dma_resource[1].start;
+	cfg[card].io_base = pnp_port_start(dev, 4);
+	cfg[card].irq     = pnp_irq(dev, 0);
+	cfg[card].dma     = pnp_dma(dev, 0);
+	cfg[card].dma2    = pnp_dma(dev, 1);
 
 	/* The MSS config: */
-	cfg_mss[card].io_base      = dev->io_resource[1].start;
-	cfg_mss[card].irq          = dev->irq_resource[0].start;
-	cfg_mss[card].dma          = dev->dma_resource[0].start;
-	cfg_mss[card].dma2         = dev->dma_resource[1].start;
+	cfg_mss[card].io_base      = pnp_port_start(dev, 1);
+	cfg_mss[card].irq          = pnp_irq(dev, 0);
+	cfg_mss[card].dma          = pnp_dma(dev, 0);
+	cfg_mss[card].dma2         = pnp_dma(dev, 1);
 	cfg_mss[card].card_subtype = 1; /* No IRQ or DMA setup */
 
-	cfg_mpu[card].io_base       = dev->io_resource[3].start;
-	cfg_mpu[card].irq           = dev->irq_resource[0].start;
+	cfg_mpu[card].io_base       = pnp_port_start(dev, 3);
+	cfg_mpu[card].irq           = pnp_irq(dev, 0);
 	cfg_mpu[card].dma           = -1;
 	cfg_mpu[card].dma2          = -1;
 	cfg_mpu[card].always_detect = 1; /* It's there, so use shared IRQs */
