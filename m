Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUHWWra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUHWWra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUHWWoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:44:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:2738 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267732AbUHWWZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:25:08 -0400
Date: Mon, 23 Aug 2004 15:19:25 -0700
From: Greg KH <greg@kroah.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       garyhade@us.ibm.com
Subject: [BK PATCH] PCI Hotplug patches for 2.4.28-pre1
Message-ID: <20040823221925.GA5368@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 4 PCI Hotplug patches for 2.4.28-pre1.  Two of them are
bugfixes for the different pci hotplug drivers, and the last patch
changes the 2.4 PCI Hotplug maintainer to be Gary Hade, instead of
myself.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/pci-2.4

The raw patches will follow.

thanks,

greg k-h


 MAINTAINERS                        |   10 +-
 arch/i386/kernel/pci-irq.c         |    8 --
 drivers/hotplug/cpqphp_ctrl.c      |    9 ++
 drivers/hotplug/pciehp.h           |    2 
 drivers/hotplug/pciehp_ctrl.c      |  146 ++++++++++++-------------------------
 drivers/hotplug/pciehp_hpc.c       |   29 +------
 drivers/hotplug/pciehp_pci.c       |    4 -
 drivers/hotplug/pciehprm_acpi.c    |   22 ++++-
 drivers/hotplug/pciehprm_nonacpi.c |   18 +++-
 drivers/hotplug/shpchp.h           |    1 
 drivers/hotplug/shpchp_ctrl.c      |   54 +++++--------
 drivers/hotplug/shpchp_hpc.c       |   10 --
 drivers/hotplug/shpchp_pci.c       |    1 
 drivers/hotplug/shpchprm_acpi.c    |   22 ++++-
 drivers/hotplug/shpchprm_nonacpi.c |   18 +++-
 drivers/pci/pci.c                  |    1 
 drivers/pci/quirks.c               |    9 --
 include/linux/pci.h                |    2 
 18 files changed, 147 insertions(+), 219 deletions(-)
-----

Dan Zink:
  o PCI Hotplug: fix potential hang in cpqphp

Dely Sy:
  o PCI Hotplug: Fixes for hot-plug drivers in 2.4 kernel

Gary Hade:
  o PCI Hotplug: change MAINTAINERS

