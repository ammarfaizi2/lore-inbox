Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272517AbTHATjS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270882AbTHAThK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:37:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:8127 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270858AbTHATcZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:32:25 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10597663154132@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test2
In-Reply-To: <10597663132258@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Aug 2003 12:31:55 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1547.10.2, 2003/07/31 16:07:20-07:00, greg@kroah.com

[PATCH] PCI: pci_device_id can not be marked __devinitdata.

Fixes up drivers/atm/* drivers/block/* drivers/char/* and drivers/video/*


 drivers/atm/eni.c                    |    2 +-
 drivers/atm/firestream.c             |    3 ++-
 drivers/atm/he.c                     |    2 +-
 drivers/atm/idt77252.c               |    2 +-
 drivers/atm/iphase.c                 |    2 +-
 drivers/block/umem.c                 |    2 +-
 drivers/char/agp/ali-agp.c           |    2 +-
 drivers/char/agp/amd-k7-agp.c        |    2 +-
 drivers/char/agp/amd-k8-agp.c        |    2 +-
 drivers/char/agp/i460-agp.c          |    2 +-
 drivers/char/agp/intel-agp.c         |    2 +-
 drivers/char/agp/nvidia-agp.c        |    2 +-
 drivers/char/agp/sworks-agp.c        |    2 +-
 drivers/char/epca.c                  |    2 +-
 drivers/char/synclink.c              |    2 +-
 drivers/char/synclinkmp.c            |    2 +-
 drivers/char/watchdog/wdt_pci.c      |    2 +-
 drivers/video/aty/aty128fb.c         |    2 +-
 drivers/video/chipsfb.c              |    2 +-
 drivers/video/console/sticore.c      |    2 +-
 drivers/video/cyber2000fb.c          |    2 +-
 drivers/video/i810/i810_main.h       |    2 +-
 drivers/video/imsttfb.c              |    2 +-
 drivers/video/matrox/matroxfb_base.c |    2 +-
 drivers/video/neofb.c                |    2 +-
 drivers/video/radeonfb.c             |    2 +-
 drivers/video/riva/fbdev.c           |    2 +-
 drivers/video/sstfb.c                |    2 +-
 drivers/video/tdfxfb.c               |    2 +-
 drivers/video/tridentfb.c            |    2 +-
 30 files changed, 31 insertions(+), 30 deletions(-)


diff -Nru a/drivers/atm/eni.c b/drivers/atm/eni.c
--- a/drivers/atm/eni.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/atm/eni.c	Fri Aug  1 12:19:02 2003
@@ -2327,7 +2327,7 @@
 }
 
 
-static struct pci_device_id eni_pci_tbl[] __devinitdata = {
+static struct pci_device_id eni_pci_tbl[] = {
 	{ PCI_VENDOR_ID_EF, PCI_DEVICE_ID_EF_ATM_FPGA, PCI_ANY_ID, PCI_ANY_ID,
 	  0, 0, 0 /* FPGA */ },
 	{ PCI_VENDOR_ID_EF, PCI_DEVICE_ID_EF_ATM_ASIC, PCI_ANY_ID, PCI_ANY_ID,
diff -Nru a/drivers/atm/firestream.c b/drivers/atm/firestream.c
--- a/drivers/atm/firestream.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/atm/firestream.c	Fri Aug  1 12:19:02 2003
@@ -2091,7 +2091,7 @@
 #endif 
 */
 
-static struct pci_device_id firestream_pci_tbl[] __devinitdata = {
+static struct pci_device_id firestream_pci_tbl[] = {
 	{ PCI_VENDOR_ID_FUJITSU_ME, PCI_DEVICE_ID_FUJITSU_FS50, 
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, FS_IS50},
 	{ PCI_VENDOR_ID_FUJITSU_ME, PCI_DEVICE_ID_FUJITSU_FS155, 
@@ -2127,4 +2127,5 @@
 module_exit(firestream_cleanup_module);
 
 MODULE_LICENSE("GPL");
+
 
diff -Nru a/drivers/atm/he.c b/drivers/atm/he.c
--- a/drivers/atm/he.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/atm/he.c	Fri Aug  1 12:19:02 2003
@@ -3096,7 +3096,7 @@
 MODULE_PARM(sdh, "i");
 MODULE_PARM_DESC(sdh, "use SDH framing (default 0)");
 
-static struct pci_device_id he_pci_tbl[] __devinitdata = {
+static struct pci_device_id he_pci_tbl[] = {
 	{ PCI_VENDOR_ID_FORE, PCI_DEVICE_ID_FORE_HE, PCI_ANY_ID, PCI_ANY_ID,
 	  0, 0, 0 },
 	{ 0, }
diff -Nru a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
--- a/drivers/atm/idt77252.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/atm/idt77252.c	Fri Aug  1 12:19:02 2003
@@ -3841,7 +3841,7 @@
 	return 0;
 }
 
-static struct pci_device_id idt77252_pci_tbl[] __devinitdata =
+static struct pci_device_id idt77252_pci_tbl[] =
 {
 	{ PCI_VENDOR_ID_IDT, PCI_DEVICE_ID_IDT_IDT77252,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
diff -Nru a/drivers/atm/iphase.c b/drivers/atm/iphase.c
--- a/drivers/atm/iphase.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/atm/iphase.c	Fri Aug  1 12:19:02 2003
@@ -3279,7 +3279,7 @@
       	kfree(iadev);
 }
 
-static struct pci_device_id ia_pci_tbl[] __devinitdata = {
+static struct pci_device_id ia_pci_tbl[] = {
 	{ PCI_VENDOR_ID_IPHASE, 0x0008, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_IPHASE, 0x0009, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0,}
diff -Nru a/drivers/block/umem.c b/drivers/block/umem.c
--- a/drivers/block/umem.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/block/umem.c	Fri Aug  1 12:19:02 2003
@@ -1145,7 +1145,7 @@
 				    card->mm_pages[1].page_dma);
 }
 
-static const struct pci_device_id __devinitdata mm_pci_ids[] = { {
+static const struct pci_device_id mm_pci_ids[] = { {
 	.vendor =	PCI_VENDOR_ID_MICRO_MEMORY,
 	.device =	PCI_DEVICE_ID_MICRO_MEMORY_5415CN,
 	}, {
diff -Nru a/drivers/char/agp/ali-agp.c b/drivers/char/agp/ali-agp.c
--- a/drivers/char/agp/ali-agp.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/char/agp/ali-agp.c	Fri Aug  1 12:19:02 2003
@@ -363,7 +363,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_ali_pci_table[] __initdata = {
+static struct pci_device_id agp_ali_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
diff -Nru a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
--- a/drivers/char/agp/amd-k7-agp.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/char/agp/amd-k7-agp.c	Fri Aug  1 12:19:02 2003
@@ -442,7 +442,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_amdk7_pci_table[] __initdata = {
+static struct pci_device_id agp_amdk7_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
diff -Nru a/drivers/char/agp/amd-k8-agp.c b/drivers/char/agp/amd-k8-agp.c
--- a/drivers/char/agp/amd-k8-agp.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/char/agp/amd-k8-agp.c	Fri Aug  1 12:19:02 2003
@@ -349,7 +349,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_amdk8_pci_table[] __initdata = {
+static struct pci_device_id agp_amdk8_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
diff -Nru a/drivers/char/agp/i460-agp.c b/drivers/char/agp/i460-agp.c
--- a/drivers/char/agp/i460-agp.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/char/agp/i460-agp.c	Fri Aug  1 12:19:02 2003
@@ -590,7 +590,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_intel_i460_pci_table[] __initdata = {
+static struct pci_device_id agp_intel_i460_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
diff -Nru a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
--- a/drivers/char/agp/intel-agp.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/char/agp/intel-agp.c	Fri Aug  1 12:19:02 2003
@@ -1417,7 +1417,7 @@
 	return 0;
 }
 
-static struct pci_device_id agp_intel_pci_table[] __initdata = {
+static struct pci_device_id agp_intel_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
diff -Nru a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
--- a/drivers/char/agp/nvidia-agp.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/char/agp/nvidia-agp.c	Fri Aug  1 12:19:02 2003
@@ -338,7 +338,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_nvidia_pci_table[] __initdata = {
+static struct pci_device_id agp_nvidia_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
diff -Nru a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
--- a/drivers/char/agp/sworks-agp.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/char/agp/sworks-agp.c	Fri Aug  1 12:19:02 2003
@@ -508,7 +508,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_serverworks_pci_table[] __initdata = {
+static struct pci_device_id agp_serverworks_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
diff -Nru a/drivers/char/epca.c b/drivers/char/epca.c
--- a/drivers/char/epca.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/char/epca.c	Fri Aug  1 12:19:02 2003
@@ -3945,7 +3945,7 @@
 }
 
 
-static struct pci_device_id epca_pci_tbl[] __initdata = {
+static struct pci_device_id epca_pci_tbl[] = {
 	{ PCI_VENDOR_DIGI, PCI_DEVICE_XR, PCI_ANY_ID, PCI_ANY_ID, 0, 0, brd_xr },
 	{ PCI_VENDOR_DIGI, PCI_DEVICE_XEM, PCI_ANY_ID, PCI_ANY_ID, 0, 0, brd_xem },
 	{ PCI_VENDOR_DIGI, PCI_DEVICE_CX, PCI_ANY_ID, PCI_ANY_ID, 0, 0, brd_cx },
diff -Nru a/drivers/char/synclink.c b/drivers/char/synclink.c
--- a/drivers/char/synclink.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/char/synclink.c	Fri Aug  1 12:19:02 2003
@@ -916,7 +916,7 @@
 				     const struct pci_device_id *ent);
 static void synclink_remove_one (struct pci_dev *dev);
 
-static struct pci_device_id synclink_pci_tbl[] __devinitdata = {
+static struct pci_device_id synclink_pci_tbl[] = {
 	{ PCI_VENDOR_ID_MICROGATE, PCI_DEVICE_ID_MICROGATE_USC, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_MICROGATE, 0x0210, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }, /* terminate list */
diff -Nru a/drivers/char/synclinkmp.c b/drivers/char/synclinkmp.c
--- a/drivers/char/synclinkmp.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/char/synclinkmp.c	Fri Aug  1 12:19:02 2003
@@ -501,7 +501,7 @@
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
 
-static struct pci_device_id synclinkmp_pci_tbl[] __devinitdata = {
+static struct pci_device_id synclinkmp_pci_tbl[] = {
 	{ PCI_VENDOR_ID_MICROGATE, PCI_DEVICE_ID_MICROGATE_SCA, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }, /* terminate list */
 };
diff -Nru a/drivers/char/watchdog/wdt_pci.c b/drivers/char/watchdog/wdt_pci.c
--- a/drivers/char/watchdog/wdt_pci.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/char/watchdog/wdt_pci.c	Fri Aug  1 12:19:02 2003
@@ -590,7 +590,7 @@
 }
 
 
-static struct pci_device_id wdtpci_pci_tbl[] __initdata = {
+static struct pci_device_id wdtpci_pci_tbl[] = {
 	{
 		.vendor	   = PCI_VENDOR_ID_ACCESSIO,
 		.device	   = PCI_DEVICE_ID_WDG_CSM,
diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/aty/aty128fb.c	Fri Aug  1 12:19:02 2003
@@ -148,7 +148,7 @@
 static void aty128_remove(struct pci_dev *pdev);
 
 /* supported Rage128 chipsets */
-static struct pci_device_id aty128_pci_tbl[] __devinitdata = {
+static struct pci_device_id aty128_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RE,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RF,
diff -Nru a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
--- a/drivers/video/chipsfb.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/chipsfb.c	Fri Aug  1 12:19:02 2003
@@ -446,7 +446,7 @@
 #endif /* CONFIG_PMAC_PBOOK */
 }
 
-static struct pci_device_id chipsfb_pci_tbl[] __devinitdata = {
+static struct pci_device_id chipsfb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CT, PCI_DEVICE_ID_CT_65550, PCI_ANY_ID, PCI_ANY_ID },
 	{ 0 }
 };
diff -Nru a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
--- a/drivers/video/console/sticore.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/console/sticore.c	Fri Aug  1 12:19:02 2003
@@ -1003,7 +1003,7 @@
 }
 
 
-static struct pci_device_id sti_pci_tbl[] __devinitdata = {
+static struct pci_device_id sti_pci_tbl[] = {
 	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_VISUALIZE_EG, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_VISUALIZE_FX6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_VISUALIZE_FX4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
diff -Nru a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
--- a/drivers/video/cyber2000fb.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/cyber2000fb.c	Fri Aug  1 12:19:02 2003
@@ -1683,7 +1683,7 @@
 	return 0;
 }
 
-static struct pci_device_id cyberpro_pci_table[] __devinitdata = {
+static struct pci_device_id cyberpro_pci_table[] = {
 //	Not yet
 //	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
 //		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
diff -Nru a/drivers/video/i810/i810_main.h b/drivers/video/i810/i810_main.h
--- a/drivers/video/i810/i810_main.h	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/i810/i810_main.h	Fri Aug  1 12:19:02 2003
@@ -24,7 +24,7 @@
 	"Intel(R) 815 (Internal Graphics with AGP) Framebuffer Device"  
 };
 
-static struct pci_device_id i810fb_pci_tbl[] __initdata = {
+static struct pci_device_id i810fb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG1, 
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, 
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG3,
diff -Nru a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
--- a/drivers/video/imsttfb.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/imsttfb.c	Fri Aug  1 12:19:02 2003
@@ -1316,7 +1316,7 @@
 	}
 }
 
-static struct pci_device_id imsttfb_pci_tbl[] __devinitdata = {
+static struct pci_device_id imsttfb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_IMS, PCI_DEVICE_ID_IMS_TT128,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IBM },
 	{ PCI_VENDOR_ID_IMS, PCI_DEVICE_ID_IMS_TT3D,
diff -Nru a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
--- a/drivers/video/matrox/matroxfb_base.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/matrox/matroxfb_base.c	Fri Aug  1 12:19:02 2003
@@ -2012,7 +2012,7 @@
 	matroxfb_remove(PMINFO 1);
 }
 
-static struct pci_device_id matroxfb_devices[] __devinitdata = {
+static struct pci_device_id matroxfb_devices[] = {
 #ifdef CONFIG_FB_MATROX_MILLENIUM
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/neofb.c	Fri Aug  1 12:19:02 2003
@@ -2065,7 +2065,7 @@
 	}
 }
 
-static struct pci_device_id neofb_devices[] __devinitdata = {
+static struct pci_device_id neofb_devices[] = {
 	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2070,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2070},
 
diff -Nru a/drivers/video/radeonfb.c b/drivers/video/radeonfb.c
--- a/drivers/video/radeonfb.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/radeonfb.c	Fri Aug  1 12:19:02 2003
@@ -185,7 +185,7 @@
 };
 
 
-static struct pci_device_id radeonfb_pci_table[] __devinitdata = {
+static struct pci_device_id radeonfb_pci_table[] = {
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QD},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QE},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QF},
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/riva/fbdev.c	Fri Aug  1 12:19:02 2003
@@ -193,7 +193,7 @@
 	{ "Quadro4-700-XGL", NV_ARCH_20 }
 };
 
-static struct pci_device_id rivafb_pci_tbl[] __initdata = {
+static struct pci_device_id rivafb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NVIDIA_SGS, PCI_DEVICE_ID_NVIDIA_SGS_RIVA128,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_128 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TNT,
diff -Nru a/drivers/video/sstfb.c b/drivers/video/sstfb.c
--- a/drivers/video/sstfb.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/sstfb.c	Fri Aug  1 12:19:02 2003
@@ -1554,7 +1554,7 @@
 }
 
 
-static struct pci_device_id sstfb_id_tbl[] __devinitdata = {
+static struct pci_device_id sstfb_id_tbl[] = {
 	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_VOODOO1 },
 	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO2,
diff -Nru a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/tdfxfb.c	Fri Aug  1 12:19:02 2003
@@ -128,7 +128,7 @@
 static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 static void tdfxfb_remove(struct pci_dev *pdev);
 
-static struct pci_device_id tdfxfb_id_table[] __devinitdata = {
+static struct pci_device_id tdfxfb_id_table[] = {
 	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  0xff0000, 0 },
diff -Nru a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	Fri Aug  1 12:19:02 2003
+++ b/drivers/video/tridentfb.c	Fri Aug  1 12:19:02 2003
@@ -1176,7 +1176,7 @@
 }
 
 /* List of boards that we are trying to support */
-static struct pci_device_id trident_devices[] __devinitdata = {
+static struct pci_device_id trident_devices[] = {
 	{PCI_VENDOR_ID_TRIDENT,	BLADE3D, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7D, PCI_ANY_ID,PCI_ANY_ID,0,0,0},

