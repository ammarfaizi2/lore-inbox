Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270112AbUJSXbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270112AbUJSXbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270157AbUJSX1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:27:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:14986 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270156AbUJSWqg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:36 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257381647@kroah.com>
Date: Tue, 19 Oct 2004 15:42:18 -0700
Message-Id: <10982257383197@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.53, 2004/10/06 13:47:41-07:00, greg@kroah.com

PCI Hotplug: Oops, didn't mean to apply the msi pci express patch, so revert it

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/pciehp_hpc.c |    2 --
 drivers/pci/hotplug/shpchp_hpc.c |    1 -
 2 files changed, 3 deletions(-)


diff -Nru a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
--- a/drivers/pci/hotplug/pciehp_hpc.c	2004-10-19 15:22:50 -07:00
+++ b/drivers/pci/hotplug/pciehp_hpc.c	2004-10-19 15:22:50 -07:00
@@ -741,8 +741,6 @@
 		if (php_ctlr->irq) {
 			free_irq(php_ctlr->irq, ctrl);
 			php_ctlr->irq = 0;
-			if (!pcie_mch_quirk) 
-				pci_disable_msi(php_ctlr->pci_dev);
 		}
 	}
 	if (php_ctlr->pci_dev) 
diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	2004-10-19 15:22:50 -07:00
+++ b/drivers/pci/hotplug/shpchp_hpc.c	2004-10-19 15:22:50 -07:00
@@ -792,7 +792,6 @@
 		if (php_ctlr->irq) {
 			free_irq(php_ctlr->irq, ctrl);
 			php_ctlr->irq = 0;
-			pci_disable_msi(php_ctlr->pci_dev);
 		}
 	}
 	if (php_ctlr->pci_dev) {

