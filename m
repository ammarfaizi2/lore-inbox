Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130251AbQLMT7Q>; Wed, 13 Dec 2000 14:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130315AbQLMT7H>; Wed, 13 Dec 2000 14:59:07 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8718 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130251AbQLMT7A>; Wed, 13 Dec 2000 14:59:00 -0500
Date: Wed, 13 Dec 2000 11:27:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11 - the continuing saga
In-Reply-To: <Pine.Linu.4.10.10012131856130.448-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.10.10012131048430.19635-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Mike Galbraith wrote:
> 
> Not in my test tree.  Same fault, and same trace leading up to it. no

Ok.

It definitely looks like a swapoff() problem.

Have you ever seen the behaviour without running swapoff?

Also, can you re-create it without running swapon() (if it's something
like a lost dirty bit, it should be possible to trigger even without the
swapon, and I'd like to hear if that can happen - if it only happens with
swapon() and you can't trigger it with just a swapoff() it might be a
question of re-using some swap file stuff and delaying the writeout or
whatever).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
