Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263075AbVBCRvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbVBCRvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbVBCRtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:49:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:60071 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263336AbVBCRlD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:41:03 -0500
Cc: akpm@osdl.org
Subject: [PATCH] PCI: typo in pci_scan_bus_parented
In-Reply-To: <20050203173208.GA23964@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Feb 2005 09:40:20 -0800
Message-Id: <11074524201252@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2041, 2005/02/03 00:39:41-08:00, akpm@osdl.org

[PATCH] PCI: typo in pci_scan_bus_parented

From: Olaf Hering <olh@suse.de>

printk format string misses a x

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/probe.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-02-03 09:29:00 -08:00
+++ b/drivers/pci/probe.c	2005-02-03 09:29:00 -08:00
@@ -879,7 +879,7 @@
 
 	if (pci_find_bus(pci_domain_nr(b), bus)) {
 		/* If we already got to this bus through a different bridge, ignore it */
-		DBG("PCI: Bus %04:%02x already known\n", pci_domain_nr(b), bus);
+		DBG("PCI: Bus %04x:%02x already known\n", pci_domain_nr(b), bus);
 		goto err_out;
 	}
 	list_add_tail(&b->node, &pci_root_buses);

