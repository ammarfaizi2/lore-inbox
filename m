Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287177AbSALQbB>; Sat, 12 Jan 2002 11:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287158AbSALQav>; Sat, 12 Jan 2002 11:30:51 -0500
Received: from svr3.applink.net ([206.50.88.3]:58632 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287173AbSALQal>;
	Sat, 12 Jan 2002 11:30:41 -0500
Message-Id: <200201121630.g0CGU5Sr006966@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Robert Love <rml@tech9.net>, timothy.covell@ashavan.org
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
Date: Sat, 12 Jan 2002 10:26:13 -0600
X-Mailer: KMail [version 1.3.2]
Cc: =?iso-8859-1?q?Fran=E7ois=20Cami?= <stilgar2k@wanadoo.fr>, mingo@elte.hu,
        Mike Kravetz <kravetz@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0201110142160.12174-100000@localhost.localdomain> <200201112150.g0BLoESr004177@svr3.applink.net> <1010814327.2018.5.camel@phantasy>
In-Reply-To: <1010814327.2018.5.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 January 2002 23:45, Robert Love wrote:
> On Fri, 2002-01-11 at 16:46, Timothy Covell wrote:
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
>
> 	Robert Love


That's the million dollar question.   I was just concerned that if that
were to be implemented in a production kernel, then lots of admins
would be confused.

-- 
timothy.covell@ashavan.org.
