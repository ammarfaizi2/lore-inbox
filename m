Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSFMCxp>; Wed, 12 Jun 2002 22:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317423AbSFMCxo>; Wed, 12 Jun 2002 22:53:44 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:45518 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317422AbSFMCxn>; Wed, 12 Jun 2002 22:53:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        frankeh@watson.ibm.com
Subject: Re: [PATCH] Futex Asynchronous Interface 
In-Reply-To: Your message of "Wed, 12 Jun 2002 09:52:28 MST."
             <Pine.LNX.4.44.0206120946100.22189-100000@home.transmeta.com> 
Date: Thu, 13 Jun 2002 12:57:51 +1000
Message-Id: <E17IKo3-000341-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206120946100.22189-100000@home.transmeta.com> you wr
ite:
> 
> 
> 
> On Wed, 12 Jun 2002, Peter W=E4chtler wrote:
> >
> > For the uncontended case: their is no blocked process...
> 
> Wrong.
> 
> The process that holds the lock can die _before_ it gets contended.
> 
> When another thread comes in, it now is contended, but the kernel doesn't
> know about anything.

Note also: this is a feature.

I have a little helper program which can grab or release a futex in a
(mmapped) file.  It's great for shell scripts to grab locks.  In this
case the helper exits with the lock held, and a later invocation
releases a lock it never held.

*AND* the lock is persistent across reboots, since it's in a file.
How cool is that!

This is the *third* major thread on this subject, BTW.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
