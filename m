Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269014AbUINFcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269014AbUINFcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 01:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269142AbUINFcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 01:32:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:9965 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269014AbUINFcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 01:32:05 -0400
Date: Mon, 13 Sep 2004 22:31:40 -0700
From: Greg KH <greg@kroah.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5, ehci stuff gone
Message-ID: <20040914053140.GA18591@kroah.com>
References: <200409132307.19242.gene.heskett@verizon.net> <20040914035606.GA14863@kroah.com> <200409140105.32221.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409140105.32221.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 01:05:32AM -0400, Gene Heskett wrote:
> On Monday 13 September 2004 23:56, Greg KH wrote:
> >On Mon, Sep 13, 2004 at 11:07:19PM -0400, Gene Heskett wrote:
> >> Greetings;
> >>
> >> I've rebooted to 2.6.9-rc1-mm5, and found that my 2 printers,
> >> usb-2.0 capable are not found.  Reverting to -mm4 brings them back
> >> among the living.
> >>
> >> Here is an 'lsusb -v' while booted to -mm5:
> >
> >cat /proc/bus/usb/devices is much easier to read in the future :)
> >
> Ooops, sorry.  Getting late.
> 
> >Anyway, try the following patch from David Brownell, it fixed the
> > ohci issues that I had in my laptop, and will show up in the next
> > -mm patch.
> 
> ohci?  I thought usb2 was ehci...

It is, but all usb 2 controllers have a usb 1 controller in them that
they use for low/high speed devices and negoiating up to usb 2 speeds.
Yours is a ohci controller as per your lspci output.

And please trim your emails, I don't think everyone wanted to see 2
copies of that patch :)

thanks,

greg k-h
