Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131215AbRANAZo>; Sat, 13 Jan 2001 19:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131216AbRANAZe>; Sat, 13 Jan 2001 19:25:34 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:50182 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S131215AbRANAZW>;
	Sat, 13 Jan 2001 19:25:22 -0500
Date: Sun, 14 Jan 2001 01:23:32 +0100
From: Frank de Lange <frank@unternet.org>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010114012332.B12027@unternet.org>
In-Reply-To: <Pine.LNX.4.10.10101121158050.3010-100000@penguin.transmeta.com> <Pine.LNX.4.30.0101122101370.2576-100000@e2> <20010114001358.A1150@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010114001358.A1150@grobbebol.xs4all.nl>; from roel@grobbebol.xs4all.nl on Sun, Jan 14, 2001 at 12:13:58AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 12:13:58AM +0000, Roeland Th. Jansen wrote:
> On Fri, Jan 12, 2001 at 09:03:49PM +0100, Ingo Molnar wrote:
> > well, some time ago i had an ne2k card in an SMP system as well, and found
> > this very problem. Disabling/enabling focus-cpu appeared to make a
> > difference, but later on i made experiments that show that in both cases
> > the hang happens. I spent a good deal of time trying to fix this problem,
> > but failed - so any fresh ideas are more than welcome.
> 
> for the record. my BP6, non OC, apic smp system with ne2k fails within
> 24 hours here too. if I can be of any help..... (2.4.0. kernel. no
> vmware or opensound)

You can help yourself by applying Manfred's patch to 8390.c (in preference to
my own patch to the same file). This will sove the hanging-network problem. If
your entire box hangs, that's another story which will probably not be fixed by
that patch. You can find the patch in Manfred's posting to the list from Fri
Jan 12 2001 - 14:04:24 EST.

I've been running a patched driver for more than a day now, under heavy network
load, without problems.

Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
