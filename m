Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVA1Qb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVA1Qb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 11:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVA1Qb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 11:31:27 -0500
Received: from mail.suse.de ([195.135.220.2]:51883 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261474AbVA1QbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 11:31:24 -0500
Date: Fri, 28 Jan 2005 17:31:07 +0100
From: Olaf Hering <olh@suse.de>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] typo in pci_scan_bus_parented
Message-ID: <20050128163107.GA1124@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


printk format string misses a x


Signed-off-by: Olaf Hering <olh@suse.de>

--- ../linux-2.6.11-rc2.orig/drivers/pci/probe.c	2005-01-22 02:48:34.000000000 +0100
+++ .//drivers/pci/probe.c	2005-01-28 17:24:50.115957815 +0100
@@ -879,7 +879,7 @@ struct pci_bus * __devinit pci_scan_bus_
 
 	if (pci_find_bus(pci_domain_nr(b), bus)) {
 		/* If we already got to this bus through a different bridge, ignore it */
-		DBG("PCI: Bus %04:%02x already known\n", pci_domain_nr(b), bus);
+		DBG("PCI: Bus %04x:%02x already known\n", pci_domain_nr(b), bus);
 		goto err_out;
 	}
 	list_add_tail(&b->node, &pci_root_buses);
