Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283949AbRLAGbz>; Sat, 1 Dec 2001 01:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283970AbRLAGbo>; Sat, 1 Dec 2001 01:31:44 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:20778 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S283969AbRLAGbe>; Sat, 1 Dec 2001 01:31:34 -0500
Message-Id: <4.3.2.7.2.20011130215624.00c03b30@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 30 Nov 2001 22:31:24 -0800
To: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>
From: Stephen Satchell <satch@concentric.net>
Subject: Re: Coding style - a non-issue
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011130193047.H19152@work.bitmover.com>
In-Reply-To: <Pine.LNX.4.33.0111301907010.1296-100000@penguin.transmeta.com>
 <20011130200239.A28131@hq2>
 <Pine.LNX.4.33.0111301907010.1296-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc list trimmed]

At 07:30 PM 11/30/01 -0800, Larry McVoy wrote:
>Yeah, right, Linus.  We should all go home and turn loose the monkeys and
>let them pound on the keyboard.  They'll just as good a job, in fact, by
>your reasoning they'll get there faster, they aren't so likely to waste
>time trying to design it.

You are confusing the production of Shakespeare with the production of good 
OS code.

The high-level design aspect is that there is a problem to be solved or a 
feature to be provided.  That represents a goal.  Some goals are good and 
some goals are bad.  In many cases, you learn which when you actually do 
the code to implement the goal, and determine whether it helps, hinders, or 
just bloats the OS.

The lower-level design aspect is planning how to achieve the 
goal.  Implementation of the lower-level design in code to achieve the goal 
can contain flaws, flaws that don't appear on paper but raise ugly warts 
when you actually try the implementation out.  In this sense, this is like 
a mutation to achieve a specific effect -- blue eyes, say -- that has a 
disastrous side effect -- it causes the heart to have a single chamber 
instead of four.

This assumes that your, um, mutation even lets the organism live.  Many 
don't.  We call it debugging.


>I can't believe the crap you are spewing on this one and I don't think you
>do either.  If you do, you need a break.  I'm all for letting people explore,
>let software evolve, that's all good.  But somebody needs to keep an eye on
>it.

I don't know you, so I don't know how long you have been in the 
industry.  I've watched Unix evolve from the beginning.  AT&T streams 
versus Berkeley sockets was a wonderful war, and we are all for the better 
for the experimentation because we got the best of both -- especially as I 
was involved in ARPAnet in the beginning and saw the influence of what 
turned into TCP/IP in both environments.  We have different styles of 
system initialization, with some being better for manual management and 
some being better for package management -- and we have both living in the 
world today.  The development of X-terminals was fun, too, to try to 
divorce the requirements for a screen from the system that feeds it, and 
yet today the two different processes run together in a single box without 
too much problem.

These were the products of evolution, of system designers trying to meet a 
need, and the process of getting there was painful and left a lot of 
corpses behind it -- piles of dead code, for sure, but also dead companies 
and burned-out development people.  That's part of the business, 
particularly in the commercial world.

"But someone has to keep an eye on it."  Very true.  After all, in this 
process of natural selection, how do we weed out the mutations that don't 
work?  In the Linux development environment, we have several levels of 
weeding going on.  First, there is peer testing -- people downloading 
patches and trying out new things, which weeds out the worst of the 
mutations.  Then, there are the maintainers who sit in judgement as the 
patches roll by, picking out the deformed ones bodily and making sure that 
two patches that change the same code play nicely with each other.  We then 
have the pre-releases, which for the 2.4 tree were patch-inspected and 
maintained by Linux and by Alan Cox, which people can download and try on 
playpen systems with applications to see if anything subtly nasty crept in 
-- this weeds out a few of the mutations that harm the organism but doesn't 
kill it outright.  Finally, we have a production release into which people 
throw all the varied and wacky applications -- and sometimes an ugly (like 
the VM problem) finally is exposed to the light.

Interestingly, you see a similar development process at commercial software 
vendors and with the successful Open Source projects.  Some of the details 
differ (especially the details on the review process) but the overall 
process is similar.  Why?  It works.

I suggest you check out this site http://www.swebok.org/ and specifically 
download this document 
http://www.swebok.org/documents/stoneman095/Trial_Version_0_95.pdf AND READ 
IT before responding further.  While the Software Engineering Body Of 
Knowledge does not use the exact concepts that Linus used in describing how 
things are done, you will find interesting correlations between what is 
described by this document and the idea that you have called "crap."

Pay particular attention to the section on Validation and Verification.

Stephen Satchell

