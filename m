Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270862AbTHAToN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTHATim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:38:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:8895 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270859AbTHATc1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:32:27 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10597663161736@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test2
In-Reply-To: <10597663154132@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Aug 2003 12:31:56 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1547.10.3, 2003/07/31 16:07:35-07:00, greg@kroah.com

[PATCH] PCI: pci_device_id can not be marked __devinitdata.

Fixes up drivers/net/*


 drivers/net/3c59x.c                 |    2 +-
 drivers/net/8139cp.c                |    2 +-
 drivers/net/8139too.c               |    2 +-
 drivers/net/acenic.c                |    2 +-
 drivers/net/amd8111e.c              |    2 +-
 drivers/net/arcnet/com20020-pci.c   |    2 +-
 drivers/net/b44.c                   |    2 +-
 drivers/net/defxx.c                 |    2 +-
 drivers/net/dl2k.h                  |    2 +-
 drivers/net/e100/e100_main.c        |    2 +-
 drivers/net/e1000/e1000_main.c      |    2 +-
 drivers/net/eepro100.c              |    2 +-
 drivers/net/epic100.c               |    2 +-
 drivers/net/fealnx.c                |    2 +-
 drivers/net/hamachi.c               |    2 +-
 drivers/net/ioc3-eth.c              |    2 +-
 drivers/net/irda/donauboe.c         |    2 +-
 drivers/net/irda/toshoboe.c         |    2 +-
 drivers/net/irda/vlsi_ir.c          |    2 +-
 drivers/net/ixgb/ixgb_main.c        |    2 +-
 drivers/net/natsemi.c               |    2 +-
 drivers/net/ne2k-pci.c              |    2 +-
 drivers/net/ns83820.c               |    2 +-
 drivers/net/pci-skeleton.c          |    2 +-
 drivers/net/pcnet32.c               |    2 +-
 drivers/net/r8169.c                 |    2 +-
 drivers/net/rcpci45.c               |    2 +-
 drivers/net/rrunner.c               |    2 +-
 drivers/net/sis900.c                |    2 +-
 drivers/net/sk98lin/skge.c          |    2 +-
 drivers/net/starfire.c              |    2 +-
 drivers/net/sundance.c              |    2 +-
 drivers/net/sungem.c                |    2 +-
 drivers/net/sunhme.c                |    2 +-
 drivers/net/tc35815.c               |    2 +-
 drivers/net/tg3.c                   |    2 +-
 drivers/net/tlan.c                  |    2 +-
 drivers/net/tokenring/3c359.c       |    2 +-
 drivers/net/tokenring/abyss.c       |    2 +-
 drivers/net/tokenring/lanstreamer.c |    2 +-
 drivers/net/tokenring/olympic.c     |    2 +-
 drivers/net/tokenring/tmspci.c      |    2 +-
 drivers/net/tulip/de2104x.c         |    2 +-
 drivers/net/tulip/dmfe.c            |    2 +-
 drivers/net/tulip/tulip_core.c      |    2 +-
 drivers/net/tulip/winbond-840.c     |    2 +-
 drivers/net/tulip/xircom_cb.c       |    2 +-
 drivers/net/tulip/xircom_tulip_cb.c |    2 +-
 drivers/net/typhoon.c               |    2 +-
 drivers/net/via-rhine.c             |    2 +-
 drivers/net/wan/dscc4.c             |    2 +-
 drivers/net/wan/farsync.c           |    2 +-
 drivers/net/wan/lmc/lmc_main.c      |    2 +-
 drivers/net/wan/pc300_drv.c         |    2 +-
 drivers/net/wireless/airo.c         |    2 +-
 drivers/net/wireless/orinoco_pci.c  |    2 +-
 drivers/net/wireless/orinoco_plx.c  |    2 +-
 drivers/net/wireless/orinoco_tmd.c  |    2 +-
 drivers/net/yellowfin.c             |    2 +-
 59 files changed, 59 insertions(+), 59 deletions(-)


diff -Nru a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/3c59x.c	Fri Aug  1 12:18:47 2003
@@ -577,7 +577,7 @@
 };
 
 
-static struct pci_device_id vortex_pci_tbl[] __devinitdata = {
+static struct pci_device_id vortex_pci_tbl[] = {
 	{ 0x10B7, 0x5900, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C590 },
 	{ 0x10B7, 0x5920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C592 },
 	{ 0x10B7, 0x5970, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C597 },
diff -Nru a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/8139cp.c	Fri Aug  1 12:18:48 2003
@@ -415,7 +415,7 @@
 	{ "RTL-8169" },
 };
 
-static struct pci_device_id cp_pci_tbl[] __devinitdata = {
+static struct pci_device_id cp_pci_tbl[] = {
 	{ PCI_VENDOR_ID_REALTEK, PCI_DEVICE_ID_REALTEK_8139,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139Cp },
 #if 0
diff -Nru a/drivers/net/8139too.c b/drivers/net/8139too.c
--- a/drivers/net/8139too.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/8139too.c	Fri Aug  1 12:18:47 2003
@@ -248,7 +248,7 @@
 };
 
 
-static struct pci_device_id rtl8139_pci_tbl[] __devinitdata = {
+static struct pci_device_id rtl8139_pci_tbl[] = {
 	{0x10ec, 0x8139, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
 	{0x10ec, 0x8138, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139_CB },
 	{0x1113, 0x1211, PCI_ANY_ID, PCI_ANY_ID, 0, 0, SMC1211TX },
diff -Nru a/drivers/net/acenic.c b/drivers/net/acenic.c
--- a/drivers/net/acenic.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/acenic.c	Fri Aug  1 12:18:48 2003
@@ -132,7 +132,7 @@
 #endif
 
 #if LINUX_VERSION_CODE >= 0x20400
-static struct pci_device_id acenic_pci_tbl[] __initdata = {
+static struct pci_device_id acenic_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ALTEON, PCI_DEVICE_ID_ALTEON_ACENIC_FIBRE,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
 	{ PCI_VENDOR_ID_ALTEON, PCI_DEVICE_ID_ALTEON_ACENIC_COPPER,
diff -Nru a/drivers/net/amd8111e.c b/drivers/net/amd8111e.c
--- a/drivers/net/amd8111e.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/amd8111e.c	Fri Aug  1 12:18:48 2003
@@ -102,7 +102,7 @@
 MODULE_PARM(dynamic_ipg, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM_DESC(dynamic_ipg, "Enable or Disable dynamic IPG, 1: Enable, 0: Disable");
 
-static struct pci_device_id amd8111e_pci_tbl[] __devinitdata = {
+static struct pci_device_id amd8111e_pci_tbl[] = {
 		
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD8111E_7462,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
diff -Nru a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
--- a/drivers/net/arcnet/com20020-pci.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/arcnet/com20020-pci.c	Fri Aug  1 12:18:47 2003
@@ -139,7 +139,7 @@
 	com20020_remove(pci_get_drvdata(pdev));
 }
 
-static struct pci_device_id com20020pci_id_table[] __devinitdata = {
+static struct pci_device_id com20020pci_id_table[] = {
 	{ 0x1571, 0xa001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0x1571, 0xa002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0x1571, 0xa003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
diff -Nru a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/b44.c	Fri Aug  1 12:18:47 2003
@@ -89,7 +89,7 @@
 #define irqreturn_t void
 #endif
 
-static struct pci_device_id b44_pci_tbl[] __devinitdata = {
+static struct pci_device_id b44_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ }	/* terminate list with empty entry */
diff -Nru a/drivers/net/defxx.c b/drivers/net/defxx.c
--- a/drivers/net/defxx.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/defxx.c	Fri Aug  1 12:18:47 2003
@@ -3352,7 +3352,7 @@
 	pci_set_drvdata(pdev, NULL);
 }
 
-static struct pci_device_id dfx_pci_tbl[] __devinitdata = {
+static struct pci_device_id dfx_pci_tbl[] = {
 	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_FDDI, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }
 };
diff -Nru a/drivers/net/dl2k.h b/drivers/net/dl2k.h
--- a/drivers/net/dl2k.h	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/dl2k.h	Fri Aug  1 12:18:48 2003
@@ -695,7 +695,7 @@
         class_mask              of the class are honored during the comparison.
         driver_data             Data private to the driver.
 */
-static struct pci_device_id rio_pci_tbl[] __devinitdata = {
+static struct pci_device_id rio_pci_tbl[] = {
 	{0x1186, 0x4000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };
diff -Nru a/drivers/net/e100/e100_main.c b/drivers/net/e100/e100_main.c
--- a/drivers/net/e100/e100_main.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/e100/e100_main.c	Fri Aug  1 12:18:48 2003
@@ -759,7 +759,7 @@
 	--e100nics;
 }
 
-static struct pci_device_id e100_id_table[] __devinitdata = {
+static struct pci_device_id e100_id_table[] = {
 	{0x8086, 0x1229, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
 	{0x8086, 0x2449, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
 	{0x8086, 0x1059, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
diff -Nru a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/e1000/e1000_main.c	Fri Aug  1 12:18:47 2003
@@ -61,7 +61,7 @@
  * { Vendor ID, Device ID, SubVendor ID, SubDevice ID,
  *   Class, Class Mask, private data (not used) }
  */
-static struct pci_device_id e1000_pci_tbl[] __devinitdata = {
+static struct pci_device_id e1000_pci_tbl[] = {
 	{0x8086, 0x1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0x8086, 0x1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0x8086, 0x1004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
diff -Nru a/drivers/net/eepro100.c b/drivers/net/eepro100.c
--- a/drivers/net/eepro100.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/eepro100.c	Fri Aug  1 12:18:48 2003
@@ -2381,7 +2381,7 @@
 	kfree(dev);
 }
 
-static struct pci_device_id eepro100_pci_tbl[] __devinitdata = {
+static struct pci_device_id eepro100_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82557,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82559ER,
diff -Nru a/drivers/net/epic100.c b/drivers/net/epic100.c
--- a/drivers/net/epic100.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/epic100.c	Fri Aug  1 12:18:48 2003
@@ -242,7 +242,7 @@
 };
 
 
-static struct pci_device_id epic_pci_tbl[] __devinitdata = {
+static struct pci_device_id epic_pci_tbl[] = {
 	{ 0x10B8, 0x0005, 0x1092, 0x0AB4, 0, 0, SMSC_83C170_0 },
 	{ 0x10B8, 0x0005, PCI_ANY_ID, PCI_ANY_ID, 0, 0, SMSC_83C170 },
 	{ 0x10B8, 0x0006, PCI_ANY_ID, PCI_ANY_ID,
diff -Nru a/drivers/net/fealnx.c b/drivers/net/fealnx.c
--- a/drivers/net/fealnx.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/fealnx.c	Fri Aug  1 12:18:48 2003
@@ -1905,7 +1905,7 @@
 	return 0;
 }
 
-static struct pci_device_id fealnx_pci_tbl[] __devinitdata = {
+static struct pci_device_id fealnx_pci_tbl[] = {
 	{0x1516, 0x0800, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0x1516, 0x0803, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{0x1516, 0x0891, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
diff -Nru a/drivers/net/hamachi.c b/drivers/net/hamachi.c
--- a/drivers/net/hamachi.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/hamachi.c	Fri Aug  1 12:18:48 2003
@@ -1982,7 +1982,7 @@
 	}
 }
 
-static struct pci_device_id hamachi_pci_tbl[] __initdata = {
+static struct pci_device_id hamachi_pci_tbl[] = {
 	{ 0x1318, 0x0911, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }
 };
diff -Nru a/drivers/net/ioc3-eth.c b/drivers/net/ioc3-eth.c
--- a/drivers/net/ioc3-eth.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/ioc3-eth.c	Fri Aug  1 12:18:47 2003
@@ -1528,7 +1528,7 @@
 	kfree(dev);
 }
 
-static struct pci_device_id ioc3_pci_tbl[] __devinitdata = {
+static struct pci_device_id ioc3_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, PCI_ANY_ID, PCI_ANY_ID },
 	{ 0 }
 };
diff -Nru a/drivers/net/irda/donauboe.c b/drivers/net/irda/donauboe.c
--- a/drivers/net/irda/donauboe.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/irda/donauboe.c	Fri Aug  1 12:18:47 2003
@@ -189,7 +189,7 @@
 #define CONFIG0H_DMA_ON_NORX CONFIG0H_DMA_OFF| OBOE_CONFIG0H_ENDMAC
 #define CONFIG0H_DMA_ON CONFIG0H_DMA_ON_NORX | OBOE_CONFIG0H_ENRX
 
-static struct pci_device_id toshoboe_pci_tbl[] __initdata = {
+static struct pci_device_id toshoboe_pci_tbl[] = {
 	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIR701, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
 	{ }			/* Terminating entry */
diff -Nru a/drivers/net/irda/toshoboe.c b/drivers/net/irda/toshoboe.c
--- a/drivers/net/irda/toshoboe.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/irda/toshoboe.c	Fri Aug  1 12:18:47 2003
@@ -77,7 +77,7 @@
 
 #define PCI_DEVICE_ID_FIR701b  0x0d01
 
-static struct pci_device_id toshoboe_pci_tbl[] __initdata = {
+static struct pci_device_id toshoboe_pci_tbl[] = {
 	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIR701, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIR701b, PCI_ANY_ID, PCI_ANY_ID, },
 	{ }			/* Terminating entry */
diff -Nru a/drivers/net/irda/vlsi_ir.c b/drivers/net/irda/vlsi_ir.c
--- a/drivers/net/irda/vlsi_ir.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/irda/vlsi_ir.c	Fri Aug  1 12:18:47 2003
@@ -57,7 +57,7 @@
 
 #define PCI_CLASS_WIRELESS_IRDA 0x0d00
 
-static struct pci_device_id vlsi_irda_table [] __devinitdata = { {
+static struct pci_device_id vlsi_irda_table [] = { {
 
 	.class =        PCI_CLASS_WIRELESS_IRDA << 8,
 	.vendor =       PCI_VENDOR_ID_VLSI,
diff -Nru a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
--- a/drivers/net/ixgb/ixgb_main.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/ixgb/ixgb_main.c	Fri Aug  1 12:18:47 2003
@@ -44,7 +44,7 @@
  * { Vendor ID, Device ID, SubVendor ID, SubDevice ID,
  *   Class, Class Mask, String Index }
  */
-static struct pci_device_id ixgb_pci_tbl[] __devinitdata = {
+static struct pci_device_id ixgb_pci_tbl[] = {
 	/* Intel(R) PRO/10GbE Network Connection */
 	{INTEL_VENDOR_ID, IXGB_DEVICE_ID_82597EX,
 	 INTEL_SUBVENDOR_ID, IXGB_SUBDEVICE_ID_A11F, 0, 0, 0},
diff -Nru a/drivers/net/natsemi.c b/drivers/net/natsemi.c
--- a/drivers/net/natsemi.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/natsemi.c	Fri Aug  1 12:18:47 2003
@@ -366,7 +366,7 @@
 	{ "NatSemi DP8381[56]", PCI_IOTYPE },
 };
 
-static struct pci_device_id natsemi_pci_tbl[] __devinitdata = {
+static struct pci_device_id natsemi_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_83815, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
diff -Nru a/drivers/net/ne2k-pci.c b/drivers/net/ne2k-pci.c
--- a/drivers/net/ne2k-pci.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/ne2k-pci.c	Fri Aug  1 12:18:47 2003
@@ -136,7 +136,7 @@
 };
 
 
-static struct pci_device_id ne2k_pci_tbl[] __devinitdata = {
+static struct pci_device_id ne2k_pci_tbl[] = {
 	{ 0x10ec, 0x8029, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RealTek_RTL_8029 },
 	{ 0x1050, 0x0940, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_Winbond_89C940 },
 	{ 0x11f6, 0x1401, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_Compex_RL2000 },
diff -Nru a/drivers/net/ns83820.c b/drivers/net/ns83820.c
--- a/drivers/net/ns83820.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/ns83820.c	Fri Aug  1 12:18:48 2003
@@ -2061,7 +2061,7 @@
 	pci_set_drvdata(pci_dev, NULL);
 }
 
-static struct pci_device_id ns83820_pci_tbl[] __devinitdata = {
+static struct pci_device_id ns83820_pci_tbl[] = {
 	{ 0x100b, 0x0022, PCI_ANY_ID, PCI_ANY_ID, 0, .driver_data = 0, },
 	{ 0, },
 };
diff -Nru a/drivers/net/pci-skeleton.c b/drivers/net/pci-skeleton.c
--- a/drivers/net/pci-skeleton.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/pci-skeleton.c	Fri Aug  1 12:18:47 2003
@@ -212,7 +212,7 @@
 };
 
 
-static struct pci_device_id netdrv_pci_tbl[] __devinitdata = {
+static struct pci_device_id netdrv_pci_tbl[] = {
 	{0x10ec, 0x8139, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
 	{0x10ec, 0x8138, PCI_ANY_ID, PCI_ANY_ID, 0, 0, NETDRV_CB },
 	{0x1113, 0x1211, PCI_ANY_ID, PCI_ANY_ID, 0, 0, SMC1211TX },
diff -Nru a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
--- a/drivers/net/pcnet32.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/pcnet32.c	Fri Aug  1 12:18:47 2003
@@ -55,7 +55,7 @@
 /*
  * PCI device identifiers for "new style" Linux PCI Device Drivers
  */
-static struct pci_device_id pcnet32_pci_tbl[] __devinitdata = {
+static struct pci_device_id pcnet32_pci_tbl[] = {
     { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE_HOME, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
     { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
     { 0, }
diff -Nru a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/r8169.c	Fri Aug  1 12:18:48 2003
@@ -107,7 +107,7 @@
 	{
 "RealTek RTL8169 Gigabit Ethernet"},};
 
-static struct pci_device_id rtl8169_pci_tbl[] __devinitdata = {
+static struct pci_device_id rtl8169_pci_tbl[] = {
 	{0x10ec, 0x8169, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,},
 };
diff -Nru a/drivers/net/rcpci45.c b/drivers/net/rcpci45.c
--- a/drivers/net/rcpci45.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/rcpci45.c	Fri Aug  1 12:18:48 2003
@@ -118,7 +118,7 @@
 static void RCreboot_callback (U32, U32, U32, struct net_device *);
 static int RC_allocate_and_post_buffers (struct net_device *, int);
 
-static struct pci_device_id rcpci45_pci_table[] __devinitdata = {
+static struct pci_device_id rcpci45_pci_table[] = {
 	{ PCI_VENDOR_ID_REDCREEK, PCI_DEVICE_ID_RC45, PCI_ANY_ID, PCI_ANY_ID,},
 	{}
 };
diff -Nru a/drivers/net/rrunner.c b/drivers/net/rrunner.c
--- a/drivers/net/rrunner.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/rrunner.c	Fri Aug  1 12:18:47 2003
@@ -1716,7 +1716,7 @@
 	}
 }
 
-static struct pci_device_id rr_pci_tbl[] __devinitdata = {
+static struct pci_device_id rr_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ESSENTIAL, PCI_DEVICE_ID_ESSENTIAL_ROADRUNNER,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0,}
diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/sis900.c	Fri Aug  1 12:18:47 2003
@@ -97,7 +97,7 @@
 	"SiS 900 PCI Fast Ethernet",
 	"SiS 7016 PCI Fast Ethernet"
 };
-static struct pci_device_id sis900_pci_tbl [] __devinitdata = {
+static struct pci_device_id sis900_pci_tbl [] = {
 	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_900,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SIS_900},
 	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7016,
diff -Nru a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
--- a/drivers/net/sk98lin/skge.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/sk98lin/skge.c	Fri Aug  1 12:18:47 2003
@@ -4032,7 +4032,7 @@
 
 #endif /* DEBUG */
 
-static struct pci_device_id skge_pci_tbl[] __devinitdata = {
+static struct pci_device_id skge_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SYSKONNECT, PCI_DEVICE_ID_SYSKONNECT_GE,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0,}
diff -Nru a/drivers/net/starfire.c b/drivers/net/starfire.c
--- a/drivers/net/starfire.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/starfire.c	Fri Aug  1 12:18:47 2003
@@ -487,7 +487,7 @@
 	CH_6915 = 0,
 };
 
-static struct pci_device_id starfire_pci_tbl[] __devinitdata = {
+static struct pci_device_id starfire_pci_tbl[] = {
 	{ 0x9004, 0x6915, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_6915 },
 	{ 0, }
 };
diff -Nru a/drivers/net/sundance.c b/drivers/net/sundance.c
--- a/drivers/net/sundance.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/sundance.c	Fri Aug  1 12:18:48 2003
@@ -284,7 +284,7 @@
 #define USE_IO_OPS 1
 #endif
 
-static struct pci_device_id sundance_pci_tbl[] __devinitdata = {
+static struct pci_device_id sundance_pci_tbl[] = {
 	{0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0},
 	{0x1186, 0x1002, 0x1186, 0x1003, 0, 0, 1},
 	{0x1186, 0x1002, 0x1186, 0x1012, 0, 0, 2},
diff -Nru a/drivers/net/sungem.c b/drivers/net/sungem.c
--- a/drivers/net/sungem.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/sungem.c	Fri Aug  1 12:18:48 2003
@@ -84,7 +84,7 @@
 #define GEM_MODULE_NAME	"gem"
 #define PFX GEM_MODULE_NAME ": "
 
-static struct pci_device_id gem_pci_tbl[] __devinitdata = {
+static struct pci_device_id gem_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_GEM,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 
diff -Nru a/drivers/net/sunhme.c b/drivers/net/sunhme.c
--- a/drivers/net/sunhme.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/sunhme.c	Fri Aug  1 12:18:47 2003
@@ -177,7 +177,7 @@
 /* This happy_pci_ids is declared __initdata because it is only used
    as an advisory to depmod.  If this is ported to the new PCI interface
    where it could be referenced at any time due to hot plugging,
-   it should be changed to __devinitdata. */
+   the __initdata reference should be removed. */
 
 struct pci_device_id happymeal_pci_ids[] __initdata = {
 	{
diff -Nru a/drivers/net/tc35815.c b/drivers/net/tc35815.c
--- a/drivers/net/tc35815.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/tc35815.c	Fri Aug  1 12:18:47 2003
@@ -469,7 +469,7 @@
 /*
  * PCI device identifiers for "new style" Linux PCI Device Drivers
  */
-static struct pci_device_id tc35815_pci_tbl[] __devinitdata = {
+static struct pci_device_id tc35815_pci_tbl[] = {
     { PCI_VENDOR_ID_TOSHIBA_2, PCI_DEVICE_ID_TOSHIBA_TC35815CF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
     { 0, }
 };
diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/tg3.c	Fri Aug  1 12:18:48 2003
@@ -127,7 +127,7 @@
 
 static int tg3_debug = -1;	/* -1 == use TG3_DEF_MSG_ENABLE as value */
 
-static struct pci_device_id tg3_pci_tbl[] __devinitdata = {
+static struct pci_device_id tg3_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5701,
diff -Nru a/drivers/net/tlan.c b/drivers/net/tlan.c
--- a/drivers/net/tlan.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/tlan.c	Fri Aug  1 12:18:47 2003
@@ -252,7 +252,7 @@
 	{ "Compaq NetFlex-3/E", TLAN_ADAPTER_ACTIVITY_LED, 0x83 }, /* EISA card */
 };
 
-static struct pci_device_id tlan_pci_tbl[] __devinitdata = {
+static struct pci_device_id tlan_pci_tbl[] = {
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL10,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100,
diff -Nru a/drivers/net/tokenring/3c359.c b/drivers/net/tokenring/3c359.c
--- a/drivers/net/tokenring/3c359.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/tokenring/3c359.c	Fri Aug  1 12:18:48 2003
@@ -116,7 +116,7 @@
 
 #include "3c359_microcode.h" 
 
-static struct pci_device_id xl_pci_tbl[] __devinitdata =
+static struct pci_device_id xl_pci_tbl[] =
 {
 	{PCI_VENDOR_ID_3COM,PCI_DEVICE_ID_3COM_3C359, PCI_ANY_ID, PCI_ANY_ID, },
 	{ }			/* terminate list */
diff -Nru a/drivers/net/tokenring/abyss.c b/drivers/net/tokenring/abyss.c
--- a/drivers/net/tokenring/abyss.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/tokenring/abyss.c	Fri Aug  1 12:18:47 2003
@@ -45,7 +45,7 @@
 
 #define ABYSS_IO_EXTENT 64
 
-static struct pci_device_id abyss_pci_tbl[] __initdata = {
+static struct pci_device_id abyss_pci_tbl[] = {
 	{ PCI_VENDOR_ID_MADGE, PCI_DEVICE_ID_MADGE_MK2,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_TOKEN_RING << 8, 0x00ffffff, },
 	{ }			/* Terminating entry */
diff -Nru a/drivers/net/tokenring/lanstreamer.c b/drivers/net/tokenring/lanstreamer.c
--- a/drivers/net/tokenring/lanstreamer.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/tokenring/lanstreamer.c	Fri Aug  1 12:18:48 2003
@@ -140,7 +140,7 @@
 static char version[] = "LanStreamer.c v0.4.0 03/08/01 - Mike Sullivan\n"
                         "              v0.5.3 11/13/02 - Kent Yoder";
 
-static struct pci_device_id streamer_pci_tbl[] __initdata = {
+static struct pci_device_id streamer_pci_tbl[] = {
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_TR, PCI_ANY_ID, PCI_ANY_ID,},
 	{}	/* terminating entry */
 };
diff -Nru a/drivers/net/tokenring/olympic.c b/drivers/net/tokenring/olympic.c
--- a/drivers/net/tokenring/olympic.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/tokenring/olympic.c	Fri Aug  1 12:18:48 2003
@@ -171,7 +171,7 @@
 static int network_monitor[OLYMPIC_MAX_ADAPTERS] = {0,};
 MODULE_PARM(network_monitor, "1-" __MODULE_STRING(OLYMPIC_MAX_ADAPTERS) "i");
 
-static struct pci_device_id olympic_pci_tbl[] __devinitdata = {
+static struct pci_device_id olympic_pci_tbl[] = {
 	{PCI_VENDOR_ID_IBM,PCI_DEVICE_ID_IBM_TR_WAKE,PCI_ANY_ID,PCI_ANY_ID,},
 	{ } 	/* Terminating Entry */
 };
diff -Nru a/drivers/net/tokenring/tmspci.c b/drivers/net/tokenring/tmspci.c
--- a/drivers/net/tokenring/tmspci.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/tokenring/tmspci.c	Fri Aug  1 12:18:48 2003
@@ -57,7 +57,7 @@
 	{ {0x03, 0x01}, "3Com Token Link Velocity"},
 };
 
-static struct pci_device_id tmspci_pci_tbl[] __initdata = {
+static struct pci_device_id tmspci_pci_tbl[] = {
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TOKENRING, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_SYSKONNECT, PCI_DEVICE_ID_SYSKONNECT_TR, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
 	{ PCI_VENDOR_ID_TCONRAD, PCI_DEVICE_ID_TCONRAD_TOKENRING, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
diff -Nru a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
--- a/drivers/net/tulip/de2104x.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/tulip/de2104x.c	Fri Aug  1 12:18:48 2003
@@ -329,7 +329,7 @@
 static unsigned int de_ok_to_advertise (struct de_private *de, u32 new_media);
 
 
-static struct pci_device_id de_pci_tbl[] __initdata = {
+static struct pci_device_id de_pci_tbl[] = {
 	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TULIP,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TULIP_PLUS,
diff -Nru a/drivers/net/tulip/dmfe.c b/drivers/net/tulip/dmfe.c
--- a/drivers/net/tulip/dmfe.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/tulip/dmfe.c	Fri Aug  1 12:18:48 2003
@@ -1975,7 +1975,7 @@
 
 
 
-static struct pci_device_id dmfe_pci_tbl[] __devinitdata = {
+static struct pci_device_id dmfe_pci_tbl[] = {
 	{ 0x1282, 0x9132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9132_ID },
 	{ 0x1282, 0x9102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9102_ID },
 	{ 0x1282, 0x9100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9100_ID },
diff -Nru a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
--- a/drivers/net/tulip/tulip_core.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/tulip/tulip_core.c	Fri Aug  1 12:18:48 2003
@@ -194,7 +194,7 @@
 };
 
 
-static struct pci_device_id tulip_pci_tbl[] __devinitdata = {
+static struct pci_device_id tulip_pci_tbl[] = {
 	{ 0x1011, 0x0009, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DC21140 },
 	{ 0x1011, 0x0019, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DC21143 },
 	{ 0x11AD, 0x0002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, LC82C168 },
diff -Nru a/drivers/net/tulip/winbond-840.c b/drivers/net/tulip/winbond-840.c
--- a/drivers/net/tulip/winbond-840.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/tulip/winbond-840.c	Fri Aug  1 12:18:47 2003
@@ -234,7 +234,7 @@
 #define W840_FLAGS (PCI_USES_MEM | PCI_ADDR1 | PCI_USES_MASTER)
 #endif
 
-static struct pci_device_id w840_pci_tbl[] __devinitdata = {
+static struct pci_device_id w840_pci_tbl[] = {
 	{ 0x1050, 0x0840, PCI_ANY_ID, 0x8153,     0, 0, 0 },
 	{ 0x1050, 0x0840, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
 	{ 0x11f6, 0x2011, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
diff -Nru a/drivers/net/tulip/xircom_cb.c b/drivers/net/tulip/xircom_cb.c
--- a/drivers/net/tulip/xircom_cb.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/tulip/xircom_cb.c	Fri Aug  1 12:18:48 2003
@@ -140,7 +140,7 @@
 
 
 
-static struct pci_device_id xircom_pci_table[] __devinitdata = {
+static struct pci_device_id xircom_pci_table[] = {
 	{0x115D, 0x0003, PCI_ANY_ID, PCI_ANY_ID,},
 	{0,},
 };
diff -Nru a/drivers/net/tulip/xircom_tulip_cb.c b/drivers/net/tulip/xircom_tulip_cb.c
--- a/drivers/net/tulip/xircom_tulip_cb.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/tulip/xircom_tulip_cb.c	Fri Aug  1 12:18:47 2003
@@ -1654,7 +1654,7 @@
 }
 
 
-static struct pci_device_id xircom_pci_table[] __devinitdata = {
+static struct pci_device_id xircom_pci_table[] = {
   { 0x115D, 0x0003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, X3201_3 },
   {0},
 };
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/typhoon.c	Fri Aug  1 12:18:48 2003
@@ -192,7 +192,7 @@
  * bit 8 indicates if this is a (0) copper or (1) fiber card
  * bits 12-16 indicate card type: (0) client and (1) server
  */
-static struct pci_device_id typhoon_pci_tbl[] __devinitdata = {
+static struct pci_device_id typhoon_pci_tbl[] = {
 	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,TYPHOON_TX },
 	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990_TX_95,
diff -Nru a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/via-rhine.c	Fri Aug  1 12:18:48 2003
@@ -401,7 +401,7 @@
 	  CanHaveMII | HasWOL },
 };
 
-static struct pci_device_id via_rhine_pci_tbl[] __devinitdata =
+static struct pci_device_id via_rhine_pci_tbl[] =
 {
 	{0x1106, 0x3043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT86C100A},
 	{0x1106, 0x3065, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6102},
diff -Nru a/drivers/net/wan/dscc4.c b/drivers/net/wan/dscc4.c
--- a/drivers/net/wan/dscc4.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/wan/dscc4.c	Fri Aug  1 12:18:47 2003
@@ -1867,7 +1867,7 @@
 
 __setup("dscc4.setup=", dscc4_setup);
 
-static struct pci_device_id dscc4_pci_tbl[] __devinitdata = {
+static struct pci_device_id dscc4_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SIEMENS, PCI_DEVICE_ID_SIEMENS_DSCC4,
 	        PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0,}
diff -Nru a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
--- a/drivers/net/wan/farsync.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/wan/farsync.c	Fri Aug  1 12:18:48 2003
@@ -414,7 +414,7 @@
 /*
  *      PCI ID lookup table
  */
-static struct pci_device_id fst_pci_dev_id[] __devinitdata = {
+static struct pci_device_id fst_pci_dev_id[] = {
         { FSC_PCI_VENDOR_ID, T2P_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
                                         FST_TYPE_T2P },
         { FSC_PCI_VENDOR_ID, T4P_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
diff -Nru a/drivers/net/wan/lmc/lmc_main.c b/drivers/net/wan/lmc/lmc_main.c
--- a/drivers/net/wan/lmc/lmc_main.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/wan/lmc/lmc_main.c	Fri Aug  1 12:18:47 2003
@@ -88,7 +88,7 @@
 int LMC_PKT_BUF_SZ = 1542;
 
 #ifdef MODULE
-static struct pci_device_id lmc_pci_tbl[] __devinitdata = {
+static struct pci_device_id lmc_pci_tbl[] = {
     { 0x1011, 0x009, 0x1379, PCI_ANY_ID, 0, 0, 0},
     { 0, }
 };
diff -Nru a/drivers/net/wan/pc300_drv.c b/drivers/net/wan/pc300_drv.c
--- a/drivers/net/wan/pc300_drv.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/wan/pc300_drv.c	Fri Aug  1 12:18:48 2003
@@ -253,7 +253,7 @@
 #undef	PC300_DEBUG_RX
 #undef	PC300_DEBUG_OTHER
 
-static struct pci_device_id cpc_pci_dev_id[] __devinitdata = {
+static struct pci_device_id cpc_pci_dev_id[] = {
 	/* PC300/RSV or PC300/X21, 2 chan */
 	{0x120e, 0x300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0x300},
 	/* PC300/RSV or PC300/X21, 1 chan */
diff -Nru a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
--- a/drivers/net/wireless/airo.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/wireless/airo.c	Fri Aug  1 12:18:47 2003
@@ -47,7 +47,7 @@
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_PCI
-static struct pci_device_id card_ids[] __devinitdata = {
+static struct pci_device_id card_ids[] = {
 	{ 0x14b9, 1, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0x14b9, 0x4500, PCI_ANY_ID, PCI_ANY_ID },
 	{ 0x14b9, 0x4800, PCI_ANY_ID, PCI_ANY_ID, },
diff -Nru a/drivers/net/wireless/orinoco_pci.c b/drivers/net/wireless/orinoco_pci.c
--- a/drivers/net/wireless/orinoco_pci.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/wireless/orinoco_pci.c	Fri Aug  1 12:18:48 2003
@@ -359,7 +359,7 @@
 	return 0;
 }
 
-static struct pci_device_id orinoco_pci_pci_id_table[] __devinitdata = {
+static struct pci_device_id orinoco_pci_pci_id_table[] = {
 	{0x1260, 0x3873, PCI_ANY_ID, PCI_ANY_ID,},
 	{0,},
 };
diff -Nru a/drivers/net/wireless/orinoco_plx.c b/drivers/net/wireless/orinoco_plx.c
--- a/drivers/net/wireless/orinoco_plx.c	Fri Aug  1 12:18:48 2003
+++ b/drivers/net/wireless/orinoco_plx.c	Fri Aug  1 12:18:48 2003
@@ -299,7 +299,7 @@
 }
 
 
-static struct pci_device_id orinoco_plx_pci_id_table[] __devinitdata = {
+static struct pci_device_id orinoco_plx_pci_id_table[] = {
 	{0x111a, 0x1023, PCI_ANY_ID, PCI_ANY_ID,},	/* Siemens SpeedStream SS1023 */
 	{0x1385, 0x4100, PCI_ANY_ID, PCI_ANY_ID,},	/* Netgear MA301 */
 	{0x15e8, 0x0130, PCI_ANY_ID, PCI_ANY_ID,},	/* Correga  - does this work? */
diff -Nru a/drivers/net/wireless/orinoco_tmd.c b/drivers/net/wireless/orinoco_tmd.c
--- a/drivers/net/wireless/orinoco_tmd.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/wireless/orinoco_tmd.c	Fri Aug  1 12:18:47 2003
@@ -190,7 +190,7 @@
 }
 
 
-static struct pci_device_id orinoco_tmd_pci_id_table[] __devinitdata = {
+static struct pci_device_id orinoco_tmd_pci_id_table[] = {
 	{0x15e8, 0x0131, PCI_ANY_ID, PCI_ANY_ID,},      /* NDC and OEMs, e.g. pheecom */
 	{0,},
 };
diff -Nru a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
--- a/drivers/net/yellowfin.c	Fri Aug  1 12:18:47 2003
+++ b/drivers/net/yellowfin.c	Fri Aug  1 12:18:47 2003
@@ -295,7 +295,7 @@
 	{0,},
 };
 
-static struct pci_device_id yellowfin_pci_tbl[] __devinitdata = {
+static struct pci_device_id yellowfin_pci_tbl[] = {
 	{ 0x1000, 0x0702, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0x1000, 0x0701, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
 	{ 0, }

