Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311917AbSDXUV1>; Wed, 24 Apr 2002 16:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312212AbSDXUV0>; Wed, 24 Apr 2002 16:21:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46841 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S311917AbSDXUVZ>;
	Wed, 24 Apr 2002 16:21:25 -0400
Message-ID: <3CC713A0.E501AC66@mvista.com>
Date: Wed, 24 Apr 2002 13:20:48 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <E170BnK-0001VB-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I must not be making my self clear :)  The overhead has nothing to do
> > with hardware.  It is all timer list insertion and deletion.  The
> > problem is that we need to do this at context switch rates, which are
> > MUCH higher that tick rates and, even with the O(1) insertion code,
> > cause the overhead to increase above the ticked overhead.
> 
> I remain unconvinced. Firstly the timer changes do not have to
> occur at schedule rate unless your implementaiton is incredibly naiive.

OK, I'll bite, how do you stop a task at the end of its slice if you
don't set up a timer event for that time?

> Secondly for the specfic schedule case done that way, it would be even more
> naiive to use the standard timer api over a single compare to getthe
> timer list versus schedule clock.

I guess it is my day to be naive :)  What are you suggesting here?

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
