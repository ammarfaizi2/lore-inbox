Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVEYGwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVEYGwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVEYGws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:52:48 -0400
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:39005 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262284AbVEYGke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:40:34 -0400
Message-Id: <20050525064005.562033000.dtor_core@ameritech.net>
References: <20050525063738.864916000.dtor_core@ameritech.net>
Date: Wed, 25 May 2005 01:37:39 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 1/9] smsc-ircc2: whitespace fixes
Content-Disposition: inline; filename=ircc2-whitespace.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRDA: smsc-ircc2 - whitespace fixes.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 smsc-ircc2.c |  384 +++++++++++++++++++++++++++++------------------------------
 smsc-ircc2.h |   50 +++----
 2 files changed, 217 insertions(+), 217 deletions(-)

Index: dtor/drivers/net/irda/smsc-ircc2.c
===================================================================
--- dtor.orig/drivers/net/irda/smsc-ircc2.c
+++ dtor/drivers/net/irda/smsc-ircc2.c
@@ -4,10 +4,10 @@
  * Description:   Driver for the SMC Infrared Communications Controller
  * Status:        Experimental.
  * Author:        Daniele Peri (peri@csai.unipa.it)
- * Created at:    
- * Modified at:   
- * Modified by:   
- * 
+ * Created at:
+ * Modified at:
+ * Modified by:
+ *
  *     Copyright (c) 2002      Daniele Peri
  *     All Rights Reserved.
  *     Copyright (c) 2002      Jean Tourrilhes
@@ -17,26 +17,26 @@
  *
  *     Copyright (c) 2001      Stefani Seibold
  *     Copyright (c) 1999-2001 Dag Brattli
- *     Copyright (c) 1998-1999 Thomas Davis, 
+ *     Copyright (c) 1998-1999 Thomas Davis,
  *
  *	and irport.c:
  *
  *     Copyright (c) 1997, 1998, 1999-2000 Dag Brattli, All Rights Reserved.
  *
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
  *     This program is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  *     GNU General Public License for more details.
- * 
- *     You should have received a copy of the GNU General Public License 
- *     along with this program; if not, write to the Free Software 
- *     Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
+ *
+ *     You should have received a copy of the GNU General Public License
+ *     along with this program; if not, write to the Free Software
+ *     Foundation, Inc., 59 Temple Place, Suite 330, Boston,
  *     MA 02111-1307 USA
  *
  ********************************************************************/
@@ -72,7 +72,7 @@
 
 struct smsc_transceiver {
 	char *name;
-	void (*set_for_speed)(int fir_base, u32 speed);	
+	void (*set_for_speed)(int fir_base, u32 speed);
 	int  (*probe)(int fir_base);
 };
 typedef struct smsc_transceiver smsc_transceiver_t;
@@ -109,7 +109,7 @@ struct smsc_ircc_cb {
 	struct net_device *netdev;     /* Yes! we are some kind of netdevice */
 	struct net_device_stats stats;
 	struct irlap_cb    *irlap; /* The link layer we are binded to */
-	
+
 	chipio_t io;               /* IrDA controller information */
 	iobuff_t tx_buff;          /* Transmit buffer */
 	iobuff_t rx_buff;          /* Receive buffer */
@@ -119,7 +119,7 @@ struct smsc_ircc_cb {
 	struct qos_info qos;       /* QoS capabilities for this device */
 
 	spinlock_t lock;           /* For serializing operations */
-	
+
 	__u32 new_speed;
 	__u32 flags;               /* Interface flags */
 
@@ -147,7 +147,7 @@ static void smsc_ircc_setup_io(struct sm
 static void smsc_ircc_setup_qos(struct smsc_ircc_cb *self);
 static void smsc_ircc_init_chip(struct smsc_ircc_cb *self);
 static int __exit smsc_ircc_close(struct smsc_ircc_cb *self);
-static int  smsc_ircc_dma_receive(struct smsc_ircc_cb *self, int iobase); 
+static int  smsc_ircc_dma_receive(struct smsc_ircc_cb *self, int iobase);
 static void smsc_ircc_dma_receive_complete(struct smsc_ircc_cb *self, int iobase);
 static void smsc_ircc_sir_receive(struct smsc_ircc_cb *self);
 static int  smsc_ircc_hard_xmit_sir(struct sk_buff *skb, struct net_device *dev);
@@ -332,7 +332,7 @@ static int __init smsc_ircc_init(void)
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
 	dev_count=0;
- 
+
 	if ((ircc_fir>0)&&(ircc_sir>0)) {
 		IRDA_MESSAGE(" Overriding FIR address 0x%04x\n", ircc_fir);
 		IRDA_MESSAGE(" Overriding SIR address 0x%04x\n", ircc_sir);
@@ -352,9 +352,9 @@ static int __init smsc_ircc_init(void)
 		if (!smsc_superio_lpc(ircc_cfg))
 			ret = 0;
 	}
-	
+
 	if(smsc_ircc_look_for_chips()>0) ret = 0;
-	
+
 	return ret;
 }
 
@@ -369,13 +369,13 @@ static int __init smsc_ircc_open(unsigne
 	struct smsc_ircc_cb *self;
 	struct net_device *dev;
 	int err;
-	
+
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
 	err = smsc_ircc_present(fir_base, sir_base);
-	if(err) 
+	if(err)
 		goto err_out;
-		
+
 	err = -ENOMEM;
 	if (dev_count > DIM(dev_self)) {
 	        IRDA_WARNING("%s(), too many devices!\n", __FUNCTION__);
@@ -402,7 +402,7 @@ static int __init smsc_ircc_open(unsigne
 	dev->stop            = smsc_ircc_net_close;
 	dev->do_ioctl        = smsc_ircc_net_ioctl;
 	dev->get_stats	     = smsc_ircc_net_get_stats;
-	
+
 	self = dev->priv;
 	self->netdev = dev;
 
@@ -414,7 +414,7 @@ static int __init smsc_ircc_open(unsigne
 	dev_self[dev_count++] = self;
 	spin_lock_init(&self->lock);
 
-	self->rx_buff.truesize = SMSC_IRCC2_RX_BUFF_TRUESIZE; 
+	self->rx_buff.truesize = SMSC_IRCC2_RX_BUFF_TRUESIZE;
 	self->tx_buff.truesize = SMSC_IRCC2_TX_BUFF_TRUESIZE;
 
 	self->rx_buff.head =
@@ -442,14 +442,14 @@ static int __init smsc_ircc_open(unsigne
 	self->rx_buff.state = OUTSIDE_FRAME;
 	self->tx_buff.data = self->tx_buff.head;
 	self->rx_buff.data = self->rx_buff.head;
-	   
+
 	smsc_ircc_setup_io(self, fir_base, sir_base, dma, irq);
 
 	smsc_ircc_setup_qos(self);
 
 	smsc_ircc_init_chip(self);
-	
-	if(ircc_transceiver > 0  && 
+
+	if(ircc_transceiver > 0  &&
 	   ircc_transceiver < SMSC_IRCC2_C_NUMBER_OF_TRANSCEIVERS)
 		self->transceiver = ircc_transceiver;
 	else
@@ -519,7 +519,7 @@ static int smsc_ircc_present(unsigned in
 	dma     = config & IRCC_INTERFACE_DMA_MASK;
 	irq     = (config & IRCC_INTERFACE_IRQ_MASK) >> 4;
 
-	if (high != 0x10 || low != 0xb8 || (chip != 0xf1 && chip != 0xf2)) { 
+	if (high != 0x10 || low != 0xb8 || (chip != 0xf1 && chip != 0xf2)) {
 	        IRDA_WARNING("%s(), addr 0x%04x - no device found!\n",
 			     __FUNCTION__, fir_base);
 		goto out3;
@@ -543,8 +543,8 @@ static int smsc_ircc_present(unsigned in
  *    Setup I/O
  *
  */
-static void smsc_ircc_setup_io(struct smsc_ircc_cb *self, 
-			       unsigned int fir_base, unsigned int sir_base, 
+static void smsc_ircc_setup_io(struct smsc_ircc_cb *self,
+			       unsigned int fir_base, unsigned int sir_base,
 			       u8 dma, u8 irq)
 {
 	unsigned char config, chip_dma, chip_irq;
@@ -569,7 +569,7 @@ static void smsc_ircc_setup_io(struct sm
 	}
 	else
 		self->io.irq = chip_irq;
-	
+
 	if (dma < 255) {
 		if (dma != chip_dma)
 			IRDA_MESSAGE("%s, Overriding DMA - chip says %d, using %d\n",
@@ -591,7 +591,7 @@ static void smsc_ircc_setup_qos(struct s
 {
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
-	
+
 	self->qos.baud_rate.bits = IR_9600|IR_19200|IR_38400|IR_57600|
 		IR_115200|IR_576000|IR_1152000|(IR_4000000 << 8);
 
@@ -608,8 +608,8 @@ static void smsc_ircc_setup_qos(struct s
  */
 static void smsc_ircc_init_chip(struct smsc_ircc_cb *self)
 {
-	int iobase, ir_mode, ctrl, fast; 
-	
+	int iobase, ir_mode, ctrl, fast;
+
 	IRDA_ASSERT( self != NULL, return; );
 	iobase = self->io.fir_base;
 
@@ -622,27 +622,27 @@ static void smsc_ircc_init_chip(struct s
 	outb(0x00, iobase+IRCC_MASTER);
 
 	register_bank(iobase, 1);
-	outb(((inb(iobase+IRCC_SCE_CFGA) & 0x87) | ir_mode), 
+	outb(((inb(iobase+IRCC_SCE_CFGA) & 0x87) | ir_mode),
 	     iobase+IRCC_SCE_CFGA);
 
 #ifdef smsc_669 /* Uses pin 88/89 for Rx/Tx */
-	outb(((inb(iobase+IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_COM), 
+	outb(((inb(iobase+IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_COM),
 	     iobase+IRCC_SCE_CFGB);
-#else	
+#else
 	outb(((inb(iobase+IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_IR),
 	     iobase+IRCC_SCE_CFGB);
-#endif	
+#endif
 	(void) inb(iobase+IRCC_FIFO_THRESHOLD);
 	outb(SMSC_IRCC2_FIFO_THRESHOLD, iobase+IRCC_FIFO_THRESHOLD);
-	
+
 	register_bank(iobase, 4);
 	outb((inb(iobase+IRCC_CONTROL) & 0x30) | ctrl, iobase+IRCC_CONTROL);
-	
+
 	register_bank(iobase, 0);
 	outb(fast, iobase+IRCC_LCR_A);
 
 	smsc_ircc_set_sir_speed(self, SMSC_IRCC2_C_IRDA_FALLBACK_SPEED);
-	
+
 	/* Power on device */
 	outb(0x00, iobase+IRCC_MASTER);
 }
@@ -667,7 +667,7 @@ static int smsc_ircc_net_ioctl(struct ne
 	IRDA_ASSERT(self != NULL, return -1;);
 
 	IRDA_DEBUG(2, "%s(), %s, (cmd=0x%X)\n", __FUNCTION__, dev->name, cmd);
-	
+
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		if (!capable(CAP_NET_ADMIN))
@@ -703,14 +703,14 @@ static int smsc_ircc_net_ioctl(struct ne
 	default:
 		ret = -EOPNOTSUPP;
 	}
-	
+
 	return ret;
 }
 
 static struct net_device_stats *smsc_ircc_net_get_stats(struct net_device *dev)
 {
 	struct smsc_ircc_cb *self = (struct smsc_ircc_cb *) dev->priv;
-	
+
 	return &self->stats;
 }
 
@@ -728,7 +728,7 @@ static void smsc_ircc_timeout(struct net
 	unsigned long flags;
 
 	self = (struct smsc_ircc_cb *) dev->priv;
-	
+
 	IRDA_WARNING("%s: transmit timed out, changing speed to: %d\n",
 		     dev->name, self->io.speed);
 	spin_lock_irqsave(&self->lock, flags);
@@ -757,14 +757,14 @@ int smsc_ircc_hard_xmit_sir(struct sk_bu
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
 	IRDA_ASSERT(dev != NULL, return 0;);
-	
+
 	self = (struct smsc_ircc_cb *) dev->priv;
 	IRDA_ASSERT(self != NULL, return 0;);
 
 	iobase = self->io.sir_base;
 
 	netif_stop_queue(dev);
-	
+
 	/* Make sure test of self->io.speed & speed change are atomic */
 	spin_lock_irqsave(&self->lock, flags);
 
@@ -796,18 +796,18 @@ int smsc_ircc_hard_xmit_sir(struct sk_bu
 	self->tx_buff.data = self->tx_buff.head;
 
 	/* Copy skb to tx_buff while wrapping, stuffing and making CRC */
-	self->tx_buff.len = async_wrap_skb(skb, self->tx_buff.data, 
+	self->tx_buff.len = async_wrap_skb(skb, self->tx_buff.data,
 					   self->tx_buff.truesize);
-	
+
 	self->stats.tx_bytes += self->tx_buff.len;
 
 	/* Turn on transmit finished interrupt. Will fire immediately!  */
-	outb(UART_IER_THRI, iobase+UART_IER); 
+	outb(UART_IER_THRI, iobase+UART_IER);
 
 	spin_unlock_irqrestore(&self->lock, flags);
 
 	dev_kfree_skb(skb);
-	
+
 	return 0;
 }
 
@@ -828,7 +828,7 @@ static void smsc_ircc_set_fir_speed(stru
 
 	switch(speed) {
 	default:
-	case 576000:		
+	case 576000:
 		ir_mode = IRCC_CFGA_IRDA_HDLC;
 		ctrl = IRCC_CRC;
 		fast = 0;
@@ -855,10 +855,10 @@ static void smsc_ircc_set_fir_speed(stru
 	register_bank(fir_base, 0);
 	outb((inb(fir_base+IRCC_LCR_A) &  0xbf) | fast, fir_base+IRCC_LCR_A);
 	#endif
-	
+
 	register_bank(fir_base, 1);
 	outb(((inb(fir_base+IRCC_SCE_CFGA) & IRCC_SCE_CFGA_BLOCK_CTRL_BITS_MASK) | ir_mode), fir_base+IRCC_SCE_CFGA);
-	
+
 	register_bank(fir_base, 4);
 	outb((inb(fir_base+IRCC_CONTROL) & 0x30) | ctrl, fir_base+IRCC_CONTROL);
 }
@@ -885,7 +885,7 @@ static void smsc_ircc_fir_start(struct s
 	/* Reset everything */
 
 	/* Install FIR transmit handler */
-	dev->hard_start_xmit = smsc_ircc_hard_xmit_fir;	
+	dev->hard_start_xmit = smsc_ircc_hard_xmit_fir;
 
 	/* Clear FIFO */
 	outb(inb(fir_base+IRCC_LCR_A)|IRCC_LCR_A_FIFO_RESET, fir_base+IRCC_LCR_A);
@@ -895,14 +895,14 @@ static void smsc_ircc_fir_start(struct s
 
 	register_bank(fir_base, 1);
 
-	/* Select the TX/RX interface */	
+	/* Select the TX/RX interface */
 #ifdef SMSC_669 /* Uses pin 88/89 for Rx/Tx */
-	outb(((inb(fir_base+IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_COM), 
+	outb(((inb(fir_base+IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_COM),
 	     fir_base+IRCC_SCE_CFGB);
-#else	
+#else
 	outb(((inb(fir_base+IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_IR),
 	     fir_base+IRCC_SCE_CFGB);
-#endif	
+#endif
 	(void) inb(fir_base+IRCC_FIFO_THRESHOLD);
 
 	/* Enable SCE interrupts */
@@ -923,12 +923,12 @@ static void smsc_ircc_fir_stop(struct sm
 	int fir_base;
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
-	
+
 	IRDA_ASSERT(self != NULL, return;);
 
 	fir_base = self->io.fir_base;
 	register_bank(fir_base, 0);
-	/*outb(IRCC_MASTER_RESET, fir_base+IRCC_MASTER);*/	
+	/*outb(IRCC_MASTER_RESET, fir_base+IRCC_MASTER);*/
 	outb(inb(fir_base+IRCC_LCR_B) & IRCC_LCR_B_SIP_ENABLE, fir_base+IRCC_LCR_B);
 }
 
@@ -947,7 +947,7 @@ static void smsc_ircc_change_speed(void 
 	struct net_device *dev;
 	int iobase;
 	int last_speed_was_sir;
-	
+
 	IRDA_DEBUG(0, "%s() changing speed to: %d\n", __FUNCTION__, speed);
 
 	IRDA_ASSERT(self != NULL, return;);
@@ -961,9 +961,9 @@ static void smsc_ircc_change_speed(void 
 	speed= 1152000;
 	self->io.speed = speed;
 	last_speed_was_sir = 0;
-	smsc_ircc_fir_start(self);	
+	smsc_ircc_fir_start(self);
 	#endif
-	
+
 	if(self->io.speed == 0)
 		smsc_ircc_sir_start(self);
 
@@ -974,17 +974,17 @@ static void smsc_ircc_change_speed(void 
 	if(self->io.speed != speed) smsc_ircc_set_transceiver_for_speed(self, speed);
 
 	self->io.speed = speed;
-	
+
 	if(speed <= SMSC_IRCC2_MAX_SIR_SPEED) {
 		if(!last_speed_was_sir) {
 			smsc_ircc_fir_stop(self);
 			smsc_ircc_sir_start(self);
 		}
-		smsc_ircc_set_sir_speed(self, speed); 
+		smsc_ircc_set_sir_speed(self, speed);
 	}
 	else {
 		if(last_speed_was_sir) {
-			#if SMSC_IRCC2_C_SIR_STOP		
+			#if SMSC_IRCC2_C_SIR_STOP
 			smsc_ircc_sir_stop(self);
 			#endif
 			smsc_ircc_fir_start(self);
@@ -994,13 +994,13 @@ static void smsc_ircc_change_speed(void 
 		#if 0
 		self->tx_buff.len = 10;
 		self->tx_buff.data = self->tx_buff.head;
-		
+
 		smsc_ircc_dma_xmit(self, iobase, 4000);
 		#endif
 		/* Be ready for incoming frames */
 		smsc_ircc_dma_receive(self, iobase);
 	}
-	
+
 	netif_wake_queue(dev);
 }
 
@@ -1013,7 +1013,7 @@ static void smsc_ircc_change_speed(void 
 void smsc_ircc_set_sir_speed(void *priv, __u32 speed)
 {
 	struct smsc_ircc_cb *self = (struct smsc_ircc_cb *) priv;
-	int iobase; 
+	int iobase;
 	int fcr;    /* FIFO control reg */
 	int lcr;    /* Line control reg */
 	int divisor;
@@ -1022,30 +1022,30 @@ void smsc_ircc_set_sir_speed(void *priv,
 
 	IRDA_ASSERT(self != NULL, return;);
 	iobase = self->io.sir_base;
-	
+
 	/* Update accounting for new speed */
 	self->io.speed = speed;
 
 	/* Turn off interrupts */
-	outb(0, iobase+UART_IER); 
+	outb(0, iobase+UART_IER);
 
 	divisor = SMSC_IRCC2_MAX_SIR_SPEED/speed;
-	
+
 	fcr = UART_FCR_ENABLE_FIFO;
 
-	/* 
+	/*
 	 * Use trigger level 1 to avoid 3 ms. timeout delay at 9600 bps, and
 	 * almost 1,7 ms at 19200 bps. At speeds above that we can just forget
-	 * about this timeout since it will always be fast enough. 
+	 * about this timeout since it will always be fast enough.
 	 */
 	if (self->io.speed < 38400)
 		fcr |= UART_FCR_TRIGGER_1;
-	else 
+	else
 		fcr |= UART_FCR_TRIGGER_14;
-        
+
 	/* IrDA ports use 8N1 */
 	lcr = UART_LCR_WLEN8;
-	
+
 	outb(UART_LCR_DLAB | lcr, iobase+UART_LCR); /* Set DLAB */
 	outb(divisor & 0xff,      iobase+UART_DLL); /* Set speed */
 	outb(divisor >> 8,	  iobase+UART_DLM);
@@ -1092,24 +1092,24 @@ static int smsc_ircc_hard_xmit_fir(struc
 			/* Note : you should make sure that speed changes
 			 * are not going to corrupt any outgoing frame.
 			 * Look at nsc-ircc for the gory details - Jean II */
-			smsc_ircc_change_speed(self, speed); 
+			smsc_ircc_change_speed(self, speed);
 			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;
 	}
-	
+
 	memcpy(self->tx_buff.head, skb->data, skb->len);
 
 	self->tx_buff.len = skb->len;
 	self->tx_buff.data = self->tx_buff.head;
-	
-	mtt = irda_get_mtt(skb);	
+
+	mtt = irda_get_mtt(skb);
 	if (mtt) {
 		int bofs;
 
-		/* 
+		/*
 		 * Compute how many BOFs (STA or PA's) we need to waste the
 		 * min turn time given the speed of the link.
 		 */
@@ -1145,7 +1145,7 @@ static void smsc_ircc_dma_xmit(struct sm
 	outb(0x00, iobase+IRCC_LCR_B);
 #endif
 	register_bank(iobase, 1);
-	outb(inb(iobase+IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE, 
+	outb(inb(iobase+IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
 	     iobase+IRCC_SCE_CFGB);
 
 	self->io.direction = IO_XMIT;
@@ -1161,7 +1161,7 @@ static void smsc_ircc_dma_xmit(struct sm
 	outb(self->tx_buff.len & 0xff, iobase+IRCC_TX_SIZE_LO);
 
 	/*outb(UART_MCR_OUT2, self->io.sir_base + UART_MCR);*/
-	
+
 	/* Enable burst mode chip Tx DMA */
 	register_bank(iobase, 1);
 	outb(inb(iobase+IRCC_SCE_CFGB) | IRCC_CFGB_DMA_ENABLE |
@@ -1176,7 +1176,7 @@ static void smsc_ircc_dma_xmit(struct sm
 	register_bank(iobase, 0);
 	outb(IRCC_IER_ACTIVE_FRAME | IRCC_IER_EOM, iobase+IRCC_IER);
 	outb(IRCC_MASTER_INT_EN, iobase+IRCC_MASTER);
-	
+
 	/* Enable transmit */
 	outb(IRCC_LCR_B_SCE_TRANSMIT | IRCC_LCR_B_SIP_ENABLE, iobase+IRCC_LCR_B);
 }
@@ -1184,7 +1184,7 @@ static void smsc_ircc_dma_xmit(struct sm
 /*
  * Function smsc_ircc_dma_xmit_complete (self)
  *
- *    The transfer of a frame in finished. This function will only be called 
+ *    The transfer of a frame in finished. This function will only be called
  *    by the interrupt handler
  *
  */
@@ -1217,7 +1217,7 @@ static void smsc_ircc_dma_xmit_complete(
 
 	/* Check if it's time to change the speed */
 	if (self->new_speed) {
-		smsc_ircc_change_speed(self, self->new_speed);		
+		smsc_ircc_change_speed(self, self->new_speed);
 		self->new_speed = 0;
 	}
 
@@ -1231,22 +1231,22 @@ static void smsc_ircc_dma_xmit_complete(
  *    if it starts to receive a frame.
  *
  */
-static int smsc_ircc_dma_receive(struct smsc_ircc_cb *self, int iobase) 
+static int smsc_ircc_dma_receive(struct smsc_ircc_cb *self, int iobase)
 {
 #if 0
 	/* Turn off chip DMA */
 	register_bank(iobase, 1);
-	outb(inb(iobase+IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE, 
+	outb(inb(iobase+IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
 	     iobase+IRCC_SCE_CFGB);
 #endif
-	
+
 	/* Disable Tx */
 	register_bank(iobase, 0);
 	outb(0x00, iobase+IRCC_LCR_B);
 
 	/* Turn off chip DMA */
 	register_bank(iobase, 1);
-	outb(inb(iobase+IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE, 
+	outb(inb(iobase+IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
 	     iobase+IRCC_SCE_CFGB);
 
 	self->io.direction = IO_RECV;
@@ -1263,7 +1263,7 @@ static int smsc_ircc_dma_receive(struct 
 
 	/* Enable burst mode chip Rx DMA */
 	register_bank(iobase, 1);
-	outb(inb(iobase+IRCC_SCE_CFGB) | IRCC_CFGB_DMA_ENABLE | 
+	outb(inb(iobase+IRCC_SCE_CFGB) | IRCC_CFGB_DMA_ENABLE |
 	     IRCC_CFGB_DMA_BURST, iobase+IRCC_SCE_CFGB);
 
 	/* Enable interrupt */
@@ -1274,9 +1274,9 @@ static int smsc_ircc_dma_receive(struct 
 
 	/* Enable receiver */
 	register_bank(iobase, 0);
-	outb(IRCC_LCR_B_SCE_RECEIVE | IRCC_LCR_B_SIP_ENABLE, 
+	outb(IRCC_LCR_B_SCE_RECEIVE | IRCC_LCR_B_SIP_ENABLE,
 	     iobase+IRCC_LCR_B);
-	
+
 	return 0;
 }
 
@@ -1290,9 +1290,9 @@ static void smsc_ircc_dma_receive_comple
 {
 	struct sk_buff *skb;
 	int len, msgcnt, lsr;
-	
+
 	register_bank(iobase, 0);
-	
+
 	IRDA_DEBUG(3, "%s\n", __FUNCTION__);
 #if 0
 	/* Disable Rx */
@@ -1309,8 +1309,8 @@ static void smsc_ircc_dma_receive_comple
 
 	len = self->rx_buff.truesize - get_dma_residue(self->io.dma);
 
-	/* Look for errors 
-	 */	
+	/* Look for errors
+	 */
 
 	if(lsr & (IRCC_LSR_FRAME_ERROR | IRCC_LSR_CRC_ERROR | IRCC_LSR_SIZE_ERROR)) {
 		self->stats.rx_errors++;
@@ -1337,9 +1337,9 @@ static void smsc_ircc_dma_receive_comple
 		IRDA_WARNING("%s(), memory squeeze, dropping frame.\n",
 			     __FUNCTION__);
 		return;
-	}			
+	}
 	/* Make sure IP header gets aligned */
-	skb_reserve(skb, 1); 
+	skb_reserve(skb, 1);
 
 	memcpy(skb_put(skb, len), self->rx_buff.data, len);
 	self->stats.rx_packets++;
@@ -1357,7 +1357,7 @@ static void smsc_ircc_dma_receive_comple
  *    Receive one frame from the infrared port
  *
  */
-static void smsc_ircc_sir_receive(struct smsc_ircc_cb *self) 
+static void smsc_ircc_sir_receive(struct smsc_ircc_cb *self)
 {
 	int boguscount = 0;
 	int iobase;
@@ -1366,12 +1366,12 @@ static void smsc_ircc_sir_receive(struct
 
 	iobase = self->io.sir_base;
 
-	/*  
-	 * Receive all characters in Rx FIFO, unwrap and unstuff them. 
-         * async_unwrap_char will deliver all found frames  
+	/*
+	 * Receive all characters in Rx FIFO, unwrap and unstuff them.
+         * async_unwrap_char will deliver all found frames
 	 */
 	do {
-		async_unwrap_char(self->netdev, &self->stats, &self->rx_buff, 
+		async_unwrap_char(self->netdev, &self->stats, &self->rx_buff,
 				  inb(iobase+UART_RX));
 
 		/* Make sure we don't stay here to long */
@@ -1379,7 +1379,7 @@ static void smsc_ircc_sir_receive(struct
 			IRDA_DEBUG(2, "%s(), breaking!\n", __FUNCTION__);
 			break;
 		}
-	} while (inb(iobase+UART_LSR) & UART_LSR_DR);	
+	} while (inb(iobase+UART_LSR) & UART_LSR_DR);
 }
 
 
@@ -1397,7 +1397,7 @@ static irqreturn_t smsc_ircc_interrupt(i
 	irqreturn_t ret = IRQ_NONE;
 
 	if (dev == NULL) {
-		printk(KERN_WARNING "%s: irq %d for unknown device.\n", 
+		printk(KERN_WARNING "%s: irq %d for unknown device.\n",
 		       driver_name, irq);
 		goto irq_ret;
 	}
@@ -1405,7 +1405,7 @@ static irqreturn_t smsc_ircc_interrupt(i
 	IRDA_ASSERT(self != NULL, return IRQ_NONE;);
 
 	/* Serialise the interrupt handler in various CPUs, stop Tx path */
-	spin_lock(&self->lock);	
+	spin_lock(&self->lock);
 
 	/* Check if we should use the SIR interrupt handler */
 	if (self->io.speed <=  SMSC_IRCC2_MAX_SIR_SPEED) {
@@ -1417,7 +1417,7 @@ static irqreturn_t smsc_ircc_interrupt(i
 
 	register_bank(iobase, 0);
 	iir = inb(iobase+IRCC_IIR);
-	if (iir == 0) 
+	if (iir == 0)
 		goto irq_ret_unlock;
 	ret = IRQ_HANDLED;
 
@@ -1425,7 +1425,7 @@ static irqreturn_t smsc_ircc_interrupt(i
 	outb(0, iobase+IRCC_IER);
 	lcra = inb(iobase+IRCC_LCR_A);
 	lsr = inb(iobase+IRCC_LSR);
-	
+
 	IRDA_DEBUG(2, "%s(), iir = 0x%02x\n", __FUNCTION__, iir);
 
 	if (iir & IRCC_IIR_EOM) {
@@ -1433,7 +1433,7 @@ static irqreturn_t smsc_ircc_interrupt(i
 			smsc_ircc_dma_receive_complete(self, iobase);
 		else
 			smsc_ircc_dma_xmit_complete(self, iobase);
-		
+
 		smsc_ircc_dma_receive(self, iobase);
 	}
 
@@ -1476,7 +1476,7 @@ static irqreturn_t smsc_ircc_interrupt_s
 		/* Clear interrupt */
 		lsr = inb(iobase+UART_LSR);
 
-		IRDA_DEBUG(4, "%s(), iir=%02x, lsr=%02x, iobase=%#x\n", 
+		IRDA_DEBUG(4, "%s(), iir=%02x, lsr=%02x, iobase=%#x\n",
 			    __FUNCTION__, iir, lsr, iobase);
 
 		switch (iir) {
@@ -1496,13 +1496,13 @@ static irqreturn_t smsc_ircc_interrupt_s
 			IRDA_DEBUG(0, "%s(), unhandled IIR=%#x\n",
 				   __FUNCTION__, iir);
 			break;
-		} 
-		
+		}
+
 		/* Make sure we don't stay here to long */
 		if (boguscount++ > 100)
 			break;
 
- 	        iir = inb(iobase + UART_IIR) & UART_IIR_ID;
+	        iir = inb(iobase + UART_IIR) & UART_IIR_ID;
 	}
 	/*spin_unlock(&self->lock);*/
 	return IRQ_HANDLED;
@@ -1529,7 +1529,7 @@ static int ircc_is_receiving(struct smsc
 		   get_dma_residue(self->io.dma));
 
 	status = (self->rx_buff.state != OUTSIDE_FRAME);
-	
+
 	return status;
 }
 #endif /* unused */
@@ -1549,14 +1549,14 @@ static int smsc_ircc_net_open(struct net
 	unsigned long flags;
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
-	
+
 	IRDA_ASSERT(dev != NULL, return -1;);
 	self = (struct smsc_ircc_cb *) dev->priv;
 	IRDA_ASSERT(self != NULL, return 0;);
-	
+
 	iobase = self->io.fir_base;
 
-	if (request_irq(self->io.irq, smsc_ircc_interrupt, 0, dev->name, 
+	if (request_irq(self->io.irq, smsc_ircc_interrupt, 0, dev->name,
 			(void *) dev)) {
 		IRDA_DEBUG(0, "%s(), unable to allocate irq=%d\n",
 			   __FUNCTION__, self->io.irq);
@@ -1568,14 +1568,14 @@ static int smsc_ircc_net_open(struct net
 	self->io.speed = 0;
 	smsc_ircc_change_speed(self, SMSC_IRCC2_C_IRDA_FALLBACK_SPEED);
 	spin_unlock_irqrestore(&self->lock, flags);
-	
+
 	/* Give self a hardware name */
 	/* It would be cool to offer the chip revision here - Jean II */
 	sprintf(hwname, "SMSC @ 0x%03x", self->io.fir_base);
 
-	/* 
+	/*
 	 * Open new IrLAP layer instance, now that everything should be
-	 * initialized properly 
+	 * initialized properly
 	 */
 	self->irlap = irlap_open(dev, &self->qos, hwname);
 
@@ -1590,7 +1590,7 @@ static int smsc_ircc_net_open(struct net
 			     __FUNCTION__, self->io.dma);
 		return -EAGAIN;
 	}
-	
+
 	netif_start_queue(dev);
 
 	return 0;
@@ -1608,16 +1608,16 @@ static int smsc_ircc_net_close(struct ne
 	int iobase;
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
-	
+
 	IRDA_ASSERT(dev != NULL, return -1;);
-	self = (struct smsc_ircc_cb *) dev->priv;	
+	self = (struct smsc_ircc_cb *) dev->priv;
 	IRDA_ASSERT(self != NULL, return 0;);
-	
+
 	iobase = self->io.fir_base;
 
 	/* Stop device */
 	netif_stop_queue(dev);
-	
+
 	/* Stop and remove instance of IrLAP */
 	if (self->irlap)
 		irlap_close(self->irlap);
@@ -1655,7 +1655,7 @@ static void smsc_ircc_wakeup(struct smsc
 	 * or give a good reason. - Jean II */
 
 	smsc_ircc_net_open(self->netdev);
-	
+
 	IRDA_MESSAGE("%s, Waking up\n", driver_name);
 }
 
@@ -1720,7 +1720,7 @@ static int __exit smsc_ircc_close(struct
 
 	release_region(self->io.fir_base, self->io.fir_ext);
 
-	IRDA_DEBUG(0, "%s(), releasing 0x%03x\n", __FUNCTION__, 
+	IRDA_DEBUG(0, "%s(), releasing 0x%03x\n", __FUNCTION__,
 		   self->io.sir_base);
 
 	release_region(self->io.sir_base, self->io.sir_ext);
@@ -1728,7 +1728,7 @@ static int __exit smsc_ircc_close(struct
 	if (self->tx_buff.head)
 		dma_free_coherent(NULL, self->tx_buff.truesize,
 				  self->tx_buff.head, self->tx_buff_dma);
-	
+
 	if (self->rx_buff.head)
 		dma_free_coherent(NULL, self->rx_buff.truesize,
 				  self->rx_buff.head, self->rx_buff_dma);
@@ -1763,9 +1763,9 @@ void smsc_ircc_sir_start(struct smsc_irc
 
 	IRDA_DEBUG(3, "%s\n", __FUNCTION__);
 
-	IRDA_ASSERT(self != NULL, return;);	
+	IRDA_ASSERT(self != NULL, return;);
 	dev= self->netdev;
-	IRDA_ASSERT(dev != NULL, return;);		
+	IRDA_ASSERT(dev != NULL, return;);
 	dev->hard_start_xmit = &smsc_ircc_hard_xmit_sir;
 
 	fir_base = self->io.fir_base;
@@ -1784,7 +1784,7 @@ void smsc_ircc_sir_start(struct smsc_irc
 	/* Initialize UART */
 	outb(UART_LCR_WLEN8, sir_base+UART_LCR);  /* Reset DLAB */
 	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), sir_base+UART_MCR);
-	
+
 	/* Turn on interrups */
 	outb(UART_IER_RLSI | UART_IER_RDI |UART_IER_THRI, sir_base+UART_IER);
 
@@ -1803,7 +1803,7 @@ void smsc_ircc_sir_stop(struct smsc_ircc
 
 	/* Reset UART */
 	outb(0, iobase+UART_MCR);
-	
+
 	/* Turn off interrupts */
 	outb(0, iobase+UART_IER);
 }
@@ -1831,16 +1831,16 @@ static void smsc_ircc_sir_write_wakeup(s
 	/* Finished with frame?  */
 	if (self->tx_buff.len > 0)  {
 		/* Write data left in transmit buffer */
-		actual = smsc_ircc_sir_write(iobase, self->io.fifo_size, 
+		actual = smsc_ircc_sir_write(iobase, self->io.fifo_size,
 				      self->tx_buff.data, self->tx_buff.len);
 		self->tx_buff.data += actual;
 		self->tx_buff.len  -= actual;
 	} else {
-	
+
 	/*if (self->tx_buff.len ==0)  {*/
-		
-		/* 
-		 *  Now serial buffer is almost free & we can start 
+
+		/*
+		 *  Now serial buffer is almost free & we can start
 		 *  transmission of another packet. But first we must check
 		 *  if we need to change the speed of the hardware
 		 */
@@ -1857,14 +1857,14 @@ static void smsc_ircc_sir_write_wakeup(s
 		self->stats.tx_packets++;
 
 		if(self->io.speed <= 115200) {
-		/* 
+		/*
 		 * Reset Rx FIFO to make sure that all reflected transmit data
 		 * is discarded. This is needed for half duplex operation
 		 */
 		fcr = UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR;
 		if (self->io.speed < 38400)
 			fcr |= UART_FCR_TRIGGER_1;
-		else 
+		else
 			fcr |= UART_FCR_TRIGGER_14;
 
 		outb(fcr, iobase+UART_FCR);
@@ -1884,13 +1884,13 @@ static void smsc_ircc_sir_write_wakeup(s
 static int smsc_ircc_sir_write(int iobase, int fifo_size, __u8 *buf, int len)
 {
 	int actual = 0;
-	
+
 	/* Tx FIFO should be empty! */
 	if (!(inb(iobase+UART_LSR) & UART_LSR_THRE)) {
 		IRDA_WARNING("%s(), failed, fifo not empty!\n", __FUNCTION__);
 		return 0;
 	}
-        
+
 	/* Fill FIFO with current frame */
 	while ((fifo_size-- > 0) && (actual < len)) {
 		/* Transmit next byte */
@@ -1921,10 +1921,10 @@ static int smsc_ircc_is_receiving(struct
 static void smsc_ircc_probe_transceiver(struct smsc_ircc_cb *self)
 {
 	unsigned int	i;
-	
+
 	IRDA_ASSERT(self != NULL, return;);
-	
-	for(i=0; smsc_transceivers[i].name!=NULL; i++) 
+
+	for(i=0; smsc_transceivers[i].name!=NULL; i++)
 		if((*smsc_transceivers[i].probe)(self->io.fir_base)) {
 			IRDA_MESSAGE(" %s transceiver found\n",
 				     smsc_transceivers[i].name);
@@ -1933,7 +1933,7 @@ static void smsc_ircc_probe_transceiver(
 		}
 	IRDA_MESSAGE("No transceiver found. Defaulting to %s\n",
 		     smsc_transceivers[SMSC_IRCC2_C_DEFAULT_TRANSCEIVER].name);
-			
+
 	self->transceiver= SMSC_IRCC2_C_DEFAULT_TRANSCEIVER;
 }
 
@@ -1947,7 +1947,7 @@ static void smsc_ircc_probe_transceiver(
 static void smsc_ircc_set_transceiver_for_speed(struct smsc_ircc_cb *self, u32 speed)
 {
 	unsigned int trx;
-	
+
 	trx = self->transceiver;
 	if(trx>0) (*smsc_transceivers[trx-1].set_for_speed)(self->io.fir_base, speed);
 }
@@ -1979,9 +1979,9 @@ static void smsc_ircc_sir_wait_hw_transm
 {
 	int iobase;
 	int count = SMSC_IRCC2_HW_TRANSMITTER_TIMEOUT_US;
-	
+
 	iobase = self->io.sir_base;
-	
+
 	/* Calibrated busy loop */
 	while((count-- > 0) && !(inb(iobase+UART_LSR) & UART_LSR_TEMT))
 		udelay(1);
@@ -2001,23 +2001,23 @@ static int __init smsc_ircc_look_for_chi
 	smsc_chip_address_t *address;
 	char	*type;
 	unsigned int cfg_base, found;
-	
+
 	found = 0;
 	address = possible_addresses;
-	
+
 	while(address->cfg_base){
 		cfg_base = address->cfg_base;
-		
+
 		/*printk(KERN_WARNING "%s(): probing: 0x%02x for: 0x%02x\n", __FUNCTION__, cfg_base, address->type);*/
-		
+
 		if( address->type & SMSCSIO_TYPE_FDC){
 			type = "FDC";
 			if((address->type) & SMSCSIO_TYPE_FLAT) {
 				if(!smsc_superio_flat(fdc_chips_flat,cfg_base, type)) found++;
 			}
 			if((address->type) & SMSCSIO_TYPE_PAGED) {
-				if(!smsc_superio_paged(fdc_chips_paged,cfg_base, type)) found++;		
-			}			
+				if(!smsc_superio_paged(fdc_chips_paged,cfg_base, type)) found++;
+			}
 		}
 		if( address->type & SMSCSIO_TYPE_LPC){
 			type = "LPC";
@@ -2025,13 +2025,13 @@ static int __init smsc_ircc_look_for_chi
 				if(!smsc_superio_flat(lpc_chips_flat,cfg_base,type)) found++;
 			}
 			if((address->type) & SMSCSIO_TYPE_PAGED) {
-				if(!smsc_superio_paged(lpc_chips_paged,cfg_base,"LPC")) found++;		
-			}			
+				if(!smsc_superio_paged(lpc_chips_paged,cfg_base,"LPC")) found++;
+			}
 		}
 		address++;
 	}
 	return found;
-} 
+}
 
 /*
  * Function smsc_superio_flat (chip, base, type)
@@ -2052,23 +2052,23 @@ static int __init smsc_superio_flat(cons
 
 	outb(SMSCSIOFLAT_UARTMODE0C_REG, cfgbase);
 	mode = inb(cfgbase+1);
-	
+
 	/*printk(KERN_WARNING "%s(): mode: 0x%02x\n", __FUNCTION__, mode);*/
-	
+
 	if(!(mode & SMSCSIOFLAT_UART2MODE_VAL_IRDA))
 		IRDA_WARNING("%s(): IrDA not enabled\n", __FUNCTION__);
 
 	outb(SMSCSIOFLAT_UART2BASEADDR_REG, cfgbase);
 	sirbase = inb(cfgbase+1) << 2;
 
-   	/* FIR iobase */
+	/* FIR iobase */
 	outb(SMSCSIOFLAT_FIRBASEADDR_REG, cfgbase);
 	firbase = inb(cfgbase+1) << 3;
 
 	/* DMA */
 	outb(SMSCSIOFLAT_FIRDMASELECT_REG, cfgbase);
 	dma = inb(cfgbase+1) & SMSCSIOFLAT_FIRDMASELECT_MASK;
-	
+
 	/* IRQ */
 	outb(SMSCSIOFLAT_UARTIRQSELECT_REG, cfgbase);
 	irq = inb(cfgbase+1) & SMSCSIOFLAT_UART2IRQSELECT_MASK;
@@ -2077,9 +2077,9 @@ static int __init smsc_superio_flat(cons
 
 	if (firbase) {
 		if (smsc_ircc_open(firbase, sirbase, dma, irq) == 0)
-			ret=0; 
+			ret=0;
 	}
-	
+
 	/* Exit configuration */
 	outb(SMSCSIO_CFGEXITKEY, cfgbase);
 
@@ -2096,22 +2096,22 @@ static int __init smsc_superio_paged(con
 {
 	unsigned short fir_io, sir_io;
 	int ret = -ENODEV;
-	
+
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
 	if (smsc_ircc_probe(cfg_base,0x20,chips,type)==NULL)
 		return ret;
-	
+
 	/* Select logical device (UART2) */
 	outb(0x07, cfg_base);
 	outb(0x05, cfg_base + 1);
-		
+
 	/* SIR iobase */
 	outb(0x60, cfg_base);
 	sir_io  = inb(cfg_base + 1) << 8;
 	outb(0x61, cfg_base);
 	sir_io |= inb(cfg_base + 1);
-		
+
 	/* Read FIR base */
 	outb(0x62, cfg_base);
 	fir_io = inb(cfg_base + 1) << 8;
@@ -2121,9 +2121,9 @@ static int __init smsc_superio_paged(con
 
 	if (fir_io) {
 		if (smsc_ircc_open(fir_io, sir_io, ircc_dma, ircc_irq) == 0)
-			ret=0; 
+			ret=0;
 	}
-	
+
 	/* Exit configuration */
 	outb(SMSCSIO_CFGEXITKEY, cfg_base);
 
@@ -2145,7 +2145,7 @@ static int __init smsc_access(unsigned s
 
 static const smsc_chip_t * __init smsc_ircc_probe(unsigned short cfg_base,u8 reg,const smsc_chip_t *chip,char *type)
 {
-	u8 devid,xdevid,rev; 
+	u8 devid,xdevid,rev;
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
@@ -2168,14 +2168,14 @@ static const smsc_chip_t * __init smsc_i
 	if (smsc_access(cfg_base,0x55))	/* send second key and check */
 		return NULL;
 	#endif
-	
+
 	/* probe device ID */
 
 	if (smsc_access(cfg_base,reg))
 		return NULL;
 
 	devid=inb(cfg_base+1);
-	
+
 	if (devid==0)			/* typical value for unused port */
 		return NULL;
 
@@ -2192,7 +2192,7 @@ static const smsc_chip_t * __init smsc_i
 	if (rev>=128)			/* i think this will make no sense */
 		return NULL;
 
-	if (devid==xdevid)		/* protection against false positives */        
+	if (devid==xdevid)		/* protection against false positives */
 		return NULL;
 
 	/* Check for expected device ID; are there others? */
@@ -2208,10 +2208,10 @@ static const smsc_chip_t * __init smsc_i
 	IRDA_MESSAGE("found SMC SuperIO Chip (devid=0x%02x rev=%02X base=0x%04x): %s%s\n",devid,rev,cfg_base,type,chip->name);
 
 	if (chip->rev>rev){
-		IRDA_MESSAGE("Revision higher than expected\n");	
+		IRDA_MESSAGE("Revision higher than expected\n");
 		return NULL;
 	}
-	
+
 	if (chip->flags&NoIRDA)
 		IRDA_MESSAGE("chipset does not support IRDA\n");
 
@@ -2270,10 +2270,10 @@ static void smsc_ircc_set_transceiver_sm
 {
 	unsigned long jiffies_now, jiffies_timeout;
 	u8	val;
-	
+
 	jiffies_now= jiffies;
 	jiffies_timeout= jiffies+SMSC_IRCC2_ATC_PROGRAMMING_TIMEOUT_JIFFIES;
-	
+
 	/* ATC */
 	register_bank(fir_base, 4);
 	outb((inb(fir_base+IRCC_ATC) & IRCC_ATC_MASK) |IRCC_ATC_nPROGREADY|IRCC_ATC_ENABLE, fir_base+IRCC_ATC);
@@ -2298,25 +2298,25 @@ static int smsc_ircc_probe_transceiver_s
 /*
  * Function smsc_ircc_set_transceiver_smsc_ircc_fast_pin_select(self, speed)
  *
- *    Set transceiver 
+ *    Set transceiver
  *
  */
 
 static void smsc_ircc_set_transceiver_smsc_ircc_fast_pin_select(int fir_base, u32 speed)
 {
 	u8	fast_mode;
-	
+
 	switch(speed)
 	{
 		default:
 		case 576000 :
-		fast_mode = 0; 
+		fast_mode = 0;
 		break;
 		case 1152000 :
 		case 4000000 :
 		fast_mode = IRCC_LCR_A_FAST;
 		break;
-		
+
 	}
 	register_bank(fir_base, 0);
 	outb((inb(fir_base+IRCC_LCR_A) &  0xbf) | fast_mode, fir_base+IRCC_LCR_A);
@@ -2325,7 +2325,7 @@ static void smsc_ircc_set_transceiver_sm
 /*
  * Function smsc_ircc_probe_transceiver_smsc_ircc_fast_pin_select(fir_base)
  *
- *    Probe transceiver 
+ *    Probe transceiver
  *
  */
 
@@ -2337,25 +2337,25 @@ static int smsc_ircc_probe_transceiver_s
 /*
  * Function smsc_ircc_set_transceiver_toshiba_sat1800(fir_base, speed)
  *
- *    Set transceiver 
+ *    Set transceiver
  *
  */
 
 static void smsc_ircc_set_transceiver_toshiba_sat1800(int fir_base, u32 speed)
 {
 	u8	fast_mode;
-	
+
 	switch(speed)
 	{
 		default:
 		case 576000 :
-		fast_mode = 0; 
+		fast_mode = 0;
 		break;
 		case 1152000 :
 		case 4000000 :
 		fast_mode = /*IRCC_LCR_A_FAST |*/ IRCC_LCR_A_GP_DATA;
 		break;
-		
+
 	}
 	/* This causes an interrupt */
 	register_bank(fir_base, 0);
@@ -2365,7 +2365,7 @@ static void smsc_ircc_set_transceiver_to
 /*
  * Function smsc_ircc_probe_transceiver_toshiba_sat1800(fir_base)
  *
- *    Probe transceiver 
+ *    Probe transceiver
  *
  */
 
Index: dtor/drivers/net/irda/smsc-ircc2.h
===================================================================
--- dtor.orig/drivers/net/irda/smsc-ircc2.h
+++ dtor/drivers/net/irda/smsc-ircc2.h
@@ -1,5 +1,5 @@
 /*********************************************************************
- * $Id: smsc-ircc2.h,v 1.12.2.1 2002/10/27 10:52:37 dip Exp $               
+ * $Id: smsc-ircc2.h,v 1.12.2.1 2002/10/27 10:52:37 dip Exp $
  *
  * Description:   Definitions for the SMC IrCC chipset
  * Status:        Experimental.
@@ -9,25 +9,25 @@
  *     All Rights Reserved.
  *
  * Based on smc-ircc.h:
- * 
+ *
  *     Copyright (c) 1999-2000, Dag Brattli <dagb@cs.uit.no>
  *     Copyright (c) 1998-1999, Thomas Davis (tadavis@jps.net>
  *     All Rights Reserved
  *
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
  *     This program is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  *     GNU General Public License for more details.
- * 
- *     You should have received a copy of the GNU General Public License 
- *     along with this program; if not, write to the Free Software 
- *     Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
+ *
+ *     You should have received a copy of the GNU General Public License
+ *     along with this program; if not, write to the Free Software
+ *     Foundation, Inc., 59 Temple Place, Suite 330, Boston,
  *     MA 02111-1307 USA
  *
  ********************************************************************/
@@ -112,10 +112,10 @@
 
 #define   IRCC_CFGA_COM				0x00
 #define		IRCC_SCE_CFGA_BLOCK_CTRL_BITS_MASK	0x87
-#define   	IRCC_CFGA_IRDA_SIR_A	0x08
-#define   	IRCC_CFGA_ASK_SIR		0x10
-#define   	IRCC_CFGA_IRDA_SIR_B	0x18
-#define   	IRCC_CFGA_IRDA_HDLC		0x20
+#define		IRCC_CFGA_IRDA_SIR_A	0x08
+#define		IRCC_CFGA_ASK_SIR		0x10
+#define		IRCC_CFGA_IRDA_SIR_B	0x18
+#define		IRCC_CFGA_IRDA_HDLC		0x20
 #define		IRCC_CFGA_IRDA_4PPM		0x28
 #define		IRCC_CFGA_CONSUMER		0x30
 #define		IRCC_CFGA_RAW_IR		0x38
@@ -130,7 +130,7 @@
 #define IRCC_CFGB_LPBCK_TX_CRC	   0x10
 #define IRCC_CFGB_NOWAIT	   0x08
 #define IRCC_CFGB_STRING_MOVE	   0x04
-#define IRCC_CFGB_DMA_BURST 	   0x02
+#define IRCC_CFGB_DMA_BURST	   0x02
 #define IRCC_CFGB_DMA_ENABLE	   0x01
 
 #define IRCC_CFGB_MUX_COM          0x00
@@ -141,11 +141,11 @@
 /* Register block 3 - Identification Registers! */
 #define IRCC_ID_HIGH	           0x00   /* 0x10 */
 #define IRCC_ID_LOW	           0x01   /* 0xB8 */
-#define IRCC_CHIP_ID 	           0x02   /* 0xF1 */
+#define IRCC_CHIP_ID	           0x02   /* 0xF1 */
 #define IRCC_VERSION	           0x03   /* 0x01 */
 #define IRCC_INTERFACE	           0x04   /* low 4 = DMA, high 4 = IRQ */
-#define 	IRCC_INTERFACE_DMA_MASK	0x0F   /* low 4 = DMA, high 4 = IRQ */
-#define 	IRCC_INTERFACE_IRQ_MASK	0xF0   /* low 4 = DMA, high 4 = IRQ */
+#define		IRCC_INTERFACE_DMA_MASK	0x0F   /* low 4 = DMA, high 4 = IRQ */
+#define		IRCC_INTERFACE_IRQ_MASK	0xF0   /* low 4 = DMA, high 4 = IRQ */
 
 /* Register block 4 - IrDA */
 #define IRCC_CONTROL               0x00
@@ -163,10 +163,10 @@
 
 /* Register block 5 - IrDA */
 #define IRCC_ATC					0x00
-#define 	IRCC_ATC_nPROGREADY		0x80
-#define 	IRCC_ATC_SPEED			0x40
-#define 	IRCC_ATC_ENABLE			0x20
-#define 	IRCC_ATC_MASK			0xE0
+#define		IRCC_ATC_nPROGREADY		0x80
+#define		IRCC_ATC_SPEED			0x40
+#define		IRCC_ATC_ENABLE			0x20
+#define		IRCC_ATC_MASK			0xE0
 
 
 #define IRCC_IRHALFDUPLEX_TIMEOUT	0x01
@@ -178,8 +178,8 @@
  */
 
 #define SMSC_IRCC2_MAX_SIR_SPEED		115200
-#define SMSC_IRCC2_FIR_CHIP_IO_EXTENT 	8
-#define SMSC_IRCC2_SIR_CHIP_IO_EXTENT 	8
+#define SMSC_IRCC2_FIR_CHIP_IO_EXTENT	8
+#define SMSC_IRCC2_SIR_CHIP_IO_EXTENT	8
 #define SMSC_IRCC2_FIFO_SIZE			16
 #define SMSC_IRCC2_FIFO_THRESHOLD		64
 /* Max DMA buffer size needed = (data_size + 6) * (window_size) + 6; */

