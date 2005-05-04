Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVEDHpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVEDHpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVEDHpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:45:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:40586 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262082AbVEDHou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:44:50 -0400
Date: Wed, 4 May 2005 00:43:32 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [GIT PATCH] USB bugfixes for 2.6.12-rc3
Message-ID: <20050504074331.GA18575@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a number of USB bugfixes for 2.6.12-rc3 and one new, tiny
driver (63 lines, with comments).  They have all been in the last few
-mm releases.

Pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

Full patches will be sent to the linux-usb-devel mailing lists, if
anyone wants to see them.

thanks,

greg k-h

-------------

 drivers/usb/core/message.c            |    4 
 drivers/usb/core/urb.c                |    6 -
 drivers/usb/gadget/ether.c            |    2 
 drivers/usb/gadget/inode.c            |    2 
 drivers/usb/gadget/lh7a40x_udc.c      |    2 
 drivers/usb/gadget/serial.c           |    2 
 drivers/usb/host/ehci-hcd.c           |   65 ++++++++---
 drivers/usb/host/ehci-hub.c           |    2 
 drivers/usb/host/ehci.h               |   19 +--
 drivers/usb/host/hc_crisv10.c         |    2 
 drivers/usb/host/sl811-hcd.c          |    4 
 drivers/usb/image/mdc800.c            |    2 
 drivers/usb/input/aiptek.c            |    2 
 drivers/usb/input/mtouchusb.c         |    2 
 drivers/usb/media/ov511.c             |    2 
 drivers/usb/media/pwc/pwc-ctrl.c      |    2 
 drivers/usb/media/pwc/pwc-if.c        |    6 -
 drivers/usb/media/pwc/pwc-ioctl.h     |    2 
 drivers/usb/misc/legousbtower.c       |    2 
 drivers/usb/net/usbnet.c              |    3 
 drivers/usb/net/zd1201.c              |    8 -
 drivers/usb/serial/Kconfig            |    9 +
 drivers/usb/serial/Makefile           |    1 
 drivers/usb/serial/airprime.c         |   63 +++++++++++
 drivers/usb/serial/cypress_m8.c       |  187 ++++++++++++++++------------------
 drivers/usb/serial/ftdi_sio.c         |   46 ++++++--
 drivers/usb/serial/ftdi_sio.h         |   36 ++++--
 drivers/usb/serial/io_usbvend.h       |    2 
 drivers/usb/serial/keyspan_usa90msg.h |    2 
 drivers/usb/storage/debug.c           |    1 
 drivers/usb/storage/shuttle_usbat.c   |    2 
 drivers/usb/storage/unusual_devs.h    |   17 ++-
 32 files changed, 329 insertions(+), 178 deletions(-)

Andrea Arcangeli:
  o USB: new usbnet device id

David Brownell:
  o USB: ehci power fixes

Greg Kroah-Hartman:
  o USB: add a driver for the AirPrime CDMA Wireless PC card

Ian Abbott:
  o USB: ftdi_sio redundant macro removal
  o USB: VID/PID updates for ftdi_sio driver

Lonnie Mendez:
  o USB cypress_m8: update kernel driver with current source

Matthew Dharm:
  o USB Storage: fix compile error

Phil Dibowitz:
  o USB: unusual_devs entry for Minolta Dimage Z10

Steven Cole:
  o USB: Spelling fixes for drivers/usb

Vivian Bregier:
  o USB: unusual_devs.h: atmel snd1 storage

