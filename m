Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVFAFEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVFAFEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVFAFEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:04:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:12765 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261261AbVFAE6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 00:58:23 -0400
Date: Tue, 31 May 2005 22:08:02 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI bugfixes for 2.6.12-rc5
Message-ID: <20050601050802.GA26927@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 3 patches for the 2.6.12-rc5 tree that fix some PCI and PCI
Hotplug bugs, and 1 patch that adds some new device ids for nvidia ide
controllers.  All of these patches have been in the past few -mm
releases.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

Full patches will be sent to the linux-kernel and linux-pci mailing lists, if
anyone wants to see them.

thanks,

greg k-h

 drivers/ide/pci/amd74xx.c               |    3 
 drivers/pci/hotplug/cpci_hotplug_core.c |  302 ++++++++++++++------------------
 drivers/pci/hotplug/cpci_hotplug_pci.c  |  144 +++++----------
 drivers/pci/hotplug/shpchprm_acpi.c     |    4 
 include/linux/pci_ids.h                 |    6 
 5 files changed, 203 insertions(+), 256 deletions(-)
-------------

Andy Currid:
  o PCI: amd74xx patch for new NVIDIA device IDs

Kenji Kaneshige:
  o PCI Hotplug: SHPCHP driver doesn't enable PERR and SERR properly
  o PCI Hotplug: shpchp driver doesn't program _HPP values properly

Scott Murray:
  o PCI Hotplug: more CPCI updates

