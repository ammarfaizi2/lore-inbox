Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbUKSWAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbUKSWAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUKSVyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:54:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:7060 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261610AbUKSVwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:52:07 -0500
Date: Fri, 19 Nov 2004 13:51:39 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.10-rc2
Message-ID: <20041119215139.GA15621@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a some bugfixes and additional device ids for USB drivers for
2.6.10-rc2.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/input/Kconfig          |    3 
 drivers/usb/net/pegasus.c          |    8 
 drivers/usb/serial/ftdi_sio.c      |    1 
 drivers/usb/serial/ipaq.c          |  483 +++++++++++++++++++++++++++++++++----
 drivers/usb/serial/ipaq.h          |   75 -----
 drivers/usb/serial/pl2303.c        |    2 
 drivers/usb/serial/pl2303.h        |    2 
 drivers/usb/serial/visor.c         |    3 
 drivers/usb/storage/isd200.c       |    4 
 drivers/usb/storage/scsiglue.c     |   53 ----
 drivers/usb/storage/transport.c    |    4 
 drivers/usb/storage/unusual_devs.h |   18 -
 drivers/usb/storage/usb.c          |   26 -
 drivers/usb/storage/usb.h          |    8 
 14 files changed, 499 insertions(+), 191 deletions(-)
-----

<masaki-c:nict.go.jp>:
  o USB: new defice for usb serial pl2303

<twogood:users.sourceforge.net>:
  o Re: The "ipaq" module: Updated list of vendor/product IDs

Daniel Ritz:
  o USB: Add some help text for touchkitusb

Matthew Dharm:
  o USB Storage: Remove unnecessary state testing
  o USB Storage: Force INQUIRY length to be 36
  o USB Storage: fixes to usb-storage scanning thread

Paul Ortyl:
  o USB Storage: Unusual_dev entry for tekom/yakumo

Paulo Marques:
  o USB: add PID to ftdi_sio.c

Petko Manolov:
  o USB: pegasus endian fixes

Roger Luethi:
  o USB: visor: Always do generic_startup

