Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbTBYD3Q>; Mon, 24 Feb 2003 22:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTBYD2O>; Mon, 24 Feb 2003 22:28:14 -0500
Received: from [24.77.48.240] ([24.77.48.240]:28771 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S265424AbTBYD10>;
	Mon, 24 Feb 2003 22:27:26 -0500
Date: Mon, 24 Feb 2003 19:37:45 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302250337.h1P3bjW32731@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - transceiver
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling fixes for 2.5.63:

This patch fixes:
    tranceiver -> transceiver

Some function names had this misspelling (e.g. e100_reset_tranceiver)
and I changed them, but I haven't tested it.

Fixes 34 occurrences in all.

diff -ur 2.5.63a/arch/cris/drivers/ethernet.c 2.5.63b/arch/cris/drivers/ethernet.c
--- 2.5.63a/arch/cris/drivers/ethernet.c	Mon Feb 24 11:05:31 2003
+++ 2.5.63b/arch/cris/drivers/ethernet.c	Mon Feb 24 18:33:47 2003
@@ -236,7 +236,7 @@
 /* Network speed indication. */
 static struct timer_list speed_timer = TIMER_INITIALIZER(NULL, 0, 0);
 static struct timer_list clear_led_timer = TIMER_INITIALIZER(NULL, 0, 0);
-static int current_speed; /* Speed read from tranceiver */
+static int current_speed; /* Speed read from transceiver */
 static int current_speed_selection; /* Speed selected by user */
 static int led_next_time;
 static int led_active;
@@ -276,7 +276,7 @@
 static void e100_send_mdio_cmd(unsigned short cmd, int write_cmd);
 static void e100_send_mdio_bit(unsigned char bit);
 static unsigned char e100_receive_mdio_bit(void);
-static void e100_reset_tranceiver(void);
+static void e100_reset_transceiver(void);
 
 static void e100_clear_network_leds(unsigned long dummy);
 static void e100_set_network_leds(int active);
@@ -786,7 +786,7 @@
 }
 
 static void 
-e100_reset_tranceiver(void)
+e100_reset_transceiver(void)
 {
 	unsigned short cmd;
 	unsigned short data;
@@ -826,9 +826,9 @@
 	RESET_DMA(NETWORK_TX_DMA_NBR);
 	WAIT_DMA(NETWORK_TX_DMA_NBR);
 	
-	/* Reset the tranceiver. */
+	/* Reset the transceiver. */
 	
-	e100_reset_tranceiver();
+	e100_reset_transceiver();
 	
 	/* and get rid of the packet that never got an interrupt */
 	
diff -ur 2.5.63a/arch/cris/drivers/lpslave/e100lpslavenet.c 2.5.63b/arch/cris/drivers/lpslave/e100lpslavenet.c
--- 2.5.63a/arch/cris/drivers/lpslave/e100lpslavenet.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/arch/cris/drivers/lpslave/e100lpslavenet.c	Mon Feb 24 18:33:56 2003
@@ -129,7 +129,7 @@
 static void e100_hardware_send_packet(unsigned long hostcmd, char *buf, int length);
 static void update_rx_stats(struct net_device_stats *);
 static void update_tx_stats(struct net_device_stats *);
-static void e100_reset_tranceiver(void);
+static void e100_reset_transceiver(void);
 
 static void boot_slave(unsigned char *code);
 
@@ -528,7 +528,7 @@
 }
 
 static void 
-e100_reset_tranceiver(void)
+e100_reset_transceiver(void)
 {
   /* To do: Reboot and setup slave Etrax */
 }
@@ -554,9 +554,9 @@
 	RESET_DMA(4);
 	WAIT_DMA(4);
 	
-	/* Reset the tranceiver. */
+	/* Reset the transceiver. */
 	
-	e100_reset_tranceiver();
+	e100_reset_transceiver();
 	
 	/* and get rid of the packet that never got an interrupt */
 	
diff -ur 2.5.63a/arch/cris/drivers/serial.c 2.5.63b/arch/cris/drivers/serial.c
--- 2.5.63a/arch/cris/drivers/serial.c	Mon Feb 24 11:05:36 2003
+++ 2.5.63b/arch/cris/drivers/serial.c	Mon Feb 24 18:34:00 2003
@@ -2802,7 +2802,7 @@
 	info->tx_ctrl |= (0x80 | 0x40); /* Set bit 7 (txd) and 6 (tr_enable) */
 	info->port[REG_TR_CTRL] = info->tx_ctrl;
 
-	/* the DMA gets awfully confused if we toggle the tranceiver like this 
+	/* the DMA gets awfully confused if we toggle the transceiver like this 
 	 * so we need to reset it 
 	 */
 	*info->ocmdadr = 4;
diff -ur 2.5.63a/drivers/net/3c503.c 2.5.63b/drivers/net/3c503.c
--- 2.5.63a/drivers/net/3c503.c	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/drivers/net/3c503.c	Mon Feb 24 18:34:15 2003
@@ -693,7 +693,7 @@
 MODULE_PARM(xcvr, "1-" __MODULE_STRING(MAX_EL2_CARDS) "i");
 MODULE_PARM_DESC(io, "I/O base address(es)");
 MODULE_PARM_DESC(irq, "IRQ number(s) (assigned)");
-MODULE_PARM_DESC(xcvr, "tranceiver(s) (0=internal, 1=external)");
+MODULE_PARM_DESC(xcvr, "transceiver(s) (0=internal, 1=external)");
 MODULE_DESCRIPTION("3Com ISA EtherLink II, II/16 (3c503, 3c503/16) driver");
 MODULE_LICENSE("GPL");
 
diff -ur 2.5.63a/drivers/net/3c509.c 2.5.63b/drivers/net/3c509.c
--- 2.5.63a/drivers/net/3c509.c	Mon Feb 24 11:05:05 2003
+++ 2.5.63b/drivers/net/3c509.c	Mon Feb 24 18:34:19 2003
@@ -1139,7 +1139,7 @@
 	int ioaddr = dev->base_addr;
 	
 	EL3WINDOW(0);
-	/* obtain current tranceiver via WN4_MEDIA? */	
+	/* obtain current transceiver via WN4_MEDIA? */	
 	tmp = inw(ioaddr + WN0_ADDR_CONF);
 	ecmd->transceiver = XCVR_INTERNAL;
 	switch (tmp >> 14) {
@@ -1548,7 +1548,7 @@
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM_DESC(debug, "debug level (0-6)");
 MODULE_PARM_DESC(irq, "IRQ number(s) (assigned)");
-MODULE_PARM_DESC(xcvr,"tranceiver(s) (0=internal, 1=external)");
+MODULE_PARM_DESC(xcvr,"transceiver(s) (0=internal, 1=external)");
 MODULE_PARM_DESC(max_interrupt_work, "maximum events handled per interrupt");
 #ifdef __ISAPNP__
 MODULE_PARM(nopnp, "i");
diff -ur 2.5.63a/drivers/net/atp.c 2.5.63b/drivers/net/atp.c
--- 2.5.63a/drivers/net/atp.c	Mon Feb 24 11:06:02 2003
+++ 2.5.63b/drivers/net/atp.c	Mon Feb 24 18:34:22 2003
@@ -162,7 +162,7 @@
 MODULE_PARM_DESC(debug, "ATP debug level (0-7)");
 MODULE_PARM_DESC(io, "ATP I/O base address(es)");
 MODULE_PARM_DESC(irq, "ATP IRQ number(s)");
-MODULE_PARM_DESC(xcvr, "ATP tranceiver(s) (0=internal, 1=external)");
+MODULE_PARM_DESC(xcvr, "ATP transceiver(s) (0=internal, 1=external)");
 
 /* The number of low I/O ports used by the ethercard. */
 #define ETHERCARD_TOTAL_SIZE	3
diff -ur 2.5.63a/drivers/net/e2100.c 2.5.63b/drivers/net/e2100.c
--- 2.5.63a/drivers/net/e2100.c	Mon Feb 24 11:05:43 2003
+++ 2.5.63b/drivers/net/e2100.c	Mon Feb 24 18:34:25 2003
@@ -389,7 +389,7 @@
 MODULE_PARM_DESC(io, "I/O base address(es)");
 MODULE_PARM_DESC(irq, "IRQ number(s)");
 MODULE_PARM_DESC(mem, " memory base address(es)");
-MODULE_PARM_DESC(xcvr, "tranceiver(s) (0=internal, 1=external)");
+MODULE_PARM_DESC(xcvr, "transceiver(s) (0=internal, 1=external)");
 MODULE_DESCRIPTION("Cabletron E2100 ISA ethernet driver");
 MODULE_LICENSE("GPL");
 
diff -ur 2.5.63a/drivers/net/eepro100.c 2.5.63b/drivers/net/eepro100.c
--- 2.5.63a/drivers/net/eepro100.c	Mon Feb 24 11:05:36 2003
+++ 2.5.63b/drivers/net/eepro100.c	Mon Feb 24 18:34:28 2003
@@ -148,7 +148,7 @@
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(multicast_filter_limit, "i");
 MODULE_PARM_DESC(debug, "debug level (0-6)");
-MODULE_PARM_DESC(options, "Bits 0-3: tranceiver type, bit 4: full duplex, bit 5: 100Mbps");
+MODULE_PARM_DESC(options, "Bits 0-3: transceiver type, bit 4: full duplex, bit 5: 100Mbps");
 MODULE_PARM_DESC(full_duplex, "full duplex setting(s) (1)");
 MODULE_PARM_DESC(congenb, "Enable congestion control (1)");
 MODULE_PARM_DESC(txfifo, "Tx FIFO threshold in 4 byte units, (0-15)");
diff -ur 2.5.63a/drivers/net/tlan.c 2.5.63b/drivers/net/tlan.c
--- 2.5.63a/drivers/net/tlan.c	Mon Feb 24 11:05:09 2003
+++ 2.5.63b/drivers/net/tlan.c	Mon Feb 24 18:34:35 2003
@@ -2399,7 +2399,7 @@
 	 *		dev	A pointer to the device structure of the
 	 *			TLAN device having the PHYs to be detailed.
 	 *				
-	 *	This function prints the registers a PHY (aka tranceiver).
+	 *	This function prints the registers a PHY (aka transceiver).
 	 *
 	 ********************************************************************/
 
@@ -2515,7 +2515,7 @@
 
 	/* Wait for 50 ms and powerup
 	 * This is abitrary.  It is intended to make sure the
-	 * tranceiver settles.
+	 * transceiver settles.
 	 */
 	TLan_SetTimer( dev, (HZ/20), TLAN_TIMER_PHY_PUP );
 
@@ -2535,7 +2535,7 @@
 	TLan_MiiWriteReg( dev, priv->phy[priv->phyNum], MII_GEN_CTL, value );
 	TLan_MiiSync(dev->base_addr);
 	/* Wait for 500 ms and reset the
-	 * tranceiver.  The TLAN docs say both 50 ms and
+	 * transceiver.  The TLAN docs say both 50 ms and
 	 * 500 ms, so do the longer, just in case.
 	 */
 	TLan_SetTimer( dev, (HZ/20), TLAN_TIMER_PHY_RESET );
@@ -2650,7 +2650,7 @@
         	TLan_MiiWriteReg( dev, phy, TLAN_TLPHY_CTL, tctl );
 	}
 
-	/* Wait for 2 sec to give the tranceiver time
+	/* Wait for 2 sec to give the transceiver time
 	 * to establish link.
 	 */
 	TLan_SetTimer( dev, (4*HZ), TLAN_TIMER_FINISH_RESET );
diff -ur 2.5.63a/drivers/net/tulip/winbond-840.c 2.5.63b/drivers/net/tulip/winbond-840.c
--- 2.5.63a/drivers/net/tulip/winbond-840.c	Mon Feb 24 11:05:11 2003
+++ 2.5.63b/drivers/net/tulip/winbond-840.c	Mon Feb 24 18:34:39 2003
@@ -597,7 +597,7 @@
 #define mdio_delay(mdio_addr) readl(mdio_addr)
 
 /* Set iff a MII transceiver on any interface requires mdio preamble.
-   This only set with older tranceivers, so the extra
+   This only set with older transceivers, so the extra
    code size of a per-interface flag is not worthwhile. */
 static char mii_preamble_required = 1;
 
diff -ur 2.5.63a/drivers/net/tulip/xircom_cb.c 2.5.63b/drivers/net/tulip/xircom_cb.c
--- 2.5.63a/drivers/net/tulip/xircom_cb.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/drivers/net/tulip/xircom_cb.c	Mon Feb 24 18:34:56 2003
@@ -121,7 +121,7 @@
 static void investigate_read_descriptor(struct net_device *dev,struct xircom_private *card, int descnr, unsigned int bufferoffset);
 static void investigate_write_descriptor(struct net_device *dev, struct xircom_private *card, int descnr, unsigned int bufferoffset);
 static void read_mac_address(struct xircom_private *card);
-static void tranceiver_voodoo(struct xircom_private *card);
+static void transceiver_voodoo(struct xircom_private *card);
 static void initialize_card(struct xircom_private *card);
 static void trigger_transmit(struct xircom_private *card);
 static void trigger_receive(struct xircom_private *card);
@@ -301,7 +301,7 @@
 	
 	/* start the transmitter to get a heartbeat */
 	/* TODO: send 2 dummy packets here */
-	tranceiver_voodoo(private);
+	transceiver_voodoo(private);
 	
 	spin_lock_irqsave(&private->lock,flags);
 	  activate_transmitter(private);
@@ -1116,15 +1116,15 @@
 
 
 /*
- tranceiver_voodoo() enables the external UTP plug thingy.
+ transceiver_voodoo() enables the external UTP plug thingy.
  it's called voodoo as I stole this code and cannot cross-reference
  it with the specification.
  */
-static void tranceiver_voodoo(struct xircom_private *card)
+static void transceiver_voodoo(struct xircom_private *card)
 {
 	unsigned long flags;
 
-	enter("tranceiver_voodoo");
+	enter("transceiver_voodoo");
 
 	/* disable all powermanagement */
 	pci_write_config_dword(card->pdev, PCI_POWERMGMT, 0x0000);
@@ -1143,7 +1143,7 @@
         spin_unlock_irqrestore(&card->lock, flags);
 
 	netif_start_queue(card->dev);
-	leave("tranceiver_voodoo");
+	leave("transceiver_voodoo");
 }
 
 
diff -ur 2.5.63a/drivers/net/tulip/xircom_tulip_cb.c 2.5.63b/drivers/net/tulip/xircom_tulip_cb.c
--- 2.5.63a/drivers/net/tulip/xircom_tulip_cb.c	Mon Feb 24 11:05:10 2003
+++ 2.5.63b/drivers/net/tulip/xircom_tulip_cb.c	Mon Feb 24 18:35:04 2003
@@ -486,7 +486,7 @@
 
 /*
  * To quote Arjan van de Ven:
- *   tranceiver_voodoo() enables the external UTP plug thingy.
+ *   transceiver_voodoo() enables the external UTP plug thingy.
  *   it's called voodoo as I stole this code and cannot cross-reference
  *   it with the specification.
  * Actually it seems to go like this:
diff -ur 2.5.63a/drivers/net/wireless/arlan-proc.c 2.5.63b/drivers/net/wireless/arlan-proc.c
--- 2.5.63a/drivers/net/wireless/arlan-proc.c	Mon Feb 24 11:05:33 2003
+++ 2.5.63b/drivers/net/wireless/arlan-proc.c	Mon Feb 24 18:35:07 2003
@@ -79,7 +79,7 @@
 		case 0xFB:
 			return "ERROR BackBone failure ";
 		case 0xFA:
-			return "ERROR tranceiver not found ";
+			return "ERROR transceiver not found ";
 		case 0xF9:
 			return "ERROR no more address space ";
 		case 0xF8:
diff -ur 2.5.63a/drivers/scsi/aic7xxx/aic79xx_core.c 2.5.63b/drivers/scsi/aic7xxx/aic79xx_core.c
--- 2.5.63a/drivers/scsi/aic7xxx/aic79xx_core.c	Mon Feb 24 11:05:04 2003
+++ 2.5.63b/drivers/scsi/aic7xxx/aic79xx_core.c	Mon Feb 24 18:35:09 2003
@@ -6016,7 +6016,7 @@
 	 * Now that termination is set, wait for up
 	 * to 500ms for our transceivers to settle.  If
 	 * the adapter does not have a cable attached,
-	 * the tranceivers may never settle, so don't
+	 * the transceivers may never settle, so don't
 	 * complain if we fail here.
 	 */
 	for (wait = 10000;
diff -ur 2.5.63a/drivers/scsi/aic7xxx/aic7xxx_core.c 2.5.63b/drivers/scsi/aic7xxx/aic7xxx_core.c
--- 2.5.63a/drivers/scsi/aic7xxx/aic7xxx_core.c	Mon Feb 24 11:05:31 2003
+++ 2.5.63b/drivers/scsi/aic7xxx/aic7xxx_core.c	Mon Feb 24 18:35:11 2003
@@ -4999,7 +4999,7 @@
 		/*
 		 * Wait for up to 500ms for our transceivers
 		 * to settle.  If the adapter does not have
-		 * a cable attached, the tranceivers may
+		 * a cable attached, the transceivers may
 		 * never settle, so don't complain if we
 		 * fail here.
 		 */
diff -ur 2.5.63a/drivers/scsi/sym53c8xx_2/sym_conf.h 2.5.63b/drivers/scsi/sym53c8xx_2/sym_conf.h
--- 2.5.63a/drivers/scsi/sym53c8xx_2/sym_conf.h	Mon Feb 24 11:05:40 2003
+++ 2.5.63b/drivers/scsi/sym53c8xx_2/sym_conf.h	Mon Feb 24 18:35:13 2003
@@ -244,7 +244,7 @@
  *  But for HVD/SE only capable chips (825a, 875, 885), 
  *  the driver uses some heuristic to probe against HVD. 
  *  Normally, the chip senses the DIFFSENS signal and 
- *  should switch its BUS tranceivers to high impedance 
+ *  should switch its BUS transceivers to high impedance 
  *  in situation of the driver having been wrong about 
  *  the actual BUS mode. May-be, the BUS mode probing of 
  *  the driver is safe, but, given that it may be partially 
diff -ur 2.5.63a/include/linux/ethtool.h 2.5.63b/include/linux/ethtool.h
--- 2.5.63a/include/linux/ethtool.h	Mon Feb 24 11:05:13 2003
+++ 2.5.63b/include/linux/ethtool.h	Mon Feb 24 18:35:41 2003
@@ -22,7 +22,7 @@
 	u8	duplex;		/* Duplex, half or full */
 	u8	port;		/* Which connector port */
 	u8	phy_address;
-	u8	transceiver;	/* Which tranceiver to use */
+	u8	transceiver;	/* Which transceiver to use */
 	u8	autoneg;	/* Enable or disable autonegotiation */
 	u32	maxtxpkt;	/* Tx pkts before generating tx int */
 	u32	maxrxpkt;	/* Rx pkts before generating rx int */
@@ -336,7 +336,7 @@
 #define PORT_FIBRE		0x03
 #define PORT_BNC		0x04
 
-/* Which tranceiver to use. */
+/* Which transceiver to use. */
 #define XCVR_INTERNAL		0x00
 #define XCVR_EXTERNAL		0x01
 #define XCVR_DUMMY1		0x02
