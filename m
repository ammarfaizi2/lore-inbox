Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317277AbSGVNmD>; Mon, 22 Jul 2002 09:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317279AbSGVNmD>; Mon, 22 Jul 2002 09:42:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59034 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317277AbSGVNmB>;
	Mon, 22 Jul 2002 09:42:01 -0400
Date: Mon, 22 Jul 2002 15:43:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <20020722152056.A18619@lst.de>
Message-ID: <Pine.LNX.4.44.0207221538580.9004-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Christoph Hellwig wrote:

> void irq_off(void);
> void irq_on(void);
> 
> flags_t irq_save();
> void irq_restore(flags_t);

i'm not so sure about flags_t. 'unsigned long' worked pretty well so far,
and i do not see the need for a more complex (or more opaque) irqflags
type. It's not that we confuse flags with some other flag all that
frequently that would necessiate some structure-based more abstract
protection of these variables.

(wrt. inline functions, every architecture is free to define them as
inline functions as they see fit.)

	Ingo

