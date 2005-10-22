Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVJVUnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVJVUnp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 16:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVJVUnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 16:43:39 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:54724 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750923AbVJVUnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 16:43:22 -0400
X-Mailbox-Line: From laurent@antares.localdomain sam oct 22 21:41:44 2005
Message-Id: <20051022194144.374550000@antares.localdomain>
References: <20051022194123.683082000@antares.localdomain>
Date: Sat, 22 Oct 2005 21:41:27 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
To: Eng.Linux@digi.com, Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] epca: updates .owner field of struct pci_driver
Content-Disposition: inline; filename=epca_pci_driver_owner_field.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates .owner field of struct pci_driver.

This allows SYSFS to create the symlink from the driver to the
module which provides it.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>

--
 drivers/char/epca.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6-stable/drivers/char/epca.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/epca.c
+++ linux-2.6-stable/drivers/char/epca.c
@@ -3777,6 +3777,7 @@
 int __init init_PCI (void)
 { /* Begin init_PCI */
 	memset (&epca_driver, 0, sizeof (epca_driver));
+	epca_driver.owner = THIS_MODULE;
 	epca_driver.name = "epca";
 	epca_driver.id_table = epca_pci_tbl;
 	epca_driver.probe = epca_init_one;

--

