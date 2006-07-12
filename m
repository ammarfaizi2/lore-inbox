Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWGLX1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWGLX1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWGLX1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:27:07 -0400
Received: from ns2.suse.de ([195.135.220.15]:36836 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932178AbWGLX1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:27:05 -0400
Date: Wed, 12 Jul 2006 16:23:20 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI patches for 2.6.18-rc1
Message-ID: <20060712232320.GA22666@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI fixes for 2.6.18-rc1.  They include a new quirk, and
some other minor bugfixes and build cleanup.

All of these patches have been in the -mm tree for a bit.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h



 arch/i386/pci/common.c   |    4 ---
 arch/i386/pci/pci.h      |    2 +-
 drivers/pci/pci.c        |   11 ++++++++-
 drivers/pci/pci.h        |   10 +++++++-
 drivers/pci/quirks.c     |   58 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h      |    1 +
 include/linux/pci_regs.h |   16 +++++++++++++
 7 files changed, 95 insertions(+), 7 deletions(-)

---------------

Adrian Bunk:
      PCI: poper prototype for arch/i386/pci/pcbios.c:pcibios_sort()

Kristen Carlson Accardi:
      PCI: PCIE power management quirk

Matthew Garrett:
      PCI: Clear abnormal poweroff flag on VIA southbridges, fix resume

Zhang, Yanmin:
      PCI: add PCI Express AER register definitions to pci_regs.h

