Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbTCGVpK>; Fri, 7 Mar 2003 16:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbTCGVpI>; Fri, 7 Mar 2003 16:45:08 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:54021 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261801AbTCGVpG>; Fri, 7 Mar 2003 16:45:06 -0500
Date: Fri, 7 Mar 2003 22:55:28 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <Pine.LNX.4.44.0303071046440.1606-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
References: <Pine.LNX.4.44.0303071046440.1606-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Mar 2003, Linus Torvalds wrote:

> > Could you please repeat your reasoning? I must have missed something.
> 
> The reasoning is very simple:
> 
>  - klibc is small. It would be pointless to make it a shared library, 
>    because the infrastructure to do so and the indirection required would
>    likely be bigger than klibc itself (unless klibc is eventually bloated
>    up)
> 
>  - klibc is potentially useful outside just standard kernel initrd images,
>    and in fact for development it is nice to use it that way.
> 
> Put the two together, and the GPL really doesn't look like a very good 
> license for klibc. Yeah, you can disagree about what the actual exceptions 
> are, but clearly there has to be _some_ exception to the license.

This really doesn't speak against the GPL, if we do something similiar as 
libgcc. This gives users still enough freedom to whatever they want, e.g. 
they can implement their own function to override the klibc one. Using GPL 
would encourage people to contribute changes back. If they are not willing 
to do this, they should have enough resources to reimplement the needed 
functionality, anyway.

> Also, since the kernel GPL thing doesn't taint user space apps (very much 
> documented since day 1), there really isn't any _reason_ to use the GPL in 
> the first place. klibc wouldn't ever get linked into the kernel, only into 
> apps.
> 
> As such, and since Peter is the main author, I don't see your argument, 
> Roman.

Well, there wasn't much to argue against yet so far :), I'm still trying 
to find the reason for Peters decision.
If klibc becomes part of kernel, Peter is not the only author anymore and 
people would be forced to contribute to a non GPL project (e.g. if I 
wanted to get it working on m68k), which is part of a GPL project.
I smell some serious trouble ahead and that's why I'd really like to know 
a good reason not to use the GPL (or a variant of it). This should 
really carefully thought about now and not when it's too late.

bye, Roman

