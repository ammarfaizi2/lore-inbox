Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbUCCEZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbUCCEX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:23:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:35714 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262359AbUCCEVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:21:55 -0500
Date: Tue, 2 Mar 2004 20:20:34 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI Hotplug fixes for 2.6.4-rc1
Message-ID: <20040303042034.GA17156@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some minor PCI hotplug fixes for 2.6.4-rc1.  They fix some
oopses, and make the build options a lot saner and allow the distros to
pick the proper options easier.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/pci/hotplug/Kconfig            |   32 ++++---------------
 drivers/pci/hotplug/Makefile           |   54 +++++++++++++++------------------
 drivers/pci/hotplug/cpqphp.h           |    1 
 drivers/pci/hotplug/cpqphp_core.c      |    5 +++
 drivers/pci/hotplug/cpqphp_ctrl.c      |   47 ++++++++++++++--------------
 drivers/pci/hotplug/cpqphp_pci.c       |   36 +++++++++++-----------
 drivers/pci/hotplug/pci_hotplug_core.c |   23 ++++++++++----
 drivers/pci/hotplug/pciehprm_acpi.c    |    3 +
 drivers/pci/hotplug/shpchp.h           |    3 -
 drivers/pci/hotplug/shpchprm_acpi.c    |    3 +
 include/linux/pci.h                    |    1 
 11 files changed, 105 insertions(+), 103 deletions(-)
-----


Dely Sy:
  o PCI Hotplug: fixes for shpc and pcie hot-plug drivers

Greg Kroah-Hartman:
  o PCI Hotplug: clean up the Makefile a bit more
  o PCI Hotplug: fix up the permission settings on a few of the sysfs files
  o PCI Hotplug: fix stupid directory name of "pci_hotplug_slots" to be just "slots"

Torben Mathiasen:
  o PCI Hotplug: Patch to get cpqphp working with IOAPIC

