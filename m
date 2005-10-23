Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVJWUye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVJWUye (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 16:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVJWUye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 16:54:34 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51645 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750789AbVJWUye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 16:54:34 -0400
X-Mailbox-Line: From laurent@antares.localdomain dim oct 23 22:49:56 2005
Message-Id: <20051023204956.213142000@antares.localdomain>
References: <20051023204947.430464000@antares.localdomain>
Date: Sun, 23 Oct 2005 22:49:48 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
To: linux-kernel@vger.kernel.org, dmo@osdl.org, mike.miller@hp.com,
       iss_storagedev@hp.com, Jeff Garzik <garzik@pobox.com>
Subject: [patch] drivers/block: updates .owner field of struct pci_driver
Content-Disposition: inline; filename=driver_block_pci_driver_owner_field.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates .owner field of struct pci_driver.

This allows SYSFS to create the symlink from the driver to the
module which provides it.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/block/DAC960.c   |    1 +
 drivers/block/cciss.c    |    1 +
 drivers/block/cpqarray.c |    1 +
 drivers/block/sx8.c      |    1 +
 drivers/block/umem.c     |    1 +
 5 files changed, 5 insertions(+)

Index: linux-2.6-stable/drivers/block/DAC960.c
===================================================================
--- linux-2.6-stable.orig/drivers/block/DAC960.c
+++ linux-2.6-stable/drivers/block/DAC960.c
@@ -7185,6 +7185,7 @@
 MODULE_DEVICE_TABLE(pci, DAC960_id_table);
 
 static struct pci_driver DAC960_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "DAC960",
 	.id_table	= DAC960_id_table,
 	.probe		= DAC960_Probe,
Index: linux-2.6-stable/drivers/block/cciss.c
===================================================================
--- linux-2.6-stable.orig/drivers/block/cciss.c
+++ linux-2.6-stable/drivers/block/cciss.c
@@ -2929,6 +2929,7 @@
 }	
 
 static struct pci_driver cciss_pci_driver = {
+	.owner =	THIS_MODULE,
 	.name =		"cciss",
 	.probe =	cciss_init_one,
 	.remove =	__devexit_p(cciss_remove_one),
Index: linux-2.6-stable/drivers/block/cpqarray.c
===================================================================
--- linux-2.6-stable.orig/drivers/block/cpqarray.c
+++ linux-2.6-stable/drivers/block/cpqarray.c
@@ -541,6 +541,7 @@
 }
 
 static struct pci_driver cpqarray_pci_driver = {
+	.owner = THIS_MODULE,
 	.name = "cpqarray",
 	.probe = cpqarray_init_one,
 	.remove = __devexit_p(cpqarray_remove_one_pci),
Index: linux-2.6-stable/drivers/block/sx8.c
===================================================================
--- linux-2.6-stable.orig/drivers/block/sx8.c
+++ linux-2.6-stable/drivers/block/sx8.c
@@ -395,6 +395,7 @@
 MODULE_DEVICE_TABLE(pci, carm_pci_tbl);
 
 static struct pci_driver carm_driver = {
+	.owner		= THIS_MODULE,
 	.name		= DRV_NAME,
 	.id_table	= carm_pci_tbl,
 	.probe		= carm_init_one,
Index: linux-2.6-stable/drivers/block/umem.c
===================================================================
--- linux-2.6-stable.orig/drivers/block/umem.c
+++ linux-2.6-stable/drivers/block/umem.c
@@ -1170,6 +1170,7 @@
 MODULE_DEVICE_TABLE(pci, mm_pci_ids);
 
 static struct pci_driver mm_pci_driver = {
+	.owner =	THIS_MODULE,
 	.name =		"umem",
 	.id_table =	mm_pci_ids,
 	.probe =	mm_pci_probe,

--

