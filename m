Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTFJTJI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTFJSmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:42:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:24453 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264043AbTFJShc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:32 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709663468@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709664024@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1342, 2003/06/09 15:51:21-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/skfp/skfddi.c


 drivers/net/skfp/skfddi.c |    4 ----
 1 files changed, 4 deletions(-)


diff -Nru a/drivers/net/skfp/skfddi.c b/drivers/net/skfp/skfddi.c
--- a/drivers/net/skfp/skfddi.c	Tue Jun 10 11:20:39 2003
+++ b/drivers/net/skfp/skfddi.c	Tue Jun 10 11:20:39 2003
@@ -298,10 +298,6 @@
 	printk("%s\n", boot_msg);
 
 	/* Scan for Syskonnect FDDI PCI controllers */
-	if (!pci_present()) {	/* is PCI BIOS even present? */
-		printk("no PCI BIOS present\n");
-		return (-ENODEV);
-	}
 	for (i = 0; i < SKFP_MAX_NUM_BOARDS; i++) {	// scan for PCI cards
 		PRINTK(KERN_INFO "Check device %d\n", i);
 		if ((pdev=pci_find_device(PCI_VENDOR_ID_SK, PCI_DEVICE_ID_SK_FP,

