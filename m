Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWEIUHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWEIUHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWEIUHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:07:11 -0400
Received: from ns1.suse.de ([195.135.220.2]:25023 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751102AbWEIUHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:07:10 -0400
Date: Tue, 9 May 2006 13:05:32 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes for 2.6.17-rc3
Message-ID: <20060509200532.GA7148@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more small USB fixes for 2.6.17-rc3.  They contain a few
small bug fixes and a few new device ids for new devices.

All of these changes have been in the -mm tree for a number of weeks.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 drivers/block/ub.c            |   18 ++++++++++--------
 drivers/usb/atm/speedtch.c    |    2 +-
 drivers/usb/atm/usbatm.c      |    8 ++++----
 drivers/usb/core/hcd.c        |   13 ++++++-------
 drivers/usb/core/hub.c        |   23 +++++++++++++----------
 drivers/usb/host/ohci-hcd.c   |    2 +-
 drivers/usb/net/pegasus.c     |   20 +++++++++++++++-----
 drivers/usb/serial/ftdi_sio.c |    2 ++
 drivers/usb/serial/ftdi_sio.h |    9 +++++++++
 9 files changed, 61 insertions(+), 36 deletions(-)

---------------

Alan Stern:
      USB: usbcore: don't check the device's power source

David Brownell:
      USB: fix bug in ohci-hcd.c ohci_restart()
      USB: pegasus fixes (logstorm, suspend)
      USB: fix OHCI PM regression

Duncan Sands:
      USBATM: change the default speedtouch iso altsetting
      USBATM: fix modinfo output

Ian Abbott:
      USB: ftdi_sio: Add support for HCG HF Dual ISO RFID Reader

Pete Zaitcev:
      USB: ub oops in block_uevent

Razvan Gavril:
      USB: ftdi_sio: add device id for ACT Solutions HomePro ZWave interface

