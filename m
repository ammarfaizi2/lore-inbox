Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbVIVHtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbVIVHtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVIVHtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:49:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:1971 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751444AbVIVHs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:48:57 -0400
Date: Thu, 22 Sep 2005 00:48:02 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       bjorn.helgaas@hp.com
Subject: [patch 05/18] PCI: remove unused "scratch"
Message-ID: <20050922074802.GF15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-remove-unused-scratch.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Unused variable.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/hotplug.c |    4 ----
 1 file changed, 4 deletions(-)

--- scsi-2.6.orig/drivers/pci/hotplug.c	2005-09-20 05:59:55.000000000 -0700
+++ scsi-2.6/drivers/pci/hotplug.c	2005-09-21 17:29:27.000000000 -0700
@@ -7,7 +7,6 @@
 		 char *buffer, int buffer_size)
 {
 	struct pci_dev *pdev;
-	char *scratch;
 	int i = 0;
 	int length = 0;
 
@@ -18,9 +17,6 @@
 	if (!pdev)
 		return -ENODEV;
 
-	scratch = buffer;
-
-
 	if (add_hotplug_env_var(envp, num_envp, &i,
 				buffer, buffer_size, &length,
 				"PCI_CLASS=%04X", pdev->class))

--
