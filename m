Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUBJWY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 17:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUBJWY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 17:24:27 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:1844 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261875AbUBJWY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 17:24:26 -0500
Date: Tue, 10 Feb 2004 16:19:42 -0600
From: johnrose@austin.ibm.com
Message-Id: <200402102219.i1AMJgXN022285@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 PCI Hotplug/DLPAR Drivers for RPA
Cc: johnrose@us.ibm.com, wortman@us.ibm.com, lxie@us.ibm.com,
       scheel@us.ibm.com, gregkh@us.ibm.com,
       pcihpd-discuss@lists.sourceforge.net, greg@kroah.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please condider the following patch for inclusion.  This patch contains
implementations of the PCI Hotplug and I/O Slot DLPAR Drivers for PPC64 RISC
Platform Architecture.  The patch is made against kernel version 2.6.3-rc2.  

The PCI Hotplug module allows the runtime addition/removal of I/O adapters on
a PPC64 machine.  Due to firmware restrictions, hotplug operations must be
initiated by userspace tools.  These operations are initiated using interface 
files located at:
/sys/bus/pci/pci_hotplug_slots/<bus_name>
Development contact for this module is Linda Xie (lxie@us.ibm.com).

The Dynamic Logical Partitioning Module allows the runtime movement of
I/O Slots between logical partitions.  An administrator can logically 
add/remove PCI Buses to/from a PPC64 partition at runtime.  These 
operations are initiated using interface files located at:
/sys/bus/pci/pci_hotplug_slots/control/
Development contact for this module is John Rose (johnrose@austin.ibm.com).

Due to the size of the patch (~1730 LOC), I have posted it at:
http://www-124.ibm.com/linux/patches/misc/ppc64-pci_hotplug-dlpar_drivers-2.6.3-rc2.patch

Thanks-
John
