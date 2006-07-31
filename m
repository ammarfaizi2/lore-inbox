Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWGaGAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWGaGAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 02:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWGaGAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 02:00:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31657 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932112AbWGaGAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 02:00:44 -0400
Date: Sun, 30 Jul 2006 23:00:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       laurent.riffard@free.fr, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Message-Id: <20060730230033.cc4fc190.akpm@osdl.org>
In-Reply-To: <20060731051547.GB29058@kroah.com>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<44CCBBC7.3070801@free.fr>
	<20060731000359.GB23220@kroah.com>
	<200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20060731033757.GA13737@kroah.com>
	<20060730212227.175c844c.akpm@osdl.org>
	<20060731043542.GA9919@kroah.com>
	<20060730215025.44292f9c.akpm@osdl.org>
	<20060731051547.GB29058@kroah.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 22:15:47 -0700
Greg KH <greg@kroah.com> wrote:

> On Sun, Jul 30, 2006 at 09:50:25PM -0700, Andrew Morton wrote:
> > On Sun, 30 Jul 2006 21:35:42 -0700
> > Greg KH <greg@kroah.com> wrote:
> > 
> > > Remember, FC3 is now in Legacy support mode, not something the mainline
> > > kernel should have to worry about.
> > 
> > It's not specifically related to FC3.  It's udev - we've broken _any_
> > distribution which uses a two-year-old udev.  In fact we're proposing
> > breaking any distro which has an older-than-ten-month udev.  That's really
> > bad.
> 
> Why?  What do you propose we do then?  Wait a year?  Two years?

Greg, once we put an interface into the kernel and expose it to userspace,
that's it - we support it forever.  At least, that's the model.  Yes,
sometimes in cases of necessity where we cannot feasibly support old
userspace we'll break things, with long notice and considerable thought
and care.

The impact is lower in this case because we've already trained our
long-suffering users to expect udev to regularly break.

> And that's the only group of people who would try to do this.
> Seriously, I don't see the complaint here.  It's an unsupported distro
> by the very makers of that distro.  How long should the community have
> to care about a distro after the creators of it have abandonded it?

Please stop going on about FC3.  My (repeat) point is that we're proposing
to break _all_ distros which are older than ten months.  We don't play the
"oh, that isn't supported any more" game.

> > Are we going to stop doing this soon?
> 
> Not if we want to keep on making things better.  The real reason I made
> these changes is to get power management working better.  We need to get
> the devices into the proper place in the sysfs tree in order to handle
> suspend/resume for classes of devices properly.  That's what Linus's
> patch did, and now I'm moving the devices to allow it to really happen.
> 

This sucks.  Do you know what machines we'll be breaking out there?  I
sure don't.

