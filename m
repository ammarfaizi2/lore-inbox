Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270710AbTGNQ6G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270598AbTGNQ41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:56:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:10127 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270684AbTGNQxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:53:49 -0400
Date: Mon, 14 Jul 2003 10:08:17 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.4.22-pre5
Message-ID: <20030714170817.GA23458@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB bugfixes and updates against 2.4.22-pre5.  There are a
number of resyncs here with drivers that are already in 2.5, and a new
USB host controller driver was added.  Also, the unusual_devs.h list for
usb-storage devices is now in sync with 2.5 thanks to Alan Stern, which
should make things a lot easier in the future.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 MAINTAINERS                        |    4 
 drivers/usb/ax8817x.c              |    4 
 drivers/usb/host/Config.in         |    6 
 drivers/usb/host/Makefile          |    1 
 drivers/usb/host/sl811.c           | 2755 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/host/sl811.h           |  177 ++
 drivers/usb/serial/ftdi_sio.c      |    3 
 drivers/usb/serial/ftdi_sio.h      |    6 
 drivers/usb/serial/ipaq.c          |    3 
 drivers/usb/serial/ipaq.h          |    5 
 drivers/usb/storage/initializers.h |    9 
 drivers/usb/storage/protocol.c     |   54 
 drivers/usb/storage/sddr09.c       |    4 
 drivers/usb/storage/unusual_devs.h |  308 +---
 drivers/usb/storage/usb.c          |   12 
 drivers/usb/storage/usb.h          |    2 
 drivers/usb/usb.c                  |    2 
 drivers/usb/usbnet.c               |  199 +-
 18 files changed, 3265 insertions(+), 289 deletions(-)
-----

<david:csse.uwa.edu.au>:
  o USB: Adding DSS-20 SyncStation to ftdi_sio

<yinah:couragetech.com.cn>:
  o USB: patch for sl811 usb host controller driver

Alan Stern:
  o USB: Implement US_FL_FIX_CAPACITY for 2.4
  o USB: Updates for unusual_devs.h
  o USB: Final reconciliation for unusual_devs.h in 2.4
  o USB: Reconcile unusual_devs.h for 2.4 and 2.5

David Brownell:
  o USB: usbnet updates
  o USB: usb_string(), don't use bogus ids

David T. Hollis:
  o USB: ax8817x.c - add Intellinet USB 2.0 Ethernet device ids

Ganesh Varadarajan:
  o USB: more ids for ipaq

Greg Kroah-Hartman:
  o USB: fix up previous sl811 patch
  o USB: fix up my USB Bluetooth entry to help prevent confusion in the future

