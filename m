Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319407AbSHNVp7>; Wed, 14 Aug 2002 17:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319408AbSHNVp7>; Wed, 14 Aug 2002 17:45:59 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:38660 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319407AbSHNVp6>;
	Wed, 14 Aug 2002 17:45:58 -0400
Date: Wed, 14 Aug 2002 14:45:40 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] Yet more USB changes for 2.5.31
Message-ID: <20020814214540.GA29006@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a compile time error in your latest BK tree, and has some USB
API cleanups for the upcoming struct device_driver changes.


Pull from:  http://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/usb/core/devio.c       |   20 +++---
 drivers/usb/core/hcd.h         |   10 +++
 drivers/usb/core/hub.h         |    4 +
 drivers/usb/core/message.c     |    2 
 drivers/usb/core/usb.c         |  135 ++++++++++++++++-------------------------
 drivers/usb/host/ehci-dbg.c    |    4 -
 drivers/usb/serial/usbserial.c |    2 
 drivers/usb/storage/scsiglue.c |    2 
 include/linux/usb.h            |   20 +-----
 9 files changed, 92 insertions(+), 107 deletions(-)
------

ChangeSet@1.522, 2002-08-14 14:30:03-07:00, greg@kroah.com
  USB: changed usb_match_id to not need the usb_device pointer.

 drivers/usb/core/usb.c         |   18 +++++++++---------
 drivers/usb/serial/usbserial.c |    2 +-
 drivers/usb/storage/scsiglue.c |    2 +-
 include/linux/usb.h            |    3 +--
 4 files changed, 12 insertions(+), 13 deletions(-)
------

ChangeSet@1.521, 2002-08-14 14:11:37-07:00, david-b@pacbell.net
  [PATCH] USB core cleanups
  
  Moves some functions that are only used by usbfs to be private, and
  documents some of the interface issues that need to be cleaned up.

 drivers/usb/core/devio.c   |   20 +++++--
 drivers/usb/core/hcd.h     |   10 +++
 drivers/usb/core/hub.h     |    4 +
 drivers/usb/core/message.c |    2 
 drivers/usb/core/usb.c     |  117 +++++++++++++++++----------------------------
 include/linux/usb.h        |   17 +-----
 6 files changed, 78 insertions(+), 92 deletions(-)
------

ChangeSet@1.520, 2002-08-14 14:10:56-07:00, greg@kroah.com
  USB: fixed DEVICE_ATTR usage in the ehci driver

 drivers/usb/host/ehci-dbg.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

