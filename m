Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTFJVig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTFJVhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:37:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8098 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263205AbTFJShB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709682819@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709672299@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1355, 2003/06/09 16:03:33-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/dmx3191d.c


 drivers/scsi/dmx3191d.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)


diff -Nru a/drivers/scsi/dmx3191d.c b/drivers/scsi/dmx3191d.c
--- a/drivers/scsi/dmx3191d.c	Tue Jun 10 11:19:26 2003
+++ b/drivers/scsi/dmx3191d.c	Tue Jun 10 11:19:26 2003
@@ -58,11 +58,6 @@
 	struct Scsi_Host *instance = NULL;
 	struct pci_dev *pdev = NULL;
 
-	if (!pci_present()) {
-		printk(KERN_WARNING "dmx3191: PCI support not enabled\n");
-		return 0;
-	}
-
 	tmpl->proc_name = DMX3191D_DRIVER_NAME;
 
 	while ((pdev = pci_find_device(PCI_VENDOR_ID_DOMEX,
@@ -139,3 +134,4 @@
         .use_clustering		= DISABLE_CLUSTERING,
 };
 #include "scsi_module.c"
+

