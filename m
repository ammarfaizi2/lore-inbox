Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293379AbSCOWBp>; Fri, 15 Mar 2002 17:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293373AbSCOWB3>; Fri, 15 Mar 2002 17:01:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10134 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S293381AbSCOWBM>;
	Fri, 15 Mar 2002 17:01:12 -0500
Date: Fri, 15 Mar 2002 21:57:06 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Joe Korty <joe.korty@ccur.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18 scheduler bugs
In-Reply-To: <200203152159.VAA27831@rudolph.ccur.com>
Message-ID: <Pine.LNX.4.44.0203152156270.23324-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Mar 2002, Joe Korty wrote:

> > > [...] But on the Athlon the IPI isnt going down a little side channel
> > > between cpus.
> > 
> > but even in the Athlon case an IPI is still an IRQ entry, which will add
> > at least 200 cycles or more to the idle wakeup latency.
> 
> It is an idle cpu that is spending those 200 cycles.

wrong. When it's woken up it's *not* an idle CPU anymore, and it's the
freshly woken up task that is going to execute 200 cycles later...

	Ingo

