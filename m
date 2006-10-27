Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752386AbWJ0Snx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbWJ0Snx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 14:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbWJ0Snx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 14:43:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:57741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752372AbWJ0Snw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 14:43:52 -0400
Date: Fri, 27 Oct 2006 11:43:44 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       kristen.c.accardi@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: [GIT PATCH] PCI and PCI hotplug fixes for 2.6.19-rc3
Message-ID: <20061027184344.GA9113@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI and PCI hotplug patches for 2.6.19-rc3.

Most of these patches have been in the -mm tree for a bit.  The
exception was the PCI Hotplug fix, and the "fix sparc64" patch.  Both of
them have been acked by the respective maintainer in the area that they
affect.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h

 arch/i386/pci/fixup.c              |   55 +++++++++++++++++++++++++++
 arch/ia64/pci/Makefile             |    2 +-
 arch/ia64/pci/fixup.c              |   69 ++++++++++++++++++++++++++++++++++
 arch/x86_64/pci/mmconfig.c         |    5 +-
 drivers/pci/hotplug/acpiphp_glue.c |    6 +-
 drivers/pci/pci-driver.c           |   13 ++++++
 drivers/pci/quirks.c               |   73 ------------------------------------
 drivers/pci/rom.c                  |    5 +-
 8 files changed, 147 insertions(+), 81 deletions(-)
 create mode 100644 arch/ia64/pci/fixup.c

---------------

Dave Jones (1):
      PCI: x86-64: mmconfig missing printk levels

Eiichiro Oiwa (1):
      PCI: fix pci_fixup_video as it blows up on sparc64

Karsten Wiese (1):
      PCI: Remove quirk_via_abnormal_poweroff

MUNEDA Takahiro (1):
      acpiphp: fix latch status

Shaohua Li (1):
      PCI: reset pci device state to unknown state for resume

