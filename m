Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262928AbVAQWVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbVAQWVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVAQWUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:20:49 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:23985 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262928AbVAQWCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:02:06 -0500
Date: Mon, 17 Jan 2005 13:56:07 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB patches for 2.6.11-rc1
Message-ID: <20050117215607.GA28830@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few usb bugfixes and a new usb driver for 2.6.11-rc1.  All of
these patches have been in the past few -mm releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 Documentation/devices.txt              |    1 
 Documentation/usb/error-codes.txt      |   17 
 Documentation/usb/sn9c102.txt          |   23 -
 drivers/block/ub.c                     |   86 ++--
 drivers/usb/Makefile                   |    1 
 drivers/usb/class/cdc-acm.c            |   23 -
 drivers/usb/class/usblp.c              |    2 
 drivers/usb/core/devio.c               |    6 
 drivers/usb/core/file.c                |    2 
 drivers/usb/core/hcd.c                 |    7 
 drivers/usb/core/hub.c                 |   22 -
 drivers/usb/core/message.c             |    4 
 drivers/usb/core/usb.c                 |    3 
 drivers/usb/host/ehci-hcd.c            |    2 
 drivers/usb/host/ehci-mem.c            |    8 
 drivers/usb/host/ehci-q.c              |   14 
 drivers/usb/host/ehci-sched.c          |   26 -
 drivers/usb/host/sl811-hcd.c           |    2 
 drivers/usb/host/uhci-debug.c          |   15 
 drivers/usb/host/uhci-hcd.c            |   44 +-
 drivers/usb/host/uhci-hcd.h            |   24 +
 drivers/usb/image/mdc800.c             |    4 
 drivers/usb/input/hid-core.c           |    2 
 drivers/usb/media/sn9c102.h            |   13 
 drivers/usb/media/sn9c102_core.c       |   96 +++--
 drivers/usb/media/sn9c102_hv7131d.c    |    2 
 drivers/usb/media/sn9c102_mi0343.c     |    2 
 drivers/usb/media/sn9c102_pas106b.c    |    2 
 drivers/usb/media/sn9c102_sensor.h     |    2 
 drivers/usb/media/sn9c102_tas5110c1b.c |    2 
 drivers/usb/media/sn9c102_tas5130d1b.c |    2 
 drivers/usb/misc/Kconfig               |   28 +
 drivers/usb/misc/Makefile              |    1 
 drivers/usb/misc/idmouse.c             |  450 +++++++++++++++++++++++-
 drivers/usb/misc/usbtest.c             |    4 
 drivers/usb/net/pegasus.c              |  204 ++++++----
 drivers/usb/net/pegasus.h              |    3 
 drivers/usb/net/usbnet.c               |  101 +++--
 drivers/usb/serial/cypress_m8.c        |  614 ++++++++++++++++++++++++---------
 drivers/usb/serial/ftdi_sio.c          |    3 
 drivers/usb/serial/ftdi_sio.h          |    6 
 drivers/usb/serial/garmin_gps.c        |    8 
 drivers/usb/serial/keyspan.c           |    6 
 drivers/usb/storage/unusual_devs.h     |    8 
 44 files changed, 1423 insertions(+), 472 deletions(-)
-----


<echtler:fs.tum.de>:
  o USB: add driver for the Siemens ID Mouse fingerprint sensor

Alan Stern:
  o USB: correct and clarify error-code documentation
  o USB UHCI: protect DMA-able fields with barriers

Alexey Dobriyan:
  o USB: drivers/usb/*: s/0/NULL/ in pointer context

Arkadiusz Miskiewicz:
  o USB: add Ever UPS vendor/product id to ftdi_sio driver

David Brownell:
  o USB: usbnet:  Olympus R1000 PDA, and blacklisting if CDC && !ZAURUS

Greg Kroah-Hartman:
  o USB: give the idmouse the 132 minor number
  o USB: fix sparse warnings in the idmouse.c driver
  o USB: remove some unneeded exported symbols

Lonnie Mendez:
  o USB cypress_m8: line setting bugfix, circular write buffer added, misc. fixes

Luca Risolia:
  o USB: SN9C10x driver updates

Oliver Neukum:
  o USB: CDC ACM module and Zoom 2985 modem

Pete Zaitcev:
  o USB: Patch to fix ub looping with a tag mismatch

Petko Manolov:
  o pegasus 2.6.10 cset

Phil Dibowitz:
  o USB unusual_devs addition: Ignore residue for ours-tech disk

Thomas Gleixner:
  o USB: Lock initializer cleanup - batch 4

