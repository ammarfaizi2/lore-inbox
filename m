Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135266AbRASRXk>; Fri, 19 Jan 2001 12:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135501AbRASRXT>; Fri, 19 Jan 2001 12:23:19 -0500
Received: from 13dyn160.delft.casema.net ([212.64.76.160]:29193 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S135266AbRASRXQ>; Fri, 19 Jan 2001 12:23:16 -0500
Message-Id: <200101191723.SAA07826@cave.bitwizard.nl>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101190911130.10218-100000@penguin.transmeta.com>
 from Linus Torvalds at "Jan 19, 2001 09:16:50 am"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Fri, 19 Jan 2001 18:23:06 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > I wrote a driver for a zoran-chipset frame-grabber card. The "natural"
> > way to save a video stream was exactly the way it came out of the
> > card. And the card was structured that you could put on an "mpeg
> > decoder" (or encoder) chip, and you could DMA the stream directly into
> > that chip.
> 
> Ehh..
> 
> And how many of these chips are out on the market?
> 
> Would you agree that it is less than 0.01% of all PC hardware? Like MUCH
> less?

Someone asked me to write a driver for one of these cards. I was
assuming that most of them work like this. And I'm never wrong, you
know... 

> > The way soundcards are commonly programmed, they don't play from their
> > own memory, but from main memory. However, they all can play from
> > their own memory. 
> 
> And how do you synchronize the streams etc? It's a nasty piece of
> business, and direct PCI-PCI streaming is not the answer.
> 
> > > And you wouldn't need a new memory zone - the kernel wouldn't ever touch
> > > the memory anyway, you'd just ioremap() it if you needed to access it
> > > programmatically in addition to the streaming of data off disk.
> > 
> > That's the way things currently work. If you start thinking about it
> > as a NUMA, it may improve the situation for "common users" too. 
> > 
> > A PC is a NUMA machine! We have disk (swap) and main memory. We also
> > have a frame buffer, which doesn't currently fit into our memory
> > architecture.
> 
> Don't be silly. It fints _fine_ in our memory architecture. We map it to
> xfree86, and we're done with it.
> 
> Using the frame buffer for "backing store" for normal  memory is not worth
> it. That's what disks are for. Frame buffers are _way_ too small to be
> interesting as a memory resource.

It's a silly small resource that suddenly becomes usable should the
right infrastructure be in place. It isn't. You're not planning on doing
it soonish. Neither am I. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
