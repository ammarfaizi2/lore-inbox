Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWELTDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWELTDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 15:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWELTDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 15:03:38 -0400
Received: from ns1.suse.de ([195.135.220.2]:54432 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751346AbWELTDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 15:03:37 -0400
Date: Fri, 12 May 2006 12:01:40 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes for 2.6.17-rc4 - resend
Message-ID: <20060512190140.GA22554@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more small USB fixes for 2.6.17-rc4.  They contain a few
small bug fixes and a few new device ids for new devices and a new USB
serial driver (it is self-contained).

All of these changes have been in the -mm tree for a number of weeks.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 drivers/block/ub.c              |   18 -
 drivers/usb/atm/speedtch.c      |    2 
 drivers/usb/atm/usbatm.c        |    8 
 drivers/usb/core/hcd.c          |   13 -
 drivers/usb/core/hub.c          |   23 +
 drivers/usb/host/ohci-hcd.c     |    2 
 drivers/usb/input/hid-core.c    |    4 
 drivers/usb/misc/emi26.c        |    4 
 drivers/usb/misc/emi62.c        |    4 
 drivers/usb/net/pegasus.c       |   20 +
 drivers/usb/serial/Kconfig      |   10 
 drivers/usb/serial/Makefile     |    1 
 drivers/usb/serial/airprime.c   |    1 
 drivers/usb/serial/ark3116.c    |  465 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/ftdi_sio.c   |    2 
 drivers/usb/serial/ftdi_sio.h   |    9 
 drivers/usb/serial/generic.c    |    1 
 drivers/usb/serial/omninet.c    |   12 -
 drivers/usb/serial/usb-serial.c |   19 +
 19 files changed, 569 insertions(+), 49 deletions(-)

---------------

Alan Stern:
      USB: usbcore: don't check the device's power source

David Brownell:
      USB: fix bug in ohci-hcd.c ohci_restart()
      USB: pegasus fixes (logstorm, suspend)
      USB: fix OHCI PM regression

Duncan Sands:
      USBATM: change the default speedtouch iso altsetting
      USBATM: fix modinfo output

Greg Kroah-Hartman:
      USB: add ark3116 usb to serial driver
      USB: fix omninet driver bug

Ian Abbott:
      USB: ftdi_sio: Add support for HCG HF Dual ISO RFID Reader

Ken Brush:
      USB: Add Sieraa Wireless 580 evdo card to airprime.c

Luiz Fernando Capitulino:
      usbserial: Fixes use-after-free in serial_open().
      usbserial: Fixes leak in serial_open() error path.

Monty:
      USB: Emagic USB firmware loading fixes

Olaf Hering:
      USB: add an IBM USB keyboard to the HID_QUIRK_NOGET blacklist

Pete Zaitcev:
      USB: ub oops in block_uevent

Razvan Gavril:
      USB: ftdi_sio: add device id for ACT Solutions HomePro ZWave interface

