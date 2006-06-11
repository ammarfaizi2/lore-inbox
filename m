Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWFKVJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWFKVJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 17:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWFKVJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 17:09:10 -0400
Received: from ns.suse.de ([195.135.220.2]:40899 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750974AbWFKVJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 17:09:08 -0400
Date: Sun, 11 Jun 2006 14:06:34 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI fixes for 2.6.17-rc6
Message-ID: <20060611210634.GA13580@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some small PCI fixes against your latest git tree.  They have
all been in the -mm tree for a while with no problems and do the following:
	- restore the pci config space in reverse order, fixing a number
	  of different systems on resume.
	- properly pass up errors on pci resume to the driver core so it
	  knows about it.
	- fix building the pci express hotplug driver on non-acpi
	  systems (like PPC64).

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h

 drivers/pci/pci-driver.c |   13 ++++++++-----
 drivers/pci/pci.c        |   18 ++++++++++++++++--
 include/linux/pci-acpi.h |    2 +-
 3 files changed, 25 insertions(+), 8 deletions(-)

---------------

Andrew Morton:
      PCI: fix pciehp compile issue when CONFIG_ACPI is not enabled

Dave Jones:
      PCI: Improve PCI config space writeback

Jean Delvare:
      PCI: Error handling on PCI device resume

Yu, Luming:
      PCI: reverse pci config space restore order

