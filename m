Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSESCIN>; Sat, 18 May 2002 22:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314094AbSESCIM>; Sat, 18 May 2002 22:08:12 -0400
Received: from slip-202-135-75-36.ca.au.prserv.net ([202.135.75.36]:59018 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314080AbSESCIL>; Sat, 18 May 2002 22:08:11 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
        alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Sat, 18 May 2002 09:14:10 MST."
             <Pine.LNX.4.44.0205180910570.26742-100000@home.transmeta.com> 
Date: Sun, 19 May 2002 12:10:38 +1000
Message-Id: <E179GA4-0004ZT-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0205180910570.26742-100000@home.transmeta.com> you wr
ite:
> 
> 
> On 18 May 2002, Andi Kleen wrote:
> >
> > Are you sure they even exist ?
> 
> Oh, like read() or write() for regular files? Yup, they exist.

Huh?  No, you ask for 2000 bytes into a buffer that can only take 1000
bytes without hitting an unmapped page, returning EFAULT or giving a
SIGSEGV is perfectly acceptable.

As a coder, I'd *really* prefer that to hiding the bug!

There's only one case which really actually cares for a valid reason:
the hack in copying mount options.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
