Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289112AbSAGDSC>; Sun, 6 Jan 2002 22:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289113AbSAGDRp>; Sun, 6 Jan 2002 22:17:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18693 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289101AbSAGDRb>; Sun, 6 Jan 2002 22:17:31 -0500
Date: Sun, 6 Jan 2002 19:16:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>, Ingo Molnar <mingo@elte.hu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <20020106190801.A27356@twiddle.net>
Message-ID: <Pine.LNX.4.33.0201061908330.5819-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Jan 2002, Richard Henderson wrote:
> On Sun, Jan 06, 2002 at 02:13:32AM +0000, Alan Cox wrote:
> > ... since an 8bit ffz can be done by lookup table
> > and that is fast on all processors
>
> Please still provide the arch hook -- single cycle ffs type
> instructions are still faster than any memory access.

This is probably true even on x86, except in benchmarks (the x86 ffs
instruction definitely doesn't historically count as "fast", and a table
lookup will probably win in a benchmark where the table is hot in the
cache, but you don't have to miss very often to be ok with a few CPU
cycles..)

(bsfl used to be very slow. That's not as true any more)

		Linus

