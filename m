Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWGFUPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWGFUPA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWGFUPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:15:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:16270 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750801AbWGFUO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:14:59 -0400
Date: Thu, 6 Jul 2006 13:11:08 -0700
From: Greg KH <greg@kroah.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-ID: <20060706201108.GA493@kroah.com>
References: <20060703030355.420c7155.akpm@osdl.org> <200607052332.13028.s0348365@sms.ed.ac.uk> <1152207073.24656.127.camel@cog.beaverton.ibm.com> <200607062102.50284.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607062102.50284.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 09:02:50PM +0100, Alistair John Strachan wrote:
> On Thursday 06 July 2006 18:31, john stultz wrote:
> > On Wed, 2006-07-05 at 23:32 +0100, Alistair John Strachan wrote:
> > > On Wednesday 05 July 2006 21:46, Greg KH wrote:
> > > > On Wed, Jul 05, 2006 at 01:37:13PM -0700, john stultz wrote:
> > > > > On Tue, 2006-07-04 at 01:49 -0700, Andrew Morton wrote:
> > > > > > On Tue, 4 Jul 2006 09:34:14 +0100
> > > > > >
> > > > > > Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > > > > > > a tested version...
> > > > > > >
> > > > > > > This one worked, thanks. Try the same URL again, I've uploaded
> > > > > > > two better shots 6,7 that capture the first oops. Unfortunately,
> > > > > > > I have a pair of oopses that interchange every couple of boots,
> > > > > > > so I've included both ;-)
> > > > > >
> > > > > > OK, that's more like it.  Thanks again.
> > > > > >
> > > > > > http://devzero.co.uk/~alistair/oops-20060703/oops6.jpg
> > > > > > http://devzero.co.uk/~alistair/oops-20060703/oops7.jpg
> > > > > >
> > > > > > People cc'ed.  Help!
> > > > >
> > > > > Hmmm. No clue on this one from just looking at it.
> > > > >
> > > > > Greg, do you see anything wrong with the way I'm registering the
> > > > > timekeeping .resume hook in
> > > > > kernel/timer.c::timekeeping_init_device()? It looks the same as the
> > > > > other users to me.
> > > >
> > > > At first glance, no, it looks sane to me.
> > > >
> > > > Are you sure you aren't registering two things with the same name
> > > > somehow?
> >
> > Looking at it, I don't see how that could happen.
> 
> I don't think it's John's code. I commented out the sysfs registration code 
> from timekeeping_init_device() and the kernel gets further, where it crashes 
> on kmem_cache_create. SLAB also complains about "losing its name" and 
> being "of size 0".
> 
> This happens identically on 2.6.18-rc1, and 2.6.17-mm6. Greg, could it be 
> anything you've changed recently? I considered bisectioning -mm, but there's 
> been a lot of RAID problems and I'm using RAID5.

Please bisect 2.6.18-rc1 if you have git, as the problem is there, and
would be good to track down.

thanks,

greg k-h
