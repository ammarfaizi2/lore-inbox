Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287449AbSALUsm>; Sat, 12 Jan 2002 15:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287450AbSALUsd>; Sat, 12 Jan 2002 15:48:33 -0500
Received: from svr3.applink.net ([206.50.88.3]:13835 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287449AbSALUsU>;
	Sat, 12 Jan 2002 15:48:20 -0500
Message-Id: <200201122047.g0CKlqSr008087@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Davide Libenzi <davidel@xmailserver.org>, Robert Love <rml@tech9.net>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
Date: Sat, 12 Jan 2002 14:44:02 -0600
X-Mailer: KMail [version 1.3.2]
Cc: timothy.covell@ashavan.org,
        =?iso-8859-1?q?Fran=E7ois=20Cami?= <stilgar2k@wanadoo.fr>,
        Ingo Molnar <mingo@elte.hu>, Mike Kravetz <kravetz@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.40.0201121237110.1559-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0201121237110.1559-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 January 2002 14:44, Davide Libenzi wrote:
> On 12 Jan 2002, Robert Love wrote:
> > On Fri, 2002-01-11 at 16:46, Timothy Covell wrote:
> > > But, given the above case, what happens when you have Sendmail on
> > > the first CPU and Squid is sharing the second CPU?  This is not optimal
> > > either, or am I missing something?
> >
> > Correct.  I sort of took the "optimal cache use" comment as
> > tongue-in-cheek.  If I am mistaken, correct me, but here is my
> > perception of the scenario:
> >
> > 2 CPUs, 3 tasks.  1 task receives 100% of the CPU time on one CPU.  The
> > remaining two tasks share the second CPU.  The result is, of three
> > evenly prioritized tasks, one receives double as much CPU time as the
> > others.
> >
> > Aside from the cache utilization, this is not really "fair" -- the
> > problem is, the current design of load_balance (which is quite good)
> > just won't throw the tasks around so readily.  What could be done --
> > cleanly -- to make this better?
>
> My opinion is: if it can be solved with no more than 20 lines of code
> let's do it, otherwise let's see what kind of catastrophe will happen by
> allowing such behavior. Because i've already seen hundreds of lines of
> code added to solve corner cases and removed after 3-4 years because
> someone realized that maybe such corner cases does not matter more than a
> whit.
> I'll be happy to be shut down here ...
>
>
>
> - Davide

There's always the 90/10 rule about 90% of the work being nescessary to
get out the last 10% of improvements.  It looks like you guys have been
working quite hard at this already and making good progress.   Personally,
I have nothing to offer beyond the ideas of Francois.

-- 
timothy.covell@ashavan.org.
