Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTFJVON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTFJVDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:03:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:1711 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263861AbTFJShL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:11 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709703999@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709702206@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1389, 2003/06/10 10:32:40-07:00, greg@kroah.com

[PATCH] PCI: remove pci_for_each_bus() macro as there are now no more users of it.


 include/linux/pci.h |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Jun 10 11:15:28 2003
+++ b/include/linux/pci.h	Tue Jun 10 11:15:28 2003
@@ -525,9 +525,6 @@
 extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 extern struct list_head pci_devices;	/* list of all devices */
 
-#define pci_for_each_bus(bus) \
-	for(bus = pci_bus_b(pci_root_buses.next); bus != pci_bus_b(&pci_root_buses); bus = pci_bus_b(bus->node.next))
-
 int pci_present(void);
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *, int mask);

