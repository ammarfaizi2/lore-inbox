Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSIBFRg>; Mon, 2 Sep 2002 01:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSIBFRg>; Mon, 2 Sep 2002 01:17:36 -0400
Received: from mail.michigannet.com ([208.49.116.30]:21001 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S314446AbSIBFRf>; Mon, 2 Sep 2002 01:17:35 -0400
Date: Mon, 2 Sep 2002 01:22:03 -0400
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
Message-ID: <20020902052203.GC2925@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
References: <3D72C6F9.6000302@wmich.edu> <Pine.LNX.4.44L.0209012327360.1857-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0209012327360.1857-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br>, on Sun Sep 01, 2002 [11:32:42 PM] said:
> On Sun, 1 Sep 2002, Ed Sweetman wrote:
> > I mean, besides making the kernel with as low latency as possible, what
> > is bad about the responsiveness in the kernel?  If there's any lag in
> > responsiveness that i see it's always something X related, particularly
> > Xfree86.
> 
> "low latency" != responsiveness
> 
> Any latency which is below the point the user can notice
> is effectively zero, so whether the 10000 wakeups/minute
> that the user doesn't notice are 2ms or 5ms don't really
> matter.
> 
> What does matter are the wakeups that make the user's
> mp3 skip, even if these don't influence the statistics
> at all because there's only 1 every few minutes, or none,
> if the VM is balanced right ;)
> 
> Another responsiveness thing is how fast you can swap in
> Mozilla when the user comes in in the morning. More of a
> throughput than a latency thing in this case ... but you
> still have to make sure the mp3 doesn't skip while mozilla
> is being loaded.
> 
> regards,
> 
> Rik

	Hi;

	I just thought I would toss this in: For some classes
of users, latency is extremely critical. For example, people
making music live, doing realtime audio effects processing, or
recording audio. These people would probably like it below 2ms.
	mp3 playing latency requirements are very
loose-- the buffer takes up the slack, unless the latency is
insane.
	The good news is that for me, using the ck4 patchset,
my smp system is stable, and has a max latency of 3.5ms under
latencytest (during a make -j4 kernel compile no less) _and_
outperformed (slightly) virgin 2.4.19 on generic benchmarks.
(like building a kernel, bonnie,...)	
	Latency may not be the holy grail, but it remains
a valid requirement for a class of user. It may not merit
degredation for the common case, but perhaps it need not?

Paul
set@pobox.com

ps. ck4 uses the aa vm, but if there was a version with rmap,
I would test it.
