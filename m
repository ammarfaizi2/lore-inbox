Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289300AbSA1RlE>; Mon, 28 Jan 2002 12:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289298AbSA1Rkz>; Mon, 28 Jan 2002 12:40:55 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:59402 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S289294AbSA1Rkq>; Mon, 28 Jan 2002 12:40:46 -0500
Date: Mon, 28 Jan 2002 18:38:45 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <simon@baydel.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
In-Reply-To: <3C54D1CB.23664.50D4C3@localhost>
Message-ID: <Pine.LNX.4.33.0201281829570.1964-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If 64-bit arithmetics cannot be avoided, the do_div64() macro defined in
> > include/asm/div64.h comes in handy.
> >   mod = do_div((unsigned long) x, (long) y)
> > will set  x  to the quotient x/y  and  mod  to the remainder  x%y .
>
> I have looked at this header file and I do not understand the asm
> syntax.
>
> In particular the only x86 div instruction I know only returns a 32 bit
> div result. Because I don't understand the div64 header I cannot
> see how a 64 bit result is calculated.
>

Sorry, there are (platform-dependent) restrictions that I forgot to
mention. I think do_div(x,y) should work for all platforms if
y < 2^16 and x/y < 2^32, but I may stand corrected.

Actually, Momchil Velikov just pointed out that some archs only do 32 bit
divs in do_div64, where at least the C code from asm-parisc/div64.h
should be used.

Tim

