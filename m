Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288952AbSA2M77>; Tue, 29 Jan 2002 07:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288845AbSA2M7t>; Tue, 29 Jan 2002 07:59:49 -0500
Received: from mx2.elte.hu ([157.181.151.9]:8139 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288810AbSA2M7g>;
	Tue, 29 Jan 2002 07:59:36 -0500
Date: Tue, 29 Jan 2002 15:57:02 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Martin Josefsson <gandalf@wlug.westbo.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] [sched] yield speedup, 2.5.3-pre5
In-Reply-To: <Pine.LNX.4.44.0201281833450.18405-100000@waste.org>
Message-ID: <Pine.LNX.4.33.0201291556320.7176-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jan 2002, Oliver Xymoron wrote:

> > > > -	spin_unlock_irq(&rq->lock);
> > > > +	spin_unlock(&rq->lock);

> > normally yes, but in this case it's an optimization: schedule() will
> > disable interrupts within a few cycles, so there is no point in enabling
> > irqs for a short amount of time.

> Needs a comment.

agreed, John Levon suggested this too. I've added a comment to my tree,
should show up in the next patches.

	Ingo

