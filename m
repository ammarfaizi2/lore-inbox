Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131531AbRARTqq>; Thu, 18 Jan 2001 14:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135571AbRARTqg>; Thu, 18 Jan 2001 14:46:36 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36878 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135569AbRARTqQ>; Thu, 18 Jan 2001 14:46:16 -0500
Date: Thu, 18 Jan 2001 11:45:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Rick Jones <raj@cup.hp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <20010118203802.D28276@athlon.random>
Message-ID: <Pine.LNX.4.10.10101181144380.18387-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Jan 2001, Andrea Arcangeli wrote:
> 
> I'm all for TCP_CORK but it has the disavantage of two syscalls for doing the
> flush of the outgoing queue to the network. And one of those two syscalls is
> spurious. Certainly it makes perfect sense that the uncork flushes the outgoing
> queue, but I think we should have a way to flush it without exiting the cork-mode.
> I believe most software only needs to SIOCPUSH after sending the data and just
> before waiting the reply.

Sure, I agree. Something like SIOCPUSH would fit very well into the
TCP_CORK mentality.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
