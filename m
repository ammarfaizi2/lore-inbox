Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSERPoN>; Sat, 18 May 2002 11:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313174AbSERPoM>; Sat, 18 May 2002 11:44:12 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:25094 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313113AbSERPoL>; Sat, 18 May 2002 11:44:11 -0400
Date: Sat, 18 May 2002 17:44:08 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.16
Message-ID: <20020518154408.GB11424@louise.pinerecords.com>
In-Reply-To: <Pine.LNX.4.33.0205180051100.3170-100000@penguin.transmeta.com> <20020518092121.A30509@flint.arm.linux.org.uk> <20020518092121.A30509@flint.arm.linux.org.uk> <20020518095125.GC10134@louise.pinerecords.com> <200205181128.OAA26251@infa.abo.fi> <20020518153856.GA8171@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc4-ext3-0.0.7a SMP (up 2 days, 8:53)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I guess it still is "$_ =~ s/\[?PATCH\]?\s*//i;", which means
> > that it still is broken. There certainly are several solutions,
> > what do people think of "s/\[?[^\]]*PATCH\]?\W*//i;" ?
> > (Maybe a ^ at the beginning?) 
> 
> Don't guess, look:
> 
>     # kill "PATCH" tag
>     s/^\s*\[PATCH\]//;
>     s/^\s*PATCH//;
>     s/^\s*[-:]+\s*//;
>     # strip trailing colon
>     s/:\s*$//;
>     # kill leading and trailing whitespace for consistent indentation
>     s/^\s+//; s/\s+$//;
> 
> So it should not harm "[ARM PATCH]".
> 
> What we would want is only remove the tag when we have symmetric square
> brackets. What we also want is simplicity to allow for easy maintenance
> and, last but not least, simple, anchored regexps for speed.

Good.
Could you repost the latest version *in plaintext* please?


T.
