Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTE0UPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTE0UPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:15:07 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:51206 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264132AbTE0UPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:15:00 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 22:24:22 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <200305272032.03645.m.c.p@wolk-project.de> <20030527201028.GJ3767@dualathlon.random>
In-Reply-To: <20030527201028.GJ3767@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305272224.22567.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 22:10, Andrea Arcangeli wrote:

Hi Andrea,

> 10/15 performance drop doesn't sound good, no matter what hardware ;).
lol, well. YES ;)

> However in contest I recall there was quite an improvement in latency at
> least (I mean, it had some positive effect too)
Yeah, but latency != throughput ;)

> Getting the best throughput and latency at the same time is normally not
> possible, however evaluating if it's losing excessive throughput given a
> certain latency improvement is difficult.
It is possible. I use 2.5 (preferably -mm tree) now more then any 2.4*.
I use the AS (Anticipatory IO Scheduler) which AKPM included in his tree.
This scheduler is kicking ass. Everything is rock fast, I can trash my HD to 
whatever I want, I still get no mouse stops, keyboard stops or anything like 
that. Even starting up multiple programs is possible while trashing the HD. 
Sure, it takes longer but it works :)

I try to backport BIO and then AS for quite over 2 weeks now, but it seems, at 
least for me, that it's an impossible mission ;(


> I'll try to find what's the precise reason of the interactivity drop
cool. Thanks.

> with the 2.4.18->2.4.19 blkdev changes on Thu. I think I shortly looked
> into it once but there was no definitive answer, or anyways going back
> to the 2.4.18 code didn't appeal or make much sense.
Yeah, that's not an option. The throughput has been increased in 2.4.19 
compared to 2.4.18.

> However I suspect this responsiveness issue could be storage hardware
> dependent.
Hmm, I am quite sure that it isn't. I have ton's of mostly totally different 
hardware in my company, also test machines for WOLK at freenet.de (the 
biggest I had was a QUAD Xeon 1GHz with 16GB memory and hardware RAID (Compaq 
ML570 to be exact (f*cking nice machine btw. ;) and I even hit it on that 
machine. Friends of mine having also different hardware then me, also hitting 
that bug. _If_ it's the case of storage hardware, then many storage hardware 
is affected ;)

> The sentence by Linus in the last few days while talking with Jens,
> about storage that reorders stuff and starve requests at the two ends of
> the platter was very scary, maybe you're really bitten by something like
> that. Linux does the right thing but your hardware keeps posting stuff
> under the os and mine doesn't.
Oh, did I miss something at lkml or was it privately?

ciao, Marc

