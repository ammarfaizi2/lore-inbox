Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269868AbRHMWPd>; Mon, 13 Aug 2001 18:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269866AbRHMWPX>; Mon, 13 Aug 2001 18:15:23 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:51466 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S269864AbRHMWPG>; Mon, 13 Aug 2001 18:15:06 -0400
Message-ID: <017f01c12445$e4763520$bef7020a@mammon>
From: "Jeremy Linton" <jlinton@interactivesi.com>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Rik van Riel" <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108101803570.1289-100000@penguin.transmeta.com>
Subject: Re: [BUG][PATCH] in sys_swapoff() path 
Date: Mon, 13 Aug 2001 17:18:28 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Linus Torvalds" <torvalds@transmeta.com>

> Can you test that the appended version does the same thing for you? I made
> the mm/memory.c check a bit stricter (it should be the _same_ pte entry,
...
> Plus this has Rik's swapspace full patch - fixed to NOT unconditionally
....
> Jeremy, Rik, please verify my changes..


Looks good!!! I grabbed 2.4.8 and put it on my machine, closely inspected
your changes to my original patch and quickly took a look at Rik's code.
They both look fine and my tests seem to prove that they are. On the other
hand, the swapoff times are slower than 2.4.7pre6 with my patches applied, I
assume that is probably something else in the kernel. This kernel version
also has some problems running the stress program that helped to find those
bugs originally. Now when it is running, xosview 'bails' out with a "Can not
open file: /proc/interrupts" or similar message after a couple minutes of
steady thrashing.

If I get a chance, I will look at the xosview problems as well as some of
the other strange behaviors.


                                                jlinton





