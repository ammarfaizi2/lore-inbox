Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVJVUnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVJVUnp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 16:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVJVUnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 16:43:40 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:30361 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750980AbVJVUnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 16:43:22 -0400
X-Mailbox-Line: From laurent@antares.localdomain sam oct 22 21:41:45 2005
Message-Id: <20051022194144.750460000@antares.localdomain>
References: <20051022194123.683082000@antares.localdomain>
Date: Sat, 22 Oct 2005 21:41:28 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] SyncLink adapters: updates .owner field of struct pci_driver
Content-Disposition: inline; filename=synclink_pci_driver_owner_field.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates .owner field of struct pci_driver.

This allows SYSFS to create the symlink from the driver to the
module which provides it.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>

--
 drivers/char/synclink.c   |    1 +
 drivers/char/synclinkmp.c |    1 +
 2 files changed, 2 insertions(+)

Index: linux-2.6-stable/drivers/char/synclink.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/synclink.c
+++ linux-2.6-stable/drivers/char/synclink.c
@@ -912,6 +912,7 @@
 MODULE_LICENSE("GPL");
 
 static struct pci_driver synclink_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "synclink",
 	.id_table	= synclink_pci_tbl,
 	.probe		= synclink_init_one,
Index: linux-2.6-stable/drivers/char/synclinkmp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/synclinkmp.c
+++ linux-2.6-stable/drivers/char/synclinkmp.c
@@ -501,6 +501,7 @@
 MODULE_LICENSE("GPL");
 
 static struct pci_driver synclinkmp_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "synclinkmp",
 	.id_table	= synclinkmp_pci_tbl,
 	.probe		= synclinkmp_init_one,

--

