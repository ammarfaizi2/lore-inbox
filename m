Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSCOVkN>; Fri, 15 Mar 2002 16:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293339AbSCOVkE>; Fri, 15 Mar 2002 16:40:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:13204 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S293337AbSCOVjy>;
	Fri, 15 Mar 2002 16:39:54 -0500
Date: Fri, 15 Mar 2002 21:35:49 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Joe Korty <joe.korty@ccur.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18 scheduler bugs
In-Reply-To: <200203152125.VAA27707@rudolph.ccur.com>
Message-ID: <Pine.LNX.4.44.0203152135170.22294-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Mar 2002, Joe Korty wrote:

> >>     Idle tasks nowdays don't spin waiting for need->resched to change,
> >>     they sleep on a halt insn instead.  Therefore any setting of
> >>     need->resched on an idle task running on a remote CPU should be
> >>     accompanied by a cross-processor interrupt.
> > 
> > this is broken as well. Check out the idle=poll feature i wrote some time
> > ago.
> 
> The idle=poll stuff is a hack. [...]

it's a feature.

> [...] I'd like my idle cpus to sleep and still have them wake up the
> moment work for them becomes available.  I see no reason why an idle cpu
> should be forced to remain idle until the next tick, nor why fixing that
> should be considered `broken'.

performance. IPIs are expensive.

	Ingo

