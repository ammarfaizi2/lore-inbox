Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbULAASN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbULAASN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULAARk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:17:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:44516 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261232AbULAAOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:21 -0500
Date: Tue, 30 Nov 2004 16:05:55 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB fixes for 2.6.10-rc2
Message-ID: <20041201000555.GA27171@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a number of tiny USB fixes for 2.6.10-rc2.  There is also a
documentation update in here too.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h


 Documentation/usb/gadget_serial.txt |  332 ++++++++++++++++++++++++++++++++++++
 drivers/base/firmware_class.c       |    2 
 drivers/block/ub.c                  |    9 
 drivers/usb/Makefile                |    1 
 drivers/usb/core/message.c          |    7 
 drivers/usb/core/urb.c              |    8 
 drivers/usb/core/usb.c              |    2 
 drivers/usb/core/usb.h              |   15 +
 drivers/usb/gadget/ether.c          |   14 +
 drivers/usb/gadget/file_storage.c   |    2 
 drivers/usb/gadget/gadget_chips.h   |    6 
 drivers/usb/gadget/serial.c         |    3 
 drivers/usb/gadget/zero.c           |    2 
 drivers/usb/host/ehci-hcd.c         |    8 
 drivers/usb/host/ehci-hub.c         |    3 
 drivers/usb/host/ehci-q.c           |    2 
 drivers/usb/host/ohci-q.c           |    2 
 drivers/usb/host/uhci-hcd.c         |    5 
 drivers/usb/input/ati_remote.c      |    5 
 drivers/usb/input/hid-core.c        |    3 
 drivers/usb/input/touchkitusb.c     |   19 +-
 drivers/usb/net/usbnet.c            |    2 
 drivers/usb/serial/io_edgeport.c    |    7 
 drivers/usb/serial/visor.c          |    3 
 drivers/usb/storage/Kconfig         |   15 +
 drivers/usb/storage/unusual_devs.h  |    8 
 include/linux/usbdevice_fs.h        |   25 --
 27 files changed, 456 insertions(+), 54 deletions(-)
-----

<dfries:mail.win.org>:
  o USB: fix for HID field index

Al Borchers:
  o USB Gadget: gadget serial documentation

Armijn Hemel:
  o USB: add ati_remote.c device id

Daniel Ritz:
  o USB touchkitusb: module_param to swap axes

David Brownell:
  o USB: ax8817x/usbnet, no GFP_KERNEL blocking in_irq
  o USB: "sparse -Wcontext" and USB HCDs
  o USB: usb_sg_*() unlink deadlock fix
  o USB: fix Genesys GL880S EHCI

Dmitry Krivoschokov:
  o USB Gadget: add and use gadget_is_pxa27x()

Greg Kroah-Hartman:
  o USB: move a internal usbfs only structure out of a public header file
  o USB: minor Makefile fix
  o USB: fix oops in io_edgeport.c driver
  o USB: fix dev_dbg() call in visor.c

Marcel Holtmann:
  o fix unnecessary increment in firmware_class_hotplug() and USB core

Pete Zaitcev:
  o ub: oops with preempt ("Sahara Workshop")
  o ub: flag day - major 180

Phil Dibowitz:
  o USB Storage: Add unusual_devs entry for another yakumo camera

Randy Dunlap:
  o usb-storage should enable scsi disk in Kconfig

Roger Luethi:
  o USB visor: Don't count outstanding URBs twice

Stephen Hemminger:
  o usb_unlink_urb: ratelimit warning

