Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVLCP5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVLCP5n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVLCP50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:57:26 -0500
Received: from covilha.procergs.com.br ([200.198.128.244]:43725 "EHLO
	covilha.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751290AbVLCP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:57:17 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH 2/11] SCSI: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: <11336254302237-git-send-email-otavio@debian.org>
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 13:57:10 -0200
Message-Id: <11336254302568-git-send-email-otavio@debian.org>
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

 drivers/scsi/3w-9xxx.c                 |    2 +-
 drivers/scsi/3w-xxxx.c                 |    2 +-
 drivers/scsi/a100u2w.c                 |    2 +-
 drivers/scsi/ahci.c                    |    2 +-
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c |    2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |    2 +-
 drivers/scsi/ata_piix.c                |    4 ++--
 drivers/scsi/dc395x.c                  |    2 +-
 drivers/scsi/dmx3191d.c                |    2 +-
 drivers/scsi/ipr.c                     |    2 +-
 drivers/scsi/ips.c                     |    2 +-
 drivers/scsi/megaraid.c                |    2 +-
 drivers/scsi/megaraid/megaraid_sas.c   |    2 +-
 drivers/scsi/nsp32.c                   |    2 +-
 drivers/scsi/pdc_adma.c                |    2 +-
 drivers/scsi/qla1280.c                 |    2 +-
 drivers/scsi/qla2xxx/ql2100.c          |    2 +-
 drivers/scsi/qla2xxx/ql2200.c          |    2 +-
 drivers/scsi/qla2xxx/ql2300.c          |    2 +-
 drivers/scsi/qla2xxx/ql2322.c          |    2 +-
 drivers/scsi/qla2xxx/ql6312.c          |    2 +-
 drivers/scsi/qla2xxx/qla_os.c          |    2 +-
 drivers/scsi/sata_mv.c                 |    2 +-
 drivers/scsi/sata_nv.c                 |    2 +-
 drivers/scsi/sata_promise.c            |    2 +-
 drivers/scsi/sata_qstor.c              |    2 +-
 drivers/scsi/sata_sil.c                |    2 +-
 drivers/scsi/sata_sil24.c              |    2 +-
 drivers/scsi/sata_sis.c                |    2 +-
 drivers/scsi/sata_svw.c                |    2 +-
 drivers/scsi/sata_sx4.c                |    2 +-
 drivers/scsi/sata_uli.c                |    2 +-
 drivers/scsi/sata_via.c                |    2 +-
 drivers/scsi/sata_vsc.c                |    2 +-
 drivers/scsi/tmscsim.c                 |    2 +-
 35 files changed, 36 insertions(+), 36 deletions(-)

applies-to: bbfea846e5360ffdd245fb04b9e5680457b56994
c67a3af36f75ae7b8923a8c332ccdfdeb1f3dbc9
diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 3ff74f4..954bc4b 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -2206,7 +2206,7 @@ static int __init twa_init(void)
 {
 	printk(KERN_WARNING "3ware 9000 Storage Controller device driver for Linux v%s.\n", TW_DRIVER_VERSION);
 
-	return pci_module_init(&twa_driver);
+	return pci_register_driver(&twa_driver);
 } /* End twa_init() */
 
 /* This function is called on driver exit */
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 283f6d2..fdc1359 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2482,7 +2482,7 @@ static int __init tw_init(void)
 {
 	printk(KERN_WARNING "3ware Storage Controller device driver for Linux v%s.\n", TW_DRIVER_VERSION);
 
-	return pci_module_init(&tw_driver);
+	return pci_register_driver(&tw_driver);
 } /* End tw_init() */
 
 /* This function is called on driver exit */
diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index 9f45ae1..2944dc6 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -1186,7 +1186,7 @@ static struct pci_driver inia100_pci_dri
 
 static int __init inia100_init(void)
 {
-	return pci_module_init(&inia100_pci_driver);
+	return pci_register_driver(&inia100_pci_driver);
 }
 
 static void __exit inia100_exit(void)
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 83467a0..92c5b83 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1140,7 +1140,7 @@ static void ahci_remove_one (struct pci_
 
 static int __init ahci_init(void)
 {
-	return pci_module_init(&ahci_pci_driver);
+	return pci_register_driver(&ahci_pci_driver);
 }
 
 static void __exit ahci_exit(void)
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
index bf360ae..12872af 100644
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
index cb30d9c..bb89827 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
@@ -246,7 +246,7 @@ int
 ahc_linux_pci_init(void)
 {
 	/* Translate error or zero return into zero or one */
-	return pci_module_init(&aic7xxx_pci_driver) ? 0 : 1;
+	return pci_register_driver(&aic7xxx_pci_driver) ? 0 : 1;
 }
 
 void
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 333d69d..3c1aa25 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -684,8 +684,8 @@ static int __init piix_init(void)
 {
 	int rc;
 
-	DPRINTK("pci_module_init\n");
-	rc = pci_module_init(&piix_pci_driver);
+	DPRINTK("pci_register_driver\n");
+	rc = pci_register_driver(&piix_pci_driver);
 	if (rc)
 		return rc;
 
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index c8a32cf..3d19215 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4921,7 +4921,7 @@ static struct pci_driver dc395x_driver =
  **/
 static int __init dc395x_module_init(void)
 {
-	return pci_module_init(&dc395x_driver);
+	return pci_register_driver(&dc395x_driver);
 }
 
 
diff --git a/drivers/scsi/dmx3191d.c b/drivers/scsi/dmx3191d.c
index 7905b90..46aaaf8 100644
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
index fa2cb35..89e6757 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6644,7 +6644,7 @@ static int __init ipr_init(void)
 	ipr_info("IBM Power RAID SCSI Device Driver version: %s %s\n",
 		 IPR_DRIVER_VERSION, IPR_DRIVER_DATE);
 
-	return pci_module_init(&ipr_driver);
+	return pci_register_driver(&ipr_driver);
 }
 
 /**
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 3882d48..5bb9670 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -7073,7 +7073,7 @@ ips_remove_device(struct pci_dev *pci_de
 static int __init
 ips_module_init(void)
 {
-	if (pci_module_init(&ips_pci_driver) < 0)
+	if (pci_register_driver(&ips_pci_driver) < 0)
 		return -ENODEV;
 	ips_driver_template.module = THIS_MODULE;
 	ips_order_controllers();
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index f979252..085c430 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -5081,7 +5081,7 @@ static int __init megaraid_init(void)
 				"megaraid: failed to create megaraid root\n");
 	}
 #endif
-	error = pci_module_init(&megaraid_pci_driver);
+	error = pci_register_driver(&megaraid_pci_driver);
 	if (error) {
 #ifdef CONFIG_PROC_FS
 		remove_proc_entry("megaraid", &proc_root);
diff --git a/drivers/scsi/megaraid/megaraid_sas.c b/drivers/scsi/megaraid/megaraid_sas.c
index 3c32e69..1cd5c6c 100644
--- a/drivers/scsi/megaraid/megaraid_sas.c
+++ b/drivers/scsi/megaraid/megaraid_sas.c
@@ -2768,7 +2768,7 @@ static int __init megasas_init(void)
 	/*
 	 * Register ourselves as PCI hotplug module
 	 */
-	rval = pci_module_init(&megasas_pci_driver);
+	rval = pci_register_driver(&megasas_pci_driver);
 
 	if (rval) {
 		printk(KERN_DEBUG "megasas: PCI hotplug regisration failed \n");
diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index a279ebb..0c0f25f 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -3574,7 +3574,7 @@ static struct pci_driver nsp32_driver = 
  */
 static int __init init_nsp32(void) {
 	nsp32_msg(KERN_INFO, "loading...");
-	return pci_module_init(&nsp32_driver);
+	return pci_register_driver(&nsp32_driver);
 }
 
 static void __exit exit_nsp32(void) {
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index f557f17..0c99b54 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -722,7 +722,7 @@ err_out:
 
 static int __init adma_ata_init(void)
 {
-	return pci_module_init(&adma_ata_pci_driver);
+	return pci_register_driver(&adma_ata_pci_driver);
 }
 
 static void __exit adma_ata_exit(void)
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 0878f95..3f4a4a3 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -4772,7 +4772,7 @@ qla1280_init(void)
 		qla1280_setup(qla1280);
 #endif
 
-	return pci_module_init(&qla1280_pci_driver);
+	return pci_register_driver(&qla1280_pci_driver);
 }
 
 static void __exit
diff --git a/drivers/scsi/qla2xxx/ql2100.c b/drivers/scsi/qla2xxx/ql2100.c
index f5db223..e5e7185 100644
--- a/drivers/scsi/qla2xxx/ql2100.c
+++ b/drivers/scsi/qla2xxx/ql2100.c
@@ -73,7 +73,7 @@ static struct pci_driver qla2100_pci_dri
 static int __init
 qla2100_init(void)
 {
-	return pci_module_init(&qla2100_pci_driver);
+	return pci_register_driver(&qla2100_pci_driver);
 }
 
 static void __exit
diff --git a/drivers/scsi/qla2xxx/ql2200.c b/drivers/scsi/qla2xxx/ql2200.c
index 0eef72d..519e750 100644
--- a/drivers/scsi/qla2xxx/ql2200.c
+++ b/drivers/scsi/qla2xxx/ql2200.c
@@ -73,7 +73,7 @@ static struct pci_driver qla2200_pci_dri
 static int __init
 qla2200_init(void)
 {
-	return pci_module_init(&qla2200_pci_driver);
+	return pci_register_driver(&qla2200_pci_driver);
 }
 
 static void __exit
diff --git a/drivers/scsi/qla2xxx/ql2300.c b/drivers/scsi/qla2xxx/ql2300.c
index fd2f4b7..8289f46 100644
--- a/drivers/scsi/qla2xxx/ql2300.c
+++ b/drivers/scsi/qla2xxx/ql2300.c
@@ -84,7 +84,7 @@ static struct pci_driver qla2300_pci_dri
 static int __init
 qla2300_init(void)
 {
-	return pci_module_init(&qla2300_pci_driver);
+	return pci_register_driver(&qla2300_pci_driver);
 }
 
 static void __exit
diff --git a/drivers/scsi/qla2xxx/ql2322.c b/drivers/scsi/qla2xxx/ql2322.c
index c88a22c..0633a21 100644
--- a/drivers/scsi/qla2xxx/ql2322.c
+++ b/drivers/scsi/qla2xxx/ql2322.c
@@ -89,7 +89,7 @@ static struct pci_driver qla2322_pci_dri
 static int __init
 qla2322_init(void)
 {
-	return pci_module_init(&qla2322_pci_driver);
+	return pci_register_driver(&qla2322_pci_driver);
 }
 
 static void __exit
diff --git a/drivers/scsi/qla2xxx/ql6312.c b/drivers/scsi/qla2xxx/ql6312.c
index de55397..3c80dcb 100644
--- a/drivers/scsi/qla2xxx/ql6312.c
+++ b/drivers/scsi/qla2xxx/ql6312.c
@@ -83,7 +83,7 @@ static struct pci_driver qla6312_pci_dri
 static int __init
 qla6312_init(void)
 {
-	return pci_module_init(&qla6312_pci_driver);
+	return pci_register_driver(&qla6312_pci_driver);
 }
 
 static void __exit
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index c58c9d9..e8c647b 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2565,7 +2565,7 @@ qla2x00_module_init(void)
 		return -ENODEV;
 
 	printk(KERN_INFO "QLogic Fibre Channel HBA Driver\n");
-	ret = pci_module_init(&qla2xxx_pci_driver);
+	ret = pci_register_driver(&qla2xxx_pci_driver);
 	if (ret) {
 		kmem_cache_destroy(srb_cachep);
 		fc_release_transport(qla2xxx_transport_template);
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index ab7432a..31eb12d 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -2229,7 +2229,7 @@ err_out:
 
 static int __init mv_init(void)
 {
-	return pci_module_init(&mv_pci_driver);
+	return pci_register_driver(&mv_pci_driver);
 }
 
 static void __exit mv_exit(void)
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 4954896..a76ffd9 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -591,7 +591,7 @@ static void nv_check_hotplug_ck804(struc
 
 static int __init nv_init(void)
 {
-	return pci_module_init(&nv_pci_driver);
+	return pci_register_driver(&nv_pci_driver);
 }
 
 static void __exit nv_exit(void)
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 8a8e3e3..e8dff47 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -743,7 +743,7 @@ err_out:
 
 static int __init pdc_ata_init(void)
 {
-	return pci_module_init(&pdc_ata_pci_driver);
+	return pci_register_driver(&pdc_ata_pci_driver);
 }
 
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index a8987f5..8824174 100644
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
index 3609186..e9cc283 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -512,7 +512,7 @@ err_out:
 
 static int __init sil_init(void)
 {
-	return pci_module_init(&sil_pci_driver);
+	return pci_register_driver(&sil_pci_driver);
 }
 
 static void __exit sil_exit(void)
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index e0d6f19..4f01e30 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -1017,7 +1017,7 @@ static int sil24_init_one(struct pci_dev
 
 static int __init sil24_init(void)
 {
-	return pci_module_init(&sil24_pci_driver);
+	return pci_register_driver(&sil24_pci_driver);
 }
 
 static void __exit sil24_exit(void)
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 32e1262..ceda6ad 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -335,7 +335,7 @@ err_out:
 
 static int __init sis_init(void)
 {
-	return pci_module_init(&sis_pci_driver);
+	return pci_register_driver(&sis_pci_driver);
 }
 
 static void __exit sis_exit(void)
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 6e7f7c8..55e0675 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -485,7 +485,7 @@ static struct pci_driver k2_sata_pci_dri
 
 static int __init k2_sata_init(void)
 {
-	return pci_module_init(&k2_sata_pci_driver);
+	return pci_register_driver(&k2_sata_pci_driver);
 }
 
 
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index dcc3ad9..bae1847 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -1495,7 +1495,7 @@ err_out:
 
 static int __init pdc_sata_init(void)
 {
-	return pci_module_init(&pdc_sata_pci_driver);
+	return pci_register_driver(&pdc_sata_pci_driver);
 }
 
 
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index b2422a0..5669611 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -272,7 +272,7 @@ err_out:
 
 static int __init uli_init(void)
 {
-	return pci_module_init(&uli_pci_driver);
+	return pci_register_driver(&uli_pci_driver);
 }
 
 static void __exit uli_exit(void)
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index c762156..63a77d3 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -382,7 +382,7 @@ err_out:
 
 static int __init svia_init(void)
 {
-	return pci_module_init(&svia_pci_driver);
+	return pci_register_driver(&svia_pci_driver);
 }
 
 static void __exit svia_exit(void)
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index fcfa486..be6cf48 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -417,7 +417,7 @@ static struct pci_driver vsc_sata_pci_dr
 
 static int __init vsc_sata_init(void)
 {
-	return pci_module_init(&vsc_sata_pci_driver);
+	return pci_register_driver(&vsc_sata_pci_driver);
 }
 
 
diff --git a/drivers/scsi/tmscsim.c b/drivers/scsi/tmscsim.c
index 91322af..f86a74c 100644
--- a/drivers/scsi/tmscsim.c
+++ b/drivers/scsi/tmscsim.c
@@ -2671,7 +2671,7 @@ static int __init dc390_module_init(void
 		printk (KERN_INFO "DC390: Using safe settings.\n");
 	}
 
-	return pci_module_init(&dc390_driver);
+	return pci_register_driver(&dc390_driver);
 }
 
 static void __exit dc390_module_exit(void)
---
0.99.9k


