Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbUKAXqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbUKAXqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S382648AbUKAXlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:41:16 -0500
Received: from alog0105.analogic.com ([208.224.220.120]:9600 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264995AbUKAXQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 18:16:40 -0500
Date: Mon, 1 Nov 2004 18:14:43 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.58.0411011424110.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0411011756470.27540@chaos.analogic.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
 <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com>
 <Pine.LNX.4.61.0411011219200.8483@twinlark.arctic.org>
 <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
 <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0411011651580.26464@chaos.analogic.com>
 <Pine.LNX.4.58.0411011424110.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, Linus Torvalds wrote:

>
>
> On Mon, 1 Nov 2004, linux-os wrote:
>>
>> You just don't get it. I, too, can make a so-called bench-mark
>> that will "prove" something that's so incredibly invalid that
>> it shouldn't even deserve an answer.
>
> *Plonk*
>
> You've just shown that not only do you ignore well-educated people who
> tell you why pipelines can have trouble with "lea", you also ignore hard
> numbers.
>

No. You've just shown that you like to argue. I recall that you
recently, like within the past 24 hours, supplied a patch that
got rid of the time-consuming stack operations in your semaphore
code. Remember, you changed it to pass parameters in registers.

Why would you bother if stack operations are free? The fact is
that you know that even a single extra memory access (i.e., a
stack operation) is costly. You just don't want to admit that
(remember the original premise if this discussion) popping
into an unused register to level the stack, is NOT better than
adding to the stack-pointer or, as another learned engineer
advised, using LEA instead.

I simply wrote some code that showed that poping registers used
more CPU cycles than adding to the stack-pointer, and using
LEA instead of the ADD showed no difference. Of course I
was immediately overwhelmed by responses that the benchmark
was invalid, presumably because it wasn't written by somebody
else.

> Your total focus on a cached memory access as being somehow more expensive
> than anything else going in the CPU pipeline is sad.
>

It's not a total focus. It's just necessary emphasis. Any work
done by your computer, ultimately comes from and goes to memory.
Some is memory-mapped hardware "memory" some is simply RAM.
Managing those memory accesses is very important when it comes
to maximizing the work that your computer can do in a limited
period of time. Wasting memory-access time is something one
should not do if at all possible.

> But hey, I've run out of ways to show you wrong. If you believe the world
> is flat, that's your problem.
>
> 		Linus
>

No, the world is crooked, not flat.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
