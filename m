Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWHGEcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWHGEcE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 00:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWHGEcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 00:32:04 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:56994 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751016AbWHGEcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 00:32:02 -0400
From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Replace last instances of pci_module_init with pci_register_driver
Date: Mon, 07 Aug 2006 00:31:54 -0400
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060807043154.7901.74081.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Roskin <proski@gnu.org>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 drivers/char/ipmi/ipmi_si_intf.c              |    2 +-
 drivers/net/3c59x.c                           |    2 +-
 drivers/net/8139cp.c                          |    2 +-
 drivers/net/8139too.c                         |    2 +-
 drivers/net/acenic.c                          |    2 +-
 drivers/net/amd8111e.c                        |    2 +-
 drivers/net/arcnet/com20020-pci.c             |    2 +-
 drivers/net/b44.c                             |    2 +-
 drivers/net/bnx2.c                            |    2 +-
 drivers/net/cassini.c                         |    2 +-
 drivers/net/chelsio/cxgb2.c                   |    2 +-
 drivers/net/defxx.c                           |    2 +-
 drivers/net/dl2k.c                            |    2 +-
 drivers/net/e100.c                            |    2 +-
 drivers/net/e1000/e1000_main.c                |    2 +-
 drivers/net/eepro100.c                        |    2 +-
 drivers/net/epic100.c                         |    2 +-
 drivers/net/fealnx.c                          |    2 +-
 drivers/net/forcedeth.c                       |    2 +-
 drivers/net/hp100.c                           |    2 +-
 drivers/net/ixgb/ixgb_main.c                  |    2 +-
 drivers/net/natsemi.c                         |    2 +-
 drivers/net/ne2k-pci.c                        |    2 +-
 drivers/net/ns83820.c                         |    2 +-
 drivers/net/pci-skeleton.c                    |    2 +-
 drivers/net/pcnet32.c                         |    2 +-
 drivers/net/r8169.c                           |    2 +-
 drivers/net/rrunner.c                         |    2 +-
 drivers/net/s2io.c                            |    2 +-
 drivers/net/saa9730.c                         |    2 +-
 drivers/net/sis190.c                          |    2 +-
 drivers/net/sis900.c                          |    2 +-
 drivers/net/sk98lin/skge.c                    |    2 +-
 drivers/net/skfp/skfddi.c                     |    2 +-
 drivers/net/skge.c                            |    2 +-
 drivers/net/starfire.c                        |    2 +-
 drivers/net/sundance.c                        |    2 +-
 drivers/net/sungem.c                          |    2 +-
 drivers/net/tc35815.c                         |    2 +-
 drivers/net/tg3.c                             |    2 +-
 drivers/net/tokenring/3c359.c                 |    2 +-
 drivers/net/tokenring/lanstreamer.c           |    2 +-
 drivers/net/tokenring/olympic.c               |    2 +-
 drivers/net/tulip/de2104x.c                   |    2 +-
 drivers/net/tulip/de4x5.c                     |    2 +-
 drivers/net/tulip/dmfe.c                      |    2 +-
 drivers/net/tulip/tulip_core.c                |    2 +-
 drivers/net/tulip/uli526x.c                   |    2 +-
 drivers/net/tulip/winbond-840.c               |    2 +-
 drivers/net/tulip/xircom_tulip_cb.c           |    2 +-
 drivers/net/typhoon.c                         |    2 +-
 drivers/net/via-rhine.c                       |    2 +-
 drivers/net/via-velocity.c                    |    2 +-
 drivers/net/wan/dscc4.c                       |    2 +-
 drivers/net/wan/farsync.c                     |    2 +-
 drivers/net/wan/lmc/lmc_main.c                |    2 +-
 drivers/net/wan/pc300_drv.c                   |    2 +-
 drivers/net/wan/pci200syn.c                   |    2 +-
 drivers/net/wan/wanxl.c                       |    2 +-
 drivers/net/wireless/atmel_pci.c              |    2 +-
 drivers/net/wireless/ipw2100.c                |    2 +-
 drivers/net/wireless/ipw2200.c                |    2 +-
 drivers/net/wireless/orinoco_nortel.c         |    2 +-
 drivers/net/wireless/orinoco_pci.c            |    2 +-
 drivers/net/wireless/orinoco_plx.c            |    2 +-
 drivers/net/wireless/orinoco_tmd.c            |    2 +-
 drivers/net/wireless/prism54/islpci_hotplug.c |    2 +-
 drivers/net/yellowfin.c                       |    2 +-
 drivers/scsi/3w-9xxx.c                        |    2 +-
 drivers/scsi/3w-xxxx.c                        |    2 +-
 drivers/scsi/a100u2w.c                        |    2 +-
 drivers/scsi/ahci.c                           |    2 +-
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c        |    2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c        |    2 +-
 drivers/scsi/ata_piix.c                       |    4 ++--
 drivers/scsi/dc395x.c                         |    2 +-
 drivers/scsi/dmx3191d.c                       |    2 +-
 drivers/scsi/ipr.c                            |    2 +-
 drivers/scsi/ips.c                            |    2 +-
 drivers/scsi/megaraid.c                       |    2 +-
 drivers/scsi/megaraid/megaraid_sas.c          |    2 +-
 drivers/scsi/nsp32.c                          |    2 +-
 drivers/scsi/pdc_adma.c                       |    2 +-
 drivers/scsi/qla1280.c                        |    2 +-
 drivers/scsi/sata_mv.c                        |    2 +-
 drivers/scsi/sata_nv.c                        |    2 +-
 drivers/scsi/sata_promise.c                   |    2 +-
 drivers/scsi/sata_qstor.c                     |    2 +-
 drivers/scsi/sata_sil.c                       |    2 +-
 drivers/scsi/sata_sil24.c                     |    2 +-
 drivers/scsi/sata_sis.c                       |    2 +-
 drivers/scsi/sata_svw.c                       |    2 +-
 drivers/scsi/sata_sx4.c                       |    2 +-
 drivers/scsi/sata_uli.c                       |    2 +-
 drivers/scsi/sata_via.c                       |    2 +-
 drivers/scsi/sata_vsc.c                       |    2 +-
 drivers/scsi/tmscsim.c                        |    2 +-
 include/linux/pci.h                           |    6 ------
 98 files changed, 98 insertions(+), 104 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index f57eba0..f1144fa 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2461,7 +2461,7 @@ #ifdef CONFIG_ACPI
 #endif
 
 #ifdef CONFIG_PCI
-	pci_module_init(&ipmi_pci_driver);
+	pci_register_driver(&ipmi_pci_driver);
 #endif
 
 	if (si_trydefaults) {
diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
index 80e8ca0..7c23813 100644
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -3169,7 +3169,7 @@ static int __init vortex_init(void)
 {
 	int pci_rc, eisa_rc;
 
-	pci_rc = pci_module_init(&vortex_driver);
+	pci_rc = pci_register_driver(&vortex_driver);
 	eisa_rc = vortex_eisa_init();
 
 	if (pci_rc == 0)
diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
index 1428bb7..7061a23 100644
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -2098,7 +2098,7 @@ static int __init cp_init (void)
 #ifdef MODULE
 	printk("%s", version);
 #endif
-	return pci_module_init (&cp_driver);
+	return pci_register_driver (&cp_driver);
 }
 
 static void __exit cp_exit (void)
diff --git a/drivers/net/8139too.c b/drivers/net/8139too.c
index e4f4eaf..0b58725 100644
--- a/drivers/net/8139too.c
+++ b/drivers/net/8139too.c
@@ -2629,7 +2629,7 @@ #ifdef MODULE
 	printk (KERN_INFO RTL8139_DRIVER_NAME "\n");
 #endif
 
-	return pci_module_init (&rtl8139_pci_driver);
+	return pci_register_driver (&rtl8139_pci_driver);
 }
 
 
diff --git a/drivers/net/acenic.c b/drivers/net/acenic.c
index 1c01e9b..c0f3574 100644
--- a/drivers/net/acenic.c
+++ b/drivers/net/acenic.c
@@ -725,7 +725,7 @@ static struct pci_driver acenic_pci_driv
 
 static int __init acenic_init(void)
 {
-	return pci_module_init(&acenic_pci_driver);
+	return pci_register_driver(&acenic_pci_driver);
 }
 
 static void __exit acenic_exit(void)
diff --git a/drivers/net/amd8111e.c b/drivers/net/amd8111e.c
index ed322a7..2ef8e55 100644
--- a/drivers/net/amd8111e.c
+++ b/drivers/net/amd8111e.c
@@ -2158,7 +2158,7 @@ static struct pci_driver amd8111e_driver
 
 static int __init amd8111e_init(void)
 {
-	return pci_module_init(&amd8111e_driver);
+	return pci_register_driver(&amd8111e_driver);
 }
 
 static void __exit amd8111e_cleanup(void)
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 979a33d..fc256c1 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -177,7 +177,7 @@ static struct pci_driver com20020pci_dri
 static int __init com20020pci_init(void)
 {
 	BUGLVL(D_NORMAL) printk(VERSION);
-	return pci_module_init(&com20020pci_driver);
+	return pci_register_driver(&com20020pci_driver);
 }
 
 static void __exit com20020pci_cleanup(void)
diff --git a/drivers/net/b44.c b/drivers/net/b44.c
index bea0fc0..17eb291 100644
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -2354,7 +2354,7 @@ static int __init b44_init(void)
 	dma_desc_align_mask = ~(dma_desc_align_size - 1);
 	dma_desc_sync_size = max_t(unsigned int, dma_desc_align_size, sizeof(struct dma_desc));
 
-	return pci_module_init(&b44_driver);
+	return pci_register_driver(&b44_driver);
 }
 
 static void __exit b44_cleanup(void)
diff --git a/drivers/net/bnx2.c b/drivers/net/bnx2.c
index db73de0..75511b0 100644
--- a/drivers/net/bnx2.c
+++ b/drivers/net/bnx2.c
@@ -6015,7 +6015,7 @@ static struct pci_driver bnx2_pci_driver
 
 static int __init bnx2_init(void)
 {
-	return pci_module_init(&bnx2_pci_driver);
+	return pci_register_driver(&bnx2_pci_driver);
 }
 
 static void __exit bnx2_cleanup(void)
diff --git a/drivers/net/cassini.c b/drivers/net/cassini.c
index a31544c..26040ab 100644
--- a/drivers/net/cassini.c
+++ b/drivers/net/cassini.c
@@ -5245,7 +5245,7 @@ static int __init cas_init(void)
 	else
 		link_transition_timeout = 0;
 
-	return pci_module_init(&cas_driver);
+	return pci_register_driver(&cas_driver);
 }
 
 static void __exit cas_cleanup(void)
diff --git a/drivers/net/chelsio/cxgb2.c b/drivers/net/chelsio/cxgb2.c
index e678724..b6de184 100644
--- a/drivers/net/chelsio/cxgb2.c
+++ b/drivers/net/chelsio/cxgb2.c
@@ -1243,7 +1243,7 @@ static struct pci_driver driver = {
 
 static int __init t1_init_module(void)
 {
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit t1_cleanup_module(void)
diff --git a/drivers/net/defxx.c b/drivers/net/defxx.c
index 91cc8cb..7d06ded 100644
--- a/drivers/net/defxx.c
+++ b/drivers/net/defxx.c
@@ -3444,7 +3444,7 @@ static int __init dfx_init(void)
 {
 	int rc_pci, rc_eisa;
 
-	rc_pci = pci_module_init(&dfx_driver);
+	rc_pci = pci_register_driver(&dfx_driver);
 	if (rc_pci >= 0) dfx_have_pci = 1;
 	
 	rc_eisa = dfx_eisa_init();
diff --git a/drivers/net/dl2k.c b/drivers/net/dl2k.c
index 402961e..e8d4623 100644
--- a/drivers/net/dl2k.c
+++ b/drivers/net/dl2k.c
@@ -1815,7 +1815,7 @@ static struct pci_driver rio_driver = {
 static int __init
 rio_init (void)
 {
-	return pci_module_init (&rio_driver);
+	return pci_register_driver (&rio_driver);
 }
 
 static void __exit
diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index 91ef5f2..5f68cb8 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -2873,7 +2873,7 @@ static int __init e100_init_module(void)
 		printk(KERN_INFO PFX "%s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
 		printk(KERN_INFO PFX "%s\n", DRV_COPYRIGHT);
 	}
-	return pci_module_init(&e100_driver);
+	return pci_register_driver(&e100_driver);
 }
 
 static void __exit e100_cleanup_module(void)
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 627f224..62ddc37 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -245,7 +245,7 @@ e1000_init_module(void)
 
 	printk(KERN_INFO "%s\n", e1000_copyright);
 
-	ret = pci_module_init(&e1000_driver);
+	ret = pci_register_driver(&e1000_driver);
 
 	return ret;
 }
diff --git a/drivers/net/eepro100.c b/drivers/net/eepro100.c
index e445988..a3d515d 100644
--- a/drivers/net/eepro100.c
+++ b/drivers/net/eepro100.c
@@ -2385,7 +2385,7 @@ static int __init eepro100_init_module(v
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&eepro100_driver);
+	return pci_register_driver(&eepro100_driver);
 }
 
 static void __exit eepro100_cleanup_module(void)
diff --git a/drivers/net/epic100.c b/drivers/net/epic100.c
index a67650c..55929a3 100644
--- a/drivers/net/epic100.c
+++ b/drivers/net/epic100.c
@@ -1604,7 +1604,7 @@ #ifdef MODULE
 		version, version2, version3);
 #endif
 
-	return pci_module_init (&epic_driver);
+	return pci_register_driver (&epic_driver);
 }
 
 
diff --git a/drivers/net/fealnx.c b/drivers/net/fealnx.c
index 97d34fe..efd86c1 100644
--- a/drivers/net/fealnx.c
+++ b/drivers/net/fealnx.c
@@ -1984,7 +1984,7 @@ #ifdef MODULE
 	printk(version);
 #endif
 
-	return pci_module_init(&fealnx_driver);
+	return pci_register_driver(&fealnx_driver);
 }
 
 static void __exit fealnx_exit(void)
diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index 11b8f1b..ab7993a 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -4540,7 +4540,7 @@ static struct pci_driver driver = {
 static int __init init_nic(void)
 {
 	printk(KERN_INFO "forcedeth.c: Reverse Engineered nForce ethernet driver. Version %s.\n", FORCEDETH_VERSION);
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit exit_nic(void)
diff --git a/drivers/net/hp100.c b/drivers/net/hp100.c
index e7d9bf3..bb92fb6 100644
--- a/drivers/net/hp100.c
+++ b/drivers/net/hp100.c
@@ -3032,7 +3032,7 @@ #ifdef CONFIG_EISA
 		goto out2;
 #endif
 #ifdef CONFIG_PCI
-	err = pci_module_init(&hp100_pci_driver);
+	err = pci_register_driver(&hp100_pci_driver);
 	if (err && err != -ENODEV) 
 		goto out3;
 #endif
diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
index 7bbd447..5bff05f 100644
--- a/drivers/net/ixgb/ixgb_main.c
+++ b/drivers/net/ixgb/ixgb_main.c
@@ -162,7 +162,7 @@ ixgb_init_module(void)
 
 	printk(KERN_INFO "%s\n", ixgb_copyright);
 
-	return pci_module_init(&ixgb_driver);
+	return pci_register_driver(&ixgb_driver);
 }
 
 module_init(ixgb_init_module);
diff --git a/drivers/net/natsemi.c b/drivers/net/natsemi.c
index db0475a..10d8458 100644
--- a/drivers/net/natsemi.c
+++ b/drivers/net/natsemi.c
@@ -3246,7 +3246,7 @@ #ifdef MODULE
 	printk(version);
 #endif
 
-	return pci_module_init (&natsemi_driver);
+	return pci_register_driver (&natsemi_driver);
 }
 
 static void __exit natsemi_exit_mod (void)
diff --git a/drivers/net/ne2k-pci.c b/drivers/net/ne2k-pci.c
index 34bdba9..31d262e 100644
--- a/drivers/net/ne2k-pci.c
+++ b/drivers/net/ne2k-pci.c
@@ -702,7 +702,7 @@ static int __init ne2k_pci_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&ne2k_driver);
+	return pci_register_driver (&ne2k_driver);
 }
 
 
diff --git a/drivers/net/ns83820.c b/drivers/net/ns83820.c
index 0e76859..0dedd34 100644
--- a/drivers/net/ns83820.c
+++ b/drivers/net/ns83820.c
@@ -2178,7 +2178,7 @@ #endif
 static int __init ns83820_init(void)
 {
 	printk(KERN_INFO "ns83820.c: National Semiconductor DP83820 10/100/1000 driver.\n");
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit ns83820_exit(void)
diff --git a/drivers/net/pci-skeleton.c b/drivers/net/pci-skeleton.c
index e0e2939..c04f53e 100644
--- a/drivers/net/pci-skeleton.c
+++ b/drivers/net/pci-skeleton.c
@@ -1963,7 +1963,7 @@ static int __init netdrv_init_module (vo
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&netdrv_pci_driver);
+	return pci_register_driver (&netdrv_pci_driver);
 }
 
 
diff --git a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
index 4daafe3..ba60657 100644
--- a/drivers/net/pcnet32.c
+++ b/drivers/net/pcnet32.c
@@ -2969,7 +2969,7 @@ static int __init pcnet32_init_module(vo
 		tx_start = tx_start_pt;
 
 	/* find the PCI devices */
-	if (!pci_module_init(&pcnet32_driver))
+	if (!pci_register_driver(&pcnet32_driver))
 		pcnet32_have_pci = 1;
 
 	/* should we find any remaining VLbus devices ? */
diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index 4c2f575..5722a56 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -2809,7 +2809,7 @@ #endif
 static int __init
 rtl8169_init_module(void)
 {
-	return pci_module_init(&rtl8169_pci_driver);
+	return pci_register_driver(&rtl8169_pci_driver);
 }
 
 static void __exit
diff --git a/drivers/net/rrunner.c b/drivers/net/rrunner.c
index c3ed734..31bcdad 100644
--- a/drivers/net/rrunner.c
+++ b/drivers/net/rrunner.c
@@ -1736,7 +1736,7 @@ static struct pci_driver rr_driver = {
 
 static int __init rr_init_module(void)
 {
-	return pci_module_init(&rr_driver);
+	return pci_register_driver(&rr_driver);
 }
 
 static void __exit rr_cleanup_module(void)
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index 132ed32..ce290e9 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -7232,7 +7232,7 @@ static void __devexit s2io_rem_nic(struc
 
 int __init s2io_starter(void)
 {
-	return pci_module_init(&s2io_driver);
+	return pci_register_driver(&s2io_driver);
 }
 
 /**
diff --git a/drivers/net/saa9730.c b/drivers/net/saa9730.c
index b2acedb..c479b07 100644
--- a/drivers/net/saa9730.c
+++ b/drivers/net/saa9730.c
@@ -1131,7 +1131,7 @@ static struct pci_driver saa9730_driver 
 
 static int __init saa9730_init(void)
 {
-	return pci_module_init(&saa9730_driver);
+	return pci_register_driver(&saa9730_driver);
 }
 
 static void __exit saa9730_cleanup(void)
diff --git a/drivers/net/sis190.c b/drivers/net/sis190.c
index df0cbeb..16e30d5 100644
--- a/drivers/net/sis190.c
+++ b/drivers/net/sis190.c
@@ -1871,7 +1871,7 @@ static struct pci_driver sis190_pci_driv
 
 static int __init sis190_init_module(void)
 {
-	return pci_module_init(&sis190_pci_driver);
+	return pci_register_driver(&sis190_pci_driver);
 }
 
 static void __exit sis190_cleanup_module(void)
diff --git a/drivers/net/sis900.c b/drivers/net/sis900.c
index 29ee7ff..ff80d9c 100644
--- a/drivers/net/sis900.c
+++ b/drivers/net/sis900.c
@@ -2495,7 +2495,7 @@ #ifdef MODULE
 	printk(version);
 #endif
 
-	return pci_module_init(&sis900_pci_driver);
+	return pci_register_driver(&sis900_pci_driver);
 }
 
 static void __exit sis900_cleanup_module(void)
diff --git a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
index ee62845..49e76c7 100644
--- a/drivers/net/sk98lin/skge.c
+++ b/drivers/net/sk98lin/skge.c
@@ -5133,7 +5133,7 @@ static struct pci_driver skge_driver = {
 
 static int __init skge_init(void)
 {
-	return pci_module_init(&skge_driver);
+	return pci_register_driver(&skge_driver);
 }
 
 static void __exit skge_exit(void)
diff --git a/drivers/net/skfp/skfddi.c b/drivers/net/skfp/skfddi.c
index b5714a6..8e4d184 100644
--- a/drivers/net/skfp/skfddi.c
+++ b/drivers/net/skfp/skfddi.c
@@ -2280,7 +2280,7 @@ static struct pci_driver skfddi_pci_driv
 
 static int __init skfd_init(void)
 {
-	return pci_module_init(&skfddi_pci_driver);
+	return pci_register_driver(&skfddi_pci_driver);
 }
 
 static void __exit skfd_exit(void)
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index 7de9a07..af217ab 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -3508,7 +3508,7 @@ #endif
 
 static int __init skge_init_module(void)
 {
-	return pci_module_init(&skge_driver);
+	return pci_register_driver(&skge_driver);
 }
 
 static void __exit skge_cleanup_module(void)
diff --git a/drivers/net/starfire.c b/drivers/net/starfire.c
index c0a62b0..8e355a2 100644
--- a/drivers/net/starfire.c
+++ b/drivers/net/starfire.c
@@ -2053,7 +2053,7 @@ #endif
 		return -ENODEV;
 	}
 
-	return pci_module_init (&starfire_driver);
+	return pci_register_driver (&starfire_driver);
 }
 
 
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index ac17377..dd34712 100644
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -1736,7 +1736,7 @@ static int __init sundance_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&sundance_driver);
+	return pci_register_driver(&sundance_driver);
 }
 
 static void __exit sundance_exit(void)
diff --git a/drivers/net/sungem.c b/drivers/net/sungem.c
index b70bbd7..1a441a8 100644
--- a/drivers/net/sungem.c
+++ b/drivers/net/sungem.c
@@ -3194,7 +3194,7 @@ #endif /* CONFIG_PM */
 
 static int __init gem_init(void)
 {
-	return pci_module_init(&gem_driver);
+	return pci_register_driver(&gem_driver);
 }
 
 static void __exit gem_cleanup(void)
diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
index 8b53ded..39460fa 100644
--- a/drivers/net/tc35815.c
+++ b/drivers/net/tc35815.c
@@ -1725,7 +1725,7 @@ static struct pci_driver tc35815_driver 
 
 static int __init tc35815_init_module(void)
 {
-	return pci_module_init(&tc35815_driver);
+	return pci_register_driver(&tc35815_driver);
 }
 
 static void __exit tc35815_cleanup_module(void)
diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
index 6f97962..6d99d3e 100644
--- a/drivers/net/tg3.c
+++ b/drivers/net/tg3.c
@@ -11814,7 +11814,7 @@ static struct pci_driver tg3_driver = {
 
 static int __init tg3_init(void)
 {
-	return pci_module_init(&tg3_driver);
+	return pci_register_driver(&tg3_driver);
 }
 
 static void __exit tg3_cleanup(void)
diff --git a/drivers/net/tokenring/3c359.c b/drivers/net/tokenring/3c359.c
index 465921e..5ba33f8 100644
--- a/drivers/net/tokenring/3c359.c
+++ b/drivers/net/tokenring/3c359.c
@@ -1815,7 +1815,7 @@ static struct pci_driver xl_3c359_driver
 
 static int __init xl_pci_init (void)
 {
-	return pci_module_init (&xl_3c359_driver);
+	return pci_register_driver (&xl_3c359_driver);
 }
 
 
diff --git a/drivers/net/tokenring/lanstreamer.c b/drivers/net/tokenring/lanstreamer.c
index 28d968f..0d66700 100644
--- a/drivers/net/tokenring/lanstreamer.c
+++ b/drivers/net/tokenring/lanstreamer.c
@@ -1998,7 +1998,7 @@ static struct pci_driver streamer_pci_dr
 };
 
 static int __init streamer_init_module(void) {
-  return pci_module_init(&streamer_pci_driver);
+  return pci_register_driver(&streamer_pci_driver);
 }
 
 static void __exit streamer_cleanup_module(void) {
diff --git a/drivers/net/tokenring/olympic.c b/drivers/net/tokenring/olympic.c
index 8583148..754fb17 100644
--- a/drivers/net/tokenring/olympic.c
+++ b/drivers/net/tokenring/olympic.c
@@ -1771,7 +1771,7 @@ static struct pci_driver olympic_driver 
 
 static int __init olympic_pci_init(void) 
 {
-	return pci_module_init (&olympic_driver) ; 
+	return pci_register_driver (&olympic_driver) ; 
 }
 
 static void __exit olympic_pci_cleanup(void)
diff --git a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
index d05c5aa..9d41dbc 100644
--- a/drivers/net/tulip/de2104x.c
+++ b/drivers/net/tulip/de2104x.c
@@ -2172,7 +2172,7 @@ static int __init de_init (void)
 #ifdef MODULE
 	printk("%s", version);
 #endif
-	return pci_module_init (&de_driver);
+	return pci_register_driver (&de_driver);
 }
 
 static void __exit de_exit (void)
diff --git a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
index 75ff14a..051d6df 100644
--- a/drivers/net/tulip/de4x5.c
+++ b/drivers/net/tulip/de4x5.c
@@ -5754,7 +5754,7 @@ static int __init de4x5_module_init (voi
 	int err = 0;
 
 #ifdef CONFIG_PCI
-	err = pci_module_init (&de4x5_pci_driver);
+	err = pci_register_driver (&de4x5_pci_driver);
 #endif
 #ifdef CONFIG_EISA
 	err |= eisa_driver_register (&de4x5_eisa_driver);
diff --git a/drivers/net/tulip/dmfe.c b/drivers/net/tulip/dmfe.c
index 4e5b0f2..66dade5 100644
--- a/drivers/net/tulip/dmfe.c
+++ b/drivers/net/tulip/dmfe.c
@@ -2039,7 +2039,7 @@ static int __init dmfe_init_module(void)
 	if (HPNA_NoiseFloor > 15)
 		HPNA_NoiseFloor = 0;
 
-	rc = pci_module_init(&dmfe_driver);
+	rc = pci_register_driver(&dmfe_driver);
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
index 7351831..e458508 100644
--- a/drivers/net/tulip/tulip_core.c
+++ b/drivers/net/tulip/tulip_core.c
@@ -1849,7 +1849,7 @@ #endif
 	tulip_max_interrupt_work = max_interrupt_work;
 
 	/* probe for and init boards */
-	return pci_module_init (&tulip_driver);
+	return pci_register_driver (&tulip_driver);
 }
 
 
diff --git a/drivers/net/tulip/uli526x.c b/drivers/net/tulip/uli526x.c
index fd64b2b..93c27a6 100644
--- a/drivers/net/tulip/uli526x.c
+++ b/drivers/net/tulip/uli526x.c
@@ -1725,7 +1725,7 @@ static int __init uli526x_init_module(vo
 		break;
 	}
 
-	rc = pci_module_init(&uli526x_driver);
+	rc = pci_register_driver(&uli526x_driver);
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/net/tulip/winbond-840.c b/drivers/net/tulip/winbond-840.c
index 7f41481..f9302c8 100644
--- a/drivers/net/tulip/winbond-840.c
+++ b/drivers/net/tulip/winbond-840.c
@@ -1689,7 +1689,7 @@ #endif
 static int __init w840_init(void)
 {
 	printk(version);
-	return pci_module_init(&w840_driver);
+	return pci_register_driver(&w840_driver);
 }
 
 static void __exit w840_exit(void)
diff --git a/drivers/net/tulip/xircom_tulip_cb.c b/drivers/net/tulip/xircom_tulip_cb.c
index 17ca7dc..d797b7b 100644
--- a/drivers/net/tulip/xircom_tulip_cb.c
+++ b/drivers/net/tulip/xircom_tulip_cb.c
@@ -1707,7 +1707,7 @@ static int __init xircom_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&xircom_driver);
+	return pci_register_driver(&xircom_driver);
 }
 
 
diff --git a/drivers/net/typhoon.c b/drivers/net/typhoon.c
index 4103c37..1014461 100644
--- a/drivers/net/typhoon.c
+++ b/drivers/net/typhoon.c
@@ -2660,7 +2660,7 @@ #endif
 static int __init
 typhoon_init(void)
 {
-	return pci_module_init(&typhoon_driver);
+	return pci_register_driver(&typhoon_driver);
 }
 
 static void __exit
diff --git a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
index d3d0ec9..bfa4e21 100644
--- a/drivers/net/via-rhine.c
+++ b/drivers/net/via-rhine.c
@@ -1941,7 +1941,7 @@ static int __init rhine_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&rhine_driver);
+	return pci_register_driver(&rhine_driver);
 }
 
 
diff --git a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
index aa9cd92..e266db1 100644
--- a/drivers/net/via-velocity.c
+++ b/drivers/net/via-velocity.c
@@ -2250,7 +2250,7 @@ static int __init velocity_init_module(v
 	int ret;
 
 	velocity_register_notifier();
-	ret = pci_module_init(&velocity_driver);
+	ret = pci_register_driver(&velocity_driver);
 	if (ret < 0)
 		velocity_unregister_notifier();
 	return ret;
diff --git a/drivers/net/wan/dscc4.c b/drivers/net/wan/dscc4.c
index 684af43..af4d415 100644
--- a/drivers/net/wan/dscc4.c
+++ b/drivers/net/wan/dscc4.c
@@ -2062,7 +2062,7 @@ static struct pci_driver dscc4_driver = 
 
 static int __init dscc4_init_module(void)
 {
-	return pci_module_init(&dscc4_driver);
+	return pci_register_driver(&dscc4_driver);
 }
 
 static void __exit dscc4_cleanup_module(void)
diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
index 3705db0..564351a 100644
--- a/drivers/net/wan/farsync.c
+++ b/drivers/net/wan/farsync.c
@@ -2697,7 +2697,7 @@ fst_init(void)
 	for (i = 0; i < FST_MAX_CARDS; i++)
 		fst_card_array[i] = NULL;
 	spin_lock_init(&fst_work_q_lock);
-	return pci_module_init(&fst_driver);
+	return pci_register_driver(&fst_driver);
 }
 
 static void __exit
diff --git a/drivers/net/wan/lmc/lmc_main.c b/drivers/net/wan/lmc/lmc_main.c
index 39f4424..7b5d81d 100644
--- a/drivers/net/wan/lmc/lmc_main.c
+++ b/drivers/net/wan/lmc/lmc_main.c
@@ -1790,7 +1790,7 @@ static struct pci_driver lmc_driver = {
 
 static int __init init_lmc(void)
 {
-    return pci_module_init(&lmc_driver);
+    return pci_register_driver(&lmc_driver);
 }
 
 static void __exit exit_lmc(void)
diff --git a/drivers/net/wan/pc300_drv.c b/drivers/net/wan/pc300_drv.c
index 567efff..56e6940 100644
--- a/drivers/net/wan/pc300_drv.c
+++ b/drivers/net/wan/pc300_drv.c
@@ -3677,7 +3677,7 @@ static struct pci_driver cpc_driver = {
 
 static int __init cpc_init(void)
 {
-	return pci_module_init(&cpc_driver);
+	return pci_register_driver(&cpc_driver);
 }
 
 static void __exit cpc_cleanup_module(void)
diff --git a/drivers/net/wan/pci200syn.c b/drivers/net/wan/pci200syn.c
index 4df61fa..a6b9c33 100644
--- a/drivers/net/wan/pci200syn.c
+++ b/drivers/net/wan/pci200syn.c
@@ -476,7 +476,7 @@ #endif
 		printk(KERN_ERR "pci200syn: Invalid PCI clock frequency\n");
 		return -EINVAL;
 	}
-	return pci_module_init(&pci200_pci_driver);
+	return pci_register_driver(&pci200_pci_driver);
 }
 
 
diff --git a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
index b2031df..ec68f7d 100644
--- a/drivers/net/wan/wanxl.c
+++ b/drivers/net/wan/wanxl.c
@@ -837,7 +837,7 @@ static int __init wanxl_init_module(void
 #ifdef MODULE
 	printk(KERN_INFO "%s\n", version);
 #endif
-	return pci_module_init(&wanxl_pci_driver);
+	return pci_register_driver(&wanxl_pci_driver);
 }
 
 static void __exit wanxl_cleanup_module(void)
diff --git a/drivers/net/wireless/atmel_pci.c b/drivers/net/wireless/atmel_pci.c
index d425c3c..3bfa791 100644
--- a/drivers/net/wireless/atmel_pci.c
+++ b/drivers/net/wireless/atmel_pci.c
@@ -76,7 +76,7 @@ static void __devexit atmel_pci_remove(s
 
 static int __init atmel_init_module(void)
 {
-	return pci_module_init(&atmel_driver);
+	return pci_register_driver(&atmel_driver);
 }
 
 static void __exit atmel_cleanup_module(void)
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
index e955db4..5f8ccf4 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -6531,7 +6531,7 @@ static int __init ipw2100_init(void)
 	printk(KERN_INFO DRV_NAME ": %s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
 	printk(KERN_INFO DRV_NAME ": %s\n", DRV_COPYRIGHT);
 
-	ret = pci_module_init(&ipw2100_pci_driver);
+	ret = pci_register_driver(&ipw2100_pci_driver);
 
 #ifdef CONFIG_IPW2100_DEBUG
 	ipw2100_debug_level = debug;
diff --git a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
index b3300ff..6fbed67 100644
--- a/drivers/net/wireless/ipw2200.c
+++ b/drivers/net/wireless/ipw2200.c
@@ -11774,7 +11774,7 @@ static int __init ipw_init(void)
 	printk(KERN_INFO DRV_NAME ": " DRV_DESCRIPTION ", " DRV_VERSION "\n");
 	printk(KERN_INFO DRV_NAME ": " DRV_COPYRIGHT "\n");
 
-	ret = pci_module_init(&ipw_driver);
+	ret = pci_register_driver(&ipw_driver);
 	if (ret) {
 		IPW_ERROR("Unable to initialize PCI module\n");
 		return ret;
diff --git a/drivers/net/wireless/orinoco_nortel.c b/drivers/net/wireless/orinoco_nortel.c
index bf05b90..eaf3d13 100644
--- a/drivers/net/wireless/orinoco_nortel.c
+++ b/drivers/net/wireless/orinoco_nortel.c
@@ -304,7 +304,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_nortel_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_nortel_driver);
+	return pci_register_driver(&orinoco_nortel_driver);
 }
 
 static void __exit orinoco_nortel_exit(void)
diff --git a/drivers/net/wireless/orinoco_pci.c b/drivers/net/wireless/orinoco_pci.c
index 1759c54..97a8b4f 100644
--- a/drivers/net/wireless/orinoco_pci.c
+++ b/drivers/net/wireless/orinoco_pci.c
@@ -244,7 +244,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_pci_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_pci_driver);
+	return pci_register_driver(&orinoco_pci_driver);
 }
 
 static void __exit orinoco_pci_exit(void)
diff --git a/drivers/net/wireless/orinoco_plx.c b/drivers/net/wireless/orinoco_plx.c
index 7f006f6..31162ac 100644
--- a/drivers/net/wireless/orinoco_plx.c
+++ b/drivers/net/wireless/orinoco_plx.c
@@ -351,7 +351,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_plx_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_plx_driver);
+	return pci_register_driver(&orinoco_plx_driver);
 }
 
 static void __exit orinoco_plx_exit(void)
diff --git a/drivers/net/wireless/orinoco_tmd.c b/drivers/net/wireless/orinoco_tmd.c
index 0831721..7c7b960 100644
--- a/drivers/net/wireless/orinoco_tmd.c
+++ b/drivers/net/wireless/orinoco_tmd.c
@@ -228,7 +228,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_tmd_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_tmd_driver);
+	return pci_register_driver(&orinoco_tmd_driver);
 }
 
 static void __exit orinoco_tmd_exit(void)
diff --git a/drivers/net/wireless/prism54/islpci_hotplug.c b/drivers/net/wireless/prism54/islpci_hotplug.c
index 09fc17a..f692dcc 100644
--- a/drivers/net/wireless/prism54/islpci_hotplug.c
+++ b/drivers/net/wireless/prism54/islpci_hotplug.c
@@ -313,7 +313,7 @@ prism54_module_init(void)
 
 	__bug_on_wrong_struct_sizes ();
 
-	return pci_module_init(&prism54_driver);
+	return pci_register_driver(&prism54_driver);
 }
 
 /* by the time prism54_module_exit() terminates, as a postcondition
diff --git a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
index 8459a18..3587f2a 100644
--- a/drivers/net/yellowfin.c
+++ b/drivers/net/yellowfin.c
@@ -1434,7 +1434,7 @@ static int __init yellowfin_init (void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&yellowfin_driver);
+	return pci_register_driver (&yellowfin_driver);
 }
 
 
diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 5a9475e..da17315 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -2211,7 +2211,7 @@ static int __init twa_init(void)
 {
 	printk(KERN_WARNING "3ware 9000 Storage Controller device driver for Linux v%s.\n", TW_DRIVER_VERSION);
 
-	return pci_module_init(&twa_driver);
+	return pci_register_driver(&twa_driver);
 } /* End twa_init() */
 
 /* This function is called on driver exit */
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index f3a5f42..2d4cb67 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2486,7 +2486,7 @@ static int __init tw_init(void)
 {
 	printk(KERN_WARNING "3ware Storage Controller device driver for Linux v%s.\n", TW_DRIVER_VERSION);
 
-	return pci_module_init(&tw_driver);
+	return pci_register_driver(&tw_driver);
 } /* End tw_init() */
 
 /* This function is called on driver exit */
diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index d7e9fab..2684150 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -1187,7 +1187,7 @@ static struct pci_driver inia100_pci_dri
 
 static int __init inia100_init(void)
 {
-	return pci_module_init(&inia100_pci_driver);
+	return pci_register_driver(&inia100_pci_driver);
 }
 
 static void __exit inia100_exit(void)
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 904c25f..0efb8ea 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1454,7 +1454,7 @@ static void ahci_remove_one (struct pci_
 
 static int __init ahci_init(void)
 {
-	return pci_module_init(&ahci_pci_driver);
+	return pci_register_driver(&ahci_pci_driver);
 }
 
 static void __exit ahci_exit(void)
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
index 50a41ed..8a52fef 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
@@ -198,7 +198,7 @@ ahd_linux_pci_dev_probe(struct pci_dev *
 int
 ahd_linux_pci_init(void)
 {
-	return (pci_module_init(&aic79xx_pci_driver));
+	return (pci_register_driver(&aic79xx_pci_driver));
 }
 
 void
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
index 7e42f07..fc74e84 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
@@ -247,7 +247,7 @@ int
 ahc_linux_pci_init(void)
 {
 	/* Translate error or zero return into zero or one */
-	return pci_module_init(&aic7xxx_pci_driver) ? 0 : 1;
+	return pci_register_driver(&aic7xxx_pci_driver) ? 0 : 1;
 }
 
 void
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 19745a3..fc28b99 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -940,8 +940,8 @@ static int __init piix_init(void)
 {
 	int rc;
 
-	DPRINTK("pci_module_init\n");
-	rc = pci_module_init(&piix_pci_driver);
+	DPRINTK("pci_register_driver\n");
+	rc = pci_register_driver(&piix_pci_driver);
 	if (rc)
 		return rc;
 
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index ff2b179..1481fac 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4949,7 +4949,7 @@ static struct pci_driver dc395x_driver =
  **/
 static int __init dc395x_module_init(void)
 {
-	return pci_module_init(&dc395x_driver);
+	return pci_register_driver(&dc395x_driver);
 }
 
 
diff --git a/drivers/scsi/dmx3191d.c b/drivers/scsi/dmx3191d.c
index 879a266..fa738ec 100644
--- a/drivers/scsi/dmx3191d.c
+++ b/drivers/scsi/dmx3191d.c
@@ -155,7 +155,7 @@ static struct pci_driver dmx3191d_pci_dr
 
 static int __init dmx3191d_init(void)
 {
-	return pci_module_init(&dmx3191d_pci_driver);
+	return pci_register_driver(&dmx3191d_pci_driver);
 }
 
 static void __exit dmx3191d_exit(void)
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 01080b3..4bc0a2b 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6721,7 +6721,7 @@ static int __init ipr_init(void)
 	ipr_info("IBM Power RAID SCSI Device Driver version: %s %s\n",
 		 IPR_DRIVER_VERSION, IPR_DRIVER_DATE);
 
-	return pci_module_init(&ipr_driver);
+	return pci_register_driver(&ipr_driver);
 }
 
 /**
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 3c63928..58065ff 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -7078,7 +7078,7 @@ ips_remove_device(struct pci_dev *pci_de
 static int __init
 ips_module_init(void)
 {
-	if (pci_module_init(&ips_pci_driver) < 0)
+	if (pci_register_driver(&ips_pci_driver) < 0)
 		return -ENODEV;
 	ips_driver_template.module = THIS_MODULE;
 	ips_order_controllers();
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 76edbb6..13dc906 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -5072,7 +5072,7 @@ #ifdef CONFIG_PROC_FS
 				"megaraid: failed to create megaraid root\n");
 	}
 #endif
-	error = pci_module_init(&megaraid_pci_driver);
+	error = pci_register_driver(&megaraid_pci_driver);
 	if (error) {
 #ifdef CONFIG_PROC_FS
 		remove_proc_entry("megaraid", &proc_root);
diff --git a/drivers/scsi/megaraid/megaraid_sas.c b/drivers/scsi/megaraid/megaraid_sas.c
index a8c9627..cd7d1f4 100644
--- a/drivers/scsi/megaraid/megaraid_sas.c
+++ b/drivers/scsi/megaraid/megaraid_sas.c
@@ -2854,7 +2854,7 @@ static int __init megasas_init(void)
 	/*
 	 * Register ourselves as PCI hotplug module
 	 */
-	rval = pci_module_init(&megasas_pci_driver);
+	rval = pci_register_driver(&megasas_pci_driver);
 
 	if (rval) {
 		printk(KERN_DEBUG "megasas: PCI hotplug regisration failed \n");
diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index bfb4f49..1c624ce 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -3581,7 +3581,7 @@ #endif
  */
 static int __init init_nsp32(void) {
 	nsp32_msg(KERN_INFO, "loading...");
-	return pci_module_init(&nsp32_driver);
+	return pci_register_driver(&nsp32_driver);
 }
 
 static void __exit exit_nsp32(void) {
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index d1f38c3..6b7b624 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -721,7 +721,7 @@ err_out:
 
 static int __init adma_ata_init(void)
 {
-	return pci_module_init(&adma_ata_pci_driver);
+	return pci_register_driver(&adma_ata_pci_driver);
 }
 
 static void __exit adma_ata_exit(void)
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 8953991..32ee66c 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -4484,7 +4484,7 @@ #ifdef MODULE
 		qla1280_setup(qla1280);
 #endif
 
-	return pci_module_init(&qla1280_pci_driver);
+	return pci_register_driver(&qla1280_pci_driver);
 }
 
 static void __exit
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 1053c7c..a2915a5 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -2447,7 +2447,7 @@ err_out:
 
 static int __init mv_init(void)
 {
-	return pci_module_init(&mv_pci_driver);
+	return pci_register_driver(&mv_pci_driver);
 }
 
 static void __exit mv_exit(void)
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 56da255..be46df7 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -583,7 +583,7 @@ static void nv_ck804_host_stop(struct at
 
 static int __init nv_init(void)
 {
-	return pci_module_init(&nv_pci_driver);
+	return pci_register_driver(&nv_pci_driver);
 }
 
 static void __exit nv_exit(void)
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 4776f4e..a5b3a7d 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -824,7 +824,7 @@ err_out:
 
 static int __init pdc_ata_init(void)
 {
-	return pci_module_init(&pdc_ata_pci_driver);
+	return pci_register_driver(&pdc_ata_pci_driver);
 }
 
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index d374c1d..71bd671 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -712,7 +712,7 @@ err_out:
 
 static int __init qs_ata_init(void)
 {
-	return pci_module_init(&qs_ata_pci_driver);
+	return pci_register_driver(&qs_ata_pci_driver);
 }
 
 static void __exit qs_ata_exit(void)
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index d0a8507..2393379 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -714,7 +714,7 @@ static int sil_pci_device_resume(struct 
 
 static int __init sil_init(void)
 {
-	return pci_module_init(&sil_pci_driver);
+	return pci_register_driver(&sil_pci_driver);
 }
 
 static void __exit sil_exit(void)
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 2e0f4a4..60e0d73 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -1206,7 +1206,7 @@ static int sil24_pci_device_resume(struc
 
 static int __init sil24_init(void)
 {
-	return pci_module_init(&sil24_pci_driver);
+	return pci_register_driver(&sil24_pci_driver);
 }
 
 static void __exit sil24_exit(void)
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index ee6b5df..ac24f66 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -334,7 +334,7 @@ err_out:
 
 static int __init sis_init(void)
 {
-	return pci_module_init(&sis_pci_driver);
+	return pci_register_driver(&sis_pci_driver);
 }
 
 static void __exit sis_exit(void)
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 7d08580..baf259a 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -488,7 +488,7 @@ static struct pci_driver k2_sata_pci_dri
 
 static int __init k2_sata_init(void)
 {
-	return pci_module_init(&k2_sata_pci_driver);
+	return pci_register_driver(&k2_sata_pci_driver);
 }
 
 
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index ccc8cad..0da83cb 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -1482,7 +1482,7 @@ err_out:
 
 static int __init pdc_sata_init(void)
 {
-	return pci_module_init(&pdc_sata_pci_driver);
+	return pci_register_driver(&pdc_sata_pci_driver);
 }
 
 
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 33cdb48..654aae2 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -287,7 +287,7 @@ err_out:
 
 static int __init uli_init(void)
 {
-	return pci_module_init(&uli_pci_driver);
+	return pci_register_driver(&uli_pci_driver);
 }
 
 static void __exit uli_exit(void)
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 03baec2..0bf1dbe 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -381,7 +381,7 @@ err_out:
 
 static int __init svia_init(void)
 {
-	return pci_module_init(&svia_pci_driver);
+	return pci_register_driver(&svia_pci_driver);
 }
 
 static void __exit svia_exit(void)
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index ad37871..4c69a70 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -462,7 +462,7 @@ static struct pci_driver vsc_sata_pci_dr
 
 static int __init vsc_sata_init(void)
 {
-	return pci_module_init(&vsc_sata_pci_driver);
+	return pci_register_driver(&vsc_sata_pci_driver);
 }
 
 
diff --git a/drivers/scsi/tmscsim.c b/drivers/scsi/tmscsim.c
index 9404ff3..6854a67 100644
--- a/drivers/scsi/tmscsim.c
+++ b/drivers/scsi/tmscsim.c
@@ -2670,7 +2670,7 @@ static int __init dc390_module_init(void
 		printk (KERN_INFO "DC390: Using safe settings.\n");
 	}
 
-	return pci_module_init(&dc390_driver);
+	return pci_register_driver(&dc390_driver);
 }
 
 static void __exit dc390_module_exit(void)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8565b81..d14f9f0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -384,12 +384,6 @@ #define PCI_DEVICE_CLASS(dev_class,dev_c
 	.vendor = PCI_ANY_ID, .device = PCI_ANY_ID, \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
-/*
- * pci_module_init is obsolete, this stays here till we fix up all usages of it
- * in the tree.
- */
-#define pci_module_init	pci_register_driver
-
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 

