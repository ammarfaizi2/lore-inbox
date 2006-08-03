Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWHCU1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWHCU1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWHCU1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:27:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:19355 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751199AbWHCU1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:27:42 -0400
Date: Thu, 3 Aug 2006 13:23:09 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI fixes for 2.6.18-rc3
Message-ID: <20060803202309.GA28797@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI fixes for 2.6.18-rc3.  They include a new quirk, and
some other minor bugfixes and build cleanup.  Also they remove the
laptop docking station uevent message as it's not really necessary, and
it should be removed before we ship it in a "real" kernel release.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h

 MAINTAINERS                        |    6 ++++++
 drivers/acpi/dock.c                |   13 ++++++------
 drivers/pci/hotplug/acpiphp_core.c |    3 +--
 drivers/pci/hotplug/acpiphp_glue.c |    2 +-
 drivers/pci/pcie/portdrv_pci.c     |   38 +++++++++++++++++++-----------------
 drivers/pci/quirks.c               |    7 +++++++
 drivers/pci/search.c               |    2 +-
 drivers/pnp/interface.c            |   12 ++++++-----
 include/linux/kobject.h            |    2 --
 include/linux/pci_ids.h            |    1 +
 lib/kobject_uevent.c               |    4 ----
 11 files changed, 49 insertions(+), 41 deletions(-)

---------------

Henrik Kretzschmar:
      pcie: fix warnings when CONFIG_PM=n

Jean Delvare:
      PCI: Unhide the SMBus on Asus PU-DLS

Kristen Carlson Accardi:
      PCI Hotplug: add acpiphp to MAINTAINERS
      PCI: docking station: remove dock uevents

Pierre Ossman:
      PNP: Add missing casts in printk() arguments

Randy Dunlap:
      PCIE: cleanup on probe error
      PCI: pci/search: EXPORTs cannot be __devinit

