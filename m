Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161345AbWI1Wmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161345AbWI1Wmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161346AbWI1Wmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:42:50 -0400
Received: from mail.suse.de ([195.135.220.2]:58327 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161345AbWI1Wmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:42:49 -0400
Date: Thu, 28 Sep 2006 15:42:50 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] More USB patches for 2.6.18
Message-ID: <20060928224250.GA23841@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more USB bugfixes and device ids 2.6.18.  They should all
fix the reported problems in your current tree (if not, please let me
know.)

All of these changes have been in the -mm tree for a while.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 drivers/usb/core/driver.c          |   65 ++++-----
 drivers/usb/core/hcd.c             |    6 -
 drivers/usb/core/hub.c             |    4 -
 drivers/usb/core/usb.c             |   46 ++++++
 drivers/usb/core/usb.h             |   19 ++-
 drivers/usb/gadget/dummy_hcd.c     |   33 +++-
 drivers/usb/gadget/file_storage.c  |   35 ++++-
 drivers/usb/host/ohci-hcd.c        |   18 +-
 drivers/usb/host/ohci-hub.c        |  265 +++++++++++++++++++++---------------
 drivers/usb/host/ohci-pci.c        |    3 
 drivers/usb/host/ohci.h            |    1 
 drivers/usb/image/microtek.c       |   18 +-
 drivers/usb/image/microtek.h       |    4 -
 drivers/usb/input/hid-core.c       |    4 +
 drivers/usb/misc/phidgetkit.c      |   56 +++++---
 drivers/usb/net/asix.c             |    4 +
 drivers/usb/net/kaweth.c           |    1 
 drivers/usb/net/pegasus.c          |   18 +-
 drivers/usb/serial/cyberjack.c     |    6 -
 drivers/usb/serial/ftdi_sio.c      |    4 +
 drivers/usb/serial/ftdi_sio.h      |   10 +
 drivers/usb/serial/generic.c       |    6 -
 drivers/usb/serial/ipaq.c          |    1 
 drivers/usb/serial/ipw.c           |    6 -
 drivers/usb/serial/ir-usb.c        |    6 -
 drivers/usb/serial/keyspan_pda.c   |    6 -
 drivers/usb/serial/omninet.c       |    6 -
 drivers/usb/serial/pl2303.c        |    1 
 drivers/usb/serial/pl2303.h        |    4 +
 drivers/usb/serial/safe_serial.c   |    6 -
 drivers/usb/storage/unusual_devs.h |   14 ++
 include/linux/usb.h                |    2 
 32 files changed, 436 insertions(+), 242 deletions(-)

---------------

Alan Cox:
      ohci: Use ref-counting hotplug safe interfaces

Alan Stern:
      USB: unusual-devs entry for Nokia E60
      USB: create new workqueue thread for USB autosuspend
      USB: dummy-hcd: fix "warn-unused-result" messages
      USB: g_file_storage: fix "ignoring return value" warnings
      USB: allow both root-hub interrupts and polling
      OHCI: remove existing autosuspend code
      OHCI: add auto-stop support
      USB: fix autosuspend when CONFIG_PM isn't set
      USB: g_file_storage: Set sense info Valid bit only when needed

David Hollis:
      USB: asix - Add alternate device IDs for Dlink DUB-E100 Rev B1

Henrik Kretzschmar:
      USB: fixes kerneldoc errors in usbcore-auto(susp/res)-patch
      USB: microtek usb scanner: Scsi_Cmnd conversion

Ian Abbott:
      USB serial ftdi_sio: Add support for Tactrix OpenPort devices

Jan Mate:
      USB Storage: unusual_devs.h entry for Sony Ericsson P990i

Justin Carlson:
      USB: add SeaLevel 2106 SeaLINK support to ftdi_sio

Matthias Urlichs:
      USB: another device ID for ipaq

Mikael Pettersson:
      USB: Fix alignment of buffer passed down to ->hub_control()

Oliver Neukum:
      USB: new id for kaweth

Peter Zijlstra:
      usb-serial: possible irq lock inversion (PPP vs. usb/serial)

Petko Manolov:
      USB: Pegasus driver failing for ADMtek 8515 network device

Raghavendra Biligiri:
      USB: add Raritan KVM USB Dongle to the HID_QUIRK_NOGET blacklist

Sean Young:
      USB: New PhidgetKit 8/8/8 reset outputs after 2 seconds

Wesley PA4WDH:
      USB: Add vendor / product ID to pl2303

