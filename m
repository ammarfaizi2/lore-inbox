Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbULAASV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbULAASV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbULAARG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:17:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:39908 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261210AbULAAOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:19 -0500
Date: Tue, 30 Nov 2004 16:09:04 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] More PCI fixes for 2.6.10-rc2
Message-ID: <20041201000904.GA27422@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more small PCI and PCI hotplug fixes for 2.6.10-rc2.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 arch/i386/pci/mmconfig.c         |    7 +++++++
 arch/x86_64/pci/mmconfig.c       |    7 +++++++
 drivers/pci/hotplug/cpqphp_pci.c |    2 +-
 drivers/pci/hotplug/pciehp_hpc.c |    3 +++
 drivers/pci/hotplug/shpchp_hpc.c |    3 +++
 drivers/pci/pci-sysfs.c          |   14 ++++++++++++--
 6 files changed, 33 insertions(+), 3 deletions(-)
-----

Andi Kleen:
  o PCI: Disable mmconfig on AMD CPUs
  o PCI: Add sysfs file to map PCI busses to cpus

Dely Sy:
  o PCI Hotplug: Add pci_enable_device() in hot-plug drivers

Greg Kroah-Hartman:
  o PCI: fix build warning in pci-sysfs.c
  o PCI Hotplug: fix warning compile issue in cpqphp driver

