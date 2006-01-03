Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWACIGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWACIGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 03:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWACIGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 03:06:15 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:34439 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750776AbWACIGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 03:06:14 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] fix readw/writew warning in sata_vsc
Date: Tue, 3 Jan 2006 10:05:23 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DBjuDb1y6kMi86J"
Message-Id: <200601031005.23885.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_DBjuDb1y6kMi86J
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  CC      drivers/scsi/sata_vsc.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c: In function `vsc_sata_tf_load':
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:133: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:134: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:135: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:136: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:137: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:139: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:140: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:141: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:142: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:143: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:147: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c: In function `vsc_sata_tf_read':
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:159: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:160: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:161: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:162: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:163: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:164: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c: In function `vsc_sata_setup_port':
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:283: warning: passing arg 2 of `writel' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:284: warning: passing arg 2 of `writel' makes pointer from integer without a cast

Patch adds (void __iomem *) casts where needed.
--
vda

--Boundary-00=_DBjuDb1y6kMi86J
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.6.15-rc7.sata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.15-rc7.sata.patch"

  CC      drivers/scsi/sata_vsc.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c: In function `vsc_sata_tf_load':
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:133: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:134: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:135: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:136: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:137: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:139: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:140: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:141: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:142: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:143: warning: passing arg 2 of `writew' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:147: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c: In function `vsc_sata_tf_read':
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:159: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:160: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:161: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:162: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:163: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:164: warning: passing arg 1 of `readw' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c: In function `vsc_sata_setup_port':
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:283: warning: passing arg 2 of `writel' makes pointer from integer without a cast
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c:284: warning: passing arg 2 of `writel' makes pointer from integer without a cast


diff -urpN linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c linux-2.6.15-rc7.fix/drivers/scsi/sata_vsc.c
--- linux-2.6.15-rc7.src/drivers/scsi/sata_vsc.c	Fri Dec 30 14:18:02 2005
+++ linux-2.6.15-rc7.fix/drivers/scsi/sata_vsc.c	Sun Jan  1 17:27:50 2006
@@ -130,21 +130,21 @@ static void vsc_sata_tf_load(struct ata_
 		vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
 	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
-		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
-		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
-		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
-		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
+		writew(tf->feature | (((u16)tf->hob_feature) << 8), (void __iomem *) ioaddr->feature_addr);
+		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), (void __iomem *) ioaddr->nsect_addr);
+		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), (void __iomem *) ioaddr->lbal_addr);
+		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), (void __iomem *) ioaddr->lbam_addr);
+		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), (void __iomem *) ioaddr->lbah_addr);
 	} else if (is_addr) {
-		writew(tf->feature, ioaddr->feature_addr);
-		writew(tf->nsect, ioaddr->nsect_addr);
-		writew(tf->lbal, ioaddr->lbal_addr);
-		writew(tf->lbam, ioaddr->lbam_addr);
-		writew(tf->lbah, ioaddr->lbah_addr);
+		writew(tf->feature, (void __iomem *) ioaddr->feature_addr);
+		writew(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
+		writew(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
+		writew(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
+		writew(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE)
-		writeb(tf->device, ioaddr->device_addr);
+		writeb(tf->device, (void __iomem *) ioaddr->device_addr);
 
 	ata_wait_idle(ap);
 }
@@ -156,12 +156,12 @@ static void vsc_sata_tf_read(struct ata_
 	u16 nsect, lbal, lbam, lbah, feature;
 
 	tf->command = ata_check_status(ap);
-	tf->device = readw(ioaddr->device_addr);
-	feature = readw(ioaddr->error_addr);
-	nsect = readw(ioaddr->nsect_addr);
-	lbal = readw(ioaddr->lbal_addr);
-	lbam = readw(ioaddr->lbam_addr);
-	lbah = readw(ioaddr->lbah_addr);
+	tf->device = readw((void __iomem *) ioaddr->device_addr);
+	feature = readw((void __iomem *) ioaddr->error_addr);
+	nsect = readw((void __iomem *) ioaddr->nsect_addr);
+	lbal = readw((void __iomem *) ioaddr->lbal_addr);
+	lbam = readw((void __iomem *) ioaddr->lbam_addr);
+	lbah = readw((void __iomem *) ioaddr->lbah_addr);
 
 	tf->feature = feature;
 	tf->nsect = nsect;
@@ -280,8 +280,8 @@ static void __devinit vsc_sata_setup_por
 	port->ctl_addr		= base + VSC_SATA_TF_CTL_OFFSET;
 	port->bmdma_addr	= base + VSC_SATA_DMA_CMD_OFFSET;
 	port->scr_addr		= base + VSC_SATA_SCR_STATUS_OFFSET;
-	writel(0, base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
-	writel(0, base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
+	writel(0, (void __iomem *) (base + VSC_SATA_UP_DESCRIPTOR_OFFSET));
+	writel(0, (void __iomem *) (base + VSC_SATA_UP_DATA_BUFFER_OFFSET));
 }
 
 

--Boundary-00=_DBjuDb1y6kMi86J--
