Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVGAUvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVGAUvC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVGAUvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:51:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:10465 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262560AbVGAUru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:47:50 -0400
Date: Fri, 1 Jul 2005 13:47:41 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI patches for 2.6.13-rc1
Message-ID: <20050701204741.GA1137@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI patches against your latest git tree.  These are the
rest of the PCI patches that have been in the -mm tree for a while, with
(hopefully) the patches that caused all the pcmcia problems removed.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-kernel and linux-pci mailing
lists, if anyone wants to see them.

thanks,

greg k-h


 arch/i386/kernel/cpu/cpufreq/gx-suspmod.c |    2 
 arch/i386/pci/common.c                    |    1 
 arch/i386/pci/i386.c                      |   11 +
 drivers/char/hw_random.c                  |    2 
 drivers/char/watchdog/i8xx_tco.c          |    2 
 drivers/ide/setup-pci.c                   |    2 
 drivers/parport/parport_pc.c              |    2 
 drivers/pci/Makefile                      |    1 
 drivers/pci/hotplug.c                     |    2 
 drivers/pci/pci-driver.c                  |  196 ++++++++++--------------------
 drivers/pci/pci.c                         |    6 
 drivers/pci/pcie/portdrv.h                |    5 
 drivers/pci/pcie/portdrv_core.c           |    8 +
 drivers/pci/pcie/portdrv_pci.c            |   79 +++++++++++-
 drivers/pci/probe.c                       |   24 +++
 drivers/pci/quirks.c                      |    1 
 drivers/pci/setup-bus.c                   |    2 
 include/linux/pci-dynids.h                |   18 --
 include/linux/pci.h                       |    5 
 sound/pci/bt87x.c                         |    2 
 20 files changed, 205 insertions(+), 166 deletions(-)

------------

Andy Whitcroft:
  gregkh-pci-pci-assign-unassigned-resources fix

Greg Kroah-Hartman:
  PCI: clean up dynamic pci id logic
  PCI: Fix up PCI routing in parent bridge

Hannes Reinecke:
  PCI: Remove newline from pci MODALIAS variable

Ivan Kokshaysky:
  PCI: handle subtractive decode pci-pci bridge better
  PCI: pci_assign_unassigned_resources() on x86

Jean Delvare:
  PCI: Add PCI quirk for SMBus on the Asus P4B-LX

John W. Linville:
  pci: cleanup argument comments for pci_{save,restore}_state

long:
  PCI: acpi tg3 ethernet not coming back properly after S3 suspendon DellM70

rajesh.shah@intel.com:
  PCI: Increase the number of PCI bus resources

