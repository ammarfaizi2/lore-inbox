Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbTBXOsQ>; Mon, 24 Feb 2003 09:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTBXOsQ>; Mon, 24 Feb 2003 09:48:16 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37388 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267158AbTBXOsP>; Mon, 24 Feb 2003 09:48:15 -0500
Date: Mon, 24 Feb 2003 09:40:25 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Andrew Morton <akpm@digeo.com>, wli@holomorphy.com, lm@work.bitmover.com,
       mbligh@aracnet.com, greearb@candelatech.com,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <20030224085617.GA6483@gnuppy.monkey.org>
Message-ID: <Pine.LNX.3.96.1030224092742.4783D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Bill Huey wrote:

> On Mon, Feb 24, 2003 at 12:40:05AM -0800, Andrew Morton wrote:
> > There is no evidence for any such thing.  Nor has any plausible
> > theory been put forward as to why such an improvement should occur.
> 
> I find what you're saying a rather unbelievable given some of the
> benchmarks I saw when the preempt patch started to floating around.
> 
> If you search linuxdevices.com for articles on preempt, you'll see a
> claim about IO performance improvements with the patch. If somethings
> changed then I'd like to know.

Clearly you do know... preempt started out when 2.4 was the only game in
town. It made improvements to some degree because the rest of the kernel
had some real latency issues.

Skip forward through low latency patches, several flavors of elevator
improvements, faster clock rate, rmap, better VM, object rmap, finer
grained locking, io scheduling of several types including latency limiting
and prevention of write blocking, and the O(1) scheduler.

Preempt was a great way to get the right thing running sooner because
there was a lot of latency in many places. Just doesn't seem to be true
anymore. Preempt doesn't make as much difference anymore because many
things have been improved.

I'm sure that there are applications which benefit greatly from preempt,
but the days of vast improvement seem to be gone, the low hanging fruit
has been picked. Context switching latency is still way higher than 2.4,
that isn't hurting io as much as all the other improvements have helped.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

