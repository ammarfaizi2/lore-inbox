Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132693AbRDDETW>; Wed, 4 Apr 2001 00:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132745AbRDDETM>; Wed, 4 Apr 2001 00:19:12 -0400
Received: from chromium11.wia.com ([207.66.214.139]:52748 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S132693AbRDDETD>; Wed, 4 Apr 2001 00:19:03 -0400
Message-ID: <3ACAA164.BDFF9B4C@chromium.com>
Date: Tue, 03 Apr 2001 21:21:57 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Kravetz <mkravetz@sequent.com>
CC: Ingo Molnar <mingo@elte.hu>, frankeh@us.ibm.com,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: a quest for a better scheduler
In-Reply-To: <20010403121308.A1054@w-mikek2.sequent.com> <Pine.LNX.4.30.0104032024290.9285-100000@elte.hu> <20010403154314.E1054@w-mikek2.sequent.com> <3ACA683A.89D24DED@chromium.com> <20010403194700.A1024@w-mikek2.sequent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was actually suspecting that the extra lines in your patch were there for a
reason :)

A few questions:

What is the real impact of a (slight) change in scheduling semantics?

Under which situation one should notice a difference?

As you state in your papers the global decision comes with a cost, is it worth it?

Could you make a port of your thing on recent kernels?
I tried and I failed and I don't have enough time to figure out why, that should be
trivial for you though.

TIA, ciao,

 - Fabio

Mike Kravetz wrote:

> On Tue, Apr 03, 2001 at 05:18:03PM -0700, Fabio Riccardi wrote:
> >
> > I have measured the HP and not the "scalability" patch because the two do more
> > or less the same thing and give me the same performance advantages, but the
> > former is a lot simpler and I could port it with no effort on any recent
> > kernel.
>
> Actually, there is a significant difference between the HP patch and
> the one I developed.  In the HP patch, if there is a schedulable task
> on the 'local' (current CPU) runqueue it will ignore runnable tasks on
> other (remote) runqueues.  In the multi-queue patch I developed, the
> scheduler always attempts to make the same global scheduling decisions
> as the current scheduler.
>
> --
> Mike Kravetz                                 mkravetz@sequent.com
> IBM Linux Technology Center

