Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUBYPkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUBYPkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:40:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2689 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261366AbUBYPkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:40:07 -0500
Date: Wed, 25 Feb 2004 10:42:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Grigor Gatchev <grigor@zadnik.org>
cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <Pine.LNX.4.44.0402251647190.17570-100000@lugburz.zadnik.org>
Message-ID: <Pine.LNX.4.53.0402251023330.9271@chaos>
References: <Pine.LNX.4.44.0402251647190.17570-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Grigor Gatchev wrote:

>
> > But the idea that the kernel should exist as a kind of onion,
> > depicted by child college professors in their children's coloring
> > books is wrong. The optimum operating system will always be the
> > one that performs its functions in the most expedient way, not
> > the one that is the "prettiest" or easiest to understand. There
> > can't be any such thing as a "layering violation".
>
> Hm.
>
> I won't agree. In my 25 years of programming, I am yet to see a case whe
> ugly, "write-only" code performed well. And the cases when "pretty"
> code has performed badly were rather rare.
>
> Isolation and layering have already proved themselves a lot. If not so,
> Unix would be dead, and we would be using now Multics or another similar
> OS. Also, Windows would be immesurably superior to any Unix in existence,
> especially in performance...
>

Not correct. Layering has isolated the designer (coder) of a
function from the required understanding of its ultimate goal.
This construct started with the idea of 'objects' wherein
the coder didn't need to understand the underlying goal, only
the immediate logic of the function. The result is, _always_,
bloat where one function simply converts its data to that
required by another. The other function converts its data,
etc. Everybody wants to deal will objects and then can claim
that they have done their work.

Ultimately somebody in the coding food-chain needs to do
actual work, i.e., communicate with the hardware to get
the work done. If you get rid of the layers and layers
of absolute repetitive junk and do the work at hand, you
end up with a lean-and-mean kernel that outperforms
the ones that were written in the "layered" construct.

Early on, I wrote code in assembly. Everybody who wrote
code understood the ultimate goal. Later on, I had to
write in Pascal because it was "understandable" and,
therefore documentable. But ultimately I had to write
drivers in assembly to do the actual work. Then along
came 'C'. I had to write code in 'C'. Ultimately, I
had to do the actual work with drivers or runtime
libraries written in assembly. Then there came C++.
Nobody was able to do any actual work anymore. Instead,
with a coding staff of hundreds, only a few actually
understand what the code does. They make the ultimate
"objects" that talk to the hardware. You could throw
away 90 percent or more of the code, improving its
performance considerably in the process, by getting
rid of the ^$(^##)) layers and directly performing
the required function at the upper-most level.

So don't claim that layering does anything useful except
to create jobs. It is a make-work technique that creates
jobs for inadequate or incompetent programmers.

> > Layering is wrong. However modularizing, although it may
> > have some negative effects, has many redeeming values. It
> > allows for the removal of dead code, code that will never
> > function in a particular system.
>
> I won't agree here, too. Dead code can be removed perfectly well from a
> big kernel, too - maybe even easier. With a modular approach, you may
> exclude certain module from your modules list, but I won't call that
> removal of dead code.
>
> Also, (logical) layering and modularizing do not contradict - they are
> practically independent. I apologize for not being able to see the point
> here.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


