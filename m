Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280663AbRKGEJG>; Tue, 6 Nov 2001 23:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280756AbRKGEI5>; Tue, 6 Nov 2001 23:08:57 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:2190 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S280663AbRKGEIm>;
	Tue, 6 Nov 2001 23:08:42 -0500
Date: Tue, 6 Nov 2001 10:46:44 -0500
From: Theodore Tso <tytso@mit.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Message-ID: <20011106104644.A2495@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011105033316Z16051-18972+45@humbolt.nl.linux.org> <E160sYK-0003WR-00@wagner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E160sYK-0003WR-00@wagner>; from rusty@rustcorp.com.au on Tue, Nov 06, 2001 at 09:48:52AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 09:48:52AM +1100, Rusty Russell wrote:
> 
> What concerns me most is the pain involved in writing a /proc or
> sysctl interface in the kernel today.  Take kernel/module.c's
> get_ksyms_list as a typical example: 45 lines of code to perform a
> very trivial task.  And this code is sitting in your kernel whether
> proc is enabled or not.  Now, I'm a huge Al Viro fan, but his proposed
> improvements are in the wrong direction, IMHO.

I'm all for simplifying the internal kernel interfaces.  What I'm not
at *all* convinced about is that it's worth it to make serious changes
to the layout of /proc, /proc/sys, etc.  And the concept of being able
to very rapidly and easily get at system configuration variables
without needing to make sure that /proc is mounted is a very, very
good thing.  

While sysctl isn't the most compact way of doing things, it *is*
simpler than doing things using a raw /proc interfaces.  If you just
want sysctl to modify a single integer variable, it's basically just a
table entry and a call to register that table with sysctl.  If you
want to do more sophisticated things, then yes, it gets more
complicated faster than it probably should.  

But the bottom line is as far as I'm concerned is:

Baby.  Bathwater.  Let's not throw out the wrong thing....

						- Ted
