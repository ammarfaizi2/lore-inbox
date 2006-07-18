Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWGRVbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWGRVbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWGRVbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:31:00 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:18831 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932148AbWGRVa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:30:58 -0400
Message-ID: <44BD538D.9010201@oracle.com>
Date: Tue, 18 Jul 2006 14:33:01 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-pci@atrey.karlin.mff.cuni.cz, gregkh@suse.de, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] pci/search: cleanups, add to kernel-api.tmpl
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Clean up kernel-doc comments in drivers/pci/search.c
  (line sizes and typos).
Enable that source file in DocBook/kernel-api.tmpl.
Depends on the kernel-doc __devinit patch.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |    4 --
 drivers/pci/search.c                  |   46 ++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 24 deletions(-)

--- linux-2618-rc2.orig/drivers/pci/search.c
+++ linux-2618-rc2/drivers/pci/search.c
@@ -61,7 +61,7 @@ struct pci_bus * __devinit pci_find_bus(
  * @from: Previous PCI bus found, or %NULL for new search.
  *
  * Iterates through the list of known PCI busses.  A new search is
- * initiated by passing %NULL to the @from argument.  Otherwise if
+ * initiated by passing %NULL as the @from argument.  Otherwise if
  * @from is not %NULL, searches continue from next device on the
  * global list.
  */
@@ -148,13 +148,14 @@ struct pci_dev * pci_get_slot(struct pci
  * @from: Previous PCI device found in search, or %NULL for new search.
  *
  * Iterates through the list of known PCI devices.  If a PCI device is
- * found with a matching @vendor, @device, @ss_vendor and @ss_device, a pointer to its
- * device structure is returned.  Otherwise, %NULL is returned.
- * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not %NULL, searches continue from next device on the global list.
+ * found with a matching @vendor, @device, @ss_vendor and @ss_device, a
+ * pointer to its device structure is returned.  Otherwise, %NULL is returned.
+ * A new search is initiated by passing %NULL as the @from argument.
+ * Otherwise if @from is not %NULL, searches continue from next device
+ * on the global list.
  *
- * NOTE: Do not use this function anymore, use pci_get_subsys() instead, as
- * the pci device returned by this function can disappear at any moment in
+ * NOTE: Do not use this function any more; use pci_get_subsys() instead, as
+ * the PCI device returned by this function can disappear at any moment in
  * time.
  */
 static struct pci_dev * pci_find_subsys(unsigned int vendor,
@@ -191,14 +192,15 @@ exit:
  * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
  * @from: Previous PCI device found in search, or %NULL for new search.
  *
- * Iterates through the list of known PCI devices.  If a PCI device is
- * found with a matching @vendor and @device, a pointer to its device structure is
+ * Iterates through the list of known PCI devices.  If a PCI device is found
+ * with a matching @vendor and @device, a pointer to its device structure is
  * returned.  Otherwise, %NULL is returned.
- * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not %NULL, searches continue from next device on the global list.
+ * A new search is initiated by passing %NULL as the @from argument.
+ * Otherwise if @from is not %NULL, searches continue from next device
+ * on the global list.
  * 
- * NOTE: Do not use this function anymore, use pci_get_device() instead, as
- * the pci device returned by this function can disappear at any moment in
+ * NOTE: Do not use this function any more; use pci_get_device() instead, as
+ * the PCI device returned by this function can disappear at any moment in
  * time.
  */
 struct pci_dev *
@@ -215,11 +217,11 @@ pci_find_device(unsigned int vendor, uns
  * @ss_device: PCI subsystem device id to match, or %PCI_ANY_ID to match all device ids
  * @from: Previous PCI device found in search, or %NULL for new search.
  *
- * Iterates through the list of known PCI devices.  If a PCI device is
- * found with a matching @vendor, @device, @ss_vendor and @ss_device, a pointer to its
+ * Iterates through the list of known PCI devices.  If a PCI device is found
+ * with a matching @vendor, @device, @ss_vendor and @ss_device, a pointer to its
  * device structure is returned, and the reference count to the device is
  * incremented.  Otherwise, %NULL is returned.  A new search is initiated by
- * passing %NULL to the @from argument.  Otherwise if @from is not %NULL,
+ * passing %NULL as the @from argument.  Otherwise if @from is not %NULL,
  * searches continue from next device on the global list.
  * The reference count for @from is always decremented if it is not %NULL.
  */
@@ -262,7 +264,7 @@ exit:
  * found with a matching @vendor and @device, the reference count to the
  * device is incremented and a pointer to its device structure is returned.
  * Otherwise, %NULL is returned.  A new search is initiated by passing %NULL
- * to the @from argument.  Otherwise if @from is not %NULL, searches continue
+ * as the @from argument.  Otherwise if @from is not %NULL, searches continue
  * from next device on the global list.  The reference count for @from is
  * always decremented if it is not %NULL.
  */
@@ -279,11 +281,13 @@ pci_get_device(unsigned int vendor, unsi
  * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
  * @from: Previous PCI device found in search, or %NULL for new search.
  *
- * Iterates through the list of known PCI devices in the reverse order of pci_find_device().
+ * Iterates through the list of known PCI devices in the reverse order of
+ * pci_find_device().
  * If a PCI device is found with a matching @vendor and @device, a pointer to
  * its device structure is returned.  Otherwise, %NULL is returned.
- * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not %NULL, searches continue from previous device on the global list.
+ * A new search is initiated by passing %NULL as the @from argument.
+ * Otherwise if @from is not %NULL, searches continue from previous device
+ * on the global list.
  */
 struct pci_dev *
 pci_find_device_reverse(unsigned int vendor, unsigned int device, const struct pci_dev *from)
@@ -317,7 +321,7 @@ exit:
  * found with a matching @class, the reference count to the device is
  * incremented and a pointer to its device structure is returned.
  * Otherwise, %NULL is returned.
- * A new search is initiated by passing %NULL to the @from argument.
+ * A new search is initiated by passing %NULL as the @from argument.
  * Otherwise if @from is not %NULL, searches continue from next device
  * on the global list.  The reference count for @from is always decremented
  * if it is not %NULL.
--- linux-2618-rc2.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2618-rc2/Documentation/DocBook/kernel-api.tmpl
@@ -312,9 +312,7 @@ X!Ekernel/module.c
 !Edrivers/pci/pci-driver.c
 !Edrivers/pci/remove.c
 !Edrivers/pci/pci-acpi.c
-<!-- kerneldoc does not understand __devinit
-X!Edrivers/pci/search.c
- -->
+!Edrivers/pci/search.c
 !Edrivers/pci/msi.c
 !Edrivers/pci/bus.c
 <!-- FIXME: Removed for now since no structured comments in source



