Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310953AbSC1Abo>; Wed, 27 Mar 2002 19:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311026AbSC1Abh>; Wed, 27 Mar 2002 19:31:37 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:60423 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S310953AbSC1Ab2>; Wed, 27 Mar 2002 19:31:28 -0500
Message-ID: <3CA263EB.2576ED4A@zip.com.au>
Date: Wed, 27 Mar 2002 16:29:31 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Kirkwood <matthew@hairy.beasts.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
In-Reply-To: <3CA20698.E8A9826E@zip.com.au> <Pine.LNX.4.33.0203272354430.17217-100000@sphinx.mythic-beasts.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood wrote:
> 
> On Wed, 27 Mar 2002, Andrew Morton wrote:
> 
> > > Yeah, I thought it was a little odd.  Postgres does so much
> > > fsync()ing that I thought it may just have been that the lower
> > > overhead won out over ext2's cleverer layout.  All the I/O was
> > > basically fsync-driven, so this test was only about write
> > > performance.
> >
> > For fsync-intensive loads ext3's best mode is generally
> > data=journal.  That way, an fsync is satisfied by a nice
> > single linear write to the journal.
> 
> Here we are.  This is with just a 200Mb journal (the partition
> is only a little over 1Gb, and the datafiles grow fairly big,
> so I didn't brave making it any bigger).
> 
>         tuning? single  ir      mx-ir   oltp    mixed-oltp
>                 (sec)   (tps)   (sec)   (tps)   (sec)
> ext3    bn      1285.32 65.98   1996.41 90.05   307.79
> ext3-wb bn      1287.31 98.42   2149.38 125.13  236.02
> ext3-jd bn      1306.90 72.07   1813.54 125.15  305.27

Oh well.

It sounds like a useful and valid workload to optimise
for.  So I'll take you up on the offer of those scripts,
please.

-
