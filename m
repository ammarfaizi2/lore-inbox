Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318928AbSIITOR>; Mon, 9 Sep 2002 15:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318929AbSIITOR>; Mon, 9 Sep 2002 15:14:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60568 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318928AbSIITOQ>;
	Mon, 9 Sep 2002 15:14:16 -0400
Date: Mon, 9 Sep 2002 21:23:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209092120310.1096-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0209092122030.4648-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Zwane Mwaikambo wrote:

> As an aside, i just had an idea for another way to improve interrupt
> handling latency. Instead of walking through all the isrs in the chain,
> we can have an isr flag wether it was the source of the irq, and if so
> we stop right there and not walk through the other isrs. Obviously
> taking into account that some devices are dumb and have no real way of
> determining.

this is something i have a 0.5 MB patch for that touches a few hundred
drivers. I can dust it off if there's demand - it will break almost
nothing because i've done the hard work of adding the default 'no work was
done' bit to every driver's IRQ handler.

	Ingo

