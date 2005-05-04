Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVEDHIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVEDHIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVEDHFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:05:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:2277 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262050AbVEDHCY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:24 -0400
Cc: elenstev@mesatop.com
Subject: [PATCH] PCI: Spelling fixes for drivers/pci.
In-Reply-To: <11151901381752@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:02:19 -0700
Message-Id: <1115190139219@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: Spelling fixes for drivers/pci.

Here are some spelling corrections for drivers/pci.

CONTROLER -> CONTROLLER
Regisetr -> Register
harware -> hardware
inital -> initial
Initilize -> Initialize
funtion -> function
funciton -> function
occured -> occurred

Signed-off-by: Steven Cole <elenstev@mesatop.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit eaae4b3a84a3781543a32bcaf0a33306ae915574
tree 2d3db5e9713dd0baeba0be2577731233780f072f
parent 3aa8c4febf74b1f23bd9fc329321af6d531fe4dd
author Steven Cole <elenstev@mesatop.com> 1115167110 -0600
committer Greg KH <gregkh@suse.de> 1115189116 -0700

Index: drivers/pci/hotplug/ibmphp.h
===================================================================
--- 7e0b5b3d9a0308224fb40e452d93ec842a3377fe/drivers/pci/hotplug/ibmphp.h  (mode:100644 sha1:5bc039da647f1e36f6d450a2bb7f8ecb07ab7e96)
+++ 2d3db5e9713dd0baeba0be2577731233780f072f/drivers/pci/hotplug/ibmphp.h  (mode:100644 sha1:c22e0284d7b143fb9588182e15010788b9142ebe)
@@ -196,7 +196,7 @@
 
 
 /********************************************************************
-*   THREE TYPE OF HOT PLUG CONTROLER                                *
+*   THREE TYPE OF HOT PLUG CONTROLLER                                *
 ********************************************************************/
 
 struct isa_ctlr_access {
Index: drivers/pci/hotplug/ibmphp_hpc.c
===================================================================
--- 7e0b5b3d9a0308224fb40e452d93ec842a3377fe/drivers/pci/hotplug/ibmphp_hpc.c  (mode:100644 sha1:6894b548c8cab0a0a9847cee6f6b03fd5808b2a6)
+++ 2d3db5e9713dd0baeba0be2577731233780f072f/drivers/pci/hotplug/ibmphp_hpc.c  (mode:100644 sha1:1a3eb8d3d4cbd8b5bbeeb277a14124a992e5c7f2)
@@ -64,7 +64,7 @@
 #define WPG_I2C_OR		0x2000	// I2C OR operation
 
 //----------------------------------------------------------------------------
-// Command set for I2C Master Operation Setup Regisetr
+// Command set for I2C Master Operation Setup Register
 //----------------------------------------------------------------------------
 #define WPG_READATADDR_MASK	0x00010000	// read,bytes,I2C shifted,index
 #define WPG_WRITEATADDR_MASK	0x40010000	// write,bytes,I2C shifted,index
@@ -835,7 +835,7 @@
 		if (ibmphp_shutdown) 
 			break;
 		
-		/* try to get the lock to do some kind of harware access */
+		/* try to get the lock to do some kind of hardware access */
 		down (&semOperations);
 
 		switch (poll_state) {
@@ -906,7 +906,7 @@
 				poll_state = POLL_LATCH_REGISTER;
 			break;
 		}	
-		/* give up the harware semaphore */
+		/* give up the hardware semaphore */
 		up (&semOperations);
 		/* sleep for a short time just for good measure */
 		msleep(100);
Index: drivers/pci/hotplug/pci_hotplug.h
===================================================================
--- 7e0b5b3d9a0308224fb40e452d93ec842a3377fe/drivers/pci/hotplug/pci_hotplug.h  (mode:100644 sha1:57ace325168dfd5fc569a2a18b7a2b3cc16f3ed4)
+++ 2d3db5e9713dd0baeba0be2577731233780f072f/drivers/pci/hotplug/pci_hotplug.h  (mode:100644 sha1:88d44f7fef2908424ca87d67793d1cf78a9c9d4f)
@@ -150,7 +150,7 @@
  * @name: the name of the slot being registered.  This string must
  * be unique amoung slots registered on this system.
  * @ops: pointer to the &struct hotplug_slot_ops to be used for this slot
- * @info: pointer to the &struct hotplug_slot_info for the inital values for
+ * @info: pointer to the &struct hotplug_slot_info for the initial values for
  * this slot.
  * @release: called during pci_hp_deregister to free memory allocated in a
  * hotplug_slot structure.
Index: drivers/pci/hotplug/pcihp_skeleton.c
===================================================================
--- 7e0b5b3d9a0308224fb40e452d93ec842a3377fe/drivers/pci/hotplug/pcihp_skeleton.c  (mode:100644 sha1:6605d6bda5291a525fdf6da450b689e8ea3d8ae5)
+++ 2d3db5e9713dd0baeba0be2577731233780f072f/drivers/pci/hotplug/pcihp_skeleton.c  (mode:100644 sha1:3194d51c6ec9c6109b20a4eb7c5821d7010f2d3c)
@@ -297,7 +297,7 @@
 		hotplug_slot->ops = &skel_hotplug_slot_ops;
 		
 		/*
-		 * Initilize the slot info structure with some known
+		 * Initialize the slot info structure with some known
 		 * good values.
 		 */
 		info->power_status = get_power_status(slot);
Index: drivers/pci/msi.c
===================================================================
--- 7e0b5b3d9a0308224fb40e452d93ec842a3377fe/drivers/pci/msi.c  (mode:100644 sha1:22ecd3b058be176a76683a87ae33eb1269ece88a)
+++ 2d3db5e9713dd0baeba0be2577731233780f072f/drivers/pci/msi.c  (mode:100644 sha1:30206ac43c443c68eb6d89c8fc3146a6f0f307d7)
@@ -522,7 +522,7 @@
  * msi_capability_init - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
  *
- * Setup the MSI capability structure of device funtion with a single
+ * Setup the MSI capability structure of device function with a single
  * MSI vector, regardless of device function is capable of handling
  * multiple messages. A return of zero indicates the successful setup
  * of an entry zero with the new MSI vector or non-zero for otherwise.
@@ -599,7 +599,7 @@
  * msix_capability_init - configure device's MSI-X capability
  * @dev: pointer to the pci_dev data structure of MSI-X device function
  *
- * Setup the MSI-X capability structure of device funtion with a
+ * Setup the MSI-X capability structure of device function with a
  * single MSI-X vector. A return of zero indicates the successful setup of
  * requested MSI-X entries with allocated vectors or non-zero for otherwise.
  **/
@@ -1074,7 +1074,7 @@
  * msi_remove_pci_irq_vectors - reclaim MSI(X) vectors to unused state
  * @dev: pointer to the pci_dev data structure of MSI(X) device function
  *
- * Being called during hotplug remove, from which the device funciton
+ * Being called during hotplug remove, from which the device function
  * is hot-removed. All previous assigned MSI/MSI-X vectors, if
  * allocated for this device function, are reclaimed to unused state,
  * which may be used later on.
Index: drivers/pci/pci-driver.c
===================================================================
--- 7e0b5b3d9a0308224fb40e452d93ec842a3377fe/drivers/pci/pci-driver.c  (mode:100644 sha1:b42466ccbb309f4961b7a653aa079c3577d7cbb7)
+++ 2d3db5e9713dd0baeba0be2577731233780f072f/drivers/pci/pci-driver.c  (mode:100644 sha1:fe98553c978f335dae47646cee5df32c8f69b42e)
@@ -381,7 +381,7 @@
  * 
  * Adds the driver structure to the list of registered drivers.
  * Returns a negative value on error, otherwise 0. 
- * If no error occured, the driver remains registered even if 
+ * If no error occurred, the driver remains registered even if 
  * no device was claimed during registration.
  */
 int pci_register_driver(struct pci_driver *drv)

