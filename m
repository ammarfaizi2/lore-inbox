Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265393AbUBJAD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265391AbUBJABy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:01:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:54460 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265389AbUBIXWZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:25 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689362321@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:16 -0800
Message-Id: <10763689362302@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.3, 2004/01/30 16:35:12-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: coding style for cpqphp_pci.c

here are some coding style fixes.


 drivers/pci/hotplug/cpqphp_pci.c |   26 +++++++++++---------------
 1 files changed, 11 insertions(+), 15 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
--- a/drivers/pci/hotplug/cpqphp_pci.c	Mon Feb  9 14:59:40 2004
+++ b/drivers/pci/hotplug/cpqphp_pci.c	Mon Feb  9 14:59:40 2004
@@ -123,7 +123,7 @@
 	dbg("%s: bus/dev/func = %x/%x/%x\n", __FUNCTION__, func->bus, func->device, func->function);
 
 	for (j=0; j<8 ; j++) {
-		struct pci_dev* temp = pci_find_slot(func->bus, (func->device << 3) | j);
+		struct pci_dev* temp = pci_find_slot(func->bus, PCI_DEVFN(func->device, j));
 		if (temp)
 			pci_remove_bus_device(temp);
 	}
@@ -545,10 +545,10 @@
 		} while (function < max_functions);
 	}			// End of IF (device in slot?)
 	else {
-		return(2);
+		return 2;
 	}
 
-	return(0);
+	return 0;
 }
 
 
@@ -594,9 +594,8 @@
 
 			while (next != NULL) {
 				rc = cpqhp_save_base_addr_length(ctrl, next);
-
 				if (rc)
-					return(rc);
+					return rc;
 
 				next = next->next;
 			}
@@ -979,7 +978,6 @@
 
 			while (next != NULL) {
 				rc = cpqhp_configure_board(ctrl, next);
-
 				if (rc)
 					return rc;
 
@@ -1076,9 +1074,8 @@
 
 			while (next != NULL) {
 				rc = cpqhp_valid_replace(ctrl, next);
-
 				if (rc)
-					return(rc);
+					return rc;
 
 				next = next->next;
 			}
@@ -1144,7 +1141,7 @@
 	}
 
 
-	return(0);
+	return 0;
 }
 
 
@@ -1229,9 +1226,8 @@
 	i = readb(rom_resource_table + NUMBER_OF_ENTRIES);
 	dbg("number_of_entries = %d\n", i);
 
-	if (!readb(one_slot + SECONDARY_BUS)) {
-		return(1);
-	}
+	if (!readb(one_slot + SECONDARY_BUS))
+		return 1;
 
 	dbg("dev|IO base|length|Mem base|length|Pre base|length|PB SB MB\n");
 
@@ -1391,7 +1387,7 @@
 	rc &= cpqhp_resource_sort_and_combine(&(ctrl->io_head));
 	rc &= cpqhp_resource_sort_and_combine(&(ctrl->bus_head));
 
-	return(rc);
+	return rc;
 }
 
 
@@ -1411,7 +1407,7 @@
 	dbg("%s\n", __FUNCTION__);
 
 	if (!func)
-		return(1);
+		return 1;
 
 	node = func->io_head;
 	func->io_head = NULL;
@@ -1450,7 +1446,7 @@
 	rc |= cpqhp_resource_sort_and_combine(&(resources->io_head));
 	rc |= cpqhp_resource_sort_and_combine(&(resources->bus_head));
 
-	return(rc);
+	return rc;
 }
 
 

