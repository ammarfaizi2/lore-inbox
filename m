Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTFJVgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbTFJVgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:36:18 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52142 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263452AbTFJShF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:05 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709661346@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709653253@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1333, 2003/06/09 15:38:57-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/isdn/hysdn/hysdn_init.c


 drivers/isdn/hysdn/hysdn_init.c |    4 ----
 1 files changed, 4 deletions(-)


diff -Nru a/drivers/isdn/hysdn/hysdn_init.c b/drivers/isdn/hysdn/hysdn_init.c
--- a/drivers/isdn/hysdn/hysdn_init.c	Tue Jun 10 11:21:22 2003
+++ b/drivers/isdn/hysdn/hysdn_init.c	Tue Jun 10 11:21:22 2003
@@ -203,10 +203,6 @@
 	printk(KERN_NOTICE "HYSDN: module Rev: %s loaded\n", hysdn_getrev(tmp));
 	strcpy(tmp, hysdn_net_revision);
 	printk(KERN_NOTICE "HYSDN: network interface Rev: %s \n", hysdn_getrev(tmp));
-	if (!pci_present()) {
-		printk(KERN_ERR "HYSDN: no PCI bus present, module not loaded\n");
-		return (-1);
-	}
 	search_cards();
 	printk(KERN_INFO "HYSDN: %d card(s) found.\n", cardmax);
 

