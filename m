Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265696AbUFXVh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265696AbUFXVh1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUFXVd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:33:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:54702 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265676AbUFXVbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:31:50 -0400
Date: Thu, 24 Jun 2004 14:30:29 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.6.7
Message-ID: <20040624213029.GA2477@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some small PCI patches for 2.6.7.  They include some pci id
fixes, quirk fixups, and pci hotplug driver updates.  They have all been
in the last few -mm releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 Documentation/pci.txt                  |    5 
 Documentation/power/pci.txt            |    8 
 arch/i386/kernel/dmi_scan.c            |   59 +++++
 arch/i386/pci/irq.c                    |   27 ++
 drivers/pci/hotplug/pciehp_ctrl.c      |  147 ++++----------
 drivers/pci/hotplug/pciehp_hpc.c       |    4 
 drivers/pci/hotplug/pciehprm_acpi.c    |   22 +-
 drivers/pci/hotplug/pciehprm_nonacpi.c |   18 +
 drivers/pci/hotplug/rpadlpar_core.c    |   28 --
 drivers/pci/hotplug/rpaphp.h           |   28 ++
 drivers/pci/hotplug/rpaphp_core.c      |  199 +++++++++++++-------
 drivers/pci/hotplug/rpaphp_pci.c       |  328 ++++++++++++++++++++++-----------
 drivers/pci/hotplug/rpaphp_slot.c      |  136 +++++++++++--
 drivers/pci/hotplug/rpaphp_vio.c       |    6 
 drivers/pci/hotplug/shpchp.h           |    1 
 drivers/pci/hotplug/shpchp_ctrl.c      |   60 ++----
 drivers/pci/hotplug/shpchp_pci.c       |    1 
 drivers/pci/hotplug/shpchprm_acpi.c    |   22 +-
 drivers/pci/hotplug/shpchprm_nonacpi.c |   18 +
 drivers/pci/msi.c                      |   10 -
 drivers/pci/pci.c                      |    2 
 drivers/pci/quirks.c                   |    1 
 include/linux/pci_ids.h                |   54 +++--
 23 files changed, 781 insertions(+), 403 deletions(-)
-----

<ossi:kde.org>:
  o PCI: (one more) PCI quirk for SMBus bridge on Asus P4 boards

Bjorn Helgaas:
  o PCI: clarify pci.txt wrt IRQ allocation

Daniel Ritz:
  o PCI: fix irq routing on acer travelmate 360 laptop

Dely Sy:
  o Fixes for hot-plug drivers (updated)

Linda Xie:
  o PCI Hotplug: rpaphp.patch -- multi-function devices not handled correctly

Roger Luethi:
  o PCI: Fix off-by-one in pci_enable_wake
  o PCI: Fix PME bits in pci.txt

Roland Dreier:
  o PCI: Fix MSI-X setup

Stephen Hemminger:
  o PCI: add id's for sk98 driver
  o PCI: fix out of order entry in pci_ids.h
  o PCI: remove duplicate in pci_ids.h

