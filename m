Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266701AbSLJGsa>; Tue, 10 Dec 2002 01:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbSLJGsa>; Tue, 10 Dec 2002 01:48:30 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:48121 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S266701AbSLJGs2>;
	Tue, 10 Dec 2002 01:48:28 -0500
Message-ID: <3DF58FF1.9C3A5BF3@mvista.com>
Date: Mon, 09 Dec 2002 22:55:45 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 20
References: <3DF2F8D9.6CA4DC85@mvista.com> <1039341009.1483.3.camel@laptop.fenrus.com> <3DF44031.58A12F66@mvista.com> <20021209035347.C12524@devserv.devel.redhat.com> <3DF48C4C.3F056661@mvista.com> <20021209073434.A24382@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> On Mon, Dec 09, 2002 at 04:27:56AM -0800, george anzinger wrote:
> > >
> > > that's why spinlocks are effectively nops on UP.
> > > What you say is true of just about every spinlock user, and no
> > > they shouldn't all do some IF_SMP() thing; the spinlock itself should be
> > > (and is) zero on UP
> >
> > But with preemption, they really are not nops on UP...
> 
> that doesn't justify fuglyfying the kernel code. If you can't live
> with the overhead of preemption, disable preemption. Simple.
> We DON'T want
> spin_lock_nop_on_preempt()
> ...
> 
> spin_unlock_nop_on_preempt()
> 
> really, I don't, and I can't see anyone else wanting that either

Well, I just thought it was an optimization.  I will leave
it the way it is.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
