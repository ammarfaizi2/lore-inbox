Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287439AbSALUjW>; Sat, 12 Jan 2002 15:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287440AbSALUjP>; Sat, 12 Jan 2002 15:39:15 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:13075 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287439AbSALUjC>; Sat, 12 Jan 2002 15:39:02 -0500
Date: Sat, 12 Jan 2002 12:44:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Robert Love <rml@tech9.net>
cc: timothy.covell@ashavan.org,
        =?ISO-8859-1?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>,
        Ingo Molnar <mingo@elte.hu>, Mike Kravetz <kravetz@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <1010814327.2018.5.camel@phantasy>
Message-ID: <Pine.LNX.4.40.0201121237110.1559-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jan 2002, Robert Love wrote:

> On Fri, 2002-01-11 at 16:46, Timothy Covell wrote:
>
> > But, given the above case, what happens when you have Sendmail on
> > the first CPU and Squid is sharing the second CPU?  This is not optimal
> > either, or am I missing something?
>
> Correct.  I sort of took the "optimal cache use" comment as
> tongue-in-cheek.  If I am mistaken, correct me, but here is my
> perception of the scenario:
>
> 2 CPUs, 3 tasks.  1 task receives 100% of the CPU time on one CPU.  The
> remaining two tasks share the second CPU.  The result is, of three
> evenly prioritized tasks, one receives double as much CPU time as the
> others.
>
> Aside from the cache utilization, this is not really "fair" -- the
> problem is, the current design of load_balance (which is quite good)
> just won't throw the tasks around so readily.  What could be done --
> cleanly -- to make this better?

My opinion is: if it can be solved with no more than 20 lines of code
let's do it, otherwise let's see what kind of catastrophe will happen by
allowing such behavior. Because i've already seen hundreds of lines of
code added to solve corner cases and removed after 3-4 years because
someone realized that maybe such corner cases does not matter more than a
whit.
I'll be happy to be shut down here ...



- Davide


