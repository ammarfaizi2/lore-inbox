Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUA3B3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUA3B3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:29:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:17115 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266319AbUA3B3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:29:22 -0500
Date: Thu, 29 Jan 2004 17:29:25 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI update for 2.6.2-rc2
Message-ID: <20040130012925.GA11727@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI and PCI hotplug patches for 2.6.2-rc2.
There's a few misc pci patches in here for different platforms (mips and
ppc64) and a few pci hotplug bug fixes.  There's also a big pci.ids
update that is the majority of the patch.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/pci/bus.c                      |    2 
 drivers/pci/gen-devlist.c              |   16 
 drivers/pci/hotplug/acpiphp.h          |    5 
 drivers/pci/hotplug/acpiphp_core.c     |   30 -
 drivers/pci/hotplug/acpiphp_glue.c     |   51 +
 drivers/pci/hotplug/acpiphp_pci.c      |    6 
 drivers/pci/hotplug/acpiphp_res.c      |    3 
 drivers/pci/hotplug/cpcihp_zt5550.c    |    2 
 drivers/pci/hotplug/pci_hotplug.h      |    6 
 drivers/pci/hotplug/pci_hotplug_core.c |   44 +
 drivers/pci/hotplug/pcihp_skeleton.c   |    8 
 drivers/pci/names.c                    |    3 
 drivers/pci/pci-sysfs.c                |    1 
 drivers/pci/pci.ids                    |  961 ++++++++++++++++++++++++---------
 drivers/pci/probe.c                    |  199 ++++--
 drivers/pci/search.c                   |   38 +
 include/linux/pci.h                    |   34 -
 17 files changed, 1043 insertions(+), 366 deletions(-)
-----

<eike-hotplug:sf-tec.de>:
  o PCI Hotplug: Fixup pcihp_skeleton.c

<johnrose:austin.ibm.com>:
  o PCI: Allow pci hotplug drivers to initialize individual devices

<kieran:mgpenguin.net>:
  o PCI: pci.ids update
  o PCI: name length change

<ogasawara:osdl.org>:
  o PCI hotplug: pcihp_zt5550.c ioremap/iounmap audit

Greg Kroah-Hartman:
  o PCI: fix compiler warning in probe.c cause by PPC patch
  o PCI: add .owner field to the config sysfs file to be "correct"

Linda Xie:
  o PCI Hotplug: add unlimited PHP slot name lengths support

Martin Hicks:
  o PCI Hotplug: Trivial warning fix

Matthew Dobson:
  o PCI: add pci_bus sysfs class

Matthew Wilcox:
  o PCI: fix pci_get_slot() bug
  o PCI: add pci_get_slot() function
  o PCI Hotplug: Better reporting of PCI frequency / bus mode problems for acpi driver

Ralf Bächle:
  o PCI: fix probing for some mips systems

Russell King:
  o Prevent PCI driver registration failure oopsing

Takayoshi Kochi:
  o PCI Hotplug: add address file and fix acpiphp bugs

