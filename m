Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130320AbQLCPu4>; Sun, 3 Dec 2000 10:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130757AbQLCPuq>; Sun, 3 Dec 2000 10:50:46 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:10275 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130320AbQLCPuh>; Sun, 3 Dec 2000 10:50:37 -0500
Date: Sun, 3 Dec 2000 17:27:43 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: David Ford <david@linux.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Matthew Kirkwood <matthew@hairy.beasts.org>, folkert@vanheusden.com,
        "Theodore Y Ts'o" <tytso@mit.edu>,
        Kernel devel list <linux-kernel@vger.kernel.org>, vpnd@sunsite.auc.dk
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <3A295F27.D356DC91@linux.com>
Message-ID: <Pine.LNX.4.21.0012031726170.13254-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Making /dev/random block if the amount requirements aren't met makes sense
> > to me. If I request x bytes of random stuff, and get less, I probably
> > reread /dev/random. If it's entropy pool is exhausted it makes sense to be
> > to block.
> 
> This is the job of the program accessing /dev/random.  Open it blocking or
> non-blocking and read until you satisfy your read buffer.

Agree, if randomness is guaranteed in that case. I usually bail out in
that case. Time to change that :)

> -d


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
