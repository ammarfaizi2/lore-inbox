Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268559AbTANDgF>; Mon, 13 Jan 2003 22:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268557AbTANDgF>; Mon, 13 Jan 2003 22:36:05 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:21345
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268559AbTANDgB>; Mon, 13 Jan 2003 22:36:01 -0500
Date: Mon, 13 Jan 2003 22:45:28 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jaroslav Kysela <perex@perex.cz>
cc: Adam Belay <ambx1@neo.rr.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] sound/oss/opl3sa2.c compile fix
Message-ID: <Pine.LNX.4.44.0301132243430.12490-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes compile but card doesn't get detected, perhaps the id list?

Index: linux-2.5.57/sound/oss/opl3sa2.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.57/sound/oss/opl3sa2.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 opl3sa2.c
--- linux-2.5.57/sound/oss/opl3sa2.c	13 Jan 2003 22:55:13 -0000	1.1.1.1
+++ linux-2.5.57/sound/oss/opl3sa2.c	14 Jan 2003 03:25:43 -0000
@@ -851,19 +851,19 @@
 	opl3sa2_activated[card] = 1;
 
 	/* Our own config: */
-	cfg[card].io_base = dev->resource[4].start;
+	cfg[card].io_base = dev->io_resource[4].start;
 	cfg[card].irq     = dev->irq_resource[0].start;
 	cfg[card].dma     = dev->dma_resource[0].start;
 	cfg[card].dma2    = dev->dma_resource[1].start;
 
 	/* The MSS config: */
-	cfg_mss[card].io_base      = dev->resource[1].start;
+	cfg_mss[card].io_base      = dev->io_resource[1].start;
 	cfg_mss[card].irq          = dev->irq_resource[0].start;
 	cfg_mss[card].dma          = dev->dma_resource[0].start;
 	cfg_mss[card].dma2         = dev->dma_resource[1].start;
 	cfg_mss[card].card_subtype = 1; /* No IRQ or DMA setup */
 
-	cfg_mpu[card].io_base       = dev->resource[3].start;
+	cfg_mpu[card].io_base       = dev->io_resource[3].start;
 	cfg_mpu[card].irq           = dev->irq_resource[0].start;
 	cfg_mpu[card].dma           = -1;
 	cfg_mpu[card].dma2          = -1;
-- 
function.linuxpower.ca

