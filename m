Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTFJVgn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTFJVfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:35:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:41116 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263818AbTFJShI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:08 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709684190@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709683957@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1362, 2003/06/09 16:07:53-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/qlogicfc.c


 drivers/scsi/qlogicfc.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/drivers/scsi/qlogicfc.c b/drivers/scsi/qlogicfc.c
--- a/drivers/scsi/qlogicfc.c	Tue Jun 10 11:18:48 2003
+++ b/drivers/scsi/qlogicfc.c	Tue Jun 10 11:18:48 2003
@@ -711,11 +711,6 @@
 
 	tmpt->proc_name = "isp2x00";
 
-	if (pci_present() == 0) {
-		printk(KERN_INFO "qlogicfc : PCI not present\n");
-		return 0;
-	}
-
 	for (i=0; i<2; i++){
 		pdev = NULL;
 	        while ((pdev = pci_find_device(PCI_VENDOR_ID_QLOGIC, device_ids[i], pdev))) {

