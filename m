Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270072AbUJSXfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270072AbUJSXfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270073AbUJSXee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:34:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:9610 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270072AbUJSWqd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:33 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257321712@kroah.com>
Date: Tue, 19 Oct 2004 15:42:12 -0700
Message-Id: <10982257321259@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.4, 2004/10/06 11:18:48-07:00, greg@kroah.com

[PATCH] PCI: update the pci.txt documentation about pci_find_device and pci_find_subsys going away

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/pci.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/Documentation/pci.txt b/Documentation/pci.txt
--- a/Documentation/pci.txt	2004-10-19 15:27:37 -07:00
+++ b/Documentation/pci.txt	2004-10-19 15:27:37 -07:00
@@ -141,7 +141,7 @@
 Searching by vendor and device ID:
 
 	struct pci_dev *dev = NULL;
-	while (dev = pci_find_device(VENDOR_ID, DEVICE_ID, dev))
+	while (dev = pci_get_device(VENDOR_ID, DEVICE_ID, dev))
 		configure_device(dev);
 
 Searching by class ID (iterate in a similar way):
@@ -150,7 +150,7 @@
 
 Searching by both vendor/device and subsystem vendor/device ID:
 
-	pci_find_subsys(VENDOR_ID, DEVICE_ID, SUBSYS_VENDOR_ID, SUBSYS_DEVICE_ID, dev).
+	pci_get_subsys(VENDOR_ID, DEVICE_ID, SUBSYS_VENDOR_ID, SUBSYS_DEVICE_ID, dev).
 
    You can use the constant PCI_ANY_ID as a wildcard replacement for
 VENDOR_ID or DEVICE_ID.  This allows searching for any device from a
@@ -275,8 +275,8 @@
 				devices just return NULL.
 pcibios_(read|write)_*		Superseded by their pci_(read|write)_*
 				counterparts.
-pcibios_find_*			Superseded by their pci_find_* counterparts.
-pci_for_each_dev()		Superseded by pci_find_device()
+pcibios_find_*			Superseded by their pci_get_* counterparts.
+pci_for_each_dev()		Superseded by pci_get_device()
 pci_for_each_dev_reverse()	Superseded by pci_find_device_reverse()
 pci_for_each_bus()		Superseded by pci_find_next_bus()
 pci_find_device()		Superseded by pci_get_device()

