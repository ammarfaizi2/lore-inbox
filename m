Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264691AbUDVVuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264691AbUDVVuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUDVVuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:50:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:6555 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264691AbUDVVuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:50:12 -0400
Date: Thu, 22 Apr 2004 14:49:48 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.6-rc2
Message-ID: <20040422214948.GA2142@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some important USB fixes for 2.6.6-rc2.  They are all pretty
small and "obvious" (hopefully.)  The most important one is the uhci
fix, as lots of people are hitting that recently.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/class/cdc-acm.c   |   91 ++++++++++++++++------------
 drivers/usb/core/hcd-pci.c    |    5 +
 drivers/usb/gadget/ether.c    |   49 ++++++++-------
 drivers/usb/gadget/rndis.c    |  135 +++++++++++++++++++++++++++---------------
 drivers/usb/gadget/rndis.h    |    7 +-
 drivers/usb/host/ehci-hcd.c   |   17 ++++-
 drivers/usb/host/ehci-hub.c   |   16 +++-
 drivers/usb/host/uhci-hcd.c   |   36 ++++++-----
 drivers/usb/misc/tiglusb.c    |   52 ++++++++--------
 drivers/usb/net/usbnet.c      |    6 +
 drivers/usb/serial/ftdi_sio.c |    4 -
 drivers/usb/storage/dpcm.c    |    9 +-
 12 files changed, 262 insertions(+), 165 deletions(-)
-----

<colin:colino.net>:
  o USB: fix cdc-acm as it is still (differently) broken

<jan:ccsinfo.com>:
  o USB: ftdi patch fixup

Alan Stern:
  o USB: Important bugfix for UHCI list management code

David Brownell:
  o USB: usbnet and pl2301/2302 reset
  o USB: rndis gadget driver updates
  o USB: ehci handles pci misbehavior better

Greg Kroah-Hartman:
  o USB: fix cdc-acm warnings due to previous patch
  o USB: Don't try to suspend devices that do not support it

Romain Lievin:
  o USB: tiglusb: wrong timeout value

William Lee Irwin III:
  o USB: silence dpcm warning

