Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278837AbRJaB0A>; Tue, 30 Oct 2001 20:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278841AbRJaBZu>; Tue, 30 Oct 2001 20:25:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15109 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278837AbRJaBZi>; Tue, 30 Oct 2001 20:25:38 -0500
Date: Tue, 30 Oct 2001 17:23:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Udo A. Steinberg" <reality@delusion.de>
cc: <airlied@csn.ul.ie>, <linux-kernel@vger.kernel.org>
Subject: Re: oops on 2.4.13-pre5 in prune_dcache
In-Reply-To: <3BDF51BE.4450888F@delusion.de>
Message-ID: <Pine.LNX.4.33.0110301720380.19263-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Oct 2001, Udo A. Steinberg wrote:
>
> For what it's worth - I've had a very similar oops ages ago. Back then it
> was blamed on bad RAM, but ever since then I've run numerous memtest's
> over it without finding anything and never had any problems later either.
>
> See here:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0101.0/0303.html

Indeed. Same exact thing, different bit.

It could easily be a wild pointer corruption - single-bit errors in RAM
are not entirely uncommon (and as Al points out, they usually end up
showing up in things like the dcache which can have long lists that are
traversed fairly infrequently).

But blaming the thing on bad RAM is not a good strategy if there are many
of these reports. I'd love to see more of a pattern, though, because
without a pattern there is nothing to really start from..

The pattern might be something as simple as "we're both using minixfs"
or whatever.

		Linus

