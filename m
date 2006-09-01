Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWIABI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWIABI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWIABI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:08:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:52929 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932123AbWIABI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:08:28 -0400
Date: Thu, 31 Aug 2006 18:08:19 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes for 2.6.18-rc5
Message-ID: <20060901010819.GA29859@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a some fixes for USB against 2.6.18-rc5.  They do the
following:
	- 2 uhci bugfixes
	- quirks fixed and added for storage and HID devices
	- bugfix in rtl8150 driver
	- via EHCI quirk bugfix
	- gadget driver spinlock fix.

Most of these changes have been in the -mm tree for a while.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 drivers/pci/quirks.c               |    1 
 drivers/usb/gadget/ether.c         |   45 +++++++----
 drivers/usb/host/uhci-q.c          |    4 -
 drivers/usb/input/hid-core.c       |  149 +++++++++++++++++++++++-------------
 drivers/usb/net/pegasus.h          |    3 +
 drivers/usb/net/rtl8150.c          |    1 
 drivers/usb/storage/unusual_devs.h |   24 +++---
 include/linux/pci_ids.h            |    1 
 8 files changed, 149 insertions(+), 79 deletions(-)

---------------

Alan Stern:
      UHCI: don't stop at an Iso error
      uhci-hcd: fix list access bug

Andrew Morton:
      USB: rtl8150_disconnect() needs tasklet_kill()

David Brownell:
      usb gadget: g_ether spinlock recursion fix

Jeremy Roberson:
      hid-core.c: Adds all GTCO CalComp Digitizers and InterWrite School Products to blacklist

juergen.mell@t-online.de:
      USB floppy drive SAMSUNG SFD-321U/EP detected 8 times

Mark Hindley:
      USB: Add VIA quirk fixup for VT8235 usb2

Nobuhiro Iwamatsu:
      USB: Support for ELECOM LD-USB20 in pegasus

Phil Dibowitz:
      USB Storage: Remove the finecam3 unusual_devs entry
      USB Storage: unusual_devs.h for Sony Ericsson M600i

Ping Cheng:
      USB: add all wacom device to hid-core.c blacklist

