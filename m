Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129803AbQLNE2i>; Wed, 13 Dec 2000 23:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130340AbQLNE2S>; Wed, 13 Dec 2000 23:28:18 -0500
Received: from www.wen-online.de ([212.223.88.39]:51467 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129803AbQLNE2H>;
	Wed, 13 Dec 2000 23:28:07 -0500
Date: Thu, 14 Dec 2000 04:57:35 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11 - the continuing saga
In-Reply-To: <Pine.LNX.4.10.10012131048430.19635-100000@penguin.transmeta.com>
Message-ID: <Pine.Linu.4.10.10012140449530.878-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Linus Torvalds wrote:

> On Wed, 13 Dec 2000, Mike Galbraith wrote:
> > 
> > Not in my test tree.  Same fault, and same trace leading up to it. no
> 
> Ok.
> 
> It definitely looks like a swapoff() problem.
> 
> Have you ever seen the behaviour without running swapoff?

No.

> Also, can you re-create it without running swapon() (if it's something
> like a lost dirty bit, it should be possible to trigger even without the
> swapon, and I'd like to hear if that can happen - if it only happens with
> swapon() and you can't trigger it with just a swapoff() it might be a
> question of re-using some swap file stuff and delaying the writeout or
> whatever).

I'll try loading up swap, swapoff and then doing jobs that fit in ram.

(hmm.. what about inactive_clean list when you do swapoff.. might there
be pages sitting there that are [were] swap cache? reclaim_page=kaboom?)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
