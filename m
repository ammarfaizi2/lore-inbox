Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbTJJXVl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 19:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTJJXUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 19:20:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:32994 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263188AbTJJXUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 19:20:05 -0400
Date: Fri, 10 Oct 2003 16:18:20 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.0-test7
Message-ID: <20031010231820.GA18566@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB fixes for 2.6.0-test7.  The net2280.c changes fix some
issues on MIPS platforms (and was sent to me before 2.6.0-test7 came
out.)  The other fixes are all minor little things, and support for the
Treo 600 was added to the visor driver.  Oh, and suspend now works for
USB devices, thanks to Paul :)

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/README           |    6 +----
 drivers/usb/class/Kconfig    |    2 -
 drivers/usb/core/devio.c     |    2 -
 drivers/usb/core/hcd-pci.c   |    2 +
 drivers/usb/gadget/Kconfig   |    2 -
 drivers/usb/gadget/net2280.c |   47 +++++++++++++++++++++----------------------
 drivers/usb/host/ohci-hcd.c  |    2 -
 drivers/usb/host/uhci-hcd.c  |    2 -
 drivers/usb/misc/Kconfig     |    2 -
 drivers/usb/serial/visor.c   |    3 ++
 drivers/usb/serial/visor.h   |    1 
 drivers/usb/storage/Kconfig  |    2 -
 12 files changed, 39 insertions(+), 34 deletions(-)
-----

<adobriyan:mail.ru>:
  o USB: Fix two typos in drivers/usb/README
  o USB: Correct module names in drivers/usb/*/Kconfig

<dax:gurulabs.com>:
  o USB: Handspring Treo 600 id

<noah:caltech.edu>:
  o USB: Make Ethernet Gadget depend on CONFIG_NET
  o USB: Make ISD-200 USB/ATA Bridge depend on BLK_DEV_IDE

David Brownell:
  o USB: make more driver names match module names
  o USB: minor net2280 cleanup

Oliver Neukum:
  o USB: remove stupid check for NULL in devio.c

Paul Mackerras:
  o USB: Fix USB suspend in 2.6.0-test6
