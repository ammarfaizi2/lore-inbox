Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVDYOnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVDYOnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 10:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVDYOnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 10:43:20 -0400
Received: from dialin-157-107.tor.primus.ca ([216.254.157.107]:39627 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262619AbVDYOnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 10:43:08 -0400
Date: Mon, 25 Apr 2005 10:42:13 -0400
From: William Park <opengeometry@yahoo.ca>
To: "David N. Welton" <davidw@dedasys.com>
Cc: Daniel Drake <dsd@gentoo.org>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, helge.hafting@hist.no
Subject: Re: rootdelay
Message-ID: <20050425144213.GA2293@node1.opengeometry.net>
Mail-Followup-To: "David N. Welton" <davidw@dedasys.com>,
	Daniel Drake <dsd@gentoo.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
	helge.hafting@hist.no
References: <87wtrphuvj.fsf@dedasys.com> <424D929A.2030801@gentoo.org> <87pswjur3c.fsf@dedasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pswjur3c.fsf@dedasys.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 11:45:59AM +0200, David N. Welton wrote:
> Daniel Drake <dsd@gentoo.org> writes:
> 
> [ Please CC replies to me - thanks! ]
> 
> > Hi David,
> 
> > David N. Welton wrote:
> 
> > > [ Please CC replies to me, thanks! ]
> 
> > > Hi, I was looking at your patch:
> 
> > > http://lkml.org/lkml/2005/1/21/132 Very small, which is nice.  I
> 
> > > was wondering if there were any interest in my own efforts in that
> > > direction:
> 
> > > http://dedasys.com/freesoftware/patches/blkdev_wakeup.patch which
> 
> > > is far more intrusive, and perhaps isn't good kernel programming
> > > style, but, on the other hand, is the optimal solution in terms of
> > > boot time because it wakes up the boot process right when the
> > > device comes on line.  Since I saw your patch included, it looks
> > > like there is interest in this, and I'd toot my own horn once more
> > > before just leaving my patch to the bit rot of the ages...
> > > Thanks!
> 
> > As simple as it may be, it's a bit of a shame that we actually need
> > rootdelay as its something that the kernel should do
> > automatically. At the time when we last discussed it, we didn't come
> > up with a better (and safe) way to handle it, but I don't think we
> > considered anything like your implementation.
> 
> > I've CC'd a few people who were involved the last time around to see
> > if they have any input for you.
> 
> Thanks!  I don't wish to be a pest, but not having heard a "no", I'll
> send another ping out.  Perhaps a simple description is better than
> the patch for busy people:
> 
>     In init/do_mounts.c, mount_root does an interruptible_sleep_on a
>     wait queue, and goes on about its business after register_blkdev
>     in drivers/block/genhd.c does a wake_up_interruptible on it, so
>     that mounting the root device happens exactly when it needs to, no
>     sooner, no later, and doesn't depend on any fiddly timing issues.

Post your patch to the list, and I'll get it from a newsgroup.

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
Slackware Linux -- because it works.
