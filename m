Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280059AbRKSXIa>; Mon, 19 Nov 2001 18:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280410AbRKSXIU>; Mon, 19 Nov 2001 18:08:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3337 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280388AbRKSXIM>; Mon, 19 Nov 2001 18:08:12 -0500
Date: Mon, 19 Nov 2001 15:03:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@marcelothewonderpenguin.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Simon Kirby <sim@netnation.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <Pine.LNX.4.33L.0111192056310.4079-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0111191501080.8727-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Rik van Riel wrote:
>
> Oh dear, that's an interesting case, too.
>
> __add_to_page_cache() blindly sets the PG_locked bit, but
> it's possible for other functions to acquire the page lock
> before that.

No. The page is either already locked (add_to_swap_cache()), or
exclusively owned by us..

At least that's how it is _supposed_ to be.

		Linus

