Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268308AbRGWReO>; Mon, 23 Jul 2001 13:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268309AbRGWReE>; Mon, 23 Jul 2001 13:34:04 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:10769 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268308AbRGWRdt>; Mon, 23 Jul 2001 13:33:49 -0400
Date: Mon, 23 Jul 2001 10:32:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jeff Dike <jdike@karaya.com>, <user-mode-linux-user@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <20010723184528.R822@athlon.random>
Message-ID: <Pine.LNX.4.33.0107231031380.13231-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Mon, 23 Jul 2001, Andrea Arcangeli wrote:
>
> it's the other way around, it's needed and gcc trapped a kernel bug.

No it's not.

> If the contents of memory not declared volatile changes under GCC (like
> it can happen right now for xtime since it's declared non volatile), gcc
> has the full rights to crash the kernel at runtime.

Absolutely not.

If we care abotu the thing always having the same value, we HAVE to use a
lock. "volatile" is not the answer.

Show me a place where we care.

		Linus

