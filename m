Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131237AbQKRHu2>; Sat, 18 Nov 2000 02:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131447AbQKRHuS>; Sat, 18 Nov 2000 02:50:18 -0500
Received: from getafix.lostland.net ([216.29.29.27]:45114 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S131237AbQKRHuH>; Sat, 18 Nov 2000 02:50:07 -0500
Date: Sat, 18 Nov 2000 02:20:04 -0500 (EST)
From: adrian <jimbud@lostland.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <8v4vep$15d$1@penguin.transmeta.com>
Message-ID: <Pine.BSO.4.21.0011180215380.28819-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 17 Nov 2000, Linus Torvalds wrote:

> In article <20001118014019.18006.qmail@web3404.mail.yahoo.com>,
> =?iso-8859-1?q?Markus=20Schoder?=  <markus_schoder@yahoo.de> wrote:
> >The following small program (linked against glibc 2.1.3) reliably
> >freezes my system (Athlon Thunderbird CPU) with at least kernels
> >2.4.0-test10 and 2.4.0-test11-pre5.  Even the SysRq keys do not work
> >after the freeze.
> >
> >Older kernels (e.g. 2.3.40) seem to work.  Any Ideas?
> 
> It certainly doesn't happen for me on any of the machines I work with,
> but it wouldn't compile as-is for me, so I exchanged the FPU setting
> with a simpler
> 
> 	asm("fldcw %0": :"m" (0));
> 
> which should do the equivalent (ie unmask divide by zero errors). Does
> that make a difference for you?
> 
> Can you try to figure out where it started happening? Ie try test9 and
> back too, to figure out what might be bringing it on... 
> 
> I sure as hell hope this isn't an Athlon issue.  Can other people try
> the test-program and see if we have a pattern (ie "it happens only on
> Athlons", or "Linus is on drugs and it happens for everybody else").
> 

I couldn't get it to freeze.  I tried it with asm("fldcw %0": :"m" (0))
and with fesetenv() using gcc -lm to link it.  I have glibc-2.1.2,
egcs 2.91.66, and 2.4.0-test10.

Regards,
Adrian


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
