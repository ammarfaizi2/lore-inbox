Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTFJUsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTFJUrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:47:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:32930 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263921AbTFJShQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:16 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709682767@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709681849@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1360, 2003/06/09 16:06:09-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/pci2220i.c


 drivers/scsi/pci2220i.c |    6 ------
 1 files changed, 6 deletions(-)


diff -Nru a/drivers/scsi/pci2220i.c b/drivers/scsi/pci2220i.c
--- a/drivers/scsi/pci2220i.c	Tue Jun 10 11:18:58 2003
+++ b/drivers/scsi/pci2220i.c	Tue Jun 10 11:18:58 2003
@@ -2534,12 +2534,6 @@
 	UCHAR				device;
 	struct pci_dev	   *pcidev = NULL;
 
-	if ( !pci_present () )
-		{
-		printk ("pci2220i: PCI BIOS not present\n");
-		return 0;
-		}
-
 	while ( (pcidev = pci_find_device (VENDOR_PSI, DEVICE_DALE_1, pcidev)) != NULL )
 		{
 		if (pci_enable_device(pcidev))

