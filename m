Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263189AbVCDXVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbVCDXVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbVCDXTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:19:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:43682 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263191AbVCDUy6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:58 -0500
Cc: gregkh@suse.de
Subject: PCI: remove pci_find_device usage from pci sysfs code.
In-Reply-To: <11099696382684@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:58 -0800
Message-Id: <11099696382576@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.23, 2005/02/25 08:26:11-08:00, gregkh@suse.de

PCI: remove pci_find_device usage from pci sysfs code.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/pci-sysfs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	2005-03-04 12:41:33 -08:00
+++ b/drivers/pci/pci-sysfs.c	2005-03-04 12:41:33 -08:00
@@ -481,7 +481,7 @@
 	struct pci_dev *pdev = NULL;
 	
 	sysfs_initialized = 1;
-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL)
+	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL)
 		pci_create_sysfs_dev_files(pdev);
 
 	return 0;

