Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTKHAYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTKGWGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:06:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:22696 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264595AbTKGT1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 14:27:06 -0500
Date: Fri, 7 Nov 2003 11:26:20 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More fixes for 2.6.0-test9
Message-ID: <20031107192620.GA4276@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more minor fixes for 2.6.0-test9.  These fixes do the
following:
	- fix oops with cardbus firewire controllers
	- fix oops with usbnet devices on non-i386 platforms
	- fix oops when removing the usb-storage module when using
	  preempt.

Please pull from:  bk://linuxusb.bkbits.net/gregkh-2.6

Patches will be posted as a follow-up thread for those who want to see
them.

thanks,

greg k-h

 drivers/pci/quirks.c        |    2 +-
 drivers/usb/host/ehci-hcd.c |    3 +++
 drivers/usb/net/kaweth.c    |    3 +++
 drivers/usb/net/usbnet.c    |    3 +++
 drivers/usb/storage/usb.c   |   19 +++++++++++++++----
 5 files changed, 25 insertions(+), 5 deletions(-)
-----

<michael:metaparadigm.com>:
  o PCI: Fix oops in quirk_via_bridge

David Brownell:
  o USB: usb ignores 64bit dma

Matthew Dharm:
  o USB: fix a thread-exit problem at module unload

