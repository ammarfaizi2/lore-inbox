Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVIMFaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVIMFaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVIMFaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:30:15 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:59579 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932294AbVIMFaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:30:13 -0400
Message-Id: <20050913052632.159645000.dtor_core@ameritech.net>
References: <20050913052026.358863000.dtor_core@ameritech.net>
Date: Tue, 13 Sep 2005 00:20:27 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 1/2] IRDA: nsc-ircc - clean up whitespace damage
Content-Disposition: inline; filename=nsc-ircc-whitespace.patch
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRDA: nsc-ircc - clean up whitespace

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/net/irda/nsc-ircc.c |  418 ++++++++++++++++++++++----------------------
 drivers/net/irda/nsc-ircc.h |   40 ++--
 2 files changed, 229 insertions(+), 229 deletions(-)

Index: work/drivers/net/irda/nsc-ircc.c
===================================================================
--- work.orig/drivers/net/irda/nsc-ircc.c
+++ work/drivers/net/irda/nsc-ircc.c
@@ -1,5 +1,5 @@
 /*********************************************************************
- *                
+ *
  * Filename:      nsc-ircc.c
  * Version:       1.0
  * Description:   Driver for the NSC PC'108 and PC'338 IrDA chipsets
@@ -8,29 +8,29 @@
  * Created at:    Sat Nov  7 21:43:15 1998
  * Modified at:   Wed Mar  1 11:29:34 2000
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
- * 
+ *
  *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>
  *     Copyright (c) 1998 Lichen Wang, <lwang@actisys.com>
  *     Copyright (c) 1998 Actisys Corp., www.actisys.com
  *     All Rights Reserved
- *      
- *     This program is free software; you can redistribute it and/or 
- *     modify it under the terms of the GNU General Public License as 
- *     published by the Free Software Foundation; either version 2 of 
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
  *     the License, or (at your option) any later version.
- *  
+ *
  *     Neither Dag Brattli nor University of Tromsø admit liability nor
- *     provide warranty for any of this software. This material is 
+ *     provide warranty for any of this software. This material is
  *     provided "AS-IS" and at no charge.
  *
  *     Notice that all functions that needs to access the chip in _any_
- *     way, must save BSR register on entry, and restore it on exit. 
+ *     way, must save BSR register on entry, and restore it on exit.
  *     It is _very_ important to follow this policy!
  *
  *         __u8 bank;
- *     
+ *
  *         bank = inb(iobase+BSR);
- *  
+ *
  *         do_your_stuff_here();
  *
  *         outb(bank, iobase+BSR);
@@ -38,7 +38,7 @@
  *    If you find bugs in this file, its very likely that the same bug
  *    will also be in w83977af_ir.c since the implementations are quite
  *    similar.
- *     
+ *
  ********************************************************************/
 
 #include <linux/module.h>
@@ -90,15 +90,15 @@ static int nsc_ircc_init_39x(nsc_chip_t 
 /* These are the known NSC chips */
 static nsc_chip_t chips[] = {
 /*  Name, {cfg registers}, chip id index reg, chip id expected value, revision mask */
-	{ "PC87108", { 0x150, 0x398, 0xea }, 0x05, 0x10, 0xf0, 
+	{ "PC87108", { 0x150, 0x398, 0xea }, 0x05, 0x10, 0xf0,
 	  nsc_ircc_probe_108, nsc_ircc_init_108 },
-	{ "PC87338", { 0x398, 0x15c, 0x2e }, 0x08, 0xb0, 0xf8, 
+	{ "PC87338", { 0x398, 0x15c, 0x2e }, 0x08, 0xb0, 0xf8,
 	  nsc_ircc_probe_338, nsc_ircc_init_338 },
 	/* Contributed by Steffen Pingel - IBM X40 */
 	{ "PC8738x", { 0x164e, 0x4e, 0x0 }, 0x20, 0xf4, 0xff,
 	  nsc_ircc_probe_39x, nsc_ircc_init_39x },
 	/* Contributed by Jan Frey - IBM A30/A31 */
-	{ "PC8739x", { 0x2e, 0x4e, 0x0 }, 0x20, 0xea, 0xff, 
+	{ "PC8739x", { 0x2e, 0x4e, 0x0 }, 0x20, 0xea, 0xff,
 	  nsc_ircc_probe_39x, nsc_ircc_init_39x },
 	{ NULL }
 };
@@ -130,7 +130,7 @@ static int  nsc_ircc_open(int i, chipio_
 static int  nsc_ircc_close(struct nsc_ircc_cb *self);
 static int  nsc_ircc_setup(chipio_t *info);
 static void nsc_ircc_pio_receive(struct nsc_ircc_cb *self);
-static int  nsc_ircc_dma_receive(struct nsc_ircc_cb *self); 
+static int  nsc_ircc_dma_receive(struct nsc_ircc_cb *self);
 static int  nsc_ircc_dma_receive_complete(struct nsc_ircc_cb *self, int iobase);
 static int  nsc_ircc_hard_xmit_sir(struct sk_buff *skb, struct net_device *dev);
 static int  nsc_ircc_hard_xmit_fir(struct sk_buff *skb, struct net_device *dev);
@@ -167,13 +167,13 @@ static int __init nsc_ircc_init(void)
 	for (chip=chips; chip->name ; chip++) {
 		IRDA_DEBUG(2, "%s(), Probing for %s ...\n", __FUNCTION__,
 			   chip->name);
-		
+
 		/* Try all config registers for this chip */
 		for (cfg=0; cfg<3; cfg++) {
 			cfg_base = chip->cfg[cfg];
 			if (!cfg_base)
 				continue;
-			
+
 			memset(&info, 0, sizeof(chipio_t));
 			info.cfg_base = cfg_base;
 			info.fir_base = io[i];
@@ -186,18 +186,18 @@ static int __init nsc_ircc_init(void)
 				IRDA_DEBUG(2, "%s() no chip at 0x%03x\n", __FUNCTION__, cfg_base);
 				continue;
 			}
-			
+
 			/* Read chip identification register */
 			outb(chip->cid_index, cfg_base);
 			id = inb(cfg_base+1);
 			if ((id & chip->cid_mask) == chip->cid_value) {
 				IRDA_DEBUG(2, "%s() Found %s chip, revision=%d\n",
 					   __FUNCTION__, chip->name, id & ~chip->cid_mask);
-				/* 
+				/*
 				 * If the user supplies the base address, then
 				 * we init the chip, if not we probe the values
 				 * set by the BIOS
-				 */				
+				 */
 				if (io[i] < 0x2000) {
 					chip->init(chip, &info);
 				} else
@@ -209,8 +209,8 @@ static int __init nsc_ircc_init(void)
 			} else {
 				IRDA_DEBUG(2, "%s(), Wrong chip id=0x%02x\n", __FUNCTION__, id);
 			}
-		} 
-		
+		}
+
 	}
 
 	return ret;
@@ -268,7 +268,7 @@ static int __init nsc_ircc_open(int i, c
 	self = dev->priv;
 	self->netdev = dev;
 	spin_lock_init(&self->lock);
-   
+
 	/* Need to store self somewhere */
 	dev_self[i] = self;
 	self->index = i;
@@ -280,7 +280,7 @@ static int __init nsc_ircc_open(int i, c
         self->io.fir_ext   = CHIP_IO_EXTENT;
         self->io.dma       = info->dma;
         self->io.fifo_size = 32;
-	
+
 	/* Reserve the ioports that we need */
 	ret = request_region(self->io.fir_base, self->io.fir_ext, driver_name);
 	if (!ret) {
@@ -292,16 +292,16 @@ static int __init nsc_ircc_open(int i, c
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
-	
+
 	/* The only value we must override it the baudrate */
 	self->qos.baud_rate.bits = IR_9600|IR_19200|IR_38400|IR_57600|
 		IR_115200|IR_576000|IR_1152000 |(IR_4000000 << 8);
-	
+
 	self->qos.min_turn_time.bits = qos_mtt_bits;
 	irda_qos_bits_to_value(&self->qos);
-	
+
 	/* Max DMA buffer size needed = (data_size + 6) * (window_size) + 6; */
-	self->rx_buff.truesize = 14384; 
+	self->rx_buff.truesize = 14384;
 	self->tx_buff.truesize = 14384;
 
 	/* Allocate memory if needed */
@@ -314,7 +314,7 @@ static int __init nsc_ircc_open(int i, c
 
 	}
 	memset(self->rx_buff.head, 0, self->rx_buff.truesize);
-	
+
 	self->tx_buff.head =
 		dma_alloc_coherent(NULL, self->tx_buff.truesize,
 				   &self->tx_buff_dma, GFP_KERNEL);
@@ -328,7 +328,7 @@ static int __init nsc_ircc_open(int i, c
 	self->rx_buff.state = OUTSIDE_FRAME;
 	self->tx_buff.data = self->tx_buff.head;
 	self->rx_buff.data = self->rx_buff.head;
-	
+
 	/* Reset Tx queue info */
 	self->tx_fifo.len = self->tx_fifo.ptr = self->tx_fifo.free = 0;
 	self->tx_fifo.tail = self->tx_buff.head;
@@ -352,14 +352,14 @@ static int __init nsc_ircc_open(int i, c
 	if ((dongle_id <= 0) ||
 	    (dongle_id >= (sizeof(dongle_types) / sizeof(dongle_types[0]))) ) {
 		dongle_id = nsc_ircc_read_dongle_id(self->io.fir_base);
-		
+
 		IRDA_MESSAGE("%s, Found dongle: %s\n", driver_name,
 			     dongle_types[dongle_id]);
 	} else {
 		IRDA_MESSAGE("%s, Using dongle: %s\n", driver_name,
 			     dongle_types[dongle_id]);
 	}
-	
+
 	self->io.dongle_id = dongle_id;
 	nsc_ircc_init_dongle_interface(self->io.fir_base, dongle_id);
 
@@ -402,21 +402,21 @@ static int __exit nsc_ircc_close(struct 
 	unregister_netdev(self->netdev);
 
 	/* Release the PORT that this driver is using */
-	IRDA_DEBUG(4, "%s(), Releasing Region %03x\n", 
+	IRDA_DEBUG(4, "%s(), Releasing Region %03x\n",
 		   __FUNCTION__, self->io.fir_base);
 	release_region(self->io.fir_base, self->io.fir_ext);
 
 	if (self->tx_buff.head)
 		dma_free_coherent(NULL, self->tx_buff.truesize,
 				  self->tx_buff.head, self->tx_buff_dma);
-	
+
 	if (self->rx_buff.head)
 		dma_free_coherent(NULL, self->rx_buff.truesize,
 				  self->rx_buff.head, self->rx_buff_dma);
 
 	dev_self[self->index] = NULL;
 	free_netdev(self->netdev);
-	
+
 	return 0;
 }
 
@@ -433,7 +433,7 @@ static int nsc_ircc_init_108(nsc_chip_t 
 
 	outb(2, cfg_base);      /* Mode Control Register (MCTL) */
 	outb(0x00, cfg_base+1); /* Disable device */
-	
+
 	/* Base Address and Interrupt Control Register (BAIC) */
 	outb(CFG_108_BAIC, cfg_base);
 	switch (info->fir_base) {
@@ -443,7 +443,7 @@ static int nsc_ircc_init_108(nsc_chip_t 
 	case 0x2f8: outb(0x17, cfg_base+1); break;
 	default: IRDA_ERROR("%s(), invalid base_address", __FUNCTION__);
 	}
-	
+
 	/* Control Signal Routing Register (CSRT) */
 	switch (info->irq) {
 	case 3:  temp = 0x01; break;
@@ -456,14 +456,14 @@ static int nsc_ircc_init_108(nsc_chip_t 
 	default: IRDA_ERROR("%s(), invalid irq", __FUNCTION__);
 	}
 	outb(CFG_108_CSRT, cfg_base);
-	
-	switch (info->dma) {	
+
+	switch (info->dma) {
 	case 0: outb(0x08+temp, cfg_base+1); break;
 	case 1: outb(0x10+temp, cfg_base+1); break;
 	case 3: outb(0x18+temp, cfg_base+1); break;
 	default: IRDA_ERROR("%s(), invalid dma", __FUNCTION__);
 	}
-	
+
 	outb(CFG_108_MCTL, cfg_base);      /* Mode Control Register (MCTL) */
 	outb(0x03, cfg_base+1); /* Enable device */
 
@@ -473,10 +473,10 @@ static int nsc_ircc_init_108(nsc_chip_t 
 /*
  * Function nsc_ircc_probe_108 (chip, info)
  *
- *    
+ *
  *
  */
-static int nsc_ircc_probe_108(nsc_chip_t *chip, chipio_t *info) 
+static int nsc_ircc_probe_108(nsc_chip_t *chip, chipio_t *info)
 {
 	int cfg_base = info->cfg_base;
 	int reg;
@@ -484,7 +484,7 @@ static int nsc_ircc_probe_108(nsc_chip_t
 	/* Read address and interrupt control register (BAIC) */
 	outb(CFG_108_BAIC, cfg_base);
 	reg = inb(cfg_base+1);
-	
+
 	switch (reg & 0x03) {
 	case 0:
 		info->fir_base = 0x3e8;
@@ -565,25 +565,25 @@ static int nsc_ircc_probe_108(nsc_chip_t
 /*
  * Function nsc_ircc_init_338 (chip, info)
  *
- *    Initialize the NSC '338 chip. Remember that the 87338 needs two 
+ *    Initialize the NSC '338 chip. Remember that the 87338 needs two
  *    consecutive writes to the data registers while CPU interrupts are
  *    disabled. The 97338 does not require this, but shouldn't be any
  *    harm if we do it anyway.
  */
-static int nsc_ircc_init_338(nsc_chip_t *chip, chipio_t *info) 
+static int nsc_ircc_init_338(nsc_chip_t *chip, chipio_t *info)
 {
 	/* No init yet */
-	
+
 	return 0;
 }
 
 /*
  * Function nsc_ircc_probe_338 (chip, info)
  *
- *    
+ *
  *
  */
-static int nsc_ircc_probe_338(nsc_chip_t *chip, chipio_t *info) 
+static int nsc_ircc_probe_338(nsc_chip_t *chip, chipio_t *info)
 {
 	int cfg_base = info->cfg_base;
 	int reg, com = 0;
@@ -598,7 +598,7 @@ static int nsc_ircc_probe_338(nsc_chip_t
 	/* Check if we are in Legacy or PnP mode */
 	outb(CFG_338_PNP0, cfg_base);
 	reg = inb(cfg_base+1);
-	
+
 	pnp = (reg >> 3) & 0x01;
 	if (pnp) {
 		IRDA_DEBUG(2, "(), Chip is in PnP mode\n");
@@ -613,7 +613,7 @@ static int nsc_ircc_probe_338(nsc_chip_t
 		/* Read function address register (FAR) */
 		outb(CFG_338_FAR, cfg_base);
 		reg = inb(cfg_base+1);
-		
+
 		switch ((reg >> 4) & 0x03) {
 		case 0:
 			info->fir_base = 0x3f8;
@@ -628,7 +628,7 @@ static int nsc_ircc_probe_338(nsc_chip_t
 			com = 4;
 			break;
 		}
-		
+
 		if (com) {
 			switch ((reg >> 6) & 0x03) {
 			case 0:
@@ -663,9 +663,9 @@ static int nsc_ircc_probe_338(nsc_chip_t
 	/* Read PnP register 1 (PNP1) */
 	outb(CFG_338_PNP1, cfg_base);
 	reg = inb(cfg_base+1);
-	
+
 	info->irq = reg >> 4;
-	
+
 	/* Read PnP register 3 (PNP3) */
 	outb(CFG_338_PNP3, cfg_base);
 	reg = inb(cfg_base+1);
@@ -699,14 +699,14 @@ static int nsc_ircc_probe_338(nsc_chip_t
  *
  * Note : this code was written by Jan Frey <janfrey@web.de>
  */
-static int nsc_ircc_init_39x(nsc_chip_t *chip, chipio_t *info) 
+static int nsc_ircc_init_39x(nsc_chip_t *chip, chipio_t *info)
 {
 	int cfg_base = info->cfg_base;
 	int enabled;
 
 	/* User is shure about his config... accept it. */
 	IRDA_DEBUG(2, "%s(): nsc_ircc_init_39x (user settings): "
-		   "io=0x%04x, irq=%d, dma=%d\n", 
+		   "io=0x%04x, irq=%d, dma=%d\n",
 		   __FUNCTION__, info->fir_base, info->irq, info->dma);
 
 	/* Access bank for SP2 */
@@ -718,7 +718,7 @@ static int nsc_ircc_init_39x(nsc_chip_t 
 	/* We want to enable the device if not enabled */
 	outb(CFG_39X_ACT, cfg_base);
 	enabled = inb(cfg_base+1) & 0x01;
-	
+
 	if (!enabled) {
 		/* Enable the device */
 		outb(CFG_39X_SIOCF1, cfg_base);
@@ -741,7 +741,7 @@ static int nsc_ircc_init_39x(nsc_chip_t 
  *
  * Note : this code was written by Jan Frey <janfrey@web.de>
  */
-static int nsc_ircc_probe_39x(nsc_chip_t *chip, chipio_t *info) 
+static int nsc_ircc_probe_39x(nsc_chip_t *chip, chipio_t *info)
 {
 	int cfg_base = info->cfg_base;
 	int reg1, reg2, irq, irqt, dma1, dma2;
@@ -778,7 +778,7 @@ static int nsc_ircc_probe_39x(nsc_chip_t
 
 	outb(CFG_39X_ACT, cfg_base);
 	info->enabled = enabled = inb(cfg_base+1) & 0x01;
-	
+
 	outb(CFG_39X_SPC, cfg_base);
 	susp = 1 - ((inb(cfg_base+1) & 0x02) >> 1);
 
@@ -789,7 +789,7 @@ static int nsc_ircc_probe_39x(nsc_chip_t
 	/* We want to enable the device if not enabled */
 	outb(CFG_39X_ACT, cfg_base);
 	enabled = inb(cfg_base+1) & 0x01;
-	
+
 	if (!enabled) {
 		/* Enable the device */
 		outb(CFG_39X_SIOCF1, cfg_base);
@@ -834,13 +834,13 @@ static int nsc_ircc_setup(chipio_t *info
 	switch_bank(iobase, BANK2);
 	outb(ECR1_EXT_SL, iobase+ECR1);
 	switch_bank(iobase, BANK0);
-	
+
 	/* Set FIFO threshold to TX17, RX16, reset and enable FIFO's */
 	switch_bank(iobase, BANK0);
 	outb(FCR_RXTH|FCR_TXTH|FCR_TXSR|FCR_RXSR|FCR_FIFO_EN, iobase+FCR);
 
-	outb(0x03, iobase+LCR); 	/* 8 bit word length */
-	outb(MCR_SIR, iobase+MCR); 	/* Start at SIR-mode, also clears LSR*/
+	outb(0x03, iobase+LCR);		/* 8 bit word length */
+	outb(MCR_SIR, iobase+MCR);	/* Start at SIR-mode, also clears LSR*/
 
 	/* Set FIFO size to 32 */
 	switch_bank(iobase, BANK2);
@@ -848,7 +848,7 @@ static int nsc_ircc_setup(chipio_t *info
 
 	/* IRCR2: FEND_MD is not set */
 	switch_bank(iobase, BANK5);
- 	outb(0x02, iobase+4);
+	outb(0x02, iobase+4);
 
 	/* Make sure that some defaults are OK */
 	switch_bank(iobase, BANK6);
@@ -880,20 +880,20 @@ static int nsc_ircc_read_dongle_id (int 
 
 	/* Select Bank 7 */
 	switch_bank(iobase, BANK7);
-	
+
 	/* IRCFG4: IRSL0_DS and IRSL21_DS are cleared */
 	outb(0x00, iobase+7);
-	
+
 	/* ID0, 1, and 2 are pulled up/down very slowly */
 	udelay(50);
-	
+
 	/* IRCFG1: read the ID bits */
 	dongle_id = inb(iobase+4) & 0x0f;
 
 #ifdef BROKEN_DONGLE_ID
 	if (dongle_id == 0x0a)
 		dongle_id = 0x09;
-#endif	
+#endif
 	/* Go back to  bank 0 before returning */
 	switch_bank(iobase, BANK0);
 
@@ -908,7 +908,7 @@ static int nsc_ircc_read_dongle_id (int 
  *     This function initializes the dongle for the transceiver that is
  *     used. This procedure needs to be executed once after
  *     power-on/reset. It also needs to be used whenever you suspect that
- *     the dongle is changed. 
+ *     the dongle is changed.
  */
 static void nsc_ircc_init_dongle_interface (int iobase, int dongle_id)
 {
@@ -919,32 +919,32 @@ static void nsc_ircc_init_dongle_interfa
 
 	/* Select Bank 7 */
 	switch_bank(iobase, BANK7);
-	
+
 	/* IRCFG4: set according to dongle_id */
 	switch (dongle_id) {
 	case 0x00: /* same as */
 	case 0x01: /* Differential serial interface */
 		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x02: /* same as */
 	case 0x03: /* Reserved */
 		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x04: /* Sharp RY5HD01 */
 		break;
 	case 0x05: /* Reserved, but this is what the Thinkpad reports */
 		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x06: /* Single-ended serial interface */
 		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x07: /* Consumer-IR only */
 		IRDA_DEBUG(0, "%s(), %s is not for IrDA mode\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x08: /* HP HSDL-2300, HP HSDL-3600/HSDL-3610 */
 		IRDA_DEBUG(0, "%s(), %s\n",
@@ -956,37 +956,37 @@ static void nsc_ircc_init_dongle_interfa
 	case 0x0A: /* same as */
 	case 0x0B: /* Reserved */
 		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x0C: /* same as */
 	case 0x0D: /* HP HSDL-1100/HSDL-2100 */
-		/* 
-		 * Set irsl0 as input, irsl[1-2] as output, and separate 
-		 * inputs are used for SIR and MIR/FIR 
+		/*
+		 * Set irsl0 as input, irsl[1-2] as output, and separate
+		 * inputs are used for SIR and MIR/FIR
 		 */
-		outb(0x48, iobase+7); 
+		outb(0x48, iobase+7);
 		break;
 	case 0x0E: /* Supports SIR Mode only */
 		outb(0x28, iobase+7); /* Set irsl[0-2] as output */
 		break;
 	case 0x0F: /* No dongle connected */
 		IRDA_DEBUG(0, "%s(), %s\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 
 		switch_bank(iobase, BANK0);
 		outb(0x62, iobase+MCR);
 		break;
-	default: 
-		IRDA_DEBUG(0, "%s(), invalid dongle_id %#x", 
+	default:
+		IRDA_DEBUG(0, "%s(), invalid dongle_id %#x",
 			   __FUNCTION__, dongle_id);
 	}
-	
+
 	/* IRCFG1: IRSL1 and 2 are set to IrDA mode */
 	outb(0x00, iobase+4);
 
 	/* Restore bank register */
 	outb(bank, iobase+BSR);
-	
+
 } /* set_up_dongle_interface */
 
 /*
@@ -1004,36 +1004,36 @@ static void nsc_ircc_change_dongle_speed
 
 	/* Select Bank 7 */
 	switch_bank(iobase, BANK7);
-	
+
 	/* IRCFG1: set according to dongle_id */
 	switch (dongle_id) {
 	case 0x00: /* same as */
 	case 0x01: /* Differential serial interface */
 		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x02: /* same as */
 	case 0x03: /* Reserved */
 		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x04: /* Sharp RY5HD01 */
 		break;
 	case 0x05: /* Reserved */
 		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x06: /* Single-ended serial interface */
 		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x07: /* Consumer-IR only */
 		IRDA_DEBUG(0, "%s(), %s is not for IrDA mode\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x08: /* HP HSDL-2300, HP HSDL-3600/HSDL-3610 */
-		IRDA_DEBUG(0, "%s(), %s\n", 
-			   __FUNCTION__, dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s\n",
+			   __FUNCTION__, dongle_types[dongle_id]);
 		outb(0x00, iobase+4);
 		if (speed > 115200)
 			outb(0x01, iobase+4);
@@ -1052,7 +1052,7 @@ static void nsc_ircc_change_dongle_speed
 	case 0x0A: /* same as */
 	case 0x0B: /* Reserved */
 		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
-			   __FUNCTION__, dongle_types[dongle_id]); 
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x0C: /* same as */
 	case 0x0D: /* HP HSDL-1100/HSDL-2100 */
@@ -1063,10 +1063,10 @@ static void nsc_ircc_change_dongle_speed
 		IRDA_DEBUG(0, "%s(), %s is not for IrDA mode\n",
 			   __FUNCTION__, dongle_types[dongle_id]);
 
-		switch_bank(iobase, BANK0); 
+		switch_bank(iobase, BANK0);
 		outb(0x62, iobase+MCR);
 		break;
-	default: 
+	default:
 		IRDA_DEBUG(0, "%s(), invalid data_rate\n", __FUNCTION__);
 	}
 	/* Restore bank register */
@@ -1084,7 +1084,7 @@ static __u8 nsc_ircc_change_speed(struct
 {
 	struct net_device *dev = self->netdev;
 	__u8 mcr = MCR_SIR;
-	int iobase; 
+	int iobase;
 	__u8 bank;
 	__u8 ier;                  /* Interrupt enable register */
 
@@ -1116,10 +1116,10 @@ static __u8 nsc_ircc_change_speed(struct
 	case 115200: outb(0x01, iobase+BGDL); break;
 	case 576000:
 		switch_bank(iobase, BANK5);
-		
+
 		/* IRCR2: MDRS is set */
 		outb(inb(iobase+4) | 0x04, iobase+4);
-	       
+
 		mcr = MCR_MIR;
 		IRDA_DEBUG(0, "%s(), handling baud of 576000\n", __FUNCTION__);
 		break;
@@ -1133,7 +1133,7 @@ static __u8 nsc_ircc_change_speed(struct
 		break;
 	default:
 		mcr = MCR_FIR;
-		IRDA_DEBUG(0, "%s(), unknown baud rate of %d\n", 
+		IRDA_DEBUG(0, "%s(), unknown baud rate of %d\n",
 			   __FUNCTION__, speed);
 		break;
 	}
@@ -1155,13 +1155,13 @@ static __u8 nsc_ircc_change_speed(struct
 	     FCR_RXSR|     /* Reset Rx FIFO */
 	     FCR_FIFO_EN,  /* Enable FIFOs */
 	     iobase+FCR);
-	
+
 	/* Set FIFO size to 32 */
 	switch_bank(iobase, BANK2);
 	outb(EXCR2_RFSIZ|EXCR2_TFSIZ, iobase+EXCR2);
-	
+
 	/* Enable some interrupts so we can receive frames */
-	switch_bank(iobase, BANK0); 
+	switch_bank(iobase, BANK0);
 	if (speed > 115200) {
 		/* Install FIR xmit handler */
 		dev->hard_start_xmit = nsc_ircc_hard_xmit_fir;
@@ -1174,7 +1174,7 @@ static __u8 nsc_ircc_change_speed(struct
 	}
 	/* Set our current interrupt mask */
 	outb(ier, iobase+IER);
-    	
+
 	/* Restore BSR */
 	outb(bank, iobase+BSR);
 
@@ -1195,7 +1195,7 @@ static int nsc_ircc_hard_xmit_sir(struct
 	int iobase;
 	__s32 speed;
 	__u8 bank;
-	
+
 	self = (struct nsc_ircc_cb *) dev->priv;
 
 	IRDA_ASSERT(self != NULL, return 0;);
@@ -1203,10 +1203,10 @@ static int nsc_ircc_hard_xmit_sir(struct
 	iobase = self->io.fir_base;
 
 	netif_stop_queue(dev);
-		
+
 	/* Make sure tests *& speed change are atomic */
 	spin_lock_irqsave(&self->lock, flags);
-	
+
 	/* Check if we need to change the speed */
 	speed = irda_get_next_speed(skb);
 	if ((speed != self->io.speed) && (speed != -1)) {
@@ -1217,7 +1217,7 @@ static int nsc_ircc_hard_xmit_sir(struct
 			 * If this is the case, let interrupt handler change
 			 * the speed itself... Jean II */
 			if (self->io.direction == IO_RECV) {
-				nsc_ircc_change_speed(self, speed); 
+				nsc_ircc_change_speed(self, speed);
 				/* TODO : For SIR->SIR, the next packet
 				 * may get corrupted - Jean II */
 				netif_wake_queue(dev);
@@ -1237,18 +1237,18 @@ static int nsc_ircc_hard_xmit_sir(struct
 
 	/* Save current bank */
 	bank = inb(iobase+BSR);
-	
+
 	self->tx_buff.data = self->tx_buff.head;
-	
-	self->tx_buff.len = async_wrap_skb(skb, self->tx_buff.data, 
+
+	self->tx_buff.len = async_wrap_skb(skb, self->tx_buff.data,
 					   self->tx_buff.truesize);
 
 	self->stats.tx_bytes += self->tx_buff.len;
-	
+
 	/* Add interrupt on tx low level (will fire immediately) */
 	switch_bank(iobase, BANK0);
 	outb(IER_TXLDL_IE, iobase+IER);
-	
+
 	/* Restore bank register */
 	outb(bank, iobase+BSR);
 
@@ -1268,12 +1268,12 @@ static int nsc_ircc_hard_xmit_fir(struct
 	__s32 speed;
 	__u8 bank;
 	int mtt, diff;
-	
+
 	self = (struct nsc_ircc_cb *) dev->priv;
 	iobase = self->io.fir_base;
 
 	netif_stop_queue(dev);
-	
+
 	/* Make sure tests *& speed change are atomic */
 	spin_lock_irqsave(&self->lock, flags);
 
@@ -1285,7 +1285,7 @@ static int nsc_ircc_hard_xmit_fir(struct
 			/* If we are currently transmitting, defer to
 			 * interrupt handler. - Jean II */
 			if(self->tx_fifo.len == 0) {
-				nsc_ircc_change_speed(self, speed); 
+				nsc_ircc_change_speed(self, speed);
 				netif_wake_queue(dev);
 			} else {
 				self->new_speed = speed;
@@ -1317,9 +1317,9 @@ static int nsc_ircc_hard_xmit_fir(struct
 
 	self->stats.tx_bytes += skb->len;
 
-	memcpy(self->tx_fifo.queue[self->tx_fifo.free].start, skb->data, 
+	memcpy(self->tx_fifo.queue[self->tx_fifo.free].start, skb->data,
 	       skb->len);
-	
+
 	self->tx_fifo.len++;
 	self->tx_fifo.free++;
 
@@ -1331,16 +1331,16 @@ static int nsc_ircc_hard_xmit_fir(struct
 			/* Check how much time we have used already */
 			do_gettimeofday(&self->now);
 			diff = self->now.tv_usec - self->stamp.tv_usec;
-			if (diff < 0) 
+			if (diff < 0)
 				diff += 1000000;
-			
+
 			/* Check if the mtt is larger than the time we have
 			 * already used by all the protocol processing
 			 */
 			if (mtt > diff) {
 				mtt -= diff;
 
-				/* 
+				/*
 				 * Use timer if delay larger than 125 us, and
 				 * use udelay for smaller values which should
 				 * be acceptable
@@ -1348,26 +1348,26 @@ static int nsc_ircc_hard_xmit_fir(struct
 				if (mtt > 125) {
 					/* Adjust for timer resolution */
 					mtt = mtt / 125;
-					
+
 					/* Setup timer */
 					switch_bank(iobase, BANK4);
 					outb(mtt & 0xff, iobase+TMRL);
 					outb((mtt >> 8) & 0x0f, iobase+TMRH);
-					
+
 					/* Start timer */
 					outb(IRCR1_TMR_EN, iobase+IRCR1);
 					self->io.direction = IO_XMIT;
-					
+
 					/* Enable timer interrupt */
 					switch_bank(iobase, BANK0);
 					outb(IER_TMR_IE, iobase+IER);
-					
+
 					/* Timer will take care of the rest */
-					goto out; 
+					goto out;
 				} else
 					udelay(mtt);
 			}
-		}		
+		}
 		/* Enable DMA interrupt */
 		switch_bank(iobase, BANK0);
 		outb(IER_DMA_IE, iobase+IER);
@@ -1407,21 +1407,21 @@ static void nsc_ircc_dma_xmit(struct nsc
 	/* Disable DMA */
 	switch_bank(iobase, BANK0);
 	outb(inb(iobase+MCR) & ~MCR_DMA_EN, iobase+MCR);
-	
+
 	self->io.direction = IO_XMIT;
-	
-	/* Choose transmit DMA channel  */ 
+
+	/* Choose transmit DMA channel */
 	switch_bank(iobase, BANK2);
 	outb(ECR1_DMASWP|ECR1_DMANF|ECR1_EXT_SL, iobase+ECR1);
-	
-	irda_setup_dma(self->io.dma, 
+
+	irda_setup_dma(self->io.dma,
 		       ((u8 *)self->tx_fifo.queue[self->tx_fifo.ptr].start -
 			self->tx_buff.head) + self->tx_buff_dma,
-		       self->tx_fifo.queue[self->tx_fifo.ptr].len, 
+		       self->tx_fifo.queue[self->tx_fifo.ptr].len,
 		       DMA_TX_MODE);
 
 	/* Enable DMA and SIR interaction pulse */
- 	switch_bank(iobase, BANK0);	
+	switch_bank(iobase, BANK0);
 	outb(inb(iobase+MCR)|MCR_TX_DFR|MCR_DMA_EN|MCR_IR_PLS, iobase+MCR);
 
 	/* Restore bank register */
@@ -1439,7 +1439,7 @@ static int nsc_ircc_pio_write(int iobase
 {
 	int actual = 0;
 	__u8 bank;
-	
+
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	/* Save current bank */
@@ -1459,10 +1459,10 @@ static int nsc_ircc_pio_write(int iobase
 		/* Transmit next byte */
 		outb(buf[actual++], iobase+TXD);
 	}
-        
-	IRDA_DEBUG(4, "%s(), fifo_size %d ; %d sent of %d\n", 
+
+	IRDA_DEBUG(4, "%s(), fifo_size %d ; %d sent of %d\n",
 		   __FUNCTION__, fifo_size, actual, len);
-	
+
 	/* Restore bank */
 	outb(bank, iobase+BSR);
 
@@ -1472,7 +1472,7 @@ static int nsc_ircc_pio_write(int iobase
 /*
  * Function nsc_ircc_dma_xmit_complete (self)
  *
- *    The transfer of a frame in finished. This function will only be called 
+ *    The transfer of a frame in finished. This function will only be called
  *    by the interrupt handler
  *
  */
@@ -1492,12 +1492,12 @@ static int nsc_ircc_dma_xmit_complete(st
 	/* Disable DMA */
 	switch_bank(iobase, BANK0);
         outb(inb(iobase+MCR) & ~MCR_DMA_EN, iobase+MCR);
-	
+
 	/* Check for underrrun! */
 	if (inb(iobase+ASCR) & ASCR_TXUR) {
 		self->stats.tx_errors++;
 		self->stats.tx_fifo_errors++;
-		
+
 		/* Clear bit, by writing 1 into it */
 		outb(ASCR_TXUR, iobase+ASCR);
 	} else {
@@ -1511,7 +1511,7 @@ static int nsc_ircc_dma_xmit_complete(st
 	/* Any frames to be sent back-to-back? */
 	if (self->tx_fifo.len) {
 		nsc_ircc_dma_xmit(self, iobase);
-		
+
 		/* Not finished yet! */
 		ret = FALSE;
 	} else {
@@ -1530,7 +1530,7 @@ static int nsc_ircc_dma_xmit_complete(st
 
 	/* Restore bank */
 	outb(bank, iobase+BSR);
-	
+
 	return ret;
 }
 
@@ -1541,7 +1541,7 @@ static int nsc_ircc_dma_xmit_complete(st
  *    if it starts to receive a frame.
  *
  */
-static int nsc_ircc_dma_receive(struct nsc_ircc_cb *self) 
+static int nsc_ircc_dma_receive(struct nsc_ircc_cb *self)
 {
 	int iobase;
 	__u8 bsr;
@@ -1565,14 +1565,14 @@ static int nsc_ircc_dma_receive(struct n
 
 	self->io.direction = IO_RECV;
 	self->rx_buff.data = self->rx_buff.head;
-	
+
 	/* Reset Rx FIFO. This will also flush the ST_FIFO */
 	switch_bank(iobase, BANK0);
 	outb(FCR_RXSR|FCR_FIFO_EN, iobase+FCR);
 
 	self->st_fifo.len = self->st_fifo.pending_bytes = 0;
 	self->st_fifo.tail = self->st_fifo.head = 0;
-	
+
 	irda_setup_dma(self->io.dma, self->rx_buff_dma, self->rx_buff.truesize,
 		       DMA_RX_MODE);
 
@@ -1582,7 +1582,7 @@ static int nsc_ircc_dma_receive(struct n
 
 	/* Restore bank register */
 	outb(bsr, iobase+BSR);
-	
+
 	return 0;
 }
 
@@ -1591,7 +1591,7 @@ static int nsc_ircc_dma_receive(struct n
  *
  *    Finished with receiving frames
  *
- *    
+ *
  */
 static int nsc_ircc_dma_receive_complete(struct nsc_ircc_cb *self, int iobase)
 {
@@ -1605,7 +1605,7 @@ static int nsc_ircc_dma_receive_complete
 
 	/* Save current bank */
 	bank = inb(iobase+BSR);
-	
+
 	/* Read all entries in status FIFO */
 	switch_bank(iobase, BANK5);
 	while ((status = inb(iobase+FRM_ST)) & FRM_ST_VLD) {
@@ -1616,7 +1616,7 @@ static int nsc_ircc_dma_receive_complete
 			IRDA_DEBUG(0, "%s(), window is full!\n", __FUNCTION__);
 			continue;
 		}
-			
+
 		st_fifo->entries[st_fifo->tail].status = status;
 		st_fifo->entries[st_fifo->tail].len = len;
 		st_fifo->pending_bytes += len;
@@ -1636,35 +1636,35 @@ static int nsc_ircc_dma_receive_complete
 		if (status & FRM_ST_ERR_MSK) {
 			if (status & FRM_ST_LOST_FR) {
 				/* Add number of lost frames to stats */
-				self->stats.rx_errors += len;	
+				self->stats.rx_errors += len;
 			} else {
 				/* Skip frame */
 				self->stats.rx_errors++;
-				
+
 				self->rx_buff.data += len;
-			
+
 				if (status & FRM_ST_MAX_LEN)
 					self->stats.rx_length_errors++;
-				
-				if (status & FRM_ST_PHY_ERR) 
+
+				if (status & FRM_ST_PHY_ERR)
 					self->stats.rx_frame_errors++;
-				
-				if (status & FRM_ST_BAD_CRC) 
+
+				if (status & FRM_ST_BAD_CRC)
 					self->stats.rx_crc_errors++;
 			}
 			/* The errors below can be reported in both cases */
 			if (status & FRM_ST_OVR1)
-				self->stats.rx_fifo_errors++;		       
-			
+				self->stats.rx_fifo_errors++;
+
 			if (status & FRM_ST_OVR2)
 				self->stats.rx_fifo_errors++;
 		} else {
-			/*  
+			/*
 			 * First we must make sure that the frame we
 			 * want to deliver is all in main memory. If we
 			 * cannot tell, then we check if the Rx FIFO is
 			 * empty. If not then we will have to take a nap
-			 * and try again later.  
+			 * and try again later.
 			 */
 			if (st_fifo->pending_bytes < self->io.fifo_size) {
 				switch_bank(iobase, BANK0);
@@ -1675,10 +1675,10 @@ static int nsc_ircc_dma_receive_complete
 					st_fifo->pending_bytes += len;
 					st_fifo->entries[st_fifo->head].status = status;
 					st_fifo->entries[st_fifo->head].len = len;
-					/*  
-					 * DMA not finished yet, so try again 
-					 * later, set timer value, resolution 
-					 * 125 us 
+					/*
+					 * DMA not finished yet, so try again
+					 * later, set timer value, resolution
+					 * 125 us
 					 */
 					switch_bank(iobase, BANK4);
 					outb(0x02, iobase+TMRL); /* x 125 us */
@@ -1689,12 +1689,12 @@ static int nsc_ircc_dma_receive_complete
 
 					/* Restore bank register */
 					outb(bank, iobase+BSR);
-					
+
 					return FALSE; /* I'll be back! */
 				}
 			}
 
-			/* 
+			/*
 			 * Remember the time we received this frame, so we can
 			 * reduce the min turn time a bit since we will know
 			 * how much time we have used for protocol processing
@@ -1713,9 +1713,9 @@ static int nsc_ircc_dma_receive_complete
 
 				return FALSE;
 			}
-			
+
 			/* Make sure IP header gets aligned */
-			skb_reserve(skb, 1); 
+			skb_reserve(skb, 1);
 
 			/* Copy frame without CRC */
 			if (self->io.speed < 4000000) {
@@ -1750,19 +1750,19 @@ static int nsc_ircc_dma_receive_complete
  *    Receive all data in receiver FIFO
  *
  */
-static void nsc_ircc_pio_receive(struct nsc_ircc_cb *self) 
+static void nsc_ircc_pio_receive(struct nsc_ircc_cb *self)
 {
 	__u8 byte;
 	int iobase;
 
 	iobase = self->io.fir_base;
-	
+
 	/*  Receive all characters in Rx FIFO */
 	do {
 		byte = inb(iobase+RXD);
-		async_unwrap_char(self->netdev, &self->stats, &self->rx_buff, 
+		async_unwrap_char(self->netdev, &self->stats, &self->rx_buff,
 				  byte);
-	} while (inb(iobase+LSR) & LSR_RXDA); /* Data available */	
+	} while (inb(iobase+LSR) & LSR_RXDA); /* Data available */
 }
 
 /*
@@ -1778,25 +1778,25 @@ static void nsc_ircc_sir_interrupt(struc
 	/* Check if transmit FIFO is low on data */
 	if (eir & EIR_TXLDL_EV) {
 		/* Write data left in transmit buffer */
-		actual = nsc_ircc_pio_write(self->io.fir_base, 
-					   self->tx_buff.data, 
-					   self->tx_buff.len, 
+		actual = nsc_ircc_pio_write(self->io.fir_base,
+					   self->tx_buff.data,
+					   self->tx_buff.len,
 					   self->io.fifo_size);
 		self->tx_buff.data += actual;
 		self->tx_buff.len  -= actual;
-		
+
 		self->io.direction = IO_XMIT;
 
 		/* Check if finished */
 		if (self->tx_buff.len > 0)
 			self->ier = IER_TXLDL_IE;
-		else { 
+		else {
 
 			self->stats.tx_packets++;
 			netif_wake_queue(self->netdev);
 			self->ier = IER_TXEMP_IE;
 		}
-			
+
 	}
 	/* Check if transmission has completed */
 	if (eir & EIR_TXEMP_EV) {
@@ -1836,13 +1836,13 @@ static void nsc_ircc_sir_interrupt(struc
  *    Handle MIR/FIR interrupt
  *
  */
-static void nsc_ircc_fir_interrupt(struct nsc_ircc_cb *self, int iobase, 
+static void nsc_ircc_fir_interrupt(struct nsc_ircc_cb *self, int iobase,
 				   int eir)
 {
 	__u8 bank;
 
 	bank = inb(iobase+BSR);
-	
+
 	/* Status FIFO event*/
 	if (eir & EIR_SFIF_EV) {
 		/* Check if DMA has finished */
@@ -1932,18 +1932,18 @@ static irqreturn_t nsc_ircc_interrupt(in
 	}
 	self = (struct nsc_ircc_cb *) dev->priv;
 
-	spin_lock(&self->lock);	
+	spin_lock(&self->lock);
 
 	iobase = self->io.fir_base;
 
-	bsr = inb(iobase+BSR); 	/* Save current bank */
+	bsr = inb(iobase+BSR);	/* Save current bank */
 
-	switch_bank(iobase, BANK0);	
-	self->ier = inb(iobase+IER); 
-	eir = inb(iobase+EIR) & self->ier; /* Mask out the interesting ones */ 
+	switch_bank(iobase, BANK0);
+	self->ier = inb(iobase+IER);
+	eir = inb(iobase+EIR) & self->ier; /* Mask out the interesting ones */
 
 	outb(0, iobase+IER); /* Disable interrupts */
-	
+
 	if (eir) {
 		/* Dispatch interrupt handler for the current speed */
 		if (self->io.speed > 115200)
@@ -1951,7 +1951,7 @@ static irqreturn_t nsc_ircc_interrupt(in
 		else
 			nsc_ircc_sir_interrupt(self, eir);
 	}
-	
+
 	outb(self->ier, iobase+IER); /* Restore interrupts */
 	outb(bsr, iobase+BSR);       /* Restore bank register */
 
@@ -1987,9 +1987,9 @@ static int nsc_ircc_is_receiving(struct 
 			status =  TRUE;
 		}
 		outb(bank, iobase+BSR);
-	} else 
+	} else
 		status = (self->rx_buff.state != OUTSIDE_FRAME);
-	
+
 	spin_unlock_irqrestore(&self->lock, flags);
 
 	return status;
@@ -2007,23 +2007,23 @@ static int nsc_ircc_net_open(struct net_
 	int iobase;
 	char hwname[32];
 	__u8 bank;
-	
+
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
-	
+
 	IRDA_ASSERT(dev != NULL, return -1;);
 	self = (struct nsc_ircc_cb *) dev->priv;
-	
+
 	IRDA_ASSERT(self != NULL, return 0;);
-	
+
 	iobase = self->io.fir_base;
-	
+
 	if (request_irq(self->io.irq, nsc_ircc_interrupt, 0, dev->name, dev)) {
 		IRDA_WARNING("%s, unable to allocate irq=%d\n",
 			     driver_name, self->io.irq);
 		return -EAGAIN;
 	}
 	/*
-	 * Always allocate the DMA channel after the IRQ, and clean up on 
+	 * Always allocate the DMA channel after the IRQ, and clean up on
 	 * failure.
 	 */
 	if (request_dma(self->io.dma, dev->name)) {
@@ -2032,10 +2032,10 @@ static int nsc_ircc_net_open(struct net_
 		free_irq(self->io.irq, dev);
 		return -EAGAIN;
 	}
-	
+
 	/* Save current bank */
 	bank = inb(iobase+BSR);
-	
+
 	/* turn on interrupts */
 	switch_bank(iobase, BANK0);
 	outb(IER_LS_IE | IER_RXHDL_IE, iobase+IER);
@@ -2045,13 +2045,13 @@ static int nsc_ircc_net_open(struct net_
 
 	/* Ready to play! */
 	netif_start_queue(dev);
-	
+
 	/* Give self a hardware name */
 	sprintf(hwname, "NSC-FIR @ 0x%03x", self->io.fir_base);
 
-	/* 
+	/*
 	 * Open new IrLAP layer instance, now that everything should be
-	 * initialized properly 
+	 * initialized properly
 	 */
 	self->irlap = irlap_open(dev, &self->qos, hwname);
 
@@ -2071,7 +2071,7 @@ static int nsc_ircc_net_close(struct net
 	__u8 bank;
 
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
-	
+
 	IRDA_ASSERT(dev != NULL, return -1;);
 
 	self = (struct nsc_ircc_cb *) dev->priv;
@@ -2079,12 +2079,12 @@ static int nsc_ircc_net_close(struct net
 
 	/* Stop device */
 	netif_stop_queue(dev);
-	
+
 	/* Stop and remove instance of IrLAP */
 	if (self->irlap)
 		irlap_close(self->irlap);
 	self->irlap = NULL;
-	
+
 	iobase = self->io.fir_base;
 
 	disable_dma(self->io.dma);
@@ -2094,8 +2094,8 @@ static int nsc_ircc_net_close(struct net
 
 	/* Disable interrupts */
 	switch_bank(iobase, BANK0);
-	outb(0, iobase+IER); 
-       
+	outb(0, iobase+IER);
+
 	free_irq(self->io.irq, dev);
 	free_dma(self->io.dma);
 
@@ -2125,7 +2125,7 @@ static int nsc_ircc_net_ioctl(struct net
 	IRDA_ASSERT(self != NULL, return -1;);
 
 	IRDA_DEBUG(2, "%s(), %s, (cmd=0x%X)\n", __FUNCTION__, dev->name, cmd);
-	
+
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		if (!capable(CAP_NET_ADMIN)) {
@@ -2156,7 +2156,7 @@ static int nsc_ircc_net_ioctl(struct net
 static struct net_device_stats *nsc_ircc_net_get_stats(struct net_device *dev)
 {
 	struct nsc_ircc_cb *self = (struct nsc_ircc_cb *) dev->priv;
-	
+
 	return &self->stats;
 }
 
@@ -2179,7 +2179,7 @@ static void nsc_ircc_wakeup(struct nsc_i
 
 	nsc_ircc_setup(&self->io);
 	nsc_ircc_net_open(self->netdev);
-	
+
 	IRDA_MESSAGE("%s, Waking up\n", driver_name);
 
 	self->io.suspended = 0;
Index: work/drivers/net/irda/nsc-ircc.h
===================================================================
--- work.orig/drivers/net/irda/nsc-ircc.h
+++ work/drivers/net/irda/nsc-ircc.h
@@ -1,28 +1,28 @@
 /*********************************************************************
- *                
+ *
  * Filename:      nsc-ircc.h
- * Version:       
- * Description:   
+ * Version:
+ * Description:
  * Status:        Experimental.
  * Author:        Dag Brattli <dagb@cs.uit.no>
  * Created at:    Fri Nov 13 14:37:40 1998
  * Modified at:   Sun Jan 23 17:47:00 2000
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
- * 
+ *
  *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>
  *     Copyright (c) 1998 Lichen Wang, <lwang@actisys.com>
  *     Copyright (c) 1998 Actisys Corp., www.actisys.com
  *     All Rights Reserved
- *      
- *     This program is free software; you can redistribute it and/or 
- *     modify it under the terms of the GNU General Public License as 
- *     published by the Free Software Foundation; either version 2 of 
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
  *     the License, or (at your option) any later version.
- *  
+ *
  *     Neither Dag Brattli nor University of Tromsø admit liability nor
- *     provide warranty for any of this software. This material is 
+ *     provide warranty for any of this software. This material is
  *     provided "AS-IS" and at no charge.
- *     
+ *
  ********************************************************************/
 
 #ifndef NSC_IRCC_H
@@ -102,24 +102,24 @@
 #define LCR             0x03 /* Link control register */
 #define LCR_WLS_8       0x03 /* 8 bits */
 
-#define BSR 	        0x03 /* Bank select register */
+#define BSR	        0x03 /* Bank select register */
 #define BSR_BKSE        0x80
-#define BANK0 	        LCR_WLS_8 /* Must make sure that we set 8N1 */
+#define BANK0	        LCR_WLS_8 /* Must make sure that we set 8N1 */
 #define BANK1	        0x80
 #define BANK2	        0xe0
 #define BANK3	        0xe4
 #define BANK4	        0xe8
 #define BANK5	        0xec
 #define BANK6	        0xf0
-#define BANK7     	0xf4
+#define BANK7		0xf4
 
 #define MCR		0x04 /* Mode Control Register */
 #define MCR_MODE_MASK	~(0xd0)
 #define MCR_UART        0x00
-#define MCR_RESERVED  	0x20	
+#define MCR_RESERVED	0x20
 #define MCR_SHARP_IR    0x40
 #define MCR_SIR         0x60
-#define MCR_MIR  	0x80
+#define MCR_MIR		0x80
 #define MCR_FIR		0xa0
 #define MCR_CEIR        0xb0
 #define MCR_IR_PLS      0x10
@@ -182,7 +182,7 @@
 #define FRM_ST_LOST_FR  0x40 /* Frame lost */
 #define FRM_ST_MAX_LEN  0x10 /* Max frame len exceeded */
 #define FRM_ST_PHY_ERR  0x08 /* Physical layer error */
-#define FRM_ST_BAD_CRC  0x04 
+#define FRM_ST_BAD_CRC  0x04
 #define FRM_ST_OVR1     0x02 /* Rx FIFO overrun */
 #define FRM_ST_OVR2     0x01 /* Frame status FIFO overrun */
 
@@ -249,10 +249,10 @@ struct nsc_ircc_cb {
 
 	struct net_device *netdev;     /* Yes! we are some kind of netdevice */
 	struct net_device_stats stats;
-	
+
 	struct irlap_cb *irlap;    /* The link layer we are binded to */
 	struct qos_info qos;       /* QoS capabilities for this device */
-	
+
 	chipio_t io;               /* IrDA controller information */
 	iobuff_t tx_buff;          /* Transmit buffer */
 	iobuff_t rx_buff;          /* Receive buffer */
@@ -265,7 +265,7 @@ struct nsc_ircc_cb {
 	struct timeval now;
 
 	spinlock_t lock;           /* For serializing operations */
-	
+
 	__u32 new_speed;
 	int index;                 /* Instance index */
 

