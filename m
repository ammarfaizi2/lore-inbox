Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVJZUzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVJZUzI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVJZUzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:55:05 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:1228 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S964926AbVJZUyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:54:41 -0400
X-Mailbox-Line: From laurent@antares.localdomain mer oct 26 22:49:09 2005
Message-Id: <20051026204909.576265000@antares.localdomain>
References: <20051026204802.123045000@antares.localdomain>
Date: Wed, 26 Oct 2005 22:48:04 +0200
From: Laurent riffard <laurent.riffard@free.fr>
To: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>,
       Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [RFC patch 2/3] remove pci_driver.owner and .name fields
Content-Disposition: inline; filename=remove_pci_driver_owner_name-drivers_block.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use pci_driver.driver.name instead of pci_driver.name (this field is
planned for deletion).

This patch updates the drivers found in directory drivers/block.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/block/DAC960.c   |    4 +++-
 drivers/block/cciss.c    |    4 +++-
 drivers/block/cpqarray.c |    4 +++-
 drivers/block/sx8.c      |    4 +++-
 drivers/block/umem.c     |    4 +++-
 5 files changed, 15 insertions(+), 5 deletions(-)

Index: linux-2.6-stable/drivers/block/DAC960.c
===================================================================
--- linux-2.6-stable.orig/drivers/block/DAC960.c
+++ linux-2.6-stable/drivers/block/DAC960.c
@@ -7185,7 +7185,9 @@
 MODULE_DEVICE_TABLE(pci, DAC960_id_table);
 
 static struct pci_driver DAC960_pci_driver = {
-	.name		= "DAC960",
+	.driver = {
+		.name	= "DAC960",
+	},
 	.id_table	= DAC960_id_table,
 	.probe		= DAC960_Probe,
 	.remove		= DAC960_Remove,
Index: linux-2.6-stable/drivers/block/cciss.c
===================================================================
--- linux-2.6-stable.orig/drivers/block/cciss.c
+++ linux-2.6-stable/drivers/block/cciss.c
@@ -2929,7 +2929,9 @@
 }	
 
 static struct pci_driver cciss_pci_driver = {
-	.name =		"cciss",
+	.driver = {
+		.name =	"cciss",
+	},
 	.probe =	cciss_init_one,
 	.remove =	__devexit_p(cciss_remove_one),
 	.id_table =	cciss_pci_device_id, /* id_table */
Index: linux-2.6-stable/drivers/block/cpqarray.c
===================================================================
--- linux-2.6-stable.orig/drivers/block/cpqarray.c
+++ linux-2.6-stable/drivers/block/cpqarray.c
@@ -541,7 +541,9 @@
 }
 
 static struct pci_driver cpqarray_pci_driver = {
-	.name = "cpqarray",
+	.driver = {
+		.name = "cpqarray",
+	},
 	.probe = cpqarray_init_one,
 	.remove = __devexit_p(cpqarray_remove_one_pci),
 	.id_table = cpqarray_pci_device_id,
Index: linux-2.6-stable/drivers/block/sx8.c
===================================================================
--- linux-2.6-stable.orig/drivers/block/sx8.c
+++ linux-2.6-stable/drivers/block/sx8.c
@@ -395,7 +395,9 @@
 MODULE_DEVICE_TABLE(pci, carm_pci_tbl);
 
 static struct pci_driver carm_driver = {
-	.name		= DRV_NAME,
+	.driver = {
+		.name	= DRV_NAME,
+	},
 	.id_table	= carm_pci_tbl,
 	.probe		= carm_init_one,
 	.remove		= carm_remove_one,
Index: linux-2.6-stable/drivers/block/umem.c
===================================================================
--- linux-2.6-stable.orig/drivers/block/umem.c
+++ linux-2.6-stable/drivers/block/umem.c
@@ -1170,7 +1170,9 @@
 MODULE_DEVICE_TABLE(pci, mm_pci_ids);
 
 static struct pci_driver mm_pci_driver = {
-	.name =		"umem",
+	.driver = {
+		.name =	"umem",
+	},
 	.id_table =	mm_pci_ids,
 	.probe =	mm_pci_probe,
 	.remove =	mm_pci_remove,

--

