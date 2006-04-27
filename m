Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWD0USE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWD0USE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWD0URq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:17:46 -0400
Received: from mail.suse.de ([195.135.220.2]:19639 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030220AbWD0URe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:17:34 -0400
Date: Thu, 27 Apr 2006 13:16:07 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes for 2.6.17-rc3
Message-ID: <20060427201607.GB2101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB fixes for 2.6.17-rc3.  They contain a few small bug
fixes and a bunch of new device ids for new devices.

All of these changes have been in the -mm tree for a number of weeks.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 arch/powerpc/platforms/powermac/pci.c |    2 +-
 drivers/usb/gadget/net2280.c          |   15 ++++++++-------
 drivers/usb/host/ehci-pci.c           |    2 +-
 drivers/usb/host/ohci-pci.c           |    2 +-
 drivers/usb/host/uhci-hcd.c           |    2 +-
 drivers/usb/serial/ftdi_sio.c         |    3 +++
 drivers/usb/serial/ftdi_sio.h         |   13 +++++++++++++
 drivers/usb/serial/pl2303.c           |    1 +
 drivers/usb/serial/pl2303.h           |    1 +
 drivers/usb/serial/whiteheat.c        |    1 +
 drivers/usb/storage/unusual_devs.h    |    9 ++++++++-
 11 files changed, 39 insertions(+), 12 deletions(-)

---------------

Alan Stern:
      USB: net2280: Handle STALLs for 0-length control-IN requests
      USB: net2280: send 0-length packets for ep0
      USB: net2280: check for shared IRQs
      USB: net2280: set driver data before it is used

Ian Abbott:
      USB: ftdi_sio: add support for ASK RDR 400 series card reader

Jean Delvare:
      USB: Use new PCI_CLASS_SERIAL_USB_* defines

Jesper Juhl:
      USB: Resource leak fix for whiteheat driver

Luiz Fernando N. Capitulino:
      USB: ftdi_sio: Adds support for iPlus device.

Nathan Bronson:
      USB: ftdi_sio vendor code for RR-CirKits LocoBuffer USB

Olivier Blondeau:
      USB: storage: atmel unusual dev update

Phil Dibowitz:
      USB: Storage: unusual devs update

Wang Jun:
      USB: add new iTegno usb CDMA 1x card support for pl2303

