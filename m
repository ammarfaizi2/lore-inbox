Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283327AbRLDV2k>; Tue, 4 Dec 2001 16:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281268AbRLDV2V>; Tue, 4 Dec 2001 16:28:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:30965 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S283327AbRLDV2S>; Tue, 4 Dec 2001 16:28:18 -0500
Message-ID: <3C0D3FD8.59346BBF@mvista.com>
Date: Tue, 04 Dec 2001 13:27:52 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@nrg.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improve spinlock debugging
In-Reply-To: <Pine.LNX.4.40.0112041314010.595-100000@cosmic.nrg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Gamble wrote:
> 
> On Tue, 4 Dec 2001, george anzinger wrote:
> >                               For example, preemption currently counts
> > up on spin_lock and disable irq, counting the spin_lockirq twice.  In
> 
> That's not correct: we don't count it twice because we don't count
> local_irq_disable etc., only the spin locks.  Because...
> 
> >                                               (Oh, and since the irq
> > inhibits preemption all by itself, we don't need to count it either.)
> 
> ...so we don't.

Right, but we do count spin_lockirq (just once).  See other email, this
time.

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
