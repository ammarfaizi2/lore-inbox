Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAXJwS>; Wed, 24 Jan 2001 04:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAXJwI>; Wed, 24 Jan 2001 04:52:08 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:7685 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129742AbRAXJv6>; Wed, 24 Jan 2001 04:51:58 -0500
Date: Wed, 24 Jan 2001 01:51:49 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Russell King <rmk@arm.linux.org.uk>, Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <20010124015149.A14891@twiddle.net>
In-Reply-To: <20010110163158.F19503@athlon.random> <200101102209.f0AM9N803486@flint.arm.linux.org.uk> <20010111005924.L29093@athlon.random> <20010123235115.A14786@twiddle.net> <20010124100240.A4526@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20010124100240.A4526@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 10:02:40AM +0100, Andrea Arcangeli wrote:
> I'd love if you could forbid it to compile.

Problem is that there's stuff like this all over the place.  Plus,
just because something is undefined by the standard doesn't mean
it's not useful -- it's not possible to write either a kernel or
libc without breaking some rules.

So any useful compile-time restrictions we could make is if the
static expression was not computable (perhaps due to being a word
addressed machine), or if we could somehow magically divine that
the store would in fact go wrong at runtime.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
