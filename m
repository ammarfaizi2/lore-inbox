Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWIRUr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWIRUr6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWIRUr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:47:58 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:64140 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964963AbWIRUr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:47:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.18-rc6-mm2 (-mm1): ohci_hcd does not recognize new devices
Date: Mon, 18 Sep 2006 22:51:08 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>,
       LKML <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <Pine.LNX.4.44L0.0609181102450.7192-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609181102450.7192-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609182251.09318.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 18 September 2006 17:07, Alan Stern wrote:
> On Mon, 18 Sep 2006, Rafael J. Wysocki wrote:
> 
> > > Actually, the problem is ohci_hcd doesn't seem to recognize devices plugged
> > > into the USB ports.
> > > 
> > > For example, if I unplug and replug a mouse (that worked before unplugging),
> > > it doesn't work any more.  I have to reload ohci_hcd to make it work again.
> > > 
> > > This is 100% reproducible and occurs on the two boxes above.
> > 
> > I have carried out a binary search and found that the problem is caused by
> > 
> > gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch
> 
> Tell me, what happens if you leave that patch installed, and you use 
> the patch I sent last week (the one that removes a chunk of code from 
> ohci-hub.c), and you also set CONFIG_USB_SUSPEND?

The problem continues to happen.

Moreover, if I revert the above patch and apply the patch removing code
from ohci-hub.c, the problem reappears.

> I think the real underlying problem here is that David's implementation of 
> root-hub suspend in ohci-hcd is incompatible with the overall scheme I've 
> been working on.  In the end I'll probably have to rewrite the ohci-hcd 
> code.

Well, at this point I can only help you by testing some code. ;-)

Seriously, if you have any new patches to test, please let me know.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
