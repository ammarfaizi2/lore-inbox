Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130196AbRCCAww>; Fri, 2 Mar 2001 19:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130201AbRCCAwn>; Fri, 2 Mar 2001 19:52:43 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:12333 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130196AbRCCAwb>; Fri, 2 Mar 2001 19:52:31 -0500
Date: Sat, 3 Mar 2001 00:52:24 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.3-pre1: PCI documentation
Message-ID: <20010303005224.L4835@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the fixes to the PCI documentation got lost in the 2.4.3-pre1
patch.  Here they are again.

Tim.
*/

2001-03-02  Tim Waugh  <twaugh@redhat.com>

	* drivers/pci/pci.c: Inline documentation, based on a patch by
	Jani Monoses.

--- linux/drivers/pci/pci.c.pcidoc	Sat Mar  3 00:37:12 2001
+++ linux/drivers/pci/pci.c	Sat Mar  3 00:37:27 2001
@@ -63,9 +63,9 @@
 /**
  * pci_find_subsys - begin or continue searching for a PCI device by vendor/subvendor/device/subdevice id
  * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
- * @device: PCI device id to match, or %PCI_ANY_ID to match all vendor ids
+ * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
  * @ss_vendor: PCI subsystem vendor id to match, or %PCI_ANY_ID to match all vendor ids
- * @ss_device: PCI subsystem device id to match, or %PCI_ANY_ID to match all vendor ids
+ * @ss_device: PCI subsystem device id to match, or %PCI_ANY_ID to match all device ids
  * @from: Previous PCI device found in search, or %NULL for new search.
  *
  * Iterates through the list of known PCI devices.  If a PCI device is
@@ -97,7 +97,7 @@
 /**
  * pci_find_device - begin or continue searching for a PCI device by vendor/device id
  * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
- * @device: PCI device id to match, or %PCI_ANY_ID to match all vendor ids
+ * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
  * @from: Previous PCI device found in search, or %NULL for new search.
  *
  * Iterates through the list of known PCI devices.  If a PCI device is
@@ -122,7 +122,8 @@
  * found with a matching @class, a pointer to its device structure is
  * returned.  Otherwise, %NULL is returned.
  * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not %NULL, searches continue from next device on the global list.
+ * Otherwise if @from is not %NULL, searches continue from next device
+ * on the global list.
  */
 struct pci_dev *
 pci_find_class(unsigned int class, const struct pci_dev *from)
@@ -144,9 +145,9 @@
  * @cap: capability code
  *
  * Tell if a device supports a given PCI capability.
- * Returns the address of the requested capability structure within the device's PCI 
- * configuration space or 0 in case the device does not support it.
- * Possible values for @flags:
+ * Returns the address of the requested capability structure within the
+ * device's PCI configuration space or 0 in case the device does not
+ * support it.  Possible values for @cap:
  *
  *  %PCI_CAP_ID_PM           Power Management 
  *
@@ -387,10 +388,10 @@
 static LIST_HEAD(pci_drivers);
 
 /**
- * pci_match_device - Tell if a PCI device structure has a matching PCI device
+ * pci_match_device - Tell if a PCI device structure has a matching PCI device id structure
  * @ids: array of PCI device id structures to search in
  * @dev: the PCI device structure to match against
- *
+ * 
  * Used by a driver to check whether a PCI device present in the
  * system is in its list of supported devices.Returns the matching
  * pci_device_id structure or %NULL if there is no match.
@@ -441,7 +442,8 @@
  * 
  * Adds the driver structure to the list of registered drivers
  * Returns the number of pci devices which were claimed by the driver
- * during registration.
+ * during registration.  The driver remains registered even if the
+ * return value is zero.
  */
 int
 pci_register_driver(struct pci_driver *drv)
@@ -462,8 +464,9 @@
  * @drv: the driver structure to unregister
  * 
  * Deletes the driver structure from the list of registered PCI drivers,
- * gives it a chance to clean up and marks the devices for which it
- * was responsible as driverless.
+ * gives it a chance to clean up by calling its remove() function for
+ * each device it was responsible for, and marks those devices as
+ * driverless.
  */
 
 void
