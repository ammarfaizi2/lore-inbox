Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTFJSix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbTFJShs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:37:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63649 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262861AbTFJSg4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:36:56 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709653937@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709643664@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:25 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1324, 2003/06/09 15:33:18-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/char/istallion.c


 drivers/char/istallion.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c	Tue Jun 10 11:22:04 2003
+++ b/drivers/char/istallion.c	Tue Jun 10 11:22:04 2003
@@ -4670,9 +4670,6 @@
 	printk("stli_findpcibrds()\n");
 #endif
 
-	if (! pci_present())
-		return(0);
-
 	while ((dev = pci_find_device(PCI_VENDOR_ID_STALLION,
 	    PCI_DEVICE_ID_ECRA, dev))) {
 		if ((rc = stli_initpcibrd(BRD_ECPPCI, dev)))

