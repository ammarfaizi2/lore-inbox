Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVAQWWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVAQWWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVAQWV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:21:58 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:34021 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262912AbVAQWCK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:02:10 -0500
Cc: dhowells@redhat.com
Subject: [PATCH] PCI: Downgrade printk that complains about unsupported PCI PM caps
In-Reply-To: <11059993121957@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 14:01:52 -0800
Message-Id: <11059993123253@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.6, 2005/01/14 15:58:36-08:00, dhowells@redhat.com

[PATCH] PCI: Downgrade printk that complains about unsupported PCI PM caps

The attached patch downgrades to KERN_DEBUG level the printk that issues a
notification that an unsupported version of the PCI power management registers
has been encountered by pci_set_power_state().

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2005-01-17 13:55:49 -08:00
+++ b/drivers/pci/pci.c	2005-01-17 13:55:49 -08:00
@@ -269,7 +269,7 @@
 
 	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
 	if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
-		printk(KERN_WARNING
+		printk(KERN_DEBUG
 		       "PCI: %s has unsupported PM cap regs version (%u)\n",
 		       dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
 		return -EIO;

