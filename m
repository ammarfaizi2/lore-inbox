Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbTFWXsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265003AbTFWXqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:46:52 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:3000 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264865AbTFWXpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:45:51 -0400
Date: Mon, 23 Jun 2003 16:58:52 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.5.73
Message-ID: <20030623235852.GA12207@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some PCI fixes that are against the latest 2.5.73 bk tree.
They fix the compile error that a number of people have reported with
2.5.73 and CONFIG_HOTPLUG=n.  It also has some more acpi pci cleanups by 
Matthew Wilcox.


Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 arch/i386/pci/Makefile           |   28 +++++-----------------
 arch/i386/pci/common.c           |    6 +---
 arch/i386/pci/direct.c           |   48 +++++++++++++++++++++------------------
 arch/i386/pci/numa.c             |   16 ++++++-------
 arch/i386/pci/pcbios.c           |   12 ++++-----
 arch/ia64/pci/pci.c              |   20 ++++++++--------
 drivers/acpi/osl.c               |    6 +++-
 drivers/pci/Makefile             |   10 ++++----
 drivers/pci/hotplug.c            |   13 ----------
 drivers/pci/hotplug/cpqphp_pci.c |    4 +--
 drivers/pci/pci-driver.c         |    8 ++++++
 include/asm-alpha/pci.h          |    3 +-
 include/linux/pci.h              |    4 +--
 13 files changed, 84 insertions(+), 94 deletions(-)
-----

Adrian Bunk:
  o PCI Hotplug: fix buggy comparison in cpqphp_pci.c

Ivan Kokshaysky:
  o PCI: fix alpha for reimplement pci proc name
  o PCI: fix non-hotplug build

Matthew Wilcox:
  o PCI: pci_raw_ops devfn
  o PCI: unconfuse arch/i386/pci/Makefile

