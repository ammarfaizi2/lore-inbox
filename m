Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932906AbWGAPIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbWGAPIL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbWGAPH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:07:28 -0400
Received: from www.osadl.org ([213.239.205.134]:58020 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751587AbWGAO5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:31 -0400
Message-Id: <20060701145227.212997000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:59 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>
Subject: [RFC][patch 34/44] misc drivers: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-misc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/acorn/block/mfmhd.c                |    2 +-
 drivers/acpi/osl.c                         |    2 +-
 drivers/atm/ambassador.c                   |    2 +-
 drivers/atm/eni.c                          |    2 +-
 drivers/atm/firestream.c                   |    2 +-
 drivers/atm/fore200e.c                     |    2 +-
 drivers/atm/he.c                           |    2 +-
 drivers/atm/horizon.c                      |    2 +-
 drivers/atm/idt77252.c                     |    2 +-
 drivers/atm/iphase.c                       |    2 +-
 drivers/atm/lanai.c                        |    2 +-
 drivers/atm/nicstar.c                      |    2 +-
 drivers/atm/zatm.c                         |    2 +-
 drivers/cdrom/cdu31a.c                     |    2 +-
 drivers/cdrom/mcdx.c                       |    2 +-
 drivers/cdrom/sonycd535.c                  |    2 +-
 drivers/dma/ioatdma.c                      |    2 +-
 drivers/fc4/soc.c                          |    2 +-
 drivers/fc4/socal.c                        |    2 +-
 drivers/i2c/busses/i2c-mpc.c               |    2 +-
 drivers/i2c/busses/i2c-pxa.c               |    2 +-
 drivers/i2c/busses/i2c-s3c2410.c           |    2 +-
 drivers/i2c/chips/isp1301_omap.c           |    4 ++--
 drivers/i2c/chips/tps65010.c               |    8 ++++----
 drivers/infiniband/hw/ipath/ipath_driver.c |    4 ++--
 drivers/infiniband/hw/mthca/mthca_eq.c     |    2 +-
 drivers/input/keyboard/corgikbd.c          |    2 +-
 drivers/input/keyboard/spitzkbd.c          |   12 ++++++------
 drivers/input/misc/ixp4xx-beeper.c         |    2 +-
 drivers/input/mouse/rpcmouse.c             |    2 +-
 drivers/input/serio/gscps2.c               |    2 +-
 drivers/input/serio/i8042.c                |    4 ++--
 drivers/input/serio/pcips2.c               |    2 +-
 drivers/input/touchscreen/ads7846.c        |    2 +-
 drivers/input/touchscreen/corgi_ts.c       |    2 +-
 drivers/input/touchscreen/h3600_ts_input.c |    4 ++--
 drivers/input/touchscreen/hp680_ts_input.c |    2 +-
 drivers/macintosh/smu.c                    |    4 ++--
 drivers/message/fusion/mptbase.c           |    2 +-
 drivers/message/i2o/pci.c                  |    2 +-
 drivers/mfd/ucb1x00-core.c                 |    2 +-
 drivers/misc/ibmasm/module.c               |    2 +-
 drivers/mmc/at91_mci.c                     |    2 +-
 drivers/mmc/au1xmmc.c                      |    2 +-
 drivers/mmc/mmci.c                         |    4 ++--
 drivers/mmc/omap.c                         |    2 +-
 drivers/mmc/sdhci.c                        |    2 +-
 drivers/mmc/wbsd.c                         |    2 +-
 drivers/parport/parport_ax88796.c          |    2 +-
 drivers/parport/parport_mfc3.c             |    2 +-
 drivers/parport/parport_sunbpp.c           |    2 +-
 drivers/pcmcia/at91_cf.c                   |    4 ++--
 drivers/pcmcia/hd64465_ss.c                |    2 +-
 drivers/pcmcia/i82092.c                    |    2 +-
 drivers/pcmcia/i82365.c                    |    6 +++---
 drivers/pcmcia/omap_cf.c                   |    2 +-
 drivers/pcmcia/pcmcia_resource.c           |    8 ++++----
 drivers/pcmcia/pd6729.c                    |    2 +-
 drivers/pcmcia/soc_common.c                |    2 +-
 drivers/pcmcia/vrc4171_card.c              |    2 +-
 drivers/pcmcia/vrc4173_cardu.c             |    2 +-
 drivers/pcmcia/yenta_socket.c              |    4 ++--
 drivers/pnp/resource.c                     |    2 +-
 drivers/rtc/rtc-at91.c                     |    2 +-
 drivers/rtc/rtc-ds1553.c                   |    2 +-
 drivers/rtc/rtc-pl031.c                    |    2 +-
 drivers/rtc/rtc-sa1100.c                   |    6 +++---
 drivers/rtc/rtc-vr41xx.c                   |    4 ++--
 drivers/sbus/char/aurora.c                 |   12 ++++++------
 drivers/sbus/char/bbc_i2c.c                |    2 +-
 drivers/sbus/char/cpwatchdog.c             |    2 +-
 drivers/sn/ioc3.c                          |    6 +++---
 drivers/tc/zs.c                            |    2 +-
 73 files changed, 104 insertions(+), 104 deletions(-)

Index: linux-2.6.git/drivers/acorn/block/mfmhd.c
===================================================================
--- linux-2.6.git.orig/drivers/acorn/block/mfmhd.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/acorn/block/mfmhd.c	2006-07-01 16:51:42.000000000 +0200
@@ -1278,7 +1278,7 @@ static int mfm_do_init(unsigned char irq
 
 	printk("mfm: detected %d hard drive%s\n", mfm_drives,
 				mfm_drives == 1 ? "" : "s");
-	ret = request_irq(mfm_irq, mfm_interrupt_handler, SA_INTERRUPT, "MFM harddisk", NULL);
+	ret = request_irq(mfm_irq, mfm_interrupt_handler, IRQF_DISABLED, "MFM harddisk", NULL);
 	if (ret) {
 		printk("mfm: unable to get IRQ%d\n", mfm_irq);
 		goto out4;
Index: linux-2.6.git/drivers/acpi/osl.c
===================================================================
--- linux-2.6.git.orig/drivers/acpi/osl.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/acpi/osl.c	2006-07-01 16:51:42.000000000 +0200
@@ -280,7 +280,7 @@ acpi_os_install_interrupt_handler(u32 gs
 
 	acpi_irq_handler = handler;
 	acpi_irq_context = context;
-	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
+	if (request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)) {
 		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
 		return AE_NOT_ACQUIRED;
 	}
Index: linux-2.6.git/drivers/atm/ambassador.c
===================================================================
--- linux-2.6.git.orig/drivers/atm/ambassador.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/atm/ambassador.c	2006-07-01 16:51:42.000000000 +0200
@@ -2286,7 +2286,7 @@ static int __devinit amb_probe(struct pc
 	setup_pci_dev(pci_dev);
 
 	// grab (but share) IRQ and install handler
-	err = request_irq(irq, interrupt_handler, SA_SHIRQ, DEV_LABEL, dev);
+	err = request_irq(irq, interrupt_handler, IRQF_SHARED, DEV_LABEL, dev);
 	if (err < 0) {
 		PRINTK (KERN_ERR, "request IRQ failed!");
 		goto out_reset;
Index: linux-2.6.git/drivers/atm/eni.c
===================================================================
--- linux-2.6.git.orig/drivers/atm/eni.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/atm/eni.c	2006-07-01 16:51:42.000000000 +0200
@@ -1797,7 +1797,7 @@ static int __devinit eni_start(struct at
 
 	DPRINTK(">eni_start\n");
 	eni_dev = ENI_DEV(dev);
-	if (request_irq(eni_dev->irq,&eni_int,SA_SHIRQ,DEV_LABEL,dev)) {
+	if (request_irq(eni_dev->irq,&eni_int,IRQF_SHARED,DEV_LABEL,dev)) {
 		printk(KERN_ERR DEV_LABEL "(itf %d): IRQ%d is already in use\n",
 		    dev->number,eni_dev->irq);
 		error = -EAGAIN;
Index: linux-2.6.git/drivers/atm/firestream.c
===================================================================
--- linux-2.6.git.orig/drivers/atm/firestream.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/atm/firestream.c	2006-07-01 16:51:42.000000000 +0200
@@ -1829,7 +1829,7 @@ static int __devinit fs_init (struct fs_
 		init_q (dev, &dev->rx_rq[i], RXB_RQ(i), RXRQ_NENTRIES, 1);
 
 	dev->irq = pci_dev->irq;
-	if (request_irq (dev->irq, fs_irq, SA_SHIRQ, "firestream", dev)) {
+	if (request_irq (dev->irq, fs_irq, IRQF_SHARED, "firestream", dev)) {
 		printk (KERN_WARNING "couldn't get irq %d for firestream.\n", pci_dev->irq);
 		/* XXX undo all previous stuff... */
 		return 1;
Index: linux-2.6.git/drivers/atm/fore200e.c
===================================================================
--- linux-2.6.git.orig/drivers/atm/fore200e.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/atm/fore200e.c	2006-07-01 16:51:42.000000000 +0200
@@ -2123,7 +2123,7 @@ fore200e_change_qos(struct atm_vcc* vcc,
 static int __devinit
 fore200e_irq_request(struct fore200e* fore200e)
 {
-    if (request_irq(fore200e->irq, fore200e_interrupt, SA_SHIRQ, fore200e->name, fore200e->atm_dev) < 0) {
+    if (request_irq(fore200e->irq, fore200e_interrupt, IRQF_SHARED, fore200e->name, fore200e->atm_dev) < 0) {
 
 	printk(FORE200E "unable to reserve IRQ %s for device %s\n",
 	       fore200e_irq_itoa(fore200e->irq), fore200e->name);
Index: linux-2.6.git/drivers/atm/he.c
===================================================================
--- linux-2.6.git.orig/drivers/atm/he.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/atm/he.c	2006-07-01 16:51:42.000000000 +0200
@@ -1007,7 +1007,7 @@ he_init_irq(struct he_dev *he_dev)
 	he_writel(he_dev, 0x0, GRP_54_MAP);
 	he_writel(he_dev, 0x0, GRP_76_MAP);
 
-	if (request_irq(he_dev->pci_dev->irq, he_irq_handler, SA_INTERRUPT|SA_SHIRQ, DEV_LABEL, he_dev)) {
+	if (request_irq(he_dev->pci_dev->irq, he_irq_handler, IRQF_DISABLED|IRQF_SHARED, DEV_LABEL, he_dev)) {
 		hprintk("irq %d already in use\n", he_dev->pci_dev->irq);
 		return -EINVAL;
 	}   
Index: linux-2.6.git/drivers/atm/horizon.c
===================================================================
--- linux-2.6.git.orig/drivers/atm/horizon.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/atm/horizon.c	2006-07-01 16:51:42.000000000 +0200
@@ -2735,7 +2735,7 @@ static int __devinit hrz_probe(struct pc
 	irq = pci_dev->irq;
 	if (request_irq(irq,
 			interrupt_handler,
-			SA_SHIRQ, /* irqflags guess */
+			IRQF_SHARED, /* irqflags guess */
 			DEV_LABEL, /* name guess */
 			dev)) {
 		PRINTD(DBG_WARN, "request IRQ failed!");
Index: linux-2.6.git/drivers/atm/idt77252.c
===================================================================
--- linux-2.6.git.orig/drivers/atm/idt77252.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/atm/idt77252.c	2006-07-01 16:51:42.000000000 +0200
@@ -3386,7 +3386,7 @@ init_card(struct atm_dev *dev)
 		writel(SAR_STAT_TMROF, SAR_REG_STAT);
 	}
 	IPRINTK("%s: Request IRQ ... ", card->name);
-	if (request_irq(pcidev->irq, idt77252_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pcidev->irq, idt77252_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			card->name, card) != 0) {
 		printk("%s: can't allocate IRQ.\n", card->name);
 		deinit_card(card);
Index: linux-2.6.git/drivers/atm/iphase.c
===================================================================
--- linux-2.6.git.orig/drivers/atm/iphase.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/atm/iphase.c	2006-07-01 16:51:42.000000000 +0200
@@ -2488,7 +2488,7 @@ static int __devinit ia_start(struct atm
 	u32 ctrl_reg;  
 	IF_EVENT(printk(">ia_start\n");)  
 	iadev = INPH_IA_DEV(dev);  
-        if (request_irq(iadev->irq, &ia_int, SA_SHIRQ, DEV_LABEL, dev)) {  
+        if (request_irq(iadev->irq, &ia_int, IRQF_SHARED, DEV_LABEL, dev)) {  
                 printk(KERN_ERR DEV_LABEL "(itf %d): IRQ%d is already in use\n",  
                     dev->number, iadev->irq);  
 		error = -EAGAIN;
Index: linux-2.6.git/drivers/atm/lanai.c
===================================================================
--- linux-2.6.git.orig/drivers/atm/lanai.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/atm/lanai.c	2006-07-01 16:51:42.000000000 +0200
@@ -2240,7 +2240,7 @@ static int __devinit lanai_dev_open(stru
 	conf2_write(lanai);
 	reg_write(lanai, TX_FIFO_DEPTH, TxDepth_Reg);
 	reg_write(lanai, 0, CBR_ICG_Reg);	/* CBR defaults to no limit */
-	if ((result = request_irq(lanai->pci->irq, lanai_int, SA_SHIRQ,
+	if ((result = request_irq(lanai->pci->irq, lanai_int, IRQF_SHARED,
 	    DEV_LABEL, lanai)) != 0) {
 		printk(KERN_ERR DEV_LABEL ": can't allocate interrupt\n");
 		goto error_vcctable;
Index: linux-2.6.git/drivers/atm/nicstar.c
===================================================================
--- linux-2.6.git.orig/drivers/atm/nicstar.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/atm/nicstar.c	2006-07-01 16:51:42.000000000 +0200
@@ -625,7 +625,7 @@ static int __devinit ns_init_card(int i,
    if (mac[i] == NULL)
       nicstar_init_eprom(card->membase);
 
-   if (request_irq(pcidev->irq, &ns_irq_handler, SA_INTERRUPT | SA_SHIRQ, "nicstar", card) != 0)
+   if (request_irq(pcidev->irq, &ns_irq_handler, IRQF_DISABLED | IRQF_SHARED, "nicstar", card) != 0)
    {
       printk("nicstar%d: can't allocate IRQ %d.\n", i, pcidev->irq);
       error = 9;
Index: linux-2.6.git/drivers/atm/zatm.c
===================================================================
--- linux-2.6.git.orig/drivers/atm/zatm.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/atm/zatm.c	2006-07-01 16:51:42.000000000 +0200
@@ -1270,7 +1270,7 @@ static int __init zatm_start(struct atm_
 	zatm_dev->rx_map = zatm_dev->tx_map = NULL;
  	for (i = 0; i < NR_MBX; i++)
  		zatm_dev->mbx_start[i] = 0;
- 	error = request_irq(zatm_dev->irq, zatm_int, SA_SHIRQ, DEV_LABEL, dev);
+ 	error = request_irq(zatm_dev->irq, zatm_int, IRQF_SHARED, DEV_LABEL, dev);
 	if (error < 0) {
  		printk(KERN_ERR DEV_LABEL "(itf %d): IRQ%d is already in use\n",
  		    dev->number,zatm_dev->irq);
Index: linux-2.6.git/drivers/cdrom/cdu31a.c
===================================================================
--- linux-2.6.git.orig/drivers/cdrom/cdu31a.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/cdrom/cdu31a.c	2006-07-01 16:51:42.000000000 +0200
@@ -3141,7 +3141,7 @@ int __init cdu31a_init(void)
 
 	if (cdu31a_irq > 0) {
 		if (request_irq
-		    (cdu31a_irq, cdu31a_interrupt, SA_INTERRUPT,
+		    (cdu31a_irq, cdu31a_interrupt, IRQF_DISABLED,
 		     "cdu31a", NULL)) {
 			printk(KERN_WARNING PFX "Unable to grab IRQ%d for "
 					"the CDU31A driver\n", cdu31a_irq);
Index: linux-2.6.git/drivers/cdrom/mcdx.c
===================================================================
--- linux-2.6.git.orig/drivers/cdrom/mcdx.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/cdrom/mcdx.c	2006-07-01 16:51:42.000000000 +0200
@@ -1193,7 +1193,7 @@ static int __init mcdx_init_drive(int dr
 	}
 
 	xtrace(INIT, "init() subscribe irq and i/o\n");
-	if (request_irq(stuffp->irq, mcdx_intr, SA_INTERRUPT, "mcdx", stuffp)) {
+	if (request_irq(stuffp->irq, mcdx_intr, IRQF_DISABLED, "mcdx", stuffp)) {
 		release_region(stuffp->wreg_data, MCDX_IO_SIZE);
 		xwarn("%s=0x%03x,%d: Init failed. Can't get irq (%d).\n",
 		      MCDX, stuffp->wreg_data, stuffp->irq, stuffp->irq);
Index: linux-2.6.git/drivers/cdrom/sonycd535.c
===================================================================
--- linux-2.6.git.orig/drivers/cdrom/sonycd535.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/cdrom/sonycd535.c	2006-07-01 16:51:42.000000000 +0200
@@ -1527,7 +1527,7 @@ static int __init sony535_init(void)
 	}
 	if (sony535_irq_used > 0) {
 	    if (request_irq(sony535_irq_used, cdu535_interrupt,
-						SA_INTERRUPT, CDU535_HANDLE, NULL)) {
+						IRQF_DISABLED, CDU535_HANDLE, NULL)) {
 			printk("Unable to grab IRQ%d for the " CDU535_MESSAGE_NAME
 					" driver; polling instead.\n", sony535_irq_used);
 			sony535_irq_used = 0;
Index: linux-2.6.git/drivers/dma/ioatdma.c
===================================================================
--- linux-2.6.git.orig/drivers/dma/ioatdma.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/dma/ioatdma.c	2006-07-01 16:51:42.000000000 +0200
@@ -739,7 +739,7 @@ static int __devinit ioat_probe(struct p
 		device->msi = 0;
 	}
 #endif
-	err = request_irq(pdev->irq, &ioat_do_interrupt, SA_SHIRQ, "ioat",
+	err = request_irq(pdev->irq, &ioat_do_interrupt, IRQF_SHARED, "ioat",
 		device);
 	if (err)
 		goto err_irq;
Index: linux-2.6.git/drivers/fc4/socal.c
===================================================================
--- linux-2.6.git.orig/drivers/fc4/socal.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/fc4/socal.c	2006-07-01 16:51:42.000000000 +0200
@@ -761,7 +761,7 @@ static inline void socal_init(struct sbu
 	
 	irq = sdev->irqs[0];
 
-	if (request_irq (irq, socal_intr, SA_SHIRQ, "SOCAL", (void *)s)) {
+	if (request_irq (irq, socal_intr, IRQF_SHARED, "SOCAL", (void *)s)) {
 		socal_printk ("Cannot order irq %d to go\n", irq);
 		socals = s->next;
 		return;
Index: linux-2.6.git/drivers/fc4/soc.c
===================================================================
--- linux-2.6.git.orig/drivers/fc4/soc.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/fc4/soc.c	2006-07-01 16:51:42.000000000 +0200
@@ -637,7 +637,7 @@ static inline void soc_init(struct sbus_
 	
 	irq = sdev->irqs[0];
 
-	if (request_irq (irq, soc_intr, SA_SHIRQ, "SOC", (void *)s)) {
+	if (request_irq (irq, soc_intr, IRQF_SHARED, "SOC", (void *)s)) {
 		soc_printk ("Cannot order irq %d to go\n", irq);
 		socs = s->next;
 		return;
Index: linux-2.6.git/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6.git.orig/drivers/i2c/busses/i2c-mpc.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/i2c/busses/i2c-mpc.c	2006-07-01 16:51:42.000000000 +0200
@@ -318,7 +318,7 @@ static int fsl_i2c_probe(struct platform
 
 	if (i2c->irq != 0)
 		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
-					  SA_SHIRQ, "i2c-mpc", i2c)) < 0) {
+					  IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
 			printk(KERN_ERR
 			       "i2c-mpc - failed to attach interrupt\n");
 			goto fail_irq;
Index: linux-2.6.git/drivers/i2c/busses/i2c-pxa.c
===================================================================
--- linux-2.6.git.orig/drivers/i2c/busses/i2c-pxa.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/i2c/busses/i2c-pxa.c	2006-07-01 16:51:42.000000000 +0200
@@ -968,7 +968,7 @@ static int i2c_pxa_probe(struct platform
 #endif
 
 	pxa_set_cken(CKEN14_I2C, 1);
-	ret = request_irq(IRQ_I2C, i2c_pxa_handler, SA_INTERRUPT,
+	ret = request_irq(IRQ_I2C, i2c_pxa_handler, IRQF_DISABLED,
 			  "pxa2xx-i2c", i2c);
 	if (ret)
 		goto out;
Index: linux-2.6.git/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux-2.6.git.orig/drivers/i2c/busses/i2c-s3c2410.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/i2c/busses/i2c-s3c2410.c	2006-07-01 16:51:42.000000000 +0200
@@ -828,7 +828,7 @@ static int s3c24xx_i2c_probe(struct plat
 		goto out;
 	}
 
-	ret = request_irq(res->start, s3c24xx_i2c_irq, SA_INTERRUPT,
+	ret = request_irq(res->start, s3c24xx_i2c_irq, IRQF_DISABLED,
 			  pdev->name, i2c);
 
 	if (ret != 0) {
Index: linux-2.6.git/drivers/i2c/chips/isp1301_omap.c
===================================================================
--- linux-2.6.git.orig/drivers/i2c/chips/isp1301_omap.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/i2c/chips/isp1301_omap.c	2006-07-01 16:51:42.000000000 +0200
@@ -908,7 +908,7 @@ static int otg_bind(struct isp1301 *isp)
 
 	if (otg_dev)
 		status = request_irq(otg_dev->resource[1].start, omap_otg_irq,
-				SA_INTERRUPT, DRIVER_NAME, isp);
+				IRQF_DISABLED, DRIVER_NAME, isp);
 	else
 		status = -ENODEV;
 
@@ -1578,7 +1578,7 @@ fail1:
 	}
 
 	status = request_irq(isp->irq, isp1301_irq,
-			SA_SAMPLE_RANDOM, DRIVER_NAME, isp);
+			IRQF_SAMPLE_RANDOM, DRIVER_NAME, isp);
 	if (status < 0) {
 		dev_dbg(&i2c->dev, "can't get IRQ %d, err %d\n",
 				isp->irq, status);
Index: linux-2.6.git/drivers/i2c/chips/tps65010.c
===================================================================
--- linux-2.6.git.orig/drivers/i2c/chips/tps65010.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/i2c/chips/tps65010.c	2006-07-01 16:51:42.000000000 +0200
@@ -521,14 +521,14 @@ tps65010_probe(struct i2c_adapter *bus, 
 	}
 
 #ifdef	CONFIG_ARM
-	irqflags = SA_SAMPLE_RANDOM | SA_TRIGGER_LOW;
+	irqflags = IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_LOW;
 	if (machine_is_omap_h2()) {
 		tps->model = TPS65010;
 		omap_cfg_reg(W4_GPIO58);
 		tps->irq = OMAP_GPIO_IRQ(58);
 		omap_request_gpio(58);
 		omap_set_gpio_direction(58, 1);
-		irqflags |= SA_TRIGGER_FALLING;
+		irqflags |= IRQF_TRIGGER_FALLING;
 	}
 	if (machine_is_omap_osk()) {
 		tps->model = TPS65010;
@@ -536,7 +536,7 @@ tps65010_probe(struct i2c_adapter *bus, 
 		tps->irq = OMAP_GPIO_IRQ(OMAP_MPUIO(1));
 		omap_request_gpio(OMAP_MPUIO(1));
 		omap_set_gpio_direction(OMAP_MPUIO(1), 1);
-		irqflags |= SA_TRIGGER_FALLING;
+		irqflags |= IRQF_TRIGGER_FALLING;
 	}
 	if (machine_is_omap_h3()) {
 		tps->model = TPS65013;
@@ -544,7 +544,7 @@ tps65010_probe(struct i2c_adapter *bus, 
 		// FIXME set up this board's IRQ ...
 	}
 #else
-	irqflags = SA_SAMPLE_RANDOM;
+	irqflags = IRQF_SAMPLE_RANDOM;
 #endif
 
 	if (tps->irq > 0) {
Index: linux-2.6.git/drivers/infiniband/hw/ipath/ipath_driver.c
===================================================================
--- linux-2.6.git.orig/drivers/infiniband/hw/ipath/ipath_driver.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/infiniband/hw/ipath/ipath_driver.c	2006-07-01 16:51:42.000000000 +0200
@@ -511,7 +511,7 @@ static int __devinit ipath_init_one(stru
 			      "continuing anyway\n");
 
 	/*
-	 * set up our interrupt handler; SA_SHIRQ probably not needed,
+	 * set up our interrupt handler; IRQF_SHARED probably not needed,
 	 * since MSI interrupts shouldn't be shared but won't  hurt for now.
 	 * check 0 irq after we return from chip-specific bus setup, since
 	 * that can affect this due to setup
@@ -520,7 +520,7 @@ static int __devinit ipath_init_one(stru
 		ipath_dev_err(dd, "irq is 0, BIOS error?  Interrupts won't "
 			      "work\n");
 	else {
-		ret = request_irq(pdev->irq, ipath_intr, SA_SHIRQ,
+		ret = request_irq(pdev->irq, ipath_intr, IRQF_SHARED,
 				  IPATH_DRV_NAME, dd);
 		if (ret) {
 			ipath_dev_err(dd, "Couldn't setup irq handler, "
Index: linux-2.6.git/drivers/infiniband/hw/mthca/mthca_eq.c
===================================================================
--- linux-2.6.git.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/infiniband/hw/mthca/mthca_eq.c	2006-07-01 16:51:42.000000000 +0200
@@ -900,7 +900,7 @@ int __devinit mthca_init_eq_table(struct
 				  mthca_is_memfree(dev) ?
 				  mthca_arbel_interrupt :
 				  mthca_tavor_interrupt,
-				  SA_SHIRQ, DRV_NAME, dev);
+				  IRQF_SHARED, DRV_NAME, dev);
 		if (err)
 			goto err_out_cmd;
 		dev->eq_table.have_irq = 1;
Index: linux-2.6.git/drivers/input/keyboard/corgikbd.c
===================================================================
--- linux-2.6.git.orig/drivers/input/keyboard/corgikbd.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/input/keyboard/corgikbd.c	2006-07-01 16:51:42.000000000 +0200
@@ -352,7 +352,7 @@ static int __init corgikbd_probe(struct 
 	for (i = 0; i < CORGI_KEY_SENSE_NUM; i++) {
 		pxa_gpio_mode(CORGI_GPIO_KEY_SENSE(i) | GPIO_IN);
 		if (request_irq(CORGI_IRQ_GPIO_KEY_SENSE(i), corgikbd_interrupt,
-				SA_INTERRUPT | SA_TRIGGER_RISING,
+				IRQF_DISABLED | IRQF_TRIGGER_RISING,
 				"corgikbd", corgikbd))
 			printk(KERN_WARNING "corgikbd: Can't get IRQ: %d!\n", i);
 	}
Index: linux-2.6.git/drivers/input/keyboard/spitzkbd.c
===================================================================
--- linux-2.6.git.orig/drivers/input/keyboard/spitzkbd.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/input/keyboard/spitzkbd.c	2006-07-01 16:51:42.000000000 +0200
@@ -410,7 +410,7 @@ static int __init spitzkbd_probe(struct 
 	for (i = 0; i < SPITZ_KEY_SENSE_NUM; i++) {
 		pxa_gpio_mode(spitz_senses[i] | GPIO_IN);
 		if (request_irq(IRQ_GPIO(spitz_senses[i]), spitzkbd_interrupt,
-				SA_INTERRUPT|SA_TRIGGER_RISING,
+				IRQF_DISABLED|IRQF_TRIGGER_RISING,
 				"Spitzkbd Sense", spitzkbd))
 			printk(KERN_WARNING "spitzkbd: Can't get Sense IRQ: %d!\n", i);
 	}
@@ -425,19 +425,19 @@ static int __init spitzkbd_probe(struct 
 	pxa_gpio_mode(SPITZ_GPIO_SWB | GPIO_IN);
 
 	request_irq(SPITZ_IRQ_GPIO_SYNC, spitzkbd_interrupt,
-		    SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 		    "Spitzkbd Sync", spitzkbd);
 	request_irq(SPITZ_IRQ_GPIO_ON_KEY, spitzkbd_interrupt,
-		    SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 		    "Spitzkbd PwrOn", spitzkbd);
 	request_irq(SPITZ_IRQ_GPIO_SWA, spitzkbd_hinge_isr,
-		    SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 		    "Spitzkbd SWA", spitzkbd);
 	request_irq(SPITZ_IRQ_GPIO_SWB, spitzkbd_hinge_isr,
-		    SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 		    "Spitzkbd SWB", spitzkbd);
  	request_irq(SPITZ_IRQ_GPIO_AK_INT, spitzkbd_hinge_isr,
-		    SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 		    "Spitzkbd HP", spitzkbd);
 
 	printk(KERN_INFO "input: Spitz Keyboard Registered\n");
Index: linux-2.6.git/drivers/input/misc/ixp4xx-beeper.c
===================================================================
--- linux-2.6.git.orig/drivers/input/misc/ixp4xx-beeper.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/input/misc/ixp4xx-beeper.c	2006-07-01 16:51:42.000000000 +0200
@@ -113,7 +113,7 @@ static int __devinit ixp4xx_spkr_probe(s
 	input_dev->event = ixp4xx_spkr_event;
 
 	err = request_irq(IRQ_IXP4XX_TIMER2, &ixp4xx_spkr_interrupt,
-			  SA_INTERRUPT | SA_TIMER, "ixp4xx-beeper", (void *) dev->id);
+			  IRQF_DISABLED | IRQF_TIMER, "ixp4xx-beeper", (void *) dev->id);
 	if (err)
 		goto err_free_device;
 
Index: linux-2.6.git/drivers/input/mouse/rpcmouse.c
===================================================================
--- linux-2.6.git.orig/drivers/input/mouse/rpcmouse.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/input/mouse/rpcmouse.c	2006-07-01 16:51:42.000000000 +0200
@@ -85,7 +85,7 @@ static int __init rpcmouse_init(void)
 	rpcmouse_lastx = (short) iomd_readl(IOMD_MOUSEX);
 	rpcmouse_lasty = (short) iomd_readl(IOMD_MOUSEY);
 
-	if (request_irq(IRQ_VSYNCPULSE, rpcmouse_irq, SA_SHIRQ, "rpcmouse", rpcmouse_dev)) {
+	if (request_irq(IRQ_VSYNCPULSE, rpcmouse_irq, IRQF_SHARED, "rpcmouse", rpcmouse_dev)) {
 		printk(KERN_ERR "rpcmouse: unable to allocate VSYNC interrupt\n");
 		input_free_device(rpcmouse_dev);
 		return -EBUSY;
Index: linux-2.6.git/drivers/input/serio/gscps2.c
===================================================================
--- linux-2.6.git.orig/drivers/input/serio/gscps2.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/input/serio/gscps2.c	2006-07-01 16:51:42.000000000 +0200
@@ -370,7 +370,7 @@ static int __init gscps2_probe(struct pa
 	serio->dev.parent	= &dev->dev;
 
 	ret = -EBUSY;
-	if (request_irq(dev->irq, gscps2_interrupt, SA_SHIRQ, ps2port->port->name, ps2port))
+	if (request_irq(dev->irq, gscps2_interrupt, IRQF_SHARED, ps2port->port->name, ps2port))
 		goto fail_miserably;
 
 	if (ps2port->id != GSC_ID_KEYBOARD && ps2port->id != GSC_ID_MOUSE) {
Index: linux-2.6.git/drivers/input/serio/i8042.c
===================================================================
--- linux-2.6.git.orig/drivers/input/serio/i8042.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/input/serio/i8042.c	2006-07-01 16:51:42.000000000 +0200
@@ -328,7 +328,7 @@ static int i8042_open(struct serio *seri
 			return 0;
 
 	if (request_irq(port->irq, i8042_interrupt,
-			SA_SHIRQ, "i8042", i8042_request_irq_cookie)) {
+			IRQF_SHARED, "i8042", i8042_request_irq_cookie)) {
 		printk(KERN_ERR "i8042.c: Can't get irq %d for %s, unregistering the port.\n", port->irq, port->name);
 		goto irq_fail;
 	}
@@ -610,7 +610,7 @@ static int __devinit i8042_check_aux(voi
  */
 
 	if (request_irq(i8042_ports[I8042_AUX_PORT_NO].irq, i8042_interrupt,
-			SA_SHIRQ, "i8042", &i8042_check_aux_cookie))
+			IRQF_SHARED, "i8042", &i8042_check_aux_cookie))
                 return -1;
 	free_irq(i8042_ports[I8042_AUX_PORT_NO].irq, &i8042_check_aux_cookie);
 
Index: linux-2.6.git/drivers/input/serio/pcips2.c
===================================================================
--- linux-2.6.git.orig/drivers/input/serio/pcips2.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/input/serio/pcips2.c	2006-07-01 16:51:42.000000000 +0200
@@ -107,7 +107,7 @@ static int pcips2_open(struct serio *io)
 	outb(PS2_CTRL_ENABLE, ps2if->base);
 	pcips2_flush_input(ps2if);
 
-	ret = request_irq(ps2if->dev->irq, pcips2_interrupt, SA_SHIRQ,
+	ret = request_irq(ps2if->dev->irq, pcips2_interrupt, IRQF_SHARED,
 			  "pcips2", ps2if);
 	if (ret == 0)
 		val = PS2_CTRL_ENABLE | PS2_CTRL_RXIRQ;
Index: linux-2.6.git/drivers/input/touchscreen/ads7846.c
===================================================================
--- linux-2.6.git.orig/drivers/input/touchscreen/ads7846.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/input/touchscreen/ads7846.c	2006-07-01 16:51:42.000000000 +0200
@@ -773,7 +773,7 @@ static int __devinit ads7846_probe(struc
 
 	ts->last_msg = m;
 
-	if (request_irq(spi->irq, ads7846_irq, SA_TRIGGER_FALLING,
+	if (request_irq(spi->irq, ads7846_irq, IRQF_TRIGGER_FALLING,
 			spi->dev.driver->name, ts)) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
 		err = -EBUSY;
Index: linux-2.6.git/drivers/input/touchscreen/corgi_ts.c
===================================================================
--- linux-2.6.git.orig/drivers/input/touchscreen/corgi_ts.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/input/touchscreen/corgi_ts.c	2006-07-01 16:51:42.000000000 +0200
@@ -318,7 +318,7 @@ static int __init corgits_probe(struct p
 	corgi_ssp_ads7846_putget((5u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
 	mdelay(5);
 
-	if (request_irq(corgi_ts->irq_gpio, ts_interrupt, SA_INTERRUPT, "ts", corgi_ts)) {
+	if (request_irq(corgi_ts->irq_gpio, ts_interrupt, IRQF_DISABLED, "ts", corgi_ts)) {
 		err = -EBUSY;
 		goto fail;
 	}
Index: linux-2.6.git/drivers/input/touchscreen/h3600_ts_input.c
===================================================================
--- linux-2.6.git.orig/drivers/input/touchscreen/h3600_ts_input.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/input/touchscreen/h3600_ts_input.c	2006-07-01 16:51:42.000000000 +0200
@@ -399,14 +399,14 @@ static int h3600ts_connect(struct serio 
 	set_GPIO_IRQ_edge(GPIO_BITSY_NPOWER_BUTTON, GPIO_RISING_EDGE);
 
 	if (request_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, action_button_handler,
-			SA_SHIRQ | SA_INTERRUPT, "h3600_action", &ts->dev)) {
+			IRQF_SHARED | IRQF_DISABLED, "h3600_action", &ts->dev)) {
 		printk(KERN_ERR "h3600ts.c: Could not allocate Action Button IRQ!\n");
 		err = -EBUSY;
 		goto fail2;
 	}
 
 	if (request_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, npower_button_handler,
-			SA_SHIRQ | SA_INTERRUPT, "h3600_suspend", &ts->dev)) {
+			IRQF_SHARED | IRQF_DISABLED, "h3600_suspend", &ts->dev)) {
 		printk(KERN_ERR "h3600ts.c: Could not allocate Power Button IRQ!\n");
 		err = -EBUSY;
 		goto fail3;
Index: linux-2.6.git/drivers/input/touchscreen/hp680_ts_input.c
===================================================================
--- linux-2.6.git.orig/drivers/input/touchscreen/hp680_ts_input.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/input/touchscreen/hp680_ts_input.c	2006-07-01 16:51:42.000000000 +0200
@@ -109,7 +109,7 @@ static int __init hp680_ts_init(void)
 	input_register_device(hp680_ts_dev);
 
 	if (request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
-			SA_INTERRUPT, MODNAME, 0) < 0) {
+			IRQF_DISABLED, MODNAME, 0) < 0) {
 		printk(KERN_ERR "hp680_touchscreen.c: Can't allocate irq %d\n",
 		       HP680_TS_IRQ);
 		input_unregister_device(hp680_ts_dev);
Index: linux-2.6.git/drivers/macintosh/smu.c
===================================================================
--- linux-2.6.git.orig/drivers/macintosh/smu.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/macintosh/smu.c	2006-07-01 16:51:42.000000000 +0200
@@ -555,7 +555,7 @@ static int smu_late_init(void)
 
 	if (smu->db_irq != NO_IRQ) {
 		if (request_irq(smu->db_irq, smu_db_intr,
-				SA_SHIRQ, "SMU doorbell", smu) < 0) {
+				IRQF_SHARED, "SMU doorbell", smu) < 0) {
 			printk(KERN_WARNING "SMU: can't "
 			       "request interrupt %d\n",
 			       smu->db_irq);
@@ -565,7 +565,7 @@ static int smu_late_init(void)
 
 	if (smu->msg_irq != NO_IRQ) {
 		if (request_irq(smu->msg_irq, smu_msg_intr,
-				SA_SHIRQ, "SMU message", smu) < 0) {
+				IRQF_SHARED, "SMU message", smu) < 0) {
 			printk(KERN_WARNING "SMU: can't "
 			       "request interrupt %d\n",
 			       smu->msg_irq);
Index: linux-2.6.git/drivers/message/fusion/mptbase.c
===================================================================
--- linux-2.6.git.orig/drivers/message/fusion/mptbase.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/message/fusion/mptbase.c	2006-07-01 16:51:42.000000000 +0200
@@ -1705,7 +1705,7 @@ mpt_do_ioc_recovery(MPT_ADAPTER *ioc, u3
 				printk(MYIOC_s_INFO_FMT "PCI-MSI enabled\n",
 					ioc->name);
 			rc = request_irq(ioc->pcidev->irq, mpt_interrupt,
-					SA_SHIRQ, ioc->name, ioc);
+					IRQF_SHARED, ioc->name, ioc);
 			if (rc < 0) {
 				printk(MYIOC_s_ERR_FMT "Unable to allocate "
 					"interrupt %d!\n", ioc->name,
Index: linux-2.6.git/drivers/message/i2o/pci.c
===================================================================
--- linux-2.6.git.orig/drivers/message/i2o/pci.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/message/i2o/pci.c	2006-07-01 16:51:42.000000000 +0200
@@ -274,7 +274,7 @@ static int i2o_pci_irq_enable(struct i2o
 	writel(0xffffffff, c->irq_mask);
 
 	if (pdev->irq) {
-		rc = request_irq(pdev->irq, i2o_pci_interrupt, SA_SHIRQ,
+		rc = request_irq(pdev->irq, i2o_pci_interrupt, IRQF_SHARED,
 				 c->name, c);
 		if (rc < 0) {
 			printk(KERN_ERR "%s: unable to allocate interrupt %d."
Index: linux-2.6.git/drivers/mfd/ucb1x00-core.c
===================================================================
--- linux-2.6.git.orig/drivers/mfd/ucb1x00-core.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/mfd/ucb1x00-core.c	2006-07-01 16:51:42.000000000 +0200
@@ -508,7 +508,7 @@ static int ucb1x00_probe(struct mcp *mcp
 		goto err_free;
 	}
 
-	ret = request_irq(ucb->irq, ucb1x00_irq, SA_TRIGGER_RISING,
+	ret = request_irq(ucb->irq, ucb1x00_irq, IRQF_TRIGGER_RISING,
 			  "UCB1x00", ucb);
 	if (ret) {
 		printk(KERN_ERR "ucb1x00: unable to grab irq%d: %d\n",
Index: linux-2.6.git/drivers/misc/ibmasm/module.c
===================================================================
--- linux-2.6.git.orig/drivers/misc/ibmasm/module.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/misc/ibmasm/module.c	2006-07-01 16:51:42.000000000 +0200
@@ -113,7 +113,7 @@ static int __devinit ibmasm_init_one(str
 		goto error_ioremap;
 	}
 
-	result = request_irq(sp->irq, ibmasm_interrupt_handler, SA_SHIRQ, sp->devname, (void*)sp);
+	result = request_irq(sp->irq, ibmasm_interrupt_handler, IRQF_SHARED, sp->devname, (void*)sp);
 	if (result) {
 		dev_err(sp->dev, "Failed to register interrupt handler\n");
 		goto error_request_irq;
Index: linux-2.6.git/drivers/mmc/at91_mci.c
===================================================================
--- linux-2.6.git.orig/drivers/mmc/at91_mci.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/mmc/at91_mci.c	2006-07-01 16:51:42.000000000 +0200
@@ -850,7 +850,7 @@ static int at91_mci_probe(struct platfor
 	/*
 	 * Allocate the MCI interrupt
 	 */
-	ret = request_irq(AT91_ID_MCI, at91_mci_irq, SA_SHIRQ, DRIVER_NAME, host);
+	ret = request_irq(AT91_ID_MCI, at91_mci_irq, IRQF_SHARED, DRIVER_NAME, host);
 	if (ret) {
 		printk(KERN_ERR "Failed to request MCI interrupt\n");
 		clk_disable(mci_clk);
Index: linux-2.6.git/drivers/mmc/au1xmmc.c
===================================================================
--- linux-2.6.git.orig/drivers/mmc/au1xmmc.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/mmc/au1xmmc.c	2006-07-01 16:51:42.000000000 +0200
@@ -886,7 +886,7 @@ static int __devinit au1xmmc_probe(struc
 	int i, ret = 0;
 
 	/* THe interrupt is shared among all controllers */
-	ret = request_irq(AU1100_SD_IRQ, au1xmmc_irq, SA_INTERRUPT, "MMC", 0);
+	ret = request_irq(AU1100_SD_IRQ, au1xmmc_irq, IRQF_DISABLED, "MMC", 0);
 
 	if (ret) {
 		printk(DRIVER_NAME "ERROR: Couldn't get int %d: %d\n",
Index: linux-2.6.git/drivers/mmc/mmci.c
===================================================================
--- linux-2.6.git.orig/drivers/mmc/mmci.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/mmc/mmci.c	2006-07-01 16:51:42.000000000 +0200
@@ -531,11 +531,11 @@ static int mmci_probe(struct amba_device
 	writel(0, host->base + MMCIMASK1);
 	writel(0xfff, host->base + MMCICLEAR);
 
-	ret = request_irq(dev->irq[0], mmci_irq, SA_SHIRQ, DRIVER_NAME " (cmd)", host);
+	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
 	if (ret)
 		goto unmap;
 
-	ret = request_irq(dev->irq[1], mmci_pio_irq, SA_SHIRQ, DRIVER_NAME " (pio)", host);
+	ret = request_irq(dev->irq[1], mmci_pio_irq, IRQF_SHARED, DRIVER_NAME " (pio)", host);
 	if (ret)
 		goto irq0_free;
 
Index: linux-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-2.6.git.orig/drivers/mmc/omap.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/mmc/omap.c	2006-07-01 16:51:42.000000000 +0200
@@ -1085,7 +1085,7 @@ static int __init mmc_omap_probe(struct 
 
 		omap_set_gpio_direction(host->switch_pin, 1);
 		ret = request_irq(OMAP_GPIO_IRQ(host->switch_pin),
-				  mmc_omap_switch_irq, SA_TRIGGER_RISING, DRIVER_NAME, host);
+				  mmc_omap_switch_irq, IRQF_TRIGGER_RISING, DRIVER_NAME, host);
 		if (ret) {
 			dev_warn(mmc_dev(host->mmc), "Unable to get IRQ for MMC cover switch\n");
 			omap_free_gpio(host->switch_pin);
Index: linux-2.6.git/drivers/mmc/sdhci.c
===================================================================
--- linux-2.6.git.orig/drivers/mmc/sdhci.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/mmc/sdhci.c	2006-07-01 16:51:42.000000000 +0200
@@ -1075,7 +1075,7 @@ static int __devinit sdhci_probe_slot(st
 
 	setup_timer(&host->timer, sdhci_timeout_timer, (long)host);
 
-	ret = request_irq(host->irq, sdhci_irq, SA_SHIRQ,
+	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
 		host->slot_descr, host);
 	if (ret)
 		goto unmap;
Index: linux-2.6.git/drivers/mmc/wbsd.c
===================================================================
--- linux-2.6.git.orig/drivers/mmc/wbsd.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/mmc/wbsd.c	2006-07-01 16:51:42.000000000 +0200
@@ -1553,7 +1553,7 @@ static int __devinit wbsd_request_irq(st
 	 * Allocate interrupt.
 	 */
 
-	ret = request_irq(irq, wbsd_irq, SA_SHIRQ, DRIVER_NAME, host);
+	ret = request_irq(irq, wbsd_irq, IRQF_SHARED, DRIVER_NAME, host);
 	if (ret)
 		return ret;
 
Index: linux-2.6.git/drivers/parport/parport_ax88796.c
===================================================================
--- linux-2.6.git.orig/drivers/parport/parport_ax88796.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/parport/parport_ax88796.c	2006-07-01 16:51:42.000000000 +0200
@@ -345,7 +345,7 @@ static int parport_ax88796_probe(struct 
 	if (irq >= 0) {
 		/* request irq */
 		ret = request_irq(irq, parport_ax88796_interrupt,
-				  SA_TRIGGER_FALLING, pdev->name, pp);
+				  IRQF_TRIGGER_FALLING, pdev->name, pp);
 
 		if (ret < 0)
 			goto exit_port;
Index: linux-2.6.git/drivers/parport/parport_mfc3.c
===================================================================
--- linux-2.6.git.orig/drivers/parport/parport_mfc3.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/parport/parport_mfc3.c	2006-07-01 16:51:42.000000000 +0200
@@ -353,7 +353,7 @@ static int __init parport_mfc3_init(void
 
 		if (p->irq != PARPORT_IRQ_NONE) {
 			if (use_cnt++ == 0)
-				if (request_irq(IRQ_AMIGA_PORTS, mfc3_interrupt, SA_SHIRQ, p->name, &pp_mfc3_ops))
+				if (request_irq(IRQ_AMIGA_PORTS, mfc3_interrupt, IRQF_SHARED, p->name, &pp_mfc3_ops))
 					goto out_irq;
 		}
 
Index: linux-2.6.git/drivers/parport/parport_sunbpp.c
===================================================================
--- linux-2.6.git.orig/drivers/parport/parport_sunbpp.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/parport/parport_sunbpp.c	2006-07-01 16:51:42.000000000 +0200
@@ -322,7 +322,7 @@ static int __devinit init_one_port(struc
 	p->size = size;
 
 	if ((err = request_irq(p->irq, parport_sunbpp_interrupt,
-			       SA_SHIRQ, p->name, p)) != 0) {
+			       IRQF_SHARED, p->name, p)) != 0) {
 		goto out_put_port;
 	}
 
Index: linux-2.6.git/drivers/pcmcia/at91_cf.c
===================================================================
--- linux-2.6.git.orig/drivers/pcmcia/at91_cf.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pcmcia/at91_cf.c	2006-07-01 16:51:42.000000000 +0200
@@ -267,7 +267,7 @@ static int __init at91_cf_probe(struct p
 
 	/* must be a GPIO; ergo must trigger on both edges */
 	status = request_irq(board->det_pin, at91_cf_irq,
-			SA_SAMPLE_RANDOM, driver_name, cf);
+			IRQF_SAMPLE_RANDOM, driver_name, cf);
 	if (status < 0)
 		goto fail0;
 	device_init_wakeup(&pdev->dev, 1);
@@ -280,7 +280,7 @@ static int __init at91_cf_probe(struct p
 	 */
 	if (board->irq_pin) {
 		status = request_irq(board->irq_pin, at91_cf_irq,
-				SA_SHIRQ, driver_name, cf);
+				IRQF_SHARED, driver_name, cf);
 		if (status < 0)
 			goto fail0a;
 		cf->socket.pci_irq = board->irq_pin;
Index: linux-2.6.git/drivers/pcmcia/hd64465_ss.c
===================================================================
--- linux-2.6.git.orig/drivers/pcmcia/hd64465_ss.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pcmcia/hd64465_ss.c	2006-07-01 16:51:42.000000000 +0200
@@ -761,7 +761,7 @@ static int hs_init_socket(hs_socket_t *s
 	
 	hd64465_register_irq_demux(sp->irq, hs_irq_demux, sp);
 	
-    	if ((err = request_irq(sp->irq, hs_interrupt, SA_INTERRUPT, MODNAME, sp)) < 0)
+    	if ((err = request_irq(sp->irq, hs_interrupt, IRQF_DISABLED, MODNAME, sp)) < 0)
 	    return err;
     	if (request_mem_region(sp->mem_base, sp->mem_length, MODNAME) == 0) {
     	    sp->mem_base = 0;
Index: linux-2.6.git/drivers/pcmcia/i82092.c
===================================================================
--- linux-2.6.git.orig/drivers/pcmcia/i82092.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pcmcia/i82092.c	2006-07-01 16:51:42.000000000 +0200
@@ -149,7 +149,7 @@ static int __devinit i82092aa_pci_probe(
 
 	/* Register the interrupt handler */
 	dprintk(KERN_DEBUG "Requesting interrupt %i \n",dev->irq);
-	if ((ret = request_irq(dev->irq, i82092aa_interrupt, SA_SHIRQ, "i82092aa", i82092aa_interrupt))) {
+	if ((ret = request_irq(dev->irq, i82092aa_interrupt, IRQF_SHARED, "i82092aa", i82092aa_interrupt))) {
 		printk(KERN_ERR "i82092aa: Failed to register IRQ %d, aborting\n", dev->irq);
 		goto err_out_free_res;
 	}
Index: linux-2.6.git/drivers/pcmcia/i82365.c
===================================================================
--- linux-2.6.git.orig/drivers/pcmcia/i82365.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pcmcia/i82365.c	2006-07-01 16:51:42.000000000 +0200
@@ -509,7 +509,7 @@ static irqreturn_t i365_count_irq(int ir
 static u_int __init test_irq(u_short sock, int irq)
 {
     debug(2, "  testing ISA irq %d\n", irq);
-    if (request_irq(irq, i365_count_irq, SA_PROBEIRQ, "scan",
+    if (request_irq(irq, i365_count_irq, IRQF_PROBE_SHARED, "scan",
 			i365_count_irq) != 0)
 	return 1;
     irq_hits = 0; irq_sock = sock;
@@ -562,7 +562,7 @@ static u_int __init isa_scan(u_short soc
     } else {
 	/* Fallback: just find interrupts that aren't in use */
 	for (i = 0; i < 16; i++)
-	    if ((mask0 & (1 << i)) && (_check_irq(i, SA_PROBEIRQ) == 0))
+	    if ((mask0 & (1 << i)) && (_check_irq(i, IRQF_PROBE_SHARED) == 0))
 		mask1 |= (1 << i);
 	printk("default");
 	/* If scan failed, default to polled status */
@@ -726,7 +726,7 @@ static void __init add_pcic(int ns, int 
 	u_int cs_mask = mask & ((cs_irq) ? (1<<cs_irq) : ~(1<<12));
 	for (cs_irq = 15; cs_irq > 0; cs_irq--)
 	    if ((cs_mask & (1 << cs_irq)) &&
-		(_check_irq(cs_irq, SA_PROBEIRQ) == 0))
+		(_check_irq(cs_irq, IRQF_PROBE_SHARED) == 0))
 		break;
 	if (cs_irq) {
 	    grab_irq = 1;
Index: linux-2.6.git/drivers/pcmcia/omap_cf.c
===================================================================
--- linux-2.6.git.orig/drivers/pcmcia/omap_cf.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pcmcia/omap_cf.c	2006-07-01 16:51:42.000000000 +0200
@@ -232,7 +232,7 @@ static int __init omap_cf_probe(struct d
 	dev_set_drvdata(dev, cf);
 
 	/* this primarily just shuts up irq handling noise */
-	status = request_irq(irq, omap_cf_irq, SA_SHIRQ,
+	status = request_irq(irq, omap_cf_irq, IRQF_SHARED,
 			driver_name, cf);
 	if (status < 0)
 		goto fail0;
Index: linux-2.6.git/drivers/pcmcia/pcmcia_resource.c
===================================================================
--- linux-2.6.git.orig/drivers/pcmcia/pcmcia_resource.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pcmcia/pcmcia_resource.c	2006-07-01 16:51:42.000000000 +0200
@@ -801,9 +801,9 @@ int pcmcia_request_irq(struct pcmcia_dev
 	/* Decide what type of interrupt we are registering */
 	type = 0;
 	if (s->functions > 1)		/* All of this ought to be handled higher up */
-		type = SA_SHIRQ;
+		type = IRQF_SHARED;
 	if (req->Attributes & IRQ_TYPE_DYNAMIC_SHARING)
-		type = SA_SHIRQ;
+		type = IRQF_SHARED;
 
 #ifdef CONFIG_PCMCIA_PROBE
 	if (s->irq.AssignedIRQ != 0) {
@@ -845,7 +845,7 @@ int pcmcia_request_irq(struct pcmcia_dev
 	if (ret && !s->irq.AssignedIRQ) {
 		if (!s->pci_irq)
 			return ret;
-		type = SA_SHIRQ;
+		type = IRQF_SHARED;
 		irq = s->pci_irq;
 	}
 
@@ -855,7 +855,7 @@ int pcmcia_request_irq(struct pcmcia_dev
 	}
 
 	/* Make sure the fact the request type was overridden is passed back */
-	if (type == SA_SHIRQ && !(req->Attributes & IRQ_TYPE_DYNAMIC_SHARING)) {
+	if (type == IRQF_SHARED && !(req->Attributes & IRQ_TYPE_DYNAMIC_SHARING)) {
 		req->Attributes |= IRQ_TYPE_DYNAMIC_SHARING;
 		printk(KERN_WARNING "pcmcia: request for exclusive IRQ could not be fulfilled.\n");
 		printk(KERN_WARNING "pcmcia: the driver needs updating to supported shared IRQ lines.\n");
Index: linux-2.6.git/drivers/pcmcia/pd6729.c
===================================================================
--- linux-2.6.git.orig/drivers/pcmcia/pd6729.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pcmcia/pd6729.c	2006-07-01 16:51:42.000000000 +0200
@@ -689,7 +689,7 @@ static int __devinit pd6729_pci_probe(st
 	pci_set_drvdata(dev, socket);
 	if (irq_mode == 1) {
 		/* Register the interrupt handler */
-		if ((ret = request_irq(dev->irq, pd6729_interrupt, SA_SHIRQ,
+		if ((ret = request_irq(dev->irq, pd6729_interrupt, IRQF_SHARED,
 							"pd6729", socket))) {
 			printk(KERN_ERR "pd6729: Failed to register irq %d, "
 							"aborting\n", dev->irq);
Index: linux-2.6.git/drivers/pcmcia/soc_common.c
===================================================================
--- linux-2.6.git.orig/drivers/pcmcia/soc_common.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pcmcia/soc_common.c	2006-07-01 16:51:42.000000000 +0200
@@ -523,7 +523,7 @@ int soc_pcmcia_request_irqs(struct soc_p
 		if (irqs[i].sock != skt->nr)
 			continue;
 		res = request_irq(irqs[i].irq, soc_common_pcmcia_interrupt,
-				  SA_INTERRUPT, irqs[i].str, skt);
+				  IRQF_DISABLED, irqs[i].str, skt);
 		if (res)
 			break;
 		set_irq_type(irqs[i].irq, IRQT_NOEDGE);
Index: linux-2.6.git/drivers/pcmcia/vrc4171_card.c
===================================================================
--- linux-2.6.git.orig/drivers/pcmcia/vrc4171_card.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pcmcia/vrc4171_card.c	2006-07-01 16:51:42.000000000 +0200
@@ -730,7 +730,7 @@ static int __devinit vrc4171_card_init(v
 
 	retval = vrc4171_add_sockets();
 	if (retval == 0)
-		retval = request_irq(vrc4171_irq, pccard_interrupt, SA_SHIRQ,
+		retval = request_irq(vrc4171_irq, pccard_interrupt, IRQF_SHARED,
 		                     vrc4171_card_name, vrc4171_sockets);
 
 	if (retval < 0) {
Index: linux-2.6.git/drivers/pcmcia/vrc4173_cardu.c
===================================================================
--- linux-2.6.git.orig/drivers/pcmcia/vrc4173_cardu.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pcmcia/vrc4173_cardu.c	2006-07-01 16:51:42.000000000 +0200
@@ -500,7 +500,7 @@ static int __devinit vrc4173_cardu_probe
 		return -ENOMEM;
 	}
 
-	if (request_irq(dev->irq, cardu_interrupt, SA_SHIRQ, socket->name, socket) < 0) {
+	if (request_irq(dev->irq, cardu_interrupt, IRQF_SHARED, socket->name, socket) < 0) {
 		pcmcia_unregister_socket(socket->pcmcia_socket);
 		socket->pcmcia_socket = NULL;
 		iounmap(socket->base);
Index: linux-2.6.git/drivers/pcmcia/yenta_socket.c
===================================================================
--- linux-2.6.git.orig/drivers/pcmcia/yenta_socket.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pcmcia/yenta_socket.c	2006-07-01 16:51:42.000000000 +0200
@@ -923,7 +923,7 @@ static int yenta_probe_cb_irq(struct yen
 
 	socket->probe_status = 0;
 
-	if (request_irq(socket->cb_irq, yenta_probe_handler, SA_SHIRQ, "yenta", socket)) {
+	if (request_irq(socket->cb_irq, yenta_probe_handler, IRQF_SHARED, "yenta", socket)) {
 		printk(KERN_WARNING "Yenta: request_irq() in yenta_probe_cb_irq() failed!\n");
 		return -1;
 	}
@@ -1172,7 +1172,7 @@ static int __devinit yenta_probe (struct
 
 	/* We must finish initialization here */
 
-	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, "yenta", socket)) {
+	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, IRQF_SHARED, "yenta", socket)) {
 		/* No IRQ or request_irq failed. Poll */
 		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
 		init_timer(&socket->poll_timer);
Index: linux-2.6.git/drivers/pnp/resource.c
===================================================================
--- linux-2.6.git.orig/drivers/pnp/resource.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/pnp/resource.c	2006-07-01 16:51:42.000000000 +0200
@@ -395,7 +395,7 @@ int pnp_check_irq(struct pnp_dev * dev, 
 	/* check if the resource is already in use, skip if the
 	 * device is active because it itself may be in use */
 	if(!dev->active) {
-		if (request_irq(*irq, pnp_test_handler, SA_INTERRUPT, "pnp", NULL))
+		if (request_irq(*irq, pnp_test_handler, IRQF_DISABLED, "pnp", NULL))
 			return 0;
 		free_irq(*irq, NULL);
 	}
Index: linux-2.6.git/drivers/rtc/rtc-at91.c
===================================================================
--- linux-2.6.git.orig/drivers/rtc/rtc-at91.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/rtc/rtc-at91.c	2006-07-01 16:51:42.000000000 +0200
@@ -293,7 +293,7 @@ static int __init at91_rtc_probe(struct 
 					AT91_RTC_CALEV);
 
 	ret = request_irq(AT91_ID_SYS, at91_rtc_interrupt,
-				SA_SHIRQ, "at91_rtc", pdev);
+				IRQF_SHARED, "at91_rtc", pdev);
 	if (ret) {
 		printk(KERN_ERR "at91_rtc: IRQ %d already in use.\n",
 				AT91_ID_SYS);
Index: linux-2.6.git/drivers/rtc/rtc-ds1553.c
===================================================================
--- linux-2.6.git.orig/drivers/rtc/rtc-ds1553.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/rtc/rtc-ds1553.c	2006-07-01 16:51:42.000000000 +0200
@@ -341,7 +341,7 @@ static int __init ds1553_rtc_probe(struc
 
 	if (pdata->irq >= 0) {
 		writeb(0, ioaddr + RTC_INTERRUPTS);
-		if (request_irq(pdata->irq, ds1553_rtc_interrupt, SA_SHIRQ,
+		if (request_irq(pdata->irq, ds1553_rtc_interrupt, IRQF_SHARED,
 				pdev->name, pdev) < 0) {
 			dev_warn(&pdev->dev, "interrupt not available.\n");
 			pdata->irq = -1;
Index: linux-2.6.git/drivers/rtc/rtc-pl031.c
===================================================================
--- linux-2.6.git.orig/drivers/rtc/rtc-pl031.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/rtc/rtc-pl031.c	2006-07-01 16:51:42.000000000 +0200
@@ -173,7 +173,7 @@ static int pl031_probe(struct amba_devic
 		goto out_no_remap;
 	}
 
-	if (request_irq(adev->irq[0], pl031_interrupt, SA_INTERRUPT,
+	if (request_irq(adev->irq[0], pl031_interrupt, IRQF_DISABLED,
 			"rtc-pl031", ldata->rtc)) {
 		ret = -EIO;
 		goto out_no_irq;
Index: linux-2.6.git/drivers/rtc/rtc-sa1100.c
===================================================================
--- linux-2.6.git.orig/drivers/rtc/rtc-sa1100.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/rtc/rtc-sa1100.c	2006-07-01 16:51:42.000000000 +0200
@@ -157,19 +157,19 @@ static int sa1100_rtc_open(struct device
 {
 	int ret;
 
-	ret = request_irq(IRQ_RTC1Hz, sa1100_rtc_interrupt, SA_INTERRUPT,
+	ret = request_irq(IRQ_RTC1Hz, sa1100_rtc_interrupt, IRQF_DISABLED,
 				"rtc 1Hz", dev);
 	if (ret) {
 		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTC1Hz);
 		goto fail_ui;
 	}
-	ret = request_irq(IRQ_RTCAlrm, sa1100_rtc_interrupt, SA_INTERRUPT,
+	ret = request_irq(IRQ_RTCAlrm, sa1100_rtc_interrupt, IRQF_DISABLED,
 				"rtc Alrm", dev);
 	if (ret) {
 		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTCAlrm);
 		goto fail_ai;
 	}
-	ret = request_irq(IRQ_OST1, timer1_interrupt, SA_INTERRUPT,
+	ret = request_irq(IRQ_OST1, timer1_interrupt, IRQF_DISABLED,
 				"rtc timer", dev);
 	if (ret) {
 		dev_err(dev, "IRQ %d already in use.\n", IRQ_OST1);
Index: linux-2.6.git/drivers/rtc/rtc-vr41xx.c
===================================================================
--- linux-2.6.git.orig/drivers/rtc/rtc-vr41xx.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/rtc/rtc-vr41xx.c	2006-07-01 16:51:42.000000000 +0200
@@ -345,11 +345,11 @@ static int __devinit rtc_probe(struct pl
 	spin_unlock_irq(&rtc_lock);
 
 	irq = ELAPSEDTIME_IRQ;
-	retval = request_irq(irq, elapsedtime_interrupt, SA_INTERRUPT,
+	retval = request_irq(irq, elapsedtime_interrupt, IRQF_DISABLED,
 	                     "elapsed_time", pdev);
 	if (retval == 0) {
 		irq = RTCLONG1_IRQ;
-		retval = request_irq(irq, rtclong1_interrupt, SA_INTERRUPT,
+		retval = request_irq(irq, rtclong1_interrupt, IRQF_DISABLED,
 		                     "rtclong1", pdev);
 	}
 
Index: linux-2.6.git/drivers/sbus/char/aurora.c
===================================================================
--- linux-2.6.git.orig/drivers/sbus/char/aurora.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/sbus/char/aurora.c	2006-07-01 16:51:42.000000000 +0200
@@ -337,19 +337,19 @@ static int aurora_probe(void)
 				printk("intr pri %d\n", grrr);
 #endif
 				if ((bp->irq=irqs[bn]) && valid_irq(bp->irq) &&
-				    !request_irq(bp->irq|0x30, aurora_interrupt, SA_SHIRQ, "sio16", bp)) {
+				    !request_irq(bp->irq|0x30, aurora_interrupt, IRQF_SHARED, "sio16", bp)) {
 					free_irq(bp->irq|0x30, bp);
 				} else
 				if ((bp->irq=prom_getint(sdev->prom_node, "bintr")) && valid_irq(bp->irq) &&
-				    !request_irq(bp->irq|0x30, aurora_interrupt, SA_SHIRQ, "sio16", bp)) {
+				    !request_irq(bp->irq|0x30, aurora_interrupt, IRQF_SHARED, "sio16", bp)) {
 					free_irq(bp->irq|0x30, bp);
 				} else
 				if ((bp->irq=prom_getint(sdev->prom_node, "intr")) && valid_irq(bp->irq) &&
-				    !request_irq(bp->irq|0x30, aurora_interrupt, SA_SHIRQ, "sio16", bp)) {
+				    !request_irq(bp->irq|0x30, aurora_interrupt, IRQF_SHARED, "sio16", bp)) {
 					free_irq(bp->irq|0x30, bp);
 				} else
 				for(grrr=0;grrr<TYPE_1_IRQS;grrr++) {
-					if ((bp->irq=type_1_irq[grrr])&&!request_irq(bp->irq|0x30, aurora_interrupt, SA_SHIRQ, "sio16", bp)) {
+					if ((bp->irq=type_1_irq[grrr])&&!request_irq(bp->irq|0x30, aurora_interrupt, IRQF_SHARED, "sio16", bp)) {
 						free_irq(bp->irq|0x30, bp);
 						break;
 					} else {
@@ -909,14 +909,14 @@ static int aurora_setup_board(struct Aur
 #ifdef AURORA_ALLIRQ
 	int i;
 	for (i = 0; i < AURORA_ALLIRQ; i++) {
-		error = request_irq(allirq[i]|0x30, aurora_interrupt, SA_SHIRQ,
+		error = request_irq(allirq[i]|0x30, aurora_interrupt, IRQF_SHARED,
 				    "sio16", bp);
 		if (error)
 			printk(KERN_ERR "IRQ%d request error %d\n",
 			       allirq[i], error);
 	}
 #else
-	error = request_irq(bp->irq|0x30, aurora_interrupt, SA_SHIRQ,
+	error = request_irq(bp->irq|0x30, aurora_interrupt, IRQF_SHARED,
 			    "sio16", bp);
 	if (error) {
 		printk(KERN_ERR "IRQ request error %d\n", error);
Index: linux-2.6.git/drivers/sbus/char/bbc_i2c.c
===================================================================
--- linux-2.6.git.orig/drivers/sbus/char/bbc_i2c.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/sbus/char/bbc_i2c.c	2006-07-01 16:51:42.000000000 +0200
@@ -377,7 +377,7 @@ static int __init attach_one_i2c(struct 
 	bp->waiting = 0;
 	init_waitqueue_head(&bp->wq);
 	if (request_irq(edev->irqs[0], bbc_i2c_interrupt,
-			SA_SHIRQ, "bbc_i2c", bp))
+			IRQF_SHARED, "bbc_i2c", bp))
 		goto fail;
 
 	bp->index = index;
Index: linux-2.6.git/drivers/sbus/char/cpwatchdog.c
===================================================================
--- linux-2.6.git.orig/drivers/sbus/char/cpwatchdog.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/sbus/char/cpwatchdog.c	2006-07-01 16:51:42.000000000 +0200
@@ -301,7 +301,7 @@ static int wd_open(struct inode *inode, 
 	{	
 		if (request_irq(wd_dev.irq, 
 						&wd_interrupt, 
-						SA_SHIRQ,
+						IRQF_SHARED,
 						WD_OBPNAME,
 						(void *)wd_dev.regs)) {
 			printk("%s: Cannot register IRQ %d\n", 
Index: linux-2.6.git/drivers/sn/ioc3.c
===================================================================
--- linux-2.6.git.orig/drivers/sn/ioc3.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/sn/ioc3.c	2006-07-01 16:51:42.000000000 +0200
@@ -706,7 +706,7 @@ static int ioc3_probe(struct pci_dev *pd
 		writel(~0, &idd->vma->eisr);
 
 		idd->dual_irq = 1;
-		if (!request_irq(pdev->irq, ioc3_intr_eth, SA_SHIRQ,
+		if (!request_irq(pdev->irq, ioc3_intr_eth, IRQF_SHARED,
 				 "ioc3-eth", (void *)idd)) {
 			idd->irq_eth = pdev->irq;
 		} else {
@@ -714,7 +714,7 @@ static int ioc3_probe(struct pci_dev *pd
 			       "%s : request_irq fails for IRQ 0x%x\n ",
 			       __FUNCTION__, pdev->irq);
 		}
-		if (!request_irq(pdev->irq+2, ioc3_intr_io, SA_SHIRQ,
+		if (!request_irq(pdev->irq+2, ioc3_intr_io, IRQF_SHARED,
 				 "ioc3-io", (void *)idd)) {
 			idd->irq_io = pdev->irq+2;
 		} else {
@@ -723,7 +723,7 @@ static int ioc3_probe(struct pci_dev *pd
 			       __FUNCTION__, pdev->irq+2);
 		}
 	} else {
-		if (!request_irq(pdev->irq, ioc3_intr_io, SA_SHIRQ,
+		if (!request_irq(pdev->irq, ioc3_intr_io, IRQF_SHARED,
 				 "ioc3", (void *)idd)) {
 			idd->irq_io = pdev->irq;
 		} else {
Index: linux-2.6.git/drivers/tc/zs.c
===================================================================
--- linux-2.6.git.orig/drivers/tc/zs.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/tc/zs.c	2006-07-01 16:51:42.000000000 +0200
@@ -1791,7 +1791,7 @@ int __init zs_init(void)
 		zs_soft[channel].clk_divisor = 16;
 		zs_soft[channel].zs_baud = get_zsbaud(&zs_soft[channel]);
 
-		if (request_irq(zs_soft[channel].irq, rs_interrupt, SA_SHIRQ,
+		if (request_irq(zs_soft[channel].irq, rs_interrupt, IRQF_SHARED,
 				"scc", &zs_soft[channel]))
 			printk(KERN_ERR "decserial: can't get irq %d\n",
 			       zs_soft[channel].irq);

--

