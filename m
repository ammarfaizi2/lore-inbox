Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUD1WfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUD1WfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 18:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUD1WfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 18:35:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:13961 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261156AbUD1WfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 18:35:07 -0400
Date: Wed, 28 Apr 2004 15:34:42 -0700
From: Greg KH <greg@kroah.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug patches for 2.4.23-pre1
Message-ID: <20040428223442.GE26685@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 4 PCI Hotplug patches for 2.4.27-pre1.  Two of them are
bugfixes for the acpi pci hotplug controller, and the other ones add the
PCI Express Hotplug driver, and the Standard PCI Hotplug Controller
driver (both of which have been in the 2.6 kernel tree for a while.)

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/pci-2.4

The raw patches will follow to you and the pcihpd mailing list.

thanks,

greg k-h


 arch/i386/kernel/pci-irq.c         |   43 
 arch/i386/kernel/pci-pc.c          |    2 
 drivers/hotplug/Config.in          |    7 
 drivers/hotplug/Makefile           |   38 
 drivers/hotplug/acpiphp.h          |   61 
 drivers/hotplug/acpiphp_core.c     |   30 
 drivers/hotplug/acpiphp_glue.c     |   92 -
 drivers/hotplug/acpiphp_pci.c      |   18 
 drivers/hotplug/acpiphp_res.c      |    5 
 drivers/hotplug/pci_hotplug.h      |   29 
 drivers/hotplug/pci_hotplug_core.c |   70 
 drivers/hotplug/pciehp.h           |  383 ++++
 drivers/hotplug/pciehp_core.c      |  703 ++++++++
 drivers/hotplug/pciehp_ctrl.c      | 2635 +++++++++++++++++++++++++++++++
 drivers/hotplug/pciehp_hpc.c       | 1504 ++++++++++++++++++
 drivers/hotplug/pciehp_pci.c       | 1052 ++++++++++++
 drivers/hotplug/pciehprm.h         |   54 
 drivers/hotplug/pciehprm_acpi.c    | 1696 ++++++++++++++++++++
 drivers/hotplug/pciehprm_nonacpi.c |  497 +++++
 drivers/hotplug/pciehprm_nonacpi.h |   56 
 drivers/hotplug/shpchp.h           |  464 +++++
 drivers/hotplug/shpchp_core.c      |  700 ++++++++
 drivers/hotplug/shpchp_ctrl.c      | 3081 ++++++++++++++++++++++++++++++++++++-
 drivers/hotplug/shpchp_hpc.c       | 1629 +++++++++++++++++++
 drivers/hotplug/shpchp_pci.c       | 1043 ++++++++++++
 drivers/hotplug/shpchprm.h         |   57 
 drivers/hotplug/shpchprm_acpi.c    | 1696 ++++++++++++++++++++
 drivers/hotplug/shpchprm_legacy.c  |  444 +++++
 drivers/hotplug/shpchprm_legacy.h  |  113 +
 drivers/hotplug/shpchprm_nonacpi.c |  430 +++++
 drivers/hotplug/shpchprm_nonacpi.h |   56 
 drivers/pci/pci.c                  |    1 
 drivers/pci/quirks.c               |    9 
 include/linux/pci.h                |    5 
 include/linux/pci_ids.h            |   29 
 35 files changed, 18576 insertions(+), 156 deletions(-)
-----


Dely Sy:
  o PCI Hotplug: SHPC & PCI-E hot-plug fixes
  o SHPC and PCI Express hot-plug drivers for 2.4 kernel

Takayoshi Kochi:
  o PCI Hotplug: acpiphp unable to power off slots

Takayoshi Kouchi:
  o PCI Hotplug: acpiphp cleanup patch for 2.4.23-pre4

