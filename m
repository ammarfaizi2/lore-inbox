Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVGBE4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVGBE4a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 00:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVGBE4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 00:56:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:65475 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261794AbVGBE40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 00:56:26 -0400
Date: Fri, 1 Jul 2005 21:51:46 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] bind and unbind drivers from userspace through sysfs
Message-ID: <20050702045146.GA5303@kroah.com>
References: <20050624051229.GA24621@kroah.com> <d120d500050630132025610e6a@mail.gmail.com> <20050701223114.GC2707@kroah.com> <200507012325.30628.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507012325.30628.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 11:25:30PM -0500, Dmitry Torokhov wrote:
> On Friday 01 July 2005 17:31, Greg KH wrote:
> > Putting it 
> > in every device directory would make the 20K scsi device people very
> > unhappy as I take up even more of their 31bit memory :)
> > 
> 
> I see. That would be an argument for folding all such operationsinto one
> attribute with bus-specific multiplexor. But really, 20K scsi people are
> probably better off without sysfs (they should still have hotplug events
> as far as I can see so hotplug/usev should still work).

The 20k scsi people need sysfs.  They did the backing store patches for
it, to make it work sane on their boxes.  They need persistant device
naming more than almost anyone else.  udev previously would not work
without sysfs.  For 2.6.12, it now almost can (haven't tried for sure,
but I think we are now there.)

> Just to reiterate - by beef is that if you put [un]bind into separate
> directory similar operations will be split across 2 subdirectories. 

But I didn't.  They are now both in the same directory.  Look at Linus's
tree :)

thanks,

greg k-h
