Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154478AbQA3BpU>; Sat, 29 Jan 2000 20:45:20 -0500
Received: by vger.rutgers.edu id <S154429AbQA3BoQ>; Sat, 29 Jan 2000 20:44:16 -0500
Received: from fw.suse.com ([216.88.157.2]:63258 "HELO suse.com") by vger.rutgers.edu with SMTP id <S154537AbQA3Bnk>; Sat, 29 Jan 2000 20:43:40 -0500
Date: Sat, 29 Jan 2000 21:52:11 -0800 (PST)
From: Andre Hedrick <andre@suse.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
In-Reply-To: <200001300006.AAA02084@raistlin.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10001292150500.427-100000@home.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


Russell,

I missed covering your a**..........yes this is a WTF.
Where did you find the break point........It will get fixed.

On Sun, 30 Jan 2000, Russell King wrote:

> Hi,
> 
> I've been looking over the 2.3.41 patch, and have come across a major problem
> area for ARM.
> 
> On ARM, there is no such thing as "dma coherent" memory.  Unfortunately, the
> new PCI code (pci_alloc_consistent) appears to assume that there is a way
> of doing this.
> 
> I have had ideas about ways to do this on the ARM, but it will not be trivial
> changes to the mm layer, and certainly has not been implemented yet.
> 
> This effectively means that I seem to have two options:
> 
> 1. either we loose any hope of IDE DMA for the rest of 2.3 and 2.4, or
> 2. the IDE DMA code gets the dma_cache_* macros added back in
> 
> I would have preferred to have heard about the extent of these changes (and
> that the dma_cache_* macros were going to be removed, along with my comments
> marking them with my initials) before it was submitted.
> 
> For now, I'm adding the dma_cache_* macros back in, and if I don't hear anything,
> I will be re-submitting that code back to Linus.
> 
> (very pissed)
>    _____
>   |_____| ------------------------------------------------- ---+---+-
>   |   |         Russell King        rmk@arm.linux.org.uk      --- ---
>   | | | |   http://www.arm.linux.org.uk/~rmk/aboutme.html    /  /  |
>   | +-+-+                                                     --- -+-
>   /   |               THE developer of ARM Linux              |+| /|\
>  /  | | |                                                     ---  |
>     +-+-+ -------------------------------------------------  /\\\  |
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
The Linux ATA/IDE guy

THE USE OF EMAIL FOR THE TRANSMISSION OF UNSOLICITED COMMERCIAL
MATERIAL IS PROHIBITED UNDER FEDERAL LAW (47 USC 227). Violations may
result in civil penalties and claims of $500.00 PER OCCURRENCE
(47 USC 227[c]).  Commercial spam WILL be forwarded to postmasters.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
