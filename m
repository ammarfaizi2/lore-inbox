Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUEWK4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUEWK4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 06:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUEWK4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 06:56:17 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:15074 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S262453AbUEWKvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 06:51:23 -0400
Date: Sun, 23 May 2004 12:50:15 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [3/4][PATCH 2.6] via-rhine: Whitespace clean-up
Message-ID: <20040523105015.GA10388@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20040523104650.GA9979@k3.hellgate.ch>
X-Operating-System: Linux 2.6.6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

- Switch to 8 char tabs.
- Remove kernel log pointer to the scyld web site -- it's
  a) fairly irrelevant by now and
  b) gone.
- Remove Emacs Voodoo.
- More white space clean up, mostly coding style.

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-2.6.6-3-tabs8.diff"

--- linux-2.6.6/drivers/net/via-rhine.c	2004-05-23 10:27:31.000000000 +0200
+++ linux-2.6.6-patch/drivers/net/via-rhine.c	2004-05-23 11:34:48.387242724 +0200
@@ -74,8 +74,8 @@
 
 	LK1.1.11:
 	- David Woodhouse: Set dev->base_addr before the first time we call
-					   wait_for_reset(). It's a lot happier that way.
-					   Free np->tx_bufs only if we actually allocated it.
+			   wait_for_reset(). It's a lot happier that way.
+			   Free np->tx_bufs only if we actually allocated it.
 
 	LK1.1.12:
 	- Martin Eriksson: Allow Memory-Mapped IO to be enabled.
@@ -85,7 +85,7 @@
 	- Replace some MII-related magic numbers with constants
 
 	LK1.1.14 (Ivan G.):
- 	- fixes comments for Rhine-III
+	- fixes comments for Rhine-III
 	- removes W_MAX_TIMEOUT (unused)
 	- adds HasDavicomPhy for Rhine-I (basis: linuxfet driver; my card
 	  is R-I and has Davicom chip, flag is referenced in kernel driver)
@@ -96,10 +96,10 @@
 	- transmit frame queue message is off by one - fixed
 	- adds IntrNormalSummary to "Something Wicked" exclusion list
 	  so normal interrupts will not trigger the message (src: Donald Becker)
- 	(Roger Luethi)
- 	- show confused chip where to continue after Tx error
- 	- location of collision counter is chip specific
- 	- allow selecting backoff algorithm (module parameter)
+	(Roger Luethi)
+	- show confused chip where to continue after Tx error
+	- location of collision counter is chip specific
+	- allow selecting backoff algorithm (module parameter)
 
 	LK1.1.15 (jgarzik):
 	- Use new MII lib helper generic_mii_ioctl
@@ -135,7 +135,7 @@
 /* A few user-configurable values.
    These may be modified when a driver module is loaded. */
 
-static int debug = 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
+static int debug = 1;	/* 1 normal messages, 0 quiet .. 7 verbose. */
 static int max_interrupt_work = 20;
 
 /* Set the copy breakpoint for the copy-only-tiny-frames scheme.
@@ -155,12 +155,12 @@ static int backoff;
    Use option values 0x10 and 0x100 for forcing half duplex fixed speed.
    Use option values 0x20 and 0x200 for forcing full duplex operation.
 */
-#define MAX_UNITS 8		/* More are supported, limit only on options */
+#define MAX_UNITS	8	/* More are supported, limit only on options */
 static int options[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int full_duplex[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 
 /* Maximum number of multicast addresses to filter (vs. rx-all-multicast).
-   The Rhine has a 64 element 8390-like hash table.  */
+   The Rhine has a 64 element 8390-like hash table. */
 static const int multicast_filter_limit = 32;
 
 
@@ -172,16 +172,16 @@ static const int multicast_filter_limit 
    bonding and packet priority.
    There are no ill effects from too-large receive rings. */
 #define TX_RING_SIZE	16
-#define TX_QUEUE_LEN	10		/* Limit ring entries actually used.  */
+#define TX_QUEUE_LEN	10	/* Limit ring entries actually used. */
 #define RX_RING_SIZE	16
 
 
 /* Operational parameters that usually are not changed. */
 
 /* Time in jiffies before concluding the transmitter is hung. */
-#define TX_TIMEOUT  (2*HZ)
+#define TX_TIMEOUT	(2*HZ)
 
-#define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/
+#define PKT_BUF_SZ	1536	/* Size of each temporary Rx buffer.*/
 
 #if !defined(__OPTIMIZE__)  ||  !defined(__KERNEL__)
 #warning  You must compile this file with the correct options!
@@ -206,7 +206,7 @@ static const int multicast_filter_limit 
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/crc32.h>
-#include <asm/processor.h>		/* Processor type for cache alignment. */
+#include <asm/processor.h>	/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -214,8 +214,7 @@ static const int multicast_filter_limit 
 
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
-KERN_INFO DRV_NAME ".c:v1.10-LK" DRV_VERSION "  " DRV_RELDATE "  Written by Donald Becker\n"
-KERN_INFO "  http://www.scyld.com/network/via-rhine.html\n";
+KERN_INFO DRV_NAME ".c:v1.10-LK" DRV_VERSION " " DRV_RELDATE " Written by Donald Becker\n";
 
 static char shortname[] = DRV_NAME;
 
@@ -258,7 +257,7 @@ MODULE_PARM_DESC(options, "VIA Rhine: Bi
 MODULE_PARM_DESC(full_duplex, "VIA Rhine full duplex setting(s) (1)");
 
 /*
-				Theory of Operation
+		Theory of Operation
 
 I. Board Compatibility
 
@@ -281,7 +280,7 @@ IIIa. Ring buffers
 
 This driver uses two statically allocated fixed-size descriptor lists
 formed into rings by a branch from the final descriptor to the beginning of
-the list.  The ring sizes are set at compile time by RX/TX_RING_SIZE.
+the list. The ring sizes are set at compile time by RX/TX_RING_SIZE.
 
 IIIb/c. Transmit/Receive Structure
 
@@ -292,29 +291,29 @@ the driver must often copy transmit pack
 
 The driver allocates full frame size skbuffs for the Rx ring buffers at
 open() time and passes the skb->data field to the chip as receive data
-buffers.  When an incoming frame is less than RX_COPYBREAK bytes long,
+buffers. When an incoming frame is less than RX_COPYBREAK bytes long,
 a fresh skbuff is allocated and the frame is copied to the new skbuff.
 When the incoming frame is larger, the skbuff is passed directly up the
-protocol stack.  Buffers consumed this way are replaced by newly allocated
-skbuffs in the last phase of via_rhine_rx().
+protocol stack. Buffers consumed this way are replaced by newly allocated
+skbuffs in the last phase of rhine_rx().
 
 The RX_COPYBREAK value is chosen to trade-off the memory wasted by
 using a full-sized skbuff for small frames vs. the copying costs of larger
-frames.  New boards are typically used in generously configured machines
+frames. New boards are typically used in generously configured machines
 and the underfilled buffers have negligible impact compared to the benefit of
 a single allocation size, so the default value of zero results in never
-copying packets.  When copying is done, the cost is usually mitigated by using
-a combined copy/checksum routine.  Copying also preloads the cache, which is
+copying packets. When copying is done, the cost is usually mitigated by using
+a combined copy/checksum routine. Copying also preloads the cache, which is
 most useful with small frames.
 
 Since the VIA chips are only able to transfer data to buffers on 32 bit
 boundaries, the IP header at offset 14 in an ethernet frame isn't
-longword aligned for further processing.  Copying these unaligned buffers
+longword aligned for further processing. Copying these unaligned buffers
 has the beneficial effect of 16-byte aligning the IP header.
 
 IIId. Synchronization
 
-The driver runs as two independent, single-threaded flows of control.  One
+The driver runs as two independent, single-threaded flows of control. One
 is the send-packet routine, which enforces single-threaded use by the
 dev->priv->lock spinlock. The other thread is the interrupt handler, which
 is single threaded by the hardware and interrupt handling software.
@@ -324,7 +323,7 @@ dev->priv->lock whenever it's queuing a 
 is not available it stops the transmit queue by calling netif_stop_queue.
 
 The interrupt handler has exclusive control over the Rx ring and records stats
-from the Tx ring.  After reaping the stats, it marks the Tx queue entry as
+from the Tx ring. After reaping the stats, it marks the Tx queue entry as
 empty by incrementing the dirty_tx mark. If at least half of the entries in
 the Rx ring are available the transmit queue is woken up if it was stopped.
 
@@ -350,7 +349,7 @@ The chip does not pad to minimum transmi
 */
 
 
-/* This table drives the PCI probe routines.  It's mostly boilerplate in all
+/* This table drives the PCI probe routines. It's mostly boilerplate in all
    of the drivers, and will likely be provided by some future kernel.
    Note the matching code -- the first table entry matchs all 56** cards but
    second only the 1234 card.
@@ -378,7 +377,8 @@ struct rhine_chip_info {
 
 enum chip_capability_flags {
 	CanHaveMII=1, HasESIPhy=2, HasDavicomPhy=4,
-	ReqTxAlign=0x10, HasWOL=0x20, };
+	ReqTxAlign=0x10, HasWOL=0x20,
+};
 
 #ifdef USE_MEM
 #define RHINE_IOTYPE (PCI_USES_MEM | PCI_USES_MASTER | PCI_ADDR1)
@@ -407,7 +407,7 @@ static struct pci_device_id rhine_pci_tb
 	{0x1106, 0x3065, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6102},
 	{0x1106, 0x3106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105}, /* 6105{,L,LOM} */
 	{0x1106, 0x3053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105M},
-	{0,}			/* terminate list */
+	{0,}	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, rhine_pci_tbl);
 
@@ -469,7 +469,7 @@ struct tx_desc {
 };
 
 /* Initial value for tx_desc.desc_length, Buffer size goes to bits 0-10 */
-#define TXDESC 0x00e08000
+#define TXDESC		0x00e08000
 
 enum rx_status_bits {
 	RxOK=0x8000, RxWholePkt=0x0300, RxErr=0x008F
@@ -517,19 +517,19 @@ struct rhine_private {
 	/* Frequently used values: keep some adjacent for cache effect. */
 	int chip_id, drv_flags;
 	struct rx_desc *rx_head_desc;
-	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
+	unsigned int cur_rx, dirty_rx;	/* Producer/consumer ring indices */
 	unsigned int cur_tx, dirty_tx;
-	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
-	u16 chip_cmd;						/* Current setting for ChipCmd */
+	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
+	u16 chip_cmd;			/* Current setting for ChipCmd */
 
 	/* These values are keep track of the transceiver/media in use. */
-	unsigned int default_port:4;		/* Last dev->if_port value. */
+	unsigned int default_port:4;	/* Last dev->if_port value. */
 	u8 tx_thresh, rx_thresh;
 
 	/* MII transceiver section. */
-	unsigned char phys[MAX_MII_CNT];			/* MII device addresses. */
-	unsigned int mii_cnt;			/* number of MIIs found, but only the first one is used */
-	u16 mii_status;						/* last read MII status */
+	unsigned char phys[MAX_MII_CNT];	/* MII device addresses. */
+	unsigned int mii_cnt;		/* number of MIIs found, but only the first one is used */
+	u16 mii_status;			/* last read MII status */
 	struct mii_if_info mii_if;
 };
 
@@ -624,8 +624,8 @@ static void rhine_poll(struct net_device
 }
 #endif
 
-static int __devinit rhine_init_one (struct pci_dev *pdev,
-					 const struct pci_device_id *ent)
+static int __devinit rhine_init_one(struct pci_dev *pdev,
+				    const struct pci_device_id *ent)
 {
 	struct net_device *dev;
 	struct rhine_private *rp;
@@ -652,31 +652,33 @@ static int __devinit rhine_init_one (str
 	io_size = rhine_chip_info[chip_id].io_size;
 	pci_flags = rhine_chip_info[chip_id].pci_flags;
 
-	if (pci_enable_device (pdev))
+	if (pci_enable_device(pdev))
 		goto err_out;
 
 	/* this should always be supported */
 	if (pci_set_dma_mask(pdev, 0xffffffff)) {
-		printk(KERN_ERR "32-bit PCI DMA addresses not supported by the card!?\n");
+		printk(KERN_ERR "32-bit PCI DMA addresses not supported by "
+		       "the card!?\n");
 		goto err_out;
 	}
 
 	/* sanity check */
-	if ((pci_resource_len (pdev, 0) < io_size) ||
-	    (pci_resource_len (pdev, 1) < io_size)) {
-		printk (KERN_ERR "Insufficient PCI resources, aborting\n");
+	if ((pci_resource_len(pdev, 0) < io_size) ||
+	    (pci_resource_len(pdev, 1) < io_size)) {
+		printk(KERN_ERR "Insufficient PCI resources, aborting\n");
 		goto err_out;
 	}
 
-	ioaddr = pci_resource_start (pdev, 0);
-	memaddr = pci_resource_start (pdev, 1);
+	ioaddr = pci_resource_start(pdev, 0);
+	memaddr = pci_resource_start(pdev, 1);
 
 	if (pci_flags & PCI_USES_MASTER)
-		pci_set_master (pdev);
+		pci_set_master(pdev);
 
 	dev = alloc_etherdev(sizeof(*rp));
 	if (dev == NULL) {
-		printk (KERN_ERR "init_ethernet failed for card #%d\n", card_idx);
+		printk(KERN_ERR "init_ethernet failed for card #%d\n",
+		       card_idx);
 		goto err_out;
 	}
 	SET_MODULE_OWNER(dev);
@@ -689,10 +691,10 @@ static int __devinit rhine_init_one (str
 	ioaddr0 = ioaddr;
 	enable_mmio(ioaddr0, chip_id);
 
-	ioaddr = (long) ioremap (memaddr, io_size);
+	ioaddr = (long) ioremap(memaddr, io_size);
 	if (!ioaddr) {
-		printk (KERN_ERR "ioremap failed for device %s, region 0x%X @ 0x%lX\n",
-				pci_name(pdev), io_size, memaddr);
+		printk(KERN_ERR "ioremap failed for device %s, region 0x%X "
+		       "@ 0x%lX\n", pci_name(pdev), io_size, memaddr);
 		goto err_out_free_res;
 	}
 
@@ -703,8 +705,8 @@ static int __devinit rhine_init_one (str
 		unsigned char a = inb(ioaddr0+reg);
 		unsigned char b = readb(ioaddr+reg);
 		if (a != b) {
-			printk (KERN_ERR "MMIO do not match PIO [%02x] (%02x != %02x)\n",
-					reg, a, b);
+			printk(KERN_ERR "MMIO do not match PIO [%02x] "
+			       "(%02x != %02x)\n", reg, a, b);
 			goto err_out_unmap;
 		}
 	}
@@ -756,7 +758,7 @@ static int __devinit rhine_init_one (str
 	if (chip_id == VT6102) {
 		/*
 		 * for 3065D, EEPROM reloaded will cause bit 0 in MAC_REG_CFGA
-		 * turned on.  it makes MAC receive magic packet
+		 * turned on. it makes MAC receive magic packet
 		 * automatically. So, we turn it off. (D-Link)
 		 */
 		writeb(readb(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
@@ -765,12 +767,12 @@ static int __devinit rhine_init_one (str
 	/* Select backoff algorithm */
 	if (backoff)
 		writeb(readb(ioaddr + ConfigD) & (0xF0 | backoff),
-			ioaddr + ConfigD);
+		       ioaddr + ConfigD);
 
 	dev->irq = pdev->irq;
 
 	rp = dev->priv;
-	spin_lock_init (&rp->lock);
+	spin_lock_init(&rp->lock);
 	rp->chip_id = chip_id;
 	rp->drv_flags = rhine_chip_info[chip_id].drv_flags;
 	rp->pdev = pdev;
@@ -810,21 +812,21 @@ static int __devinit rhine_init_one (str
 			rp->mii_if.full_duplex = 1;
 		rp->default_port = option & 15;
 	}
-	if (card_idx < MAX_UNITS  &&  full_duplex[card_idx] > 0)
+	if (card_idx < MAX_UNITS && full_duplex[card_idx] > 0)
 		rp->mii_if.full_duplex = 1;
 
 	if (rp->mii_if.full_duplex) {
-		printk(KERN_INFO "%s: Set to forced full duplex, autonegotiation"
-			   " disabled.\n", dev->name);
+		printk(KERN_INFO "%s: Set to forced full duplex, "
+		       "autonegotiation disabled.\n", dev->name);
 		rp->mii_if.force_media = 1;
 	}
 
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
-		   dev->name, rhine_chip_info[chip_id].name,
-		   (pci_flags & PCI_USES_IO) ? ioaddr : memaddr);
+	       dev->name, rhine_chip_info[chip_id].name,
+	       (pci_flags & PCI_USES_IO) ? ioaddr : memaddr);
 
 	for (i = 0; i < 5; i++)
-			printk("%2.2x:", dev->dev_addr[i]);
+		printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], pdev->irq);
 
 	pci_set_drvdata(pdev, dev);
@@ -834,13 +836,14 @@ static int __devinit rhine_init_one (str
 		rp->phys[0] = 1;		/* Standard for this chip. */
 		for (phy = 1; phy < 32 && phy_idx < MAX_MII_CNT; phy++) {
 			int mii_status = mdio_read(dev, phy, 1);
-			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
+			if (mii_status != 0xffff && mii_status != 0x0000) {
 				rp->phys[phy_idx++] = phy;
 				rp->mii_if.advertising = mdio_read(dev, phy, 4);
-				printk(KERN_INFO "%s: MII PHY found at address %d, status "
-					   "0x%4.4x advertising %4.4x Link %4.4x.\n",
-					   dev->name, phy, mii_status, rp->mii_if.advertising,
-					   mdio_read(dev, phy, 5));
+				printk(KERN_INFO "%s: MII PHY found at address "
+				       "%d, status 0x%4.4x advertising %4.4x "
+				       "Link %4.4x.\n", dev->name, phy,
+				       mii_status, rp->mii_if.advertising,
+				       mdio_read(dev, phy, 5));
 
 				/* set IFF_RUNNING */
 				if (mii_status & BMSR_LSTATUS)
@@ -863,13 +866,14 @@ static int __devinit rhine_init_one (str
 		if (option & 0x330) {
 			/* FIXME: shouldn't someone check this variable? */
 			/* rp->medialock = 1; */
-			printk(KERN_INFO "  Forcing %dMbs %s-duplex operation.\n",
-				   (option & 0x300 ? 100 : 10),
-				   (option & 0x220 ? "full" : "half"));
+			printk(KERN_INFO " Forcing %dMbs %s-duplex "
+				"operation.\n",
+			       (option & 0x300 ? 100 : 10),
+			       (option & 0x220 ? "full" : "half"));
 			if (rp->mii_cnt)
 				mdio_write(dev, rp->phys[0], MII_BMCR,
-						   ((option & 0x300) ? 0x2000 : 0) |  /* 100mbps? */
-						   ((option & 0x220) ? 0x0100 : 0));  /* Full duplex? */
+					   ((option & 0x300) ? 0x2000 : 0) | /* 100mbps? */
+					   ((option & 0x220) ? 0x0100 : 0)); /* Full duplex? */
 		}
 	}
 
@@ -882,7 +886,7 @@ err_out_free_res:
 #endif
 	pci_release_regions(pdev);
 err_out_free_netdev:
-	free_netdev (dev);
+	free_netdev(dev);
 err_out:
 	return -ENODEV;
 }
@@ -902,8 +906,9 @@ static int alloc_ring(struct net_device*
 		return -ENOMEM;
 	}
 	if (rp->drv_flags & ReqTxAlign) {
-		rp->tx_bufs = pci_alloc_consistent(rp->pdev, PKT_BUF_SZ * TX_RING_SIZE,
-								   &rp->tx_bufs_dma);
+		rp->tx_bufs = pci_alloc_consistent(rp->pdev,
+						   PKT_BUF_SZ * TX_RING_SIZE,
+						   &rp->tx_bufs_dma);
 		if (rp->tx_bufs == NULL) {
 			pci_free_consistent(rp->pdev,
 				    RX_RING_SIZE * sizeof(struct rx_desc) +
@@ -933,7 +938,7 @@ void free_ring(struct net_device* dev)
 
 	if (rp->tx_bufs)
 		pci_free_consistent(rp->pdev, PKT_BUF_SZ * TX_RING_SIZE,
-							rp->tx_bufs, rp->tx_bufs_dma);
+				    rp->tx_bufs, rp->tx_bufs_dma);
 
 	rp->tx_bufs = NULL;
 
@@ -972,7 +977,7 @@ static void alloc_rbufs(struct net_devic
 
 		rp->rx_skbuff_dma[i] =
 			pci_map_single(rp->pdev, skb->tail, rp->rx_buf_sz,
-						   PCI_DMA_FROMDEVICE);
+				       PCI_DMA_FROMDEVICE);
 
 		rp->rx_ring[i].addr = cpu_to_le32(rp->rx_skbuff_dma[i]);
 		rp->rx_ring[i].rx_status = cpu_to_le32(DescOwn);
@@ -991,8 +996,8 @@ static void free_rbufs(struct net_device
 		rp->rx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
 		if (rp->rx_skbuff[i]) {
 			pci_unmap_single(rp->pdev,
-							 rp->rx_skbuff_dma[i],
-							 rp->rx_buf_sz, PCI_DMA_FROMDEVICE);
+					 rp->rx_skbuff_dma[i],
+					 rp->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			dev_kfree_skb(rp->rx_skbuff[i]);
 		}
 		rp->rx_skbuff[i] = 0;
@@ -1031,8 +1036,9 @@ static void free_tbufs(struct net_device
 		if (rp->tx_skbuff[i]) {
 			if (rp->tx_skbuff_dma[i]) {
 				pci_unmap_single(rp->pdev,
-								 rp->tx_skbuff_dma[i],
-								 rp->tx_skbuff[i]->len, PCI_DMA_TODEVICE);
+						 rp->tx_skbuff_dma[i],
+						 rp->tx_skbuff[i]->len,
+						 PCI_DMA_TODEVICE);
 			}
 			dev_kfree_skb(rp->tx_skbuff[i]);
 		}
@@ -1055,7 +1061,7 @@ static void init_registers(struct net_de
 	/* Configure initial FIFO thresholds. */
 	writeb(0x20, ioaddr + TxConfig);
 	rp->tx_thresh = 0x20;
-	rp->rx_thresh = 0x60;			/* Written in rhine_set_rx_mode(). */
+	rp->rx_thresh = 0x60;		/* Written in rhine_set_rx_mode(). */
 	rp->mii_if.full_duplex = 0;
 
 	if (dev->if_port == 0)
@@ -1068,10 +1074,10 @@ static void init_registers(struct net_de
 
 	/* Enable interrupts by setting the interrupt mask. */
 	writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow |
-		   IntrRxDropped | IntrRxNoBuf | IntrTxAborted |
-		   IntrTxDone | IntrTxError | IntrTxUnderrun |
-		   IntrPCIErr | IntrStatsMax | IntrLinkChange,
-		   ioaddr + IntrEnable);
+	       IntrRxDropped | IntrRxNoBuf | IntrTxAborted |
+	       IntrTxDone | IntrTxError | IntrTxUnderrun |
+	       IntrPCIErr | IntrStatsMax | IntrLinkChange,
+	       ioaddr + IntrEnable);
 
 	rp->chip_cmd = CmdStart|CmdTxOn|CmdRxOn|CmdNoTxPoll;
 	if (rp->mii_if.force_media)
@@ -1080,12 +1086,13 @@ static void init_registers(struct net_de
 
 	rhine_check_duplex(dev);
 
-	/* The LED outputs of various MII xcvrs should be configured.  */
+	/* The LED outputs of various MII xcvrs should be configured. */
 	/* For NS or Mison phys, turn on bit 1 in register 0x17 */
 	/* For ESI phys, turn on bit 7 in register 0x17. */
 	mdio_write(dev, rp->phys[0], 0x17, mdio_read(dev, rp->phys[0], 0x17) |
-			   (rp->drv_flags & HasESIPhy) ? 0x0080 : 0x0001);
+		   (rp->drv_flags & HasESIPhy) ? 0x0080 : 0x0001);
 }
+
 /* Read and write over the MII Management Data I/O (MDIO) interface. */
 
 static int mdio_read(struct net_device *dev, int phy_id, int regnum)
@@ -1099,7 +1106,7 @@ static int mdio_read(struct net_device *
 	writeb(0x00, ioaddr + MIICmd);
 	writeb(phy_id, ioaddr + MIIPhyAddr);
 	writeb(regnum, ioaddr + MIIRegAddr);
-	writeb(0x40, ioaddr + MIICmd);			/* Trigger read */
+	writeb(0x40, ioaddr + MIICmd);		/* Trigger read */
 	boguscnt = 1024;
 	while ((readb(ioaddr + MIICmd) & 0x40) && --boguscnt > 0)
 		;
@@ -1114,8 +1121,8 @@ static void mdio_write(struct net_device
 
 	if (phy_id == rp->phys[0]) {
 		switch (regnum) {
-		case MII_BMCR:					/* Is user forcing speed/duplex? */
-			if (value & 0x9000)			/* Autonegotiation. */
+		case MII_BMCR:		/* Is user forcing speed/duplex? */
+			if (value & 0x9000)	/* Autonegotiation. */
 				rp->mii_if.force_media = 0;
 			else
 				rp->mii_if.full_duplex = (value & 0x0100) ? 1 : 0;
@@ -1133,7 +1140,7 @@ static void mdio_write(struct net_device
 	writeb(phy_id, ioaddr + MIIPhyAddr);
 	writeb(regnum, ioaddr + MIIRegAddr);
 	writew(value, ioaddr + MIIData);
-	writeb(0x20, ioaddr + MIICmd);			/* Trigger write. */
+	writeb(0x20, ioaddr + MIICmd);		/* Trigger write. */
 }
 
 
@@ -1146,13 +1153,14 @@ static int rhine_open(struct net_device 
 	/* Reset the chip. */
 	writew(CmdReset, ioaddr + ChipCmd);
 
-	i = request_irq(rp->pdev->irq, &rhine_interrupt, SA_SHIRQ, dev->name, dev);
+	i = request_irq(rp->pdev->irq, &rhine_interrupt, SA_SHIRQ, dev->name,
+			dev);
 	if (i)
 		return i;
 
 	if (debug > 1)
 		printk(KERN_DEBUG "%s: rhine_open() irq %d.\n",
-			   dev->name, rp->pdev->irq);
+		       dev->name, rp->pdev->irq);
 
 	i = alloc_ring(dev);
 	if (i)
@@ -1163,9 +1171,9 @@ static int rhine_open(struct net_device 
 	init_registers(dev);
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Done rhine_open(), status %4.4x "
-			   "MII status: %4.4x.\n",
-			   dev->name, readw(ioaddr + ChipCmd),
-			   mdio_read(dev, rp->phys[0], MII_BMSR));
+		       "MII status: %4.4x.\n",
+		       dev->name, readw(ioaddr + ChipCmd),
+		       mdio_read(dev, rp->phys[0], MII_BMSR));
 
 	netif_start_queue(dev);
 
@@ -1173,7 +1181,7 @@ static int rhine_open(struct net_device 
 	init_timer(&rp->timer);
 	rp->timer.expires = jiffies + 2 * HZ/100;
 	rp->timer.data = (unsigned long)dev;
-	rp->timer.function = &rhine_timer;				/* timer handler */
+	rp->timer.function = &rhine_timer;		/* timer handler */
 	add_timer(&rp->timer);
 
 	return 0;
@@ -1187,15 +1195,16 @@ static void rhine_check_duplex(struct ne
 	int negotiated = mii_lpa & rp->mii_if.advertising;
 	int duplex;
 
-	if (rp->mii_if.force_media  ||  mii_lpa == 0xffff)
+	if (rp->mii_if.force_media || mii_lpa == 0xffff)
 		return;
 	duplex = (negotiated & 0x0100) || (negotiated & 0x01C0) == 0x0040;
 	if (rp->mii_if.full_duplex != duplex) {
 		rp->mii_if.full_duplex = duplex;
 		if (debug)
-			printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d link"
-				   " partner capability of %4.4x.\n", dev->name,
-				   duplex ? "full" : "half", rp->phys[0], mii_lpa);
+			printk(KERN_INFO "%s: Setting %s-duplex based on "
+			       "MII #%d link partner capability of %4.4x.\n",
+			       dev->name, duplex ? "full" : "half",
+			       rp->phys[0], mii_lpa);
 		if (duplex)
 			rp->chip_cmd |= CmdFDuplex;
 		else
@@ -1215,7 +1224,7 @@ static void rhine_timer(unsigned long da
 
 	if (debug > 3) {
 		printk(KERN_DEBUG "%s: VIA Rhine monitor tick, status %4.4x.\n",
-			   dev->name, readw(ioaddr + IntrStatus));
+		       dev->name, readw(ioaddr + IntrStatus));
 	}
 
 	spin_lock_irq (&rp->lock);
@@ -1224,7 +1233,7 @@ static void rhine_timer(unsigned long da
 
 	/* make IFF_RUNNING follow the MII status bit "Link established" */
 	mii_status = mdio_read(dev, rp->phys[0], MII_BMSR);
-	if ( (mii_status & BMSR_LSTATUS) != (rp->mii_status & BMSR_LSTATUS) ) {
+	if ((mii_status & BMSR_LSTATUS) != (rp->mii_status & BMSR_LSTATUS)) {
 		if (mii_status & BMSR_LSTATUS)
 			netif_carrier_on(dev);
 		else
@@ -1232,22 +1241,22 @@ static void rhine_timer(unsigned long da
 	}
 	rp->mii_status = mii_status;
 
-	spin_unlock_irq (&rp->lock);
+	spin_unlock_irq(&rp->lock);
 
 	rp->timer.expires = jiffies + next_tick;
 	add_timer(&rp->timer);
 }
 
 
-static void rhine_tx_timeout (struct net_device *dev)
+static void rhine_tx_timeout(struct net_device *dev)
 {
 	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
 
-	printk (KERN_WARNING "%s: Transmit timed out, status %4.4x, PHY status "
-		"%4.4x, resetting...\n",
-		dev->name, readw (ioaddr + IntrStatus),
-		mdio_read (dev, rp->phys[0], MII_BMSR));
+	printk(KERN_WARNING "%s: Transmit timed out, status %4.4x, PHY status "
+	       "%4.4x, resetting...\n",
+	       dev->name, readw(ioaddr + IntrStatus),
+	       mdio_read(dev, rp->phys[0], MII_BMSR));
 
 	dev->if_port = 0;
 
@@ -1298,8 +1307,7 @@ static int rhine_start_tx(struct sk_buff
 	rp->tx_skbuff[entry] = skb;
 
 	if ((rp->drv_flags & ReqTxAlign) &&
-		(((long)skb->data & 3) || skb_shinfo(skb)->nr_frags != 0 || skb->ip_summed == CHECKSUM_HW)
-		) {
+	    (((long)skb->data & 3) || skb_shinfo(skb)->nr_frags != 0 || skb->ip_summed == CHECKSUM_HW)) {
 		/* Must use alignment buffer. */
 		if (skb->len > PKT_BUF_SZ) {
 			/* packet too long, drop it */
@@ -1311,10 +1319,12 @@ static int rhine_start_tx(struct sk_buff
 		skb_copy_and_csum_dev(skb, rp->tx_buf[entry]);
 		rp->tx_skbuff_dma[entry] = 0;
 		rp->tx_ring[entry].addr = cpu_to_le32(rp->tx_bufs_dma +
-										  (rp->tx_buf[entry] - rp->tx_bufs));
+						      (rp->tx_buf[entry] -
+						       rp->tx_bufs));
 	} else {
 		rp->tx_skbuff_dma[entry] =
-			pci_map_single(rp->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
+			pci_map_single(rp->pdev, skb->data, skb->len,
+				       PCI_DMA_TODEVICE);
 		rp->tx_ring[entry].addr = cpu_to_le32(rp->tx_skbuff_dma[entry]);
 	}
 
@@ -1322,7 +1332,7 @@ static int rhine_start_tx(struct sk_buff
 		cpu_to_le32(TXDESC | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
 
 	/* lock eth irq */
-	spin_lock_irq (&rp->lock);
+	spin_lock_irq(&rp->lock);
 	wmb();
 	rp->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
 	wmb();
@@ -1346,11 +1356,11 @@ static int rhine_start_tx(struct sk_buff
 
 	dev->trans_start = jiffies;
 
-	spin_unlock_irq (&rp->lock);
+	spin_unlock_irq(&rp->lock);
 
 	if (debug > 4) {
 		printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
-			   dev->name, rp->cur_tx-1, entry);
+		       dev->name, rp->cur_tx-1, entry);
 	}
 	return 0;
 }
@@ -1378,10 +1388,10 @@ static irqreturn_t rhine_interrupt(int i
 
 		if (debug > 4)
 			printk(KERN_DEBUG "%s: Interrupt, status %8.8x.\n",
-				   dev->name, intr_status);
+			       dev->name, intr_status);
 
 		if (intr_status & (IntrRxDone | IntrRxErr | IntrRxDropped |
-						   IntrRxWakeUp | IntrRxEmpty | IntrRxNoBuf))
+		    IntrRxWakeUp | IntrRxEmpty | IntrRxNoBuf))
 			rhine_rx(dev);
 
 		if (intr_status & (IntrTxErrSummary | IntrTxDone)) {
@@ -1391,9 +1401,9 @@ static irqreturn_t rhine_interrupt(int i
 				while ((readw(ioaddr+ChipCmd) & CmdTxOn) && --cnt)
 					udelay(5);
 				if (debug > 2 && !cnt)
-					printk(KERN_WARNING "%s: rhine_interrupt() "
-						   "Tx engine still on.\n",
-						   dev->name);
+					printk(KERN_WARNING "%s: "
+					       "rhine_interrupt() Tx engine"
+					       "still on.\n", dev->name);
 			}
 			rhine_tx(dev);
 		}
@@ -1406,15 +1416,15 @@ static irqreturn_t rhine_interrupt(int i
 
 		if (--boguscnt < 0) {
 			printk(KERN_WARNING "%s: Too much work at interrupt, "
-				   "status=%#8.8x.\n",
-				   dev->name, intr_status);
+			       "status=%#8.8x.\n",
+			       dev->name, intr_status);
 			break;
 		}
 	}
 
 	if (debug > 3)
 		printk(KERN_DEBUG "%s: exiting interrupt, status=%8.8x.\n",
-			   dev->name, readw(ioaddr + IntrStatus));
+		       dev->name, readw(ioaddr + IntrStatus));
 	return IRQ_RETVAL(handled);
 }
 
@@ -1425,27 +1435,28 @@ static void rhine_tx(struct net_device *
 	struct rhine_private *rp = dev->priv;
 	int txstatus = 0, entry = rp->dirty_tx % TX_RING_SIZE;
 
-	spin_lock (&rp->lock);
+	spin_lock(&rp->lock);
 
 	/* find and cleanup dirty tx descriptors */
 	while (rp->dirty_tx != rp->cur_tx) {
 		txstatus = le32_to_cpu(rp->tx_ring[entry].tx_status);
 		if (debug > 6)
 			printk(KERN_DEBUG " Tx scavenge %d status %8.8x.\n",
-				   entry, txstatus);
+			       entry, txstatus);
 		if (txstatus & DescOwn)
 			break;
 		if (txstatus & 0x8000) {
 			if (debug > 1)
-				printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",
-					   dev->name, txstatus);
+				printk(KERN_DEBUG "%s: Transmit error, "
+				       "Tx status %8.8x.\n",
+				       dev->name, txstatus);
 			rp->stats.tx_errors++;
 			if (txstatus & 0x0400) rp->stats.tx_carrier_errors++;
 			if (txstatus & 0x0200) rp->stats.tx_window_errors++;
 			if (txstatus & 0x0100) rp->stats.tx_aborted_errors++;
 			if (txstatus & 0x0080) rp->stats.tx_heartbeat_errors++;
 			if (((rp->chip_id == VT86C100A) && txstatus & 0x0002) ||
-				(txstatus & 0x0800) || (txstatus & 0x1000)) {
+			    (txstatus & 0x0800) || (txstatus & 0x1000)) {
 				rp->stats.tx_fifo_errors++;
 				rp->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
 				break; /* Keep the skb - we try again */
@@ -1458,25 +1469,26 @@ static void rhine_tx(struct net_device *
 				rp->stats.collisions += txstatus & 0x0F;
 			if (debug > 6)
 				printk(KERN_DEBUG "collisions: %1.1x:%1.1x\n",
-					(txstatus >> 3) & 0xF,
-					txstatus & 0xF);
+				       (txstatus >> 3) & 0xF,
+				       txstatus & 0xF);
 			rp->stats.tx_bytes += rp->tx_skbuff[entry]->len;
 			rp->stats.tx_packets++;
 		}
 		/* Free the original skb. */
 		if (rp->tx_skbuff_dma[entry]) {
 			pci_unmap_single(rp->pdev,
-							 rp->tx_skbuff_dma[entry],
-							 rp->tx_skbuff[entry]->len, PCI_DMA_TODEVICE);
+					 rp->tx_skbuff_dma[entry],
+					 rp->tx_skbuff[entry]->len,
+					 PCI_DMA_TODEVICE);
 		}
 		dev_kfree_skb_irq(rp->tx_skbuff[entry]);
 		rp->tx_skbuff[entry] = NULL;
 		entry = (++rp->dirty_tx) % TX_RING_SIZE;
 	}
 	if ((rp->cur_tx - rp->dirty_tx) < TX_QUEUE_LEN - 4)
-		netif_wake_queue (dev);
+		netif_wake_queue(dev);
 
-	spin_unlock (&rp->lock);
+	spin_unlock(&rp->lock);
 }
 
 /* This routine is logically part of the interrupt handler, but isolated
@@ -1489,42 +1501,47 @@ static void rhine_rx(struct net_device *
 
 	if (debug > 4) {
 		printk(KERN_DEBUG "%s: rhine_rx(), entry %d status %8.8x.\n",
-			   dev->name, entry, le32_to_cpu(rp->rx_head_desc->rx_status));
+		       dev->name, entry,
+		       le32_to_cpu(rp->rx_head_desc->rx_status));
 	}
 
 	/* If EOP is set on the next entry, it's a new packet. Send it up. */
-	while ( ! (rp->rx_head_desc->rx_status & cpu_to_le32(DescOwn))) {
+	while (!(rp->rx_head_desc->rx_status & cpu_to_le32(DescOwn))) {
 		struct rx_desc *desc = rp->rx_head_desc;
 		u32 desc_status = le32_to_cpu(desc->rx_status);
 		int data_size = desc_status >> 16;
 
 		if (debug > 4)
-			printk(KERN_DEBUG "  rhine_rx() status is %8.8x.\n",
-				   desc_status);
+			printk(KERN_DEBUG " rhine_rx() status is %8.8x.\n",
+			       desc_status);
 		if (--boguscnt < 0)
 			break;
-		if ( (desc_status & (RxWholePkt | RxErr)) !=  RxWholePkt) {
-			if ((desc_status & RxWholePkt) !=  RxWholePkt) {
-				printk(KERN_WARNING "%s: Oversized Ethernet frame spanned "
-					   "multiple buffers, entry %#x length %d status %8.8x!\n",
-					   dev->name, entry, data_size, desc_status);
-				printk(KERN_WARNING "%s: Oversized Ethernet frame %p vs %p.\n",
-					   dev->name, rp->rx_head_desc, &rp->rx_ring[entry]);
+		if ((desc_status & (RxWholePkt | RxErr)) != RxWholePkt) {
+			if ((desc_status & RxWholePkt) != RxWholePkt) {
+				printk(KERN_WARNING "%s: Oversized Ethernet "
+				       "frame spanned multiple buffers, entry "
+				       "%#x length %d status %8.8x!\n",
+				       dev->name, entry, data_size,
+				       desc_status);
+				printk(KERN_WARNING "%s: Oversized Ethernet "
+				       "frame %p vs %p.\n", dev->name,
+				       rp->rx_head_desc, &rp->rx_ring[entry]);
 				rp->stats.rx_length_errors++;
 			} else if (desc_status & RxErr) {
 				/* There was a error. */
 				if (debug > 2)
-					printk(KERN_DEBUG "  rhine_rx() Rx error was %8.8x.\n",
-						   desc_status);
+					printk(KERN_DEBUG " rhine_rx() Rx "
+					       "error was %8.8x.\n",
+					       desc_status);
 				rp->stats.rx_errors++;
 				if (desc_status & 0x0030) rp->stats.rx_length_errors++;
 				if (desc_status & 0x0048) rp->stats.rx_fifo_errors++;
 				if (desc_status & 0x0004) rp->stats.rx_frame_errors++;
 				if (desc_status & 0x0002) {
 					/* this can also be updated outside the interrupt handler */
-					spin_lock (&rp->lock);
+					spin_lock(&rp->lock);
 					rp->stats.rx_crc_errors++;
-					spin_unlock (&rp->lock);
+					spin_unlock(&rp->lock);
 				}
 			}
 		} else {
@@ -1532,38 +1549,48 @@ static void rhine_rx(struct net_device *
 			/* Length should omit the CRC */
 			int pkt_len = data_size - 4;
 
-			/* Check if the packet is long enough to accept without copying
-			   to a minimally-sized skbuff. */
+			/* Check if the packet is long enough to accept without
+			   copying to a minimally-sized skbuff. */
 			if (pkt_len < rx_copybreak &&
 				(skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* 16 byte align the IP header */
-				pci_dma_sync_single_for_cpu(rp->pdev, rp->rx_skbuff_dma[entry],
-						    rp->rx_buf_sz, PCI_DMA_FROMDEVICE);
-
-				/* *_IP_COPYSUM isn't defined anywhere and eth_copy_and_sum
-				   is memcpy for all archs so this is kind of pointless right
-				   now ... or? */
-#if HAS_IP_COPYSUM                     /* Call copy + cksum if available. */
-				eth_copy_and_sum(skb, rp->rx_skbuff[entry]->tail, pkt_len, 0);
+				pci_dma_sync_single_for_cpu(rp->pdev,
+							    rp->rx_skbuff_dma[entry],
+							    rp->rx_buf_sz,
+							    PCI_DMA_FROMDEVICE);
+
+				/* *_IP_COPYSUM isn't defined anywhere and
+				   eth_copy_and_sum is memcpy for all archs so
+				   this is kind of pointless right now
+				   ... or? */
+#if HAS_IP_COPYSUM		/* Call copy + cksum if available. */
+				eth_copy_and_sum(skb,
+						 rp->rx_skbuff[entry]->tail,
+						 pkt_len, 0);
 				skb_put(skb, pkt_len);
 #else
-				memcpy(skb_put(skb, pkt_len), rp->rx_skbuff[entry]->tail,
-					   pkt_len);
+				memcpy(skb_put(skb, pkt_len),
+				       rp->rx_skbuff[entry]->tail, pkt_len);
 #endif
-				pci_dma_sync_single_for_device(rp->pdev, rp->rx_skbuff_dma[entry],
-						    rp->rx_buf_sz, PCI_DMA_FROMDEVICE);
+				pci_dma_sync_single_for_device(rp->pdev,
+							       rp->rx_skbuff_dma[entry],
+							       rp->rx_buf_sz,
+							       PCI_DMA_FROMDEVICE);
 			} else {
 				skb = rp->rx_skbuff[entry];
 				if (skb == NULL) {
-					printk(KERN_ERR "%s: Inconsistent Rx descriptor chain.\n",
-						   dev->name);
+					printk(KERN_ERR "%s: Inconsistent Rx "
+					       "descriptor chain.\n",
+					       dev->name);
 					break;
 				}
 				rp->rx_skbuff[entry] = NULL;
 				skb_put(skb, pkt_len);
-				pci_unmap_single(rp->pdev, rp->rx_skbuff_dma[entry],
-								 rp->rx_buf_sz, PCI_DMA_FROMDEVICE);
+				pci_unmap_single(rp->pdev,
+						 rp->rx_skbuff_dma[entry],
+						 rp->rx_buf_sz,
+						 PCI_DMA_FROMDEVICE);
 			}
 			skb->protocol = eth_type_trans(skb, dev);
 			netif_rx(skb);
@@ -1583,11 +1610,12 @@ static void rhine_rx(struct net_device *
 			skb = dev_alloc_skb(rp->rx_buf_sz);
 			rp->rx_skbuff[entry] = skb;
 			if (skb == NULL)
-				break;			/* Better luck next round. */
-			skb->dev = dev;			/* Mark as being used by this device. */
+				break;	/* Better luck next round. */
+			skb->dev = dev;	/* Mark as being used by this device. */
 			rp->rx_skbuff_dma[entry] =
-				pci_map_single(rp->pdev, skb->tail, rp->rx_buf_sz,
-							   PCI_DMA_FROMDEVICE);
+				pci_map_single(rp->pdev, skb->tail,
+					       rp->rx_buf_sz,
+					       PCI_DMA_FROMDEVICE);
 			rp->rx_ring[entry].addr = cpu_to_le32(rp->rx_skbuff_dma[entry]);
 		}
 		rp->rx_ring[entry].rx_status = cpu_to_le32(DescOwn);
@@ -1595,13 +1623,15 @@ static void rhine_rx(struct net_device *
 
 	/* Pre-emptively restart Rx engine. */
 	writew(readw(dev->base_addr + ChipCmd) | CmdRxOn | CmdRxDemand,
-		   dev->base_addr + ChipCmd);
+	       dev->base_addr + ChipCmd);
 }
 
-/* Clears the "tally counters" for CRC errors and missed frames(?).
-   It has been reported that some chips need a write of 0 to clear
-   these, for others the counters are set to 1 when written to and
-   instead cleared when read. So we clear them both ways ... */
+/*
+ * Clears the "tally counters" for CRC errors and missed frames(?).
+ * It has been reported that some chips need a write of 0 to clear
+ * these, for others the counters are set to 1 when written to and
+ * instead cleared when read. So we clear them both ways ...
+ */
 static inline void clear_tally_counters(const long ioaddr)
 {
 	writel(0, ioaddr + RxMissed);
@@ -1625,7 +1655,7 @@ static void rhine_restart_tx(struct net_
 
 		/* We know better than the chip where it should continue. */
 		writel(rp->tx_ring_dma + entry * sizeof(struct tx_desc),
-			   ioaddr + TxRingPtr);
+		       ioaddr + TxRingPtr);
 
 		writew(CmdTxDemand | rp->chip_cmd, ioaddr + ChipCmd);
 		IOSYNC;
@@ -1634,8 +1664,8 @@ static void rhine_restart_tx(struct net_
 		/* This should never happen */
 		if (debug > 1)
 			printk(KERN_WARNING "%s: rhine_restart_tx() "
-				   "Another error occured %8.8x.\n",
-				   dev->name, intr_status);
+			       "Another error occured %8.8x.\n",
+			       dev->name, intr_status);
 	}
 
 }
@@ -1645,7 +1675,7 @@ static void rhine_error(struct net_devic
 	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
 
-	spin_lock (&rp->lock);
+	spin_lock(&rp->lock);
 
 	if (intr_status & (IntrLinkChange)) {
 		if (readb(ioaddr + MIIStatus) & 0x02) {
@@ -1655,58 +1685,59 @@ static void rhine_error(struct net_devic
 		} else
 			rhine_check_duplex(dev);
 		if (debug)
-			printk(KERN_ERR "%s: MII status changed: Autonegotiation "
-				   "advertising %4.4x  partner %4.4x.\n", dev->name,
-			   mdio_read(dev, rp->phys[0], MII_ADVERTISE),
-			   mdio_read(dev, rp->phys[0], MII_LPA));
+			printk(KERN_ERR "%s: MII status changed: "
+			       "Autonegotiation advertising %4.4x partner "
+			       "%4.4x.\n", dev->name,
+			       mdio_read(dev, rp->phys[0], MII_ADVERTISE),
+			       mdio_read(dev, rp->phys[0], MII_LPA));
 	}
 	if (intr_status & IntrStatsMax) {
-		rp->stats.rx_crc_errors	+= readw(ioaddr + RxCRCErrs);
-		rp->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
+		rp->stats.rx_crc_errors += readw(ioaddr + RxCRCErrs);
+		rp->stats.rx_missed_errors += readw(ioaddr + RxMissed);
 		clear_tally_counters(ioaddr);
 	}
 	if (intr_status & IntrTxAborted) {
 		if (debug > 1)
 			printk(KERN_INFO "%s: Abort %8.8x, frame dropped.\n",
-				   dev->name, intr_status);
+			       dev->name, intr_status);
 	}
 	if (intr_status & IntrTxUnderrun) {
 		if (rp->tx_thresh < 0xE0)
 			writeb(rp->tx_thresh += 0x20, ioaddr + TxConfig);
 		if (debug > 1)
 			printk(KERN_INFO "%s: Transmitter underrun, Tx "
-				   "threshold now %2.2x.\n",
-				   dev->name, rp->tx_thresh);
+			       "threshold now %2.2x.\n",
+			       dev->name, rp->tx_thresh);
 	}
 	if (intr_status & IntrTxDescRace) {
 		if (debug > 2)
 			printk(KERN_INFO "%s: Tx descriptor write-back race.\n",
-				   dev->name);
+			       dev->name);
 	}
 	if ((intr_status & IntrTxError) &&
-			(intr_status & ( IntrTxAborted |
-			IntrTxUnderrun | IntrTxDescRace )) == 0) {
+	    (intr_status & (IntrTxAborted |
+	     IntrTxUnderrun | IntrTxDescRace)) == 0) {
 		if (rp->tx_thresh < 0xE0) {
 			writeb(rp->tx_thresh += 0x20, ioaddr + TxConfig);
 		}
 		if (debug > 1)
 			printk(KERN_INFO "%s: Unspecified error. Tx "
-				   "threshold now %2.2x.\n",
-				   dev->name, rp->tx_thresh);
+			       "threshold now %2.2x.\n",
+			       dev->name, rp->tx_thresh);
 	}
-	if (intr_status & ( IntrTxAborted | IntrTxUnderrun | IntrTxDescRace |
-						IntrTxError ))
+	if (intr_status & (IntrTxAborted | IntrTxUnderrun | IntrTxDescRace |
+			   IntrTxError))
 		rhine_restart_tx(dev);
 
-	if (intr_status & ~( IntrLinkChange | IntrStatsMax | IntrTxUnderrun |
-						 IntrTxError | IntrTxAborted | IntrNormalSummary |
-						 IntrTxDescRace )) {
+	if (intr_status & ~(IntrLinkChange | IntrStatsMax | IntrTxUnderrun |
+			    IntrTxError | IntrTxAborted | IntrNormalSummary |
+			    IntrTxDescRace)) {
 		if (debug > 1)
-			printk(KERN_ERR "%s: Something Wicked happened! %8.8x.\n",
-				   dev->name, intr_status);
+			printk(KERN_ERR "%s: Something Wicked happened! "
+			       "%8.8x.\n", dev->name, intr_status);
 	}
 
-	spin_unlock (&rp->lock);
+	spin_unlock(&rp->lock);
 }
 
 static struct net_device_stats *rhine_get_stats(struct net_device *dev)
@@ -1716,8 +1747,8 @@ static struct net_device_stats *rhine_ge
 	unsigned long flags;
 
 	spin_lock_irqsave(&rp->lock, flags);
-	rp->stats.rx_crc_errors	+= readw(ioaddr + RxCRCErrs);
-	rp->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
+	rp->stats.rx_crc_errors += readw(ioaddr + RxCRCErrs);
+	rp->stats.rx_missed_errors += readw(ioaddr + RxMissed);
 	clear_tally_counters(ioaddr);
 	spin_unlock_irqrestore(&rp->lock, flags);
 
@@ -1728,17 +1759,18 @@ static void rhine_set_rx_mode(struct net
 {
 	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
-	u32 mc_filter[2];			/* Multicast hash filter */
-	u8 rx_mode;					/* Note: 0x02=accept runt, 0x01=accept errs */
+	u32 mc_filter[2];	/* Multicast hash filter */
+	u8 rx_mode;		/* Note: 0x02=accept runt, 0x01=accept errs */
 
-	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous. */
+	if (dev->flags & IFF_PROMISC) {		/* Set promiscuous. */
 		/* Unconditionally log net taps. */
-		printk(KERN_NOTICE "%s: Promiscuous mode enabled.\n", dev->name);
+		printk(KERN_NOTICE "%s: Promiscuous mode enabled.\n",
+		       dev->name);
 		rx_mode = 0x1C;
 		writel(0xffffffff, ioaddr + MulticastFilter0);
 		writel(0xffffffff, ioaddr + MulticastFilter1);
 	} else if ((dev->mc_count > multicast_filter_limit)
-			   ||  (dev->flags & IFF_ALLMULTI)) {
+		   || (dev->flags & IFF_ALLMULTI)) {
 		/* Too many to match, or accept all multicasts. */
 		writel(0xffffffff, ioaddr + MulticastFilter0);
 		writel(0xffffffff, ioaddr + MulticastFilter1);
@@ -1748,7 +1780,7 @@ static void rhine_set_rx_mode(struct net
 		int i;
 		memset(mc_filter, 0, sizeof(mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
-			 i++, mclist = mclist->next) {
+		     i++, mclist = mclist->next) {
 			int bit_nr = ether_crc(ETH_ALEN, mclist->dmi_addr) >> 26;
 
 			mc_filter[bit_nr >> 5] |= cpu_to_le32(1 << (bit_nr & 31));
@@ -1760,13 +1792,13 @@ static void rhine_set_rx_mode(struct net
 	writeb(rp->rx_thresh | rx_mode, ioaddr + RxConfig);
 }
 
-static void netdev_get_drvinfo (struct net_device *dev, struct ethtool_drvinfo *info)
+static void netdev_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 {
 	struct rhine_private *rp = dev->priv;
 
-	strcpy (info->driver, DRV_NAME);
-	strcpy (info->version, DRV_VERSION);
-	strcpy (info->bus_info, pci_name(rp->pdev));
+	strcpy(info->driver, DRV_NAME);
+	strcpy(info->version, DRV_VERSION);
+	strcpy(info->bus_info, pci_name(rp->pdev));
 }
 
 static int netdev_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
@@ -1869,8 +1901,9 @@ static int rhine_close(struct net_device
 	netif_stop_queue(dev);
 
 	if (debug > 1)
-		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.\n",
-			   dev->name, readw(ioaddr + ChipCmd));
+		printk(KERN_DEBUG "%s: Shutting down ethercard, "
+		       "status was %4.4x.\n",
+		       dev->name, readw(ioaddr + ChipCmd));
 
 	/* Switch to loopback mode to avoid hardware races. */
 	writeb(rp->tx_thresh | 0x02, ioaddr + TxConfig);
@@ -1892,7 +1925,7 @@ static int rhine_close(struct net_device
 }
 
 
-static void __devexit rhine_remove_one (struct pci_dev *pdev)
+static void __devexit rhine_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -1918,31 +1951,21 @@ static struct pci_driver rhine_driver = 
 };
 
 
-static int __init rhine_init (void)
+static int __init rhine_init(void)
 {
 /* when a module, this is printed whether or not devices are found in probe */
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&rhine_driver);
+	return pci_module_init(&rhine_driver);
 }
 
 
-static void __exit rhine_cleanup (void)
+static void __exit rhine_cleanup(void)
 {
-	pci_unregister_driver (&rhine_driver);
+	pci_unregister_driver(&rhine_driver);
 }
 
 
 module_init(rhine_init);
 module_exit(rhine_cleanup);
-
-
-/*
- * Local variables:
- *  compile-command: "gcc -DMODULE -D__KERNEL__ -I/usr/src/linux/net/inet -Wall -Wstrict-prototypes -O6 -c via-rhine.c `[ -f /usr/include/linux/modversions.h ] && echo -DMODVERSIONS`"
- *  c-indent-level: 4
- *  c-basic-offset: 4
- *  tab-width: 4
- * End:
- */

--PNTmBPCT7hxwcZjr--
