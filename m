Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSGVNVx>; Mon, 22 Jul 2002 09:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSGVNVx>; Mon, 22 Jul 2002 09:21:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15325 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315276AbSGVNVv>;
	Mon, 22 Jul 2002 09:21:51 -0400
Date: Mon, 22 Jul 2002 15:23:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <20020722152056.A18619@lst.de>
Message-ID: <Pine.LNX.4.44.0207221521170.7711-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Christoph Hellwig wrote:

> > 	irq_off()
> > 	irq_on()
> > 	irq_save(flags)
> > 	irq_save_off(flags)
> > 	irq_restore(flags)
> 
> I'd prefer the following:
> 
> void irq_off(void);
> void irq_on(void);
> 
> flags_t irq_save();		/* the old irq_save_off() */
> void irq_restore(flags_t);
> 
> void __irq_save(void);		/* without saveing */
> 
> rational:  proper function-like API (should be inlines), irq save
> without disableing is very uncommon, better make the API symmetric.

i agree mostly, but i do not agree with __irq_save() and irq_save().  
What's wrong with "flags_t irq_save_off()" - the name carries the proper
meaning, and it also harmonizes with irq_off().

	Ingo

