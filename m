Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUA0XVZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUA0XVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:21:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:24505 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263946AbUA0XVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:21:22 -0500
Date: Tue, 27 Jan 2004 15:21:07 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.6.2-rc2
Message-ID: <20040127232107.GA28680@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB patches for 2.6.2-rc2.  Here are the main types of
changes:
	- a number of small bugfixes
	- a usb gadget update including the ability to enable the
	  drivers to build properly, and a new gadget filesystem driver.
	- a new ohci host controller driver for the omap platform.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/Kconfig                |    2 
 drivers/usb/core/hub.c             |    5 
 drivers/usb/core/message.c         |   37 
 drivers/usb/core/usb.c             |   24 
 drivers/usb/core/usb.h             |    3 
 drivers/usb/gadget/Kconfig         |  207 +
 drivers/usb/gadget/Makefile        |    5 
 drivers/usb/gadget/ether.c         |   98 
 drivers/usb/gadget/file_storage.c  | 4169 +++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/net2280.c       |  489 ++--
 drivers/usb/gadget/net2280.h       |    6 
 drivers/usb/gadget/serial.c        |   27 
 drivers/usb/gadget/zero.c          |   10 
 drivers/usb/host/ohci-hcd.c        |    6 
 drivers/usb/host/ohci-omap.c       |  673 +++++
 drivers/usb/host/ohci-omap.h       |   57 
 drivers/usb/media/dabusb.c         |   12 
 drivers/usb/misc/Kconfig           |    2 
 drivers/usb/misc/auerswald.c       |    4 
 drivers/usb/misc/tiglusb.c         |   24 
 drivers/usb/serial/kobil_sct.c     |    2 
 drivers/usb/serial/whiteheat.c     |   27 
 drivers/usb/storage/scsiglue.c     |   39 
 drivers/usb/storage/unusual_devs.h |   12 
 include/linux/usb.h                |    1 
 sound/usb/usbaudio.c               |    6 
 26 files changed, 5574 insertions(+), 373 deletions(-)
-----


Alan Stern:
  o USB: Update sound/usb/usbaudio.c
  o USB: Fix DMA coherence when reading device descriptor
  o USB: Don't dereference NULL actconfig
  o USB Storage: unusual_devs update

Arjan van de Ven:
  o usb: remove some sleep_on's

Dave Jones:
  o USB: fix suspicious pointer usage in kobil_sct driver

David Brownell:
  o USB gadget: serial driver config update
  o USB gadget: ethernet config updates
  o USB gadget: zero config updates
  o USB gadget: config/build updates
  o USB gadget: add File-backed Storage Gadget (FSG)
  o USB gadget: net2280 controller updates

Greg Kroah-Hartman:
  o USB: add ohci support for OMAP controller
  o USB: fix up whiteheat syntax errors from previous patch
  o USB: fix up emi drivers Kconfig dependancy
  o USB storage: remove info sysfs file as it violates the sysfs 1 value per file rule

Herbert Xu:
  o USB Storage: revert freecom dvd-rw fx-50 usb-ide patch

Oliver Neukum:
  o USB: fix dma to stack in ti driver
  o USB: fix whiteheat doing DMA to stack

