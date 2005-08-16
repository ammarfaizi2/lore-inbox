Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVHPWQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVHPWQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVHPWQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:16:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:16017 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751122AbVHPWQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:16:40 -0400
Date: Tue, 16 Aug 2005 15:16:26 -0700
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jirislaby@gmail.com
Subject: [patch 5/7] PCI: update documentation
Message-ID: <20050816221626.GF28619@kroah.com>
References: <20050816220001.699316000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-update-docs.patch"
In-Reply-To: <20050816221527.GA28619@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jirislaby@gmail.com>

This removes very old functions from pci docs, which aren't no longer in the
kernel.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/pci.txt |   14 --------------
 1 files changed, 14 deletions(-)

--- gregkh-2.6.orig/Documentation/pci.txt	2005-08-16 14:51:30.000000000 -0700
+++ gregkh-2.6/Documentation/pci.txt	2005-08-16 14:57:58.000000000 -0700
@@ -266,20 +266,6 @@ port an old driver to the new PCI interf
 in the kernel as they aren't compatible with hotplug or PCI domains or
 having sane locking.
 
-pcibios_present() and		Since ages, you don't need to test presence
-pci_present()			of PCI subsystem when trying to talk to it.
-				If it's not there, the list of PCI devices
-				is empty and all functions for searching for
-				devices just return NULL.
-pcibios_(read|write)_*		Superseded by their pci_(read|write)_*
-				counterparts.
-pcibios_find_*			Superseded by their pci_get_* counterparts.
-pci_for_each_dev()		Superseded by pci_get_device()
-pci_for_each_dev_reverse()	Superseded by pci_find_device_reverse()
-pci_for_each_bus()		Superseded by pci_find_next_bus()
 pci_find_device()		Superseded by pci_get_device()
 pci_find_subsys()		Superseded by pci_get_subsys()
 pci_find_slot()			Superseded by pci_get_slot()
-pcibios_find_class()		Superseded by pci_get_class()
-pci_find_class()		Superseded by pci_get_class()
-pci_(read|write)_*_nodev()	Superseded by pci_bus_(read|write)_*()

--
