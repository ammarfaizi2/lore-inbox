Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbTFEVMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265166AbTFEVLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:11:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:54408 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265129AbTFEUro convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:47:44 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10548468772486@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.70
In-Reply-To: <10548468772002@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 5 Jun 2003 14:01:17 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1316, 2003/06/05 12:04:22-07:00, greg@kroah.com

[PATCH] PCI: remove pci_for_each_dev_reverse() now that all users of it are gone.


 include/linux/pci.h |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jun  5 13:52:48 2003
+++ b/include/linux/pci.h	Thu Jun  5 13:52:48 2003
@@ -527,8 +527,6 @@
 	return !list_empty(&pci_devices);
 }
 
-#define pci_for_each_dev_reverse(dev) \
-	for(dev = pci_dev_g(pci_devices.prev); dev != pci_dev_g(&pci_devices); dev = pci_dev_g(dev->global_list.prev))
 #define pci_for_each_bus(bus) \
 	for(bus = pci_bus_b(pci_root_buses.next); bus != pci_bus_b(&pci_root_buses); bus = pci_bus_b(bus->node.next))
 

