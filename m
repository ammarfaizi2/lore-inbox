Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276411AbRJGPma>; Sun, 7 Oct 2001 11:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276416AbRJGPmU>; Sun, 7 Oct 2001 11:42:20 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:7698 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S276411AbRJGPmH>; Sun, 7 Oct 2001 11:42:07 -0400
Date: Sun, 7 Oct 2001 17:42:10 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <E15qEfV-0005td-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1011007173411.6774A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes - you can run out of vmalloc space. But you run out of it only when
> > you create too many processes (8192), load too many modules etc. If
> > someone needs to put such heavy load on linux, we can expect that he is
> > not a luser and he knows how to increase size of vmalloc space.
> 
> Not just that - you get fragmentation of it which leads you back to the
> same situation as kmalloc except that with the guard pages you fragment the
> address space more.

So - for example if you have 500 processes, each process 8k stack (plus
one page for vmalloc alignment). Please tell me some alloc/free strategy
that fills up and fragments 64M vmalloc space.

You can't find it.

The difference between memory and vmalloc space is this: you fill up the
whole memory with cache => memory fragments. You don't fill up the whole
vmalloc space with anything => vmalloc space doesn't fragment.

Mikulas

