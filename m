Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbTEWVXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 17:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTEWVXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 17:23:01 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:11466 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264196AbTEWVW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 17:22:59 -0400
Date: Fri, 23 May 2003 14:37:55 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] Again, more USB changes for 2.5.69
Message-ID: <20030523213754.GA13749@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB fixes for the latest 2.5.69.  They include some
merge fixups that I caused in the last set of patches sent to you, and a
interrupt latency fix some people have been reporting, and a fix for
some devices that also has been reported on lkml.


Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5


Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/core/message.c      |    4 
 drivers/usb/host/uhci-hcd.c     |  164 ++++--
 drivers/usb/host/uhci-hcd.h     |   29 +
 drivers/usb/misc/speedtch.c     | 1088 +++++++++++++++++-----------------------
 drivers/usb/storage/transport.c |    2 
 drivers/usb/storage/transport.h |    2 
 6 files changed, 650 insertions(+), 639 deletions(-)
-----

Alan Stern:
  o USB: Addition to previous patch needed for PM UHCI
  o USB: uhci Interrupt Latency fix

David Brownell:
  o USB: bugfix endpoint state

Duncan Sands:
  o USB speedtouch: set owner fields
  o USB speedtouch: receive code rewrite
  o USB speedtouch: receive path micro optimization
  o USB speedtouch: remove useless NULL pointer checks
  o USB speedtouch: kfree_skb -> dev_kfree_skb
  o USB speedtouch: send path micro optimizations
  o USB speedtouch: use optimally sized reconstruction buffers
  o USB speedtouch: remove stale code
  o USB speedtouch: verbose debugging
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in tasklets
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in process context
  o USB speedtouch: add defensive memory barriers
  o USB speedtouch: replace yield()
  o USB speedtouch: trivial whitespace and name changes

Greg Kroah-Hartman:
  o USB: speedtch merge fixups by hand

Vojtech Pavlik:
  o USB: Make Olympus cameras work with usb-storage

