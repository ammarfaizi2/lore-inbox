Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267317AbUHWTAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbUHWTAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUHWS6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:58:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:14532 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267323AbUHWShJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:09 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860893685@kroah.com>
Date: Mon, 23 Aug 2004 11:34:49 -0700
Message-Id: <10932860893300@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.44, 2004/08/10 16:29:24-07:00, dsaxena@plexity.net

[PATCH] Remove spaces from PCI IDE pci_driver.name field

Spaces in driver names show up as spaces in sysfs. Annoying.
I went ahead and changed ones that don't have spaces to use
${NAME}_IDE so they are all consistent.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/ide/pci/aec62xx.c      |    2 +-
 drivers/ide/pci/alim15x3.c     |    2 +-
 drivers/ide/pci/amd74xx.c      |    2 +-
 drivers/ide/pci/atiixp.c       |    2 +-
 drivers/ide/pci/cmd64x.c       |    2 +-
 drivers/ide/pci/cs5520.c       |    2 +-
 drivers/ide/pci/cy82c693.c     |    2 +-
 drivers/ide/pci/generic.c      |    2 +-
 drivers/ide/pci/hpt34x.c       |    2 +-
 drivers/ide/pci/hpt366.c       |    2 +-
 drivers/ide/pci/it8172.c       |    2 +-
 drivers/ide/pci/ns87415.c      |    2 +-
 drivers/ide/pci/opti621.c      |    2 +-
 drivers/ide/pci/pdc202xx_new.c |    2 +-
 drivers/ide/pci/pdc202xx_old.c |    2 +-
 drivers/ide/pci/piix.c         |    2 +-
 drivers/ide/pci/rz1000.c       |    2 +-
 drivers/ide/pci/sc1200.c       |    2 +-
 drivers/ide/pci/serverworks.c  |    2 +-
 drivers/ide/pci/sgiioc4.c      |    2 +-
 drivers/ide/pci/siimage.c      |    2 +-
 drivers/ide/pci/sis5513.c      |    2 +-
 drivers/ide/pci/sl82c105.c     |    2 +-
 drivers/ide/pci/slc90e66.c     |    2 +-
 drivers/ide/pci/triflex.c      |    2 +-
 drivers/ide/pci/trm290.c       |    2 +-
 drivers/ide/pci/via82cxxx.c    |    2 +-
 27 files changed, 27 insertions(+), 27 deletions(-)


diff -Nru a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
--- a/drivers/ide/pci/aec62xx.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/aec62xx.c	2004-08-23 11:02:27 -07:00
@@ -540,7 +540,7 @@
 MODULE_DEVICE_TABLE(pci, aec62xx_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "AEC62xx IDE",
+	.name		= "AEC62xx_IDE",
 	.id_table	= aec62xx_pci_tbl,
 	.probe		= aec62xx_init_one,
 };
diff -Nru a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
--- a/drivers/ide/pci/alim15x3.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/alim15x3.c	2004-08-23 11:02:27 -07:00
@@ -893,7 +893,7 @@
 MODULE_DEVICE_TABLE(pci, alim15x3_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "ALI15x3 IDE",
+	.name		= "ALI15x3_IDE",
 	.id_table	= alim15x3_pci_tbl,
 	.probe		= alim15x3_init_one,
 };
diff -Nru a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/amd74xx.c	2004-08-23 11:02:27 -07:00
@@ -520,7 +520,7 @@
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "AMD IDE",
+	.name		= "AMD_IDE",
 	.id_table	= amd74xx_pci_tbl,
 	.probe		= amd74xx_probe,
 };
diff -Nru a/drivers/ide/pci/atiixp.c b/drivers/ide/pci/atiixp.c
--- a/drivers/ide/pci/atiixp.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/atiixp.c	2004-08-23 11:02:27 -07:00
@@ -490,7 +490,7 @@
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "ATIIXP IDE",
+	.name		= "ATIIXP_IDE",
 	.id_table	= atiixp_pci_tbl,
 	.probe		= atiixp_init_one,
 };
diff -Nru a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
--- a/drivers/ide/pci/cmd64x.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/cmd64x.c	2004-08-23 11:02:27 -07:00
@@ -760,7 +760,7 @@
 MODULE_DEVICE_TABLE(pci, cmd64x_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "CMD64x IDE",
+	.name		= "CMD64x_IDE",
 	.id_table	= cmd64x_pci_tbl,
 	.probe		= cmd64x_init_one,
 };
diff -Nru a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
--- a/drivers/ide/pci/cs5520.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/cs5520.c	2004-08-23 11:02:27 -07:00
@@ -319,7 +319,7 @@
 MODULE_DEVICE_TABLE(pci, cs5520_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "CyrixIDE",
+	.name		= "Cyrix_IDE",
 	.id_table	= cs5520_pci_tbl,
 	.probe		= cs5520_init_one,
 };
diff -Nru a/drivers/ide/pci/cy82c693.c b/drivers/ide/pci/cy82c693.c
--- a/drivers/ide/pci/cy82c693.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/cy82c693.c	2004-08-23 11:02:27 -07:00
@@ -444,7 +444,7 @@
 MODULE_DEVICE_TABLE(pci, cy82c693_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "Cypress IDE",
+	.name		= "Cypress_IDE",
 	.id_table	= cy82c693_pci_tbl,
 	.probe		= cy82c693_init_one,
 };
diff -Nru a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
--- a/drivers/ide/pci/generic.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/generic.c	2004-08-23 11:02:27 -07:00
@@ -138,7 +138,7 @@
 MODULE_DEVICE_TABLE(pci, generic_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "PCI IDE",
+	.name		= "PCI_IDE",
 	.id_table	= generic_pci_tbl,
 	.probe		= generic_init_one,
 };
diff -Nru a/drivers/ide/pci/hpt34x.c b/drivers/ide/pci/hpt34x.c
--- a/drivers/ide/pci/hpt34x.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/hpt34x.c	2004-08-23 11:02:27 -07:00
@@ -339,7 +339,7 @@
 MODULE_DEVICE_TABLE(pci, hpt34x_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "HPT34x IDE",
+	.name		= "HPT34x_IDE",
 	.id_table	= hpt34x_pci_tbl,
 	.probe		= hpt34x_init_one,
 };
diff -Nru a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
--- a/drivers/ide/pci/hpt366.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/hpt366.c	2004-08-23 11:02:27 -07:00
@@ -1403,7 +1403,7 @@
 MODULE_DEVICE_TABLE(pci, hpt366_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "HPT366 IDE",
+	.name		= "HPT366_IDE",
 	.id_table	= hpt366_pci_tbl,
 	.probe		= hpt366_init_one,
 };
diff -Nru a/drivers/ide/pci/it8172.c b/drivers/ide/pci/it8172.c
--- a/drivers/ide/pci/it8172.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/it8172.c	2004-08-23 11:02:27 -07:00
@@ -302,7 +302,7 @@
 MODULE_DEVICE_TABLE(pci, it8172_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "IT8172IDE",
+	.name		= "IT8172_IDE",
 	.id_table	= it8172_pci_tbl,
 	.probe		= it8172_init_one,
 };
diff -Nru a/drivers/ide/pci/ns87415.c b/drivers/ide/pci/ns87415.c
--- a/drivers/ide/pci/ns87415.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/ns87415.c	2004-08-23 11:02:27 -07:00
@@ -236,7 +236,7 @@
 MODULE_DEVICE_TABLE(pci, ns87415_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "NS87415IDE",
+	.name		= "NS87415_IDE",
 	.id_table	= ns87415_pci_tbl,
 	.probe		= ns87415_init_one,
 };
diff -Nru a/drivers/ide/pci/opti621.c b/drivers/ide/pci/opti621.c
--- a/drivers/ide/pci/opti621.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/opti621.c	2004-08-23 11:02:27 -07:00
@@ -367,7 +367,7 @@
 MODULE_DEVICE_TABLE(pci, opti621_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "Opti621 IDE",
+	.name		= "Opti621_IDE",
 	.id_table	= opti621_pci_tbl,
 	.probe		= opti621_init_one,
 };
diff -Nru a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_new.c
--- a/drivers/ide/pci/pdc202xx_new.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/pdc202xx_new.c	2004-08-23 11:02:27 -07:00
@@ -531,7 +531,7 @@
 MODULE_DEVICE_TABLE(pci, pdc202new_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "Promise IDE",
+	.name		= "Promise_IDE",
 	.id_table	= pdc202new_pci_tbl,
 	.probe		= pdc202new_init_one,
 };
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/pdc202xx_old.c	2004-08-23 11:02:27 -07:00
@@ -905,7 +905,7 @@
 MODULE_DEVICE_TABLE(pci, pdc202xx_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "Promise Old IDE",
+	.name		= "Promise_Old_IDE",
 	.id_table	= pdc202xx_pci_tbl,
 	.probe		= pdc202xx_init_one,
 };
diff -Nru a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/piix.c	2004-08-23 11:02:27 -07:00
@@ -803,7 +803,7 @@
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "PIIX IDE",
+	.name		= "PIIX_IDE",
 	.id_table	= piix_pci_tbl,
 	.probe		= piix_init_one,
 };
diff -Nru a/drivers/ide/pci/rz1000.c b/drivers/ide/pci/rz1000.c
--- a/drivers/ide/pci/rz1000.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/rz1000.c	2004-08-23 11:02:27 -07:00
@@ -74,7 +74,7 @@
 MODULE_DEVICE_TABLE(pci, rz1000_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "RZ1000 IDE",
+	.name		= "RZ1000_IDE",
 	.id_table	= rz1000_pci_tbl,
 	.probe		= rz1000_init_one,
 };
diff -Nru a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
--- a/drivers/ide/pci/sc1200.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/sc1200.c	2004-08-23 11:02:27 -07:00
@@ -565,7 +565,7 @@
 MODULE_DEVICE_TABLE(pci, sc1200_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "SC1200 IDE",
+	.name		= "SC1200_IDE",
 	.id_table	= sc1200_pci_tbl,
 	.probe		= sc1200_init_one,
 	.suspend	= sc1200_suspend,
diff -Nru a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverworks.c
--- a/drivers/ide/pci/serverworks.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/serverworks.c	2004-08-23 11:02:27 -07:00
@@ -812,7 +812,7 @@
 MODULE_DEVICE_TABLE(pci, svwks_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "Serverworks IDE",
+	.name		= "Serverworks_IDE",
 	.id_table	= svwks_pci_tbl,
 	.probe		= svwks_init_one,
 #if 0	/* FIXME: implement */
diff -Nru a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
--- a/drivers/ide/pci/sgiioc4.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/sgiioc4.c	2004-08-23 11:02:27 -07:00
@@ -782,7 +782,7 @@
 MODULE_DEVICE_TABLE(pci, sgiioc4_pci_tbl);
 
 static struct pci_driver driver = {
-	.name = "SGI-IOC4 IDE",
+	.name = "SGI-IOC4_IDE",
 	.id_table = sgiioc4_pci_tbl,
 	.probe = sgiioc4_init_one,
 };
diff -Nru a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/siimage.c	2004-08-23 11:02:27 -07:00
@@ -1137,7 +1137,7 @@
 MODULE_DEVICE_TABLE(pci, siimage_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "SiI IDE",
+	.name		= "SiI_IDE",
 	.id_table	= siimage_pci_tbl,
 	.probe		= siimage_init_one,
 };
diff -Nru a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
--- a/drivers/ide/pci/sis5513.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/sis5513.c	2004-08-23 11:02:27 -07:00
@@ -968,7 +968,7 @@
 MODULE_DEVICE_TABLE(pci, sis5513_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "SIS IDE",
+	.name		= "SIS_IDE",
 	.id_table	= sis5513_pci_tbl,
 	.probe		= sis5513_init_one,
 };
diff -Nru a/drivers/ide/pci/sl82c105.c b/drivers/ide/pci/sl82c105.c
--- a/drivers/ide/pci/sl82c105.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/sl82c105.c	2004-08-23 11:02:27 -07:00
@@ -503,7 +503,7 @@
 MODULE_DEVICE_TABLE(pci, sl82c105_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "W82C105 IDE",
+	.name		= "W82C105_IDE",
 	.id_table	= sl82c105_pci_tbl,
 	.probe		= sl82c105_init_one,
 };
diff -Nru a/drivers/ide/pci/slc90e66.c b/drivers/ide/pci/slc90e66.c
--- a/drivers/ide/pci/slc90e66.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/slc90e66.c	2004-08-23 11:02:27 -07:00
@@ -387,7 +387,7 @@
 MODULE_DEVICE_TABLE(pci, slc90e66_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "SLC90e66 IDE",
+	.name		= "SLC90e66_IDE",
 	.id_table	= slc90e66_pci_tbl,
 	.probe		= slc90e66_init_one,
 };
diff -Nru a/drivers/ide/pci/triflex.c b/drivers/ide/pci/triflex.c
--- a/drivers/ide/pci/triflex.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/triflex.c	2004-08-23 11:02:27 -07:00
@@ -242,7 +242,7 @@
 MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "TRIFLEX IDE",
+	.name		= "TRIFLEX_IDE",
 	.id_table	= triflex_pci_tbl,
 	.probe		= triflex_init_one,
 };
diff -Nru a/drivers/ide/pci/trm290.c b/drivers/ide/pci/trm290.c
--- a/drivers/ide/pci/trm290.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/trm290.c	2004-08-23 11:02:27 -07:00
@@ -408,7 +408,7 @@
 MODULE_DEVICE_TABLE(pci, trm290_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "TRM290 IDE",
+	.name		= "TRM290_IDE",
 	.id_table	= trm290_pci_tbl,
 	.probe		= trm290_init_one,
 };
diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	2004-08-23 11:02:27 -07:00
+++ b/drivers/ide/pci/via82cxxx.c	2004-08-23 11:02:27 -07:00
@@ -632,7 +632,7 @@
 MODULE_DEVICE_TABLE(pci, via_pci_tbl);
 
 static struct pci_driver driver = {
-	.name 		= "VIA IDE",
+	.name 		= "VIA_IDE",
 	.id_table 	= via_pci_tbl,
 	.probe 		= via_init_one,
 };

