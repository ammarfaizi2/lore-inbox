Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTFKAEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTFKAEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:04:33 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:41164 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262379AbTFKAEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:04:08 -0400
Date: Tue, 10 Jun 2003 17:19:22 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] And yet more USB changes for 2.5.70
Message-ID: <20030611001922.GB21057@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB changes and fixes for 2.5.70.  These include some
usb-storage cleanups, hub driver cleanups, ethtool fixes, and some
sparse cleanups to the usb core code.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/core/devices.c      |    4 
 drivers/usb/core/devio.c        |  106 +++---
 drivers/usb/core/hub.c          |  239 ++++++++------
 drivers/usb/core/hub.h          |    7 
 drivers/usb/core/inode.c        |    4 
 drivers/usb/gadget/net2280.c    |   30 +
 drivers/usb/host/ohci-q.c       |    8 
 drivers/usb/image/hpusbscsi.c   |    2 
 drivers/usb/media/vicam.c       |   57 +++
 drivers/usb/net/catc.c          |   19 -
 drivers/usb/net/kaweth.c        |   18 -
 drivers/usb/net/pegasus.c       |  174 ++++++----
 drivers/usb/net/pegasus.h       |    6 
 drivers/usb/net/rtl8150.c       |   45 +-
 drivers/usb/storage/transport.c |   34 +-
 drivers/usb/storage/transport.h |    6 
 drivers/usb/storage/usb.c       |  669 ++++++++++++++++++----------------------
 drivers/usb/storage/usb.h       |    7 
 include/linux/usb.h             |    2 
 include/linux/usbdevice_fs.h    |    8 
 20 files changed, 787 insertions(+), 658 deletions(-)
-----

Alan Stern:
  o USB: Make hub.c DMA-aware
  o USB: Rename static functions in hub.c and increase timeouts
  o USB: Don't allocate transfer buffers on the stack in hub.c

David Brownell:
  o USB: ohci-hcd, remove FIXME
  o USB: net2280 patch: control-out fix, minor cleanups
  o USB: usb/core/devio: identify process

Greg Kroah-Hartman:
  o USB: lots of sparse fixups for usbfs
  o USB: sparse fixups for drivers/usb/core/inode.c
  o USB: sparse fixups for drivers/usb/core/devices.c
  o USB: fix problem found by sparse in usb.h

Joe Burks:
  o USB: vicam.c patch

Matthew Dharm:
  o USB: usb-storage: remove dead code
  o USB: usb-storage: re-organize probe/disconnect
  o USB: usb-storage: handle babble

Olaf Hering:
  o USB: incorrect ethtool -i driver name

Oliver Neukum:
  o USB: kill a compiler warning in hpusbscsi

Petko Manolov:
  o USB: pegasus patch

