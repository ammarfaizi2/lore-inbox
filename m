Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTFJSpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTFJSoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:44:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:53666 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264015AbTFJSh1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:27 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709681370@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709684190@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1363, 2003/06/09 16:08:18-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/qlogicisp.c


 drivers/scsi/qlogicisp.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/drivers/scsi/qlogicisp.c b/drivers/scsi/qlogicisp.c
--- a/drivers/scsi/qlogicisp.c	Tue Jun 10 11:18:43 2003
+++ b/drivers/scsi/qlogicisp.c	Tue Jun 10 11:18:43 2003
@@ -666,11 +666,6 @@
 
 	tmpt->proc_name = "isp1020";
 
-	if (pci_present() == 0) {
-		printk("qlogicisp : PCI not present\n");
-		return 0;
-	}
-
 	while ((pdev = pci_find_device(PCI_VENDOR_ID_QLOGIC, PCI_DEVICE_ID_QLOGIC_ISP1020, pdev)))
 	{
 		if (pci_enable_device(pdev))

