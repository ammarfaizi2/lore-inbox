Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUGBD1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUGBD1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 23:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266431AbUGBD1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 23:27:39 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:9603 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S266427AbUGBD1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 23:27:32 -0400
Message-Id: <200407020327.i623RT0J010592@localhost.localdomain>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK 
In-reply-to: Your message of "Thu, 01 Jul 2004 11:14:01 PDT."
             <20040701181401.GB21066@holomorphy.com> 
Date: Thu, 01 Jul 2004 23:27:28 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [141.152.253.159] at Thu, 1 Jul 2004 22:27:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Jun 30, 2004 at 09:41:46AM -0400, Paul Davis wrote:
>>> Because of the recognition by kernel developers that 2.6 does not
>>> perform as well as 2.4+lowlat (the Andrew Morton patches) when it
>>> comes to scheduling latency, most audio developers and users have
>>> remained with 2.4. Recently however, several brave souls have
>>> attempted to test 2.6. The results have been mixed.
>
>On Thu, Jul 01, 2004 at 01:03:56PM -0500, Matt Mackall wrote:
>> I'm afraid these "brave souls" have shown up to the baby shower after
>> the child's been accepted to college. Developers getting around to
>> testing 2.6 after multiple vendors are shipping it should not be
>> characterized as courageous.

I call BS on this response.

We were told by A(ndrew)M(orton) and several other people that 2.6
would not be as good as 2.4 for low latency real time audio. It was
made clear that the preemption patches were considered more
appropriate even though they did not do anywhere near as reliable an
improvement as AM's lowlat patches. We found out (and I mean no
discredit to AM whatsoever - he did an amazing job on the 2.4 lowlat
patches) that the author of the premiere lowlat patches for 2.4 would
not be maintaining a similar set for 2.6. We also found during the
development of 2.5 that there were a number of areas of real concern,
(the VM subsystem and the scheduler and the disk subsystems) but that
many notable kernel developers were not particularly interested in our
needs - we were considered odd, edge case studies.

So we just punted and said "ah, its OK, we still have 2.4 and that
works really, really well". I spent a lot of time working debugging,
testing, measuring and playing with on 2.3 and 2.4. I even tested the
HRT patches with great anticipation (they didn't work very well at
all, and I didn't have time to spend tracking that down then). I'm
terribly sorry, but I don't have time to do full-scale kernel
debugging and also develop applications that have already taken 4+
years to get to "useful". Frankly, the mess of dealing with the
development process for 2.3/2.4, with a VM subsystem that took a year
to stabilize into a situation where we could reliably stream realistic
audio workloads didn't make me feel too good when I started reading
about similar issues in 2.5 before it was even half-done. I tested
just about every MM patch from andrea and rik that came out for
2.3/2.4 - I did not have time to do that with 2.5.

And 2.4.19+ does work really well. The problem is that users are now
booting up 2.6 and finding out that (1) the deep changes in the thread
system have not been fully tested with real time thread applications
and (2) the scheduler, VM and disk subsystems appear to be conspiring
to prevent performance equivalent to 2.4+lowlat. Are we suprised? No,
we knew this would be the case? Are we complaining? Not really. Are we
asking for help? Are we offering to try to help as best we can? Yes,
we certainly are.

Courageous? Yes, because they are willing to start testing a kernel
that has been developed with an open admission by the kernel
development group that our needs are not considered particularly
important or relevant (and there is nothing wrong with that, just to
be clear about it). Linus made it clear 2 years ago that we weren't
going to get what we needed any time soon, and personally, I am
entirely happy with telling people to use 2.4+lowlat instead. There
are several distributions of Linux that build precisely this kernel
for users, and those users are very happy with it.

But NPTL has muddied the situation considerably. People did test NPTL
when it came out. It seemed to work perfectly OK. So we just assumed
that it would always work perfectly OK. It turns out, however, that it
no longer does. And therefore I wrote to try to find out what we could
do figure it out. 

>I appear to have nuked the thread you're replying to in disgust over
>this precise issue.

Disgust? Thanks for sharing.

--p
