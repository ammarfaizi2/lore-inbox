Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281320AbRKHCZc>; Wed, 7 Nov 2001 21:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281293AbRKHCZR>; Wed, 7 Nov 2001 21:25:17 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27121
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281288AbRKHCYs>; Wed, 7 Nov 2001 21:24:48 -0500
Date: Wed, 7 Nov 2001 18:24:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory accounting problem in 2.4.13, 2.4.14pre, and possibly 2.4.14
Message-ID: <20011107182442.B467@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011106140335.A13678@mikef-linux.matchmail.com> <3BE9E9A7.6F90C4DB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE9E9A7.6F90C4DB@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 06:10:47PM -0800, Andrew Morton wrote:
> Mike Fedyk wrote:
> > 
> > Hello,
> > 
> > I am trying to track down a memory accounting problem I've seen ever since I
> > tried a 2.4.13 based kernel.  Specifically I've noticed an overflow for the
> > "Cached" entry in /proc/meminfo, but also the numbers don't add up to the
> > total memory count.  Shouldn't they add up?  If they should, I haven't seen
> > one that does....
> > 
> > I first noticed it on:
> > 2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap
> > 2.4.14-pre6+preempt+netdev_random+ext3_0.9.14-2414p5
> > 
> > I thought it may be preempt so I tried:
> > 2.4.14-pre8+netdev_random-p7+xsched+ext3_0.9.14-2414p8+elevator
> > 
> > But I still get the same problem with "Cached".
> > 
> > Now I'm trying to see if it could be ext3 with:
> > 2.4.14-ext3-2.4-0.9.14-2414p8
> > 
> > And I haven't noticed the problem after 16 hours uptime.  Sometimes it would
> > show earlier, or later.
> > 
> 
> Ah.  So are you saying that it does *not* occur on
> ext3, but that it does occur on ext2?
> 

I have been able to see the same problem with 2.4.14-ext3-2.4-0.9.14-2414p8.

> Could you retest ext2 with this:
> 

I am running unpatched 2.4.14 now.

Do you still want me to try this patch now that you know I have been able to
see the problem with 2.2.14+ext3?

Mike
