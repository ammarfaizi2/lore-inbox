Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281880AbRKSCJ3>; Sun, 18 Nov 2001 21:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281878AbRKSCJT>; Sun, 18 Nov 2001 21:09:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37127 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281877AbRKSCJQ>; Sun, 18 Nov 2001 21:09:16 -0500
Date: Sun, 18 Nov 2001 18:04:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
cc: Andrea Arcangeli <andrea@suse.de>, <ehrhardt@mathematik.uni-ulm.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1 
In-Reply-To: <200111181710.fAIHAlCF011794@sleipnir.valparaiso.cl>
Message-ID: <Pine.LNX.4.33.0111181803040.7482-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Nov 2001, Horst von Brand wrote:
> Linus Torvalds <torvalds@transmeta.com> said:
> > And nope, not really. It does use plain stores to page->flags, and I agree
> > that it is ugly, but if the page was locked before calling it, all the
> > stores will be with the PG_lock bit set - and even plain stores _are_
> > documented to be atomic on x86 (and on all other reasonable architectures
> > too).
>
> Even unaligned stores?

Actually, even unaligned stores (which page->flags is NOT) are atomic,
even if Intel strongly discourages them (for performance reasons if no
others) and there tends to be documentation that doesn't guarantee it.

		Linus

