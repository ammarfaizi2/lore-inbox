Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbRGWQfJ>; Mon, 23 Jul 2001 12:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268288AbRGWQfA>; Mon, 23 Jul 2001 12:35:00 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:23310 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268286AbRGWQej>; Mon, 23 Jul 2001 12:34:39 -0400
Date: Mon, 23 Jul 2001 09:33:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jeff Dike <jdike@karaya.com>, <user-mode-linux-user@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <20010723175635.L822@athlon.random>
Message-ID: <Pine.LNX.4.33.0107230931590.12978-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Mon, 23 Jul 2001, Andrea Arcangeli wrote:
>
> in my tree I did some further cleanup, here the ones that you can
> interested about:

Andrea, please drop the "volatile" from xtime. It's bogus.

There's no reason why gcc couldn't make one or many accesses to that
variable, and volatile is an evil keyword that is badly specified and only
makes the compiler generate worse code without ever fixing any real bugs.

If you need a stable value, use a lock.

		Linus

