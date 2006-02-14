Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWBNGAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWBNGAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWBNGAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:00:05 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:34021
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030305AbWBNGAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:00:04 -0500
Date: Mon, 13 Feb 2006 22:00:07 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.16-rc3
Message-ID: <20060214060007.GA618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB patches for 2.6.16-rc3.  They do the following:
	- build fix for sl811 driver.
	- new device ids for ldusb, hid-core, and pl2303 drivers.
	- take EXPERIMENTAL tag off of the ldusb driver.
	- usb-storage unusual-devices update fixing some new devices.
	- USB EHCI handoff fixup (fixes a number of reported problems.)
	- ability to debug USB OHCI and UHCI handoff a bit easier.

All of these patches have been in the -mm tree for a while.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 drivers/usb/host/pci-quirks.c      |   16 +++++++---
 drivers/usb/host/sl811_cs.c        |    4 +-
 drivers/usb/input/hid-core.c       |   50 ++++++++++++++++++--------------
 drivers/usb/misc/Kconfig           |    2 -
 drivers/usb/misc/ldusb.c           |   57 ++++++++++++++++++++-----------------
 drivers/usb/serial/pl2303.c        |    5 +--
 drivers/usb/serial/pl2303.h        |    4 ++
 drivers/usb/storage/unusual_devs.h |   52 +++++++++++++++++++++++++++++----
 8 files changed, 127 insertions(+), 63 deletions(-)

----

Alan Stern:
      usb-storage: new unusual_devs entry
      usb-storage: unusual_devs entry
      USB: unusual_devs.h entry: TrekStor i.Beat
      USB: unusual_devs.h entry: iAUDIO M5

Christian Lindner:
      USB: PL2303: Leadtek 9531 GPS-Mouse

David Brownell:
      USB: fix up the usb early handoff logic for EHCI
      USB: sl811_cs needs platform_device conversion too

Michael Hund:
      USB: add new device ids to ldusb
      USB: change ldusb's experimental state

Phil Dibowitz:
      USB: unusual-devs bugfix


