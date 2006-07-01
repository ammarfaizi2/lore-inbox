Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWGAPEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWGAPEw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWGAPEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:04:38 -0400
Received: from www.osadl.org ([213.239.205.134]:59812 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751635AbWGAO5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:34 -0400
Message-Id: <20060701145227.313844000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:55:00 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, jgarzik@pobox.com
Subject: [RFC][patch 35/44] drivers/net: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-net.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/net/3c515.c                           |    2 +-
 drivers/net/3c523.c                           |    2 +-
 drivers/net/3c527.c                           |    2 +-
 drivers/net/3c59x.c                           |    4 ++--
 drivers/net/8139cp.c                          |    2 +-
 drivers/net/8139too.c                         |    2 +-
 drivers/net/a2065.c                           |    2 +-
 drivers/net/acenic.c                          |    2 +-
 drivers/net/amd8111e.c                        |    2 +-
 drivers/net/apne.c                            |    2 +-
 drivers/net/arcnet/com20020-pci.c             |    2 +-
 drivers/net/ariadne.c                         |    2 +-
 drivers/net/b44.c                             |    4 ++--
 drivers/net/bnx2.c                            |    6 +++---
 drivers/net/cassini.c                         |    2 +-
 drivers/net/chelsio/cxgb2.c                   |    2 +-
 drivers/net/cris/eth_v10.c                    |    2 +-
 drivers/net/defxx.c                           |    2 +-
 drivers/net/dgrs.c                            |    2 +-
 drivers/net/dl2k.c                            |    2 +-
 drivers/net/dm9000.c                          |    2 +-
 drivers/net/e100.c                            |    2 +-
 drivers/net/e1000/e1000_ethtool.c             |    6 +++---
 drivers/net/e1000/e1000_main.c                |    2 +-
 drivers/net/eepro.c                           |    2 +-
 drivers/net/eepro100.c                        |    2 +-
 drivers/net/epic100.c                         |    2 +-
 drivers/net/fealnx.c                          |    2 +-
 drivers/net/forcedeth.c                       |   18 +++++++++---------
 drivers/net/fs_enet/fs_enet-main.c            |    2 +-
 drivers/net/gt96100eth.c                      |    2 +-
 drivers/net/hamachi.c                         |    2 +-
 drivers/net/hamradio/baycom_ser_fdx.c         |    2 +-
 drivers/net/hamradio/baycom_ser_hdx.c         |    2 +-
 drivers/net/hamradio/scc.c                    |    2 +-
 drivers/net/hamradio/yam.c                    |    2 +-
 drivers/net/hp100.c                           |    2 +-
 drivers/net/hydra.c                           |    2 +-
 drivers/net/ibmlana.c                         |    2 +-
 drivers/net/ioc3-eth.c                        |    2 +-
 drivers/net/irda/donauboe.c                   |    4 ++--
 drivers/net/irda/vlsi_ir.c                    |    2 +-
 drivers/net/ixgb/ixgb_main.c                  |    2 +-
 drivers/net/ixp2000/ixpdev.c                  |    2 +-
 drivers/net/jazzsonic.c                       |    2 +-
 drivers/net/lp486e.c                          |    2 +-
 drivers/net/mipsnet.c                         |    2 +-
 drivers/net/mv643xx_eth.c                     |    2 +-
 drivers/net/myri10ge/myri10ge.c               |    4 ++--
 drivers/net/myri_sbus.c                       |    2 +-
 drivers/net/natsemi.c                         |    2 +-
 drivers/net/ne2k-pci.c                        |    2 +-
 drivers/net/netx-eth.c                        |    2 +-
 drivers/net/ns83820.c                         |    2 +-
 drivers/net/pci-skeleton.c                    |    2 +-
 drivers/net/pcmcia/axnet_cs.c                 |    2 +-
 drivers/net/pcmcia/pcnet_cs.c                 |    2 +-
 drivers/net/pcnet32.c                         |    2 +-
 drivers/net/phy/phy.c                         |    2 +-
 drivers/net/r8169.c                           |    2 +-
 drivers/net/rrunner.c                         |    2 +-
 drivers/net/s2io.c                            |    4 ++--
 drivers/net/sb1250-mac.c                      |    2 +-
 drivers/net/sis190.c                          |    2 +-
 drivers/net/sis900.c                          |    2 +-
 drivers/net/sk98lin/skge.c                    |    8 ++++----
 drivers/net/sk_mca.c                          |    2 +-
 drivers/net/skfp/skfddi.c                     |    2 +-
 drivers/net/skge.c                            |    2 +-
 drivers/net/sky2.c                            |    4 ++--
 drivers/net/smc-ultra32.c                     |    2 +-
 drivers/net/smc911x.c                         |    2 +-
 drivers/net/smc91x.h                          |    4 ++--
 drivers/net/spider_net.c                      |    2 +-
 drivers/net/starfire.c                        |    2 +-
 drivers/net/sun3lance.c                       |    2 +-
 drivers/net/sunbmac.c                         |    2 +-
 drivers/net/sundance.c                        |    2 +-
 drivers/net/sungem.c                          |    2 +-
 drivers/net/sunhme.c                          |    4 ++--
 drivers/net/sunlance.c                        |    2 +-
 drivers/net/sunqe.c                           |    2 +-
 drivers/net/tc35815.c                         |    2 +-
 drivers/net/tg3.c                             |    6 +++---
 drivers/net/tlan.c                            |    2 +-
 drivers/net/tokenring/3c359.c                 |    2 +-
 drivers/net/tokenring/abyss.c                 |    2 +-
 drivers/net/tokenring/lanstreamer.c           |    2 +-
 drivers/net/tokenring/madgemc.c               |    2 +-
 drivers/net/tokenring/olympic.c               |    2 +-
 drivers/net/tokenring/smctr.c                 |    4 ++--
 drivers/net/tokenring/tmspci.c                |    2 +-
 drivers/net/tulip/de2104x.c                   |    2 +-
 drivers/net/tulip/de4x5.c                     |    8 ++++----
 drivers/net/tulip/dmfe.c                      |    2 +-
 drivers/net/tulip/tulip_core.c                |    4 ++--
 drivers/net/tulip/uli526x.c                   |    2 +-
 drivers/net/tulip/winbond-840.c               |    2 +-
 drivers/net/tulip/xircom_cb.c                 |    2 +-
 drivers/net/tulip/xircom_tulip_cb.c           |    2 +-
 drivers/net/typhoon.c                         |    2 +-
 drivers/net/via-rhine.c                       |    4 ++--
 drivers/net/via-velocity.c                    |    2 +-
 drivers/net/wan/dscc4.c                       |    2 +-
 drivers/net/wan/farsync.c                     |    2 +-
 drivers/net/wan/hostess_sv11.c                |    2 +-
 drivers/net/wan/lmc/lmc_main.c                |    2 +-
 drivers/net/wan/pc300_drv.c                   |    2 +-
 drivers/net/wan/pci200syn.c                   |    2 +-
 drivers/net/wan/sbni.c                        |    2 +-
 drivers/net/wan/sealevel.c                    |    2 +-
 drivers/net/wan/wanxl.c                       |    2 +-
 drivers/net/wireless/airo.c                   |    2 +-
 drivers/net/wireless/atmel.c                  |    2 +-
 drivers/net/wireless/bcm43xx/bcm43xx_main.c   |    2 +-
 drivers/net/wireless/hostap/hostap_pci.c      |    2 +-
 drivers/net/wireless/hostap/hostap_plx.c      |    2 +-
 drivers/net/wireless/ipw2100.c                |    2 +-
 drivers/net/wireless/ipw2200.c                |    2 +-
 drivers/net/wireless/orinoco_nortel.c         |    2 +-
 drivers/net/wireless/orinoco_pci.c            |    2 +-
 drivers/net/wireless/orinoco_pci.h            |    2 +-
 drivers/net/wireless/orinoco_plx.c            |    2 +-
 drivers/net/wireless/orinoco_tmd.c            |    2 +-
 drivers/net/wireless/prism54/islpci_hotplug.c |    2 +-
 drivers/net/yellowfin.c                       |    2 +-
 drivers/net/zorro8390.c                       |    2 +-
 include/net/irda/irda_device.h                |    2 +-
 128 files changed, 159 insertions(+), 159 deletions(-)

Index: linux-2.6.git/drivers/net/3c515.c
===================================================================
--- linux-2.6.git.orig/drivers/net/3c515.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/3c515.c	2006-07-01 16:51:43.000000000 +0200
@@ -760,7 +760,7 @@ static int corkscrew_open(struct net_dev
 				   vp->product_name, dev)) return -EAGAIN;
 		enable_dma(dev->dma);
 		set_dma_mode(dev->dma, DMA_MODE_CASCADE);
-	} else if (request_irq(dev->irq, &corkscrew_interrupt, SA_SHIRQ,
+	} else if (request_irq(dev->irq, &corkscrew_interrupt, IRQF_SHARED,
 			       vp->product_name, dev)) {
 		return -EAGAIN;
 	}
Index: linux-2.6.git/drivers/net/3c523.c
===================================================================
--- linux-2.6.git.orig/drivers/net/3c523.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/3c523.c	2006-07-01 16:51:43.000000000 +0200
@@ -289,7 +289,7 @@ static int elmc_open(struct net_device *
 
 	elmc_id_attn586();	/* disable interrupts */
 
-	ret = request_irq(dev->irq, &elmc_interrupt, SA_SHIRQ | SA_SAMPLE_RANDOM,
+	ret = request_irq(dev->irq, &elmc_interrupt, IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			  dev->name, dev);
 	if (ret) {
 		printk(KERN_ERR "%s: couldn't get irq %d\n", dev->name, dev->irq);
Index: linux-2.6.git/drivers/net/3c527.c
===================================================================
--- linux-2.6.git.orig/drivers/net/3c527.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/3c527.c	2006-07-01 16:51:43.000000000 +0200
@@ -435,7 +435,7 @@ static int __init mc32_probe1(struct net
 	 *	Grab the IRQ
 	 */
 
-	err = request_irq(dev->irq, &mc32_interrupt, SA_SHIRQ | SA_SAMPLE_RANDOM, DRV_NAME, dev);
+	err = request_irq(dev->irq, &mc32_interrupt, IRQF_SHARED | IRQF_SAMPLE_RANDOM, DRV_NAME, dev);
 	if (err) {
 		release_region(dev->base_addr, MC32_IO_EXTENT);
 		printk(KERN_ERR "%s: unable to get IRQ %d.\n", DRV_NAME, dev->irq);
Index: linux-2.6.git/drivers/net/3c59x.c
===================================================================
--- linux-2.6.git.orig/drivers/net/3c59x.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/3c59x.c	2006-07-01 16:51:43.000000000 +0200
@@ -996,7 +996,7 @@ static int vortex_resume(struct pci_dev 
 		pci_enable_device(pdev);
 		pci_set_master(pdev);
 		if (request_irq(dev->irq, vp->full_bus_master_rx ?
-				&boomerang_interrupt : &vortex_interrupt, SA_SHIRQ, dev->name, dev)) {
+				&boomerang_interrupt : &vortex_interrupt, IRQF_SHARED, dev->name, dev)) {
 			printk(KERN_WARNING "%s: Could not reserve IRQ %d\n", dev->name, dev->irq);
 			pci_disable_device(pdev);
 			return -EBUSY;
@@ -1833,7 +1833,7 @@ vortex_open(struct net_device *dev)
 
 	/* Use the now-standard shared IRQ implementation. */
 	if ((retval = request_irq(dev->irq, vp->full_bus_master_rx ?
-				&boomerang_interrupt : &vortex_interrupt, SA_SHIRQ, dev->name, dev))) {
+				&boomerang_interrupt : &vortex_interrupt, IRQF_SHARED, dev->name, dev))) {
 		printk(KERN_ERR "%s: Could not reserve IRQ %d\n", dev->name, dev->irq);
 		goto out;
 	}
Index: linux-2.6.git/drivers/net/8139cp.c
===================================================================
--- linux-2.6.git.orig/drivers/net/8139cp.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/8139cp.c	2006-07-01 16:51:43.000000000 +0200
@@ -1203,7 +1203,7 @@ static int cp_open (struct net_device *d
 
 	cp_init_hw(cp);
 
-	rc = request_irq(dev->irq, cp_interrupt, SA_SHIRQ, dev->name, dev);
+	rc = request_irq(dev->irq, cp_interrupt, IRQF_SHARED, dev->name, dev);
 	if (rc)
 		goto err_out_hw;
 
Index: linux-2.6.git/drivers/net/8139too.c
===================================================================
--- linux-2.6.git.orig/drivers/net/8139too.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/8139too.c	2006-07-01 16:51:43.000000000 +0200
@@ -1310,7 +1310,7 @@ static int rtl8139_open (struct net_devi
 	int retval;
 	void __iomem *ioaddr = tp->mmio_addr;
 
-	retval = request_irq (dev->irq, rtl8139_interrupt, SA_SHIRQ, dev->name, dev);
+	retval = request_irq (dev->irq, rtl8139_interrupt, IRQF_SHARED, dev->name, dev);
 	if (retval)
 		return retval;
 
Index: linux-2.6.git/drivers/net/a2065.c
===================================================================
--- linux-2.6.git.orig/drivers/net/a2065.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/a2065.c	2006-07-01 16:51:43.000000000 +0200
@@ -495,7 +495,7 @@ static int lance_open (struct net_device
 	ll->rdp = LE_C0_STOP;
 
 	/* Install the Interrupt handler */
-	ret = request_irq(IRQ_AMIGA_PORTS, lance_interrupt, SA_SHIRQ,
+	ret = request_irq(IRQ_AMIGA_PORTS, lance_interrupt, IRQF_SHARED,
 			  dev->name, dev);
 	if (ret) return ret;
 
Index: linux-2.6.git/drivers/net/acenic.c
===================================================================
--- linux-2.6.git.orig/drivers/net/acenic.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/acenic.c	2006-07-01 16:51:43.000000000 +0200
@@ -1194,7 +1194,7 @@ static int __devinit ace_init(struct net
 		goto init_error;
 	}
 
-	ecode = request_irq(pdev->irq, ace_interrupt, SA_SHIRQ,
+	ecode = request_irq(pdev->irq, ace_interrupt, IRQF_SHARED,
 			    DRV_NAME, dev);
 	if (ecode) {
 		printk(KERN_WARNING "%s: Requested IRQ %d is busy\n",
Index: linux-2.6.git/drivers/net/amd8111e.c
===================================================================
--- linux-2.6.git.orig/drivers/net/amd8111e.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/amd8111e.c	2006-07-01 16:51:43.000000000 +0200
@@ -1376,7 +1376,7 @@ static int amd8111e_open(struct net_devi
 {
 	struct amd8111e_priv *lp = netdev_priv(dev);
 
-	if(dev->irq ==0 || request_irq(dev->irq, amd8111e_interrupt, SA_SHIRQ,
+	if(dev->irq ==0 || request_irq(dev->irq, amd8111e_interrupt, IRQF_SHARED,
 					 dev->name, dev)) 
 		return -EAGAIN;
 
Index: linux-2.6.git/drivers/net/apne.c
===================================================================
--- linux-2.6.git.orig/drivers/net/apne.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/apne.c	2006-07-01 16:51:43.000000000 +0200
@@ -313,7 +313,7 @@ static int __init apne_probe1(struct net
     dev->base_addr = ioaddr;
 
     /* Install the Interrupt handler */
-    i = request_irq(IRQ_AMIGA_PORTS, apne_interrupt, SA_SHIRQ, DRV_NAME, dev);
+    i = request_irq(IRQ_AMIGA_PORTS, apne_interrupt, IRQF_SHARED, DRV_NAME, dev);
     if (i) return i;
 
     for(i = 0; i < ETHER_ADDR_LEN; i++) {
Index: linux-2.6.git/drivers/net/ariadne.c
===================================================================
--- linux-2.6.git.orig/drivers/net/ariadne.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/ariadne.c	2006-07-01 16:51:43.000000000 +0200
@@ -320,7 +320,7 @@ static int ariadne_open(struct net_devic
 
     netif_start_queue(dev);
 
-    i = request_irq(IRQ_AMIGA_PORTS, ariadne_interrupt, SA_SHIRQ,
+    i = request_irq(IRQ_AMIGA_PORTS, ariadne_interrupt, IRQF_SHARED,
                     dev->name, dev);
     if (i) return i;
 
Index: linux-2.6.git/drivers/net/b44.c
===================================================================
--- linux-2.6.git.orig/drivers/net/b44.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/b44.c	2006-07-01 16:51:43.000000000 +0200
@@ -1421,7 +1421,7 @@ static int b44_open(struct net_device *d
 
 	b44_check_phy(bp);
 
-	err = request_irq(dev->irq, b44_interrupt, SA_SHIRQ, dev->name, dev);
+	err = request_irq(dev->irq, b44_interrupt, IRQF_SHARED, dev->name, dev);
 	if (unlikely(err < 0)) {
 		b44_chip_reset(bp);
 		b44_free_rings(bp);
@@ -2322,7 +2322,7 @@ static int b44_resume(struct pci_dev *pd
 	if (!netif_running(dev))
 		return 0;
 
-	if (request_irq(dev->irq, b44_interrupt, SA_SHIRQ, dev->name, dev))
+	if (request_irq(dev->irq, b44_interrupt, IRQF_SHARED, dev->name, dev))
 		printk(KERN_ERR PFX "%s: request_irq failed\n", dev->name);
 
 	spin_lock_irq(&bp->lock);
Index: linux-2.6.git/drivers/net/bnx2.c
===================================================================
--- linux-2.6.git.orig/drivers/net/bnx2.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/bnx2.c	2006-07-01 16:51:43.000000000 +0200
@@ -4260,11 +4260,11 @@ bnx2_open(struct net_device *dev)
 		}
 		else {
 			rc = request_irq(bp->pdev->irq, bnx2_interrupt,
-					SA_SHIRQ, dev->name, dev);
+					IRQF_SHARED, dev->name, dev);
 		}
 	}
 	else {
-		rc = request_irq(bp->pdev->irq, bnx2_interrupt, SA_SHIRQ,
+		rc = request_irq(bp->pdev->irq, bnx2_interrupt, IRQF_SHARED,
 				dev->name, dev);
 	}
 	if (rc) {
@@ -4311,7 +4311,7 @@ bnx2_open(struct net_device *dev)
 
 			if (!rc) {
 				rc = request_irq(bp->pdev->irq, bnx2_interrupt,
-					SA_SHIRQ, dev->name, dev);
+					IRQF_SHARED, dev->name, dev);
 			}
 			if (rc) {
 				bnx2_free_skbs(bp);
Index: linux-2.6.git/drivers/net/cassini.c
===================================================================
--- linux-2.6.git.orig/drivers/net/cassini.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/cassini.c	2006-07-01 16:51:43.000000000 +0200
@@ -4349,7 +4349,7 @@ static int cas_open(struct net_device *d
 	 * mapping to expose them
 	 */
 	if (request_irq(cp->pdev->irq, cas_interrupt,
-			SA_SHIRQ, dev->name, (void *) dev)) {
+			IRQF_SHARED, dev->name, (void *) dev)) {
 		printk(KERN_ERR "%s: failed to request irq !\n", 
 		       cp->dev->name);
 		err = -EAGAIN;
Index: linux-2.6.git/drivers/net/defxx.c
===================================================================
--- linux-2.6.git.orig/drivers/net/defxx.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/defxx.c	2006-07-01 16:51:43.000000000 +0200
@@ -1228,7 +1228,7 @@ static int dfx_open(struct net_device *d
 	
 	/* Register IRQ - support shared interrupts by passing device ptr */
 
-	ret = request_irq(dev->irq, dfx_interrupt, SA_SHIRQ, dev->name, dev);
+	ret = request_irq(dev->irq, dfx_interrupt, IRQF_SHARED, dev->name, dev);
 	if (ret) {
 		printk(KERN_ERR "%s: Requested IRQ %d is busy\n", dev->name, dev->irq);
 		return ret;
Index: linux-2.6.git/drivers/net/dgrs.c
===================================================================
--- linux-2.6.git.orig/drivers/net/dgrs.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/dgrs.c	2006-07-01 16:51:43.000000000 +0200
@@ -1191,7 +1191,7 @@ dgrs_probe1(struct net_device *dev)
 	if (priv->plxreg)
 		OUTL(dev->base_addr + PLX_LCL2PCI_DOORBELL, 1);
 	
-	rc = request_irq(dev->irq, &dgrs_intr, SA_SHIRQ, "RightSwitch", dev);
+	rc = request_irq(dev->irq, &dgrs_intr, IRQF_SHARED, "RightSwitch", dev);
 	if (rc)
 		goto err_out;
 
Index: linux-2.6.git/drivers/net/dl2k.c
===================================================================
--- linux-2.6.git.orig/drivers/net/dl2k.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/dl2k.c	2006-07-01 16:51:43.000000000 +0200
@@ -440,7 +440,7 @@ rio_open (struct net_device *dev)
 	int i;
 	u16 macctrl;
 	
-	i = request_irq (dev->irq, &rio_interrupt, SA_SHIRQ, dev->name, dev);
+	i = request_irq (dev->irq, &rio_interrupt, IRQF_SHARED, dev->name, dev);
 	if (i)
 		return i;
 	
Index: linux-2.6.git/drivers/net/dm9000.c
===================================================================
--- linux-2.6.git.orig/drivers/net/dm9000.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/dm9000.c	2006-07-01 16:51:43.000000000 +0200
@@ -603,7 +603,7 @@ dm9000_open(struct net_device *dev)
 
 	PRINTK2("entering dm9000_open\n");
 
-	if (request_irq(dev->irq, &dm9000_interrupt, SA_SHIRQ, dev->name, dev))
+	if (request_irq(dev->irq, &dm9000_interrupt, IRQF_SHARED, dev->name, dev))
 		return -EAGAIN;
 
 	/* Initialize DM9000 board */
Index: linux-2.6.git/drivers/net/e100.c
===================================================================
--- linux-2.6.git.orig/drivers/net/e100.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/e100.c	2006-07-01 16:51:43.000000000 +0200
@@ -2063,7 +2063,7 @@ static int e100_up(struct nic *nic)
 	e100_set_multicast_list(nic->netdev);
 	e100_start_receiver(nic, NULL);
 	mod_timer(&nic->watchdog, jiffies);
-	if((err = request_irq(nic->pdev->irq, e100_intr, SA_SHIRQ,
+	if((err = request_irq(nic->pdev->irq, e100_intr, IRQF_SHARED,
 		nic->netdev->name, nic->netdev)))
 		goto err_no_irq;
 	netif_wake_queue(nic->netdev);
Index: linux-2.6.git/drivers/net/eepro100.c
===================================================================
--- linux-2.6.git.orig/drivers/net/eepro100.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/eepro100.c	2006-07-01 16:51:43.000000000 +0200
@@ -977,7 +977,7 @@ speedo_open(struct net_device *dev)
 	sp->in_interrupt = 0;
 
 	/* .. we can safely take handler calls during init. */
-	retval = request_irq(dev->irq, &speedo_interrupt, SA_SHIRQ, dev->name, dev);
+	retval = request_irq(dev->irq, &speedo_interrupt, IRQF_SHARED, dev->name, dev);
 	if (retval) {
 		return retval;
 	}
Index: linux-2.6.git/drivers/net/eepro.c
===================================================================
--- linux-2.6.git.orig/drivers/net/eepro.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/eepro.c	2006-07-01 16:51:43.000000000 +0200
@@ -920,7 +920,7 @@ static int	eepro_grab_irq(struct net_dev
 
 		eepro_sw2bank0(ioaddr); /* Switch back to Bank 0 */
 
-		if (request_irq (*irqp, NULL, SA_SHIRQ, "bogus", dev) != EBUSY) {
+		if (request_irq (*irqp, NULL, IRQF_SHARED, "bogus", dev) != EBUSY) {
 			unsigned long irq_mask;
 			/* Twinkle the interrupt, and check if it's seen */
 			irq_mask = probe_irq_on();
Index: linux-2.6.git/drivers/net/epic100.c
===================================================================
--- linux-2.6.git.orig/drivers/net/epic100.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/epic100.c	2006-07-01 16:51:43.000000000 +0200
@@ -713,7 +713,7 @@ static int epic_open(struct net_device *
 	/* Soft reset the chip. */
 	outl(0x4001, ioaddr + GENCTL);
 
-	if ((retval = request_irq(dev->irq, &epic_interrupt, SA_SHIRQ, dev->name, dev)))
+	if ((retval = request_irq(dev->irq, &epic_interrupt, IRQF_SHARED, dev->name, dev)))
 		return retval;
 
 	epic_init_ring(dev);
Index: linux-2.6.git/drivers/net/fealnx.c
===================================================================
--- linux-2.6.git.orig/drivers/net/fealnx.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/fealnx.c	2006-07-01 16:51:43.000000000 +0200
@@ -834,7 +834,7 @@ static int netdev_open(struct net_device
 
 	iowrite32(0x00000001, ioaddr + BCR);	/* Reset */
 
-	if (request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev))
+	if (request_irq(dev->irq, &intr_handler, IRQF_SHARED, dev->name, dev))
 		return -EAGAIN;
 
 	for (i = 0; i < 3; i++)
Index: linux-2.6.git/drivers/net/forcedeth.c
===================================================================
--- linux-2.6.git.orig/drivers/net/forcedeth.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/forcedeth.c	2006-07-01 16:51:43.000000000 +0200
@@ -2622,21 +2622,21 @@ static int nv_request_irq(struct net_dev
 			np->msi_flags |= NV_MSI_X_ENABLED;
 			if (optimization_mode == NV_OPTIMIZATION_MODE_THROUGHPUT && !intr_test) {
 				/* Request irq for rx handling */
-				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector, &nv_nic_irq_rx, SA_SHIRQ, dev->name, dev) != 0) {
+				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector, &nv_nic_irq_rx, IRQF_SHARED, dev->name, dev) != 0) {
 					printk(KERN_INFO "forcedeth: request_irq failed for rx %d\n", ret);
 					pci_disable_msix(np->pci_dev);
 					np->msi_flags &= ~NV_MSI_X_ENABLED;
 					goto out_err;
 				}
 				/* Request irq for tx handling */
-				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector, &nv_nic_irq_tx, SA_SHIRQ, dev->name, dev) != 0) {
+				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector, &nv_nic_irq_tx, IRQF_SHARED, dev->name, dev) != 0) {
 					printk(KERN_INFO "forcedeth: request_irq failed for tx %d\n", ret);
 					pci_disable_msix(np->pci_dev);
 					np->msi_flags &= ~NV_MSI_X_ENABLED;
 					goto out_free_rx;
 				}
 				/* Request irq for link and timer handling */
-				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector, &nv_nic_irq_other, SA_SHIRQ, dev->name, dev) != 0) {
+				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector, &nv_nic_irq_other, IRQF_SHARED, dev->name, dev) != 0) {
 					printk(KERN_INFO "forcedeth: request_irq failed for link %d\n", ret);
 					pci_disable_msix(np->pci_dev);
 					np->msi_flags &= ~NV_MSI_X_ENABLED;
@@ -2651,9 +2651,9 @@ static int nv_request_irq(struct net_dev
 			} else {
 				/* Request irq for all interrupts */
 				if ((!intr_test &&
-				     request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector, &nv_nic_irq, SA_SHIRQ, dev->name, dev) != 0) ||
+				     request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector, &nv_nic_irq, IRQF_SHARED, dev->name, dev) != 0) ||
 				    (intr_test &&
-				     request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector, &nv_nic_irq_test, SA_SHIRQ, dev->name, dev) != 0)) {
+				     request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector, &nv_nic_irq_test, IRQF_SHARED, dev->name, dev) != 0)) {
 					printk(KERN_INFO "forcedeth: request_irq failed %d\n", ret);
 					pci_disable_msix(np->pci_dev);
 					np->msi_flags &= ~NV_MSI_X_ENABLED;
@@ -2669,8 +2669,8 @@ static int nv_request_irq(struct net_dev
 	if (ret != 0 && np->msi_flags & NV_MSI_CAPABLE) {
 		if ((ret = pci_enable_msi(np->pci_dev)) == 0) {
 			np->msi_flags |= NV_MSI_ENABLED;
-			if ((!intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq, SA_SHIRQ, dev->name, dev) != 0) ||
-			    (intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq_test, SA_SHIRQ, dev->name, dev) != 0)) {
+			if ((!intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq, IRQF_SHARED, dev->name, dev) != 0) ||
+			    (intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq_test, IRQF_SHARED, dev->name, dev) != 0)) {
 				printk(KERN_INFO "forcedeth: request_irq failed %d\n", ret);
 				pci_disable_msi(np->pci_dev);
 				np->msi_flags &= ~NV_MSI_ENABLED;
@@ -2685,8 +2685,8 @@ static int nv_request_irq(struct net_dev
 		}
 	}
 	if (ret != 0) {
-		if ((!intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq, SA_SHIRQ, dev->name, dev) != 0) ||
-		    (intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq_test, SA_SHIRQ, dev->name, dev) != 0))
+		if ((!intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq, IRQF_SHARED, dev->name, dev) != 0) ||
+		    (intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq_test, IRQF_SHARED, dev->name, dev) != 0))
 			goto out_err;
 
 	}
Index: linux-2.6.git/drivers/net/gt96100eth.c
===================================================================
--- linux-2.6.git.orig/drivers/net/gt96100eth.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/gt96100eth.c	2006-07-01 16:51:43.000000000 +0200
@@ -1030,7 +1030,7 @@ gt96100_open(struct net_device *dev)
 	}
 
 	if ((retval = request_irq(dev->irq, &gt96100_interrupt,
-				  SA_SHIRQ, dev->name, dev))) {
+				  IRQF_SHARED, dev->name, dev))) {
 		err("unable to get IRQ %d\n", dev->irq);
 		return retval;
 	}
Index: linux-2.6.git/drivers/net/hamachi.c
===================================================================
--- linux-2.6.git.orig/drivers/net/hamachi.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/hamachi.c	2006-07-01 16:51:43.000000000 +0200
@@ -871,7 +871,7 @@ static int hamachi_open(struct net_devic
 	u32 rx_int_var, tx_int_var;
 	u16 fifo_info;
 
-	i = request_irq(dev->irq, &hamachi_interrupt, SA_SHIRQ, dev->name, dev);
+	i = request_irq(dev->irq, &hamachi_interrupt, IRQF_SHARED, dev->name, dev);
 	if (i)
 		return i;
 
Index: linux-2.6.git/drivers/net/hp100.c
===================================================================
--- linux-2.6.git.orig/drivers/net/hp100.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/hp100.c	2006-07-01 16:51:43.000000000 +0200
@@ -1079,7 +1079,7 @@ static int hp100_open(struct net_device 
 	/* New: if bus is PCI or EISA, interrupts might be shared interrupts */
 	if (request_irq(dev->irq, hp100_interrupt,
 			lp->bus == HP100_BUS_PCI || lp->bus ==
-			HP100_BUS_EISA ? SA_SHIRQ : SA_INTERRUPT,
+			HP100_BUS_EISA ? IRQF_SHARED : IRQF_DISABLED,
 			"hp100", dev)) {
 		printk("hp100: %s: unable to get IRQ %d\n", dev->name, dev->irq);
 		return -EAGAIN;
Index: linux-2.6.git/drivers/net/hydra.c
===================================================================
--- linux-2.6.git.orig/drivers/net/hydra.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/hydra.c	2006-07-01 16:51:43.000000000 +0200
@@ -117,7 +117,7 @@ static int __devinit hydra_init(struct z
     dev->irq = IRQ_AMIGA_PORTS;
 
     /* Install the Interrupt handler */
-    if (request_irq(IRQ_AMIGA_PORTS, ei_interrupt, SA_SHIRQ, "Hydra Ethernet",
+    if (request_irq(IRQ_AMIGA_PORTS, ei_interrupt, IRQF_SHARED, "Hydra Ethernet",
 		    dev)) {
 	free_netdev(dev);
 	return -EAGAIN;
Index: linux-2.6.git/drivers/net/ibmlana.c
===================================================================
--- linux-2.6.git.orig/drivers/net/ibmlana.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/ibmlana.c	2006-07-01 16:51:43.000000000 +0200
@@ -782,7 +782,7 @@ static int ibmlana_open(struct net_devic
 
 	/* register resources - only necessary for IRQ */
 
-	result = request_irq(priv->realirq, irq_handler, SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
+	result = request_irq(priv->realirq, irq_handler, IRQF_SHARED | IRQF_SAMPLE_RANDOM, dev->name, dev);
 	if (result != 0) {
 		printk(KERN_ERR "%s: failed to register irq %d\n", dev->name, dev->irq);
 		return result;
Index: linux-2.6.git/drivers/net/ioc3-eth.c
===================================================================
--- linux-2.6.git.orig/drivers/net/ioc3-eth.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/ioc3-eth.c	2006-07-01 16:51:43.000000000 +0200
@@ -1063,7 +1063,7 @@ static int ioc3_open(struct net_device *
 {
 	struct ioc3_private *ip = netdev_priv(dev);
 
-	if (request_irq(dev->irq, ioc3_interrupt, SA_SHIRQ, ioc3_str, dev)) {
+	if (request_irq(dev->irq, ioc3_interrupt, IRQF_SHARED, ioc3_str, dev)) {
 		printk(KERN_ERR "%s: Can't get irq %d\n", dev->name, dev->irq);
 
 		return -EAGAIN;
Index: linux-2.6.git/drivers/net/jazzsonic.c
===================================================================
--- linux-2.6.git.orig/drivers/net/jazzsonic.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/jazzsonic.c	2006-07-01 16:51:43.000000000 +0200
@@ -260,7 +260,7 @@ MODULE_DESCRIPTION("Jazz SONIC ethernet 
 module_param(sonic_debug, int, 0);
 MODULE_PARM_DESC(sonic_debug, "jazzsonic debug level (1-4)");
 
-#define SONIC_IRQ_FLAG SA_INTERRUPT
+#define SONIC_IRQ_FLAG IRQF_DISABLED
 
 #include "sonic.c"
 
Index: linux-2.6.git/drivers/net/lp486e.c
===================================================================
--- linux-2.6.git.orig/drivers/net/lp486e.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/lp486e.c	2006-07-01 16:51:43.000000000 +0200
@@ -851,7 +851,7 @@ static int i596_open(struct net_device *
 {
 	int i;
 
-	i = request_irq(dev->irq, &i596_interrupt, SA_SHIRQ, dev->name, dev);
+	i = request_irq(dev->irq, &i596_interrupt, IRQF_SHARED, dev->name, dev);
 	if (i) {
 		printk(KERN_ERR "%s: IRQ %d not free\n", dev->name, dev->irq);
 		return i;
Index: linux-2.6.git/drivers/net/mipsnet.c
===================================================================
--- linux-2.6.git.orig/drivers/net/mipsnet.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/mipsnet.c	2006-07-01 16:51:43.000000000 +0200
@@ -179,7 +179,7 @@ static int mipsnet_open(struct net_devic
 	pr_debug("%s: mipsnet_open\n", dev->name);
 
 	err = request_irq(dev->irq, &mipsnet_interrupt,
-			  SA_SHIRQ, dev->name, (void *) dev);
+			  IRQF_SHARED, dev->name, (void *) dev);
 
 	if (err) {
 		pr_debug("%s: %s(): can't get irq %d\n",
Index: linux-2.6.git/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.6.git.orig/drivers/net/mv643xx_eth.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/mv643xx_eth.c	2006-07-01 16:51:43.000000000 +0200
@@ -778,7 +778,7 @@ static int mv643xx_eth_open(struct net_d
 	int err;
 
 	err = request_irq(dev->irq, mv643xx_eth_int_handler,
-			SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
+			IRQF_SHARED | IRQF_SAMPLE_RANDOM, dev->name, dev);
 	if (err) {
 		printk(KERN_ERR "Can not assign IRQ number to MV643XX_eth%d\n",
 								port_num);
Index: linux-2.6.git/drivers/net/myri_sbus.c
===================================================================
--- linux-2.6.git.orig/drivers/net/myri_sbus.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/myri_sbus.c	2006-07-01 16:51:43.000000000 +0200
@@ -1069,7 +1069,7 @@ static int __init myri_ether_init(struct
 	/* Register interrupt handler now. */
 	DET(("Requesting MYRIcom IRQ line.\n"));
 	if (request_irq(dev->irq, &myri_interrupt,
-			SA_SHIRQ, "MyriCOM Ethernet", (void *) dev)) {
+			IRQF_SHARED, "MyriCOM Ethernet", (void *) dev)) {
 		printk("MyriCOM: Cannot register interrupt handler.\n");
 		goto err;
 	}
Index: linux-2.6.git/drivers/net/natsemi.c
===================================================================
--- linux-2.6.git.orig/drivers/net/natsemi.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/natsemi.c	2006-07-01 16:51:43.000000000 +0200
@@ -1574,7 +1574,7 @@ static int netdev_open(struct net_device
 	/* Reset the chip, just in case. */
 	natsemi_reset(dev);
 
-	i = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
+	i = request_irq(dev->irq, &intr_handler, IRQF_SHARED, dev->name, dev);
 	if (i) return i;
 
 	if (netif_msg_ifup(np))
Index: linux-2.6.git/drivers/net/ne2k-pci.c
===================================================================
--- linux-2.6.git.orig/drivers/net/ne2k-pci.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/ne2k-pci.c	2006-07-01 16:51:43.000000000 +0200
@@ -420,7 +420,7 @@ static int ne2k_pci_set_fdx(struct net_d
 
 static int ne2k_pci_open(struct net_device *dev)
 {
-	int ret = request_irq(dev->irq, ei_interrupt, SA_SHIRQ, dev->name, dev);
+	int ret = request_irq(dev->irq, ei_interrupt, IRQF_SHARED, dev->name, dev);
 	if (ret)
 		return ret;
 
Index: linux-2.6.git/drivers/net/netx-eth.c
===================================================================
--- linux-2.6.git.orig/drivers/net/netx-eth.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/netx-eth.c	2006-07-01 16:51:43.000000000 +0200
@@ -223,7 +223,7 @@ static int netx_eth_open(struct net_devi
 	struct netx_eth_priv *priv = netdev_priv(ndev);
 
 	if (request_irq
-	    (ndev->irq, &netx_eth_interrupt, SA_SHIRQ, ndev->name, ndev))
+	    (ndev->irq, &netx_eth_interrupt, IRQF_SHARED, ndev->name, ndev))
 		return -EAGAIN;
 
 	writel(ndev->dev_addr[0] |
Index: linux-2.6.git/drivers/net/ns83820.c
===================================================================
--- linux-2.6.git.orig/drivers/net/ns83820.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/ns83820.c	2006-07-01 16:51:43.000000000 +0200
@@ -1881,7 +1881,7 @@ static int __devinit ns83820_init_one(st
 
 	dev->IMR_cache = 0;
 
-	err = request_irq(pci_dev->irq, ns83820_irq, SA_SHIRQ,
+	err = request_irq(pci_dev->irq, ns83820_irq, IRQF_SHARED,
 			  DRV_NAME, ndev);
 	if (err) {
 		printk(KERN_INFO "ns83820: unable to register irq %d\n",
Index: linux-2.6.git/drivers/net/pci-skeleton.c
===================================================================
--- linux-2.6.git.orig/drivers/net/pci-skeleton.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/pci-skeleton.c	2006-07-01 16:51:43.000000000 +0200
@@ -1075,7 +1075,7 @@ static int netdrv_open (struct net_devic
 
 	DPRINTK ("ENTER\n");
 
-	retval = request_irq (dev->irq, netdrv_interrupt, SA_SHIRQ, dev->name, dev);
+	retval = request_irq (dev->irq, netdrv_interrupt, IRQF_SHARED, dev->name, dev);
 	if (retval) {
 		DPRINTK ("EXIT, returning %d\n", retval);
 		return retval;
Index: linux-2.6.git/drivers/net/pcnet32.c
===================================================================
--- linux-2.6.git.orig/drivers/net/pcnet32.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/pcnet32.c	2006-07-01 16:51:43.000000000 +0200
@@ -1541,7 +1541,7 @@ static int pcnet32_open(struct net_devic
 	unsigned long flags;
 
 	if (request_irq(dev->irq, &pcnet32_interrupt,
-			lp->shared_irq ? SA_SHIRQ : 0, dev->name,
+			lp->shared_irq ? IRQF_SHARED : 0, dev->name,
 			(void *)dev)) {
 		return -EAGAIN;
 	}
Index: linux-2.6.git/drivers/net/r8169.c
===================================================================
--- linux-2.6.git.orig/drivers/net/r8169.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/r8169.c	2006-07-01 16:51:43.000000000 +0200
@@ -1726,7 +1726,7 @@ static int rtl8169_open(struct net_devic
 	rtl8169_set_rxbufsize(tp, dev);
 
 	retval =
-	    request_irq(dev->irq, rtl8169_interrupt, SA_SHIRQ, dev->name, dev);
+	    request_irq(dev->irq, rtl8169_interrupt, IRQF_SHARED, dev->name, dev);
 	if (retval < 0)
 		goto out;
 
Index: linux-2.6.git/drivers/net/rrunner.c
===================================================================
--- linux-2.6.git.orig/drivers/net/rrunner.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/rrunner.c	2006-07-01 16:51:43.000000000 +0200
@@ -1252,7 +1252,7 @@ static int rr_open(struct net_device *de
 	readl(&regs->HostCtrl);
 	spin_unlock_irqrestore(&rrpriv->lock, flags);
 
-	if (request_irq(dev->irq, rr_interrupt, SA_SHIRQ, dev->name, dev)) {
+	if (request_irq(dev->irq, rr_interrupt, IRQF_SHARED, dev->name, dev)) {
 		printk(KERN_WARNING "%s: Requested IRQ %d is busy\n",
 		       dev->name, dev->irq);
 		ecode = -EAGAIN;
Index: linux-2.6.git/drivers/net/s2io.c
===================================================================
--- linux-2.6.git.orig/drivers/net/s2io.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/s2io.c	2006-07-01 16:51:43.000000000 +0200
@@ -3761,7 +3761,7 @@ static int s2io_open(struct net_device *
 	/* After proper initialization of H/W, register ISR */
 	if (sp->intr_type == MSI) {
 		err = request_irq((int) sp->pdev->irq, s2io_msi_handle, 
-			SA_SHIRQ, sp->name, dev);
+			IRQF_SHARED, sp->name, dev);
 		if (err) {
 			DBG_PRINT(ERR_DBG, "%s: MSI registration \
 failed\n", dev->name);
@@ -3799,7 +3799,7 @@ failed\n", dev->name, i);
 		}
 	}
 	if (sp->intr_type == INTA) {
-		err = request_irq((int) sp->pdev->irq, s2io_isr, SA_SHIRQ,
+		err = request_irq((int) sp->pdev->irq, s2io_isr, IRQF_SHARED,
 				sp->name, dev);
 		if (err) {
 			DBG_PRINT(ERR_DBG, "%s: ISR registration failed\n",
Index: linux-2.6.git/drivers/net/sb1250-mac.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sb1250-mac.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sb1250-mac.c	2006-07-01 16:51:43.000000000 +0200
@@ -2450,7 +2450,7 @@ static int sbmac_open(struct net_device 
 	 */
 
 	__raw_readq(sc->sbm_isr);
-	if (request_irq(dev->irq, &sbmac_intr, SA_SHIRQ, dev->name, dev))
+	if (request_irq(dev->irq, &sbmac_intr, IRQF_SHARED, dev->name, dev))
 		return -EBUSY;
 
 	/*
Index: linux-2.6.git/drivers/net/sis190.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sis190.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sis190.c	2006-07-01 16:51:43.000000000 +0200
@@ -1054,7 +1054,7 @@ static int sis190_open(struct net_device
 
 	sis190_request_timer(dev);
 
-	rc = request_irq(dev->irq, sis190_interrupt, SA_SHIRQ, dev->name, dev);
+	rc = request_irq(dev->irq, sis190_interrupt, IRQF_SHARED, dev->name, dev);
 	if (rc < 0)
 		goto err_release_timer_2;
 
Index: linux-2.6.git/drivers/net/sis900.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sis900.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sis900.c	2006-07-01 16:51:43.000000000 +0200
@@ -1013,7 +1013,7 @@ sis900_open(struct net_device *net_dev)
 	/* Equalizer workaround Rule */
 	sis630_set_eq(net_dev, sis_priv->chipset_rev);
 
-	ret = request_irq(net_dev->irq, &sis900_interrupt, SA_SHIRQ,
+	ret = request_irq(net_dev->irq, &sis900_interrupt, IRQF_SHARED,
 						net_dev->name, net_dev);
 	if (ret)
 		return ret;
Index: linux-2.6.git/drivers/net/skge.c
===================================================================
--- linux-2.6.git.orig/drivers/net/skge.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/skge.c	2006-07-01 16:51:43.000000000 +0200
@@ -3341,7 +3341,7 @@ static int __devinit skge_probe(struct p
 		goto err_out_free_hw;
 	}
 
-	err = request_irq(pdev->irq, skge_intr, SA_SHIRQ, DRV_NAME, hw);
+	err = request_irq(pdev->irq, skge_intr, IRQF_SHARED, DRV_NAME, hw);
 	if (err) {
 		printk(KERN_ERR PFX "%s: cannot assign irq %d\n",
 		       pci_name(pdev), pdev->irq);
Index: linux-2.6.git/drivers/net/sk_mca.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sk_mca.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sk_mca.c	2006-07-01 16:51:43.000000000 +0200
@@ -824,7 +824,7 @@ static int skmca_open(struct net_device 
 	/* register resources - only necessary for IRQ */
 	result =
 	    request_irq(priv->realirq, irq_handler,
-			SA_SHIRQ | SA_SAMPLE_RANDOM, "sk_mca", dev);
+			IRQF_SHARED | IRQF_SAMPLE_RANDOM, "sk_mca", dev);
 	if (result != 0) {
 		printk("%s: failed to register irq %d\n", dev->name,
 		       dev->irq);
Index: linux-2.6.git/drivers/net/sky2.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sky2.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sky2.c	2006-07-01 16:51:43.000000000 +0200
@@ -3188,7 +3188,7 @@ static int __devinit sky2_test_msi(struc
 
 	sky2_write32(hw, B0_IMSK, Y2_IS_IRQ_SW);
 
-	err = request_irq(pdev->irq, sky2_test_intr, SA_SHIRQ, DRV_NAME, hw);
+	err = request_irq(pdev->irq, sky2_test_intr, IRQF_SHARED, DRV_NAME, hw);
 	if (err) {
 		printk(KERN_ERR PFX "%s: cannot assign irq %d\n",
 		       pci_name(pdev), pdev->irq);
@@ -3348,7 +3348,7 @@ static int __devinit sky2_probe(struct p
 			goto err_out_unregister;
  	}
 
-	err = request_irq(pdev->irq,  sky2_intr, SA_SHIRQ, DRV_NAME, hw);
+	err = request_irq(pdev->irq,  sky2_intr, IRQF_SHARED, DRV_NAME, hw);
 	if (err) {
 		printk(KERN_ERR PFX "%s: cannot assign irq %d\n",
 		       pci_name(pdev), pdev->irq);
Index: linux-2.6.git/drivers/net/smc911x.c
===================================================================
--- linux-2.6.git.orig/drivers/net/smc911x.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/smc911x.c	2006-07-01 16:51:43.000000000 +0200
@@ -2081,7 +2081,7 @@ static int __init smc911x_probe(struct n
 	lp->ctl_rspeed = 100;
 
 	/* Grab the IRQ */
-	retval = request_irq(dev->irq, &smc911x_interrupt, SA_SHIRQ, dev->name, dev);
+	retval = request_irq(dev->irq, &smc911x_interrupt, IRQF_SHARED, dev->name, dev);
 	if (retval)
 		goto err_out;
 
Index: linux-2.6.git/drivers/net/smc91x.h
===================================================================
--- linux-2.6.git.orig/drivers/net/smc91x.h	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/smc91x.h	2006-07-01 16:51:43.000000000 +0200
@@ -207,7 +207,7 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 		   machine_is_omap_h2() \
 		|| machine_is_omap_h3() \
 		|| (machine_is_omap_innovator() && !cpu_is_omap1510()) \
-	) ? SA_TRIGGER_FALLING : SA_TRIGGER_RISING)
+	) ? IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING)
 
 
 #elif	defined(CONFIG_SH_SH4202_MICRODEV)
@@ -540,7 +540,7 @@ smc_pxa_dma_irq(int dma, void *dummy, st
 #endif
 
 #ifndef	SMC_IRQ_FLAGS
-#define	SMC_IRQ_FLAGS		SA_TRIGGER_RISING
+#define	SMC_IRQ_FLAGS		IRQF_TRIGGER_RISING
 #endif
 
 #ifndef SMC_INTERRUPT_PREAMBLE
Index: linux-2.6.git/drivers/net/smc-ultra32.c
===================================================================
--- linux-2.6.git.orig/drivers/net/smc-ultra32.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/smc-ultra32.c	2006-07-01 16:51:43.000000000 +0200
@@ -290,7 +290,7 @@ out:
 static int ultra32_open(struct net_device *dev)
 {
 	int ioaddr = dev->base_addr - ULTRA32_NIC_OFFSET; /* ASIC addr */
-	int irq_flags = (inb(ioaddr + ULTRA32_CFG5) & 0x08) ? 0 : SA_SHIRQ;
+	int irq_flags = (inb(ioaddr + ULTRA32_CFG5) & 0x08) ? 0 : IRQF_SHARED;
 	int retval;
 
 	retval = request_irq(dev->irq, ei_interrupt, irq_flags, dev->name, dev);
Index: linux-2.6.git/drivers/net/spider_net.c
===================================================================
--- linux-2.6.git.orig/drivers/net/spider_net.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/spider_net.c	2006-07-01 16:51:43.000000000 +0200
@@ -1744,7 +1744,7 @@ spider_net_open(struct net_device *netde
 
 	result = -EBUSY;
 	if (request_irq(netdev->irq, spider_net_interrupt,
-			     SA_SHIRQ, netdev->name, netdev))
+			     IRQF_SHARED, netdev->name, netdev))
 		goto register_int_failed;
 
 	spider_net_enable_card(card);
Index: linux-2.6.git/drivers/net/starfire.c
===================================================================
--- linux-2.6.git.orig/drivers/net/starfire.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/starfire.c	2006-07-01 16:51:43.000000000 +0200
@@ -1070,7 +1070,7 @@ static int netdev_open(struct net_device
 
 	/* Do we ever need to reset the chip??? */
 
-	retval = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
+	retval = request_irq(dev->irq, &intr_handler, IRQF_SHARED, dev->name, dev);
 	if (retval)
 		return retval;
 
Index: linux-2.6.git/drivers/net/sun3lance.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sun3lance.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sun3lance.c	2006-07-01 16:51:43.000000000 +0200
@@ -341,7 +341,7 @@ static int __init lance_probe( struct ne
 
 	REGA(CSR0) = CSR0_STOP; 
 
-	request_irq(LANCE_IRQ, lance_interrupt, SA_INTERRUPT, "SUN3 Lance", dev);
+	request_irq(LANCE_IRQ, lance_interrupt, IRQF_DISABLED, "SUN3 Lance", dev);
 	dev->irq = (unsigned short)LANCE_IRQ;
 
 
Index: linux-2.6.git/drivers/net/sunbmac.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sunbmac.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sunbmac.c	2006-07-01 16:51:43.000000000 +0200
@@ -918,7 +918,7 @@ static int bigmac_open(struct net_device
 	struct bigmac *bp = (struct bigmac *) dev->priv;
 	int ret;
 
-	ret = request_irq(dev->irq, &bigmac_interrupt, SA_SHIRQ, dev->name, bp);
+	ret = request_irq(dev->irq, &bigmac_interrupt, IRQF_SHARED, dev->name, bp);
 	if (ret) {
 		printk(KERN_ERR "BIGMAC: Can't order irq %d to go.\n", dev->irq);
 		return ret;
Index: linux-2.6.git/drivers/net/sundance.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sundance.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sundance.c	2006-07-01 16:51:43.000000000 +0200
@@ -870,7 +870,7 @@ static int netdev_open(struct net_device
 
 	/* Do we need to reset the chip??? */
 
-	i = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
+	i = request_irq(dev->irq, &intr_handler, IRQF_SHARED, dev->name, dev);
 	if (i)
 		return i;
 
Index: linux-2.6.git/drivers/net/sungem.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sungem.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sungem.c	2006-07-01 16:51:43.000000000 +0200
@@ -2220,7 +2220,7 @@ static int gem_do_start(struct net_devic
 	spin_unlock_irqrestore(&gp->lock, flags);
 
 	if (request_irq(gp->pdev->irq, gem_interrupt,
-				   SA_SHIRQ, dev->name, (void *)dev)) {
+				   IRQF_SHARED, dev->name, (void *)dev)) {
 		printk(KERN_ERR "%s: failed to request irq !\n", gp->dev->name);
 
 		spin_lock_irqsave(&gp->lock, flags);
Index: linux-2.6.git/drivers/net/sunhme.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sunhme.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sunhme.c	2006-07-01 16:51:43.000000000 +0200
@@ -2194,7 +2194,7 @@ static int happy_meal_open(struct net_de
 	 */
 	if ((hp->happy_flags & (HFLAG_QUATTRO|HFLAG_PCI)) != HFLAG_QUATTRO) {
 		if (request_irq(dev->irq, &happy_meal_interrupt,
-				SA_SHIRQ, dev->name, (void *)dev)) {
+				IRQF_SHARED, dev->name, (void *)dev)) {
 			HMD(("EAGAIN\n"));
 			printk(KERN_ERR "happy_meal(SBUS): Can't order irq %d to go.\n",
 			       dev->irq);
@@ -2608,7 +2608,7 @@ static void __init quattro_sbus_register
 
 		err = request_irq(sdev->irqs[0],
 				  quattro_sbus_interrupt,
-				  SA_SHIRQ, "Quattro",
+				  IRQF_SHARED, "Quattro",
 				  qp);
 		if (err != 0) {
 			printk(KERN_ERR "Quattro: Fatal IRQ registery error %d.\n", err);
Index: linux-2.6.git/drivers/net/sunlance.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sunlance.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sunlance.c	2006-07-01 16:51:43.000000000 +0200
@@ -930,7 +930,7 @@ static int lance_open(struct net_device 
 
 	STOP_LANCE(lp);
 
-	if (request_irq(dev->irq, &lance_interrupt, SA_SHIRQ,
+	if (request_irq(dev->irq, &lance_interrupt, IRQF_SHARED,
 			lancestr, (void *) dev)) {
 		printk(KERN_ERR "Lance: Can't get irq %d\n", dev->irq);
 		return -EAGAIN;
Index: linux-2.6.git/drivers/net/sunqe.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sunqe.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sunqe.c	2006-07-01 16:51:43.000000000 +0200
@@ -811,7 +811,7 @@ static struct sunqec * __init get_qec(st
 			qec_init_once(qecp, qec_sdev);
 
 			if (request_irq(qec_sdev->irqs[0], &qec_interrupt,
-					SA_SHIRQ, "qec", (void *) qecp)) {
+					IRQF_SHARED, "qec", (void *) qecp)) {
 				printk(KERN_ERR "qec: Can't register irq.\n");
 				goto fail;
 			}
Index: linux-2.6.git/drivers/net/tc35815.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tc35815.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tc35815.c	2006-07-01 16:51:43.000000000 +0200
@@ -880,7 +880,7 @@ tc35815_open(struct net_device *dev)
 	 */
 
 	if (dev->irq == 0  ||
-	    request_irq(dev->irq, &tc35815_interrupt, SA_SHIRQ, cardname, dev)) {
+	    request_irq(dev->irq, &tc35815_interrupt, IRQF_SHARED, cardname, dev)) {
 		return -EAGAIN;
 	}
 
Index: linux-2.6.git/drivers/net/tg3.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tg3.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tg3.c	2006-07-01 16:51:43.000000000 +0200
@@ -6702,12 +6702,12 @@ static int tg3_request_irq(struct tg3 *t
 		fn = tg3_msi;
 		if (tp->tg3_flags2 & TG3_FLG2_1SHOT_MSI)
 			fn = tg3_msi_1shot;
-		flags = SA_SAMPLE_RANDOM;
+		flags = IRQF_SAMPLE_RANDOM;
 	} else {
 		fn = tg3_interrupt;
 		if (tp->tg3_flags & TG3_FLAG_TAGGED_STATUS)
 			fn = tg3_interrupt_tagged;
-		flags = SA_SHIRQ | SA_SAMPLE_RANDOM;
+		flags = IRQF_SHARED | IRQF_SAMPLE_RANDOM;
 	}
 	return (request_irq(tp->pdev->irq, fn, flags, dev->name, dev));
 }
@@ -6726,7 +6726,7 @@ static int tg3_test_interrupt(struct tg3
 	free_irq(tp->pdev->irq, dev);
 
 	err = request_irq(tp->pdev->irq, tg3_test_isr,
-			  SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
+			  IRQF_SHARED | IRQF_SAMPLE_RANDOM, dev->name, dev);
 	if (err)
 		return err;
 
Index: linux-2.6.git/drivers/net/tlan.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tlan.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tlan.c	2006-07-01 16:51:43.000000000 +0200
@@ -943,7 +943,7 @@ static int TLan_Open( struct net_device 
 	int		err;
 	
 	priv->tlanRev = TLan_DioRead8( dev->base_addr, TLAN_DEF_REVISION );
-	err = request_irq( dev->irq, TLan_HandleInterrupt, SA_SHIRQ, TLanSignature, dev );
+	err = request_irq( dev->irq, TLan_HandleInterrupt, IRQF_SHARED, TLanSignature, dev );
 	
 	if ( err ) {
 		printk(KERN_ERR "TLAN:  Cannot open %s because IRQ %d is already in use.\n", dev->name, dev->irq );
Index: linux-2.6.git/drivers/net/typhoon.c
===================================================================
--- linux-2.6.git.orig/drivers/net/typhoon.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/typhoon.c	2006-07-01 16:51:43.000000000 +0200
@@ -2131,7 +2131,7 @@ typhoon_open(struct net_device *dev)
 		goto out_sleep;
 	}
 
-	err = request_irq(dev->irq, &typhoon_interrupt, SA_SHIRQ,
+	err = request_irq(dev->irq, &typhoon_interrupt, IRQF_SHARED,
 				dev->name, dev);
 	if(err < 0)
 		goto out_sleep;
Index: linux-2.6.git/drivers/net/via-rhine.c
===================================================================
--- linux-2.6.git.orig/drivers/net/via-rhine.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/via-rhine.c	2006-07-01 16:51:43.000000000 +0200
@@ -1210,7 +1210,7 @@ static int rhine_open(struct net_device 
 	void __iomem *ioaddr = rp->base;
 	int rc;
 
-	rc = request_irq(rp->pdev->irq, &rhine_interrupt, SA_SHIRQ, dev->name,
+	rc = request_irq(rp->pdev->irq, &rhine_interrupt, IRQF_SHARED, dev->name,
 			dev);
 	if (rc)
 		return rc;
@@ -1999,7 +1999,7 @@ static int rhine_resume(struct pci_dev *
 	if (!netif_running(dev))
 		return 0;
 
-        if (request_irq(dev->irq, rhine_interrupt, SA_SHIRQ, dev->name, dev))
+        if (request_irq(dev->irq, rhine_interrupt, IRQF_SHARED, dev->name, dev))
 		printk(KERN_ERR "via-rhine %s: request_irq failed\n", dev->name);
 
 	ret = pci_set_power_state(pdev, PCI_D0);
Index: linux-2.6.git/drivers/net/via-velocity.c
===================================================================
--- linux-2.6.git.orig/drivers/net/via-velocity.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/via-velocity.c	2006-07-01 16:51:43.000000000 +0200
@@ -1750,7 +1750,7 @@ static int velocity_open(struct net_devi
 	
 	velocity_init_registers(vptr, VELOCITY_INIT_COLD);
 
-	ret = request_irq(vptr->pdev->irq, &velocity_intr, SA_SHIRQ,
+	ret = request_irq(vptr->pdev->irq, &velocity_intr, IRQF_SHARED,
 			  dev->name, dev);
 	if (ret < 0) {
 		/* Power down the chip */
Index: linux-2.6.git/drivers/net/yellowfin.c
===================================================================
--- linux-2.6.git.orig/drivers/net/yellowfin.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/yellowfin.c	2006-07-01 16:51:43.000000000 +0200
@@ -602,7 +602,7 @@ static int yellowfin_open(struct net_dev
 	/* Reset the chip. */
 	iowrite32(0x80000000, ioaddr + DMACtrl);
 
-	i = request_irq(dev->irq, &yellowfin_interrupt, SA_SHIRQ, dev->name, dev);
+	i = request_irq(dev->irq, &yellowfin_interrupt, IRQF_SHARED, dev->name, dev);
 	if (i) return i;
 
 	if (yellowfin_debug > 1)
Index: linux-2.6.git/drivers/net/zorro8390.c
===================================================================
--- linux-2.6.git.orig/drivers/net/zorro8390.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/zorro8390.c	2006-07-01 16:51:43.000000000 +0200
@@ -201,7 +201,7 @@ static int __devinit zorro8390_init(stru
     dev->irq = IRQ_AMIGA_PORTS;
 
     /* Install the Interrupt handler */
-    i = request_irq(IRQ_AMIGA_PORTS, ei_interrupt, SA_SHIRQ, DRV_NAME, dev);
+    i = request_irq(IRQ_AMIGA_PORTS, ei_interrupt, IRQF_SHARED, DRV_NAME, dev);
     if (i) return i;
 
     for(i = 0; i < ETHER_ADDR_LEN; i++) {
Index: linux-2.6.git/drivers/net/arcnet/com20020-pci.c
===================================================================
--- linux-2.6.git.orig/drivers/net/arcnet/com20020-pci.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/arcnet/com20020-pci.c	2006-07-01 16:51:43.000000000 +0200
@@ -120,7 +120,7 @@ static int __devinit com20020pci_probe(s
 		goto out_port;
 	}
 
-	if ((err = com20020_found(dev, SA_SHIRQ)) != 0)
+	if ((err = com20020_found(dev, IRQF_SHARED)) != 0)
 	        goto out_port;
 
 	return 0;
Index: linux-2.6.git/drivers/net/chelsio/cxgb2.c
===================================================================
--- linux-2.6.git.orig/drivers/net/chelsio/cxgb2.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/chelsio/cxgb2.c	2006-07-01 16:51:43.000000000 +0200
@@ -218,7 +218,7 @@ static int cxgb_up(struct adapter *adapt
 
 	t1_interrupts_clear(adapter);
 	if ((err = request_irq(adapter->pdev->irq,
-			       t1_select_intr_handler(adapter), SA_SHIRQ,
+			       t1_select_intr_handler(adapter), IRQF_SHARED,
 			       adapter->name, adapter))) {
 		goto out_err;
 	}
Index: linux-2.6.git/drivers/net/cris/eth_v10.c
===================================================================
--- linux-2.6.git.orig/drivers/net/cris/eth_v10.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/cris/eth_v10.c	2006-07-01 16:51:43.000000000 +0200
@@ -671,7 +671,7 @@ e100_open(struct net_device *dev)
 	/* allocate the irq corresponding to the receiving DMA */
 
 	if (request_irq(NETWORK_DMA_RX_IRQ_NBR, e100rxtx_interrupt,
-			SA_SAMPLE_RANDOM, cardname, (void *)dev)) {
+			IRQF_SAMPLE_RANDOM, cardname, (void *)dev)) {
 		goto grace_exit0;
 	}
 
Index: linux-2.6.git/drivers/net/e1000/e1000_ethtool.c
===================================================================
--- linux-2.6.git.orig/drivers/net/e1000/e1000_ethtool.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/e1000/e1000_ethtool.c	2006-07-01 16:51:43.000000000 +0200
@@ -871,10 +871,10 @@ e1000_intr_test(struct e1000_adapter *ad
 	*data = 0;
 
 	/* Hook up test interrupt handler just for this test */
-	if (!request_irq(irq, &e1000_test_intr, SA_PROBEIRQ, netdev->name,
-	                 netdev)) {
+	if (!request_irq(irq, &e1000_test_intr, IRQF_PROBE_SHARED,
+			 netdev->name, netdev)) {
  		shared_int = FALSE;
- 	} else if (request_irq(irq, &e1000_test_intr, SA_SHIRQ,
+ 	} else if (request_irq(irq, &e1000_test_intr, IRQF_SHARED,
 			      netdev->name, netdev)){
 		*data = 1;
 		return -1;
Index: linux-2.6.git/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.git.orig/drivers/net/e1000/e1000_main.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/e1000/e1000_main.c	2006-07-01 16:51:43.000000000 +0200
@@ -426,7 +426,7 @@ e1000_up(struct e1000_adapter *adapter)
 	}
 #endif
 	if ((err = request_irq(adapter->pdev->irq, &e1000_intr,
-		              SA_SHIRQ | SA_SAMPLE_RANDOM,
+		              IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 		              netdev->name, netdev))) {
 		DPRINTK(PROBE, ERR,
 		    "Unable to allocate interrupt Error: %d\n", err);
Index: linux-2.6.git/drivers/net/fs_enet/fs_enet-main.c
===================================================================
--- linux-2.6.git.orig/drivers/net/fs_enet/fs_enet-main.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/fs_enet/fs_enet-main.c	2006-07-01 16:51:43.000000000 +0200
@@ -671,7 +671,7 @@ static int fs_request_irq(struct net_dev
 	struct fs_enet_private *fep = netdev_priv(dev);
 
 	(*fep->ops->pre_request_irq)(dev, irq);
-	return request_irq(irq, irqf, SA_SHIRQ, name, dev);
+	return request_irq(irq, irqf, IRQF_SHARED, name, dev);
 }
 
 static void fs_free_irq(struct net_device *dev, int irq)
Index: linux-2.6.git/drivers/net/hamradio/baycom_ser_fdx.c
===================================================================
--- linux-2.6.git.orig/drivers/net/hamradio/baycom_ser_fdx.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/hamradio/baycom_ser_fdx.c	2006-07-01 16:51:43.000000000 +0200
@@ -434,7 +434,7 @@ static int ser12_open(struct net_device 
 	outb(0, FCR(dev->base_addr));  /* disable FIFOs */
 	outb(0x0d, MCR(dev->base_addr));
 	outb(0, IER(dev->base_addr));
-	if (request_irq(dev->irq, ser12_interrupt, SA_INTERRUPT | SA_SHIRQ,
+	if (request_irq(dev->irq, ser12_interrupt, IRQF_DISABLED | IRQF_SHARED,
 			"baycom_ser_fdx", dev)) {
 		release_region(dev->base_addr, SER12_EXTENT);
 		return -EBUSY;
Index: linux-2.6.git/drivers/net/hamradio/baycom_ser_hdx.c
===================================================================
--- linux-2.6.git.orig/drivers/net/hamradio/baycom_ser_hdx.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/hamradio/baycom_ser_hdx.c	2006-07-01 16:51:43.000000000 +0200
@@ -488,7 +488,7 @@ static int ser12_open(struct net_device 
 	outb(0, FCR(dev->base_addr));  /* disable FIFOs */
 	outb(0x0d, MCR(dev->base_addr));
 	outb(0, IER(dev->base_addr));
-	if (request_irq(dev->irq, ser12_interrupt, SA_INTERRUPT | SA_SHIRQ,
+	if (request_irq(dev->irq, ser12_interrupt, IRQF_DISABLED | IRQF_SHARED,
 			"baycom_ser12", dev)) {
 		release_region(dev->base_addr, SER12_EXTENT);       
 		return -EBUSY;
Index: linux-2.6.git/drivers/net/hamradio/scc.c
===================================================================
--- linux-2.6.git.orig/drivers/net/hamradio/scc.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/hamradio/scc.c	2006-07-01 16:51:43.000000000 +0200
@@ -1736,7 +1736,7 @@ static int scc_net_ioctl(struct net_devi
 				
 			if (!Ivec[hwcfg.irq].used && hwcfg.irq)
 			{
-				if (request_irq(hwcfg.irq, scc_isr, SA_INTERRUPT, "AX.25 SCC", NULL))
+				if (request_irq(hwcfg.irq, scc_isr, IRQF_DISABLED, "AX.25 SCC", NULL))
 					printk(KERN_WARNING "z8530drv: warning, cannot get IRQ %d\n", hwcfg.irq);
 				else
 					Ivec[hwcfg.irq].used = 1;
Index: linux-2.6.git/drivers/net/hamradio/yam.c
===================================================================
--- linux-2.6.git.orig/drivers/net/hamradio/yam.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/hamradio/yam.c	2006-07-01 16:51:43.000000000 +0200
@@ -873,7 +873,7 @@ static int yam_open(struct net_device *d
 		goto out_release_base;
 	}
 	outb(0, IER(dev->base_addr));
-	if (request_irq(dev->irq, yam_interrupt, SA_INTERRUPT | SA_SHIRQ, dev->name, dev)) {
+	if (request_irq(dev->irq, yam_interrupt, IRQF_DISABLED | IRQF_SHARED, dev->name, dev)) {
 		printk(KERN_ERR "%s: irq %d busy\n", dev->name, dev->irq);
 		ret = -EBUSY;
 		goto out_release_base;
Index: linux-2.6.git/drivers/net/irda/donauboe.c
===================================================================
--- linux-2.6.git.orig/drivers/net/irda/donauboe.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/irda/donauboe.c	2006-07-01 16:51:43.000000000 +0200
@@ -1372,7 +1372,7 @@ toshoboe_net_open (struct net_device *de
     return 0;
 
   if (request_irq (self->io.irq, toshoboe_interrupt,
-                   SA_SHIRQ | SA_INTERRUPT, dev->name, (void *) self))
+                   IRQF_SHARED | IRQF_DISABLED, dev->name, (void *) self))
     {
       return -EAGAIN;
     }
@@ -1573,7 +1573,7 @@ toshoboe_open (struct pci_dev *pci_dev, 
   self->io.fir_base = self->base;
   self->io.fir_ext = OBOE_IO_EXTENT;
   self->io.irq = pci_dev->irq;
-  self->io.irqflags = SA_SHIRQ | SA_INTERRUPT;
+  self->io.irqflags = IRQF_SHARED | IRQF_DISABLED;
 
   self->speed = self->io.speed = 9600;
   self->async = 0;
Index: linux-2.6.git/drivers/net/irda/vlsi_ir.c
===================================================================
--- linux-2.6.git.orig/drivers/net/irda/vlsi_ir.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/irda/vlsi_ir.c	2006-07-01 16:51:43.000000000 +0200
@@ -1517,7 +1517,7 @@ static int vlsi_open(struct net_device *
 
 	outb(IRINTR_INT_MASK, ndev->base_addr+VLSI_PIO_IRINTR);
 
-	if (request_irq(ndev->irq, vlsi_interrupt, SA_SHIRQ,
+	if (request_irq(ndev->irq, vlsi_interrupt, IRQF_SHARED,
 			drivername, ndev)) {
 		IRDA_WARNING("%s: couldn't get IRQ: %d\n",
 			     __FUNCTION__, ndev->irq);
Index: linux-2.6.git/drivers/net/ixgb/ixgb_main.c
===================================================================
--- linux-2.6.git.orig/drivers/net/ixgb/ixgb_main.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/ixgb/ixgb_main.c	2006-07-01 16:51:43.000000000 +0200
@@ -253,7 +253,7 @@ ixgb_up(struct ixgb_adapter *adapter)
 
 #endif
 	if((err = request_irq(adapter->pdev->irq, &ixgb_intr,
-				  SA_SHIRQ | SA_SAMPLE_RANDOM,
+				  IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			          netdev->name, netdev))) {
 		DPRINTK(PROBE, ERR,
 		 "Unable to allocate interrupt Error: %d\n", err);
Index: linux-2.6.git/drivers/net/ixp2000/ixpdev.c
===================================================================
--- linux-2.6.git.orig/drivers/net/ixp2000/ixpdev.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/ixp2000/ixpdev.c	2006-07-01 16:51:43.000000000 +0200
@@ -235,7 +235,7 @@ static int ixpdev_open(struct net_device
 
 	if (!nds_open++) {
 		err = request_irq(IRQ_IXP2000_THDA0, ixpdev_interrupt,
-					SA_SHIRQ, "ixp2000_eth", nds);
+					IRQF_SHARED, "ixp2000_eth", nds);
 		if (err) {
 			nds_open--;
 			return err;
Index: linux-2.6.git/drivers/net/myri10ge/myri10ge.c
===================================================================
--- linux-2.6.git.orig/drivers/net/myri10ge/myri10ge.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/myri10ge/myri10ge.c	2006-07-01 16:51:43.000000000 +0200
@@ -2413,7 +2413,7 @@ static int myri10ge_resume(struct pci_de
 	pci_enable_device(pdev);
 	pci_set_master(pdev);
 
-	status = request_irq(pdev->irq, myri10ge_intr, SA_SHIRQ,
+	status = request_irq(pdev->irq, myri10ge_intr, IRQF_SHARED,
 			     netdev->name, mgp);
 	if (status != 0) {
 		dev_err(&pdev->dev, "failed to allocate IRQ\n");
@@ -2694,7 +2694,7 @@ static int myri10ge_probe(struct pci_dev
 			mgp->msi_enabled = 1;
 	}
 
-	status = request_irq(pdev->irq, myri10ge_intr, SA_SHIRQ,
+	status = request_irq(pdev->irq, myri10ge_intr, IRQF_SHARED,
 			     netdev->name, mgp);
 	if (status != 0) {
 		dev_err(&pdev->dev, "failed to allocate IRQ\n");
Index: linux-2.6.git/drivers/net/pcmcia/axnet_cs.c
===================================================================
--- linux-2.6.git.orig/drivers/net/pcmcia/axnet_cs.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/pcmcia/axnet_cs.c	2006-07-01 16:51:43.000000000 +0200
@@ -535,7 +535,7 @@ static int axnet_open(struct net_device 
 
     link->open++;
 
-    request_irq(dev->irq, ei_irq_wrapper, SA_SHIRQ, "axnet_cs", dev);
+    request_irq(dev->irq, ei_irq_wrapper, IRQF_SHARED, "axnet_cs", dev);
 
     info->link_status = 0x00;
     init_timer(&info->watchdog);
Index: linux-2.6.git/drivers/net/pcmcia/pcnet_cs.c
===================================================================
--- linux-2.6.git.orig/drivers/net/pcmcia/pcnet_cs.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/pcmcia/pcnet_cs.c	2006-07-01 16:51:43.000000000 +0200
@@ -998,7 +998,7 @@ static int pcnet_open(struct net_device 
     link->open++;
 
     set_misc_reg(dev);
-    request_irq(dev->irq, ei_irq_wrapper, SA_SHIRQ, dev_info, dev);
+    request_irq(dev->irq, ei_irq_wrapper, IRQF_SHARED, dev_info, dev);
 
     info->phy_id = info->eth_phy;
     info->link_status = 0x00;
Index: linux-2.6.git/drivers/net/phy/phy.c
===================================================================
--- linux-2.6.git.orig/drivers/net/phy/phy.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/phy/phy.c	2006-07-01 16:51:43.000000000 +0200
@@ -556,7 +556,7 @@ int phy_start_interrupts(struct phy_devi
 	INIT_WORK(&phydev->phy_queue, phy_change, phydev);
 
 	if (request_irq(phydev->irq, phy_interrupt,
-				SA_SHIRQ,
+				IRQF_SHARED,
 				"phy_interrupt",
 				phydev) < 0) {
 		printk(KERN_WARNING "%s: Can't get IRQ %d (PHY)\n",
Index: linux-2.6.git/drivers/net/sk98lin/skge.c
===================================================================
--- linux-2.6.git.orig/drivers/net/sk98lin/skge.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/sk98lin/skge.c	2006-07-01 16:51:43.000000000 +0200
@@ -570,9 +570,9 @@ SK_BOOL	DualNet;
 	spin_unlock_irqrestore(&pAC->SlowPathLock, Flags);
 
 	if (pAC->GIni.GIMacsFound == 2) {
-		 Ret = request_irq(dev->irq, SkGeIsr, SA_SHIRQ, "sk98lin", dev);
+		 Ret = request_irq(dev->irq, SkGeIsr, IRQF_SHARED, "sk98lin", dev);
 	} else if (pAC->GIni.GIMacsFound == 1) {
-		Ret = request_irq(dev->irq, SkGeIsrOnePort, SA_SHIRQ,
+		Ret = request_irq(dev->irq, SkGeIsrOnePort, IRQF_SHARED,
 			"sk98lin", dev);
 	} else {
 		printk(KERN_WARNING "sk98lin: Illegal number of ports: %d\n",
@@ -5073,9 +5073,9 @@ static int skge_resume(struct pci_dev *p
 	pci_enable_device(pdev);
 	pci_set_master(pdev);
 	if (pAC->GIni.GIMacsFound == 2)
-		ret = request_irq(dev->irq, SkGeIsr, SA_SHIRQ, "sk98lin", dev);
+		ret = request_irq(dev->irq, SkGeIsr, IRQF_SHARED, "sk98lin", dev);
 	else
-		ret = request_irq(dev->irq, SkGeIsrOnePort, SA_SHIRQ, "sk98lin", dev);
+		ret = request_irq(dev->irq, SkGeIsrOnePort, IRQF_SHARED, "sk98lin", dev);
 	if (ret) {
 		printk(KERN_WARNING "sk98lin: unable to acquire IRQ %d\n", dev->irq);
 		pAC->AllocFlag &= ~SK_ALLOC_IRQ;
Index: linux-2.6.git/drivers/net/skfp/skfddi.c
===================================================================
--- linux-2.6.git.orig/drivers/net/skfp/skfddi.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/skfp/skfddi.c	2006-07-01 16:51:43.000000000 +0200
@@ -497,7 +497,7 @@ static int skfp_open(struct net_device *
 
 	PRINTK(KERN_INFO "entering skfp_open\n");
 	/* Register IRQ - support shared interrupts by passing device ptr */
-	err = request_irq(dev->irq, (void *) skfp_interrupt, SA_SHIRQ,
+	err = request_irq(dev->irq, (void *) skfp_interrupt, IRQF_SHARED,
 			  dev->name, dev);
 	if (err)
 		return err;
Index: linux-2.6.git/drivers/net/tokenring/3c359.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tokenring/3c359.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tokenring/3c359.c	2006-07-01 16:51:43.000000000 +0200
@@ -576,7 +576,7 @@ static int xl_open(struct net_device *de
 
 	u16 switchsettings, switchsettings_eeprom  ;
  
-	if(request_irq(dev->irq, &xl_interrupt, SA_SHIRQ , "3c359", dev)) {
+	if(request_irq(dev->irq, &xl_interrupt, IRQF_SHARED , "3c359", dev)) {
 		return -EAGAIN;
 	}
 
Index: linux-2.6.git/drivers/net/tokenring/abyss.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tokenring/abyss.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tokenring/abyss.c	2006-07-01 16:51:43.000000000 +0200
@@ -123,7 +123,7 @@ static int __devinit abyss_attach(struct
 		goto err_out_trdev;
 	}
 		
-	ret = request_irq(pdev->irq, tms380tr_interrupt, SA_SHIRQ,
+	ret = request_irq(pdev->irq, tms380tr_interrupt, IRQF_SHARED,
 			  dev->name, dev);
 	if (ret)
 		goto err_out_region;
Index: linux-2.6.git/drivers/net/tokenring/lanstreamer.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tokenring/lanstreamer.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tokenring/lanstreamer.c	2006-07-01 16:51:43.000000000 +0200
@@ -601,7 +601,7 @@ static int streamer_open(struct net_devi
 	        rc=streamer_reset(dev);
 	}
 
-	if (request_irq(dev->irq, &streamer_interrupt, SA_SHIRQ, "lanstreamer", dev)) {
+	if (request_irq(dev->irq, &streamer_interrupt, IRQF_SHARED, "lanstreamer", dev)) {
 		return -EAGAIN;
 	}
 #if STREAMER_DEBUG
Index: linux-2.6.git/drivers/net/tokenring/madgemc.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tokenring/madgemc.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tokenring/madgemc.c	2006-07-01 16:51:43.000000000 +0200
@@ -311,7 +311,7 @@ static int __devinit madgemc_probe(struc
 	 */ 
 	outb(0, dev->base_addr + MC_CONTROL_REG0); /* sanity */
 	madgemc_setsifsel(dev, 1);
-	if (request_irq(dev->irq, madgemc_interrupt, SA_SHIRQ,
+	if (request_irq(dev->irq, madgemc_interrupt, IRQF_SHARED,
 		       "madgemc", dev)) {
 		ret = -EBUSY;
 		goto getout3;
Index: linux-2.6.git/drivers/net/tokenring/olympic.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tokenring/olympic.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tokenring/olympic.c	2006-07-01 16:51:43.000000000 +0200
@@ -445,7 +445,7 @@ static int olympic_open(struct net_devic
 
 	olympic_init(dev);
 
-	if(request_irq(dev->irq, &olympic_interrupt, SA_SHIRQ , "olympic", dev)) {
+	if(request_irq(dev->irq, &olympic_interrupt, IRQF_SHARED , "olympic", dev)) {
 		return -EAGAIN;
 	}
 
Index: linux-2.6.git/drivers/net/tokenring/smctr.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tokenring/smctr.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tokenring/smctr.c	2006-07-01 16:51:43.000000000 +0200
@@ -531,7 +531,7 @@ static int __init smctr_chk_mca(struct n
 			dev->irq = 15;
                		break;
 	}
-	if (request_irq(dev->irq, smctr_interrupt, SA_SHIRQ, smctr_name, dev)) {
+	if (request_irq(dev->irq, smctr_interrupt, IRQF_SHARED, smctr_name, dev)) {
 		release_region(dev->base_addr, SMCTR_IO_EXTENT);
 		return -ENODEV;
 	}
@@ -1061,7 +1061,7 @@ static int __init smctr_chk_isa(struct n
                         goto out2;
          }
 
-        if (request_irq(dev->irq, smctr_interrupt, SA_SHIRQ, smctr_name, dev))
+        if (request_irq(dev->irq, smctr_interrupt, IRQF_SHARED, smctr_name, dev))
                 goto out2;
 
         /* Get 58x Rom Base */
Index: linux-2.6.git/drivers/net/tokenring/tmspci.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tokenring/tmspci.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tokenring/tmspci.c	2006-07-01 16:51:43.000000000 +0200
@@ -122,7 +122,7 @@ static int __devinit tms_pci_attach(stru
 		goto err_out_trdev;
 	}
 
-	ret = request_irq(pdev->irq, tms380tr_interrupt, SA_SHIRQ,
+	ret = request_irq(pdev->irq, tms380tr_interrupt, IRQF_SHARED,
 			  dev->name, dev);
 	if (ret)
 		goto err_out_region;
Index: linux-2.6.git/drivers/net/tulip/de2104x.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tulip/de2104x.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tulip/de2104x.c	2006-07-01 16:51:43.000000000 +0200
@@ -1371,7 +1371,7 @@ static int de_open (struct net_device *d
 
 	dw32(IntrMask, 0);
 
-	rc = request_irq(dev->irq, de_interrupt, SA_SHIRQ, dev->name, dev);
+	rc = request_irq(dev->irq, de_interrupt, IRQF_SHARED, dev->name, dev);
 	if (rc) {
 		printk(KERN_ERR "%s: IRQ %d request failure, err=%d\n",
 		       dev->name, dev->irq, rc);
Index: linux-2.6.git/drivers/net/tulip/de4x5.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tulip/de4x5.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tulip/de4x5.c	2006-07-01 16:51:43.000000000 +0200
@@ -292,7 +292,7 @@
       0.41    21-Mar-96   Don't check for get_hw_addr checksum unless DEC card
                           only <niles@axp745gsfc.nasa.gov>
 			  Fix for multiple PCI cards reported by <jos@xos.nl>
-			  Duh, put the SA_SHIRQ flag into request_interrupt().
+			  Duh, put the IRQF_SHARED flag into request_interrupt().
 			  Fix SMC ethernet address in enet_det[].
 			  Print chip name instead of "UNKNOWN" during boot.
       0.42    26-Apr-96   Fix MII write TA bit error.
@@ -353,7 +353,7 @@
 			   infoblocks.
 			  Added DC21142 and DC21143 functions.
 			  Added byte counters from <phil@tazenda.demon.co.uk>
-			  Added SA_INTERRUPT temporary fix from
+			  Added IRQF_DISABLED temporary fix from
 			   <mjacob@feral.com>.
       0.53   12-Nov-97    Fix the *_probe() to include 'eth??' name during
                            module load: bug reported by
@@ -1319,10 +1319,10 @@ de4x5_open(struct net_device *dev)
     lp->state = OPEN;
     de4x5_dbg_open(dev);
 
-    if (request_irq(dev->irq, (void *)de4x5_interrupt, SA_SHIRQ,
+    if (request_irq(dev->irq, (void *)de4x5_interrupt, IRQF_SHARED,
 		                                     lp->adapter_name, dev)) {
 	printk("de4x5_open(): Requested IRQ%d is busy - attemping FAST/SHARE...", dev->irq);
-	if (request_irq(dev->irq, de4x5_interrupt, SA_INTERRUPT | SA_SHIRQ,
+	if (request_irq(dev->irq, de4x5_interrupt, IRQF_DISABLED | IRQF_SHARED,
 			                             lp->adapter_name, dev)) {
 	    printk("\n              Cannot get IRQ- reconfigure your hardware.\n");
 	    disable_ast(dev);
Index: linux-2.6.git/drivers/net/tulip/dmfe.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tulip/dmfe.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tulip/dmfe.c	2006-07-01 16:51:43.000000000 +0200
@@ -506,7 +506,7 @@ static int dmfe_open(struct DEVICE *dev)
 
 	DMFE_DBUG(0, "dmfe_open", 0);
 
-	ret = request_irq(dev->irq, &dmfe_interrupt, SA_SHIRQ, dev->name, dev);
+	ret = request_irq(dev->irq, &dmfe_interrupt, IRQF_SHARED, dev->name, dev);
 	if (ret)
 		return ret;
 
Index: linux-2.6.git/drivers/net/tulip/tulip_core.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tulip/tulip_core.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tulip/tulip_core.c	2006-07-01 16:51:43.000000000 +0200
@@ -489,7 +489,7 @@ tulip_open(struct net_device *dev)
 {
 	int retval;
 
-	if ((retval = request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev)))
+	if ((retval = request_irq(dev->irq, &tulip_interrupt, IRQF_SHARED, dev->name, dev)))
 		return retval;
 
 	tulip_init_ring (dev);
@@ -1770,7 +1770,7 @@ static int tulip_resume(struct pci_dev *
 
 	pci_enable_device(pdev);
 
-	if ((retval = request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev))) {
+	if ((retval = request_irq(dev->irq, &tulip_interrupt, IRQF_SHARED, dev->name, dev))) {
 		printk (KERN_ERR "tulip: request_irq failed in resume\n");
 		return retval;
 	}
Index: linux-2.6.git/drivers/net/tulip/uli526x.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tulip/uli526x.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tulip/uli526x.c	2006-07-01 16:51:43.000000000 +0200
@@ -436,7 +436,7 @@ static int uli526x_open(struct net_devic
 
 	ULI526X_DBUG(0, "uli526x_open", 0);
 
-	ret = request_irq(dev->irq, &uli526x_interrupt, SA_SHIRQ, dev->name, dev);
+	ret = request_irq(dev->irq, &uli526x_interrupt, IRQF_SHARED, dev->name, dev);
 	if (ret)
 		return ret;
 
Index: linux-2.6.git/drivers/net/tulip/winbond-840.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tulip/winbond-840.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tulip/winbond-840.c	2006-07-01 16:51:43.000000000 +0200
@@ -658,7 +658,7 @@ static int netdev_open(struct net_device
 	iowrite32(0x00000001, ioaddr + PCIBusCfg);		/* Reset */
 
 	netif_device_detach(dev);
-	i = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
+	i = request_irq(dev->irq, &intr_handler, IRQF_SHARED, dev->name, dev);
 	if (i)
 		goto out_err;
 
Index: linux-2.6.git/drivers/net/tulip/xircom_cb.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tulip/xircom_cb.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tulip/xircom_cb.c	2006-07-01 16:51:43.000000000 +0200
@@ -457,7 +457,7 @@ static int xircom_open(struct net_device
 	int retval;
 	enter("xircom_open");
 	printk(KERN_INFO "xircom cardbus adaptor found, registering as %s, using irq %i \n",dev->name,dev->irq);
-	retval = request_irq(dev->irq, &xircom_interrupt, SA_SHIRQ, dev->name, dev);
+	retval = request_irq(dev->irq, &xircom_interrupt, IRQF_SHARED, dev->name, dev);
 	if (retval) {
 		leave("xircom_open - No IRQ");
 		return retval;
Index: linux-2.6.git/drivers/net/tulip/xircom_tulip_cb.c
===================================================================
--- linux-2.6.git.orig/drivers/net/tulip/xircom_tulip_cb.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/tulip/xircom_tulip_cb.c	2006-07-01 16:51:43.000000000 +0200
@@ -807,7 +807,7 @@ xircom_open(struct net_device *dev)
 {
 	struct xircom_private *tp = netdev_priv(dev);
 
-	if (request_irq(dev->irq, &xircom_interrupt, SA_SHIRQ, dev->name, dev))
+	if (request_irq(dev->irq, &xircom_interrupt, IRQF_SHARED, dev->name, dev))
 		return -EAGAIN;
 
 	xircom_up(dev);
Index: linux-2.6.git/drivers/net/wan/dscc4.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wan/dscc4.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wan/dscc4.c	2006-07-01 16:51:43.000000000 +0200
@@ -752,7 +752,7 @@ static int __devinit dscc4_init_one(stru
 
 	priv = pci_get_drvdata(pdev);
 
-	rc = request_irq(pdev->irq, dscc4_irq, SA_SHIRQ, DRV_NAME, priv->root);
+	rc = request_irq(pdev->irq, dscc4_irq, IRQF_SHARED, DRV_NAME, priv->root);
 	if (rc < 0) {
 		printk(KERN_WARNING "%s: IRQ %d busy\n", DRV_NAME, pdev->irq);
 		goto err_release_4;
Index: linux-2.6.git/drivers/net/wan/farsync.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wan/farsync.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wan/farsync.c	2006-07-01 16:51:43.000000000 +0200
@@ -2519,7 +2519,7 @@ fst_add_one(struct pci_dev *pdev, const 
 	dbg(DBG_PCI, "kernel mem %p, ctlmem %p\n", card->mem, card->ctlmem);
 
 	/* Register the interrupt handler */
-	if (request_irq(pdev->irq, fst_intr, SA_SHIRQ, FST_DEV_NAME, card)) {
+	if (request_irq(pdev->irq, fst_intr, IRQF_SHARED, FST_DEV_NAME, card)) {
 		printk_err("Unable to register interrupt %d\n", card->irq);
 		pci_release_regions(pdev);
 		pci_disable_device(pdev);
Index: linux-2.6.git/drivers/net/wan/hostess_sv11.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wan/hostess_sv11.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wan/hostess_sv11.c	2006-07-01 16:51:43.000000000 +0200
@@ -264,7 +264,7 @@ static struct sv11_device *sv11_init(int
 	/* We want a fast IRQ for this device. Actually we'd like an even faster
 	   IRQ ;) - This is one driver RtLinux is made for */
 	   
-	if(request_irq(irq, &z8530_interrupt, SA_INTERRUPT, "Hostess SV11", dev)<0)
+	if(request_irq(irq, &z8530_interrupt, IRQF_DISABLED, "Hostess SV11", dev)<0)
 	{
 		printk(KERN_WARNING "hostess: IRQ %d already in use.\n", irq);
 		goto fail1;
Index: linux-2.6.git/drivers/net/wan/pc300_drv.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wan/pc300_drv.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wan/pc300_drv.c	2006-07-01 16:51:43.000000000 +0200
@@ -3600,7 +3600,7 @@ cpc_init_one(struct pci_dev *pdev, const
 	}
 
 	/* Allocate IRQ */
-	if (request_irq(card->hw.irq, cpc_intr, SA_SHIRQ, "Cyclades-PC300", card)) {
+	if (request_irq(card->hw.irq, cpc_intr, IRQF_SHARED, "Cyclades-PC300", card)) {
 		printk ("PC300 found at RAM 0x%08x, but could not allocate IRQ%d.\n",
 			 card->hw.ramphys, card->hw.irq);
 		goto err_io_unmap;
Index: linux-2.6.git/drivers/net/wan/pci200syn.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wan/pci200syn.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wan/pci200syn.c	2006-07-01 16:51:43.000000000 +0200
@@ -402,7 +402,7 @@ static int __devinit pci200_pci_init_one
 	writew(readw(p) | 0x0040, p);
 
 	/* Allocate IRQ */
-	if (request_irq(pdev->irq, sca_intr, SA_SHIRQ, devname, card)) {
+	if (request_irq(pdev->irq, sca_intr, IRQF_SHARED, devname, card)) {
 		printk(KERN_WARNING "pci200syn: could not allocate IRQ%d.\n",
 		       pdev->irq);
 		pci200_pci_remove_one(pdev);
Index: linux-2.6.git/drivers/net/wan/sbni.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wan/sbni.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wan/sbni.c	2006-07-01 16:51:43.000000000 +0200
@@ -1192,7 +1192,7 @@ sbni_open( struct net_device  *dev )
 			}
 	}
 
-	if( request_irq(dev->irq, sbni_interrupt, SA_SHIRQ, dev->name, dev) ) {
+	if( request_irq(dev->irq, sbni_interrupt, IRQF_SHARED, dev->name, dev) ) {
 		printk( KERN_ERR "%s: unable to get IRQ %d.\n",
 			dev->name, dev->irq );
 		return  -EAGAIN;
Index: linux-2.6.git/drivers/net/wan/sealevel.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wan/sealevel.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wan/sealevel.c	2006-07-01 16:51:43.000000000 +0200
@@ -322,7 +322,7 @@ static __init struct slvl_board *slvl_in
 	/* We want a fast IRQ for this device. Actually we'd like an even faster
 	   IRQ ;) - This is one driver RtLinux is made for */
    
-	if(request_irq(irq, &z8530_interrupt, SA_INTERRUPT, "SeaLevel", dev)<0)
+	if(request_irq(irq, &z8530_interrupt, IRQF_DISABLED, "SeaLevel", dev)<0)
 	{
 		printk(KERN_WARNING "sealevel: IRQ %d already in use.\n", irq);
 		goto fail1_1;
Index: linux-2.6.git/drivers/net/wan/wanxl.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wan/wanxl.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wan/wanxl.c	2006-07-01 16:51:43.000000000 +0200
@@ -755,7 +755,7 @@ static int __devinit wanxl_pci_init_one(
 	       pci_name(pdev), plx_phy, ramsize / 1024, mem_phy, pdev->irq);
 
 	/* Allocate IRQ */
-	if (request_irq(pdev->irq, wanxl_intr, SA_SHIRQ, "wanXL", card)) {
+	if (request_irq(pdev->irq, wanxl_intr, IRQF_SHARED, "wanXL", card)) {
 		printk(KERN_WARNING "wanXL %s: could not allocate IRQ%i.\n",
 		       pci_name(pdev), pdev->irq);
 		wanxl_pci_remove_one(pdev);
Index: linux-2.6.git/drivers/net/wan/lmc/lmc_main.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wan/lmc/lmc_main.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wan/lmc/lmc_main.c	2006-07-01 16:51:43.000000000 +0200
@@ -1058,7 +1058,7 @@ static int lmc_open (struct net_device *
     lmc_softreset (sc);
 
     /* Since we have to use PCI bus, this should work on x86,alpha,ppc */
-    if (request_irq (dev->irq, &lmc_interrupt, SA_SHIRQ, dev->name, dev)){
+    if (request_irq (dev->irq, &lmc_interrupt, IRQF_SHARED, dev->name, dev)){
         printk(KERN_WARNING "%s: could not get irq: %d\n", dev->name, dev->irq);
         lmc_trace(dev, "lmc_open irq failed out");
         return -EAGAIN;
Index: linux-2.6.git/drivers/net/wireless/airo.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/airo.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/airo.c	2006-07-01 16:51:43.000000000 +0200
@@ -2848,7 +2848,7 @@ static struct net_device *_init_airo_car
 	reset_card (dev, 1);
 	msleep(400);
 
-	rc = request_irq( dev->irq, airo_interrupt, SA_SHIRQ, dev->name, dev );
+	rc = request_irq( dev->irq, airo_interrupt, IRQF_SHARED, dev->name, dev );
 	if (rc) {
 		airo_print_err(dev->name, "register interrupt %d failed, rc %d",
 				irq, rc);
Index: linux-2.6.git/drivers/net/wireless/atmel.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/atmel.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/atmel.c	2006-07-01 16:51:43.000000000 +0200
@@ -1577,7 +1577,7 @@ struct net_device *init_atmel_card(unsig
 
 	SET_NETDEV_DEV(dev, sys_dev);
 
-	if ((rc = request_irq(dev->irq, service_interrupt, SA_SHIRQ, dev->name, dev))) {
+	if ((rc = request_irq(dev->irq, service_interrupt, IRQF_SHARED, dev->name, dev))) {
 		printk(KERN_ERR "%s: register interrupt %d failed, rc %d\n", dev->name, irq, rc);
 		goto err_out_free;
 	}
Index: linux-2.6.git/drivers/net/wireless/ipw2100.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/ipw2100.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/ipw2100.c	2006-07-01 16:51:43.000000000 +0200
@@ -6229,7 +6229,7 @@ static int ipw2100_pci_init_one(struct p
 	ipw2100_queues_initialize(priv);
 
 	err = request_irq(pci_dev->irq,
-			  ipw2100_interrupt, SA_SHIRQ, dev->name, priv);
+			  ipw2100_interrupt, IRQF_SHARED, dev->name, priv);
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling request_irq: %d.\n", pci_dev->irq);
Index: linux-2.6.git/drivers/net/wireless/ipw2200.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/ipw2200.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/ipw2200.c	2006-07-01 16:51:43.000000000 +0200
@@ -11545,7 +11545,7 @@ static int ipw_pci_probe(struct pci_dev 
 
 	ipw_sw_reset(priv, 1);
 
-	err = request_irq(pdev->irq, ipw_isr, SA_SHIRQ, DRV_NAME, priv);
+	err = request_irq(pdev->irq, ipw_isr, IRQF_SHARED, DRV_NAME, priv);
 	if (err) {
 		IPW_ERROR("Error allocating IRQ %d\n", pdev->irq);
 		goto out_destroy_workqueue;
Index: linux-2.6.git/drivers/net/wireless/orinoco_nortel.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/orinoco_nortel.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/orinoco_nortel.c	2006-07-01 16:51:43.000000000 +0200
@@ -198,7 +198,7 @@ static int orinoco_nortel_init_one(struc
 
 	hermes_struct_init(&priv->hw, hermes_io, HERMES_16BIT_REGSPACING);
 
-	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
+	err = request_irq(pdev->irq, orinoco_interrupt, IRQF_SHARED,
 			  dev->name, dev);
 	if (err) {
 		printk(KERN_ERR PFX "Cannot allocate IRQ %d\n", pdev->irq);
Index: linux-2.6.git/drivers/net/wireless/orinoco_pci.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/orinoco_pci.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/orinoco_pci.c	2006-07-01 16:51:43.000000000 +0200
@@ -153,7 +153,7 @@ static int orinoco_pci_init_one(struct p
 
 	hermes_struct_init(&priv->hw, hermes_io, HERMES_32BIT_REGSPACING);
 
-	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
+	err = request_irq(pdev->irq, orinoco_interrupt, IRQF_SHARED,
 			  dev->name, dev);
 	if (err) {
 		printk(KERN_ERR PFX "Cannot allocate IRQ %d\n", pdev->irq);
Index: linux-2.6.git/drivers/net/wireless/orinoco_pci.h
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/orinoco_pci.h	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/orinoco_pci.h	2006-07-01 16:51:43.000000000 +0200
@@ -63,7 +63,7 @@ static int orinoco_pci_resume(struct pci
 	pci_enable_device(pdev);
 	pci_restore_state(pdev);
 
-	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
+	err = request_irq(pdev->irq, orinoco_interrupt, IRQF_SHARED,
 			  dev->name, dev);
 	if (err) {
 		printk(KERN_ERR "%s: cannot re-allocate IRQ on resume\n",
Index: linux-2.6.git/drivers/net/wireless/orinoco_plx.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/orinoco_plx.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/orinoco_plx.c	2006-07-01 16:51:43.000000000 +0200
@@ -237,7 +237,7 @@ static int orinoco_plx_init_one(struct p
 
 	hermes_struct_init(&priv->hw, hermes_io, HERMES_16BIT_REGSPACING);
 
-	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
+	err = request_irq(pdev->irq, orinoco_interrupt, IRQF_SHARED,
 			  dev->name, dev);
 	if (err) {
 		printk(KERN_ERR PFX "Cannot allocate IRQ %d\n", pdev->irq);
Index: linux-2.6.git/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/orinoco_tmd.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/orinoco_tmd.c	2006-07-01 16:51:43.000000000 +0200
@@ -139,7 +139,7 @@ static int orinoco_tmd_init_one(struct p
 
 	hermes_struct_init(&priv->hw, hermes_io, HERMES_16BIT_REGSPACING);
 
-	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
+	err = request_irq(pdev->irq, orinoco_interrupt, IRQF_SHARED,
 			  dev->name, dev);
 	if (err) {
 		printk(KERN_ERR PFX "Cannot allocate IRQ %d\n", pdev->irq);
Index: linux-2.6.git/drivers/net/wireless/bcm43xx/bcm43xx_main.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-07-01 16:51:43.000000000 +0200
@@ -2175,7 +2175,7 @@ static int bcm43xx_initialize_irq(struct
 	}
 #endif
 	res = request_irq(bcm->irq, bcm43xx_interrupt_handler,
-			  SA_SHIRQ, KBUILD_MODNAME, bcm);
+			  IRQF_SHARED, KBUILD_MODNAME, bcm);
 	if (res) {
 		printk(KERN_ERR PFX "Cannot register IRQ%d\n", bcm->irq);
 		return -ENODEV;
Index: linux-2.6.git/drivers/net/wireless/hostap/hostap_pci.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/hostap/hostap_pci.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/hostap/hostap_pci.c	2006-07-01 16:51:43.000000000 +0200
@@ -337,7 +337,7 @@ static int prism2_pci_probe(struct pci_d
 
 	pci_set_drvdata(pdev, dev);
 
-	if (request_irq(dev->irq, prism2_interrupt, SA_SHIRQ, dev->name,
+	if (request_irq(dev->irq, prism2_interrupt, IRQF_SHARED, dev->name,
 			dev)) {
 		printk(KERN_WARNING "%s: request_irq failed\n", dev->name);
 		goto fail;
Index: linux-2.6.git/drivers/net/wireless/hostap/hostap_plx.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/hostap/hostap_plx.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/hostap/hostap_plx.c	2006-07-01 16:51:43.000000000 +0200
@@ -550,7 +550,7 @@ static int prism2_plx_probe(struct pci_d
 
 	pci_set_drvdata(pdev, dev);
 
-	if (request_irq(dev->irq, prism2_interrupt, SA_SHIRQ, dev->name,
+	if (request_irq(dev->irq, prism2_interrupt, IRQF_SHARED, dev->name,
 			dev)) {
 		printk(KERN_WARNING "%s: request_irq failed\n", dev->name);
 		goto fail;
Index: linux-2.6.git/drivers/net/wireless/prism54/islpci_hotplug.c
===================================================================
--- linux-2.6.git.orig/drivers/net/wireless/prism54/islpci_hotplug.c	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/drivers/net/wireless/prism54/islpci_hotplug.c	2006-07-01 16:51:43.000000000 +0200
@@ -189,7 +189,7 @@ prism54_probe(struct pci_dev *pdev, cons
 
 	/* request for the interrupt before uploading the firmware */
 	rvalue = request_irq(pdev->irq, &islpci_interrupt,
-			     SA_SHIRQ, ndev->name, priv);
+			     IRQF_SHARED, ndev->name, priv);
 
 	if (rvalue) {
 		/* error, could not hook the handler to the irq */
Index: linux-2.6.git/include/net/irda/irda_device.h
===================================================================
--- linux-2.6.git.orig/include/net/irda/irda_device.h	2006-07-01 16:51:15.000000000 +0200
+++ linux-2.6.git/include/net/irda/irda_device.h	2006-07-01 16:51:43.000000000 +0200
@@ -160,7 +160,7 @@ typedef struct {
         int irq, irq2;        /* Interrupts used */
         int dma, dma2;        /* DMA channel(s) used */
         int fifo_size;        /* FIFO size */
-        int irqflags;         /* interrupt flags (ie, SA_SHIRQ|SA_INTERRUPT) */
+        int irqflags;         /* interrupt flags (ie, IRQF_SHARED|IRQF_DISABLED) */
 	int direction;        /* Link direction, used by some FIR drivers */
 	int enabled;          /* Powered on? */
 	int suspended;        /* Suspended by APM */

--

