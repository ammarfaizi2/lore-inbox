Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSA2AfK>; Mon, 28 Jan 2002 19:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSA2AfA>; Mon, 28 Jan 2002 19:35:00 -0500
Received: from waste.org ([209.173.204.2]:485 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S287946AbSA2Ael>;
	Mon, 28 Jan 2002 19:34:41 -0500
Date: Mon, 28 Jan 2002 18:34:29 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Martin Josefsson <gandalf@wlug.westbo.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] [sched] yield speedup, 2.5.3-pre5
In-Reply-To: <Pine.LNX.4.33.0201282020440.13846-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0201281833450.18405-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Ingo Molnar wrote:

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

Needs a comment.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

