Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTFJUc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTFJUcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:32:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:17071 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263952AbTFJShT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:19 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709681849@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709681203@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1359, 2003/06/09 16:05:39-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/pci2000.c


 drivers/scsi/pci2000.c |    7 -------
 1 files changed, 7 deletions(-)


diff -Nru a/drivers/scsi/pci2000.c b/drivers/scsi/pci2000.c
--- a/drivers/scsi/pci2000.c	Tue Jun 10 11:19:03 2003
+++ b/drivers/scsi/pci2000.c	Tue Jun 10 11:19:03 2003
@@ -668,13 +668,6 @@
 	UCHAR			   *consistent;
 	dma_addr_t			consistentDma;
 
-
-	if ( !pci_present () )
-		{
-		printk ("pci2000: PCI BIOS not present\n");
-		return 0;
-		}
-
 	while ( (pdev = pci_find_device (VENDOR_PSI, DEVICE_ROY_1, pdev)) != NULL )
 		{
 		if (pci_enable_device(pdev))

