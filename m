Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKVLaH>; Wed, 22 Nov 2000 06:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129520AbQKVL35>; Wed, 22 Nov 2000 06:29:57 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:54758 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129091AbQKVL3q>; Wed, 22 Nov 2000 06:29:46 -0500
From: kumon@flab.fujitsu.co.jp
Date: Wed, 22 Nov 2000 19:59:38 +0900
Message-Id: <200011221059.TAA03907@asami.proc.flab.fujitsu.co.jp>
To: Jens Axboe <axboe@suse.de>
Cc: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org,
        Dave Jones <davej@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
In-Reply-To: <20001121112836.B10007@suse.de>
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp>
	<20001121112836.B10007@suse.de>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
 > I'd be very interested if you could repeat your test with my
 > block patch applied. It has, among other things, a more fair (and
 > faster) insertion.
 > 
 > *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test11/blk-11.bz2

This patch fixes the "DoS" behavior of the current queuing mechanism.
Even if I set the "pass-over" values to very large number (1000000) it
stably runs.
Thank you for your patch.

>From my understanding, passover is an option of the elevator
scheduling to prioritize long waiting requests for improving online
responses.  In that test, passover value setting doesn't affect the
benchmark number, which is probable.

Will the patch is included in the next kernel?


BTW,
The major performance difference between test1 and test2 was caused by
whether the hard_dirty_limit is hit or not.

The current Linux has a lot of difficult to set parameters in
/proc/sys.
 Once a system goes beyond some settable limits, the system behavior
changes so sharp.  Bdf_prm.nrfract in fs/buffer.c is one of the
difficult parameters.  I hope a tool to monitor or set these value.

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
