Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWIRVQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWIRVQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 17:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWIRVQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 17:16:33 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:4882 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751168AbWIRVQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 17:16:32 -0400
Date: Mon, 18 Sep 2006 17:16:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>,
       LKML <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.18-rc6-mm2 (-mm1): ohci_hcd does not recognize new devices
In-Reply-To: <200609182251.09318.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0609181715200.7192-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2006, Rafael J. Wysocki wrote:

> > > I have carried out a binary search and found that the problem is caused by
> > > 
> > > gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch
> > 
> > Tell me, what happens if you leave that patch installed, and you use 
> > the patch I sent last week (the one that removes a chunk of code from 
> > ohci-hub.c), and you also set CONFIG_USB_SUSPEND?
> 
> The problem continues to happen.
> 
> Moreover, if I revert the above patch and apply the patch removing code
> from ohci-hub.c, the problem reappears.

Very strange.

> > I think the real underlying problem here is that David's implementation of 
> > root-hub suspend in ohci-hcd is incompatible with the overall scheme I've 
> > been working on.  In the end I'll probably have to rewrite the ohci-hcd 
> > code.
> 
> Well, at this point I can only help you by testing some code. ;-)
> 
> Seriously, if you have any new patches to test, please let me know.

I definitely will.  However they won't be ready for a few days...

Alan Stern

