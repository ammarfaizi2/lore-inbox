Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132603AbQL2WWi>; Fri, 29 Dec 2000 17:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132641AbQL2WW2>; Fri, 29 Dec 2000 17:22:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:58124 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132603AbQL2WWL>; Fri, 29 Dec 2000 17:22:11 -0500
Date: Fri, 29 Dec 2000 13:51:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: markhe@veritas.com, ak@suse.de, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
In-Reply-To: <200012292123.NAA05899@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10012291350120.10402-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, David S. Miller wrote:
> 
>      For my development testing, I'm running a _heavily_ hacked
>    kernel.  One of these hacks is to pull the wait_queue_head out of
>    struct page; the waitq-heads are in a separate allocated area of
>    memory, with a waitq-head pointer embedded in the page structure
>    (allocated/initialised in free_area_init_core()).  This gives a
>    page structure of 60bytes, giving me one free double-word to play
>    with (which I'm using as a pointer to a release function).
> 
> Not something like those damn Solaris turnstiles, no please....

If you want to have a release function, please just use "page->mapping",
which gives you much more, including memory pressure indicators etc. Now
_that_ can be useful for doing things like slab caches.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
