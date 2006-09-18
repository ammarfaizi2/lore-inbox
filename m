Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965466AbWIRGY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965466AbWIRGY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 02:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965467AbWIRGY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 02:24:26 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:59525 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965466AbWIRGYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 02:24:25 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc6-mm2 (-mm1): ohci_hcd does not recognize new devices
Date: Mon, 18 Sep 2006 08:27:50 +0200
User-Agent: KMail/1.9.1
Cc: David Brownell <david-b@pacbell.net>, LKML <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>
References: <200609160013.16014.rjw@sisk.pl> <200609161013.45800.rjw@sisk.pl>
In-Reply-To: <200609161013.45800.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609180827.53626.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 16 September 2006 10:13, Rafael J. Wysocki wrote:
> On Saturday, 16 September 2006 00:13, Rafael J. Wysocki wrote:
>
> > It looks like the ohci_hcd driver sometimes has problems with the
> > initialization (eg. USB mouse doesn't work after a fresh boot and reloading
> > of the driver helps).
> > 
> > I have observed this on two different x86_64 boxes (HPC 6325, Asus L5D),
> > but it is not readily reproducible.  Anyway I've got a dmesg output from a
> > failing case which is attached.
> 
> Actually, the problem is ohci_hcd doesn't seem to recognize devices plugged
> into the USB ports.
> 
> For example, if I unplug and replug a mouse (that worked before unplugging),
> it doesn't work any more.  I have to reload ohci_hcd to make it work again.
> 
> This is 100% reproducible and occurs on the two boxes above.

I have carried out a binary search and found that the problem is caused by

gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
