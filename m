Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWALGiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWALGiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWALGiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:38:55 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:40603 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932686AbWALGiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:38:54 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Martin Bligh <mbligh@google.com>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Date: Thu, 12 Jan 2006 17:39:17 +1100
User-Agent: KMail/1.8.3
Cc: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <43C45BDC.1050402@google.com> <43C5BD8F.3000307@bigpond.net.au> <43C5BE4A.9030105@google.com>
In-Reply-To: <43C5BE4A.9030105@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121739.17886.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 01:26 pm, Martin Bligh wrote:
> Peter Williams wrote:
> > Con Kolivas wrote:
> >> On Thu, 12 Jan 2006 12:29 pm, Peter Williams wrote:
> >>> Con Kolivas wrote:
> >>>> This is a shot in the dark. We haven't confirmed 1. there is a
> >>>> problem 2.
> >>>> that this is the problem nor 3. that this patch will fix the problem.
> >>>
> >>> I disagree.  I think that there is a clear mistake in my original patch
> >>> that this patch fixes.
> >>
> >> I agree with you on that. The real concern is that we were just about
> >> to push it upstream. So where does this leave us?  I propose we delay
> >> merging the
> >> "improved smp nice handling" patch into mainline pending your further
> >> changes.
> >
> > I think that they're already in 2.6.15 minus my "move load not tasks"
> > modification which I was expecting to go into 2.6.16.  Is that what you
> > meant?
> >
> > If so I think this is a small and obvious fix that shouldn't delay the
> > merging of "move load not tasks" into the mainline.  But it's not my
> > call.
>
> BTW, in reference to a question from last night ... -git7 seems fine. So
> if you merged it already, it wasn't that ;-)

Thanks and looks like the results are in from 2.6.14-rc2-mm1 with the patch 
backed out.

Drumroll....

http://test.kernel.org/perf/kernbench.moe.png

The performance goes back to a range similar to 2.6.14-rc1-mm1 (see 
2.6.14-rc2-mm1 + 20328 in blue). Unfortunately this does implicate this 
patch. Can we put it back into -mm only and allow Peter's tweaks/fixes to go 
on top and have it tested some more before going upstream?

Peter, Ingo?

Cheers,
Con
