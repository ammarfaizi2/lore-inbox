Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTJGXTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 19:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbTJGXTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 19:19:39 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58100 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262637AbTJGXSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 19:18:13 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][IDE] do not init to zero fields of static chipset tables in drivers/ide/pci/*.h
Date: Wed, 8 Oct 2003 01:21:52 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310080121.52947.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] do not init to zero fields of static chipset tables in drivers/ide/pci/*.h

 drivers/ide/pci/adma100.h      |    6 -----
 drivers/ide/pci/aec62xx.h      |   12 -----------
 drivers/ide/pci/alim15x3.h     |    6 -----
 drivers/ide/pci/amd74xx.h      |   10 ---------
 drivers/ide/pci/cmd640.h       |    8 -------
 drivers/ide/pci/cmd64x.h       |   13 ------------
 drivers/ide/pci/cs5520.h       |    4 ---
 drivers/ide/pci/cs5530.h       |    6 -----
 drivers/ide/pci/cy82c693.h     |    6 -----
 drivers/ide/pci/generic.h      |   40 --------------------------------------
 drivers/ide/pci/hpt34x.h       |    5 ----
 drivers/ide/pci/hpt366.h       |   17 ----------------
 drivers/ide/pci/it8172.h       |    5 ----
 drivers/ide/pci/ns87415.h      |    7 ------
 drivers/ide/pci/opti621.h      |    9 --------
 drivers/ide/pci/pdc202xx_new.h |   30 +---------------------------
 drivers/ide/pci/pdc202xx_old.h |   27 ++++---------------------
 drivers/ide/pci/piix.h         |   43 -----------------------------------------
 drivers/ide/pci/rz1000.h       |   13 ------------
 drivers/ide/pci/sc1200.h       |    6 -----
 drivers/ide/pci/serverworks.h  |   16 ---------------
 drivers/ide/pci/siimage.h      |    9 --------
 drivers/ide/pci/sis5513.h      |    5 ----
 drivers/ide/pci/sl82c105.h     |    5 ----
 drivers/ide/pci/slc90e66.h     |    5 ----
 drivers/ide/pci/triflex.h      |    1 
 drivers/ide/pci/trm290.h       |    8 -------
 drivers/ide/pci/via82cxxx.h    |    5 ----
 28 files changed, 7 insertions(+), 320 deletions(-)

diff -puN drivers/ide/pci/adma100.h~ide-pci-dont-zero-static drivers/ide/pci/adma100.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/adma100.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.011197120 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/adma100.h	2003-10-08 00:48:54.094184504 +0200
@@ -17,18 +17,12 @@ static ide_pci_device_t pdcadma_chipsets
 		.name		= "ADMA100",
 		.init_setup	= init_setup_pdcadma,
 		.init_chipset	= init_chipset_pdcadma,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdcadma,
 		.init_dma	= init_dma_pdcadma,
 		.channels	= 2,
 		.autodma	= NODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 }
diff -puN drivers/ide/pci/aec62xx.h~ide-pci-dont-zero-static drivers/ide/pci/aec62xx.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/aec62xx.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.014196664 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/aec62xx.h	2003-10-08 00:48:54.095184352 +0200
@@ -100,70 +100,58 @@ static ide_pci_device_t aec62xx_chipsets
 		.name		= "AEC6210",
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_aec62xx,
 		.init_dma	= init_dma_aec62xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	},{	/* 1 */
 		.vendor		= PCI_VENDOR_ID_ARTOP,
 		.device		= PCI_DEVICE_ID_ARTOP_ATP860,
 		.name		= "AEC6260",
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_aec62xx,
 		.init_dma	= init_dma_aec62xx,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	},{	/* 2 */
 		.vendor		= PCI_VENDOR_ID_ARTOP,
 		.device		= PCI_DEVICE_ID_ARTOP_ATP860R,
 		.name		= "AEC6260R",
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_aec62xx,
 		.init_dma	= init_dma_aec62xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= NEVER_BOARD,
-		.extra		= 0,
 	},{	/* 3 */
 		.vendor		= PCI_VENDOR_ID_ARTOP,
 		.device		= PCI_DEVICE_ID_ARTOP_ATP865,
 		.name		= "AEC6X80",
 		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_aec62xx,
 		.init_dma	= init_dma_aec62xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	},{	/* 4 */
 		.vendor		= PCI_VENDOR_ID_ARTOP,
 		.device		= PCI_DEVICE_ID_ARTOP_ATP865R,
 		.name		= "AEC6X80R",
 		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_aec62xx,
 		.init_dma	= init_dma_aec62xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	}
 };
 
diff -puN drivers/ide/pci/alim15x3.h~ide-pci-dont-zero-static drivers/ide/pci/alim15x3.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/alim15x3.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.016196360 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/alim15x3.h	2003-10-08 00:48:54.096184200 +0200
@@ -35,18 +35,12 @@ static ide_pci_device_t ali15x3_chipsets
 		.device		= PCI_DEVICE_ID_AL_M5229,
 		.name		= "ALI15X3",
 		.init_chipset	= init_chipset_ali15x3,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_ali15x3,
 		.init_dma	= init_dma_ali15x3,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/amd74xx.h~ide-pci-dont-zero-static drivers/ide/pci/amd74xx.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/amd74xx.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.020195752 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/amd74xx.h	2003-10-08 00:48:54.096184200 +0200
@@ -38,7 +38,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
-		.extra		= 0
 	},{	/* 1 */
 		.vendor		= PCI_VENDOR_ID_AMD,
 		.device		= PCI_DEVICE_ID_AMD_VIPER_7409,
@@ -49,7 +48,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
-		.extra		= 0
 	},{	/* 2 */
 		.vendor		= PCI_VENDOR_ID_AMD,
 		.device		= PCI_DEVICE_ID_AMD_VIPER_7411,
@@ -60,7 +58,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
-		.extra		= 0
 	},{	/* 3 */
 		.vendor		= PCI_VENDOR_ID_AMD,
 		.device		= PCI_DEVICE_ID_AMD_OPUS_7441,
@@ -71,7 +68,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
-		.extra		= 0
 	},{	/* 4 */
 		.vendor		= PCI_VENDOR_ID_AMD,
 		.device		= PCI_DEVICE_ID_AMD_8111_IDE,
@@ -82,7 +78,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.channels	= 2,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
-		.extra		= 0
 	},
 	{	/* 5 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
@@ -94,7 +89,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},
 	{	/* 6 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
@@ -106,12 +100,8 @@ static ide_pci_device_t amd74xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},
 	{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/cmd640.h~ide-pci-dont-zero-static drivers/ide/pci/cmd640.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cmd640.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.023195296 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cmd640.h	2003-10-08 00:48:54.097184048 +0200
@@ -12,19 +12,11 @@ static ide_pci_device_t cmd640_chipsets[
 		.vendor		= PCI_VENDOR_ID_CMD,
 		.device		= PCI_DEVICE_ID_CMD_640,
 		.name		= "CMD640",
-		.init_setup	= NULL,
-		.init_chipset	= NULL,
-		.init_iops	= NULL,
 		.init_hwif	= IDE_IGNORE,
-		.init_dma	= NULL,
 		.channels	= 2,
 		.autodma	= NODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0
 	},{
-		.vendor		= 0,
-		.device		= 0,
 		.bootable	= EOL,
 	}
 }
diff -puN drivers/ide/pci/cmd64x.h~ide-pci-dont-zero-static drivers/ide/pci/cmd64x.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cmd64x.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.025194992 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cmd64x.h	2003-10-08 00:48:54.097184048 +0200
@@ -87,52 +87,39 @@ static ide_pci_device_t cmd64x_chipsets[
 		.device		= PCI_DEVICE_ID_CMD_643,
 		.name		= "CMD643",
 		.init_chipset	= init_chipset_cmd64x,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 1 */
 		.vendor		= PCI_VENDOR_ID_CMD,
 		.device		= PCI_DEVICE_ID_CMD_646,
 		.name		= "CMD646",
 		.init_chipset	= init_chipset_cmd64x,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 2 */
 		.vendor		= PCI_VENDOR_ID_CMD,
 		.device	= PCI_DEVICE_ID_CMD_648,
 		.name		= "CMD648",
 		.init_chipset	= init_chipset_cmd64x,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
 		.vendor		= PCI_VENDOR_ID_CMD,
 		.device		= PCI_DEVICE_ID_CMD_649,
 		.name		= "CMD649",
 		.init_chipset	= init_chipset_cmd64x,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
 		.channels	= 2,
 		.bootable	= EOL,
 	}
diff -puN drivers/ide/pci/cs5520.h~ide-pci-dont-zero-static drivers/ide/pci/cs5520.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cs5520.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.028194536 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cs5520.h	2003-10-08 00:48:54.097184048 +0200
@@ -35,13 +35,11 @@ static ide_pci_device_t cyrix_chipsets[]
 		.name		= "Cyrix 5510",
 		.init_chipset	= init_chipset_cs5520,
 		.init_setup_dma = cs5520_init_setup_dma,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cs5520,
 		.isa_ports	= 1,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_CYRIX,
@@ -49,13 +47,11 @@ static ide_pci_device_t cyrix_chipsets[]
 		.name		= "Cyrix 5520",
 		.init_chipset	= init_chipset_cs5520,
 		.init_setup_dma = cs5520_init_setup_dma,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cs5520,
 		.isa_ports	= 1,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	}
 };
 
diff -puN drivers/ide/pci/cs5530.h~ide-pci-dont-zero-static drivers/ide/pci/cs5530.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cs5530.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.031194080 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cs5530.h	2003-10-08 00:48:54.098183896 +0200
@@ -33,17 +33,11 @@ static ide_pci_device_t cs5530_chipsets[
 		.device		= PCI_DEVICE_ID_CYRIX_5530_IDE,
 		.name		= "CS5530",
 		.init_chipset	= init_chipset_cs5530,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cs5530,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/cy82c693.h~ide-pci-dont-zero-static drivers/ide/pci/cy82c693.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cy82c693.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.034193624 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cy82c693.h	2003-10-08 00:48:54.098183896 +0200
@@ -76,16 +76,10 @@ static ide_pci_device_t cy82c693_chipset
 		.init_chipset	= init_chipset_cy82c693,
 		.init_iops	= init_iops_cy82c693,
 		.init_hwif	= init_hwif_cy82c693,
-		.init_dma	= NULL,
 		.channels	= 1,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/generic.h~ide-pci-dont-zero-static drivers/ide/pci/generic.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/generic.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.037193168 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/generic.h	2003-10-08 00:48:54.099183744 +0200
@@ -14,125 +14,93 @@ static ide_pci_device_t generic_chipsets
 		.device		= PCI_DEVICE_ID_NS_87410,
 		.name		= "NS87410",
 		.init_chipset	= init_chipset_generic,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
         },{	/* 1 */
 		.vendor		= PCI_VENDOR_ID_PCTECH,
 		.device		= PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,
 		.name		= "SAMURAI",
 		.init_chipset	= init_chipset_generic,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 2 */
 		.vendor		= PCI_VENDOR_ID_HOLTEK,
 		.device		= PCI_DEVICE_ID_HOLTEK_6565,
 		.name		= "HT6565",
 		.init_chipset	= init_chipset_generic,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 3 */
 		.vendor		= PCI_VENDOR_ID_UMC,
 		.device		= PCI_DEVICE_ID_UMC_UM8673F,
 		.name		= "UM8673F",
 		.init_chipset	= init_chipset_generic,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 4 */
 		.vendor		= PCI_VENDOR_ID_UMC,
 		.device		= PCI_DEVICE_ID_UMC_UM8886A,
 		.name		= "UM8886A",
 		.init_chipset	= init_chipset_generic,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 5 */
 		.vendor		= PCI_VENDOR_ID_UMC,
 		.device		= PCI_DEVICE_ID_UMC_UM8886BF,
 		.name		= "UM8886BF",
 		.init_chipset	= init_chipset_generic,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 6 */
 		.vendor		= PCI_VENDOR_ID_HINT,
 		.device		= PCI_DEVICE_ID_HINT_VXPROII_IDE,
 		.name		= "HINT_IDE",
 		.init_chipset	= init_chipset_generic,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 7 */
 		.vendor		= PCI_VENDOR_ID_VIA,
 		.device		= PCI_DEVICE_ID_VIA_82C561,
 		.name		= "VIA_IDE",
 		.init_chipset	= init_chipset_generic,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 8 */
 		.vendor		= PCI_VENDOR_ID_OPTI,
 		.device		= PCI_DEVICE_ID_OPTI_82C558,
 		.name		= "OPTI621V",
 		.init_chipset	= init_chipset_generic,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 9 */
 		.vendor		= PCI_VENDOR_ID_VIA,
 		.device		= PCI_DEVICE_ID_VIA_8237_SATA,
 		.name		= "VIA8237SATA",
 		.init_chipset	= init_chipset_generic,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
@@ -140,21 +108,13 @@ static ide_pci_device_t generic_chipsets
 #if 0
 static ide_pci_device_t unknown_chipset[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= 0,
-		.device		= 0,
 		.name		= "PCI_IDE",
 		.init_chipset	= init_chipset_generic,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 
diff -puN drivers/ide/pci/hpt34x.h~ide-pci-dont-zero-static drivers/ide/pci/hpt34x.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/hpt34x.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.040192712 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/hpt34x.h	2003-10-08 00:48:54.100183592 +0200
@@ -39,17 +39,12 @@ static ide_pci_device_t hpt34x_chipsets[
 		.device		= PCI_DEVICE_ID_TTI_HPT343,
 		.name		= "HPT34X",
 		.init_chipset	= init_chipset_hpt34x,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_hpt34x,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= NEVER_BOARD,
 		.extra		= 16
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/hpt366.h~ide-pci-dont-zero-static drivers/ide/pci/hpt366.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/hpt366.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.043192256 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/hpt366.h	2003-10-08 00:48:54.101183440 +0200
@@ -447,12 +447,10 @@ static ide_pci_device_t hpt366_chipsets[
 		.name		= "HPT366",
 		.init_setup	= init_setup_hpt366,
 		.init_chipset	= init_chipset_hpt366,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	},{	/* 1 */
@@ -461,60 +459,45 @@ static ide_pci_device_t hpt366_chipsets[
 		.name		= "HPT372A",
 		.init_setup	= init_setup_hpt37x,
 		.init_chipset	= init_chipset_hpt366,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0
 	},{	/* 2 */
 		.vendor		= PCI_VENDOR_ID_TTI,
 		.device		= PCI_DEVICE_ID_TTI_HPT302,
 		.name		= "HPT302",
 		.init_setup	= init_setup_hpt37x,
 		.init_chipset	= init_chipset_hpt366,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0
 	},{	/* 3 */
 		.vendor		= PCI_VENDOR_ID_TTI,
 		.device		= PCI_DEVICE_ID_TTI_HPT371,
 		.name		= "HPT371",
 		.init_setup	= init_setup_hpt37x,
 		.init_chipset	= init_chipset_hpt366,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0
 	},{	/* 4 */
 		.vendor		= PCI_VENDOR_ID_TTI,
 		.device		= PCI_DEVICE_ID_TTI_HPT374,
 		.name		= "HPT374",
 		.init_setup	= init_setup_hpt374,
 		.init_chipset	= init_chipset_hpt366,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,	/* 4 */
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/it8172.h~ide-pci-dont-zero-static drivers/ide/pci/it8172.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/it8172.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.045191952 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/it8172.h	2003-10-08 00:48:54.101183440 +0200
@@ -25,17 +25,12 @@ static ide_pci_device_t it8172_chipsets[
 		.name		= "IT8172G",
 		.init_setup	= init_setup_it8172,
 		.init_chipset	= init_chipset_it8172,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_it8172,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x40,0x00,0x01}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/ns87415.h~ide-pci-dont-zero-static drivers/ide/pci/ns87415.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/ns87415.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.048191496 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/ns87415.h	2003-10-08 00:48:54.101183440 +0200
@@ -12,18 +12,11 @@ static ide_pci_device_t ns87415_chipsets
 		.vendor		= PCI_VENDOR_ID_NS,
 		.device		= PCI_DEVICE_ID_NS_87415,
 		.name		= "NS87415",
-		.init_chipset	= NULL,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_ns87415,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/opti621.h~ide-pci-dont-zero-static drivers/ide/pci/opti621.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/opti621.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.052190888 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/opti621.h	2003-10-08 00:48:54.102183288 +0200
@@ -14,31 +14,22 @@ static ide_pci_device_t opti621_chipsets
 		.device		= PCI_DEVICE_ID_OPTI_82C621,
 		.name		= "OPTI621",
 		.init_setup	= init_setup_opti621,
-		.init_chipset	= NULL,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_opti621,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 1 */
 		.vendor		= PCI_VENDOR_ID_OPTI,
 		.device		= PCI_DEVICE_ID_OPTI_82C825,
 		.name		= "OPTI621X",
 		.init_setup	= init_setup_opti621,
-		.init_chipset	= NULL,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_opti621,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/pdc202xx_new.h~ide-pci-dont-zero-static drivers/ide/pci/pdc202xx_new.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/pdc202xx_new.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.055190432 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/pdc202xx_new.h	2003-10-08 00:48:54.103183136 +0200
@@ -195,103 +195,77 @@ static ide_pci_device_t pdcnew_chipsets[
 		.name		= "PDC20268",
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	},{	/* 1 */
 		.vendor		= PCI_VENDOR_ID_PROMISE,
 		.device		= PCI_DEVICE_ID_PROMISE_20269,
 		.name		= "PDC20269",
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	},{	/* 2 */
 		.vendor		= PCI_VENDOR_ID_PROMISE,
 		.device		= PCI_DEVICE_ID_PROMISE_20270,
 		.name		= "PDC20270",
 		.init_setup	= init_setup_pdc20270,
 		.init_chipset	= init_chipset_pdcnew,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifdef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-#else /* !CONFIG_PDC202XX_FORCE */
+#ifndef CONFIG_PDC202XX_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	},{	/* 3 */
 		.vendor		= PCI_VENDOR_ID_PROMISE,
 		.device		= PCI_DEVICE_ID_PROMISE_20271,
 		.name		= "PDC20271",
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	},{	/* 4 */
 		.vendor		= PCI_VENDOR_ID_PROMISE,
 		.device		= PCI_DEVICE_ID_PROMISE_20275,
 		.name		= "PDC20275",
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	},{	/* 5 */
 		.vendor		= PCI_VENDOR_ID_PROMISE,
 		.device		= PCI_DEVICE_ID_PROMISE_20276,
 		.name		= "PDC20276",
 		.init_setup	= init_setup_pdc20276,
 		.init_chipset	= init_chipset_pdcnew,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifdef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-#else /* !CONFIG_PDC202XX_FORCE */
+#ifndef CONFIG_PDC202XX_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	},{	/* 6 */
 		.vendor		= PCI_VENDOR_ID_PROMISE,
 		.device		= PCI_DEVICE_ID_PROMISE_20277,
 		.name		= "PDC20277",
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/pdc202xx_old.h~ide-pci-dont-zero-static drivers/ide/pci/pdc202xx_old.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/pdc202xx_old.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.058189976 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/pdc202xx_old.h	2003-10-08 00:48:54.103183136 +0200
@@ -231,14 +231,11 @@ static ide_pci_device_t pdc202xx_chipset
 		.name		= "PDC20246",
 		.init_setup	= init_setup_pdc202ata4,
 		.init_chipset	= init_chipset_pdc202xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifdef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-#else /* !CONFIG_PDC202XX_FORCE */
+#ifndef CONFIG_PDC202XX_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -249,14 +246,11 @@ static ide_pci_device_t pdc202xx_chipset
 		.name		= "PDC20262",
 		.init_setup	= init_setup_pdc202ata4,
 		.init_chipset	= init_chipset_pdc202xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifdef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-#else /* !CONFIG_PDC202XX_FORCE */
+#ifndef CONFIG_PDC202XX_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -267,14 +261,11 @@ static ide_pci_device_t pdc202xx_chipset
 		.name		= "PDC20263",
 		.init_setup	= init_setup_pdc202ata4,
 		.init_chipset	= init_chipset_pdc202xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifdef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-#else /* !CONFIG_PDC202XX_FORCE */
+#ifndef CONFIG_PDC202XX_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -289,9 +280,7 @@ static ide_pci_device_t pdc202xx_chipset
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifdef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-#else /* !CONFIG_PDC202XX_FORCE */
+#ifndef CONFIG_PDC202XX_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -302,22 +291,16 @@ static ide_pci_device_t pdc202xx_chipset
 		.name		= "PDC20267",
 		.init_setup	= init_setup_pdc202xx,
 		.init_chipset	= init_chipset_pdc202xx,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifdef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-#else /* !CONFIG_PDC202XX_FORCE */
+#ifndef CONFIG_PDC202XX_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/piix.h~ide-pci-dont-zero-static drivers/ide/pci/piix.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/piix.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.062189368 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/piix.h	2003-10-08 00:48:54.104182984 +0200
@@ -42,252 +42,209 @@ static ide_pci_device_t piix_pci_info[] 
 		.name		= "PIIXa",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 1 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82371FB_1,
 		.name		= "PIIXb",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 2 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82371MX,
 		.name		= "MPIIX",
 		.init_setup	= init_setup_piix,
-		.init_chipset	= NULL,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= NODMA,
 		.enablebits	= {{0x6D,0x80,0x80}, {0x6F,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 3 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82371SB_1,
 		.name		= "PIIX3",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 4 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82371AB,
 		.name		= "PIIX4",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 5 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801AB_1,
 		.name		= "ICH0",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 6 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82443MX_1,
 		.name		= "PIIX4",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 7 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801AA_1,
 		.name		= "ICH",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 8 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82372FB_1,
 		.name		= "PIIX4",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 9 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82451NX,
 		.name		= "PIIX4",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 10 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801BA_9,
 		.name		= "ICH2",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 11 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801BA_8,
 		.name		= "ICH2M",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 12 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801CA_10,
 		.name		= "ICH3M",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 13 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801CA_11,
 		.name		= "ICH3",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 14 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801DB_11,
 		.name		= "ICH4",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 15 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801EB_11,
 		.name		= "ICH5",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 16 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801E_11,
 		.name		= "C-ICH",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 17 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801DB_10,
 		.name		= "ICH4",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 18 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801EB_1,
 		.name		= "ICH5-SATA",
 		.init_setup	= init_setup_piix,
 		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
-		.init_setup	= NULL,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/rz1000.h~ide-pci-dont-zero-static drivers/ide/pci/rz1000.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/rz1000.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.065188912 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/rz1000.h	2003-10-08 00:48:54.105182832 +0200
@@ -12,32 +12,19 @@ static ide_pci_device_t rz1000_chipsets[
 		.vendor		= PCI_VENDOR_ID_PCTECH,
 		.device		= PCI_DEVICE_ID_PCTECH_RZ1000,
 		.name		= "RZ1000",
-		.init_chipset	= NULL,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_rz1000,
-		.init_dma	= NULL,
 		.channels	= 2,
 		.autodma	= NODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
 		.vendor		= PCI_VENDOR_ID_PCTECH,
 		.device		= PCI_DEVICE_ID_PCTECH_RZ1001,
 		.name		= "RZ1001",
-		.init_chipset	= NULL,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_rz1000,
-		.init_dma	= NULL,
 		.channels	= 2,
 		.autodma	= NODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/sc1200.h~ide-pci-dont-zero-static drivers/ide/pci/sc1200.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/sc1200.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.067188608 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/sc1200.h	2003-10-08 00:48:54.105182832 +0200
@@ -33,17 +33,11 @@ static ide_pci_device_t sc1200_chipsets[
 		.device		= PCI_DEVICE_ID_NS_SCx200_IDE,
 		.name		= "SC1200",
 		.init_chipset	= init_chipset_sc1200,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_sc1200,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/serverworks.h~ide-pci-dont-zero-static drivers/ide/pci/serverworks.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/serverworks.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.071188000 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/serverworks.h	2003-10-08 00:48:54.106182680 +0200
@@ -53,60 +53,44 @@ static ide_pci_device_t serverworks_chip
 		.name		= "SvrWks OSB4",
 		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_svwks,
-		.init_dma	= NULL,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 1 */
 		.vendor		= PCI_VENDOR_ID_SERVERWORKS,
 		.device		= PCI_DEVICE_ID_SERVERWORKS_CSB5IDE,
 		.name		= "SvrWks CSB5",
 		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_svwks,
 		.init_dma	= init_dma_svwks,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 2 */
 		.vendor		= PCI_VENDOR_ID_SERVERWORKS,
 		.device		= PCI_DEVICE_ID_SERVERWORKS_CSB6IDE,
 		.name		= "SvrWks CSB6",
 		.init_setup	= init_setup_csb6,
 		.init_chipset	= init_chipset_svwks,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_svwks,
 		.init_dma	= init_dma_svwks,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 3 */
 		.vendor		= PCI_VENDOR_ID_SERVERWORKS,
 		.device		= PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2,
 		.name		= "SvrWks CSB6",
 		.init_setup	= init_setup_csb6,
 		.init_chipset	= init_chipset_svwks,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_svwks,
 		.init_dma	= init_dma_svwks,
 		.channels	= 1,	/* 2 */
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/siimage.h~ide-pci-dont-zero-static drivers/ide/pci/siimage.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/siimage.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.074187544 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/siimage.h	2003-10-08 00:48:54.106182680 +0200
@@ -54,9 +54,7 @@ static ide_pci_device_t siimage_chipsets
 		.init_hwif	= init_hwif_siimage,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 1 */
 		.vendor		= PCI_VENDOR_ID_CMD,
 		.device		= PCI_DEVICE_ID_SII_3112,
@@ -66,9 +64,7 @@ static ide_pci_device_t siimage_chipsets
 		.init_hwif	= init_hwif_siimage,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 2 */
 		.vendor		= PCI_VENDOR_ID_CMD,
 		.device		= PCI_DEVICE_ID_SII_1210SA,
@@ -78,13 +74,8 @@ static ide_pci_device_t siimage_chipsets
 		.init_hwif	= init_hwif_siimage,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/sis5513.h~ide-pci-dont-zero-static drivers/ide/pci/sis5513.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/sis5513.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.076187240 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/sis5513.h	2003-10-08 00:48:54.107182528 +0200
@@ -33,17 +33,12 @@ static ide_pci_device_t sis5513_chipsets
 		.device		= PCI_DEVICE_ID_SI_5513,
 		.name		= "SIS5513",
 		.init_chipset	= init_chipset_sis5513,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_sis5513,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= ON_BOARD,
-		.extra		= 0
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/sl82c105.h~ide-pci-dont-zero-static drivers/ide/pci/sl82c105.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/sl82c105.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.080186632 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/sl82c105.h	2003-10-08 00:48:54.107182528 +0200
@@ -15,18 +15,13 @@ static ide_pci_device_t sl82c105_chipset
 		.device		= PCI_DEVICE_ID_WINBOND_82C105,
 		.name		= "W82C105",
 		.init_chipset	= init_chipset_sl82c105,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_sl82c105,
 		.init_dma	= init_dma_sl82c105,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x10,0x10}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/slc90e66.h~ide-pci-dont-zero-static drivers/ide/pci/slc90e66.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/slc90e66.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.083186176 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/slc90e66.h	2003-10-08 00:48:54.108182376 +0200
@@ -35,17 +35,12 @@ static ide_pci_device_t slc90e66_chipset
 		.device		= PCI_DEVICE_ID_EFAR_SLC90E66_1,
 		.name		= "SLC90E66",
 		.init_chipset	= init_chipset_slc90e66,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_slc90e66,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/triflex.h~ide-pci-dont-zero-static drivers/ide/pci/triflex.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/triflex.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.085185872 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/triflex.h	2003-10-08 00:48:54.108182376 +0200
@@ -22,7 +22,6 @@ static ide_pci_device_t triflex_devices[
 		.device		= PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE,
 		.name		= "TRIFLEX",
 		.init_chipset	= init_chipset_triflex,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_triflex,
 		.channels	= 2,
 		.autodma	= AUTODMA,
diff -puN drivers/ide/pci/trm290.h~ide-pci-dont-zero-static drivers/ide/pci/trm290.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/trm290.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.088185416 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/trm290.h	2003-10-08 00:48:54.108182376 +0200
@@ -12,19 +12,11 @@ static ide_pci_device_t trm290_chipsets[
 		.vendor		= PCI_VENDOR_ID_TEKRAM,
 		.device		= PCI_DEVICE_ID_TEKRAM_DC290,
 		.name		= "TRM290",
-		.init_chipset	= NULL,
-		.init_iops	= NULL,
 		.init_hwif	= init_hwif_trm290,
-		.init_dma	= NULL,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };
diff -puN drivers/ide/pci/via82cxxx.h~ide-pci-dont-zero-static drivers/ide/pci/via82cxxx.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/via82cxxx.h~ide-pci-dont-zero-static	2003-10-08 00:48:54.091184960 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/via82cxxx.h	2003-10-08 00:48:54.109182224 +0200
@@ -38,7 +38,6 @@ static ide_pci_device_t via82cxxx_chipse
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{	/* 1 */
 		.vendor		= PCI_VENDOR_ID_VIA,
 		.device		= PCI_DEVICE_ID_VIA_82C586_1,
@@ -49,11 +48,7 @@ static ide_pci_device_t via82cxxx_chipse
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
 		.bootable	= EOL,
 	}
 };

_

