Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281248AbRKHBfe>; Wed, 7 Nov 2001 20:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281249AbRKHBfZ>; Wed, 7 Nov 2001 20:35:25 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:40978 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S281248AbRKHBfP>; Wed, 7 Nov 2001 20:35:15 -0500
Date: Thu, 8 Nov 2001 10:35:55 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Theodore Tso <tytso@mit.edu>
Cc: phillips@bonn-fries.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Message-Id: <20011108103555.017cb21e.rusty@rustcorp.com.au>
In-Reply-To: <20011106104644.A2495@thunk.org>
In-Reply-To: <20011105033316Z16051-18972+45@humbolt.nl.linux.org>
	<E160sYK-0003WR-00@wagner>
	<20011106104644.A2495@thunk.org>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001 10:46:44 -0500
Theodore Tso <tytso@mit.edu> wrote:

> On Tue, Nov 06, 2001 at 09:48:52AM +1100, Rusty Russell wrote:
> > 
> > What concerns me most is the pain involved in writing a /proc or
> > sysctl interface in the kernel today.  Take kernel/module.c's
> > get_ksyms_list as a typical example: 45 lines of code to perform a
> > very trivial task.  And this code is sitting in your kernel whether
> > proc is enabled or not.  Now, I'm a huge Al Viro fan, but his proposed
> > improvements are in the wrong direction, IMHO.
> 
> I'm all for simplifying the internal kernel interfaces.  What I'm not
> at *all* convinced about is that it's worth it to make serious changes
> to the layout of /proc, /proc/sys, etc.  And the concept of being able
> to very rapidly and easily get at system configuration variables
> without needing to make sure that /proc is mounted is a very, very
> good thing.

As these threads show, this is a big argument, involving:
1) What should the in-kernel interface look like?
2) What should the userspace interface look like?
3) Should there be a sysctl interface overlap?

I'm trying to nail down (1).  Whether there is a new backwards
compatible sysctl() which takes a name instead of a number, and/or
whether the whole thing should be done in userspace, I am not going
to address.

Rusty.
