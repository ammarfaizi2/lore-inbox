Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTGAVbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 17:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTGAVbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 17:31:32 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:17917 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263897AbTGAVb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 17:31:28 -0400
Date: Tue, 1 Jul 2003 14:45:50 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB fixes for 2.5.73
Message-ID: <20030701214550.GA1184@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB fixes and cleanups for 2.5.73.  There are some
usb-storage changes, a few minor bugfixes, and the conversion of the
usb_bus structures to fit into the kernel driver model.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/core/hcd-pci.c         |   16 ++-
 drivers/usb/core/hcd.c             |   83 ++++++++++++--------
 drivers/usb/core/hcd.h             |    5 -
 drivers/usb/core/usb.c             |   12 ++
 drivers/usb/host/ehci-dbg.c        |   51 ++++++------
 drivers/usb/host/hc_sl811.c        |    2 
 drivers/usb/host/ohci-dbg.c        |   42 ++++++----
 drivers/usb/host/uhci-hcd.c        |    9 +-
 drivers/usb/net/usbnet.c           |   18 ++++
 drivers/usb/storage/scsiglue.c     |    8 +
 drivers/usb/storage/transport.c    |  131 ++++++++++++++++++--------------
 drivers/usb/storage/unusual_devs.h |  141 +++++++++++++++--------------------
 drivers/usb/storage/usb.c          |  149 +++++++++++++++++++++++--------------
 drivers/usb/storage/usb.h          |   32 +++++--
 drivers/usb/usb-skeleton.c         |   22 +++--
 include/linux/usb.h                |    4 
 16 files changed, 427 insertions(+), 298 deletions(-)
-----

<grigouze:noos.fr>:
  o USB: zaurus SL-C700

Alan Stern:
  o USB: Reconcile unusual_devs.h in 2.4 and 2.5

Greg Kroah-Hartman:
  o USB: move ohci's sysfs files to the class device instead of the pci device
  o USB: move ehci's sysfs files to the class device instead of the pci device
  o USB: make struct usb_bus a struct class_device
  o USB: turn down some debugging messages in uhci-hcd
  o Cset exclude: cweidema@indiana.edu|ChangeSet|20030621162021|08529

Kay Sievers:
  o USB: usb-skeleton.c usb_buffer_free() not called

Matthew Dharm:
  o USB storage: logic cleanup
  o USB storage: General purpose I/O buffer allocation and management
  o USB storage: Cosmetic cleanups
  o USB storage: create private I/O buffer
  o USB storage: avoid sending URBs when disconnecting
  o USB storage: create associate_dev(), more US_*_DEVICE printout
  o USB storage: unusual_devs.h cleanups

