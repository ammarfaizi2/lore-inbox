Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVK3F4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVK3F4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVK3F4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:56:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:34458 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750734AbVK3F4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:56:21 -0500
Date: Tue, 29 Nov 2005 21:56:07 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.15-rc3
Message-ID: <20051130055607.GA4406@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are six small patches for 2.6.15-rc3 against your git tree that fix
some reported problems.  The biggest is the ehci boot issue, and the usb
suspend issue that the ppc people are seeing.  There's also a
documentation fix, a hwmon driver bugfix, and a pci_ids.h duplication
fix in here.

I did this as a git tree to make it easier to apply :)

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel and linux-kernel
mailing lists, if anyone wants to see them.

thanks,

greg k-h


 Documentation/usb/error-codes.txt |    5 ++--
 drivers/hwmon/w83792d.c           |   25 ++++++++++++++------
 drivers/usb/atm/cxacru.c          |    3 ++
 drivers/usb/core/hcd-pci.c        |    3 +-
 drivers/usb/core/hcd.c            |   15 ++++++++----
 drivers/usb/core/hcd.h            |    7 ++++-
 drivers/usb/host/ehci-pci.c       |   46 +++++++++++++++++++++++++++++++-------
 drivers/usb/host/ehci-q.c         |   24 +++++++++++++------
 drivers/usb/host/ehci-sched.c     |   18 +++++++++++++-
 drivers/usb/host/ohci-hcd.c       |    6 ++++
 drivers/usb/host/ohci-hub.c       |   24 ++++++++++++++++---
 drivers/usb/host/ohci-pci.c       |   27 ++++++++++++++++++++--
 drivers/usb/host/uhci-hcd.c       |    6 ++++
 include/linux/pci_ids.h           |    3 --
 14 files changed, 168 insertions(+), 44 deletions(-)


Alan Stern:
      USB: documentation update

Benjamin Herrenschmidt:
      USB: Fix USB suspend/resume crasher (#2)

Dave Jones:
      Additional device ID for Conexant AccessRunner USB driver

David Brownell:
      USB: ehci fixups

Grant Coady:
      pci_ids.h: remove duplicate entries

Jean Delvare:
      hwmon: w83792d fix unused fan pins

