Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbTBXJqI>; Mon, 24 Feb 2003 04:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbTBXJqI>; Mon, 24 Feb 2003 04:46:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:54187 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265947AbTBXJqH>;
	Mon, 24 Feb 2003 04:46:07 -0500
Date: Mon, 24 Feb 2003 01:56:25 -0800
From: Andrew Morton <akpm@digeo.com>
To: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Cc: wli@holomorphy.com, lm@work.bitmover.com, mbligh@aracnet.com,
       davidsen@tmr.com, greearb@candelatech.com, linux-kernel@vger.kernel.org,
       billh@gnuppy.monkey.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-Id: <20030224015625.2c258894.akpm@digeo.com>
In-Reply-To: <20030224092427.GA6733@gnuppy.monkey.org>
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com>
	<33350000.1046043468@[10.10.2.4]>
	<20030224045717.GC4215@work.bitmover.com>
	<20030224074447.GA4664@gnuppy.monkey.org>
	<20030224075430.GN10411@holomorphy.com>
	<20030224080052.GA4764@gnuppy.monkey.org>
	<20030224004005.5e46758d.akpm@digeo.com>
	<20030224085617.GA6483@gnuppy.monkey.org>
	<20030224010938.35de6275.akpm@digeo.com>
	<20030224092427.GA6733@gnuppy.monkey.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Feb 2003 09:56:12.0624 (UTC) FILETIME=[F69EFD00:01C2DBEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (Hui) <billh@gnuppy.monkey.org> wrote:
>
> On Mon, Feb 24, 2003 at 01:09:38AM -0800, Andrew Morton wrote:
> > That's a 5% difference across five dbench runs.  If it is even 
> > statistically significant, dbench is notoriously prone to chaotic
> > effects (less so in 2.5)  It is a long stretch to say that any
> > increase in dbench numbers can be generalised to "improved IO
> > performance" across the board.
> 
> I think the test is valid. If the scheduler can't deal with some
> kind IO event in a very tight time window, then you'd think that 
> it might influence the performance of that IO system.
> 

On the contrary.  If the disk request queue is plugged and the task
which is submitting writeback is preempted, the IO system could 
remain artificially idle for hundreds of milliseconds while the CPU
is off calculating pi.  This is one of the reasons why I converted
the 2.5 request queues to unplug autonomously.

But that is speculation as well - I never observed this aspect to be
a real problem.  Probably, it was not.

Substantiation of your claim requires quality testing and a plausible
explanation.  I do not believe we have seen either, OK?

> Read:
> 	http://linuxdevices.com/articles/AT6106723802.html

I did, briefly.  It appears to be claiming that the average scheduling
latency of the non-preemptible kernel is ten milliseconds!

Maybe I need to read that again in the morning.



