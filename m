Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTIFBD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTIFBD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:03:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:15529 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261276AbTIFBDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:03:53 -0400
Date: Fri, 5 Sep 2003 18:04:05 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB fixes for 2.6.0-test4
Message-ID: <20030906010405.GA18959@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB fixes for 2.6.0-test4.  They include a fix for
the uhci driver that a lot of people have been running into for a while.
Also included is a fix for the pl2303 driver for B0 and for when you
connect to the device after closing it.

Also included is gadgetfs which allows access to usb gadget devices from
userspace without any ioctls needed :)

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/core/usb.c             |   34 
 drivers/usb/gadget/Kconfig         |   24 
 drivers/usb/gadget/Makefile        |    2 
 drivers/usb/gadget/inode.c         | 1869 +++++++++++++++++++++++++++++++++++++
 drivers/usb/host/uhci-hcd.c        |   42 
 drivers/usb/host/uhci-hcd.h        |    5 
 drivers/usb/serial/pl2303.c        |   24 
 drivers/usb/storage/unusual_devs.h |    7 
 include/linux/usb_gadgetfs.h       |   75 +
 9 files changed, 2056 insertions(+), 26 deletions(-)
-----

<joris:struyve.be>:
  o unusual_devs.h entry

David Brownell:
  o USB: usb_epnum_to_ep_desc only look
  o USB: usb "gadgetfs" (2/2)
  o USB: usb "gadgetfs" (1/2)

Duncan Sands:
  o USB: fix uhci "host controller process error"

Greg Kroah-Hartman:
  o USB: fix up B0 support in the pl2303 driver
  o USB: fix data toggle problem for pl2303 driver

