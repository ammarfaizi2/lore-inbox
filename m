Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270655AbTHATcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270862AbTHATcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:32:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:6335 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270655AbTHATcV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:32:21 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10597663232556@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test2
In-Reply-To: <10597663213636@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Aug 2003 12:32:03 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1547.10.6, 2003/07/31 16:11:47-07:00, greg@kroah.com

[PATCH] PCI: pci_device_id can not be marked __devinitdata.

Fixes up drivers/input/* drivers/isdn/* drivers/media/*
drivers/mtd/* drivers/parisc/* drivers/pci/* drivers/parport/*
drivers/scsi/* and drivers/serial/*


 drivers/input/gameport/cs461x.c         |    2 +-
 drivers/input/gameport/emu10k1-gp.c     |    2 +-
 drivers/input/gameport/fm801-gp.c       |    2 +-
 drivers/input/gameport/vortex.c         |    2 +-
 drivers/isdn/hardware/avm/b1pci.c       |    2 +-
 drivers/isdn/hardware/avm/c4.c          |    2 +-
 drivers/isdn/hardware/avm/t1pci.c       |    2 +-
 drivers/isdn/hardware/eicon/divasmain.c |    2 +-
 drivers/isdn/hisax/hisax_fcpcipnp.c     |    2 +-
 drivers/isdn/hisax/hisax_hfcpci.c       |    2 +-
 drivers/isdn/tpam/tpam_main.c           |    2 +-
 drivers/media/radio/radio-maxiradio.c   |    2 +-
 drivers/media/video/bttv-driver.c       |    2 +-
 drivers/media/video/meye.c              |    2 +-
 drivers/mtd/maps/amd76xrom.c            |    2 +-
 drivers/mtd/maps/ich2rom.c              |    2 +-
 drivers/mtd/maps/pci.c                  |    2 +-
 drivers/mtd/maps/scb2_flash.c           |    2 +-
 drivers/parisc/eisa.c                   |    2 +-
 drivers/parisc/superio.c                |    2 +-
 drivers/parport/parport_pc.c            |    2 +-
 drivers/parport/parport_serial.c        |    2 +-
 drivers/pci/hotplug/cpcihp_zt5550.c     |    5 ++---
 drivers/pci/hotplug/cpqphp_core.c       |    2 +-
 drivers/pci/hotplug/ibmphp_ebda.c       |    2 +-
 drivers/pcmcia/yenta_socket.c           |    2 +-
 drivers/scsi/dc395x.c                   |    2 +-
 drivers/scsi/gdth.c                     |    2 +-
 drivers/scsi/ips.c                      |    2 +-
 drivers/scsi/nsp32.c                    |    2 +-
 drivers/scsi/tmscsim.c                  |    2 +-
 drivers/serial/8250_pci.c               |    2 +-
 32 files changed, 33 insertions(+), 34 deletions(-)


diff -Nru a/drivers/input/gameport/cs461x.c b/drivers/input/gameport/cs461x.c
--- a/drivers/input/gameport/cs461x.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/input/gameport/cs461x.c	Fri Aug  1 12:18:06 2003
@@ -216,7 +216,7 @@
 	return 0;
 }
 
-static struct pci_device_id cs461x_pci_tbl[] __devinitdata = {
+static struct pci_device_id cs461x_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CIRRUS, 0x6001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Cirrus CS4610 */
 	{ PCI_VENDOR_ID_CIRRUS, 0x6003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Cirrus CS4612 */
 	{ PCI_VENDOR_ID_CIRRUS, 0x6005, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Cirrus CS4615 */
diff -Nru a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
--- a/drivers/input/gameport/emu10k1-gp.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/input/gameport/emu10k1-gp.c	Fri Aug  1 12:18:06 2003
@@ -49,7 +49,7 @@
 	char phys[32];
 };
 	
-static struct pci_device_id emu_tbl[] __devinitdata = {
+static struct pci_device_id emu_tbl[] = {
 	{ 0x1102, 0x7002, PCI_ANY_ID, PCI_ANY_ID }, /* SB Live gameport */
 	{ 0x1102, 0x7003, PCI_ANY_ID, PCI_ANY_ID }, /* Audigy gameport */
 	{ 0, }
diff -Nru a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
--- a/drivers/input/gameport/fm801-gp.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/input/gameport/fm801-gp.c	Fri Aug  1 12:18:06 2003
@@ -131,7 +131,7 @@
 	}
 }
 
-static struct pci_device_id fm801_gp_id_table[] __devinitdata = {
+static struct pci_device_id fm801_gp_id_table[] = {
 	{ PCI_VENDOR_ID_FORTEMEDIA, PCI_DEVICE_ID_FM801_GP, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0  },
 	{ 0 }
 };
diff -Nru a/drivers/input/gameport/vortex.c b/drivers/input/gameport/vortex.c
--- a/drivers/input/gameport/vortex.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/input/gameport/vortex.c	Fri Aug  1 12:18:06 2003
@@ -159,7 +159,7 @@
 	kfree(vortex);
 }
 
-static struct pci_device_id vortex_id_table[] __devinitdata =
+static struct pci_device_id vortex_id_table[] =
 {{ 0x12eb, 0x0001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0x11000 },
  { 0x12eb, 0x0002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0x28800 },
  { 0 }};
diff -Nru a/drivers/isdn/hardware/avm/b1pci.c b/drivers/isdn/hardware/avm/b1pci.c
--- a/drivers/isdn/hardware/avm/b1pci.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/isdn/hardware/avm/b1pci.c	Fri Aug  1 12:18:06 2003
@@ -28,7 +28,7 @@
 
 /* ------------------------------------------------------------- */
 
-static struct pci_device_id b1pci_pci_tbl[] __devinitdata = {
+static struct pci_device_id b1pci_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AVM, PCI_DEVICE_ID_AVM_B1, PCI_ANY_ID, PCI_ANY_ID },
 	{ }				/* Terminating entry */
 };
diff -Nru a/drivers/isdn/hardware/avm/c4.c b/drivers/isdn/hardware/avm/c4.c
--- a/drivers/isdn/hardware/avm/c4.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/isdn/hardware/avm/c4.c	Fri Aug  1 12:18:06 2003
@@ -36,7 +36,7 @@
 
 static int suppress_pollack;
 
-static struct pci_device_id c4_pci_tbl[] __devinitdata = {
+static struct pci_device_id c4_pci_tbl[] = {
 	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21285, PCI_VENDOR_ID_AVM, PCI_DEVICE_ID_AVM_C4, 4 },
 	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21285, PCI_VENDOR_ID_AVM, PCI_DEVICE_ID_AVM_C2, 2 },
 	{ }			/* Terminating entry */
diff -Nru a/drivers/isdn/hardware/avm/t1pci.c b/drivers/isdn/hardware/avm/t1pci.c
--- a/drivers/isdn/hardware/avm/t1pci.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/isdn/hardware/avm/t1pci.c	Fri Aug  1 12:18:06 2003
@@ -31,7 +31,7 @@
 
 /* ------------------------------------------------------------- */
 
-static struct pci_device_id t1pci_pci_tbl[] __devinitdata = {
+static struct pci_device_id t1pci_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AVM, PCI_DEVICE_ID_AVM_T1, PCI_ANY_ID, PCI_ANY_ID },
 	{ }				/* Terminating entry */
 };
diff -Nru a/drivers/isdn/hardware/eicon/divasmain.c b/drivers/isdn/hardware/eicon/divasmain.c
--- a/drivers/isdn/hardware/eicon/divasmain.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/isdn/hardware/eicon/divasmain.c	Fri Aug  1 12:18:06 2003
@@ -119,7 +119,7 @@
 /*
   This table should be sorted by PCI device ID
   */
-static struct pci_device_id divas_pci_tbl[] __devinitdata = {
+static struct pci_device_id divas_pci_tbl[] = {
 /* Diva Server BRI-2M PCI 0xE010 */
 	{PCI_VENDOR_ID_EICON, PCI_DEVICE_ID_EICON_MAESTRA,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, CARDTYPE_MAESTRA_PCI},
diff -Nru a/drivers/isdn/hisax/hisax_fcpcipnp.c b/drivers/isdn/hisax/hisax_fcpcipnp.c
--- a/drivers/isdn/hisax/hisax_fcpcipnp.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/isdn/hisax/hisax_fcpcipnp.c	Fri Aug  1 12:18:06 2003
@@ -46,7 +46,7 @@
 MODULE_AUTHOR("Kai Germaschewski <kai.germaschewski@gmx.de>/Karsten Keil <kkeil@suse.de>");
 MODULE_DESCRIPTION("AVM Fritz!PCI/PnP ISDN driver");
 
-static struct pci_device_id fcpci_ids[] __devinitdata = {
+static struct pci_device_id fcpci_ids[] = {
 	{ .vendor      = PCI_VENDOR_ID_AVM,
 	  .device      = PCI_DEVICE_ID_AVM_A1,
 	  .subvendor   = PCI_ANY_ID,
diff -Nru a/drivers/isdn/hisax/hisax_hfcpci.c b/drivers/isdn/hisax/hisax_hfcpci.c
--- a/drivers/isdn/hisax/hisax_hfcpci.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/isdn/hisax/hisax_hfcpci.c	Fri Aug  1 12:18:06 2003
@@ -47,7 +47,7 @@
           .class_mask  = 0,                      \
 	  .driver_data = (unsigned long) name }
 
-static struct pci_device_id hfcpci_ids[] __devinitdata = {
+static struct pci_device_id hfcpci_ids[] = {
 	ID(CCD,     CCD_2BD0,         "CCD/Billion/Asuscom 2BD0"),
 	ID(CCD,     CCD_B000,         "Billion B000"),
 	ID(CCD,     CCD_B006,         "Billion B006"),
diff -Nru a/drivers/isdn/tpam/tpam_main.c b/drivers/isdn/tpam/tpam_main.c
--- a/drivers/isdn/tpam/tpam_main.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/isdn/tpam/tpam_main.c	Fri Aug  1 12:18:06 2003
@@ -241,7 +241,7 @@
 	kfree(card);
 }
 
-static struct pci_device_id tpam_pci_tbl[] __devinitdata = {
+static struct pci_device_id tpam_pci_tbl[] = {
 	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_TURBOPAM,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ }
diff -Nru a/drivers/media/radio/radio-maxiradio.c b/drivers/media/radio/radio-maxiradio.c
--- a/drivers/media/radio/radio-maxiradio.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/media/radio/radio-maxiradio.c	Fri Aug  1 12:18:06 2003
@@ -327,7 +327,7 @@
 	release_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
 }
 
-static struct pci_device_id maxiradio_pci_tbl[] __devinitdata = {
+static struct pci_device_id maxiradio_pci_tbl[] = {
 	{ PCI_VENDOR_ID_GUILLEMOT, PCI_DEVICE_ID_GUILLEMOT_MAXIRADIO,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0,}
diff -Nru a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
--- a/drivers/media/video/bttv-driver.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/media/video/bttv-driver.c	Fri Aug  1 12:18:06 2003
@@ -3496,7 +3496,7 @@
         return;
 }
 
-static struct pci_device_id bttv_pci_tbl[] __devinitdata = {
+static struct pci_device_id bttv_pci_tbl[] = {
         {PCI_VENDOR_ID_BROOKTREE, PCI_DEVICE_ID_BT848,
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_BROOKTREE, PCI_DEVICE_ID_BT849,
diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/media/video/meye.c	Fri Aug  1 12:18:06 2003
@@ -1416,7 +1416,7 @@
 	printk(KERN_INFO "meye: removed\n");
 }
 
-static struct pci_device_id meye_pci_tbl[] __devinitdata = {
+static struct pci_device_id meye_pci_tbl[] = {
 	{ PCI_VENDOR_ID_KAWASAKI, PCI_DEVICE_ID_MCHIP_KL5A72002, 
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ }
diff -Nru a/drivers/mtd/maps/amd76xrom.c b/drivers/mtd/maps/amd76xrom.c
--- a/drivers/mtd/maps/amd76xrom.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/mtd/maps/amd76xrom.c	Fri Aug  1 12:18:06 2003
@@ -160,7 +160,7 @@
 #endif /* REQUEST_MEM_REGION */
 }
 
-static struct pci_device_id amd76xrom_pci_tbl[] __devinitdata = {
+static struct pci_device_id amd76xrom_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7410,  
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7440,  
diff -Nru a/drivers/mtd/maps/ich2rom.c b/drivers/mtd/maps/ich2rom.c
--- a/drivers/mtd/maps/ich2rom.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/mtd/maps/ich2rom.c	Fri Aug  1 12:18:06 2003
@@ -260,7 +260,7 @@
 #endif
 }
 
-static struct pci_device_id ich2rom_pci_tbl[] __devinitdata = {
+static struct pci_device_id ich2rom_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, 
 	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, 
diff -Nru a/drivers/mtd/maps/pci.c b/drivers/mtd/maps/pci.c
--- a/drivers/mtd/maps/pci.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/mtd/maps/pci.c	Fri Aug  1 12:18:06 2003
@@ -191,7 +191,7 @@
  * PCI device ID table
  */
 
-static struct pci_device_id mtd_pci_ids[] __devinitdata = {
+static struct pci_device_id mtd_pci_ids[] = {
 	{
 		.vendor =	PCI_VENDOR_ID_INTEL,
 		.device =	0x530d,
diff -Nru a/drivers/mtd/maps/scb2_flash.c b/drivers/mtd/maps/scb2_flash.c
--- a/drivers/mtd/maps/scb2_flash.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/mtd/maps/scb2_flash.c	Fri Aug  1 12:18:06 2003
@@ -218,7 +218,7 @@
 	pci_set_drvdata(dev, NULL);
 }
 
-static struct pci_device_id scb2_flash_pci_ids[] __devinitdata = {
+static struct pci_device_id scb2_flash_pci_ids[] = {
 	{
 	  .vendor = PCI_VENDOR_ID_SERVERWORKS,
 	  .device = PCI_DEVICE_ID_SERVERWORKS_CSB5,
diff -Nru a/drivers/parisc/eisa.c b/drivers/parisc/eisa.c
--- a/drivers/parisc/eisa.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/parisc/eisa.c	Fri Aug  1 12:18:06 2003
@@ -398,7 +398,7 @@
 	return 0;
 }
 
-static struct parisc_device_id __devinitdata eisa_tbl[] = {
+static struct parisc_device_id eisa_tbl[] = {
 	{ HPHW_BA, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00076 }, /* Mongoose */
 	{ HPHW_BA, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00090 }, /* Wax EISA */
 	{ 0, }
diff -Nru a/drivers/parisc/superio.c b/drivers/parisc/superio.c
--- a/drivers/parisc/superio.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/parisc/superio.c	Fri Aug  1 12:18:06 2003
@@ -517,7 +517,7 @@
 	}
 }
 
-static struct pci_device_id superio_tbl[] __devinitdata = {
+static struct pci_device_id superio_tbl[] = {
 	{ PCI_VENDOR_ID_NS, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, }
 };
diff -Nru a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/parport/parport_pc.c	Fri Aug  1 12:18:06 2003
@@ -2825,7 +2825,7 @@
 	/* mobility_pp */		{ 1, { { 0, 1 }, } },
 };
 
-static struct pci_device_id parport_pc_pci_tbl[] __devinitdata = {
+static struct pci_device_id parport_pc_pci_tbl[] = {
 	/* Super-IO onboard chips */
 	{ 0x1106, 0x0686, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sio_via_686a },
 	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8872,
diff -Nru a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
--- a/drivers/parport/parport_serial.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/parport/parport_serial.c	Fri Aug  1 12:18:06 2003
@@ -87,7 +87,7 @@
 	/* siig_2s1p_20x */		{ 1, { { 2, 3 }, } },
 };
 
-static struct pci_device_id parport_serial_pci_tbl[] __devinitdata = {
+static struct pci_device_id parport_serial_pci_tbl[] = {
 	/* PCI cards */
 	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_110L,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_110l },
diff -Nru a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
--- a/drivers/pci/hotplug/cpcihp_zt5550.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c	Fri Aug  1 12:18:06 2003
@@ -187,8 +187,7 @@
 	return 0;
 }
 
-static int __devinit zt5550_hc_init_one (struct pci_dev *pdev,
-					 const struct pci_device_id *ent)
+static int zt5550_hc_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int status;
 
@@ -262,7 +261,7 @@
 }
 
 
-static struct pci_device_id zt5550_hc_pci_tbl[] __devinitdata = {
+static struct pci_device_id zt5550_hc_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ZIATECH, PCI_DEVICE_ID_ZIATECH_5550_HC, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }
 };
diff -Nru a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
--- a/drivers/pci/hotplug/cpqphp_core.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/pci/hotplug/cpqphp_core.c	Fri Aug  1 12:18:06 2003
@@ -1488,7 +1488,7 @@
 
 
 
-static struct pci_device_id hpcd_pci_tbl[] __devinitdata = {
+static struct pci_device_id hpcd_pci_tbl[] = {
 	{
 	/* handle any PCI Hotplug controller */
 	.class =        ((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00),
diff -Nru a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
--- a/drivers/pci/hotplug/ibmphp_ebda.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/pci/hotplug/ibmphp_ebda.c	Fri Aug  1 12:18:06 2003
@@ -1230,7 +1230,7 @@
 	}
 }
 
-static struct pci_device_id id_table[] __devinitdata = {
+static struct pci_device_id id_table[] = {
 	{
 		.vendor		= PCI_VENDOR_ID_IBM,
 		.device		= HPC_DEVICE_ID,
diff -Nru a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
--- a/drivers/pcmcia/yenta_socket.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/pcmcia/yenta_socket.c	Fri Aug  1 12:18:06 2003
@@ -911,7 +911,7 @@
 }
 
 
-static struct pci_device_id yenta_table [] __devinitdata = { {
+static struct pci_device_id yenta_table [] = { {
 	.class		= PCI_CLASS_BRIDGE_CARDBUS << 8,
 	.class_mask	= ~0,
 
diff -Nru a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
--- a/drivers/scsi/dc395x.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/scsi/dc395x.c	Fri Aug  1 12:18:06 2003
@@ -6237,7 +6237,7 @@
  * Table which identifies the PCI devices which
  * are handled by this device driver.
  */
-static struct pci_device_id dc395x_pci_table[] __devinitdata = {
+static struct pci_device_id dc395x_pci_table[] = {
 	{
 		.vendor		= PCI_VENDOR_ID_TEKRAM,
 		.device		= PCI_DEVICE_ID_TEKRAM_TRMS1040,
diff -Nru a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
--- a/drivers/scsi/gdth.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/scsi/gdth.c	Fri Aug  1 12:18:06 2003
@@ -862,7 +862,7 @@
 /* Vortex only makes RAID controllers.
  * We do not really want to specify all 550 ids here, so wildcard match.
  */
-static struct pci_device_id gdthtable[] __devinitdata = {
+static struct pci_device_id gdthtable[] = {
     {PCI_VENDOR_ID_VORTEX,PCI_ANY_ID,PCI_ANY_ID, PCI_ANY_ID},
     {PCI_VENDOR_ID_INTEL,PCI_DEVICE_ID_INTEL_SRC,PCI_ANY_ID,PCI_ANY_ID}, 
     {PCI_VENDOR_ID_INTEL,PCI_DEVICE_ID_INTEL_SRC_XSCALE,PCI_ANY_ID,PCI_ANY_ID}, 
diff -Nru a/drivers/scsi/ips.c b/drivers/scsi/ips.c
--- a/drivers/scsi/ips.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/scsi/ips.c	Fri Aug  1 12:18:06 2003
@@ -280,7 +280,7 @@
 
 
    /* This table describes all ServeRAID Adapters */
-   static struct  pci_device_id  ips_pci_table[]  __devinitdata = {
+   static struct  pci_device_id  ips_pci_table[] = {
            { 0x1014, 0x002E, PCI_ANY_ID, PCI_ANY_ID, 0, 0 },
            { 0x1014, 0x01BD, PCI_ANY_ID, PCI_ANY_ID, 0, 0 },
            { 0x9005, 0x0250, PCI_ANY_ID, PCI_ANY_ID, 0, 0 },
diff -Nru a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
--- a/drivers/scsi/nsp32.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/scsi/nsp32.c	Fri Aug  1 12:18:06 2003
@@ -2001,7 +2001,7 @@
 	iounmap((void *)(data->MmioAddress));
 }
 
-static struct pci_device_id nsp32_pci_table[] __devinitdata = {
+static struct pci_device_id nsp32_pci_table[] = {
 	{
 		.vendor      = PCI_VENDOR_ID_IODATA,
 		.device      = PCI_DEVICE_ID_NINJASCSI_32BI_CBSC_II,
diff -Nru a/drivers/scsi/tmscsim.c b/drivers/scsi/tmscsim.c
--- a/drivers/scsi/tmscsim.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/scsi/tmscsim.c	Fri Aug  1 12:18:06 2003
@@ -274,7 +274,7 @@
 #endif
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,99)
-static struct pci_device_id tmscsim_pci_tbl[] __initdata = {
+static struct pci_device_id tmscsim_pci_tbl[] = {
 	{
 		.vendor		= PCI_VENDOR_ID_AMD,
 		.device		= PCI_DEVICE_ID_AMD53C974,
diff -Nru a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c	Fri Aug  1 12:18:06 2003
+++ b/drivers/serial/8250_pci.c	Fri Aug  1 12:18:06 2003
@@ -1647,7 +1647,7 @@
 	return 0;
 }
 
-static struct pci_device_id serial_pci_tbl[] __devinitdata = {
+static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,

