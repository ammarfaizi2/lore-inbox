Return-Path: <linux-kernel-owner+w=401wt.eu-S1750727AbXAEUmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbXAEUmJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 15:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbXAEUmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 15:42:09 -0500
Received: from ns2.suse.de ([195.135.220.15]:55840 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbXAEUmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 15:42:08 -0500
Date: Fri, 5 Jan 2007 12:41:36 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes for 2.6.20-rc3
Message-ID: <20070105204136.GA7222@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB fixes for 2.6.20-rc3

They include:
	- more quirks for usbstorage and printer devices
	- minor bugfixes

They have all been in the -mm tree for a while.

The gadget driver update looks big, but David says it fixes a number of
problems with it, and it's self-contained.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/usb/acm.txt               |    4 +
 drivers/usb/class/usblp.c               |    1 +
 drivers/usb/core/endpoint.c             |    2 +-
 drivers/usb/gadget/omap_udc.c           |  245 ++++++++++++++++++++++++-------
 drivers/usb/gadget/omap_udc.h           |    3 +
 drivers/usb/host/uhci-hcd.c             |   20 +--
 drivers/usb/misc/sisusbvga/sisusb_con.c |   12 +-
 drivers/usb/net/asix.c                  |    2 +-
 drivers/usb/serial/Kconfig              |    2 +-
 drivers/usb/serial/option.c             |    3 +
 drivers/usb/storage/unusual_devs.h      |   17 ++-
 11 files changed, 235 insertions(+), 76 deletions(-)

---------------

Alan Stern (2):
      UHCI: make test for ASUS motherboard more specific
      UHCI: support device_may_wakeup

Andrew Morton (2):
      USB: funsoft is borken on sparc
      sisusb_con warning fixes

David Brownell (1):
      USB: omap_udc build fixes (sync with linux-omap)

David Hollis (1):
      USB: asix: Fix AX88772 device PHY selection

Martin Williges (1):
      USB: usblp.c - add Kyocera Mita FS 820 to list of "quirky" printers

Miguel Angel Alvarez (1):
      USB: fix interaction between different interfaces in an "Option" usb device

Oliver Neukum (1):
      USB: small update to Documentation/usb/acm.txt

Pete Zaitcev (1):
      USB storage: fix ipod ejecting issue

Phil Dibowitz (1):
      USB Storage: unusual_devs: add supertop drives

Sarah Bailey (1):
      USB: Fixed bug in endpoint release function.

