Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTFXWYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTFXWYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:24:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:50060 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263722AbTFXWX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:23:58 -0400
Date: Tue, 24 Jun 2003 15:37:12 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.5.73
Message-ID: <20030624223712.GA3190@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some small USB fixes and cleanups for 2.5.72.  Biggest thing
here was deleting a driver that wasn't being built or used anymore.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/net/cdc-ether.c        | 1397 -------------------------------------
 drivers/usb/net/cdc-ether.h        |   98 --
 Documentation/DocBook/gadget.tmpl  |  488 ------------
 drivers/usb/host/uhci-debug.c      |    2 
 drivers/usb/net/kaweth.c           |   73 +
 drivers/usb/serial/io_edgeport.c   |    3 
 drivers/usb/serial/pl2303.c        |    6 
 drivers/usb/serial/visor.c         |   40 +
 drivers/usb/storage/initializers.c |   47 +
 drivers/usb/storage/initializers.h |    6 
 drivers/usb/storage/unusual_devs.h |   20 
 include/linux/usb_gadget.h         |    5 
 12 files changed, 208 insertions(+), 1977 deletions(-)
-----


<judd:jpilot.org>:
  o USB: add module paramater to visor driver for new devices

<kpc-usbdev:gelato.uiuc.edu>:
  o USB: Desknote/ECS UCR-61S2B card reader (2.5.72 patched)

Christoph Weidemann:
  o USB: pentax optio S

David Brownell:
  o USB: GFDL in the kernel tree

Greg Kroah-Hartman:
  o USB: add support for 50 baud to io_edgeport.c
  o USB: pl2303: add ability to report CTS and DSR status to userspace
  o USB: delete cdc-ether driver as it's no longer needed

Johannes Erdfelt:
  o USB: fix UHCI debug kmalloc() usage

Oliver Neukum:
  o USB: make kaweth deal with ENOMEM
  o USB: highdma support for kaweth
  o USB: fix kaweth warnings

