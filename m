Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVEaRp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVEaRp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVEaRp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:45:28 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:40347 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261164AbVEaRo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:44:28 -0400
Subject: Re: RT patch acceptance
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
In-Reply-To: <20050531171143.GS5413@g5.random>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk>
	 <1117556283.2569.26.camel@localhost.localdomain>
	 <20050531171143.GS5413@g5.random>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 31 May 2005 13:42:59 -0400
Message-Id: <1117561379.2569.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 19:11 +0200, Andrea Arcangeli wrote:
> On Tue, May 31, 2005 at 12:18:03PM -0400, Steven Rostedt wrote:
> > Later, while working at Lockheed, we had WindRiver over and they would
> > only give a small broken down (basically all features removed) OS that
> > Lockheed would be responsible for testing.
> > 
> > When someone mentions Hard-RT, this is what I think about.  These are
> 
> I think testing is the wrong word. The code should be demonstrated to be
> correct, and to do so it must be stripped down and as simple as
> possible. Then the more testing the better to verify it's all right, but
> people shouldn't depend _only_ on huge testing. Probably linux is too
> big anyway for those usages, but certainly one needs a guarantee of
> hard-RT for those usages that preempt-RT sure can't provide (while
> nanokernel/RTAI could at least in theory provide it, assuming rest of
> linux itself has no bugs and no memory corruption/deadlocks leading to a
> full system crash).

How does one demonstrate that something works without a test. You may
call it a "demo", but in reality it is just another test.  It's been
quite some time since I use to work on that, and I never read the
MilSpec myself, I was just told what to do by those that did read it.
But I would still call it testing.  Every requirement must have a way to
prove that it was fulfilled, whether it was by "demo", inspection, or
measurement, I would call all those tests. 

One of the tests that were done was to inspect ever module (or function)
for every code path it took.  This grows exponential with every branch.
Programs were written for each of these modules testing all paths by
sending in the input and seeing if the expected output was returned.
Binary branches had to be tested for all enumerations. "Greater Than",
"Less Than", "Equals" (and variants ">=") was tested for one unit less
than,  equal and one unit greater than.  This was only done this
extensively at the module level, then there were other tedious tests at
the integration level, and system level.  Could you imagine what it
would take to do this with Linux!  Linux is much bigger than that code
that ran the engine of an aircraft, and that testing took ten years!
Not to mention that Linux is a moving target, and the engine control
code was designed for a single purpose and a single type of hardware.

Before I put my hand under that saw, I would want to test it several
times with a hotdog first!

-- Steve

