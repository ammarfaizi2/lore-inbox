Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbTBXUgB>; Mon, 24 Feb 2003 15:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTBXUgB>; Mon, 24 Feb 2003 15:36:01 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25987 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267430AbTBXUgA>; Mon, 24 Feb 2003 15:36:00 -0500
Date: Mon, 24 Feb 2003 15:49:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <200302242005.VAA04400@post.webmailer.de>
Message-ID: <Pine.LNX.3.95.1030224154227.14911A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Arnd Bergmann wrote:

> Richard B. Johnson wrote:
> 
> > I think you must keep these warnings in! There are many bugs
> > that these uncover uncluding loops that don't terminate correctly
> > but seem to work for "most all" cases. These are the hard-to-find
> > bugs that hit you six months after release.
> 
> This was my change. Obviously the warning is a good idea in general,
> but I don't see the point of scrolling through hundreds of lines
> with the same warning in someone else's code. I actually plan to fix
> these warnings in arch/s390 and drivers/s390 as well as include/
> and make the s390 kernel compile with -Werror, but the rest looks 
> more like a task for the Janitors. Note that before gcc-3.3, 
> -Wsign-compare has not been part of -Wall.
> 

Yep. There are a lot of things, not part of -Wall. To find 'need coffee'
errors, I use:

	-Wall -Werror -Wstrict-prototypes -Wwrite-strings -Wshadow \
	-Wsign-compare -Wno-trigraphs

        plus...
	-fno-builtin -fno-common -fomit-frame-pointer.

I also use -march=1486 so it will boot. Some machines don't like
`cmov` and other stuff the compiler may emit. 


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


