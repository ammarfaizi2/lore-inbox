Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280047AbRKSCxn>; Sun, 18 Nov 2001 21:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281885AbRKSCxe>; Sun, 18 Nov 2001 21:53:34 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:53464 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S280047AbRKSCxT>;
	Sun, 18 Nov 2001 21:53:19 -0500
Date: Sun, 18 Nov 2001 21:53:16 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
cc: John Jasen <jjasen@realityfailure.org>, <linux-kernel@vger.kernel.org>
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
In-Reply-To: <3BF86A86.1010804@fugmann.dhs.org>
Message-ID: <Pine.SGI.4.31L.02.0111182144150.12243284-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Anders Peter Fugmann wrote:

> Funny how the system time is almost identical, while 10 times as much
> time is spend in userspace.
> What does top say while compiling a kernel? (On a 2.4.12 system)

right now, top is consuming 7.7% of CPU on the 2.4.12 system, and 0.7% on
the 2.2.19 system. Nothing else is running.

Hmmmm... However, I just noticed that there is a different in memory
reported:

2.2.19: 259680k
2.4.12: 254236k

but less used on the 2.4.12 machine, with right now 90000k being free
there, versus 3000k on the 2.2.19 system (running grep -r)

> I just had this strange thought that the problem might not be with the
> disc, but a whole other place - like some process hogging the CPU, and
> not allowing gcc to do its job.
>
> How does 'grep -r "somestring"' on 2.4.12 compre to 2.2.19?

grep comsumes about 25% of CPU on 2.2.19, with the following times:
1.50user 2.79system 0:12.61elapsed 34%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (178major+79minor)pagefaults 0swaps

on 2.4.12, it consumes between 60 and 80% of cpu, and I'm still waiting
for times ...

101.48user 4.11system 3:22.85elapsed 52%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (130major+138minor)pagefaults 0swaps

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

