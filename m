Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270676AbTHATet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270871AbTHATeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:34:03 -0400
Received: from mail.kroah.org ([65.200.24.183]:7103 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270676AbTHATcX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:32:23 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10597663213636@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test2
In-Reply-To: <10597663191966@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Aug 2003 12:32:01 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1547.10.5, 2003/07/31 16:09:44-07:00, greg@kroah.com

[PATCH] PCI: pci_device_id can not be marked __devinitdata.

fixes up drivers/i2c/* drivers/ide/* and drivers/ieee1394/*


 drivers/i2c/busses/i2c-ali1535.c |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c |    2 +-
 drivers/i2c/busses/i2c-amd756.c  |    2 +-
 drivers/i2c/busses/i2c-amd8111.c |    2 +-
 drivers/i2c/busses/i2c-i801.c    |    2 +-
 drivers/i2c/busses/i2c-piix4.c   |    2 +-
 drivers/i2c/busses/i2c-sis96x.c  |    2 +-
 drivers/i2c/busses/i2c-viapro.c  |    2 +-
 drivers/i2c/chips/via686a.c      |    2 +-
 drivers/i2c/i2c-prosavage.c      |    2 +-
 drivers/ide/pci/aec62xx.c        |    2 +-
 drivers/ide/pci/alim15x3.c       |    2 +-
 drivers/ide/pci/amd74xx.c        |    2 +-
 drivers/ide/pci/cmd64x.c         |    2 +-
 drivers/ide/pci/cs5520.c         |    2 +-
 drivers/ide/pci/cs5530.c         |    2 +-
 drivers/ide/pci/cy82c693.c       |    2 +-
 drivers/ide/pci/generic.c        |    2 +-
 drivers/ide/pci/hpt34x.c         |    2 +-
 drivers/ide/pci/hpt366.c         |    2 +-
 drivers/ide/pci/it8172.c         |    2 +-
 drivers/ide/pci/ns87415.c        |    2 +-
 drivers/ide/pci/opti621.c        |    2 +-
 drivers/ide/pci/pdc202xx_new.c   |    2 +-
 drivers/ide/pci/pdc202xx_old.c   |    2 +-
 drivers/ide/pci/pdcadma.c        |    2 +-
 drivers/ide/pci/piix.c           |    2 +-
 drivers/ide/pci/rz1000.c         |    2 +-
 drivers/ide/pci/sc1200.c         |    2 +-
 drivers/ide/pci/serverworks.c    |    2 +-
 drivers/ide/pci/siimage.c        |    2 +-
 drivers/ide/pci/sis5513.c        |    2 +-
 drivers/ide/pci/sl82c105.c       |    2 +-
 drivers/ide/pci/slc90e66.c       |    2 +-
 drivers/ide/pci/triflex.h        |    2 +-
 drivers/ide/pci/trm290.c         |    2 +-
 drivers/ide/pci/via82cxxx.c      |    2 +-
 drivers/ieee1394/ohci1394.c      |    2 +-
 drivers/ieee1394/pcilynx.c       |    2 +-
 39 files changed, 39 insertions(+), 39 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/i2c/busses/i2c-ali1535.c	Fri Aug  1 12:18:18 2003
@@ -494,7 +494,7 @@
 	}
 };
 
-static struct pci_device_id ali1535_ids[] __devinitdata = {
+static struct pci_device_id ali1535_ids[] = {
 	{
 		.vendor =	PCI_VENDOR_ID_AL,
 		.device =	PCI_DEVICE_ID_AL_M7101,
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Fri Aug  1 12:18:18 2003
@@ -486,7 +486,7 @@
 	},
 };
 
-static struct pci_device_id ali15x3_ids[] __devinitdata = {
+static struct pci_device_id ali15x3_ids[] = {
 	{
 	.vendor =	PCI_VENDOR_ID_AL,
 	.device =	PCI_DEVICE_ID_AL_M7101,
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Fri Aug  1 12:18:18 2003
@@ -322,7 +322,7 @@
 
 enum chiptype { AMD756, AMD766, AMD768, NFORCE };
 
-static struct pci_device_id amd756_ids[] __devinitdata = {
+static struct pci_device_id amd756_ids[] = {
 	{PCI_VENDOR_ID_AMD, 0x740B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD756 },
 	{PCI_VENDOR_ID_AMD, 0x7413, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD766 },
 	{PCI_VENDOR_ID_AMD, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD768 },
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Fri Aug  1 12:18:18 2003
@@ -331,7 +331,7 @@
 };
 
 
-static struct pci_device_id amd8111_ids[] __devinitdata = {
+static struct pci_device_id amd8111_ids[] = {
 	{ 0x1022, 0x746a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, }
 };
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Fri Aug  1 12:18:18 2003
@@ -556,7 +556,7 @@
 	},
 };
 
-static struct pci_device_id i801_ids[] __devinitdata = {
+static struct pci_device_id i801_ids[] = {
 	{
 		.vendor =	PCI_VENDOR_ID_INTEL,
 		.device =	PCI_DEVICE_ID_INTEL_82801AA_3,
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Fri Aug  1 12:18:18 2003
@@ -402,7 +402,7 @@
 	},
 };
 
-static struct pci_device_id piix4_ids[] __devinitdata = {
+static struct pci_device_id piix4_ids[] = {
 	{
 		.vendor =	PCI_VENDOR_ID_INTEL,
 		.device =	PCI_DEVICE_ID_INTEL_82371AB_3,
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/i2c/busses/i2c-sis96x.c	Fri Aug  1 12:18:18 2003
@@ -276,7 +276,7 @@
 	},
 };
 
-static struct pci_device_id sis96x_ids[] __devinitdata = {
+static struct pci_device_id sis96x_ids[] = {
 
 	{
 		.vendor	=	PCI_VENDOR_ID_SI,
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/i2c/busses/i2c-viapro.c	Fri Aug  1 12:18:18 2003
@@ -401,7 +401,7 @@
 	release_region(vt596_smba, 8);
 }
 
-static struct pci_device_id vt596_ids[] __devinitdata = {
+static struct pci_device_id vt596_ids[] = {
 	{
 		.vendor		= PCI_VENDOR_ID_VIA,
 		.device 	= PCI_DEVICE_ID_VIA_82C596_3,
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/i2c/chips/via686a.c	Fri Aug  1 12:18:18 2003
@@ -914,7 +914,7 @@
 	up(&data->update_lock);
 }
 
-static struct pci_device_id via686a_pci_ids[] __devinitdata = {
+static struct pci_device_id via686a_pci_ids[] = {
        {
 	       .vendor 		= PCI_VENDOR_ID_VIA, 
 	       .device 		= PCI_DEVICE_ID_VIA_82C686_4, 
diff -Nru a/drivers/i2c/i2c-prosavage.c b/drivers/i2c/i2c-prosavage.c
--- a/drivers/i2c/i2c-prosavage.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/i2c/i2c-prosavage.c	Fri Aug  1 12:18:18 2003
@@ -321,7 +321,7 @@
 /*
  * Data for PCI driver interface
  */
-static struct pci_device_id prosavage_pci_tbl[] __devinitdata = {
+static struct pci_device_id prosavage_pci_tbl[] = {
    {
 	.vendor		=	PCI_VENDOR_ID_S3,
 	.device		=	PCI_DEVICE_ID_S3_SAVAGE4,
diff -Nru a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
--- a/drivers/ide/pci/aec62xx.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/aec62xx.c	Fri Aug  1 12:18:18 2003
@@ -533,7 +533,7 @@
 	return 0;
 }
 
-static struct pci_device_id aec62xx_pci_tbl[] __devinitdata = {
+static struct pci_device_id aec62xx_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
 	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860R,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
diff -Nru a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
--- a/drivers/ide/pci/alim15x3.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/alim15x3.c	Fri Aug  1 12:18:18 2003
@@ -872,7 +872,7 @@
 }
 
 
-static struct pci_device_id alim15x3_pci_tbl[] __devinitdata = {
+static struct pci_device_id alim15x3_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5229, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/amd74xx.c	Fri Aug  1 12:18:18 2003
@@ -440,7 +440,7 @@
 	return 0;
 }
 
-static struct pci_device_id amd74xx_pci_tbl[] __devinitdata = {
+static struct pci_device_id amd74xx_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_COBRA_7401,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7409,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7411,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
diff -Nru a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
--- a/drivers/ide/pci/cmd64x.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/cmd64x.c	Fri Aug  1 12:18:18 2003
@@ -763,7 +763,7 @@
 	return 0;
 }
 
-static struct pci_device_id cmd64x_pci_tbl[] __devinitdata = {
+static struct pci_device_id cmd64x_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_643, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_646, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_648, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
diff -Nru a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
--- a/drivers/ide/pci/cs5520.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/cs5520.c	Fri Aug  1 12:18:18 2003
@@ -296,7 +296,7 @@
 	return 0;
 }
 
-static struct pci_device_id cs5520_pci_tbl[] __devinitdata = {
+static struct pci_device_id cs5520_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
diff -Nru a/drivers/ide/pci/cs5530.c b/drivers/ide/pci/cs5530.c
--- a/drivers/ide/pci/cs5530.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/cs5530.c	Fri Aug  1 12:18:18 2003
@@ -431,7 +431,7 @@
 	return 0;
 }
 
-static struct pci_device_id cs5530_pci_tbl[] __devinitdata = {
+static struct pci_device_id cs5530_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/cy82c693.c b/drivers/ide/pci/cy82c693.c
--- a/drivers/ide/pci/cy82c693.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/cy82c693.c	Fri Aug  1 12:18:18 2003
@@ -439,7 +439,7 @@
 	return 0;
 }
 
-static struct pci_device_id cy82c693_pci_tbl[] __devinitdata = {
+static struct pci_device_id cy82c693_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
--- a/drivers/ide/pci/generic.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/generic.c	Fri Aug  1 12:18:18 2003
@@ -130,7 +130,7 @@
 	return 0;
 }
 
-static struct pci_device_id generic_pci_tbl[] __devinitdata = {
+static struct pci_device_id generic_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NS,     PCI_DEVICE_ID_NS_87410,            PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
diff -Nru a/drivers/ide/pci/hpt34x.c b/drivers/ide/pci/hpt34x.c
--- a/drivers/ide/pci/hpt34x.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/hpt34x.c	Fri Aug  1 12:18:18 2003
@@ -339,7 +339,7 @@
 	return 0;
 }
 
-static struct pci_device_id hpt34x_pci_tbl[] __devinitdata = {
+static struct pci_device_id hpt34x_pci_tbl[] = {
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT343, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
--- a/drivers/ide/pci/hpt366.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/hpt366.c	Fri Aug  1 12:18:18 2003
@@ -1190,7 +1190,7 @@
 	return 0;
 }
 
-static struct pci_device_id hpt366_pci_tbl[] __devinitdata = {
+static struct pci_device_id hpt366_pci_tbl[] = {
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT302, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
diff -Nru a/drivers/ide/pci/it8172.c b/drivers/ide/pci/it8172.c
--- a/drivers/ide/pci/it8172.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/it8172.c	Fri Aug  1 12:18:18 2003
@@ -303,7 +303,7 @@
 	return 0;
 }
 
-static struct pci_device_id it8172_pci_tbl[] __devinitdata = {
+static struct pci_device_id it8172_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_IT8172G, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/ns87415.c b/drivers/ide/pci/ns87415.c
--- a/drivers/ide/pci/ns87415.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/ns87415.c	Fri Aug  1 12:18:18 2003
@@ -236,7 +236,7 @@
 	return 0;
 }
 
-static struct pci_device_id ns87415_pci_tbl[] __devinitdata = {
+static struct pci_device_id ns87415_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/opti621.c b/drivers/ide/pci/opti621.c
--- a/drivers/ide/pci/opti621.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/opti621.c	Fri Aug  1 12:18:18 2003
@@ -371,7 +371,7 @@
 	return 0;
 }
 
-static struct pci_device_id opti621_pci_tbl[] __devinitdata = {
+static struct pci_device_id opti621_pci_tbl[] = {
 	{ PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C621, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
diff -Nru a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_new.c
--- a/drivers/ide/pci/pdc202xx_new.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/pdc202xx_new.c	Fri Aug  1 12:18:18 2003
@@ -636,7 +636,7 @@
 	return 0;
 }
 
-static struct pci_device_id pdc202new_pci_tbl[] __devinitdata = {
+static struct pci_device_id pdc202new_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20270, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/pdc202xx_old.c	Fri Aug  1 12:18:18 2003
@@ -928,7 +928,7 @@
 	return 0;
 }
 
-static struct pci_device_id pdc202xx_pci_tbl[] __devinitdata = {
+static struct pci_device_id pdc202xx_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20262, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20263, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
diff -Nru a/drivers/ide/pci/pdcadma.c b/drivers/ide/pci/pdcadma.c
--- a/drivers/ide/pci/pdcadma.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/pdcadma.c	Fri Aug  1 12:18:18 2003
@@ -134,7 +134,7 @@
 	return 1;
 }
 
-static struct pci_device_id pdcadma_pci_tbl[] __devinitdata = {
+static struct pci_device_id pdcadma_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PDC, PCI_DEVICE_ID_PDC_1841, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/piix.c	Fri Aug  1 12:18:18 2003
@@ -792,7 +792,7 @@
 		printk(KERN_WARNING "piix: A BIOS update may resolve this.\n");
 }		
 
-static struct pci_device_id piix_pci_tbl[] __devinitdata = {
+static struct pci_device_id piix_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
diff -Nru a/drivers/ide/pci/rz1000.c b/drivers/ide/pci/rz1000.c
--- a/drivers/ide/pci/rz1000.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/rz1000.c	Fri Aug  1 12:18:18 2003
@@ -66,7 +66,7 @@
 	return 0;
 }
 
-static struct pci_device_id rz1000_pci_tbl[] __devinitdata = {
+static struct pci_device_id rz1000_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
diff -Nru a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
--- a/drivers/ide/pci/sc1200.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/sc1200.c	Fri Aug  1 12:18:18 2003
@@ -564,7 +564,7 @@
 	return 0;
 }
 
-static struct pci_device_id sc1200_pci_tbl[] __devinitdata = {
+static struct pci_device_id sc1200_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverworks.c
--- a/drivers/ide/pci/serverworks.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/serverworks.c	Fri Aug  1 12:18:18 2003
@@ -799,7 +799,7 @@
 	return 0;
 }
 
-static struct pci_device_id svwks_pci_tbl[] __devinitdata = {
+static struct pci_device_id svwks_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
diff -Nru a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/siimage.c	Fri Aug  1 12:18:18 2003
@@ -826,7 +826,7 @@
 	return 0;
 }
 
-static struct pci_device_id siimage_pci_tbl[] __devinitdata = {
+static struct pci_device_id siimage_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
diff -Nru a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
--- a/drivers/ide/pci/sis5513.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/sis5513.c	Fri Aug  1 12:18:18 2003
@@ -961,7 +961,7 @@
 	return 0;
 }
 
-static struct pci_device_id sis5513_pci_tbl[] __devinitdata = {
+static struct pci_device_id sis5513_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/sl82c105.c b/drivers/ide/pci/sl82c105.c
--- a/drivers/ide/pci/sl82c105.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/sl82c105.c	Fri Aug  1 12:18:18 2003
@@ -511,7 +511,7 @@
 	return 0;
 }
 
-static struct pci_device_id sl82c105_pci_tbl[] __devinitdata = {
+static struct pci_device_id sl82c105_pci_tbl[] = {
 	{ PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/slc90e66.c b/drivers/ide/pci/slc90e66.c
--- a/drivers/ide/pci/slc90e66.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/slc90e66.c	Fri Aug  1 12:18:18 2003
@@ -381,7 +381,7 @@
 	return 0;
 }
 
-static struct pci_device_id slc90e66_pci_tbl[] __devinitdata = {
+static struct pci_device_id slc90e66_pci_tbl[] = {
 	{ PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/triflex.h b/drivers/ide/pci/triflex.h
--- a/drivers/ide/pci/triflex.h	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/triflex.h	Fri Aug  1 12:18:18 2003
@@ -41,7 +41,7 @@
 };
 #endif
 
-static struct pci_device_id triflex_pci_tbl[] __devinitdata = {
+static struct pci_device_id triflex_pci_tbl[] = {
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE, PCI_ANY_ID, 
 		PCI_ANY_ID, 0, 0, 0 },
 	{ 0, },
diff -Nru a/drivers/ide/pci/trm290.c b/drivers/ide/pci/trm290.c
--- a/drivers/ide/pci/trm290.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/trm290.c	Fri Aug  1 12:18:18 2003
@@ -407,7 +407,7 @@
 	return 0;
 }
 
-static struct pci_device_id trm290_pci_tbl[] __devinitdata = {
+static struct pci_device_id trm290_pci_tbl[] = {
 	{ PCI_VENDOR_ID_TEKRAM, PCI_DEVICE_ID_TEKRAM_DC290, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ide/pci/via82cxxx.c	Fri Aug  1 12:18:18 2003
@@ -638,7 +638,7 @@
 	return 0;
 }
 
-static struct pci_device_id via_pci_tbl[] __devinitdata = {
+static struct pci_device_id via_pci_tbl[] = {
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
diff -Nru a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
--- a/drivers/ieee1394/ohci1394.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ieee1394/ohci1394.c	Fri Aug  1 12:18:18 2003
@@ -3571,7 +3571,7 @@
 
 #define PCI_CLASS_FIREWIRE_OHCI     ((PCI_CLASS_SERIAL_FIREWIRE << 8) | 0x10)
 
-static struct pci_device_id ohci1394_pci_tbl[] __devinitdata = {
+static struct pci_device_id ohci1394_pci_tbl[] = {
 	{
 		.class = 	PCI_CLASS_FIREWIRE_OHCI,
 		.class_mask = 	PCI_ANY_ID,
diff -Nru a/drivers/ieee1394/pcilynx.c b/drivers/ieee1394/pcilynx.c
--- a/drivers/ieee1394/pcilynx.c	Fri Aug  1 12:18:18 2003
+++ b/drivers/ieee1394/pcilynx.c	Fri Aug  1 12:18:18 2003
@@ -1897,7 +1897,7 @@
         return sizeof(lynx_csr_rom);
 }
 
-static struct pci_device_id pci_table[] __devinitdata = {
+static struct pci_device_id pci_table[] = {
 	{
                 .vendor =    PCI_VENDOR_ID_TI,
                 .device =    PCI_DEVICE_ID_TI_PCILYNX,

