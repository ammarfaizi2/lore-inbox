Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSG2EY1>; Mon, 29 Jul 2002 00:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318017AbSG2EY1>; Mon, 29 Jul 2002 00:24:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25348 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318016AbSG2EY1>; Mon, 29 Jul 2002 00:24:27 -0400
Date: Sun, 28 Jul 2002 21:28:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <3D44C3A9.982C0205@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207282127560.1003-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, Andrew Morton wrote:
>
> I don't think it can happen in 2.4.  In the truncate case,
> the page is taken off the LRU by hand.  If do_flushpage()
> failed then the buffers still have a ref on the page, which
> is undone in shrink_cache(), inside pagemap_lru_lock.
>
> So, probably safe, but way too subtle.

That was by no means "subtle", it was all very much "design".

Just undo the broken patch by Rik, and we should all be home free again.

		Linus

