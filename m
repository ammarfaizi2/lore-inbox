Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311454AbSDDUNk>; Thu, 4 Apr 2002 15:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311463AbSDDUNa>; Thu, 4 Apr 2002 15:13:30 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:2802 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S311454AbSDDUNT>;
	Thu, 4 Apr 2002 15:13:19 -0500
Message-ID: <3CACB2E2.D9F4A7FE@mvista.com>
Date: Thu, 04 Apr 2002 12:09:06 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Robert Love <rml@tech9.net>, Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() atboot 
 time
In-Reply-To: <Pine.LNX.4.33.0204041139060.12895-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On 4 Apr 2002, Robert Love wrote:
> >
> > Eh, maybe - what about all the code that sets non-running before putting
> > itself on a wait queue?
> 
> In most cases that code will call a schedule itself.
> 
> Of course, we might make just ZOMBIE a special case, but in general I
> think it's simply absolutely wrong for the preemption to change task
> internal data structures on its own.
>
Amen!
 
>                 Linus
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
