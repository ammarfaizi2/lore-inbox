Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbUEQXtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUEQXtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUEQXsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:48:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:1498 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263174AbUEQXqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:46:00 -0400
Date: Mon, 17 May 2004 16:45:17 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] more USB changes for 2.6.6
Message-ID: <20040517234517.GA22699@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB patches for 2.6.6.  They fix some bugs in the
current USB code (both runtime and at build time) and have a few more
driver cleanups.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/core/hub.c          |   14 
 drivers/usb/core/usb.c          |   11 
 drivers/usb/gadget/ether.c      |   88 -
 drivers/usb/gadget/rndis.c      |   60 
 drivers/usb/gadget/rndis.h      |    1 
 drivers/usb/host/ehci-hcd.c     |    2 
 drivers/usb/host/ehci-hub.c     |   10 
 drivers/usb/host/ehci.h         |    6 
 drivers/usb/host/ohci-hub.c     |    4 
 drivers/usb/host/ohci-pci.c     |    3 
 drivers/usb/host/ohci.h         |    6 
 drivers/usb/image/mdc800.c      |   33 
 drivers/usb/input/aiptek.c      | 3259 +++++++++++++++++++++++++++++++---------
 drivers/usb/input/hid-core.c    |   16 
 drivers/usb/serial/console.c    |    2 
 drivers/usb/serial/usb-serial.c |    7 
 drivers/usb/storage/scsiglue.h  |    2 
 drivers/usb/storage/usb.h       |    2 
 include/linux/pm.h              |    2 
 include/linux/usb.h             |    2 
 20 files changed, 2737 insertions(+), 793 deletions(-)
-----

<zwane:fsmlabs.com>:
  o USB: fix usb-serial serial_open oops

Arjan van de Ven:
  o USB: fix obsolete header usage in usb storage

Bryan W. Headley:
  o USB: Aiptek.c Driver patch

David Brownell:
  o USB: ethernet/rndis gadget address params
  o USB: RNDIS (and CDC) filter flag handling
  o USB: fix MSEC_TO_JIFFIES in usb code
  o USB: fix CONFIG_PM build issues

Greg Kroah-Hartman:
  o USB: fix up formatting issues with aiptek driver
  o USB: fix dumb compile error in aiptek driver
  o USB: fix build error in drivers/usb/serial/console.c

Oliver Neukum:
  o USB: purge wait_ms from core
  o USB: new delay helper safe wrt waitqueues
  o USB: further fix to mdc800

