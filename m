Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSFFXS0>; Thu, 6 Jun 2002 19:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSFFXSZ>; Thu, 6 Jun 2002 19:18:25 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:16799 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S312619AbSFFXSY>; Thu, 6 Jun 2002 19:18:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Futex Asynchronous Interface 
In-Reply-To: Your message of "Thu, 06 Jun 2002 09:36:23 MST."
             <Pine.LNX.4.44.0206060930240.5920-100000@home.transmeta.com> 
Date: Fri, 07 Jun 2002 09:21:33 +1000
Message-Id: <E17G6ZR-0000F2-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206060930240.5920-100000@home.transmeta.com> you wri
te:
> Do we have major and minor numbers for sockets and populate /dev
> with them? No. And as a result, there has _never_ been any sysadmin
> problems with either.

Ummm... you don't do much network programming, do you Linus?  Don't
confuse familiarity with fondness: the socket API is *not* a good
model to copy.

> You already have to have a system call to bind the particular fd to the
> futex _anyway_, so do the only sane thing, and allocate the fd _there_,
> and get rid of that stupid and horrible /dev/futed which only buys you
> pain, system administration, extra code, and a black star for being
> stupid.

Yet another special way to create a special fd?  Hmm...

That might be better than what I proposed, but it's not the epitomy of
taste either.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
