Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSHDJ5b>; Sun, 4 Aug 2002 05:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSHDJ5b>; Sun, 4 Aug 2002 05:57:31 -0400
Received: from www.jubileegroup.co.uk ([212.22.195.7]:24841 "EHLO
	www2.jubileegroup.co.uk") by vger.kernel.org with ESMTP
	id <S318139AbSHDJ5a>; Sun, 4 Aug 2002 05:57:30 -0400
Date: Sun, 4 Aug 2002 11:00:48 +0100 (BST)
From: Ged Haywood <ged@www2.jubileegroup.co.uk>
To: Willy Tarreau <willy@w.ods.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: RE:2.4.19 warnings with allnoconfig
In-Reply-To: <20020804081620.GA13316@alpha.home.local>
Message-ID: <Pine.LNX.4.21.0208041045160.6405-100000@www2.jubileegroup.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Sun, 4 Aug 2002, Willy Tarreau wrote:

> It is always bad to ignore the compiler's complaints, because it tells
> you that it may do things wrong when it's not sure about what you want.
> [snip] specially when indentation fools you. Eg, this common mistake :
> 
> 	if (something1)
> 		if (something 2)
> 			do_2();
> 	else
> 		do_not_1();

You are quite right.  Compilations should be SILENT.  How else do you
know nothing's wrong?  I would rewrite (refactor?) the code above as:

  if( something1 )
  {
    if( something2 ) { do_2(); }
  }
  else
  {
    do_not_1();
  }

and yes I use two spaces, not tabs, to indent, so I don't fall off the
page; and yes, I always use the braces, even in a one-liner; and yes,
I put the braces there and not like K&R, so I can see the buggers.
Also I NULL all my pointers immediately after declaring them AND after
using them, and I check they're not NULL before using them, which
prevents loads of segfault type errors when I screw up and...

But in trying to change the world, you're wasting time (and bandwidth :).

73,
Ged.

