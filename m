Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316420AbSEWON7>; Thu, 23 May 2002 10:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316717AbSEWON6>; Thu, 23 May 2002 10:13:58 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61191 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316420AbSEWON5>; Thu, 23 May 2002 10:13:57 -0400
Date: Thu, 23 May 2002 10:10:10 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dave McCracken <dmccr@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] POSIX personality
In-Reply-To: <Pine.LNX.4.33.0205211349100.3073-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1020523094611.11249A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002, Linus Torvalds wrote:

> I don't see any reason to start using some fixed-mode semantics without 
> seeing some stronger arguments on exactly why that would be a good idea. 
> We have used up 11 of 24 bits (and more can be made available) over the 
> last five years, and there are no obvious inefficiencies that I can see.

I think the reason which comes to mind is avoiding future problems. By
having a single POSIX mode flag not only does the program not have to know
about setting the "right" other bits today, but if we find that POSIX
behaviour is needed in some other area in the future, the program doesn't
need to be modified and recompiled, because the POSIX behaviour "is in
there" for all things.

Ideally a program could execute some make-Linux-run-POSIX in init, and
have the expected behaviour everywhere without all manner of ifdefs.

I think that's a stronger argument, avoiding future problems is nice, like
wearing Kevlar sox if you shoot yourself in the foot a lot.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

