Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSBFQRj>; Wed, 6 Feb 2002 11:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289240AbSBFQR3>; Wed, 6 Feb 2002 11:17:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62468 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288967AbSBFQRK>; Wed, 6 Feb 2002 11:17:10 -0500
Date: Wed, 6 Feb 2002 11:16:15 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Robert Love <rml@tech9.net>
cc: Roland Dreier <roland@topspincom.com>, linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <1012951046.1064.123.camel@phantasy>
Message-ID: <Pine.LNX.3.96.1020206105208.7298B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Feb 2002, Robert Love wrote:

> On Tue, 2002-02-05 at 18:02, Bill Davidsen wrote:
> 
> > You seem to equate root space with user space, which is a kernel way of
> > looking at things, particularly if you haven't been noting all the various
> > hacker attacks lately. Just because it is possible to run in user space
> > doesn't mean it's desirable to do so, and many sites don't really want
> > things running as root so they can feed other things to the kernel.
> > 
> > The assumption that power users will know how to fix it and other users
> > won't notice they have no entropy isn't all that appealing to me, I want
> > Linux to be as easy to do right as the competition.
> 
> It is certainly desirable to run as much as feasibly possible in
> userspace.  The only exception of things that could be handled in
> userspace but are allowed to live in kernel space would be performance
> critical and stable items (say, TCP/IP).

  Given that there is graphics stuff in there, and web server stuff, I
would say that having the system hang waiting for entropy is a performance
issue. And lack of it is a security issue.
 
> No one said the rngd has to run as root.  For example, run it as nobody
> in a random group and give /dev/random write privileges to the random
> group.

  So a functional /dev/random would be a feature of power users installing
fixes, as opposed to the kernel using the available hardware? And having
one or more extra user space daemons crapping up the system doesn't seem
an issue?
 
> If userspace equates to insecure, and we stick things in the kernel for
> that reason, we are beyond help ...

  Not all Linux users are hackers, and depending on users to know their
hardware, find, build, install, and configure something, change ownership
of a device without messing it up, and understand that not doing so is
both a performance and security issue... seems either optimistic or just
unconcerned with the users. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

