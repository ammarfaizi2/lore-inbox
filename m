Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287269AbRL2X6s>; Sat, 29 Dec 2001 18:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287270AbRL2X6j>; Sat, 29 Dec 2001 18:58:39 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:50192 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287269AbRL2X6X> convert rfc822-to-8bit; Sat, 29 Dec 2001 18:58:23 -0500
Date: Sat, 29 Dec 2001 16:02:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
In-Reply-To: <200112292338.AAA29985@webserver.ithnet.com>
Message-ID: <Pine.LNX.4.40.0112291549540.1580-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Stephan von Krawczynski wrote:

> > On Sat, 29 Dec 2001, Dieter [iso-8859-15] Nützel wrote:
> >
> > The new patch need ver >= 2.5.2-pre3 because Linus merged the Time
> Slice
> > Split Scheduler and making it to apply to 2.4.x could be a pain in
> the b*tt.
> > Yes, as i expected numbers on big SMP are very good but still i
> don't
> > think that this can help you with your problem.
>
> Just a short note on that:
>
> Before the scheduler stuff really got rolling there was a pretty
> distinct discussion why L didn't quite get involved in the thread. I
> may remind you that he thought it to be not a _that_ interesting stuff
> and I well remember he said something about the smallness and the low
> possibility that it gets broken by (well-thought-out) patches. This
> leads me to believe he has no major issues with enhancements to 2.4
> scheduler.
> Well, me neither :-)
> In fact we should keep in mind that 2.5 is a _development_ kernel and
> a next stable branch is out-of-sight at this time. So it would be
> quite reasonable to do a "backport" to 2.4 of the scheduler, because
> SMP systems do get more in size and number today and the near future.
> And we should not expect the not-LKML world to use _development_
> kernels on their cool-nu-SMP-box (tm), because this can only be bad
> for ongoing comparisons with other OSs. Well, you know what I mean.

I think Alan is interested doing a back port + testing on 2.4.x
Even if i kindly agree with Linus that the scheduler code cannot screw up
that much you've to remember that this is brand new code and it needs
testing and polishing. And maybe trashing :)


> In fact I can see two major steps to take for marcelo's maintenance
> (besides the bugfixes of course):
> 1) the SMP-scheduling (its all yours, Davide :-)
> 2) the HIGHMEM problems (a warm welcome to Andrea :-)

Yep, next on your screens, "GodFather IV" :)


> We cannot deny the fact that people expect the scalability of the
> system, and just to give you a small hint, I personally already
> stopped buying UP machines. There is no real big difference in prices
> between UP and 2-SMP these days, and RAM is unbelievably cheap in this
> decade - and it makes your seti-statistics fly ;-)
> So these issues will be very much in the mainstream of all users. No
> way to deny this.
> I have no fear: this is a reachable goal, let's just take it.

You can still live with the current scheduler on 2SMP while what i'm
seeing on an 8SMP is a completely different picture.




- Davide




