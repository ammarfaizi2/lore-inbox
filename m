Return-Path: <linux-kernel-owner+w=401wt.eu-S1751595AbXALEXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbXALEXX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbXALEXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:23:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbXALEXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:23:04 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=sHY+6BxQIT/nm6GDCIN7IYCc3YOhsf9NSXJTGoD0JusZwexaqmQfE7CL3XlfY/43DwA60oGT40QUyswNpZKNXw0Vb0Eqoj3TjYVWa2//LUj2EaFKBs/c9fTs+zqnkkf5OaZUg/0Co2Y61V4csximssQQKpQvu1U8nhkM+rOWfZg=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:26:40 +0100
Message-Id: <20070112042640.28794.80063.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 5/19] ide: add missing __init tags to IDE PCI host drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: add missing __init tags to IDE PCI host drivers

also change __devinit tag for sgiioc4.c:ioc4_ide_init() to __init

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/aec62xx.c      |    2 +-
 drivers/ide/pci/alim15x3.c     |    2 +-
 drivers/ide/pci/amd74xx.c      |    2 +-
 drivers/ide/pci/atiixp.c       |    2 +-
 drivers/ide/pci/cmd64x.c       |    2 +-
 drivers/ide/pci/cs5520.c       |    2 +-
 drivers/ide/pci/cs5530.c       |    2 +-
 drivers/ide/pci/cy82c693.c     |    2 +-
 drivers/ide/pci/generic.c      |    2 +-
 drivers/ide/pci/hpt34x.c       |    2 +-
 drivers/ide/pci/hpt366.c       |    2 +-
 drivers/ide/pci/ns87415.c      |    2 +-
 drivers/ide/pci/opti621.c      |    2 +-
 drivers/ide/pci/pdc202xx_new.c |    2 +-
 drivers/ide/pci/pdc202xx_old.c |    2 +-
 drivers/ide/pci/rz1000.c       |    2 +-
 drivers/ide/pci/sc1200.c       |    2 +-
 drivers/ide/pci/serverworks.c  |    2 +-
 drivers/ide/pci/sgiioc4.c      |    3 +--
 drivers/ide/pci/siimage.c      |    2 +-
 drivers/ide/pci/sis5513.c      |    2 +-
 drivers/ide/pci/sl82c105.c     |    2 +-
 drivers/ide/pci/slc90e66.c     |    2 +-
 drivers/ide/pci/tc86c001.c     |    2 +-
 drivers/ide/pci/triflex.c      |    2 +-
 drivers/ide/pci/trm290.c       |    2 +-
 drivers/ide/pci/via82cxxx.c    |    2 +-
 27 files changed, 27 insertions(+), 28 deletions(-)

Index: a/drivers/ide/pci/aec62xx.c
===================================================================
--- a.orig/drivers/ide/pci/aec62xx.c
+++ a/drivers/ide/pci/aec62xx.c
@@ -441,7 +441,7 @@ static struct pci_driver driver = {
 	.probe		= aec62xx_init_one,
 };
 
-static int aec62xx_ide_init(void)
+static int __init aec62xx_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/alim15x3.c
===================================================================
--- a.orig/drivers/ide/pci/alim15x3.c
+++ a/drivers/ide/pci/alim15x3.c
@@ -907,7 +907,7 @@ static struct pci_driver driver = {
 	.probe		= alim15x3_init_one,
 };
 
-static int ali15x3_ide_init(void)
+static int __init ali15x3_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/amd74xx.c
===================================================================
--- a.orig/drivers/ide/pci/amd74xx.c
+++ a/drivers/ide/pci/amd74xx.c
@@ -544,7 +544,7 @@ static struct pci_driver driver = {
 	.probe		= amd74xx_probe,
 };
 
-static int amd74xx_ide_init(void)
+static int __init amd74xx_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/atiixp.c
===================================================================
--- a.orig/drivers/ide/pci/atiixp.c
+++ a/drivers/ide/pci/atiixp.c
@@ -376,7 +376,7 @@ static struct pci_driver driver = {
 	.probe		= atiixp_init_one,
 };
 
-static int atiixp_ide_init(void)
+static int __init atiixp_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/cmd64x.c
===================================================================
--- a.orig/drivers/ide/pci/cmd64x.c
+++ a/drivers/ide/pci/cmd64x.c
@@ -793,7 +793,7 @@ static struct pci_driver driver = {
 	.probe		= cmd64x_init_one,
 };
 
-static int cmd64x_ide_init(void)
+static int __init cmd64x_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/cs5520.c
===================================================================
--- a.orig/drivers/ide/pci/cs5520.c
+++ a/drivers/ide/pci/cs5520.c
@@ -260,7 +260,7 @@ static struct pci_driver driver = {
 	.probe		= cs5520_init_one,
 };
 
-static int cs5520_ide_init(void)
+static int __init cs5520_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/cs5530.c
===================================================================
--- a.orig/drivers/ide/pci/cs5530.c
+++ a/drivers/ide/pci/cs5530.c
@@ -374,7 +374,7 @@ static struct pci_driver driver = {
 	.probe		= cs5530_init_one,
 };
 
-static int cs5530_ide_init(void)
+static int __init cs5530_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/cy82c693.c
===================================================================
--- a.orig/drivers/ide/pci/cy82c693.c
+++ a/drivers/ide/pci/cy82c693.c
@@ -519,7 +519,7 @@ static struct pci_driver driver = {
 	.probe		= cy82c693_init_one,
 };
 
-static int cy82c693_ide_init(void)
+static int __init cy82c693_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/generic.c
===================================================================
--- a.orig/drivers/ide/pci/generic.c
+++ a/drivers/ide/pci/generic.c
@@ -263,7 +263,7 @@ static struct pci_driver driver = {
 	.probe		= generic_init_one,
 };
 
-static int generic_ide_init(void)
+static int __init generic_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/hpt34x.c
===================================================================
--- a.orig/drivers/ide/pci/hpt34x.c
+++ a/drivers/ide/pci/hpt34x.c
@@ -265,7 +265,7 @@ static struct pci_driver driver = {
 	.probe		= hpt34x_init_one,
 };
 
-static int hpt34x_ide_init(void)
+static int __init hpt34x_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/hpt366.c
===================================================================
--- a.orig/drivers/ide/pci/hpt366.c
+++ a/drivers/ide/pci/hpt366.c
@@ -1668,7 +1668,7 @@ static struct pci_driver driver = {
 	.probe		= hpt366_init_one,
 };
 
-static int hpt366_ide_init(void)
+static int __init hpt366_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/ns87415.c
===================================================================
--- a.orig/drivers/ide/pci/ns87415.c
+++ a/drivers/ide/pci/ns87415.c
@@ -302,7 +302,7 @@ static struct pci_driver driver = {
 	.probe		= ns87415_init_one,
 };
 
-static int ns87415_ide_init(void)
+static int __init ns87415_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/opti621.c
===================================================================
--- a.orig/drivers/ide/pci/opti621.c
+++ a/drivers/ide/pci/opti621.c
@@ -382,7 +382,7 @@ static struct pci_driver driver = {
 	.probe		= opti621_init_one,
 };
 
-static int opti621_ide_init(void)
+static int __init opti621_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a.orig/drivers/ide/pci/pdc202xx_new.c
+++ a/drivers/ide/pci/pdc202xx_new.c
@@ -716,7 +716,7 @@ static struct pci_driver driver = {
 	.probe		= pdc202new_init_one,
 };
 
-static int pdc202new_ide_init(void)
+static int __init pdc202new_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a.orig/drivers/ide/pci/pdc202xx_old.c
+++ a/drivers/ide/pci/pdc202xx_old.c
@@ -704,7 +704,7 @@ static struct pci_driver driver = {
 	.probe		= pdc202xx_init_one,
 };
 
-static int pdc202xx_ide_init(void)
+static int __init pdc202xx_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/rz1000.c
===================================================================
--- a.orig/drivers/ide/pci/rz1000.c
+++ a/drivers/ide/pci/rz1000.c
@@ -77,7 +77,7 @@ static struct pci_driver driver = {
 	.probe		= rz1000_init_one,
 };
 
-static int rz1000_ide_init(void)
+static int __init rz1000_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/sc1200.c
===================================================================
--- a.orig/drivers/ide/pci/sc1200.c
+++ a/drivers/ide/pci/sc1200.c
@@ -507,7 +507,7 @@ static struct pci_driver driver = {
 #endif
 };
 
-static int sc1200_ide_init(void)
+static int __init sc1200_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/serverworks.c
===================================================================
--- a.orig/drivers/ide/pci/serverworks.c
+++ a/drivers/ide/pci/serverworks.c
@@ -666,7 +666,7 @@ static struct pci_driver driver = {
 	.probe		= svwks_init_one,
 };
 
-static int svwks_ide_init(void)
+static int __init svwks_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/sgiioc4.c
===================================================================
--- a.orig/drivers/ide/pci/sgiioc4.c
+++ a/drivers/ide/pci/sgiioc4.c
@@ -762,8 +762,7 @@ static struct ioc4_submodule ioc4_ide_su
 /*	.is_remove = ioc4_ide_remove_one,	*/
 };
 
-static int __devinit
-ioc4_ide_init(void)
+static int __init ioc4_ide_init(void)
 {
 	return ioc4_register_submodule(&ioc4_ide_submodule);
 }
Index: a/drivers/ide/pci/siimage.c
===================================================================
--- a.orig/drivers/ide/pci/siimage.c
+++ a/drivers/ide/pci/siimage.c
@@ -1096,7 +1096,7 @@ static struct pci_driver driver = {
 	.probe		= siimage_init_one,
 };
 
-static int siimage_ide_init(void)
+static int __init siimage_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/sis5513.c
===================================================================
--- a.orig/drivers/ide/pci/sis5513.c
+++ a/drivers/ide/pci/sis5513.c
@@ -968,7 +968,7 @@ static struct pci_driver driver = {
 	.probe		= sis5513_init_one,
 };
 
-static int sis5513_ide_init(void)
+static int __init sis5513_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/sl82c105.c
===================================================================
--- a.orig/drivers/ide/pci/sl82c105.c
+++ a/drivers/ide/pci/sl82c105.c
@@ -492,7 +492,7 @@ static struct pci_driver driver = {
 	.probe		= sl82c105_init_one,
 };
 
-static int sl82c105_ide_init(void)
+static int __init sl82c105_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/slc90e66.c
===================================================================
--- a.orig/drivers/ide/pci/slc90e66.c
+++ a/drivers/ide/pci/slc90e66.c
@@ -266,7 +266,7 @@ static struct pci_driver driver = {
 	.probe		= slc90e66_init_one,
 };
 
-static int slc90e66_ide_init(void)
+static int __init slc90e66_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/tc86c001.c
===================================================================
--- a.orig/drivers/ide/pci/tc86c001.c
+++ a/drivers/ide/pci/tc86c001.c
@@ -298,7 +298,7 @@ static struct pci_driver driver = {
 	.probe		= tc86c001_init_one
 };
 
-static int tc86c001_ide_init(void)
+static int __init tc86c001_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/triflex.c
===================================================================
--- a.orig/drivers/ide/pci/triflex.c
+++ a/drivers/ide/pci/triflex.c
@@ -173,7 +173,7 @@ static struct pci_driver driver = {
 	.probe		= triflex_init_one,
 };
 
-static int triflex_ide_init(void)
+static int __init triflex_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/trm290.c
===================================================================
--- a.orig/drivers/ide/pci/trm290.c
+++ a/drivers/ide/pci/trm290.c
@@ -355,7 +355,7 @@ static struct pci_driver driver = {
 	.probe		= trm290_init_one,
 };
 
-static int trm290_ide_init(void)
+static int __init trm290_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
Index: a/drivers/ide/pci/via82cxxx.c
===================================================================
--- a.orig/drivers/ide/pci/via82cxxx.c
+++ a/drivers/ide/pci/via82cxxx.c
@@ -514,7 +514,7 @@ static struct pci_driver driver = {
 	.probe 		= via_init_one,
 };
 
-static int via_ide_init(void)
+static int __init via_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
