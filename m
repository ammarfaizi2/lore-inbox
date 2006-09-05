Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWIEQ7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWIEQ7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWIEQ7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:59:49 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:11274 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932150AbWIEQ7s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:59:48 -0400
Date: Tue, 5 Sep 2006 12:59:39 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [RFC] USB device persistence across suspend-to-disk
In-Reply-To: <20060905091318.42c273d2.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.44L0.0609051252240.5763-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2006, Randy.Dunlap wrote:

> > +Setting the "persist=y" module parameter for usbcore will cause the
> 
>                 persist=1 ??

Either will work.

> > +kernel to work around these issues.  If usbcore is build into the
> 
> s/build/built/

Got it, thanks.

> > +main kernel instead of as a separate module, you can put
> > +"usbcore.persist=1" on the boot command line.  You can also change the
> > +kernel's behavior on the fly using sysfs: Type
> > +
> > +	echo y >/sys/module/usbcore/parameters/persist
> 
> Does sysfs treat 'y' as '1'?
> Anyway, it would be Good to be consistent.

Yes; I'll change everything to 'y'.

> > +structure.  In effect, the kernel treats the device as though it had
> > +merely been reset instead of unplugged.
> 
> so does the USB device also retain its same USB address?

It does.  It didn't seem worthwhile to mention that point, however.

> > -			dev->have_langid = -1;
> > +			dev->have_langid = 1;

> Different patch (?).

When this is submitted for inclusion, that change will be broken out into 
a separate patch.

Alan Stern

