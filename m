Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTBXKEj>; Mon, 24 Feb 2003 05:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTBXKEi>; Mon, 24 Feb 2003 05:04:38 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:20613 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S266114AbTBXKEi>; Mon, 24 Feb 2003 05:04:38 -0500
Date: Mon, 24 Feb 2003 02:11:36 -0800
To: Andrew Morton <akpm@digeo.com>
Cc: wli@holomorphy.com, lm@work.bitmover.com, mbligh@aracnet.com,
       davidsen@tmr.com, greearb@candelatech.com, linux-kernel@vger.kernel.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224101136.GA7063@gnuppy.monkey.org>
References: <33350000.1046043468@[10.10.2.4]> <20030224045717.GC4215@work.bitmover.com> <20030224074447.GA4664@gnuppy.monkey.org> <20030224075430.GN10411@holomorphy.com> <20030224080052.GA4764@gnuppy.monkey.org> <20030224004005.5e46758d.akpm@digeo.com> <20030224085617.GA6483@gnuppy.monkey.org> <20030224010938.35de6275.akpm@digeo.com> <20030224092427.GA6733@gnuppy.monkey.org> <20030224015625.2c258894.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224015625.2c258894.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 01:56:25AM -0800, Andrew Morton wrote:
> But that is speculation as well - I never observed this aspect to be
> a real problem.  Probably, it was not.
> 
> Substantiation of your claim requires quality testing and a plausible
> explanation.  I do not believe we have seen either, OK?

Well, let's back off here. It's not my claim, it's Robert Love's in that
URL. Not to arrange a fight, but I had to point that out. :)

> > 	http://linuxdevices.com/articles/AT6106723802.html
> 
> I did, briefly.  It appears to be claiming that the average scheduling
> latency of the non-preemptible kernel is ten milliseconds!

They mention that this is related to the console code. Obviously, if you're
not checking for reschedule in a big pix map scroll blit, then it's going
to stick out boldly as a big latency spike.

A fully preemptive system would only turn off preemption in places that
would break drivers and other obvious places like scheduler run-queues,
etc...

> Maybe I need to read that again in the morning.

It's also an old article, but goes over a lot of the basics of a fully
preemptable kernel like that. Things might not be as dramatic now with
2.5.62. Not sure how things are now...

bill

