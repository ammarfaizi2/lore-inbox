Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWGAPFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWGAPFO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWGAPE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:04:29 -0400
Received: from www.osadl.org ([213.239.205.134]:2213 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751533AbWGAO5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:37 -0400
Message-Id: <20060701145227.780197000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:55:05 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>,
       James.Bottomley@HansenPartnership.com
Subject: [RFC][patch 39/44] scsi: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-scsi.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/scsi/3w-9xxx.c                 |    2 +-
 drivers/scsi/3w-xxxx.c                 |    2 +-
 drivers/scsi/53c7xx.c                  |    4 ++--
 drivers/scsi/BusLogic.c                |    2 +-
 drivers/scsi/NCR5380.c                 |    2 +-
 drivers/scsi/NCR_D700.c                |    2 +-
 drivers/scsi/NCR_Q720.c                |    2 +-
 drivers/scsi/a100u2w.c                 |    2 +-
 drivers/scsi/a2091.c                   |    2 +-
 drivers/scsi/a3000.c                   |    2 +-
 drivers/scsi/aacraid/rkt.c             |    2 +-
 drivers/scsi/aacraid/rx.c              |    2 +-
 drivers/scsi/aacraid/sa.c              |    2 +-
 drivers/scsi/advansys.c                |   18 +++++++++---------
 drivers/scsi/aha152x.c                 |    4 ++--
 drivers/scsi/aha1740.c                 |    2 +-
 drivers/scsi/ahci.c                    |    2 +-
 drivers/scsi/aic7xxx/aic7770_osm.c     |    2 +-
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c |    2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |    2 +-
 drivers/scsi/aic7xxx_old.c             |    4 ++--
 drivers/scsi/arm/acornscsi.c           |    2 +-
 drivers/scsi/arm/cumana_1.c            |    2 +-
 drivers/scsi/arm/cumana_2.c            |    2 +-
 drivers/scsi/arm/powertec.c            |    2 +-
 drivers/scsi/atp870u.c                 |    6 +++---
 drivers/scsi/blz1230.c                 |    2 +-
 drivers/scsi/blz2060.c                 |    2 +-
 drivers/scsi/cyberstorm.c              |    2 +-
 drivers/scsi/cyberstormII.c            |    2 +-
 drivers/scsi/dc395x.c                  |    2 +-
 drivers/scsi/dec_esp.c                 |   10 +++++-----
 drivers/scsi/dmx3191d.c                |    2 +-
 drivers/scsi/dpt_i2o.c                 |    2 +-
 drivers/scsi/dtc.c                     |    2 +-
 drivers/scsi/eata.c                    |    2 +-
 drivers/scsi/eata_pio.c                |    4 ++--
 drivers/scsi/esp.c                     |    2 +-
 drivers/scsi/fastlane.c                |    2 +-
 drivers/scsi/fd_mcs.c                  |    2 +-
 drivers/scsi/fdomain.c                 |    2 +-
 drivers/scsi/g_NCR5380.c               |    2 +-
 drivers/scsi/gdth.c                    |    6 +++---
 drivers/scsi/gvp11.c                   |    2 +-
 drivers/scsi/hptiop.c                  |    2 +-
 drivers/scsi/ibmmca.c                  |    6 +++---
 drivers/scsi/in2000.c                  |    2 +-
 drivers/scsi/initio.c                  |    2 +-
 drivers/scsi/ipr.c                     |    2 +-
 drivers/scsi/ips.c                     |    4 ++--
 drivers/scsi/jazz_esp.c                |    2 +-
 drivers/scsi/lasi700.c                 |    2 +-
 drivers/scsi/libata-bmdma.c            |    2 +-
 drivers/scsi/lpfc/lpfc_init.c          |    2 +-
 drivers/scsi/megaraid.c                |    2 +-
 drivers/scsi/megaraid/megaraid_mbox.c  |    2 +-
 drivers/scsi/megaraid/megaraid_sas.c   |    2 +-
 drivers/scsi/nsp32.c                   |    2 +-
 drivers/scsi/oktagon_esp.c             |    2 +-
 drivers/scsi/pas16.c                   |    2 +-
 drivers/scsi/pcmcia/nsp_cs.c           |    2 +-
 drivers/scsi/pcmcia/sym53c500_cs.c     |    2 +-
 drivers/scsi/pdc_adma.c                |    2 +-
 drivers/scsi/qla1280.c                 |    4 ++--
 drivers/scsi/qla2xxx/qla_os.c          |    2 +-
 drivers/scsi/qlogicpti.c               |    2 +-
 drivers/scsi/sata_mv.c                 |    2 +-
 drivers/scsi/sata_promise.c            |    2 +-
 drivers/scsi/sata_qstor.c              |    2 +-
 drivers/scsi/sata_sil.c                |    2 +-
 drivers/scsi/sata_sil24.c              |    2 +-
 drivers/scsi/sata_svw.c                |    2 +-
 drivers/scsi/sata_sx4.c                |    2 +-
 drivers/scsi/sata_via.c                |    2 +-
 drivers/scsi/sata_vsc.c                |    2 +-
 drivers/scsi/seagate.c                 |    2 +-
 drivers/scsi/sim710.c                  |    2 +-
 drivers/scsi/sun3x_esp.c               |    2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c    |    2 +-
 drivers/scsi/t128.c                    |    2 +-
 drivers/scsi/tmscsim.c                 |    2 +-
 drivers/scsi/u14-34f.c                 |    2 +-
 drivers/scsi/wd7000.c                  |    2 +-
 drivers/scsi/zalon.c                   |    2 +-
 84 files changed, 108 insertions(+), 108 deletions(-)

Index: linux-2.6.git/drivers/scsi/3w-9xxx.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/3w-9xxx.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/3w-9xxx.c	2006-07-01 16:51:47.000000000 +0200
@@ -2122,7 +2122,7 @@ static int __devinit twa_probe(struct pc
 				     TW_PARAM_PORTCOUNT, TW_PARAM_PORTCOUNT_LENGTH)));
 
 	/* Now setup the interrupt handler */
-	retval = request_irq(pdev->irq, twa_interrupt, SA_SHIRQ, "3w-9xxx", tw_dev);
+	retval = request_irq(pdev->irq, twa_interrupt, IRQF_SHARED, "3w-9xxx", tw_dev);
 	if (retval) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x30, "Error requesting IRQ");
 		goto out_remove_host;
Index: linux-2.6.git/drivers/scsi/3w-xxxx.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/3w-xxxx.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/3w-xxxx.c	2006-07-01 16:51:47.000000000 +0200
@@ -2397,7 +2397,7 @@ static int __devinit tw_probe(struct pci
 	printk(KERN_WARNING "3w-xxxx: scsi%d: Found a 3ware Storage Controller at 0x%x, IRQ: %d.\n", host->host_no, tw_dev->base_addr, pdev->irq);
 
 	/* Now setup the interrupt handler */
-	retval = request_irq(pdev->irq, tw_interrupt, SA_SHIRQ, "3w-xxxx", tw_dev);
+	retval = request_irq(pdev->irq, tw_interrupt, IRQF_SHARED, "3w-xxxx", tw_dev);
 	if (retval) {
 		printk(KERN_WARNING "3w-xxxx: Error requesting IRQ.");
 		goto out_remove_host;
Index: linux-2.6.git/drivers/scsi/53c7xx.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/53c7xx.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/53c7xx.c	2006-07-01 16:51:47.000000000 +0200
@@ -1070,7 +1070,7 @@ NCR53c7x0_init (struct Scsi_Host *host) 
 
     NCR53c7x0_driver_init (host);
 
-    if (request_irq(host->irq, NCR53c7x0_intr, SA_SHIRQ, "53c7xx", host))
+    if (request_irq(host->irq, NCR53c7x0_intr, IRQF_SHARED, "53c7xx", host))
     {
 	printk("scsi%d : IRQ%d not free, detaching\n",
 		host->host_no, host->irq);
@@ -4232,7 +4232,7 @@ restart:
  * Purpose : handle NCR53c7x0 interrupts for all NCR devices sharing
  *	the same IRQ line.  
  * 
- * Inputs : Since we're using the SA_INTERRUPT interrupt handler
+ * Inputs : Since we're using the IRQF_DISABLED interrupt handler
  *	semantics, irq indicates the interrupt which invoked 
  *	this handler.  
  *
Index: linux-2.6.git/drivers/scsi/a100u2w.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/a100u2w.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/a100u2w.c	2006-07-01 16:51:47.000000000 +0200
@@ -1120,7 +1120,7 @@ static int __devinit inia100_probe_one(s
 	shost->sg_tablesize = TOTAL_SG_ENTRY;
 
 	/* Initial orc chip           */
-	error = request_irq(pdev->irq, inia100_intr, SA_SHIRQ,
+	error = request_irq(pdev->irq, inia100_intr, IRQF_SHARED,
 			"inia100", shost);
 	if (error < 0) {
 		printk(KERN_WARNING "inia100: unable to get irq %d\n",
Index: linux-2.6.git/drivers/scsi/a2091.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/a2091.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/a2091.c	2006-07-01 16:51:47.000000000 +0200
@@ -208,7 +208,7 @@ int __init a2091_detect(struct scsi_host
 	regs.SASR = &(DMA(instance)->SASR);
 	regs.SCMD = &(DMA(instance)->SCMD);
 	wd33c93_init(instance, regs, dma_setup, dma_stop, WD33C93_FS_8_10);
-	request_irq(IRQ_AMIGA_PORTS, a2091_intr, SA_SHIRQ, "A2091 SCSI",
+	request_irq(IRQ_AMIGA_PORTS, a2091_intr, IRQF_SHARED, "A2091 SCSI",
 		    instance);
 	DMA(instance)->CNTR = CNTR_PDMD | CNTR_INTEN;
 	num_a2091++;
Index: linux-2.6.git/drivers/scsi/a3000.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/a3000.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/a3000.c	2006-07-01 16:51:47.000000000 +0200
@@ -190,7 +190,7 @@ int __init a3000_detect(struct scsi_host
     regs.SASR = &(DMA(a3000_host)->SASR);
     regs.SCMD = &(DMA(a3000_host)->SCMD);
     wd33c93_init(a3000_host, regs, dma_setup, dma_stop, WD33C93_FS_12_15);
-    if (request_irq(IRQ_AMIGA_PORTS, a3000_intr, SA_SHIRQ, "A3000 SCSI",
+    if (request_irq(IRQ_AMIGA_PORTS, a3000_intr, IRQF_SHARED, "A3000 SCSI",
 		    a3000_intr))
         goto fail_irq;
     DMA(a3000_host)->CNTR = CNTR_PDMD | CNTR_INTEN;
Index: linux-2.6.git/drivers/scsi/advansys.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/advansys.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/advansys.c	2006-07-01 16:51:47.000000000 +0200
@@ -371,7 +371,7 @@
 
      1.5 (8/8/96):
          1. Add support for ABP-940U (PCI Ultra) adapter.
-         2. Add support for IRQ sharing by setting the SA_SHIRQ flag for
+         2. Add support for IRQ sharing by setting the IRQF_SHARED flag for
             request_irq and supplying a dev_id pointer to both request_irq()
             and free_irq().
          3. In AscSearchIOPortAddr11() restore a call to check_region() which
@@ -504,9 +504,9 @@
          3. For v2.1.93 and newer kernels use CONFIG_PCI and new PCI BIOS
             access functions.
          4. Update board serial number printing.
-         5. Try allocating an IRQ both with and without the SA_INTERRUPT
+         5. Try allocating an IRQ both with and without the IRQF_DISABLED
             flag set to allow IRQ sharing with drivers that do not set
-            the SA_INTERRUPT flag. Also display a more descriptive error
+            the IRQF_DISABLED flag. Also display a more descriptive error
             message if request_irq() fails.
          6. Update to latest Asc and Adv Libraries.
 
@@ -5202,19 +5202,19 @@ advansys_detect(struct scsi_host_templat
             /* Register IRQ Number. */
             ASC_DBG1(2, "advansys_detect: request_irq() %d\n", shp->irq);
            /*
-            * If request_irq() fails with the SA_INTERRUPT flag set,
-            * then try again without the SA_INTERRUPT flag set. This
+            * If request_irq() fails with the IRQF_DISABLED flag set,
+            * then try again without the IRQF_DISABLED flag set. This
             * allows IRQ sharing to work even with other drivers that
-            * do not set the SA_INTERRUPT flag.
+            * do not set the IRQF_DISABLED flag.
             *
-            * If SA_INTERRUPT is not set, then interrupts are enabled
+            * If IRQF_DISABLED is not set, then interrupts are enabled
             * before the driver interrupt function is called.
             */
             if (((ret = request_irq(shp->irq, advansys_interrupt,
-                            SA_INTERRUPT | (share_irq == TRUE ? SA_SHIRQ : 0),
+                            IRQF_DISABLED | (share_irq == TRUE ? IRQF_SHARED : 0),
                             "advansys", boardp)) != 0) &&
                 ((ret = request_irq(shp->irq, advansys_interrupt,
-                            (share_irq == TRUE ? SA_SHIRQ : 0),
+                            (share_irq == TRUE ? IRQF_SHARED : 0),
                             "advansys", boardp)) != 0))
             {
                 if (ret == -EBUSY) {
Index: linux-2.6.git/drivers/scsi/aha152x.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/aha152x.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/aha152x.c	2006-07-01 16:51:47.000000000 +0200
@@ -855,7 +855,7 @@ struct Scsi_Host *aha152x_probe_one(stru
 	SETPORT(SIMODE0, 0);
 	SETPORT(SIMODE1, 0);
 
-	if( request_irq(shpnt->irq, swintr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shpnt) ) {
+	if( request_irq(shpnt->irq, swintr, IRQF_DISABLED|IRQF_SHARED, "aha152x", shpnt) ) {
 		printk(KERN_ERR "aha152x%d: irq %d busy.\n", shpnt->host_no, shpnt->irq);
 		goto out_host_put;
 	}
@@ -889,7 +889,7 @@ struct Scsi_Host *aha152x_probe_one(stru
 	SETPORT(SSTAT0, 0x7f);
 	SETPORT(SSTAT1, 0xef);
 
-	if ( request_irq(shpnt->irq, intr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shpnt) ) {
+	if ( request_irq(shpnt->irq, intr, IRQF_DISABLED|IRQF_SHARED, "aha152x", shpnt) ) {
 		printk(KERN_ERR "aha152x%d: failed to reassign irq %d.\n", shpnt->host_no, shpnt->irq);
 		goto out_host_put;
 	}
Index: linux-2.6.git/drivers/scsi/aha1740.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/aha1740.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/aha1740.c	2006-07-01 16:51:47.000000000 +0200
@@ -634,7 +634,7 @@ static int aha1740_probe (struct device 
 	}
 	
 	DEB(printk("aha1740_probe: enable interrupt channel %d\n",irq_level));
-	if (request_irq(irq_level,aha1740_intr_handle,irq_type ? 0 : SA_SHIRQ,
+	if (request_irq(irq_level,aha1740_intr_handle,irq_type ? 0 : IRQF_SHARED,
 			"aha1740",shpnt)) {
 		printk(KERN_ERR "aha1740_probe: Unable to allocate IRQ %d.\n",
 		       irq_level);
Index: linux-2.6.git/drivers/scsi/ahci.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/ahci.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/ahci.c	2006-07-01 16:51:47.000000000 +0200
@@ -1371,7 +1371,7 @@ static int ahci_init_one (struct pci_dev
 	probe_ent->port_ops	= ahci_port_info[board_idx].port_ops;
 
        	probe_ent->irq = pdev->irq;
-       	probe_ent->irq_flags = SA_SHIRQ;
+       	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->mmio_base = mmio_base;
 	probe_ent->private_data = hpriv;
 
Index: linux-2.6.git/drivers/scsi/aic7xxx_old.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/aic7xxx_old.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/aic7xxx_old.c	2006-07-01 16:51:47.000000000 +0200
@@ -8322,11 +8322,11 @@ aic7xxx_register(struct scsi_host_templa
   }
   else
   {
-    result = (request_irq(p->irq, do_aic7xxx_isr, SA_SHIRQ,
+    result = (request_irq(p->irq, do_aic7xxx_isr, IRQF_SHARED,
               "aic7xxx", p));
     if (result < 0)
     {
-      result = (request_irq(p->irq, do_aic7xxx_isr, SA_INTERRUPT | SA_SHIRQ,
+      result = (request_irq(p->irq, do_aic7xxx_isr, IRQF_DISABLED | IRQF_SHARED,
               "aic7xxx", p));
     }
   }
Index: linux-2.6.git/drivers/scsi/atp870u.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/atp870u.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/atp870u.c	2006-07-01 16:51:47.000000000 +0200
@@ -2751,7 +2751,7 @@ flash_ok_880:
 			goto unregister;
 		}
 
-		if (request_irq(pdev->irq, atp870u_intr_handle, SA_SHIRQ, "atp880i", shpnt)) {
+		if (request_irq(pdev->irq, atp870u_intr_handle, IRQF_SHARED, "atp880i", shpnt)) {
  			printk(KERN_ERR "Unable to allocate IRQ%d for Acard controller.\n", pdev->irq);
 			goto free_tables;
 		}
@@ -2822,7 +2822,7 @@ flash_ok_880:
 #ifdef ED_DBGP		
 	printk("request_irq() shpnt %p hostdata %p\n", shpnt, p);
 #endif	        
-		if (request_irq(pdev->irq, atp870u_intr_handle, SA_SHIRQ, "atp870u", shpnt)) {
+		if (request_irq(pdev->irq, atp870u_intr_handle, IRQF_SHARED, "atp870u", shpnt)) {
 				printk(KERN_ERR "Unable to allocate IRQ for Acard controller.\n");
 			goto free_tables;
 		}
@@ -3004,7 +3004,7 @@ flash_ok_885:
 		if (atp870u_init_tables(shpnt) < 0)
 			goto unregister;
 
-		if (request_irq(pdev->irq, atp870u_intr_handle, SA_SHIRQ, "atp870i", shpnt)) {
+		if (request_irq(pdev->irq, atp870u_intr_handle, IRQF_SHARED, "atp870i", shpnt)) {
 			printk(KERN_ERR "Unable to allocate IRQ%d for Acard controller.\n", pdev->irq);
 			goto free_tables;
 		}
Index: linux-2.6.git/drivers/scsi/blz1230.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/blz1230.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/blz1230.c	2006-07-01 16:51:47.000000000 +0200
@@ -172,7 +172,7 @@ int __init blz1230_esp_detect(struct scs
 
 		esp->irq = IRQ_AMIGA_PORTS;
 		esp->slot = board+REAL_BLZ1230_ESP_ADDR;
-		if (request_irq(IRQ_AMIGA_PORTS, esp_intr, SA_SHIRQ,
+		if (request_irq(IRQ_AMIGA_PORTS, esp_intr, IRQF_SHARED,
 				 "Blizzard 1230 SCSI IV", esp->ehost))
 			goto err_out;
 
Index: linux-2.6.git/drivers/scsi/blz2060.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/blz2060.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/blz2060.c	2006-07-01 16:51:47.000000000 +0200
@@ -146,7 +146,7 @@ int __init blz2060_esp_detect(struct scs
 		esp->esp_command_dvma = virt_to_bus((void *)cmd_buffer);
 
 		esp->irq = IRQ_AMIGA_PORTS;
-		request_irq(IRQ_AMIGA_PORTS, esp_intr, SA_SHIRQ,
+		request_irq(IRQ_AMIGA_PORTS, esp_intr, IRQF_SHARED,
 			    "Blizzard 2060 SCSI", esp->ehost);
 
 		/* Figure out our scsi ID on the bus */
Index: linux-2.6.git/drivers/scsi/BusLogic.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/BusLogic.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/BusLogic.c	2006-07-01 16:51:47.000000000 +0200
@@ -1844,7 +1844,7 @@ static boolean __init BusLogic_AcquireRe
 	/*
 	   Acquire shared access to the IRQ Channel.
 	 */
-	if (request_irq(HostAdapter->IRQ_Channel, BusLogic_InterruptHandler, SA_SHIRQ, HostAdapter->FullModelName, HostAdapter) < 0) {
+	if (request_irq(HostAdapter->IRQ_Channel, BusLogic_InterruptHandler, IRQF_SHARED, HostAdapter->FullModelName, HostAdapter) < 0) {
 		BusLogic_Error("UNABLE TO ACQUIRE IRQ CHANNEL %d - DETACHING\n", HostAdapter, HostAdapter->IRQ_Channel);
 		return false;
 	}
Index: linux-2.6.git/drivers/scsi/cyberstorm.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/cyberstorm.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/cyberstorm.c	2006-07-01 16:51:47.000000000 +0200
@@ -172,7 +172,7 @@ int __init cyber_esp_detect(struct scsi_
 		esp->esp_command_dvma = virt_to_bus((void *)cmd_buffer);
 
 		esp->irq = IRQ_AMIGA_PORTS;
-		request_irq(IRQ_AMIGA_PORTS, esp_intr, SA_SHIRQ,
+		request_irq(IRQ_AMIGA_PORTS, esp_intr, IRQF_SHARED,
 			    "CyberStorm SCSI", esp->ehost);
 		/* Figure out our scsi ID on the bus */
 		/* The DMA cond flag contains a hardcoded jumper bit
Index: linux-2.6.git/drivers/scsi/cyberstormII.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/cyberstormII.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/cyberstormII.c	2006-07-01 16:51:47.000000000 +0200
@@ -153,7 +153,7 @@ int __init cyberII_esp_detect(struct scs
 		esp->esp_command_dvma = virt_to_bus((void *)cmd_buffer);
 
 		esp->irq = IRQ_AMIGA_PORTS;
-		request_irq(IRQ_AMIGA_PORTS, esp_intr, SA_SHIRQ,
+		request_irq(IRQ_AMIGA_PORTS, esp_intr, IRQF_SHARED,
 			    "CyberStorm SCSI Mk II", esp->ehost);
 
 		/* Figure out our scsi ID on the bus */
Index: linux-2.6.git/drivers/scsi/dc395x.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/dc395x.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/dc395x.c	2006-07-01 16:51:47.000000000 +0200
@@ -4562,7 +4562,7 @@ static int __devinit adapter_init(struct
 	acb->io_port_base = io_port;
 	acb->io_port_len = io_port_len;
 	
-	if (request_irq(irq, dc395x_interrupt, SA_SHIRQ, DC395X_NAME, acb)) {
+	if (request_irq(irq, dc395x_interrupt, IRQF_SHARED, DC395X_NAME, acb)) {
 	    	/* release the region we just claimed */
 		dprintkl(KERN_INFO, "Failed to register IRQ\n");
 		goto failed;
Index: linux-2.6.git/drivers/scsi/dec_esp.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/dec_esp.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/dec_esp.c	2006-07-01 16:51:47.000000000 +0200
@@ -202,19 +202,19 @@ static int dec_esp_detect(struct scsi_ho
 
 		esp_initialize(esp);
 
-		if (request_irq(esp->irq, esp_intr, SA_INTERRUPT,
+		if (request_irq(esp->irq, esp_intr, IRQF_DISABLED,
 				"ncr53c94", esp->ehost))
 			goto err_dealloc;
 		if (request_irq(dec_interrupt[DEC_IRQ_ASC_MERR],
-				scsi_dma_merr_int, SA_INTERRUPT,
+				scsi_dma_merr_int, IRQF_DISABLED,
 				"ncr53c94 error", esp->ehost))
 			goto err_free_irq;
 		if (request_irq(dec_interrupt[DEC_IRQ_ASC_ERR],
-				scsi_dma_err_int, SA_INTERRUPT,
+				scsi_dma_err_int, IRQF_DISABLED,
 				"ncr53c94 overrun", esp->ehost))
 			goto err_free_irq_merr;
 		if (request_irq(dec_interrupt[DEC_IRQ_ASC_DMA],
-				scsi_dma_int, SA_INTERRUPT,
+				scsi_dma_int, IRQF_DISABLED,
 				"ncr53c94 dma", esp->ehost))
 			goto err_free_irq_err;
 
@@ -276,7 +276,7 @@ static int dec_esp_detect(struct scsi_ho
 			esp->dma_mmu_release_scsi_sgl = 0;
 			esp->dma_advance_sg = 0;
 
- 			if (request_irq(esp->irq, esp_intr, SA_INTERRUPT,
+ 			if (request_irq(esp->irq, esp_intr, IRQF_DISABLED,
  					 "PMAZ_AA", esp->ehost)) {
  				esp_deallocate(esp);
  				release_tc_card(slot);
Index: linux-2.6.git/drivers/scsi/dmx3191d.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/dmx3191d.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/dmx3191d.c	2006-07-01 16:51:47.000000000 +0200
@@ -94,7 +94,7 @@ static int __devinit dmx3191d_probe_one(
 
 	NCR5380_init(shost, FLAG_NO_PSEUDO_DMA | FLAG_DTC3181E);
 
-	if (request_irq(pdev->irq, NCR5380_intr, SA_SHIRQ,
+	if (request_irq(pdev->irq, NCR5380_intr, IRQF_SHARED,
 				DMX3191D_DRIVER_NAME, shost)) {
 		/*
 		 * Steam powered scsi controllers run without an IRQ anyway
Index: linux-2.6.git/drivers/scsi/dpt_i2o.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/dpt_i2o.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/dpt_i2o.c	2006-07-01 16:51:47.000000000 +0200
@@ -1009,7 +1009,7 @@ static int adpt_install_hba(struct scsi_
 		printk(KERN_INFO"     BAR1 %p - size= %x\n",msg_addr_virt,hba_map1_area_size);
 	}
 
-	if (request_irq (pDev->irq, adpt_isr, SA_SHIRQ, pHba->name, pHba)) {
+	if (request_irq (pDev->irq, adpt_isr, IRQF_SHARED, pHba->name, pHba)) {
 		printk(KERN_ERR"%s: Couldn't register IRQ %d\n", pHba->name, pDev->irq);
 		adpt_i2o_delete_hba(pHba);
 		return -EINVAL;
Index: linux-2.6.git/drivers/scsi/dtc.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/dtc.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/dtc.c	2006-07-01 16:51:47.000000000 +0200
@@ -280,7 +280,7 @@ found:
 		/* With interrupts enabled, it will sometimes hang when doing heavy
 		 * reads. So better not enable them until I finger it out. */
 		if (instance->irq != SCSI_IRQ_NONE)
-			if (request_irq(instance->irq, dtc_intr, SA_INTERRUPT, "dtc", instance)) {
+			if (request_irq(instance->irq, dtc_intr, IRQF_DISABLED, "dtc", instance)) {
 				printk(KERN_ERR "scsi%d : IRQ%d not free, interrupts disabled\n", instance->host_no, instance->irq);
 				instance->irq = SCSI_IRQ_NONE;
 			}
Index: linux-2.6.git/drivers/scsi/eata.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/eata.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/eata.c	2006-07-01 16:51:47.000000000 +0200
@@ -1221,7 +1221,7 @@ static int port_detect(unsigned long por
 
 	/* Board detected, allocate its IRQ */
 	if (request_irq(irq, do_interrupt_handler,
-			SA_INTERRUPT | ((subversion == ESA) ? SA_SHIRQ : 0),
+			IRQF_DISABLED | ((subversion == ESA) ? IRQF_SHARED : 0),
 			driver_name, (void *)&sha[j])) {
 		printk("%s: unable to allocate IRQ %u, detaching.\n", name,
 		       irq);
Index: linux-2.6.git/drivers/scsi/eata_pio.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/eata_pio.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/eata_pio.c	2006-07-01 16:51:47.000000000 +0200
@@ -731,7 +731,7 @@ static int register_pio_HBA(long base, s
 		return 0;
 
 	if (!reg_IRQ[gc->IRQ]) {	/* Interrupt already registered ? */
-		if (!request_irq(gc->IRQ, do_eata_pio_int_handler, SA_INTERRUPT, "EATA-PIO", sh)) {
+		if (!request_irq(gc->IRQ, do_eata_pio_int_handler, IRQF_DISABLED, "EATA-PIO", sh)) {
 			reg_IRQ[gc->IRQ]++;
 			if (!gc->IRQ_TR)
 				reg_IRQL[gc->IRQ] = 1;	/* IRQ is edge triggered */
@@ -965,7 +965,7 @@ static int eata_pio_detect(struct scsi_h
 
 	for (i = 0; i <= MAXIRQ; i++)
 		if (reg_IRQ[i])
-			request_irq(i, do_eata_pio_int_handler, SA_INTERRUPT, "EATA-PIO", NULL);
+			request_irq(i, do_eata_pio_int_handler, IRQF_DISABLED, "EATA-PIO", NULL);
 
 	HBA_ptr = first_HBA;
 
Index: linux-2.6.git/drivers/scsi/esp.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/esp.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/esp.c	2006-07-01 16:51:47.000000000 +0200
@@ -778,7 +778,7 @@ static int __init esp_register_irq(struc
 	 * sanely maintain.
 	 */
 	if (request_irq(esp->ehost->irq, esp_intr,
-			SA_SHIRQ, "ESP SCSI", esp)) {
+			IRQF_SHARED, "ESP SCSI", esp)) {
 		printk("esp%d: Cannot acquire irq line\n",
 		       esp->esp_id);
 		return -1;
Index: linux-2.6.git/drivers/scsi/fastlane.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/fastlane.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/fastlane.c	2006-07-01 16:51:47.000000000 +0200
@@ -210,7 +210,7 @@ int __init fastlane_esp_detect(struct sc
 
 		esp->irq = IRQ_AMIGA_PORTS;
 		esp->slot = board+FASTLANE_ESP_ADDR;
-		if (request_irq(IRQ_AMIGA_PORTS, esp_intr, SA_SHIRQ,
+		if (request_irq(IRQ_AMIGA_PORTS, esp_intr, IRQF_SHARED,
 				"Fastlane SCSI", esp->ehost)) {
 			printk(KERN_WARNING "Fastlane: Could not get IRQ%d, aborting.\n", IRQ_AMIGA_PORTS);
 			goto err_unmap;
Index: linux-2.6.git/drivers/scsi/fd_mcs.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/fd_mcs.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/fd_mcs.c	2006-07-01 16:51:47.000000000 +0200
@@ -400,7 +400,7 @@ static int fd_mcs_detect(struct scsi_hos
 				mca_set_adapter_name(slot - 1, fd_mcs_adapters[loop].name);
 
 				/* check irq/region */
-				if (request_irq(irq, fd_mcs_intr, SA_SHIRQ, "fd_mcs", hosts)) {
+				if (request_irq(irq, fd_mcs_intr, IRQF_SHARED, "fd_mcs", hosts)) {
 					printk(KERN_ERR "fd_mcs: interrupt is not available, skipping...\n");
 					continue;
 				}
Index: linux-2.6.git/drivers/scsi/fdomain.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/fdomain.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/fdomain.c	2006-07-01 16:51:47.000000000 +0200
@@ -949,7 +949,7 @@ struct Scsi_Host *__fdomain_16x0_detect(
       /* Register the IRQ with the kernel */
 
       retcode = request_irq( interrupt_level,
-			     do_fdomain_16x0_intr, pdev?SA_SHIRQ:0, "fdomain", shpnt);
+			     do_fdomain_16x0_intr, pdev?IRQF_SHARED:0, "fdomain", shpnt);
 
       if (retcode < 0) {
 	 if (retcode == -EINVAL) {
Index: linux-2.6.git/drivers/scsi/gdth.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/gdth.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/gdth.c	2006-07-01 16:51:47.000000000 +0200
@@ -4350,7 +4350,7 @@ static int __init gdth_detect(Scsi_Host_
                 printk("Configuring GDT-ISA HA at BIOS 0x%05X IRQ %u DRQ %u\n",
                        isa_bios,ha->irq,ha->drq);
 
-                if (request_irq(ha->irq,gdth_interrupt,SA_INTERRUPT,"gdth",ha)) {
+                if (request_irq(ha->irq,gdth_interrupt,IRQF_DISABLED,"gdth",ha)) {
                     printk("GDT-ISA: Unable to allocate IRQ\n");
                     scsi_unregister(shp);
                     continue;
@@ -4476,7 +4476,7 @@ static int __init gdth_detect(Scsi_Host_
                 printk("Configuring GDT-EISA HA at Slot %d IRQ %u\n",
                        eisa_slot>>12,ha->irq);
 
-                if (request_irq(ha->irq,gdth_interrupt,SA_INTERRUPT,"gdth",ha)) {
+                if (request_irq(ha->irq,gdth_interrupt,IRQF_DISABLED,"gdth",ha)) {
                     printk("GDT-EISA: Unable to allocate IRQ\n");
                     scsi_unregister(shp);
                     continue;
@@ -4603,7 +4603,7 @@ static int __init gdth_detect(Scsi_Host_
                pcistr[ctr].bus,PCI_SLOT(pcistr[ctr].device_fn),ha->irq);
 
         if (request_irq(ha->irq, gdth_interrupt,
-                        SA_INTERRUPT|SA_SHIRQ, "gdth", ha))
+                        IRQF_DISABLED|IRQF_SHARED, "gdth", ha))
         {
             printk("GDT-PCI: Unable to allocate IRQ\n");
             scsi_unregister(shp);
Index: linux-2.6.git/drivers/scsi/g_NCR5380.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/g_NCR5380.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/g_NCR5380.c	2006-07-01 16:51:47.000000000 +0200
@@ -461,7 +461,7 @@ int __init generic_NCR5380_detect(struct
 			instance->irq = NCR5380_probe_irq(instance, 0xffff);
 
 		if (instance->irq != SCSI_IRQ_NONE)
-			if (request_irq(instance->irq, generic_NCR5380_intr, SA_INTERRUPT, "NCR5380", instance)) {
+			if (request_irq(instance->irq, generic_NCR5380_intr, IRQF_DISABLED, "NCR5380", instance)) {
 				printk(KERN_WARNING "scsi%d : IRQ%d not free, interrupts disabled\n", instance->host_no, instance->irq);
 				instance->irq = SCSI_IRQ_NONE;
 			}
Index: linux-2.6.git/drivers/scsi/gvp11.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/gvp11.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/gvp11.c	2006-07-01 16:51:47.000000000 +0200
@@ -328,7 +328,7 @@ int __init gvp11_detect(struct scsi_host
 		     (epc & GVP_SCSICLKMASK) ? WD33C93_FS_8_10
 					     : WD33C93_FS_12_15);
 
-	request_irq(IRQ_AMIGA_PORTS, gvp11_intr, SA_SHIRQ, "GVP11 SCSI",
+	request_irq(IRQ_AMIGA_PORTS, gvp11_intr, IRQF_SHARED, "GVP11 SCSI",
 		    instance);
 	DMA(instance)->CNTR = GVP11_DMAC_INT_ENABLE;
 	num_gvp11++;
Index: linux-2.6.git/drivers/scsi/hptiop.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/hptiop.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/hptiop.c	2006-07-01 16:51:47.000000000 +0200
@@ -1304,7 +1304,7 @@ static int __devinit hptiop_probe(struct
 
 	pci_set_drvdata(pcidev, host);
 
-	if (request_irq(pcidev->irq, hptiop_intr, SA_SHIRQ,
+	if (request_irq(pcidev->irq, hptiop_intr, IRQF_SHARED,
 					driver_name, hba)) {
 		printk(KERN_ERR "scsi%d: request irq %d failed\n",
 					hba->host->host_no, pcidev->irq);
Index: linux-2.6.git/drivers/scsi/ibmmca.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/ibmmca.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/ibmmca.c	2006-07-01 16:51:47.000000000 +0200
@@ -1510,7 +1510,7 @@ int ibmmca_detect(struct scsi_host_templ
 #endif
 
 	/* get interrupt request level */
-	if (request_irq(IM_IRQ, interrupt_handler, SA_SHIRQ, "ibmmcascsi", hosts)) {
+	if (request_irq(IM_IRQ, interrupt_handler, IRQF_SHARED, "ibmmcascsi", hosts)) {
 		printk(KERN_ERR "IBM MCA SCSI: Unable to get shared IRQ %d.\n", IM_IRQ);
 		return 0;
 	} else
@@ -1635,7 +1635,7 @@ int ibmmca_detect(struct scsi_host_templ
 				/* IRQ11 is used by SCSI-2 F/W Adapter/A */
 				printk(KERN_DEBUG "IBM MCA SCSI: SCSI-2 F/W adapter needs IRQ 11.\n");
 				/* get interrupt request level */
-				if (request_irq(IM_IRQ_FW, interrupt_handler, SA_SHIRQ, "ibmmcascsi", hosts)) {
+				if (request_irq(IM_IRQ_FW, interrupt_handler, IRQF_SHARED, "ibmmcascsi", hosts)) {
 					printk(KERN_ERR "IBM MCA SCSI: Unable to get shared IRQ %d.\n", IM_IRQ_FW);
 				} else
 					IRQ11_registered++;
@@ -1696,7 +1696,7 @@ int ibmmca_detect(struct scsi_host_templ
 				/* IRQ11 is used by SCSI-2 F/W Adapter/A */
 				printk(KERN_DEBUG  "IBM MCA SCSI: SCSI-2 F/W adapter needs IRQ 11.\n");
 				/* get interrupt request level */
-				if (request_irq(IM_IRQ_FW, interrupt_handler, SA_SHIRQ, "ibmmcascsi", hosts))
+				if (request_irq(IM_IRQ_FW, interrupt_handler, IRQF_SHARED, "ibmmcascsi", hosts))
 					printk(KERN_ERR "IBM MCA SCSI: Unable to get shared IRQ %d.\n", IM_IRQ_FW);
 				else
 					IRQ11_registered++;
Index: linux-2.6.git/drivers/scsi/in2000.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/in2000.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/in2000.c	2006-07-01 16:51:47.000000000 +0200
@@ -2015,7 +2015,7 @@ static int __init in2000_detect(struct s
 		write1_io(0, IO_FIFO_READ);	/* start fifo out in read mode */
 		write1_io(0, IO_INTR_MASK);	/* allow all ints */
 		x = int_tab[(switches & (SW_INT0 | SW_INT1)) >> SW_INT_SHIFT];
-		if (request_irq(x, in2000_intr, SA_INTERRUPT, "in2000", instance)) {
+		if (request_irq(x, in2000_intr, IRQF_DISABLED, "in2000", instance)) {
 			printk("in2000_detect: Unable to allocate IRQ.\n");
 			detect_count--;
 			continue;
Index: linux-2.6.git/drivers/scsi/initio.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/initio.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/initio.c	2006-07-01 16:51:47.000000000 +0200
@@ -2867,7 +2867,7 @@ static int i91u_detect(struct scsi_host_
 		hreg->sg_tablesize = TOTAL_SG_ENTRY;	/* Maximun support is 32 */
 
 		/* Initial tulip chip           */
-		ok = request_irq(pHCB->HCS_Intr, i91u_intr, SA_INTERRUPT | SA_SHIRQ, "i91u", hreg);
+		ok = request_irq(pHCB->HCS_Intr, i91u_intr, IRQF_DISABLED | IRQF_SHARED, "i91u", hreg);
 		if (ok < 0) {
 			printk(KERN_WARNING "i91u: unable to request IRQ %d\n\n", pHCB->HCS_Intr);
 			return 0;
Index: linux-2.6.git/drivers/scsi/ipr.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/ipr.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/ipr.c	2006-07-01 16:51:47.000000000 +0200
@@ -6428,7 +6428,7 @@ static int __devinit ipr_probe_ioa(struc
 		ioa_cfg->needs_hard_reset = 1;
 
 	ipr_mask_and_clear_interrupts(ioa_cfg, ~IPR_PCII_IOA_TRANS_TO_OPER);
-	rc = request_irq(pdev->irq, ipr_isr, SA_SHIRQ, IPR_NAME, ioa_cfg);
+	rc = request_irq(pdev->irq, ipr_isr, IRQF_SHARED, IPR_NAME, ioa_cfg);
 
 	if (rc) {
 		dev_err(&pdev->dev, "Couldn't register IRQ %d! rc=%d\n",
Index: linux-2.6.git/drivers/scsi/ips.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/ips.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/ips.c	2006-07-01 16:51:47.000000000 +0200
@@ -7007,7 +7007,7 @@ ips_register_scsi(int index)
 	memcpy(ha, oldha, sizeof (ips_ha_t));
 	free_irq(oldha->irq, oldha);
 	/* Install the interrupt handler with the new ha */
-	if (request_irq(ha->irq, do_ipsintr, SA_SHIRQ, ips_name, ha)) {
+	if (request_irq(ha->irq, do_ipsintr, IRQF_SHARED, ips_name, ha)) {
 		IPS_PRINTK(KERN_WARNING, ha->pcidev,
 			   "Unable to install interrupt handler\n");
 		scsi_host_put(sh);
@@ -7419,7 +7419,7 @@ ips_init_phase2(int index)
 	}
 
 	/* Install the interrupt handler */
-	if (request_irq(ha->irq, do_ipsintr, SA_SHIRQ, ips_name, ha)) {
+	if (request_irq(ha->irq, do_ipsintr, IRQF_SHARED, ips_name, ha)) {
 		IPS_PRINTK(KERN_WARNING, ha->pcidev,
 			   "Unable to install interrupt handler\n");
 		return ips_abort_init(ha, index);
Index: linux-2.6.git/drivers/scsi/jazz_esp.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/jazz_esp.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/jazz_esp.c	2006-07-01 16:51:47.000000000 +0200
@@ -131,7 +131,7 @@ static int jazz_esp_detect(struct scsi_h
 	esp->esp_command_dvma = vdma_alloc(CPHYSADDR(cmd_buffer), sizeof (cmd_buffer));
 	
 	esp->irq = JAZZ_SCSI_IRQ;
-	request_irq(JAZZ_SCSI_IRQ, esp_intr, SA_INTERRUPT, "JAZZ SCSI",
+	request_irq(JAZZ_SCSI_IRQ, esp_intr, IRQF_DISABLED, "JAZZ SCSI",
 	            esp->ehost);
 
 	/*
Index: linux-2.6.git/drivers/scsi/lasi700.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/lasi700.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/lasi700.c	2006-07-01 16:51:47.000000000 +0200
@@ -131,7 +131,7 @@ lasi700_probe(struct parisc_device *dev)
 	host->this_id = 7;
 	host->base = base;
 	host->irq = dev->irq;
-	if(request_irq(dev->irq, NCR_700_intr, SA_SHIRQ, "lasi700", host)) {
+	if(request_irq(dev->irq, NCR_700_intr, IRQF_SHARED, "lasi700", host)) {
 		printk(KERN_ERR "lasi700: request_irq failed!\n");
 		goto out_put_host;
 	}
Index: linux-2.6.git/drivers/scsi/libata-bmdma.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/libata-bmdma.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/libata-bmdma.c	2006-07-01 16:51:47.000000000 +0200
@@ -853,7 +853,7 @@ ata_pci_init_native_mode(struct pci_dev 
 		return NULL;
 
 	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->private_data = port[0]->private_data;
 
 	if (ports & ATA_PORT_PRIMARY) {
Index: linux-2.6.git/drivers/scsi/megaraid.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/megaraid.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/megaraid.c	2006-07-01 16:51:47.000000000 +0200
@@ -4714,7 +4714,7 @@ megaraid_probe_one(struct pci_dev *pdev,
 
 	if (request_irq(irq, (adapter->flag & BOARD_MEMMAP) ?
 				megaraid_isr_memmapped : megaraid_isr_iomapped,
-					SA_SHIRQ, "megaraid", adapter)) {
+					IRQF_SHARED, "megaraid", adapter)) {
 		printk(KERN_WARNING
 			"megaraid: Couldn't register IRQ %d!\n", irq);
 		goto out_free_scb_list;
Index: linux-2.6.git/drivers/scsi/NCR5380.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/NCR5380.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/NCR5380.c	2006-07-01 16:51:47.000000000 +0200
@@ -585,7 +585,7 @@ static int __init NCR5380_probe_irq(stru
 	NCR5380_setup(instance);
 
 	for (trying_irqs = i = 0, mask = 1; i < 16; ++i, mask <<= 1)
-		if ((mask & possible) && (request_irq(i, &probe_intr, SA_INTERRUPT, "NCR-probe", NULL) == 0))
+		if ((mask & possible) && (request_irq(i, &probe_intr, IRQF_DISABLED, "NCR-probe", NULL) == 0))
 			trying_irqs |= mask;
 
 	timeout = jiffies + (250 * HZ / 1000);
Index: linux-2.6.git/drivers/scsi/NCR_D700.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/NCR_D700.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/NCR_D700.c	2006-07-01 16:51:47.000000000 +0200
@@ -320,7 +320,7 @@ NCR_D700_probe(struct device *dev)
 	memset(p, '\0', sizeof(*p));
 	p->dev = dev;
 	snprintf(p->name, sizeof(p->name), "D700(%s)", dev->bus_id);
-	if (request_irq(irq, NCR_D700_intr, SA_SHIRQ, p->name, p)) {
+	if (request_irq(irq, NCR_D700_intr, IRQF_SHARED, p->name, p)) {
 		printk(KERN_ERR "D700: request_irq failed\n");
 		kfree(p);
 		return -EBUSY;
Index: linux-2.6.git/drivers/scsi/NCR_Q720.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/NCR_Q720.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/NCR_Q720.c	2006-07-01 16:51:47.000000000 +0200
@@ -265,7 +265,7 @@ NCR_Q720_probe(struct device *dev)
 	p->irq = irq;
 	p->siops = siops;
 
-	if (request_irq(irq, NCR_Q720_intr, SA_SHIRQ, "NCR_Q720", p)) {
+	if (request_irq(irq, NCR_Q720_intr, IRQF_SHARED, "NCR_Q720", p)) {
 		printk(KERN_ERR "NCR_Q720: request irq %d failed\n", irq);
 		goto out_release;
 	}
Index: linux-2.6.git/drivers/scsi/nsp32.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/nsp32.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/nsp32.c	2006-07-01 16:51:47.000000000 +0200
@@ -2867,7 +2867,7 @@ static int nsp32_detect(struct scsi_host
 	nsp32_do_bus_reset(data);
 
 	ret = request_irq(host->irq, do_nsp32_isr,
-			  SA_SHIRQ | SA_SAMPLE_RANDOM, "nsp32", data);
+			  IRQF_SHARED | IRQF_SAMPLE_RANDOM, "nsp32", data);
 	if (ret < 0) {
 		nsp32_msg(KERN_ERR, "Unable to allocate IRQ for NinjaSCSI32 "
 			  "SCSI PCI controller. Interrupt: %d", host->irq);
Index: linux-2.6.git/drivers/scsi/oktagon_esp.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/oktagon_esp.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/oktagon_esp.c	2006-07-01 16:51:47.000000000 +0200
@@ -197,7 +197,7 @@ int oktagon_esp_detect(struct scsi_host_
 		esp->esp_command_dvma = (__u32) cmd_buffer;
 
 		esp->irq = IRQ_AMIGA_PORTS;
-		request_irq(IRQ_AMIGA_PORTS, esp_intr, SA_SHIRQ,
+		request_irq(IRQ_AMIGA_PORTS, esp_intr, IRQF_SHARED,
 			    "BSC Oktagon SCSI", esp->ehost);
 
 		/* Figure out our scsi ID on the bus */
Index: linux-2.6.git/drivers/scsi/pas16.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/pas16.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/pas16.c	2006-07-01 16:51:47.000000000 +0200
@@ -454,7 +454,7 @@ int __init pas16_detect(struct scsi_host
 	    instance->irq = NCR5380_probe_irq(instance, PAS16_IRQS);
 
 	if (instance->irq != SCSI_IRQ_NONE) 
-	    if (request_irq(instance->irq, pas16_intr, SA_INTERRUPT, "pas16", instance)) {
+	    if (request_irq(instance->irq, pas16_intr, IRQF_DISABLED, "pas16", instance)) {
 		printk("scsi%d : IRQ%d not free, interrupts disabled\n", 
 		    instance->host_no, instance->irq);
 		instance->irq = SCSI_IRQ_NONE;
Index: linux-2.6.git/drivers/scsi/pdc_adma.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/pdc_adma.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/pdc_adma.c	2006-07-01 16:51:47.000000000 +0200
@@ -690,7 +690,7 @@ static int adma_ata_init_one(struct pci_
 	probe_ent->port_ops	= adma_port_info[board_idx].port_ops;
 
 	probe_ent->irq		= pdev->irq;
-	probe_ent->irq_flags	= SA_SHIRQ;
+	probe_ent->irq_flags	= IRQF_SHARED;
 	probe_ent->mmio_base	= mmio_base;
 	probe_ent->n_ports	= ADMA_PORTS;
 
Index: linux-2.6.git/drivers/scsi/qla1280.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/qla1280.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/qla1280.c	2006-07-01 16:51:47.000000000 +0200
@@ -192,7 +192,7 @@
         - Don't walk the entire list in qla1280_putq_t() just to directly
 	  grab the pointer to the last element afterwards
     Rev  3.23.5 Beta August 9, 2001, Jes Sorensen
-	- Don't use SA_INTERRUPT, it's use is deprecated for this kinda driver
+	- Don't use IRQF_DISABLED, it's use is deprecated for this kinda driver
     Rev  3.23.4 Beta August 8, 2001, Jes Sorensen
 	- Set dev->max_sectors to 1024
     Rev  3.23.3 Beta August 6, 2001, Jes Sorensen
@@ -4369,7 +4369,7 @@ qla1280_probe_one(struct pci_dev *pdev, 
 	/* Disable ISP interrupts. */
 	qla1280_disable_intrs(ha);
 
-	if (request_irq(pdev->irq, qla1280_intr_handler, SA_SHIRQ,
+	if (request_irq(pdev->irq, qla1280_intr_handler, IRQF_SHARED,
 				"qla1280", ha)) {
 		printk("qla1280 : Failed to reserve interrupt %d already "
 		       "in use\n", pdev->irq);
Index: linux-2.6.git/drivers/scsi/qlogicpti.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/qlogicpti.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/qlogicpti.c	2006-07-01 16:51:47.000000000 +0200
@@ -718,7 +718,7 @@ static int __init qpti_register_irq(stru
 	 * sanely maintain.
 	 */
 	if (request_irq(qpti->irq, qpti_intr,
-			SA_SHIRQ, "Qlogic/PTI", qpti))
+			IRQF_SHARED, "Qlogic/PTI", qpti))
 		goto fail;
 
 	printk("qpti%d: IRQ %d ", qpti->qpti_id, qpti->irq);
Index: linux-2.6.git/drivers/scsi/sata_mv.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sata_mv.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sata_mv.c	2006-07-01 16:51:47.000000000 +0200
@@ -2395,7 +2395,7 @@ static int mv_init_one(struct pci_dev *p
 	probe_ent->port_ops = mv_port_info[board_idx].port_ops;
 
 	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->mmio_base = mmio_base;
 	probe_ent->private_data = hpriv;
 
Index: linux-2.6.git/drivers/scsi/sata_promise.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sata_promise.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sata_promise.c	2006-07-01 16:51:47.000000000 +0200
@@ -743,7 +743,7 @@ static int pdc_ata_init_one (struct pci_
 	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
 
        	probe_ent->irq = pdev->irq;
-       	probe_ent->irq_flags = SA_SHIRQ;
+       	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->mmio_base = mmio_base;
 
 	pdc_ata_setup_port(&probe_ent->port[0], base + 0x200);
Index: linux-2.6.git/drivers/scsi/sata_qstor.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sata_qstor.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sata_qstor.c	2006-07-01 16:51:47.000000000 +0200
@@ -680,7 +680,7 @@ static int qs_ata_init_one(struct pci_de
 	probe_ent->port_ops	= qs_port_info[board_idx].port_ops;
 
 	probe_ent->irq		= pdev->irq;
-	probe_ent->irq_flags	= SA_SHIRQ;
+	probe_ent->irq_flags	= IRQF_SHARED;
 	probe_ent->mmio_base	= mmio_base;
 	probe_ent->n_ports	= QS_PORTS;
 
Index: linux-2.6.git/drivers/scsi/sata_sil24.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sata_sil24.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sata_sil24.c	2006-07-01 16:51:47.000000000 +0200
@@ -1041,7 +1041,7 @@ static int sil24_init_one(struct pci_dev
 	probe_ent->n_ports	= SIL24_FLAG2NPORTS(pinfo->host_flags);
 
 	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->mmio_base = port_base;
 	probe_ent->private_data = hpriv;
 
Index: linux-2.6.git/drivers/scsi/sata_sil.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sata_sil.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sata_sil.c	2006-07-01 16:51:47.000000000 +0200
@@ -608,7 +608,7 @@ static int sil_init_one (struct pci_dev 
 	probe_ent->mwdma_mask = sil_port_info[ent->driver_data].mwdma_mask;
 	probe_ent->udma_mask = sil_port_info[ent->driver_data].udma_mask;
        	probe_ent->irq = pdev->irq;
-       	probe_ent->irq_flags = SA_SHIRQ;
+       	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->host_flags = sil_port_info[ent->driver_data].host_flags;
 
 	mmio_base = pci_iomap(pdev, 5, 0);
Index: linux-2.6.git/drivers/scsi/sata_svw.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sata_svw.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sata_svw.c	2006-07-01 16:51:47.000000000 +0200
@@ -428,7 +428,7 @@ static int k2_sata_init_one (struct pci_
 	probe_ent->port_ops = &k2_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->mmio_base = mmio_base;
 
 	/* We don't care much about the PIO/UDMA masks, but the core won't like us
Index: linux-2.6.git/drivers/scsi/sata_sx4.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sata_sx4.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sata_sx4.c	2006-07-01 16:51:47.000000000 +0200
@@ -1436,7 +1436,7 @@ static int pdc_sata_init_one (struct pci
 	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
 
        	probe_ent->irq = pdev->irq;
-       	probe_ent->irq_flags = SA_SHIRQ;
+       	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->mmio_base = mmio_base;
 
 	probe_ent->private_data = hpriv;
Index: linux-2.6.git/drivers/scsi/sata_via.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sata_via.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sata_via.c	2006-07-01 16:51:47.000000000 +0200
@@ -242,7 +242,7 @@ static struct ata_probe_ent *vt6421_init
 	probe_ent->port_ops	= &svia_sata_ops;
 	probe_ent->n_ports	= N_PORTS;
 	probe_ent->irq		= pdev->irq;
-	probe_ent->irq_flags	= SA_SHIRQ;
+	probe_ent->irq_flags	= IRQF_SHARED;
 	probe_ent->pio_mask	= 0x1f;
 	probe_ent->mwdma_mask	= 0x07;
 	probe_ent->udma_mask	= 0x7f;
Index: linux-2.6.git/drivers/scsi/sata_vsc.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sata_vsc.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sata_vsc.c	2006-07-01 16:51:47.000000000 +0200
@@ -400,7 +400,7 @@ static int __devinit vsc_sata_init_one (
 	probe_ent->port_ops = &vsc_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->mmio_base = mmio_base;
 
 	/* We don't care much about the PIO/UDMA masks, but the core won't like us
Index: linux-2.6.git/drivers/scsi/seagate.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/seagate.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/seagate.c	2006-07-01 16:51:47.000000000 +0200
@@ -497,7 +497,7 @@ int __init seagate_st0x_detect (struct s
 		return 0;
 
 	hostno = instance->host_no;
-	if (request_irq (irq, do_seagate_reconnect_intr, SA_INTERRUPT, (controller_type == SEAGATE) ? "seagate" : "tmc-8xx", instance)) {
+	if (request_irq (irq, do_seagate_reconnect_intr, IRQF_DISABLED, (controller_type == SEAGATE) ? "seagate" : "tmc-8xx", instance)) {
 		printk(KERN_ERR "scsi%d : unable to allocate IRQ%d\n", hostno, irq);
 		return 0;
 	}
Index: linux-2.6.git/drivers/scsi/sim710.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sim710.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sim710.c	2006-07-01 16:51:47.000000000 +0200
@@ -133,7 +133,7 @@ sim710_probe_common(struct device *dev, 
 	host->this_id = scsi_id;
 	host->base = base_addr;
 	host->irq = irq;
-	if (request_irq(irq, NCR_700_intr, SA_SHIRQ, "sim710", host)) {
+	if (request_irq(irq, NCR_700_intr, IRQF_SHARED, "sim710", host)) {
 		printk(KERN_ERR "sim710: request_irq failed\n");
 		goto out_put_host;
 	}
Index: linux-2.6.git/drivers/scsi/sun3x_esp.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sun3x_esp.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sun3x_esp.c	2006-07-01 16:51:47.000000000 +0200
@@ -97,7 +97,7 @@ int sun3x_esp_detect(struct scsi_host_te
 	esp->esp_command_dvma = dvma_vtob((unsigned long)esp->esp_command);
 
 	esp->irq = 2;
-	if (request_irq(esp->irq, esp_intr, SA_INTERRUPT, 
+	if (request_irq(esp->irq, esp_intr, IRQF_DISABLED, 
 			"SUN3X SCSI", esp->ehost)) {
 		esp_deallocate(esp);
 		return 0;
Index: linux-2.6.git/drivers/scsi/t128.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/t128.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/t128.c	2006-07-01 16:51:47.000000000 +0200
@@ -260,7 +260,7 @@ found:
 	    instance->irq = NCR5380_probe_irq(instance, T128_IRQS);
 
 	if (instance->irq != SCSI_IRQ_NONE) 
-	    if (request_irq(instance->irq, t128_intr, SA_INTERRUPT, "t128", instance)) {
+	    if (request_irq(instance->irq, t128_intr, IRQF_DISABLED, "t128", instance)) {
 		printk("scsi%d : IRQ%d not free, interrupts disabled\n", 
 		    instance->host_no, instance->irq);
 		instance->irq = SCSI_IRQ_NONE;
Index: linux-2.6.git/drivers/scsi/tmscsim.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/tmscsim.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/tmscsim.c	2006-07-01 16:51:47.000000000 +0200
@@ -2584,7 +2584,7 @@ static int __devinit dc390_probe_one(str
 	/* Reset Pending INT */
 	DC390_read8_(INT_Status, io_port);
 
-	if (request_irq(pdev->irq, do_DC390_Interrupt, SA_SHIRQ,
+	if (request_irq(pdev->irq, do_DC390_Interrupt, IRQF_SHARED,
 				"tmscsim", pACB)) {
 		printk(KERN_ERR "DC390: register IRQ error!\n");
 		goto out_release_region;
Index: linux-2.6.git/drivers/scsi/u14-34f.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/u14-34f.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/u14-34f.c	2006-07-01 16:51:47.000000000 +0200
@@ -872,7 +872,7 @@ static int port_detect \
 
    /* Board detected, allocate its IRQ */
    if (request_irq(irq, do_interrupt_handler,
-             SA_INTERRUPT | ((subversion == ESA) ? SA_SHIRQ : 0),
+             IRQF_DISABLED | ((subversion == ESA) ? IRQF_SHARED : 0),
              driver_name, (void *) &sha[j])) {
       printk("%s: unable to allocate IRQ %u, detaching.\n", name, irq);
       goto freelock;
Index: linux-2.6.git/drivers/scsi/wd7000.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/wd7000.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/wd7000.c	2006-07-01 16:51:47.000000000 +0200
@@ -1250,7 +1250,7 @@ static int wd7000_init(Adapter * host)
 		return 0;
 
 
-	if (request_irq(host->irq, wd7000_intr, SA_INTERRUPT, "wd7000", host)) {
+	if (request_irq(host->irq, wd7000_intr, IRQF_DISABLED, "wd7000", host)) {
 		printk("wd7000_init: can't get IRQ %d.\n", host->irq);
 		return (0);
 	}
Index: linux-2.6.git/drivers/scsi/zalon.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/zalon.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/zalon.c	2006-07-01 16:51:47.000000000 +0200
@@ -136,7 +136,7 @@ zalon_probe(struct parisc_device *dev)
 	if (!host)
 		goto fail;
 
-	if (request_irq(dev->irq, ncr53c8xx_intr, SA_SHIRQ, "zalon", host)) {
+	if (request_irq(dev->irq, ncr53c8xx_intr, IRQF_SHARED, "zalon", host)) {
 		printk(KERN_ERR "%s: irq problem with %d, detaching\n ",
 			dev->dev.bus_id, dev->irq);
 		goto fail;
Index: linux-2.6.git/drivers/scsi/aacraid/rkt.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/aacraid/rkt.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/aacraid/rkt.c	2006-07-01 16:51:47.000000000 +0200
@@ -453,7 +453,7 @@ int aac_rkt_init(struct aac_dev *dev)
 		}
 		msleep(1);
 	}
-	if (request_irq(dev->scsi_host_ptr->irq, aac_rkt_intr, SA_SHIRQ|SA_INTERRUPT, "aacraid", (void *)dev)<0) 
+	if (request_irq(dev->scsi_host_ptr->irq, aac_rkt_intr, IRQF_SHARED|IRQF_DISABLED, "aacraid", (void *)dev)<0) 
 	{
 		printk(KERN_ERR "%s%d: Interrupt unavailable.\n", name, instance);
 		goto error_iounmap;
Index: linux-2.6.git/drivers/scsi/aacraid/rx.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/aacraid/rx.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/aacraid/rx.c	2006-07-01 16:51:47.000000000 +0200
@@ -453,7 +453,7 @@ int aac_rx_init(struct aac_dev *dev)
 		}
 		msleep(1);
 	}
-	if (request_irq(dev->scsi_host_ptr->irq, aac_rx_intr, SA_SHIRQ|SA_INTERRUPT, "aacraid", (void *)dev)<0) 
+	if (request_irq(dev->scsi_host_ptr->irq, aac_rx_intr, IRQF_SHARED|IRQF_DISABLED, "aacraid", (void *)dev)<0) 
 	{
 		printk(KERN_ERR "%s%d: Interrupt unavailable.\n", name, instance);
 		goto error_iounmap;
Index: linux-2.6.git/drivers/scsi/aacraid/sa.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/aacraid/sa.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/aacraid/sa.c	2006-07-01 16:51:47.000000000 +0200
@@ -327,7 +327,7 @@ int aac_sa_init(struct aac_dev *dev)
 		msleep(1);
 	}
 
-	if (request_irq(dev->scsi_host_ptr->irq, aac_sa_intr, SA_SHIRQ|SA_INTERRUPT, "aacraid", (void *)dev ) < 0) {
+	if (request_irq(dev->scsi_host_ptr->irq, aac_sa_intr, IRQF_SHARED|IRQF_DISABLED, "aacraid", (void *)dev ) < 0) {
 		printk(KERN_WARNING "%s%d: Interrupt unavailable.\n", name, instance);
 		goto error_iounmap;
 	}
Index: linux-2.6.git/drivers/scsi/aic7xxx/aic7770_osm.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/aic7xxx/aic7770_osm.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/aic7xxx/aic7770_osm.c	2006-07-01 16:51:47.000000000 +0200
@@ -65,7 +65,7 @@ aic7770_map_int(struct ahc_softc *ahc, u
 
 	shared = 0;
 	if ((ahc->flags & AHC_EDGE_INTERRUPT) == 0)
-		shared = SA_SHIRQ;
+		shared = IRQF_SHARED;
 
 	error = request_irq(irq, ahc_linux_isr, shared, "aic7xxx", ahc);
 	if (error == 0)
Index: linux-2.6.git/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2006-07-01 16:51:47.000000000 +0200
@@ -342,7 +342,7 @@ ahd_pci_map_int(struct ahd_softc *ahd)
 	int error;
 
 	error = request_irq(ahd->dev_softc->irq, ahd_linux_isr,
-			    SA_SHIRQ, "aic79xx", ahd);
+			    IRQF_SHARED, "aic79xx", ahd);
 	if (!error)
 		ahd->platform_data->irq = ahd->dev_softc->irq;
 	
Index: linux-2.6.git/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2006-07-01 16:51:47.000000000 +0200
@@ -375,7 +375,7 @@ ahc_pci_map_int(struct ahc_softc *ahc)
 	int error;
 
 	error = request_irq(ahc->dev_softc->irq, ahc_linux_isr,
-			    SA_SHIRQ, "aic7xxx", ahc);
+			    IRQF_SHARED, "aic7xxx", ahc);
 	if (error == 0)
 		ahc->platform_data->irq = ahc->dev_softc->irq;
 	
Index: linux-2.6.git/drivers/scsi/arm/acornscsi.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/arm/acornscsi.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/arm/acornscsi.c	2006-07-01 16:51:47.000000000 +0200
@@ -3030,7 +3030,7 @@ acornscsi_probe(struct expansion_card *e
 	if (!request_region(host->io_port, 2048, "acornscsi(ram)"))
 		goto err_5;
 
-	ret = request_irq(host->irq, acornscsi_intr, SA_INTERRUPT, "acornscsi", ashost);
+	ret = request_irq(host->irq, acornscsi_intr, IRQF_DISABLED, "acornscsi", ashost);
 	if (ret) {
 		printk(KERN_CRIT "scsi%d: IRQ%d not free: %d\n",
 			host->host_no, ashost->scsi.irq, ret);
Index: linux-2.6.git/drivers/scsi/arm/cumana_1.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/arm/cumana_1.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/arm/cumana_1.c	2006-07-01 16:51:47.000000000 +0200
@@ -277,7 +277,7 @@ cumanascsi1_probe(struct expansion_card 
         ((struct NCR5380_hostdata *)host->hostdata)->ctrl = 0;
         outb(0x00, host->io_port - 577);
 
-	ret = request_irq(host->irq, cumanascsi_intr, SA_INTERRUPT,
+	ret = request_irq(host->irq, cumanascsi_intr, IRQF_DISABLED,
 			  "CumanaSCSI-1", host);
 	if (ret) {
 		printk("scsi%d: IRQ%d not free: %d\n",
Index: linux-2.6.git/drivers/scsi/arm/cumana_2.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/arm/cumana_2.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/arm/cumana_2.c	2006-07-01 16:51:47.000000000 +0200
@@ -460,7 +460,7 @@ cumanascsi2_probe(struct expansion_card 
 		goto out_free;
 
 	ret = request_irq(ec->irq, cumanascsi_2_intr,
-			  SA_INTERRUPT, "cumanascsi2", info);
+			  IRQF_DISABLED, "cumanascsi2", info);
 	if (ret) {
 		printk("scsi%d: IRQ%d not free: %d\n",
 		       host->host_no, ec->irq, ret);
Index: linux-2.6.git/drivers/scsi/arm/powertec.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/arm/powertec.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/arm/powertec.c	2006-07-01 16:51:47.000000000 +0200
@@ -373,7 +373,7 @@ powertecscsi_probe(struct expansion_card
 		goto out_free;
 
 	ret = request_irq(ec->irq, powertecscsi_intr,
-			  SA_INTERRUPT, "powertec", info);
+			  IRQF_DISABLED, "powertec", info);
 	if (ret) {
 		printk("scsi%d: IRQ%d not free: %d\n",
 		       host->host_no, ec->irq, ret);
Index: linux-2.6.git/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/lpfc/lpfc_init.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/lpfc/lpfc_init.c	2006-07-01 16:51:47.000000000 +0200
@@ -1620,7 +1620,7 @@ lpfc_pci_probe_one(struct pci_dev *pdev,
 	if (error)
 		goto out_remove_host;
 
-	error =	request_irq(phba->pcidev->irq, lpfc_intr_handler, SA_SHIRQ,
+	error =	request_irq(phba->pcidev->irq, lpfc_intr_handler, IRQF_SHARED,
 							LPFC_DRIVER_NAME, phba);
 	if (error) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
Index: linux-2.6.git/drivers/scsi/megaraid/megaraid_mbox.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/megaraid/megaraid_mbox.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/megaraid/megaraid_mbox.c	2006-07-01 16:51:47.000000000 +0200
@@ -767,7 +767,7 @@ megaraid_init_mbox(adapter_t *adapter)
 	//
 
 	// request IRQ and register the interrupt service routine
-	if (request_irq(adapter->irq, megaraid_isr, SA_SHIRQ, "megaraid",
+	if (request_irq(adapter->irq, megaraid_isr, IRQF_SHARED, "megaraid",
 		adapter)) {
 
 		con_log(CL_ANN, (KERN_WARNING
Index: linux-2.6.git/drivers/scsi/megaraid/megaraid_sas.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/megaraid/megaraid_sas.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/megaraid/megaraid_sas.c	2006-07-01 16:51:47.000000000 +0200
@@ -2191,7 +2191,7 @@ megasas_probe_one(struct pci_dev *pdev, 
 	/*
 	 * Register IRQ
 	 */
-	if (request_irq(pdev->irq, megasas_isr, SA_SHIRQ, "megasas", instance)) {
+	if (request_irq(pdev->irq, megasas_isr, IRQF_SHARED, "megasas", instance)) {
 		printk(KERN_DEBUG "megasas: Failed to register IRQ\n");
 		goto fail_irq;
 	}
Index: linux-2.6.git/drivers/scsi/pcmcia/nsp_cs.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/pcmcia/nsp_cs.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/pcmcia/nsp_cs.c	2006-07-01 16:51:47.000000000 +0200
@@ -1623,7 +1623,7 @@ static int nsp_cs_probe(struct pcmcia_de
 	/* Interrupt handler */
 	link->irq.Handler	 = &nspintr;
 	link->irq.Instance       = info;
-	link->irq.Attributes     |= (SA_SHIRQ | SA_SAMPLE_RANDOM);
+	link->irq.Attributes     |= (IRQF_SHARED | IRQF_SAMPLE_RANDOM);
 
 	/* General socket configuration */
 	link->conf.Attributes	 = CONF_ENABLE_IRQ;
Index: linux-2.6.git/drivers/scsi/pcmcia/sym53c500_cs.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/pcmcia/sym53c500_cs.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/pcmcia/sym53c500_cs.c	2006-07-01 16:51:47.000000000 +0200
@@ -799,7 +799,7 @@ next_entry:
 	data = (struct sym53c500_data *)host->hostdata;
 
 	if (irq_level > 0) {
-		if (request_irq(irq_level, SYM53C500_intr, SA_SHIRQ, "SYM53C500", host)) {
+		if (request_irq(irq_level, SYM53C500_intr, IRQF_SHARED, "SYM53C500", host)) {
 			printk("SYM53C500: unable to allocate IRQ %d\n", irq_level);
 			goto err_free_scsi;
 		}
Index: linux-2.6.git/drivers/scsi/qla2xxx/qla_os.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/qla2xxx/qla_os.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/qla2xxx/qla_os.c	2006-07-01 16:51:47.000000000 +0200
@@ -1541,7 +1541,7 @@ static int qla2x00_probe_one(struct pci_
 	host->transportt = qla2xxx_transport_template;
 
 	ret = request_irq(pdev->irq, ha->isp_ops.intr_handler,
-	    SA_INTERRUPT|SA_SHIRQ, QLA2XXX_DRIVER_NAME, ha);
+	    IRQF_DISABLED|IRQF_SHARED, QLA2XXX_DRIVER_NAME, ha);
 	if (ret) {
 		qla_printk(KERN_WARNING, ha,
 		    "Failed to reserve interrupt %d already in use.\n",
Index: linux-2.6.git/drivers/scsi/sym53c8xx_2/sym_glue.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-07-01 16:51:47.000000000 +0200
@@ -1547,7 +1547,7 @@ static struct Scsi_Host * __devinit sym_
 	 *  If we synchonize the C code with SCRIPTS on interrupt, 
 	 *  we do not want to share the INTR line at all.
 	 */
-	if (request_irq(pdev->irq, sym53c8xx_intr, SA_SHIRQ, NAME53C8XX, np)) {
+	if (request_irq(pdev->irq, sym53c8xx_intr, IRQF_SHARED, NAME53C8XX, np)) {
 		printf_err("%s: request irq %d failure\n",
 			sym_name(np), pdev->irq);
 		goto attach_failed;

--

