Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278979AbRJ2E0N>; Sun, 28 Oct 2001 23:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278984AbRJ2E0E>; Sun, 28 Oct 2001 23:26:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42002 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278979AbRJ2EZt>; Sun, 28 Oct 2001 23:25:49 -0500
Date: Sun, 28 Oct 2001 20:24:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <rwhron@earthlink.net>, <linux-kernel@vger.kernel.org>,
        <ltp-list@lists.sourceforge.net>
Subject: Re: VM test on 2.4.14pre3aa2 (compared to 2.4.14pre3aa1)
In-Reply-To: <20011029042938.M1396@athlon.random>
Message-ID: <Pine.LNX.4.33.0110282021290.7925-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Oct 2001, Andrea Arcangeli wrote:
>
> I guess I cheated this time though :), see the _only_ change that I did to
> speedup from 68/69 seconds to exactly 40 seconds:

That's not really cheating - I think it's the right thing to do.

The whole "synchronous wait" thing is for historical reasons, and for VM's
that didn't throttle on their own. I actually think that _not_ waiting is
the right thing, because the new VM throttles when it thinks it needs to,
so other waiting is just going to hurt.

As long as interactive behaviour is fine under load, removing these hacks
is a _good_ thing, not a cheat.

		Linus

