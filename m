Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267456AbTBDWEl>; Tue, 4 Feb 2003 17:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbTBDWEl>; Tue, 4 Feb 2003 17:04:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11537 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267456AbTBDWEk>; Tue, 4 Feb 2003 17:04:40 -0500
Date: Tue, 4 Feb 2003 14:11:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
In-Reply-To: <200302042154.h14LsYlQ003240@darkstar.example.net>
Message-ID: <Pine.LNX.4.44.0302041405500.2638-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Feb 2003, John Bradford wrote:
> > I'd love to see a small - and fast - C compiler, and I'd be willing to
> > make kernel changes to make it work with it.  
> 
> How IA-32 centric would your prefered compiler choice be?  In other
> words, if a small and fast C compiler turns up, which lacks support
> for some currently ported to architectures, are you likely to
> encourage kernel changes which will make it difficult for the other
> architectures that have to stay with GCC to keep up?

I don't think being architecture-specific is necessarily a bad thing in 
compilers, although most compiler writers obviously try to avoid it.

The kernel shouldn't really care: it does want to have a compiler with
support for inline functions, but other than that it's fairly close to
ANSI C.

Yes, I know we use a _lot_ of gcc extensions (inline asms, variadic macros
etc), but that's at least partly because there simply aren't any really
viable alternatives to gcc, so we've had no incentives to abstract any of
that out.

So the gcc'isms aren't really fundamental per se. Although, quite frankly,
even inline asms are pretty much a "standard" thing for any reasonable C
compiler (since C is often used for things that really want it), and the
main issue tends to be the exact syntax rather than anything else. So I
don't think I'd like to use a compiler that is _so_ limited that it
doesn't have some support for something like that. I certainly would 
refuse to use a C compiler that didn't support inline functions.

		Linus

