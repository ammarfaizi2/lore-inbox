Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030666AbVIIWI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030666AbVIIWI7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030669AbVIIWI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:08:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:8844 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030663AbVIIWIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:08:53 -0400
Date: Fri, 9 Sep 2005 15:07:58 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] More PCI patches for 2.6.13
Message-ID: <20050909220758.GA29746@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more PCI patches against your latest git tree.  Most of
them were just not applied to the last pci git pull, due to me messing
up the mbox that I applied to the tree.  They have been in the -mm tree
for a while.

The other two patches are a moving around of the pci probe functions so
that ppc has an easier time of future work, and I've sent in a pci quirk
that has been in the -mm tree for a while.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing lists, if anyone
wants to see them.

thanks,

greg k-h

 drivers/pci/hotplug.c               |   53 ++++++++++++++----------------------
 drivers/pci/hotplug/pciehprm_acpi.c |    8 ++---
 drivers/pci/pci.h                   |    1 
 drivers/pci/probe.c                 |   50 ++++++++++++++++++++++-----------
 drivers/pci/quirks.c                |   12 ++++++++
 include/linux/pci.h                 |   23 ++++++++-------
 6 files changed, 83 insertions(+), 64 deletions(-)


Dave Jones:
  must_check attributes for PCI layer.

Greg Kroah-Hartman:
  PCI: move pci core to use add_hotplug_env_var()

Paul Mackerras:
  PCI: Small rearrangement of PCI probing code

Rajesh Shah:
  PCI: Fix PCI bus mastering enable problem in pciehp

Rumen Ivanov Zarev:
  PCI: Unhide SMBus on Compaq Evo N620c

