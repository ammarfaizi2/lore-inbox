Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316962AbSFKJKy>; Tue, 11 Jun 2002 05:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316963AbSFKJKx>; Tue, 11 Jun 2002 05:10:53 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:54979 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316962AbSFKJKt>; Tue, 11 Jun 2002 05:10:49 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dent@cosy.sbg.ac.at, adilger@clusterfs.com, da-x@gmx.net,
        patch@luckynet.dynu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 - list.h cleanup 
In-Reply-To: Your message of "Tue, 11 Jun 2002 01:33:54 MST."
             <Pine.LNX.4.44.0206110128130.1987-100000@home.transmeta.com> 
Date: Tue, 11 Jun 2002 19:14:51 +1000
Message-Id: <E17Hhjo-0007rM-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206110128130.1987-100000@home.transmeta.com> you wri
te:
> 
> 
> On Tue, 11 Jun 2002, Rusty Russell wrote:
> >
> > Worst sin is that you can't predeclare typedefs.  For many uses (not the
> > list macros of course):
> > 	struct xx;
> > is sufficient and avoids the #include hell,
> 
> True.
> 
> However, that only works for function declarations.

Our headers basically consist of:

1) Macros
2) Structure declarations
3) Function declarations
4) Inline functions

The number of structures and functions which need only "struct xxx *"
is very high: removing typedefs is something about with ~zero pain
(unlike dropping the sometimes-dubious loveaffair with inlines).

Rusty.
PS.  I blame Ingo: list_t indeed!
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
