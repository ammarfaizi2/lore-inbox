Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288851AbSA3HyD>; Wed, 30 Jan 2002 02:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288827AbSA3Hxy>; Wed, 30 Jan 2002 02:53:54 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:19884 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288811AbSA3Hxp>; Wed, 30 Jan 2002 02:53:45 -0500
Message-Id: <200201291610.g0TGAvqf001302@tigger.cs.uni-dortmund.de>
To: mingo@elte.hu
cc: Martin Josefsson <gandalf@wlug.westbo.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] [sched] yield speedup, 2.5.3-pre5 
In-Reply-To: Message from Ingo Molnar <mingo@elte.hu> 
   of "Mon, 28 Jan 2002 20:21:56 +0100." <Pine.LNX.4.33.0201282020440.13846-100000@localhost.localdomain> 
Date: Tue, 29 Jan 2002 17:10:57 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> said:
> On Mon, 28 Jan 2002, Martin Josefsson wrote:
> 
> > > -	spin_unlock_irq(&rq->lock);
> > > +	spin_unlock(&rq->lock);
> 
> > I'm not an spinlock expert but shouldn't you use spin_unlock_irq()
> > when it was locked with spin_lock_irq() ?
> 
> normally yes, but in this case it's an optimization: schedule() will
> disable interrupts within a few cycles, so there is no point in enabling
> irqs for a short amount of time.

And a short comment in the code?
-- 
Horst von Brand			     http://counter.li.org # 22616
