Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTFJS7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTFJSnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:43:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34479 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264037AbTFJShb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:31 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709641390@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709641345@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:24 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1319, 2003/06/09 15:30:39-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/atm/fore200e.c


 drivers/atm/fore200e.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
--- a/drivers/atm/fore200e.c	Tue Jun 10 11:22:27 2003
+++ b/drivers/atm/fore200e.c	Tue Jun 10 11:22:27 2003
@@ -633,11 +633,6 @@
     struct pci_dev*  pci_dev = NULL;
     int              count = index;
     
-    if (pci_present() == 0) {
-	printk(FORE200E "no PCI subsystem\n");
-	return NULL;
-    }
-
     do {
 	pci_dev = pci_find_device(PCI_VENDOR_ID_FORE, PCI_DEVICE_ID_FORE_PCA200E, pci_dev);
 	if (pci_dev == NULL)

