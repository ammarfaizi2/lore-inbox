Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVBCSoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVBCSoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbVBCRyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:54:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:8616 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263232AbVBCRlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:41:19 -0500
Date: Thu, 3 Feb 2005 09:32:08 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [BK PATCH] PCI fixes for 2.6.11-rc3
Message-ID: <20050203173208.GA23964@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few PCI and PCI Hotplug bugfixes 2.6.11-rc3.  All of these
patches have been in the past few -mm releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/2.6.11-rc3/pci

Patches will be posted to linux-kernel and linux-pci as a follow-up
thread for those who want to see them.

thanks,

greg k-h

 MAINTAINERS                       |    1 
 drivers/pci/hotplug/rpaphp.h      |    7 --
 drivers/pci/hotplug/rpaphp_core.c |   39 ++++++++----
 drivers/pci/pci-sysfs.c           |    1 
 drivers/pci/pcie/portdrv.h        |    7 --
 drivers/pci/pcie/portdrv_bus.c    |   15 ----
 drivers/pci/pcie/portdrv_core.c   |  119 +++++++++++++++-----------------------
 drivers/pci/pcie/portdrv_pci.c    |   22 -------
 drivers/pci/probe.c               |    2 
 drivers/pci/quirks.c              |   10 +++
 10 files changed, 99 insertions(+), 124 deletions(-)
-----


Brian King:
  o pci: Add Citrine quirk

Greg Kroah-Hartman:
  o PCI: add linux-pci mailing list to PCI maintainers entry

John Rose:
  o PCI Hotplug: remove incorrect rpaphp firmware dependency

Kay Sievers:
  o PCI: memset rom attribute before using it

Olaf Hering:
  o PCI: typo in pci_scan_bus_parented

Tom L. Nguyen:
  o PCI: change sysfs representation of PCI-E devices

