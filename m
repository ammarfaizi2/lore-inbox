Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWCXShg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWCXShg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWCXShg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:37:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25112 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932449AbWCXShf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:37:35 -0500
Date: Fri, 24 Mar 2006 19:37:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Brandon Low <lostlogic@lostlogicx.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1
Message-ID: <20060324183734.GC4173@suse.de>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <20060324021729.GL27559@lostlogicx.com> <20060323182411.7f80b4a6.akpm@osdl.org> <20060324024540.GM27559@lostlogicx.com> <20060323185810.3bf2a4ce.akpm@osdl.org> <20060324032126.GN27559@lostlogicx.com> <20060324033934.161302c1.akpm@osdl.org> <20060324125817.GB3381@lostlogicx.com> <20060324103301.4e6c5a4b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324103301.4e6c5a4b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24 2006, Andrew Morton wrote:
> Brandon Low <lostlogic@lostlogicx.com> wrote:
> >
> > On Fri, 03/24/06 at 03:39:34 -0800, Andrew Morton wrote:
> > > Brandon Low <lostlogic@lostlogicx.com> wrote:
> > > >
> > > >  I hadn't noticed immediately in the ooops, but it is something to do
> > > >  with the Hardware Abstraction Layer Daemon from http://freedesktop.org/Software/hal
> > > >  I can't reproduce it without that daemon loaded either.  I wonder if the
> > > >  last accessed sysfs file mentioned in the oops (sda/size) is relevent
> > > >  also.
> > > > 
> > > >  My exact steps (with hald loaded) are:
> > > >  plug in ipod
> > > >  mount /mnt/ipod
> > > >  unzip -d /mnt/ipod rockbox.zip
> > > >  eject /dev/sda
> > > >  unplug ipod
> > > >  immediately here, the oops prints.
> > > 
> > > Still no joy, alas.
> > > 
> > > git-cfq.patch plays with the elevator exit code for all IO schedulers. 
> > > Would you be able to do
> > > 
> > > wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/broken-out/git-cfq.patch
> > > patch -p1 -R < git-cfq.patch
> > > 
> > > and retest?
> > > 
> > > Thanks.
> > 
> > It is definitely this patch.  Identical steps (also used an untainted
> > kernel for both tests) on -mm1 with and without that patch, and when the
> > patch is reversed, I cannot cause the oops.  I booted into single user
> > mode (to dodge tainting and any other weirdness), started the dbus
> > system message daemon and hald (which depends on dbus), then performed
> > the steps mentioned above.
> > 
> 
> Great.  Thanks for working that out.  It's time to add the dreaded Cc.

Can I see that oops?

-- 
Jens Axboe

