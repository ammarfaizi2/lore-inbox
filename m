Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFCItK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFCItK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 04:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVFCItK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 04:49:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:38603 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261187AbVFCItC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 04:49:02 -0400
Date: Fri, 3 Jun 2005 01:58:30 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] More USB bugfixes for 2.6.12-rc5
Message-ID: <20050603085830.GA31276@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more USB patches for the 2.6.12-rc5 tree.  The ub patch is pretty
big, but I forgot to send that one to you way back at the beginning of 2.6.12-rc
It has had much testing in the -mm tree.  The other patches are just fixes or
device ids, or a new driver.  And the cp2101 driver has an update to actually
make it useful.  All of these patches have been in the past few -mm
releases.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

Full patches will be sent to the linux-usb-devel mailing list, if anyone
wants to see them.

thanks,

greg k-h

 drivers/block/ub.c                 |  598 ++++++++++++++++++------------
 drivers/usb/core/sysfs.c           |   22 -
 drivers/usb/input/hid-core.c       |   18 
 drivers/usb/media/pwc/ChangeLog    |  143 -------
 drivers/usb/serial/Kconfig         |   11 
 drivers/usb/serial/Makefile        |    1 
 drivers/usb/serial/cp2101.c        |  363 +++++++++++++-----
 drivers/usb/serial/option.c        |  729 +++++++++++++++++++++++++++++++++++++
 drivers/usb/storage/unusual_devs.h |    9 
 include/linux/usb.h                |    6 
 10 files changed, 1421 insertions(+), 479 deletions(-)

---------------

Adrian Bunk:
  o USB: remove drivers/usb/media/pwc/ChangeLog

Craig Shelley:
  o USB: CP2101 Add support for flow control

Greg Kroah-Hartman:
  o USB: add Vernier devices to HID blacklist

Lonnie Mendez:
  o USB: hid-core: add Earthmate lt-20 productid to blacklist table

Matthias Urlichs:
  o USB: add Option Card driver

Paulo Marques:
  o USB: make MODALIAS code a bit smaller devices

Pete Zaitcev:
  o USB: Support multiply-LUN devices in ub

Phil Dibowitz:
  o USB Storage: Add unusual_devs for Trumpion Voice Recorder

Ping Cheng:
  o USB: add new wacom device to usb hid-core list

Roman Kagan:
  o USB: update urb documentation

