Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263606AbRFKTJi>; Mon, 11 Jun 2001 15:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263607AbRFKTJ2>; Mon, 11 Jun 2001 15:09:28 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:35082 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263606AbRFKTJZ>; Mon, 11 Jun 2001 15:09:25 -0400
Date: Mon, 11 Jun 2001 12:09:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: softirq bugs in pre2
In-Reply-To: <20010611193703.S5468@athlon.random>
Message-ID: <Pine.LNX.4.31.0106111207350.4452-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Jun 2001, Andrea Arcangeli wrote:
>
> Since I mentioned the copy-user latency fixes (even if offtopic with the
> above) this is the URL for trivial merging:

The copy-user latency fixes only make sense for out-of-line copies. If
we're going to have a conditional function call to "schedule()", we do not
want to inline the dang thing any more - we've just destroyed our register
set etc anyway.

		Linus

