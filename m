Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263108AbVCDWRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbVCDWRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbVCDWOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:14:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:48289 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263138AbVCDUyV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:21 -0500
Cc: matthew@wil.cx
Subject: [PATCH] PCI: Make pci_claim_resource __devinit
In-Reply-To: <1109969636798@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:56 -0800
Message-Id: <11099696361878@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.10, 2005/02/07 14:38:32-08:00, matthew@wil.cx

[PATCH] PCI: Make pci_claim_resource __devinit

ia64 calls pci_claim_resource() from pcibios_fixup_bus(), which is
__devinit, so pci_claim_resource() needs to be __devinit too.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/setup-res.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c	2005-03-04 12:43:06 -08:00
+++ b/drivers/pci/setup-res.c	2005-03-04 12:43:06 -08:00
@@ -90,7 +90,7 @@
 		new & ~PCI_REGION_FLAG_MASK));
 }
 
-int __init
+int __devinit
 pci_claim_resource(struct pci_dev *dev, int resource)
 {
 	struct resource *res = &dev->resource[resource];

