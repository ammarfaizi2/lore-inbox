Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292657AbSCDSdF>; Mon, 4 Mar 2002 13:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292660AbSCDScz>; Mon, 4 Mar 2002 13:32:55 -0500
Received: from zero.tech9.net ([209.61.188.187]:9487 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292657AbSCDSco> convert rfc822-to-8bit;
	Mon, 4 Mar 2002 13:32:44 -0500
Subject: Re: latency & real-time-ness.
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <200203041720.41169.Dieter.Nuetzel@hamburg.de>
In-Reply-To: <200203041720.41169.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 13:32:28 -0500
Message-Id: <1015266757.15277.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 11:20, Dieter Nützel wrote:

> Robert I am running 2.4.19-pre2-ac2 + preemption + lock-break.
> It is very snappy due to lock-break I think.
> But lock-break failed on vmscan.c and I didn't apply it by hand this time.
> There was another fail but it was small and easily fixable.
> We need a new lock-break, soon.

-ac2 has rmap and lock-break is not designed for the rmap VM.  You can
just ignore the rejects.  Further, rmap has some conditional schedules
so you are taken care of.

If rmap finds its way into 2.5, I and others have some ideas about ways
to optimize the algorithms to reduce lock hold time and benefit from
preemption.  For example, Daniel Phillips has some ideas wrt
zap_page_range.

> Sadly it is relative hard to put sched-O1-2.4.18-pre8-K3.patch and preemption 
> on top of 2.4.19pre2aa1 which I did for several weeks before. The throughput 
> with -aa VM maintenance is much better then with -ac.
>
> Latest -aa is 2.4.18-pre8-K3-VM-24-preempt-lock.

	Robert Love

