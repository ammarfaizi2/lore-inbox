Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWAJBul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWAJBul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 20:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWAJBuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 20:50:12 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:4787 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932138AbWAJBuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 20:50:10 -0500
Date: Mon, 9 Jan 2006 20:49:35 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: George Anzinger <george@mvista.com>
cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RT] make hrtimer_nanosleep return immediately if time
 has passed
In-Reply-To: <43C30FB9.1000609@mvista.com>
Message-ID: <Pine.LNX.4.58.0601092042260.11138@gandalf.stny.rr.com>
References: <1136557086.12468.138.camel@localhost.localdomain> 
 <43BEEEED.9040308@mvista.com> <1136588597.12468.162.camel@localhost.localdomain>
 <43C30FB9.1000609@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Jan 2006, George Anzinger wrote:
> Steven Rostedt wrote:
>
> Uh... I have been wondering about the "mode" thing, thinking "flags" might be
> better.  And allowing, say, a "return if elapsed" flag as well as the ABS
> flag.  Then all you would need to do is to add the "return if elapsed" flag
> to the nanosleep calls.  I have other reasons for wanting to expand the
> "mode" to more that two states... but, even with out that, I think the result
> would be a) less code, and b) easier to follow and understand.  I just have
> trouble pushing a word on the stack to make a call and then use only one bit
> of it when it could be combined...

And I perfectly agree with you :)

The problem is that the hrtimes is not my code, and I don't like doing
too many changes in code that I don't understand the consequences of. As
you showed me earlier, that the previous change broke the posix_timers.
So I really only did the bare minimum to fix what I considered a bug, and
let Thomas, John, Ingo or yourself do a proper fix.  Someone that
understands the timers better than I do.

Currently, it seems those people are too busy, and I just wanted a quick
fix.  I personally didn't like the patch, but my nose is stuck more into
the scheduling, memory and Ingo's rt_mutex now to spend time understanding
all the timer code. ;)

>
> Never the less, the following code looks like is does the right thing.
>

This was all I asked for.

Thanks,

-- Steve

