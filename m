Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTFJVig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTFJVhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:37:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:48639 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263264AbTFJShC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709671915@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270966103@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1344, 2003/06/09 15:52:15-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/tulip/de4x5.c


 drivers/net/tulip/de4x5.c |    6 ------
 1 files changed, 6 deletions(-)


diff -Nru a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
--- a/drivers/net/tulip/de4x5.c	Tue Jun 10 11:20:28 2003
+++ b/drivers/net/tulip/de4x5.c	Tue Jun 10 11:20:28 2003
@@ -2182,11 +2182,6 @@
 
     if (lastPCI == NO_MORE_PCI) return;
 
-    if (!pci_present()) {
-	lastPCI = NO_MORE_PCI;
-	return;          /* No PCI bus in this machine! */
-    }
-    
     lp->bus = PCI;
     lp->bus_num = 0;
 
@@ -5863,7 +5858,6 @@
 	if (EISA_signature(name, EISA_ID)) j++;
     }
 #endif
-    if (!pci_present()) return j;
 
     for (i=0; (pdev=pci_find_class(class, pdev))!= NULL; i++) {
 	vendor = pdev->vendor;

