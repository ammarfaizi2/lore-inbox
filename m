Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTFJTJG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTFJSm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:42:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:64418 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264047AbTFJShc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:32 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709683957@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709682767@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1361, 2003/06/09 16:07:27-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/qla1280.c


 drivers/scsi/qla1280.c |    6 ------
 1 files changed, 6 deletions(-)


diff -Nru a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
--- a/drivers/scsi/qla1280.c	Tue Jun 10 11:18:53 2003
+++ b/drivers/scsi/qla1280.c	Tue Jun 10 11:18:53 2003
@@ -360,7 +360,6 @@
  */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 0)
 #define pci_set_dma_mask(dev, mask)		dev->dma_mask = mask;
-#define pci_present()				pcibios_present()
 #define pci_enable_device(pdev)			0
 #define pci_find_subsys(id, dev, sid, sdev, pdev) pci_find_device(id,dev,pdev)
 #define scsi_set_pci_device(host, pdev)
@@ -1008,11 +1007,6 @@
 	       "arguments to\n"
 	       "qla1280: insmod or else it might trash certain memory areas.\n");
 #endif
-
-	if (!pci_present()) {
-		printk(KERN_INFO "scsi: PCI not present\n");
-		return 0;
-	}
 
 	bdp = &ql1280_board_tbl[0];
 	qla1280_hostlist = NULL;

