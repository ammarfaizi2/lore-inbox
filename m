Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVLAM64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVLAM64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVLAM6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:58:55 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:27646 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932205AbVLAM6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:58:54 -0500
Date: Thu, 1 Dec 2005 13:58:49 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051201130358.28376.11359.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051201130338.28376.65935.sendpatchset@thinktank.campus.ltu.se>
References: <20051201130338.28376.65935.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 2.6.15-rc3-mm1 1/3] drivers: Replace pci_module_init() with pci_register_driver() in -mm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Replace obsolete pci_module_init() with pci_register_driver().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 edac/amd76x_edac.c       |    2 +-
 edac/e7xxx_edac.c        |    2 +-
 edac/r82600_edac.c       |    2 +-
 net/sky2.c               |    2 +-
 net/wireless/tiacx/pci.c |    2 +-
 scsi/arcmsr/arcmsr.c     |    2 +-
 scsi/pata_amd.c          |    2 +-
 scsi/pata_opti.c         |    2 +-
 scsi/pata_pdc2027x.c     |    2 +-
 scsi/pata_sil680.c       |    2 +-
 scsi/pata_triflex.c      |    2 +-
 scsi/pata_via.c          |    2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff -Narup a/drivers/edac/amd76x_edac.c b/drivers/edac/amd76x_edac.c
--- a/drivers/edac/amd76x_edac.c	2005-12-01 01:35:41.000000000 +0100
+++ b/drivers/edac/amd76x_edac.c	2005-12-01 01:52:23.000000000 +0100
@@ -340,7 +340,7 @@ static struct pci_driver amd76x_driver =
 
 int __init amd76x_init(void)
 {
-	return pci_module_init(&amd76x_driver);
+	return pci_register_driver(&amd76x_driver);
 }
 
 static void __exit amd76x_exit(void)
diff -Narup a/drivers/edac/e7xxx_edac.c b/drivers/edac/e7xxx_edac.c
--- a/drivers/edac/e7xxx_edac.c	2005-12-01 01:35:41.000000000 +0100
+++ b/drivers/edac/e7xxx_edac.c	2005-12-01 01:52:23.000000000 +0100
@@ -539,7 +539,7 @@ static struct pci_driver e7xxx_driver = 
 
 int __init e7xxx_init(void)
 {
-	return pci_module_init(&e7xxx_driver);
+	return pci_register_driver(&e7xxx_driver);
 }
 
 
diff -Narup a/drivers/edac/r82600_edac.c b/drivers/edac/r82600_edac.c
--- a/drivers/edac/r82600_edac.c	2005-12-01 01:35:41.000000000 +0100
+++ b/drivers/edac/r82600_edac.c	2005-12-01 01:52:23.000000000 +0100
@@ -383,7 +383,7 @@ static struct pci_driver r82600_driver =
 
 int __init r82600_init(void)
 {
-	return pci_module_init(&r82600_driver);
+	return pci_register_driver(&r82600_driver);
 }
 
 
diff -Narup a/drivers/net/sky2.c b/drivers/net/sky2.c
--- a/drivers/net/sky2.c	2005-12-01 01:35:51.000000000 +0100
+++ b/drivers/net/sky2.c	2005-12-01 01:52:23.000000000 +0100
@@ -3023,7 +3023,7 @@ static struct pci_driver sky2_driver = {
 
 static int __init sky2_init_module(void)
 {
-	return pci_module_init(&sky2_driver);
+	return pci_register_driver(&sky2_driver);
 }
 
 static void __exit sky2_cleanup_module(void)
diff -Narup a/drivers/net/wireless/tiacx/pci.c b/drivers/net/wireless/tiacx/pci.c
--- a/drivers/net/wireless/tiacx/pci.c	2005-12-01 01:35:49.000000000 +0100
+++ b/drivers/net/wireless/tiacx/pci.c	2005-12-01 01:52:23.000000000 +0100
@@ -4607,7 +4607,7 @@ acxpci_e_init_module(void)
 	acxlog(L_INIT, "PCI module " WLAN_RELEASE " initialized, "
 		"waiting for cards to probe...\n");
 
-	res = pci_module_init(&acxpci_drv_id);
+	res = pci_register_driver(&acxpci_drv_id);
 	FN_EXIT1(res);
 	return res;
 }
diff -Narup a/drivers/scsi/arcmsr/arcmsr.c b/drivers/scsi/arcmsr/arcmsr.c
--- a/drivers/scsi/arcmsr/arcmsr.c	2005-12-01 01:35:58.000000000 +0100
+++ b/drivers/scsi/arcmsr/arcmsr.c	2005-12-01 01:52:23.000000000 +0100
@@ -519,7 +519,7 @@ static int arcmsr_scsi_host_template_ini
 	 ** register as a PCI hot-plug driver module
 	 */
 	memset(pHCBARC, 0, sizeof(struct _HCBARC));
-	error = pci_module_init(&arcmsr_pci_driver);
+	error = pci_register_driver(&arcmsr_pci_driver);
 	if (pHCBARC->pACB[0] != NULL) {
 		host_template->proc_name = "arcmsr";
 		register_reboot_notifier(&arcmsr_event_notifier);
diff -Narup a/drivers/scsi/pata_amd.c b/drivers/scsi/pata_amd.c
--- a/drivers/scsi/pata_amd.c	2005-12-01 01:35:57.000000000 +0100
+++ b/drivers/scsi/pata_amd.c	2005-12-01 01:52:23.000000000 +0100
@@ -625,7 +625,7 @@ static struct pci_driver amd_pci_driver 
 
 static int __init amd_init(void)
 {
-	return pci_module_init(&amd_pci_driver);
+	return pci_register_driver(&amd_pci_driver);
 }
 
 static void __exit amd_exit(void)
diff -Narup a/drivers/scsi/pata_opti.c b/drivers/scsi/pata_opti.c
--- a/drivers/scsi/pata_opti.c	2005-12-01 01:35:57.000000000 +0100
+++ b/drivers/scsi/pata_opti.c	2005-12-01 01:52:23.000000000 +0100
@@ -247,7 +247,7 @@ static struct pci_driver opti_pci_driver
 
 static int __init opti_init(void)
 {
-	return pci_module_init(&opti_pci_driver);
+	return pci_register_driver(&opti_pci_driver);
 }
 
 
diff -Narup a/drivers/scsi/pata_pdc2027x.c b/drivers/scsi/pata_pdc2027x.c
--- a/drivers/scsi/pata_pdc2027x.c	2005-12-01 01:35:57.000000000 +0100
+++ b/drivers/scsi/pata_pdc2027x.c	2005-12-01 01:52:23.000000000 +0100
@@ -840,7 +840,7 @@ static void __devexit pdc2027x_remove_on
  */
 static int __init pdc2027x_init(void)
 {
-	return pci_module_init(&pdc2027x_pci_driver);
+	return pci_register_driver(&pdc2027x_pci_driver);
 }
 
 /**
diff -Narup a/drivers/scsi/pata_sil680.c b/drivers/scsi/pata_sil680.c
--- a/drivers/scsi/pata_sil680.c	2005-12-01 01:35:56.000000000 +0100
+++ b/drivers/scsi/pata_sil680.c	2005-12-01 01:52:23.000000000 +0100
@@ -341,7 +341,7 @@ static struct pci_driver sil680_pci_driv
 
 static int __init sil680_init(void)
 {
-	return pci_module_init(&sil680_pci_driver);
+	return pci_register_driver(&sil680_pci_driver);
 }
 
 
diff -Narup a/drivers/scsi/pata_triflex.c b/drivers/scsi/pata_triflex.c
--- a/drivers/scsi/pata_triflex.c	2005-12-01 01:35:59.000000000 +0100
+++ b/drivers/scsi/pata_triflex.c	2005-12-01 01:52:23.000000000 +0100
@@ -247,7 +247,7 @@ static struct pci_driver triflex_pci_dri
 
 static int __init triflex_init(void)
 {
-	return pci_module_init(&triflex_pci_driver);
+	return pci_register_driver(&triflex_pci_driver);
 }
 
 
diff -Narup a/drivers/scsi/pata_via.c b/drivers/scsi/pata_via.c
--- a/drivers/scsi/pata_via.c	2005-12-01 01:35:59.000000000 +0100
+++ b/drivers/scsi/pata_via.c	2005-12-01 01:52:23.000000000 +0100
@@ -491,7 +491,7 @@ static struct pci_driver via_pci_driver 
 
 static int __init via_init(void)
 {
-	return pci_module_init(&via_pci_driver);
+	return pci_register_driver(&via_pci_driver);
 }
 
 
