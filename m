Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283451AbRLEHlo>; Wed, 5 Dec 2001 02:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283477AbRLEHlf>; Wed, 5 Dec 2001 02:41:35 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:38645 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S283451AbRLEHl1>; Wed, 5 Dec 2001 02:41:27 -0500
Message-ID: <3C0DCF8C.9F7D40F4@mvista.com>
Date: Tue, 04 Dec 2001 23:41:00 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@xs4all.nl>
CC: Robert Love <rml@tech9.net>, nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improve spinlock debugging
In-Reply-To: <Pine.LNX.4.40.0112041321080.595-100000@cosmic.nrg.org> <1007504598.1307.30.camel@phantasy> <3C0D74B8.F3FF439@xs4all.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Hi,
> 
> Robert Love wrote:
> 
> > Right, I meant just the spin_lock_irq case, which would be fine except
> > for the case where:
> >
> > spin_lock_irq
> > spin_unlock
> > restore_irq
> >
> > to solve this, we need a spin_unlock_irq_on macro that didn't touch the
> > preemption count.
> 
> Has someone a real example of something like this?
> I'd suspect someone is trying a (questionable) micro optimization or is
> holding the lock for too long anyway. Instead of adding more macros,
> maybe it's better to look closely whether something needs fixing.
> 
Oh it is in there somewhere.  I tried to do the indicated thing for
preemption and ran aground on it.  Grep drivers for spin_lock_irq (or
irq save).  I don't remember which, but there is more than one.


-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
