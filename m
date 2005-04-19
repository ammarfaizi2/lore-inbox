Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVDSBKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVDSBKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 21:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVDSBKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 21:10:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:32741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261244AbVDSBJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 21:09:54 -0400
Date: Mon, 18 Apr 2005 18:09:28 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Git Mailing List <git@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [GIT PATCH] USB updates for 2.6.12-rc2
Message-ID: <20050419010928.GA21709@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, I think I got this set up properly, but don't have an automated
script to generate the changelog and diffstat messages yet, so bear with
me...

Could you merge with:
	kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

It should be against your latest git tree.  It contains a number of USB
patches (that I'm holding on to still, in case something happens to
this...) that are bug fix only.  The diffstat is below.  I'll figure out
how to send the patches out to the mailing list later on, if these
"stick".

And damm if git isn't fast on applying these patches, very nice job, I
like it.

thanks,

greg k-h

 drivers/net/irda/stir4200.c           |    4 
 drivers/usb/class/audio.c             |   48 +++-------
 drivers/usb/class/bluetty.c           |    4 
 drivers/usb/core/config.c             |    3 
 drivers/usb/core/devices.c            |    8 -
 drivers/usb/core/devio.c              |   72 ++++++----------
 drivers/usb/core/file.c               |    2 
 drivers/usb/core/hcd-pci.c            |  151 ++++++++++++++++++++--------------
 drivers/usb/core/hcd.h                |    4 
 drivers/usb/core/hub.c                |   24 ++---
 drivers/usb/core/inode.c              |    1 
 drivers/usb/core/message.c            |   25 -----
 drivers/usb/core/urb.c                |   16 ++-
 drivers/usb/core/usb.c                |   13 --
 drivers/usb/core/usb.h                |    8 +
 drivers/usb/gadget/ether.c            |   56 +++++-------
 drivers/usb/gadget/omap_udc.c         |   12 +-
 drivers/usb/gadget/rndis.c            |   40 ++++-----
 drivers/usb/gadget/rndis.h            |    4 
 drivers/usb/gadget/serial.c           |    5 -
 drivers/usb/host/ehci-dbg.c           |    2 
 drivers/usb/host/ehci-hcd.c           |    4 
 drivers/usb/host/ehci-mem.c           |    3 
 drivers/usb/host/ehci-sched.c         |    4 
 drivers/usb/host/ehci.h               |    2 
 drivers/usb/host/ohci-omap.c          |    4 
 drivers/usb/host/ohci-pci.c           |   21 +++-
 drivers/usb/host/ohci-pxa27x.c        |    5 -
 drivers/usb/host/ohci-q.c             |   13 ++
 drivers/usb/host/ohci.h               |    2 
 drivers/usb/host/uhci-hcd.c           |    9 --
 drivers/usb/input/aiptek.c            |    1 
 drivers/usb/input/hid-core.c          |    9 --
 drivers/usb/media/dabusb.c            |    3 
 drivers/usb/media/ov511.c             |   12 --
 drivers/usb/media/se401.c             |   15 +--
 drivers/usb/media/usbvideo.c          |    6 -
 drivers/usb/media/w9968cf.c           |    6 -
 drivers/usb/misc/auerswald.c          |   26 ++---
 drivers/usb/misc/sisusbvga/sisusb.c   |    3 
 drivers/usb/net/pegasus.c             |   22 ++++
 drivers/usb/net/usbnet.c              |   32 +++++--
 drivers/usb/net/zd1201.c              |    3 
 drivers/usb/serial/belkin_sa.c        |    3 
 drivers/usb/serial/cypress_m8.c       |    5 -
 drivers/usb/serial/digi_acceleport.c  |   10 +-
 drivers/usb/serial/empeg.c            |    6 -
 drivers/usb/serial/ftdi_sio.c         |   10 --
 drivers/usb/serial/io_edgeport.c      |   24 +----
 drivers/usb/serial/io_ti.c            |    5 -
 drivers/usb/serial/kl5kusb105.c       |    3 
 drivers/usb/serial/omninet.c          |    5 -
 drivers/usb/serial/pl2303.c           |   56 ++++++++----
 drivers/usb/serial/pl2303.h           |    4 
 drivers/usb/serial/ti_usb_3410_5052.c |    3 
 drivers/usb/serial/visor.c            |    6 +
 drivers/usb/serial/visor.h            |    4 
 drivers/usb/storage/sddr55.c          |   24 +----
 drivers/usb/storage/transport.c       |    2 
 drivers/usb/storage/unusual_devs.h    |   13 ++
 include/linux/usb.h                   |    4 
 include/linux/usb_cdc.h               |    2 
 62 files changed, 467 insertions(+), 429 deletions(-)
