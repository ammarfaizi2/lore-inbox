Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTDRWCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 18:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTDRWCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 18:02:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44992 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263273AbTDRWCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 18:02:43 -0400
Date: Fri, 18 Apr 2003 15:15:26 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.4.21-pre7
Message-ID: <20030418221526.GA8638@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB bugfixes for 2.4.21-pre7.  These are all pretty small
and important (the ftdi_sio one is a bit bigger, but still needed.)

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 drivers/usb/CDCEther.c             |   50 +-
 drivers/usb/CDCEther.h             |    3 
 drivers/usb/acm.c                  |    1 
 drivers/usb/host/ehci-mem.c        |    1 
 drivers/usb/host/ehci-q.c          |   10 
 drivers/usb/host/uhci.c            |    2 
 drivers/usb/pegasus.c              |   10 
 drivers/usb/pegasus.h              |    6 
 drivers/usb/scanner.c              |   11 
 drivers/usb/scanner.h              |    2 
 drivers/usb/serial/ftdi_sio.c      |  855 ++++++++++++++++++++++++++++---------
 drivers/usb/serial/ftdi_sio.h      |   56 ++
 drivers/usb/serial/io_edgeport.c   |    8 
 drivers/usb/serial/ipaq.c          |    1 
 drivers/usb/serial/ipaq.h          |    3 
 drivers/usb/storage/unusual_devs.h |    9 
 drivers/usb/usb.c                  |    2 
 18 files changed, 798 insertions(+), 252 deletions(-)
-----

<alborchers@steinerpoint.com>:
  o USB: patch for oops in io_edgeport.c

<arndt@lin02384n012.mc.schoenewald.de>:
  o USB: Patch against unusual_devs.h to enable Pontis SP600

<bryder@paradise.net.nz>:
  o USB: ftdi_sio update

<legoll@free.fr>:
  o USB: New USB serial device ID: Asus A600 PDA cradle

<soruk@eridani.co.uk>:
  o USB: enable Motorola cellphone USB modems

Alan Stern <stern@rowland.harvard.edu>:
  o USB: usb-storage START-STOP under Linux 2.4

David Brownell <david-b@pacbell.net>:
  o USB: CDC Ether fix notifications
  o USB: usbcore deadlock paranoia
  o USB: ehci-hcd, minor hardware tweaks

Duncan Sands <baldrick@wanadoo.fr>:
  o USB: uhci bandaid

Henning Meier-Geinitz <henning@meier-geinitz.de>:
  o USB: scanner.c endpoint detection fix

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: pegasus link status detection fix

