Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263946AbTCVWng>; Sat, 22 Mar 2003 17:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263922AbTCVWly>; Sat, 22 Mar 2003 17:41:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13189
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263925AbTCVWlU>; Sat, 22 Mar 2003 17:41:20 -0500
Date: Sat, 22 Mar 2003 23:57:01 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303222357.h2MNv1AU020715@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: ide typo fixes #3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm looking into the other IDE problem from the merge - several people
see hangs. Bartolomiej has found one suspicious looking candidate. I'll
try and pin it down ASAP.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/pci/serverworks.c linux-2.5.65-ac3/drivers/ide/pci/serverworks.c
--- linux-2.5.65-bk3/drivers/ide/pci/serverworks.c	2003-03-22 19:35:11.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/pci/serverworks.c	2003-03-22 20:32:12.000000000 +0000
@@ -582,7 +582,7 @@
 			 * This is a device pin issue on CSB6.
 			 * Since there will be a future raid mode,
 			 * early versions of the chipset require the
-			 * interrupt pin to be set, and it is a compatiblity
+			 * interrupt pin to be set, and it is a compatibility
 			 * mode issue.
 			 */
 			dev->irq = 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/pci/sis5513.c linux-2.5.65-ac3/drivers/ide/pci/sis5513.c
--- linux-2.5.65-bk3/drivers/ide/pci/sis5513.c	2003-03-22 19:35:11.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/pci/sis5513.c	2003-03-22 20:32:12.000000000 +0000
@@ -70,7 +70,7 @@
    at boot time to its value */
 // #define BROKEN_LEVEL XFER_SW_DMA_0
 
-/* Miscellaneaous flags */
+/* Miscellaneous flags */
 #define SIS5513_LATENCY		0x01
 
 /* registers layout and init values are chipset family dependant */
@@ -185,7 +185,7 @@
 	{ "SiS5511",	PCI_DEVICE_ID_SI_5511,	ATA_16,		0},
 };
 
-/* Cycle time bits and values vary accross chip dma capabilities
+/* Cycle time bits and values vary across chip dma capabilities
    These three arrays hold the register layout and the values to set.
    Indexed by chipset_family and (dma_mode - XFER_UDMA_0) */
 
@@ -202,7 +202,7 @@
 	{15,10,7,5,3,2,1}, /* ATA_133a (earliest 691 southbridges) */
 	{15,10,7,5,3,2,1}, /* ATA_133 */
 };
-/* CRC Valid Setup Time vary accross IDE clock setting 33/66/100/133
+/* CRC Valid Setup Time vary across IDE clock setting 33/66/100/133
    See SiS962 data sheet for more detail */
 static u8 cvs_time_value[][XFER_UDMA_6 - XFER_UDMA_0 + 1] = {
 	{0,0,0,0,0,0,0}, /* no udma */
@@ -214,7 +214,7 @@
 	{9,6,4,2,2,2,2},
 	{9,6,4,2,2,2,2},
 };
-/* Initialize time, Active time, Recovery time vary accross
+/* Initialize time, Active time, Recovery time vary across
    IDE clock settings. These 3 arrays hold the register value
    for PIO0/1/2/3/4 and DMA0/1/2 mode in order */
 static u8 ini_time_value[][8] = {
@@ -927,7 +927,7 @@
 	}
 
 	/* Make general config ops here
-	   1/ tell IDE channels to operate in Compabitility mode only
+	   1/ tell IDE channels to operate in Compatibility mode only
 	   2/ tell old chips to allow per drive IDE timings */
 	if (host_dev) {
 		u8 reg;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/ppc/pmac.c linux-2.5.65-ac3/drivers/ide/ppc/pmac.c
--- linux-2.5.65-bk3/drivers/ide/ppc/pmac.c	2003-03-22 19:33:55.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/ppc/pmac.c	2003-03-22 20:32:12.000000000 +0000
@@ -61,7 +61,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 	/* Those fields are duplicating what is in hwif. We currently
 	 * can't use the hwif ones because of some assumptions that are
-	 * beeing done by the generic code about the kind of dma controller
+	 * being done by the generic code about the kind of dma controller
 	 * and format of the dma table. This will have to be fixed though.
 	 */
 	volatile struct dbdma_regs*	dma_regs;
@@ -1392,7 +1392,7 @@
 	/* We have to things to deal with here:
 	 * 
 	 * - The dbdma won't stop if the command was started
-	 * but completed with an error without transfering all
+	 * but completed with an error without transferring all
 	 * datas. This happens when bad blocks are met during
 	 * a multi-block transfer.
 	 * 
