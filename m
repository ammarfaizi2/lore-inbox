Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264088AbUE1Vx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbUE1Vx4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUE1Vv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:51:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:58040 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262431AbUE1Vsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:48:41 -0400
Date: Fri, 28 May 2004 14:46:43 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.7-bk1
Message-ID: <20040528214643.GA13068@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a number of various USB fixes and cleanups for 2.6.7-bk1.  All
of these patches have been in the past few -mm releases.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/core/driverfs.c     |  229 ---------------
 drivers/usb/class/usblp.c       |   21 +
 drivers/usb/core/Makefile       |    2 
 drivers/usb/core/config.c       |   17 -
 drivers/usb/core/hcd.h          |    4 
 drivers/usb/core/hub.c          |  604 ++++++++++++++++++++--------------------
 drivers/usb/core/message.c      |    2 
 drivers/usb/core/sysfs.c        |  229 +++++++++++++++
 drivers/usb/core/usb.c          |  107 +++----
 drivers/usb/core/usb.h          |    4 
 drivers/usb/gadget/Kconfig      |    1 
 drivers/usb/gadget/epautoconf.c |    3 
 drivers/usb/gadget/serial.c     |    9 
 drivers/usb/host/uhci-hcd.c     |   51 +++
 drivers/usb/host/uhci-hcd.h     |    3 
 drivers/usb/input/hiddev.c      |    4 
 drivers/usb/input/powermate.c   |   20 -
 drivers/usb/net/kaweth.c        |   11 
 drivers/usb/net/pegasus.h       |    3 
 drivers/usb/serial/Kconfig      |    4 
 drivers/usb/serial/ftdi_sio.c   |  125 ++++++--
 drivers/usb/serial/kobil_sct.c  |   51 ++-
 drivers/usb/serial/visor.c      |  123 ++++----
 drivers/usb/storage/transport.c |    3 
 24 files changed, 906 insertions(+), 724 deletions(-)
-----

<errandir_news:mph.eclipse.co.uk>:
  o USB: usblp printer GET_DEVICE_ID fix

<jnardelli:infosciences.com>:
  o USB: visor: Fix Oops on disconnect

<movits:bloomberg.com>:
  o USB: add support for MS adapter to usb pegasus net driver

<thomas.wahrenbruch:kobil.com>:
  o USB: Fix kobil_sct with uhci

Alan Stern:
  o USB: Use normal return codes for several routines in hub.c
  o USB: Gonzo variable renaming in hub.c
  o USB: Make usb_choose_configuration() a separate subroutine
  o USB: Add usb_release_address() and move usb_set_address()
  o USB: Change "driverfs" to "sysfs" in usbcore
  o USB UHCI: allow URBs to be unlinked when IRQs don't work
  o USB: Initially read 9 bytes of config descriptor

David Brownell:
  o USB: PXA 2xx UDC and RNDIS g_ether

Ian Abbott:
  o USB: ftdi_sio throttling fix

James Lamanna:
  o USB: Fix down() in hard IRQ in powermate driver

Luiz Capitulino:
  o USB: /usb/gadget/serial.c warning fix

Olaf Hering:
  o USB: out of bounds access in hiddev_cleanup

Oliver Neukum:
  o USB: fix fix to kaweth.c
  o USB: waitqueue related problem in kaweth
  o USB: yet another place for msleep
  o USB: clean delays for ehci

