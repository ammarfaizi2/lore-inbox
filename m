Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbUKSWUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbUKSWUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUKSWAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:00:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:58007 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261623AbUKSV6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:58:15 -0500
Date: Fri, 19 Nov 2004 13:57:44 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc2
Message-ID: <20041119215744.GE15863@kroah.com>
References: <20041119215618.GA15863@kroah.com> <20041119215640.GB15863@kroah.com> <20041119215659.GC15863@kroah.com> <20041119215722.GD15863@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119215722.GD15863@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2167, 2004/11/19 10:02:32-08:00, eike-kernel@sf-tec.de

[PATCH] PCI: fix Documentation/pci.txt inconsistency

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/pci.txt |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)


diff -Nru a/Documentation/pci.txt b/Documentation/pci.txt
--- a/Documentation/pci.txt	2004-11-19 13:19:58 -08:00
+++ b/Documentation/pci.txt	2004-11-19 13:19:58 -08:00
@@ -156,11 +156,9 @@
 VENDOR_ID or DEVICE_ID.  This allows searching for any device from a
 specific vendor, for example.
 
-Note that these functions are not hotplug-safe.  Their hotplug-safe
-replacements are pci_get_device(), pci_get_class() and pci_get_subsys().
-They increment the reference count on the pci_dev that they return.
-You must eventually (possibly at module unload) decrement the reference
-count on these devices by calling pci_dev_put().
+   These functions are hotplug-safe. They increment the reference count on
+the pci_dev that they return. You must eventually (possibly at module unload)
+decrement the reference count on these devices by calling pci_dev_put().
 
 
 3. Enabling and disabling devices
