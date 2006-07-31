Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWGaFSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWGaFSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 01:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWGaFSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 01:18:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:26025 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751333AbWGaFSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 01:18:14 -0400
Date: Sun, 30 Jul 2006 22:15:47 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       laurent.riffard@free.fr, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Message-ID: <20060731051547.GB29058@kroah.com>
References: <20060727015639.9c89db57.akpm@osdl.org> <44CCBBC7.3070801@free.fr> <20060731000359.GB23220@kroah.com> <200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060731033757.GA13737@kroah.com> <20060730212227.175c844c.akpm@osdl.org> <20060731043542.GA9919@kroah.com> <20060730215025.44292f9c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730215025.44292f9c.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 09:50:25PM -0700, Andrew Morton wrote:
> On Sun, 30 Jul 2006 21:35:42 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > Remember, FC3 is now in Legacy support mode, not something the mainline
> > kernel should have to worry about.
> 
> It's not specifically related to FC3.  It's udev - we've broken _any_
> distribution which uses a two-year-old udev.  In fact we're proposing
> breaking any distro which has an older-than-ten-month udev.  That's really
> bad.

Why?  What do you propose we do then?  Wait a year?  Two years?  I've
already stated that I'm going to wait 3 more months in order to be able
to fix up the currently supported distros to handle the changes needed.
I'll even dig up RC4 to get that working, as it shouldn't be that hard
to do so.  What more can I do?

> It's worse on FC3 because there is, as far as I can tell, no rpm or srpm
> which can be used to unbreak it.  And pointing at Documentation/Changes
> doesn't alter that, does it?

No, but it does show that you are running on an unsupported distro.  Why
should the kernel developers have to support this?  When is the cut-off
date?

> Personally, there's no way I'm upgrading this box because I _want_ to run
> old distros to catch things like this.  So I'll hack it around to work
> somehow.  I can do that, because I'm a developer. 

And that's the only group of people who would try to do this.
Seriously, I don't see the complaint here.  It's an unsupported distro
by the very makers of that distro.  How long should the community have
to care about a distro after the creators of it have abandonded it?

> Are we going to stop doing this soon?

Not if we want to keep on making things better.  The real reason I made
these changes is to get power management working better.  We need to get
the devices into the proper place in the sysfs tree in order to handle
suspend/resume for classes of devices properly.  That's what Linus's
patch did, and now I'm moving the devices to allow it to really happen.

thanks,

greg k-h
