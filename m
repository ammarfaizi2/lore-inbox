Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263017AbRE1IRy>; Mon, 28 May 2001 04:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263001AbRE1IRo>; Mon, 28 May 2001 04:17:44 -0400
Received: from ns01.vbnet.com.br ([200.230.208.6]:29414 "EHLO
	iron.vbnet.com.br") by vger.kernel.org with ESMTP
	id <S263012AbRE1IRi>; Mon, 28 May 2001 04:17:38 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] tiny cleanup ...
Date: Mon, 28 May 2001 05:17:21 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01052805172100.28606@shark.techlinux>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following patch remove some unused vars ... ( valid for 2.4.4-ac18 && 2.4.5-[vanilla,ac?] )

diff --exclude=*~ -ur linux-245ac/drivers/char/drm/r128_cce.c linux-245ac-carlos/drivers/char/drm/r128_cce.c
--- linux-245ac/drivers/char/drm/r128_cce.c	Mon May 28 04:53:40 2001
+++ linux-245ac-carlos/drivers/char/drm/r128_cce.c	Mon May 28 04:40:21 2001
@@ -1016,11 +1016,8 @@
 {
         drm_file_t *priv = filp->private_data;
         drm_device_t *dev = priv->dev;
-	drm_r128_private_t *dev_priv = dev->dev_private;
 	drm_r128_packet_t packet;
-	u32 *buffer;
 	int c;
-	int size;
 	int ret = 0;
 
 #if 0
diff --exclude=*~ -ur linux-245ac/drivers/mtd/nftlmount.c linux-245ac-carlos/drivers/mtd/nftlmount.c
--- linux-245ac/drivers/mtd/nftlmount.c	Mon May 28 04:53:35 2001
+++ linux-245ac-carlos/drivers/mtd/nftlmount.c	Mon May 28 04:41:11 2001
@@ -359,8 +359,7 @@
 {
 	struct nftl_uci1 h1;
 	unsigned int erase_mark;
-	int i, retlen;
-	unsigned char buf[SECTORSIZE];
+	int retlen;
 
 	/* check erase mark. */
 	if (MTD_READOOB(nftl->mtd, block * nftl->EraseSize + SECTORSIZE + 8, 8, 
diff --exclude=*~ -ur linux-245ac/drivers/net/irda/toshoboe.c linux-245ac-carlos/drivers/net/irda/toshoboe.c
--- linux-245ac/drivers/net/irda/toshoboe.c	Mon May 28 04:56:22 2001
+++ linux-245ac-carlos/drivers/net/irda/toshoboe.c	Mon May 28 04:41:33 2001
@@ -695,7 +695,6 @@
 {
   struct toshoboe_cb *self;
   struct net_device *dev;
-  struct pm_dev *pmdev;
   int i = 0;
   int ok = 0;
   int err;
diff --exclude=*~ -ur linux-245ac/drivers/parport/parport_pc.c linux-245ac-carlos/drivers/parport/parport_pc.c
--- linux-245ac/drivers/parport/parport_pc.c	Mon May 28 04:56:22 2001
+++ linux-245ac-carlos/drivers/parport/parport_pc.c	Mon May 28 04:41:53 2001
@@ -2798,7 +2798,6 @@
 static int __init parport_pc_find_ports (int autoirq, int autodma)
 {
 	int count = 0, r;
-	struct pci_dev *dev;
 
 #ifdef CONFIG_PARPORT_PC_SUPERIO
 	detect_and_report_winbond ();
diff --exclude=*~ -ur linux-245ac/drivers/scsi/scsi_debug.c linux-245ac-carlos/drivers/scsi/scsi_debug.c
--- linux-245ac/drivers/scsi/scsi_debug.c	Mon May 28 04:53:48 2001
+++ linux-245ac-carlos/drivers/scsi/scsi_debug.c	Mon May 28 04:42:14 2001
@@ -662,7 +662,6 @@
 
 int scsi_debug_biosparam(Disk * disk, kdev_t dev, int *info)
 {
-	int size = disk->capacity;
 	info[0] = N_HEAD;
 	info[1] = N_SECTOR;
 	info[2] = N_CYLINDER;
diff --exclude=*~ -ur linux-245ac/drivers/sound/via82cxxx_audio.c linux-245ac-carlos/drivers/sound/via82cxxx_audio.c
--- linux-245ac/drivers/sound/via82cxxx_audio.c	Mon May 28 04:54:00 2001
+++ linux-245ac-carlos/drivers/sound/via82cxxx_audio.c	Mon May 28 04:42:33 2001
@@ -1371,7 +1371,6 @@
 static int __init via_ac97_reset (struct via_info *card)
 {
 	struct pci_dev *pdev = card->pdev;
-	u8 tmp8;
 	u16 tmp16;
 
 	DPRINTK ("ENTER\n");
diff --exclude=*~ -ur linux-245ac/net/irda/irnet/irnet_irda.c linux-245ac-carlos/net/irda/irnet/irnet_irda.c
--- linux-245ac/net/irda/irnet/irnet_irda.c	Mon May 28 04:53:06 2001
+++ linux-245ac-carlos/net/irda/irnet/irnet_irda.c	Mon May 28 04:43:00 2001
@@ -1081,7 +1081,6 @@
 			LOCK_STATUS lock)
 {
   irnet_socket *	self = (irnet_socket *) instance;
-  LOCAL_FLOW		oldflow = self->tx_flow;
 
   DENTER(IRDA_TCB_TRACE, "(self=0x%X)\n", (unsigned int) self);
   DASSERT(self != NULL, , IRDA_CB_ERROR, "Self is NULL !!!\n");
--

	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________

