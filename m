Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbVJVUni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVJVUni (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 16:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVJVUni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 16:43:38 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:30948 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751044AbVJVUnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 16:43:24 -0400
Date: Sat, 22 Oct 2005 21:52:46 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.11) Gecko/20050729
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm] Multi-Tech serial card: updates .owner field of struct
 pci_driver
References: <20051022133650.960391000@antares.localdomain>
In-Reply-To: <20051022133650.960391000@antares.localdomain>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename=isicom_pci_driver_owner_field.patch
Message-Id: <20051022204322.08B253712F@smtp3-g19.free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates .owner field of struct pci_driver.

This allows SYSFS to create the symlink from the driver to the
module which provides it.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>

--

 drivers/char/isicom.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6-mm/drivers/char/isicom.c
===================================================================
--- linux-2.6-mm.orig/drivers/char/isicom.c
+++ linux-2.6-mm/drivers/char/isicom.c
@@ -163,6 +163,7 @@
 MODULE_DEVICE_TABLE(pci, isicom_pci_tbl);
 
 static struct pci_driver isicom_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "isicom",
 	.id_table	= isicom_pci_tbl,
 	.probe		= isicom_probe,

--



