Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267829AbRGRE4b>; Wed, 18 Jul 2001 00:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267830AbRGRE4W>; Wed, 18 Jul 2001 00:56:22 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:42511 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267829AbRGRE4H>; Wed, 18 Jul 2001 00:56:07 -0400
Date: Tue, 17 Jul 2001 21:55:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.21.0107172333250.7990-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107172152300.1437-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jul 2001, Marcelo Tosatti wrote:
>
> > A single-zone parameter just looks fundamentally broken.
>
> The "zone" parameter passed to swap_out() means "don't unmap pte's mapping
> to pages belonging to not-under-shortage zones". It can (and it should) be
> replaced by a "zone_specific" parameter.

Ahh.

In fact, it should be replaced by a single bit.

Passing in a "zone *" and then using it purely as a boolean makes no
sense.

But that still makes me ask: why do you have that (misnamed, and
mis-typed) boolean there in the first place? Why not just unconditionally
have the "zone_shortage(page->zone)"?

		Linus

