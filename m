Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268029AbUJLWfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268029AbUJLWfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUJLWfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:35:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:32665 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268029AbUJLWfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:35:18 -0400
Date: Tue, 12 Oct 2004 15:34:31 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.9-rc4
Message-ID: <20041012223431.GA9830@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 5 USB fixes against the latest 2.6.9-rc4 tree.  They do the
following:
	- fix a oops in the digi_acceleport driver
	- fix a SMP race in the ehci_hcd driver
	- fix a lockup in the net2280 driver
	- fix a oops in the usblp driver
	- fix a oops in the hiddev driver
These patches have all been in the -mm tree for the past few weeks

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/fix-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/class/usblp.c            |    8 ++++----
 drivers/usb/gadget/net2280.c         |   19 ++++++++++---------
 drivers/usb/host/ehci-hcd.c          |    9 +++++++++
 drivers/usb/host/ehci.h              |    1 +
 drivers/usb/input/hid-core.c         |    2 +-
 drivers/usb/media/konicawc.c         |    2 +-
 drivers/usb/serial/digi_acceleport.c |    7 ++++++-
 7 files changed, 32 insertions(+), 16 deletions(-)
-----

Al Borchers:
  o USB: corrected digi_acceleport 2.6.9-rc1 fix for hang on disconnect

David Brownell:
  o USB: net2280 updates
  o USB: EHCI SMP fix

Herbert Xu:
  o USB: Fix hiddev devfs oops

Vojtech Pavlik:
  o USB: Fix oops in usblp driver

