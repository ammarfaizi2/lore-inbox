Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263668AbRFKTmV>; Mon, 11 Jun 2001 15:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263669AbRFKTmL>; Mon, 11 Jun 2001 15:42:11 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:4168 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263668AbRFKTl4>; Mon, 11 Jun 2001 15:41:56 -0400
Date: Mon, 11 Jun 2001 21:41:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: softirq bugs in pre2
Message-ID: <20010611214133.W5468@athlon.random>
In-Reply-To: <20010611193703.S5468@athlon.random> <Pine.LNX.4.31.0106111207350.4452-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0106111207350.4452-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jun 11, 2001 at 12:09:03PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2001 at 12:09:03PM -0700, Linus Torvalds wrote:
> The copy-user latency fixes only make sense for out-of-line copies. If
> we're going to have a conditional function call to "schedule()", we do not
> want to inline the dang thing any more - we've just destroyed our register
> set etc anyway.

I think we should override conditional_schedule() with asm, ala
local_bh_enable in pre2, then it should be ok to left the copies inline
(btw I found more bugs in the softirq stuff in pre2, I will keep sorting
it out later today or tomorrow).

Andrea
