Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTJXGLT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 02:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTJXGLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 02:11:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:28321 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262015AbTJXGLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 02:11:18 -0400
Date: Thu, 23 Oct 2003 23:06:53 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.0-test8
Message-ID: <20031024060652.GA3617@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB fixes for 2.6.0-test8.  They are all small bugfixes or
add some new device ids to the ftdi_sio and usb-storage drivers.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/class/audio.c          |    4 +
 drivers/usb/class/cdc-acm.c        |   82 +++++++++++++++++++------------------
 drivers/usb/core/message.c         |   12 ++---
 drivers/usb/core/usb.c             |    3 +
 drivers/usb/gadget/inode.c         |    4 -
 drivers/usb/media/vicam.c          |    1 
 drivers/usb/misc/brlvger.c         |    1 
 drivers/usb/net/usbnet.c           |    7 ++-
 drivers/usb/serial/ftdi_sio.c      |   52 ++++++++++++-----------
 drivers/usb/serial/ftdi_sio.h      |   13 ++++-
 drivers/usb/serial/io_edgeport.c   |    1 
 drivers/usb/storage/unusual_devs.h |   14 +++++-
 12 files changed, 115 insertions(+), 79 deletions(-)
-----


<car.busse:gmx.de>:
  o USB: one more digicam for unusual_devs.h

Alan Stern:
  o USB: fix for earlier unusual_devs.h patch

Arnaldo Carvalho de Melo:
  o leaking info on drivers/usb

David Brownell:
  o USB: usb enumeration clears full speed ep0 state
  o USB: fix usb-storage self-deadlock
  o USB: ACM USB modem fixes

David T. Hollis:
  o USB: ax8817x fixes in usbnet.c

Greg Kroah-Hartman:
  o USB: gadget fixes for 64bit processor warnings

Ian Abbott:
  o USB: ftdi_sio - Perle UltraPort new ids - 2 of 2
  o USB: ftdi_sio - Perle UltraPort new ids - 1 of 2

