Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbSLIM1F>; Mon, 9 Dec 2002 07:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbSLIM1F>; Mon, 9 Dec 2002 07:27:05 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:42046 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265382AbSLIM1E>; Mon, 9 Dec 2002 07:27:04 -0500
Date: Mon, 9 Dec 2002 07:34:34 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: george anzinger <george@mvista.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 20
Message-ID: <20021209073434.A24382@devserv.devel.redhat.com>
References: <3DF2F8D9.6CA4DC85@mvista.com> <1039341009.1483.3.camel@laptop.fenrus.com> <3DF44031.58A12F66@mvista.com> <20021209035347.C12524@devserv.devel.redhat.com> <3DF48C4C.3F056661@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DF48C4C.3F056661@mvista.com>; from george@mvista.com on Mon, Dec 09, 2002 at 04:27:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Dec 09, 2002 at 04:27:56AM -0800, george anzinger wrote:
> > 
> > that's why spinlocks are effectively nops on UP.
> > What you say is true of just about every spinlock user, and no
> > they shouldn't all do some IF_SMP() thing; the spinlock itself should be
> > (and is) zero on UP
> 
> But with preemption, they really are not nops on UP...

that doesn't justify fuglyfying the kernel code. If you can't live
with the overhead of preemption, disable preemption. Simple. 
We DON'T want
spin_lock_nop_on_preempt()
...

spin_unlock_nop_on_preempt()

really, I don't, and I can't see anyone else wanting that either
