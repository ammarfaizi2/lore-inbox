Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVJWVPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVJWVPF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 17:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVJWVPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 17:15:04 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:9876 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750777AbVJWVPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 17:15:02 -0400
X-Mailbox-Line: From laurent@antares.localdomain dim oct 23 23:09:40 2005
Message-Id: <20051023210940.512241000@antares.localdomain>
References: <20051023210900.994245000@antares.localdomain>
Date: Sun, 23 Oct 2005 23:09:16 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
To: linux-kernel@vger.kernel.org
Subject: [patch -mm] drivers/edac: updates .owner field of struct pci_driver
Content-Disposition: inline; filename=driver_edac_pci_driver_owner_field.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates .owner field of struct pci_driver.

This allows SYSFS to create the symlink from the driver to the
module which provides it.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/edac/amd76x_edac.c  |    1 +
 drivers/edac/e7xxx_edac.c   |    1 +
 drivers/edac/i82875p_edac.c |    1 +
 drivers/edac/r82600_edac.c  |    1 +
 4 files changed, 4 insertions(+)

Index: linux-2.6-mm/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6-mm.orig/drivers/edac/amd76x_edac.c
+++ linux-2.6-mm/drivers/edac/amd76x_edac.c
@@ -332,6 +332,7 @@
 
 
 static struct pci_driver amd76x_driver = {
+	.owner = THIS_MODULE,
 	.name = BS_MOD_STR,
 	.probe = amd76x_init_one,
 	.remove = __devexit_p(amd76x_remove_one),
Index: linux-2.6-mm/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6-mm.orig/drivers/edac/e7xxx_edac.c
+++ linux-2.6-mm/drivers/edac/e7xxx_edac.c
@@ -530,6 +530,7 @@
 
 
 static struct pci_driver e7xxx_driver = {
+	.owner = THIS_MODULE,
 	.name = BS_MOD_STR,
 	.probe = e7xxx_init_one,
 	.remove = __devexit_p(e7xxx_remove_one),
Index: linux-2.6-mm/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6-mm.orig/drivers/edac/i82875p_edac.c
+++ linux-2.6-mm/drivers/edac/i82875p_edac.c
@@ -476,6 +476,7 @@
 
 
 static struct pci_driver i82875p_driver = {
+	.owner = THIS_MODULE,
 	.name = BS_MOD_STR,
 	.probe = i82875p_init_one,
 	.remove = __devexit_p(i82875p_remove_one),
Index: linux-2.6-mm/drivers/edac/r82600_edac.c
===================================================================
--- linux-2.6-mm.orig/drivers/edac/r82600_edac.c
+++ linux-2.6-mm/drivers/edac/r82600_edac.c
@@ -374,6 +374,7 @@
 
 
 static struct pci_driver r82600_driver = {
+	.owner = THIS_MODULE,
 	.name = BS_MOD_STR,
 	.probe = r82600_init_one,
 	.remove = __devexit_p(r82600_remove_one),

--

