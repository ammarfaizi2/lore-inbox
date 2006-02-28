Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWB1Vtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWB1Vtc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWB1Vtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:49:32 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:32450
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932553AbWB1Vtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:49:31 -0500
Date: Tue, 28 Feb 2006 13:49:35 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes for 2.6.16-rc5
Message-ID: <20060228214935.GA27833@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB fixes for 2.6.16-rc5.  They fix a EHCI handoff issue,
a few gadget issues, and add some more device ids for various drivers.
All of these patches have been in the -mm tree for a while, except for
one of the "add a new device id" ones.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 drivers/usb/gadget/lh7a40x_udc.c   |    6 ++++--
 drivers/usb/gadget/rndis.c         |   11 +++++++----
 drivers/usb/host/pci-quirks.c      |   11 ++++++-----
 drivers/usb/input/hid-core.c       |    2 ++
 drivers/usb/serial/ftdi_sio.c      |    6 ++++++
 drivers/usb/serial/ftdi_sio.h      |   10 +++++++++-
 drivers/usb/serial/visor.c         |    3 +++
 drivers/usb/serial/visor.h         |    3 +++
 drivers/usb/storage/unusual_devs.h |    7 +++++++
 9 files changed, 47 insertions(+), 12 deletions(-)

---------------

Alan Stern:
      USB: unusual_devs entry for Lyra RCA RD1080

Andrew Fuller:
      USB: Wisegroup MP-8866 Dual USB Joypad

David Brownell:
      USB: fix EHCI BIOS handshake

Franck Bui-Huu:
      USB: lh7a40x gadget driver: Fixed a dead lock

Hendrik Schweppe:
      USB: visor.c id for gspda smartphone

Ian Abbott:
      USB: ftdi_sio: new microHAM device IDs

Shaun Tancheff:
      USB: Gadget RNDIS fix alloc bug. (buffer overflow)

