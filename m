Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbTBTWA1>; Thu, 20 Feb 2003 17:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTBTWA1>; Thu, 20 Feb 2003 17:00:27 -0500
Received: from [195.223.140.107] ([195.223.140.107]:16770 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267049AbTBTWA0>;
	Thu, 20 Feb 2003 17:00:26 -0500
Date: Thu, 20 Feb 2003 23:08:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: filesystem access slowing system to a crawl
Message-ID: <20030220220842.GZ31480@x30.school.suse.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <200302201629.51374.m.c.p@wolk-project.de> <20030220103543.7c2d250c.akpm@digeo.com> <200302202232.27433.m.c.p@wolk-project.de> <20030220134104.0b37683a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220134104.0b37683a.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 01:41:04PM -0800, Andrew Morton wrote:
> Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
> >
> > On Thursday 20 February 2003 19:35, Andrew Morton wrote:
> > 
> > Hi Andrew,
> > 
> > > Andrea's VM patches, against 2.4.21-pre4 are at
> > > 	http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.21-pre4/
> > > The applying order is in the series file.
> > I am afraid Marcelo will never accept these or some of them.
> > 
> 
> The most important one is inode-highmem.  It's a safe patch, and the risk of
> it causing problems due to not having other surrounding -aa stuff is low.
> 
> It's a matter of someone getting down, testing it and sending it.
> 
> Ho hum.  It'll take an hour.  I shall try.

this is a pre kernel, it's meant to *test* stuff, if anything will go
wrong we're here ready to fix it immediatly. Sure, applying the patch of
the last minute to an -rc just before releasing the new official kernel
w/o any kind of testing was a bad idea, but we must not be too much
conservative either, especially like in these cases where we are fixing
bugs, I mean we can't delay bugfixes with the argument that they could
introduce new bugs, otherwise we can as well stop fixing bugs.

Also note that this stuff is being tested aggressively for a very long
time by lots of people, it's not a last minute patch like the xdr
highmem deadlock ;).

Don't take me wrong, I'm not saying that Marcelo is too conservative,
quite the opposite, I'm simply not so pessimistic that the stuff won't
go in ;).

Andrea
