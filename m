Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbUCSX3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUCSX3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:29:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:4814 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263146AbUCSX3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:29:18 -0500
Date: Fri, 19 Mar 2004 15:25:16 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI and PCI Hotplug fixes for 2.6.5-rc1
Message-ID: <20040319232516.GA16178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI and PCI hotplug patches for 2.6.5-rc1.  These are all
bugfixes of one sort or another and the majority of them have been in
the past few -mm releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 arch/ia64/pci/pci.c                 |   62 +
 drivers/pci/hotplug/Makefile        |    4 
 drivers/pci/hotplug/acpiphp.h       |    2 
 drivers/pci/hotplug/acpiphp_glue.c  |   27 
 drivers/pci/hotplug/acpiphp_pci.c   |   20 
 drivers/pci/hotplug/acpiphp_res.c   |    2 
 drivers/pci/hotplug/pciehp_pci.c    |    2 
 drivers/pci/hotplug/pciehprm_acpi.c |    3 
 drivers/pci/hotplug/rpadlpar_core.c |  186 ++-
 drivers/pci/hotplug/rpaphp.h        |   90 +
 drivers/pci/hotplug/rpaphp_core.c   | 1706 ++++++++----------------------------
 drivers/pci/hotplug/rpaphp_pci.c    |  357 +++++++
 drivers/pci/hotplug/rpaphp_slot.c   |  188 +++
 drivers/pci/hotplug/rpaphp_vio.c    |  121 ++
 drivers/pci/hotplug/shpchp_pci.c    |    2 
 drivers/pci/setup-res.c             |    9 
 kernel/resource.c                   |    1 
 17 files changed, 1319 insertions(+), 1463 deletions(-)
-----

<lxiep:ltcfwd.linux.ibm.com>:
  o PCI Hotplug: rpaphp/rpadlpar latest (support for vio and multifunction devices )

Andreas Schwab:
  o PCI Hotplug: Fix PCIE and SHPC hotplug drivers for ia64

Greg Kroah-Hartman:
  o PCI Hotplug: fix compiler warning in acpiphp driver

Matthew Wilcox:
  o PCI: claim PCI resources on ia64
  o PCI: Use insert_resource in pci_claim_resource
  o PCI: insert_resource can succeed and return an error

Takayoshi Kochi:
  o PCI Hotlug: fix acpiphp unable to power off slots

