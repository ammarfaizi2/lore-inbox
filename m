Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTD3VRa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTD3VRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:17:30 -0400
Received: from granite.he.net ([216.218.226.66]:7436 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262424AbTD3VR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:17:28 -0400
Date: Wed, 30 Apr 2003 14:31:41 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB changes for 2.5.68
Message-ID: <20030430213141.GA24995@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB changes and fixes for 2.5.68.  There are a few
bugs fixed as found by the CHECKER project, and a usbnet driver rework
and a few other minor changes.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h


 drivers/input/joystick/sidewinder.c |   11 +-
 drivers/input/misc/uinput.c         |   35 ++++---
 drivers/usb/Makefile                |    1 
 drivers/usb/core/urb.c              |   31 +++++-
 drivers/usb/host/uhci-hcd.c         |   13 +-
 drivers/usb/input/usbkbd.c          |    3 
 drivers/usb/input/usbmouse.c        |    3 
 drivers/usb/media/vicam.c           |    5 -
 drivers/usb/net/Kconfig             |  175 +++++++++++++++++++++++++++---------
 drivers/usb/net/Makefile            |    1 
 drivers/usb/net/usbnet.c            |  113 +++++++++++++++--------
 drivers/usb/serial/empeg.c          |    4 
 drivers/usb/serial/io_edgeport.c    |    6 -
 drivers/usb/serial/ipaq.c           |    2 
 drivers/usb/serial/keyspan.c        |    4 
 drivers/usb/serial/usb-serial.h     |    2 
 drivers/usb/storage/unusual_devs.h  |   33 ++++++
 include/linux/usb.h                 |    3 
 18 files changed, 321 insertions(+), 124 deletions(-)
-----

<ccheney@cheney.cx>:
  o USB: vicam.c copyright patches

<gj@pointblue.com.pl>:
  o USB: fix usbkbd.c compilation error

<james@superbug.demon.co.uk>:
  o USB: Add support for Pentax Still Camera to linux kernel

<joe@perches.com>:
  o USB: fix up usb.h's dbg macro to take up less space
  o USB: fix up usb_serial.h's dbg macro to take up less space
  o USB: fix up usbnet's macros for older compilers

<linux-usb@gemeinhardt.info>:
  o USB: add support for Mello MP3 Player

Alan Stern <stern@rowland.harvard.edu>:
  o USB: Minor patch for uhci-hcd.c

David Brownell <david-b@pacbell.net>:
  o USB: usbnet, config changes for CDC Ether

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: add comment to storage/unusual_devs.h that specifies how to add new entries
  o USB: added support for Sony DSC-P8
  o USB: create usb_init_urb() for those people who like to live dangerously (like the bluetooth stack.)
  o USB: fix CHECKER found bug in the keyspan.c driver
  o USB: fix CHECKER found bug in the ipaq.c driver
  o USB: fix CHECKER found bug in the io_edgeport.c driver
  o USB: fix CHECKER found bug in the empeg.c driver

Randy Dunlap <randy.dunlap@verizon.net>:
  o uinput.c: reduce stack usage
  o sidewinder: reduce stack usage

