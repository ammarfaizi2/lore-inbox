Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbRFSX4z>; Tue, 19 Jun 2001 19:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264361AbRFSX4p>; Tue, 19 Jun 2001 19:56:45 -0400
Received: from intranet.resilience.com ([209.245.157.33]:4521 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S261173AbRFSX4h>; Tue, 19 Jun 2001 19:56:37 -0400
Mime-Version: 1.0
Message-Id: <p05100319b75593a25b1e@[10.128.7.49]>
In-Reply-To: <15151.49403.344626.759512@pizda.ninka.net>
In-Reply-To: <Pine.LNX.4.30.0106190940420.28643-100000@gene.pbi.nrc.ca>
 <3B2F769C.DCDB790E@kegel.com>	<20010619090956.R3089@work.bitmover.com>
 <p05100302b7553d481172@[10.128.7.49]>
 <15151.48287.782428.953466@pizda.ninka.net>
 <p0510030ab7556d686012@[10.128.7.49]>
 <15151.49403.344626.759512@pizda.ninka.net>
Date: Tue, 19 Jun 2001 16:56:16 -0700
To: "David S. Miller" <davem@redhat.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:15 PM -0700 2001-06-19, David S. Miller wrote:
>Jonathan Lundell writes:
>  > It seems to me that the telling argument against threads has much
>  > more to do with the potential complexity of the resulting code than
>  > with after-all-minor performance considerations.
>
>I don't get this impression, see the stack space memory usage parts
>of this thread, particular some of Larry's postings.

OK, in some contexts, sure. Larry wrote, for example:

>  ...  It was originally said to some GUI people
>  who wanted to use a thread per object, every button, scrollbar, canvas,
>  text widget, menu, etc., are all threads.  What they didn't figure out is
>  that a thread needs a stack, the stack is the dominating space term, and
>  they were looking at a typical desktop with around 9,000 objects.  Times,
>  at that point, an 8K stack.  That was 73MB in stacks.  Pretty darned stupid
>  when you look at it that way, huh?

But so what? That's $16 worth of DRAM (I just checked). Not so bad 
*if* threads are otherwise a great solution. I grant that one might 
have a pretty tough time making the case, but again, for the right 
application, say some app with a dedicated server, 73MB isn't the end 
of the world (though I suppose it was at the time...).

Regardless, these discussions tend to end up sounding like (in this 
case) "use threads for everything" vs "never ever use threads", 
neither of which is likely to fairly represent the views of the 
participants. Threads have their place, they can be misused, and 
overusing resources is only one of the possible ways to misuse them.
-- 
/Jonathan Lundell.
