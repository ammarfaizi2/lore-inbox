Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289102AbSAGD0x>; Sun, 6 Jan 2002 22:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289104AbSAGD0n>; Sun, 6 Jan 2002 22:26:43 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:36366 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289102AbSAGD0W>; Sun, 6 Jan 2002 22:26:22 -0500
Date: Sun, 6 Jan 2002 19:31:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Richard Henderson <rth@twiddle.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201061908330.5819-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0201061927490.1000-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Linus Torvalds wrote:

>
> On Sun, 6 Jan 2002, Richard Henderson wrote:
> > On Sun, Jan 06, 2002 at 02:13:32AM +0000, Alan Cox wrote:
> > > ... since an 8bit ffz can be done by lookup table
> > > and that is fast on all processors
> >
> > Please still provide the arch hook -- single cycle ffs type
> > instructions are still faster than any memory access.
>
> This is probably true even on x86, except in benchmarks (the x86 ffs
> instruction definitely doesn't historically count as "fast", and a table
> lookup will probably win in a benchmark where the table is hot in the
> cache, but you don't have to miss very often to be ok with a few CPU
> cycles..)
>
> (bsfl used to be very slow. That's not as true any more)

32 bit words lookup can be easily done in few clock cycles in most cpus
by using tuned assembly code.




- Davide


