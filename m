Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRC2Vwc>; Thu, 29 Mar 2001 16:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRC2VwW>; Thu, 29 Mar 2001 16:52:22 -0500
Received: from chromium11.wia.com ([207.66.214.139]:42511 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S129115AbRC2VwR>; Thu, 29 Mar 2001 16:52:17 -0500
Message-ID: <3AC3AF3E.F083EE36@chromium.com>
Date: Thu, 29 Mar 2001 13:55:11 -0800
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <dlang@diginsite.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux scheduler limitations?
In-Reply-To: <Pine.LNX.4.33.0103291326110.26411-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.4.2-ac26, but I've noticed the same behavior with all the 2.4
kernels I've seen so far.

I haven't even tried on 2.2

 - Fabio

David Lang wrote:

> 2.2 or 2.4 kernel?
>
> the 2.4 does a MUCH better job of dealing with large numbers of processes.
>
> David Lang
>
> On Thu, 29 Mar 2001, Fabio Riccardi wrote:
>
> > Date: Thu, 29 Mar 2001 13:19:05 -0800
> > From: Fabio Riccardi <fabio@chromium.com>
> > To: linux-kernel@vger.kernel.org
> > Subject: linux scheduler limitations?
> >
> > Hello,
> >
> > I'm working on an enhanced version of Apache and I'm hitting my head
> > against something I don't understand.
> >
> > I've found a (to me) unexplicable system behaviour when the number of
> > Apache forked instances goes somewhere beyond 1050, the machine
> > suddently slows down almost top a halt and becomes totally unresponsive,
> > until I stop the test (SpecWeb).
> >
> > Profiling the kernel shows that the scheduler and the interrupt handler
> > are taking most of the CPU time.
> >
> > I understand that there must be a limit to the number of processes that
> > the scheduler can efficiently handle, but I would expect some sort of
> > gradual performance degradation when increasing the number of tasks,
> > instead I observe that by increasing Apache's MaxClient linit by as
> > little as 10 can cause a sudden transition between smooth working with
> > lots (30-40%) of CPU idle to a total lock-up.
> >
> > Moreover the max number of processes is not even constant. If I increase
> > the server load gradually then I manage to have 1500 processes running
> > with no problem, but if the transition is sharp (the SpecWeb case) than
> > I end-up having a lock up.
> >
> > Anybody seen this before? Any clues?
> >
> >  - Fabio
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >

