Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSG1S43>; Sun, 28 Jul 2002 14:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317278AbSG1S42>; Sun, 28 Jul 2002 14:56:28 -0400
Received: from waste.org ([209.173.204.2]:14229 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317261AbSG1S41>;
	Sun, 28 Jul 2002 14:56:27 -0400
Date: Sun, 28 Jul 2002 13:59:12 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] automatic initcalls
In-Reply-To: <Pine.LNX.4.44.0207272145050.6125-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207281223570.17906-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002, Linus Torvalds wrote:

> On Sat, 27 Jul 2002, Jeff Garzik wrote:
> >
> > I've always preferred a system where one simply lists dependencies [as
> > you describe above], and some program actually does the hard work of
> > chasing down all the initcall dependency checking and ordering.
> >
> > Linus has traditionally poo-pooed this so I haven't put any work towards
> > it...
>
> I don't hate the notion, but at the same time every time it comes up I
> feel that there are reasonably simple ways to just avoid the ordering
> problems.

The 'simple ways' are only simpler because they're taking advantage of
pre-existing (and undocumented) implicit ordering. The explicit
dependencies are probably less complex on the whole as it lets you take
out a ton of per-subsystem conditional cruft and replace it with a couple
lines of dependency info.

Given that sizeof(dependency info)==sizeof(missing documentation of
dependencies), it's clear that sizeof(dependency info + support + script)
< sizeof(current ordering code + conditional cruft + missing
documentation).

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

