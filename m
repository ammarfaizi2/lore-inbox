Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280467AbRKSVbi>; Mon, 19 Nov 2001 16:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280727AbRKSVb2>; Mon, 19 Nov 2001 16:31:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53508 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280467AbRKSVbQ>; Mon, 19 Nov 2001 16:31:16 -0500
Date: Mon, 19 Nov 2001 13:26:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Simon Kirby <sim@netnation.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <Pine.LNX.4.21.0111191755460.7451-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0111191325040.8600-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Marcelo Tosatti wrote:
>
> We ended up talking about the possibility of a reschedule (IRQ) happening
> before after the "spin_unlock(pagecache_lock)" but before the
> "lru_cache_add()".

So?

The worst that happens is that the page is not on the LRU list, which just
means that it won't be free'd until we add it (which we will do when the
lru_cache_add() resumes..

		Linus

