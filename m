Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTFJT3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTFJSjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:39:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:897 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262818AbTFJShq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:46 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709664024@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709662296@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1341, 2003/06/09 15:50:55-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/sk98lin/skge.c


 drivers/net/sk98lin/skge.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
--- a/drivers/net/sk98lin/skge.c	Tue Jun 10 11:20:43 2003
+++ b/drivers/net/sk98lin/skge.c	Tue Jun 10 11:20:43 2003
@@ -409,9 +409,6 @@
 		printk("%s\n", BootString);
 	}
 
-	if (!pci_present())		/* is PCI support present? */
-		return -ENODEV;
-
 	while((pdev = pci_find_device(PCI_VENDOR_ID_SYSKONNECT,
 				      PCI_DEVICE_ID_SYSKONNECT_GE, pdev)) != NULL) {
 

