Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbSAFCIh>; Sat, 5 Jan 2002 21:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286931AbSAFCI1>; Sat, 5 Jan 2002 21:08:27 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:42504 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286934AbSAFCIN>; Sat, 5 Jan 2002 21:08:13 -0500
Date: Sat, 5 Jan 2002 18:12:59 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <E16N2oW-00021c-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0201051812080.1607-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Alan Cox wrote:

> > Ingo, you don't need that many queues, 32 are more than sufficent.
> > If you look at the distribution you'll see that it matters ( for
> > interactive feel ) only the very first ( top ) queues, while lower ones
> > can very easily tollerate a FIFO pickup w/out bad feelings.
>
> 64 queues costs a tiny amount more than 32 queues. If you can get it down
> to eight or nine queues with no actual cost (espcially for non realtime queues)
> then it represents a huge win since an 8bit ffz can be done by lookup table
> and that is fast on all processors

It's here that i want to go, but i'd liketo do it gradually :)

unsigned char first_bit[255];




- Davide


