Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269706AbTGJXb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269707AbTGJXb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:31:57 -0400
Received: from storm.he.net ([64.71.150.66]:62343 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S269706AbTGJXbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:31:43 -0400
Date: Thu, 10 Jul 2003 16:46:11 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.5.75
Message-ID: <20030710234611.GA15049@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some small USB fixes for 2.5.75.  Biggest thing here is a sync
up with the usb-serial ftdi_sio driver that is in 2.4.  Everything else
is small.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 MAINTAINERS                        |    2 
 drivers/usb/class/usblp.c          |   24 
 drivers/usb/core/inode.c           |    4 
 drivers/usb/core/message.c         |    2 
 drivers/usb/net/usbnet.c           |    2 
 drivers/usb/serial/ftdi_sio.c      | 1976 ++++++++++++++++++++++++++++---------
 drivers/usb/serial/ftdi_sio.h      |  188 ++-
 drivers/usb/storage/datafab.c      |   90 +
 drivers/usb/storage/freecom.c      |   33 
 drivers/usb/storage/initializers.c |   36 
 drivers/usb/storage/unusual_devs.h |   10 
 drivers/usb/usb-skeleton.c         |    3 
 12 files changed, 1752 insertions(+), 618 deletions(-)
-----

<abbotti:mev.co.uk>:
  o USB: ftdi_sio update

Alan Stern:
  o USB: Updates for unusual_devs.h
  o USB: Small correction to usb-skeleton.c

David Brownell:
  o USB: usbnet, don't NET_XMIT_DROP
  o USB: usb_get_string(), don't use bogus ids

Greg Kroah-Hartman:
  o USB: remove pointless warning about using usbdevfs
  o USB: fix up my USB Bluetooth entry to help prevent confusion in the future

Kay Sievers:
  o usblp: usb_buffer_free() not called

Matthew Dharm:
  o USB: fix datafab and freecom to use I/O buffer
  o USB: fix usb-storage initializers

