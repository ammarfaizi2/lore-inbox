Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132296AbRADBYN>; Wed, 3 Jan 2001 20:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132312AbRADBYB>; Wed, 3 Jan 2001 20:24:01 -0500
Received: from zeus.kernel.org ([209.10.41.242]:15631 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132349AbRADBXp>;
	Wed, 3 Jan 2001 20:23:45 -0500
Date: Thu, 4 Jan 2001 01:41:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Cc: linux-kernel@vger.kernel.org, linux-parport@torque.net,
        tim@cyberelk.demon.co.uk
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010104014115.C6256@athlon.random>
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010103201344.A3203@athlon.random> <m2hf3gz6yc.fsf@ppro.localdomain> <20010103223504.L32185@athlon.random> <m266jww55q.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m266jww55q.fsf@ppro.localdomain>; from peter.osterlund@mailbox.swipnet.se on Thu, Jan 04, 2001 at 01:08:01AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 01:08:01AM +0100, Peter Osterlund wrote:
> What do you think about the following patch? It also works for all the
> tests mentioned in my previous message.

I'm worried somebody needed to disable LP_CAREFUL to print, probably it's not a
big deal to keep it. About the lp_wait_ready that's what I had in mind with the
"rework" thing and it looks fine. However parport_write can still could silenty
discard data, but maybe it can't notice errors with some handshake. I didn't
checked the details of the DMA based handshake so Tim needs to comment if
this can be considered a final/right fix (I hope it's not ;).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
