Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVLCP5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVLCP5m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVLCP5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:57:30 -0500
Received: from aveiro.procergs.com.br ([200.198.128.42]:52662 "EHLO
	aveiro.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751291AbVLCP5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:57:18 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH 5/11] NET: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: <11336254302124-git-send-email-otavio@debian.org>
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 13:57:10 -0200
Message-Id: <11336254304109-git-send-email-otavio@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Otavio Salvador <otavio@debian.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Otavio Salvador <otavio@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace all calls to pci_module_init, that's deprecated and
will be removed in future, with pci_register_driver that should be
the used function now.

Signed-off-by: Otavio Salvador <otavio@debian.org>


---

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
 drivers/net/irda/donauboe.c                   |    2 +-
 drivers/net/irda/vlsi_ir.c                    |    2 +-
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
 68 files changed, 68 insertions(+), 68 deletions(-)

applies-to: 309b3a61c2d9ccddf631182412f70319775c32c3
7c16b7463d474c538e6010ad895d39328dc87531
diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
index 7488ee7..b403923 100644
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -3367,7 +3367,7 @@ static int __init vortex_init (void)
 {
 	int pci_rc, eisa_rc;
 
-	pci_rc = pci_module_init(&vortex_driver);
+	pci_rc = pci_register_driver(&vortex_driver);
 	eisa_rc = vortex_eisa_init();
 
 	if (pci_rc == 0)
diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
index f822cd3..6cbf944 100644
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -1939,7 +1939,7 @@ static int __init cp_init (void)
 #ifdef MODULE
 	printk("%s", version);
 #endif
-	return pci_module_init (&cp_driver);
+	return pci_register_driver (&cp_driver);
 }
 
 static void __exit cp_exit (void)
diff --git a/drivers/net/8139too.c b/drivers/net/8139too.c
index 30bee11..4a6445d 100644
--- a/drivers/net/8139too.c
+++ b/drivers/net/8139too.c
@@ -2635,7 +2635,7 @@ static int __init rtl8139_init_module (v
 	printk (KERN_INFO RTL8139_DRIVER_NAME "\n");
 #endif
 
-	return pci_module_init (&rtl8139_pci_driver);
+	return pci_register_driver (&rtl8139_pci_driver);
 }
 
 
diff --git a/drivers/net/acenic.c b/drivers/net/acenic.c
index b8953de..016f1c2 100644
--- a/drivers/net/acenic.c
+++ b/drivers/net/acenic.c
@@ -730,7 +730,7 @@ static struct pci_driver acenic_pci_driv
 
 static int __init acenic_init(void)
 {
-	return pci_module_init(&acenic_pci_driver);
+	return pci_register_driver(&acenic_pci_driver);
 }
 
 static void __exit acenic_exit(void)
diff --git a/drivers/net/amd8111e.c b/drivers/net/amd8111e.c
index d9ba8be..bee8451 100644
--- a/drivers/net/amd8111e.c
+++ b/drivers/net/amd8111e.c
@@ -2159,7 +2159,7 @@ static struct pci_driver amd8111e_driver
 
 static int __init amd8111e_init(void)
 {
-	return pci_module_init(&amd8111e_driver);
+	return pci_register_driver(&amd8111e_driver);
 }
 
 static void __exit amd8111e_cleanup(void)
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 96636ca..c0fa5c8 100644
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
index 7aa49b9..7857de9 100644
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -2138,7 +2138,7 @@ static int __init b44_init(void)
 	dma_desc_align_mask = ~(dma_desc_align_size - 1);
 	dma_desc_sync_size = max(dma_desc_align_size, sizeof(struct dma_desc));
 
-	return pci_module_init(&b44_driver);
+	return pci_register_driver(&b44_driver);
 }
 
 static void __exit b44_cleanup(void)
diff --git a/drivers/net/bnx2.c b/drivers/net/bnx2.c
index 49fa1e4..a58cb86 100644
--- a/drivers/net/bnx2.c
+++ b/drivers/net/bnx2.c
@@ -5849,7 +5849,7 @@ static struct pci_driver bnx2_pci_driver
 
 static int __init bnx2_init(void)
 {
-	return pci_module_init(&bnx2_pci_driver);
+	return pci_register_driver(&bnx2_pci_driver);
 }
 
 static void __exit bnx2_cleanup(void)
diff --git a/drivers/net/cassini.c b/drivers/net/cassini.c
index 1f7ca45..36079ca 100644
--- a/drivers/net/cassini.c
+++ b/drivers/net/cassini.c
@@ -5224,7 +5224,7 @@ static int __init cas_init(void)
 	else
 		link_transition_timeout = 0;
 
-	return pci_module_init(&cas_driver);
+	return pci_register_driver(&cas_driver);
 }
 
 static void __exit cas_cleanup(void)
diff --git a/drivers/net/chelsio/cxgb2.c b/drivers/net/chelsio/cxgb2.c
index 349ebe7..bf712b3 100644
--- a/drivers/net/chelsio/cxgb2.c
+++ b/drivers/net/chelsio/cxgb2.c
@@ -1244,7 +1244,7 @@ static struct pci_driver driver = {
 
 static int __init t1_init_module(void)
 {
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit t1_cleanup_module(void)
diff --git a/drivers/net/defxx.c b/drivers/net/defxx.c
index 5acd35c..1ac4545 100644
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
index 430c628..c738098 100644
--- a/drivers/net/dl2k.c
+++ b/drivers/net/dl2k.c
@@ -1848,7 +1848,7 @@ static struct pci_driver rio_driver = {
 static int __init
 rio_init (void)
 {
-	return pci_module_init (&rio_driver);
+	return pci_register_driver (&rio_driver);
 }
 
 static void __exit
diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index 22cd045..ab1a8a5 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -2722,7 +2722,7 @@ static int __init e100_init_module(void)
 		printk(KERN_INFO PFX "%s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
 		printk(KERN_INFO PFX "%s\n", DRV_COPYRIGHT);
 	}
-	return pci_module_init(&e100_driver);
+	return pci_register_driver(&e100_driver);
 }
 
 static void __exit e100_cleanup_module(void)
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index e0ae248..180ef80 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -247,7 +247,7 @@ e1000_init_module(void)
 
 	printk(KERN_INFO "%s\n", e1000_copyright);
 
-	ret = pci_module_init(&e1000_driver);
+	ret = pci_register_driver(&e1000_driver);
 
 	return ret;
 }
diff --git a/drivers/net/eepro100.c b/drivers/net/eepro100.c
index 8c62ced..587c7d5 100644
--- a/drivers/net/eepro100.c
+++ b/drivers/net/eepro100.c
@@ -2391,7 +2391,7 @@ static int __init eepro100_init_module(v
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&eepro100_driver);
+	return pci_register_driver(&eepro100_driver);
 }
 
 static void __exit eepro100_cleanup_module(void)
diff --git a/drivers/net/epic100.c b/drivers/net/epic100.c
index f119ec4..d71c0e9 100644
--- a/drivers/net/epic100.c
+++ b/drivers/net/epic100.c
@@ -1673,7 +1673,7 @@ static int __init epic_init (void)
 		version, version2, version3);
 #endif
 
-	return pci_module_init (&epic_driver);
+	return pci_register_driver (&epic_driver);
 }
 
 
diff --git a/drivers/net/fealnx.c b/drivers/net/fealnx.c
index 55dbe9a..bfe1272 100644
--- a/drivers/net/fealnx.c
+++ b/drivers/net/fealnx.c
@@ -1992,7 +1992,7 @@ static int __init fealnx_init(void)
 	printk(version);
 #endif
 
-	return pci_module_init(&fealnx_driver);
+	return pci_register_driver(&fealnx_driver);
 }
 
 static void __exit fealnx_exit(void)
diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index 525624f..7739f15 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -2720,7 +2720,7 @@ static struct pci_driver driver = {
 static int __init init_nic(void)
 {
 	printk(KERN_INFO "forcedeth.c: Reverse Engineered nForce ethernet driver. Version %s.\n", FORCEDETH_VERSION);
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit exit_nic(void)
diff --git a/drivers/net/hp100.c b/drivers/net/hp100.c
index e92c17f..86c2662 100644
--- a/drivers/net/hp100.c
+++ b/drivers/net/hp100.c
@@ -3048,7 +3048,7 @@ static int __init hp100_module_init(void
 		goto out2;
 #endif
 #ifdef CONFIG_PCI
-	err = pci_module_init(&hp100_pci_driver);
+	err = pci_register_driver(&hp100_pci_driver);
 	if (err && err != -ENODEV) 
 		goto out3;
 #endif
diff --git a/drivers/net/irda/donauboe.c b/drivers/net/irda/donauboe.c
index 3137592..910c0ca 100644
--- a/drivers/net/irda/donauboe.c
+++ b/drivers/net/irda/donauboe.c
@@ -1778,7 +1778,7 @@ static struct pci_driver donauboe_pci_dr
 static int __init
 donauboe_init (void)
 {
-  return pci_module_init(&donauboe_pci_driver);
+  return pci_register_driver(&donauboe_pci_driver);
 }
 
 static void __exit
diff --git a/drivers/net/irda/vlsi_ir.c b/drivers/net/irda/vlsi_ir.c
index a9f49f0..97a49e0 100644
--- a/drivers/net/irda/vlsi_ir.c
+++ b/drivers/net/irda/vlsi_ir.c
@@ -1887,7 +1887,7 @@ static int __init vlsi_mod_init(void)
 		vlsi_proc_root->owner = THIS_MODULE;
 	}
 
-	ret = pci_module_init(&vlsi_irda_driver);
+	ret = pci_register_driver(&vlsi_irda_driver);
 
 	if (ret && vlsi_proc_root)
 		remove_proc_entry(PROC_DIR, NULL);
diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
index f9f77e4..a7ee7a9 100644
--- a/drivers/net/ixgb/ixgb_main.c
+++ b/drivers/net/ixgb/ixgb_main.c
@@ -171,7 +171,7 @@ ixgb_init_module(void)
 
 	printk(KERN_INFO "%s\n", ixgb_copyright);
 
-	return pci_module_init(&ixgb_driver);
+	return pci_register_driver(&ixgb_driver);
 }
 
 module_init(ixgb_init_module);
diff --git a/drivers/net/natsemi.c b/drivers/net/natsemi.c
index 9d6d254..f61d090 100644
--- a/drivers/net/natsemi.c
+++ b/drivers/net/natsemi.c
@@ -3260,7 +3260,7 @@ static int __init natsemi_init_mod (void
 	printk(version);
 #endif
 
-	return pci_module_init (&natsemi_driver);
+	return pci_register_driver (&natsemi_driver);
 }
 
 static void __exit natsemi_exit_mod (void)
diff --git a/drivers/net/ne2k-pci.c b/drivers/net/ne2k-pci.c
index d11821d..e326dbc 100644
--- a/drivers/net/ne2k-pci.c
+++ b/drivers/net/ne2k-pci.c
@@ -703,7 +703,7 @@ static int __init ne2k_pci_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&ne2k_driver);
+	return pci_register_driver (&ne2k_driver);
 }
 
 
diff --git a/drivers/net/ns83820.c b/drivers/net/ns83820.c
index f857ae9..34ef031 100644
--- a/drivers/net/ns83820.c
+++ b/drivers/net/ns83820.c
@@ -2175,7 +2175,7 @@ static struct pci_driver driver = {
 static int __init ns83820_init(void)
 {
 	printk(KERN_INFO "ns83820.c: National Semiconductor DP83820 10/100/1000 driver.\n");
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit ns83820_exit(void)
diff --git a/drivers/net/pci-skeleton.c b/drivers/net/pci-skeleton.c
index a1ac4bd..0bd53d4 100644
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
index be31922..b8cc648 100644
--- a/drivers/net/pcnet32.c
+++ b/drivers/net/pcnet32.c
@@ -2513,7 +2513,7 @@ static int __init pcnet32_init_module(vo
 	tx_start = tx_start_pt;
 
     /* find the PCI devices */
-    if (!pci_module_init(&pcnet32_driver))
+    if (!pci_register_driver(&pcnet32_driver))
 	pcnet32_have_pci = 1;
 
     /* should we find any remaining VLbus devices ? */
diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index 14a76f7..8470a17 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -2713,7 +2713,7 @@ static struct pci_driver rtl8169_pci_dri
 static int __init
 rtl8169_init_module(void)
 {
-	return pci_module_init(&rtl8169_pci_driver);
+	return pci_register_driver(&rtl8169_pci_driver);
 }
 
 static void __exit
diff --git a/drivers/net/rrunner.c b/drivers/net/rrunner.c
index 19c2df9..9262d27 100644
--- a/drivers/net/rrunner.c
+++ b/drivers/net/rrunner.c
@@ -1737,7 +1737,7 @@ static struct pci_driver rr_driver = {
 
 static int __init rr_init_module(void)
 {
-	return pci_module_init(&rr_driver);
+	return pci_register_driver(&rr_driver);
 }
 
 static void __exit rr_cleanup_module(void)
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index e57df8d..fb30142 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -6297,7 +6297,7 @@ static void __devexit s2io_rem_nic(struc
 
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
index 478791e..7ec938a 100644
--- a/drivers/net/sis190.c
+++ b/drivers/net/sis190.c
@@ -1872,7 +1872,7 @@ static struct pci_driver sis190_pci_driv
 
 static int __init sis190_init_module(void)
 {
-	return pci_module_init(&sis190_pci_driver);
+	return pci_register_driver(&sis190_pci_driver);
 }
 
 static void __exit sis190_cleanup_module(void)
diff --git a/drivers/net/sis900.c b/drivers/net/sis900.c
index 1d4d886..e83a46b 100644
--- a/drivers/net/sis900.c
+++ b/drivers/net/sis900.c
@@ -2410,7 +2410,7 @@ static int __init sis900_init_module(voi
 	printk(version);
 #endif
 
-	return pci_module_init(&sis900_pci_driver);
+	return pci_register_driver(&sis900_pci_driver);
 }
 
 static void __exit sis900_cleanup_module(void)
diff --git a/drivers/net/skfp/skfddi.c b/drivers/net/skfp/skfddi.c
index 4b5ed2c..a59a4e4 100644
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
index 7164678..da640d0 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -3417,7 +3417,7 @@ static struct pci_driver skge_driver = {
 
 static int __init skge_init_module(void)
 {
-	return pci_module_init(&skge_driver);
+	return pci_register_driver(&skge_driver);
 }
 
 static void __exit skge_cleanup_module(void)
diff --git a/drivers/net/starfire.c b/drivers/net/starfire.c
index d167ded..9002b6c 100644
--- a/drivers/net/starfire.c
+++ b/drivers/net/starfire.c
@@ -2137,7 +2137,7 @@ static int __init starfire_init (void)
 		return -ENODEV;
 	}
 
-	return pci_module_init (&starfire_driver);
+	return pci_register_driver (&starfire_driver);
 }
 
 
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index 0ab9c38..c9ad132 100644
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -1806,7 +1806,7 @@ static int __init sundance_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&sundance_driver);
+	return pci_register_driver(&sundance_driver);
 }
 
 static void __exit sundance_exit(void)
diff --git a/drivers/net/sungem.c b/drivers/net/sungem.c
index 081717d..fb71ce4 100644
--- a/drivers/net/sungem.c
+++ b/drivers/net/sungem.c
@@ -3190,7 +3190,7 @@ static struct pci_driver gem_driver = {
 
 static int __init gem_init(void)
 {
-	return pci_module_init(&gem_driver);
+	return pci_register_driver(&gem_driver);
 }
 
 static void __exit gem_cleanup(void)
diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
index c2ec9fd..a44ea20 100644
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
index 1828a6b..8189da7 100644
--- a/drivers/net/tg3.c
+++ b/drivers/net/tg3.c
@@ -10879,7 +10879,7 @@ static struct pci_driver tg3_driver = {
 
 static int __init tg3_init(void)
 {
-	return pci_module_init(&tg3_driver);
+	return pci_register_driver(&tg3_driver);
 }
 
 static void __exit tg3_cleanup(void)
diff --git a/drivers/net/tokenring/3c359.c b/drivers/net/tokenring/3c359.c
index 41e0cd8..0d0ed94 100644
--- a/drivers/net/tokenring/3c359.c
+++ b/drivers/net/tokenring/3c359.c
@@ -1816,7 +1816,7 @@ static struct pci_driver xl_3c359_driver
 
 static int __init xl_pci_init (void)
 {
-	return pci_module_init (&xl_3c359_driver);
+	return pci_register_driver (&xl_3c359_driver);
 }
 
 
diff --git a/drivers/net/tokenring/lanstreamer.c b/drivers/net/tokenring/lanstreamer.c
index 97712c3..0e7b5be 100644
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
index 05477d2..2334024 100644
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
index d7fb3ff..448a9f1 100644
--- a/drivers/net/tulip/de2104x.c
+++ b/drivers/net/tulip/de2104x.c
@@ -2178,7 +2178,7 @@ static int __init de_init (void)
 #ifdef MODULE
 	printk("%s", version);
 #endif
-	return pci_module_init (&de_driver);
+	return pci_register_driver (&de_driver);
 }
 
 static void __exit de_exit (void)
diff --git a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
index ee48bfd..78e6c90 100644
--- a/drivers/net/tulip/de4x5.c
+++ b/drivers/net/tulip/de4x5.c
@@ -5755,7 +5755,7 @@ static int __init de4x5_module_init (voi
 	int err = 0;
 
 #ifdef CONFIG_PCI
-	err = pci_module_init (&de4x5_pci_driver);
+	err = pci_register_driver (&de4x5_pci_driver);
 #endif
 #ifdef CONFIG_EISA
 	err |= eisa_driver_register (&de4x5_eisa_driver);
diff --git a/drivers/net/tulip/dmfe.c b/drivers/net/tulip/dmfe.c
index 74e9075..ee57eea 100644
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
index 125ed00..5f82be9 100644
--- a/drivers/net/tulip/tulip_core.c
+++ b/drivers/net/tulip/tulip_core.c
@@ -1854,7 +1854,7 @@ static int __init tulip_init (void)
 	tulip_max_interrupt_work = max_interrupt_work;
 
 	/* probe for and init boards */
-	return pci_module_init (&tulip_driver);
+	return pci_register_driver (&tulip_driver);
 }
 
 
diff --git a/drivers/net/tulip/uli526x.c b/drivers/net/tulip/uli526x.c
index 1a43163..6318452 100644
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
index 5b1af39..1d6bdc7 100644
--- a/drivers/net/tulip/winbond-840.c
+++ b/drivers/net/tulip/winbond-840.c
@@ -1705,7 +1705,7 @@ static struct pci_driver w840_driver = {
 static int __init w840_init(void)
 {
 	printk(version);
-	return pci_module_init(&w840_driver);
+	return pci_register_driver(&w840_driver);
 }
 
 static void __exit w840_exit(void)
diff --git a/drivers/net/tulip/xircom_tulip_cb.c b/drivers/net/tulip/xircom_tulip_cb.c
index 887d724..de94506 100644
--- a/drivers/net/tulip/xircom_tulip_cb.c
+++ b/drivers/net/tulip/xircom_tulip_cb.c
@@ -1727,7 +1727,7 @@ static int __init xircom_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&xircom_driver);
+	return pci_register_driver(&xircom_driver);
 }
 
 
diff --git a/drivers/net/typhoon.c b/drivers/net/typhoon.c
index 4c76cb7..f677ed2 100644
--- a/drivers/net/typhoon.c
+++ b/drivers/net/typhoon.c
@@ -2659,7 +2659,7 @@ static struct pci_driver typhoon_driver 
 static int __init
 typhoon_init(void)
 {
-	return pci_module_init(&typhoon_driver);
+	return pci_register_driver(&typhoon_driver);
 }
 
 static void __exit
diff --git a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
index 2418715..bd6cf61 100644
--- a/drivers/net/via-rhine.c
+++ b/drivers/net/via-rhine.c
@@ -2049,7 +2049,7 @@ static int __init rhine_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&rhine_driver);
+	return pci_register_driver(&rhine_driver);
 }
 
 
diff --git a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
index 82c6b75..266345b 100644
--- a/drivers/net/via-velocity.c
+++ b/drivers/net/via-velocity.c
@@ -2241,7 +2241,7 @@ static int __init velocity_init_module(v
 	int ret;
 
 	velocity_register_notifier();
-	ret = pci_module_init(&velocity_driver);
+	ret = pci_register_driver(&velocity_driver);
 	if (ret < 0)
 		velocity_unregister_notifier();
 	return ret;
diff --git a/drivers/net/wan/dscc4.c b/drivers/net/wan/dscc4.c
index 2f61a47..2dcce40 100644
--- a/drivers/net/wan/dscc4.c
+++ b/drivers/net/wan/dscc4.c
@@ -2061,7 +2061,7 @@ static struct pci_driver dscc4_driver = 
 
 static int __init dscc4_init_module(void)
 {
-	return pci_module_init(&dscc4_driver);
+	return pci_register_driver(&dscc4_driver);
 }
 
 static void __exit dscc4_cleanup_module(void)
diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
index 7981a2c..2c71353 100644
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
index 2b948ea..f5dba3f 100644
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
index a3e65d1..0e5641e 100644
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
index 8dea07b..dc328f7 100644
--- a/drivers/net/wan/pci200syn.c
+++ b/drivers/net/wan/pci200syn.c
@@ -468,7 +468,7 @@ static int __init pci200_init_module(voi
 		printk(KERN_ERR "pci200syn: Invalid PCI clock frequency\n");
 		return -EINVAL;
 	}
-	return pci_module_init(&pci200_pci_driver);
+	return pci_register_driver(&pci200_pci_driver);
 }
 
 
diff --git a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
index 9c1e106..c4c33f6 100644
--- a/drivers/net/wan/wanxl.c
+++ b/drivers/net/wan/wanxl.c
@@ -822,7 +822,7 @@ static int __init wanxl_init_module(void
 #ifdef MODULE
 	printk(KERN_INFO "%s\n", version);
 #endif
-	return pci_module_init(&wanxl_pci_driver);
+	return pci_register_driver(&wanxl_pci_driver);
 }
 
 static void __exit wanxl_cleanup_module(void)
diff --git a/drivers/net/wireless/atmel_pci.c b/drivers/net/wireless/atmel_pci.c
index a61b3bc..9de7ecb 100644
--- a/drivers/net/wireless/atmel_pci.c
+++ b/drivers/net/wireless/atmel_pci.c
@@ -77,7 +77,7 @@ static void __devexit atmel_pci_remove(s
 
 static int __init atmel_init_module(void)
 {
-	return pci_module_init(&atmel_driver);
+	return pci_register_driver(&atmel_driver);
 }
 
 static void __exit atmel_cleanup_module(void)
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
index 77d2a21..b1c1ede 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -6856,7 +6856,7 @@ static int __init ipw2100_init(void)
 	printk(KERN_INFO DRV_NAME ": %s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
 	printk(KERN_INFO DRV_NAME ": %s\n", DRV_COPYRIGHT);
 
-	ret = pci_module_init(&ipw2100_pci_driver);
+	ret = pci_register_driver(&ipw2100_pci_driver);
 
 #ifdef CONFIG_IPW_DEBUG
 	ipw2100_debug_level = debug;
diff --git a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
index 5e7c7e9..c9e2d6a 100644
--- a/drivers/net/wireless/ipw2200.c
+++ b/drivers/net/wireless/ipw2200.c
@@ -11221,7 +11221,7 @@ static int __init ipw_init(void)
 	printk(KERN_INFO DRV_NAME ": " DRV_DESCRIPTION ", " DRV_VERSION "\n");
 	printk(KERN_INFO DRV_NAME ": " DRV_COPYRIGHT "\n");
 
-	ret = pci_module_init(&ipw_driver);
+	ret = pci_register_driver(&ipw_driver);
 	if (ret) {
 		IPW_ERROR("Unable to initialize PCI module\n");
 		return ret;
diff --git a/drivers/net/wireless/orinoco_nortel.c b/drivers/net/wireless/orinoco_nortel.c
index d8afd51..eec27cb 100644
--- a/drivers/net/wireless/orinoco_nortel.c
+++ b/drivers/net/wireless/orinoco_nortel.c
@@ -287,7 +287,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init nortel_pci_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&nortel_pci_driver);
+	return pci_register_driver(&nortel_pci_driver);
 }
 
 static void __exit nortel_pci_exit(void)
diff --git a/drivers/net/wireless/orinoco_pci.c b/drivers/net/wireless/orinoco_pci.c
index 5362c21..58883eb 100644
--- a/drivers/net/wireless/orinoco_pci.c
+++ b/drivers/net/wireless/orinoco_pci.c
@@ -379,7 +379,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_pci_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_pci_driver);
+	return pci_register_driver(&orinoco_pci_driver);
 }
 
 static void __exit orinoco_pci_exit(void)
diff --git a/drivers/net/wireless/orinoco_plx.c b/drivers/net/wireless/orinoco_plx.c
index 210e737..708dae4 100644
--- a/drivers/net/wireless/orinoco_plx.c
+++ b/drivers/net/wireless/orinoco_plx.c
@@ -382,7 +382,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_plx_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_plx_driver);
+	return pci_register_driver(&orinoco_plx_driver);
 }
 
 static void __exit orinoco_plx_exit(void)
diff --git a/drivers/net/wireless/orinoco_tmd.c b/drivers/net/wireless/orinoco_tmd.c
index 5e68b70..6f04e81 100644
--- a/drivers/net/wireless/orinoco_tmd.c
+++ b/drivers/net/wireless/orinoco_tmd.c
@@ -239,7 +239,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_tmd_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_tmd_driver);
+	return pci_register_driver(&orinoco_tmd_driver);
 }
 
 static void __exit orinoco_tmd_exit(void)
diff --git a/drivers/net/wireless/prism54/islpci_hotplug.c b/drivers/net/wireless/prism54/islpci_hotplug.c
index b41d666..05aa311 100644
--- a/drivers/net/wireless/prism54/islpci_hotplug.c
+++ b/drivers/net/wireless/prism54/islpci_hotplug.c
@@ -312,7 +312,7 @@ prism54_module_init(void)
 
 	__bug_on_wrong_struct_sizes ();
 
-	return pci_module_init(&prism54_driver);
+	return pci_register_driver(&prism54_driver);
 }
 
 /* by the time prism54_module_exit() terminates, as a postcondition
diff --git a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
index 1c25065..18c8359 100644
--- a/drivers/net/yellowfin.c
+++ b/drivers/net/yellowfin.c
@@ -1474,7 +1474,7 @@ static int __init yellowfin_init (void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&yellowfin_driver);
+	return pci_register_driver (&yellowfin_driver);
 }
 
 
---
0.99.9k


