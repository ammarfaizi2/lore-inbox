Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269766AbRHEQPy>; Sun, 5 Aug 2001 12:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269972AbRHEQPo>; Sun, 5 Aug 2001 12:15:44 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:61037 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269766AbRHEQPa>; Sun, 5 Aug 2001 12:15:30 -0400
Date: Sun, 5 Aug 2001 18:16:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: alloc_skb cannot be called with GFP_DMA
Message-ID: <20010805181606.F21840@athlon.random>
In-Reply-To: <20010805175334.E21840@athlon.random> <E15TQMy-00081S-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15TQMy-00081S-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Aug 05, 2001 at 05:03:12PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001 at 05:03:12PM +0100, Alan Cox wrote:
> > A fast grep revealed a few buggy network drivers already (of course the
> > bug is going to affect only ISA drivers so it's not a showstopper).
> 
> "It doesnt affect my computer so its not a problem" - humm 

I never said anything like that, with "it's not a showstopper" I only
meant "it doesn't affect 99% of the hardware configurations out there".

> If somoe can add the needed isa dma handling to alloc_skb (or alloc_isa_skb)

alloc_isa_skb will avoid to slowdown alloc_skb so I prefer it compared
to hiding the logic inside alloc_skb.

> I'll go and fix all the drivers up. 

Thanks. With the bugcheck patch I wanted to make _sure_ that somebody
will do that (which is very far from "... so it's not a problem" :).

Andrea
