Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315048AbSEUQGJ>; Tue, 21 May 2002 12:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315155AbSEUQGJ>; Tue, 21 May 2002 12:06:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63498 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315048AbSEUQGH>; Tue, 21 May 2002 12:06:07 -0400
Date: Tue, 21 May 2002 09:06:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.21.0205211544320.23394-100000@serv>
Message-ID: <Pine.LNX.4.44.0205210904440.2249-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 May 2002, Roman Zippel wrote:
> On Mon, 20 May 2002, Linus Torvalds wrote:
>
> > And yet more TLB shootdown stuff.
>
> I'm a bit puzzled, how you want to do proper rss accounting, you put now a
> "tlb->freed++;" into zap_pte_range(). mmu_gather_t is supposed to be an
> opaque type and this access violates this.

I don't think there is any validity any more in the "opaque type" comment,
and I'd rather expose the fact that it _has_ to have the rss computations
inside of it than have more made-up interfaces to hide it.

The fact is, the rss cannot be computed anywhere else any more, so why
play games about it?

		Linus

