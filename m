Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132665AbRALUr2>; Fri, 12 Jan 2001 15:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132444AbRALUrR>; Fri, 12 Jan 2001 15:47:17 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:7180 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132975AbRALUrC>;
	Fri, 12 Jan 2001 15:47:02 -0500
Date: Fri, 12 Jan 2001 21:46:42 +0100
From: Frank de Lange <frank@unternet.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
Message-ID: <20010112214642.A27809@unternet.org>
In-Reply-To: <20010112213555.F26555@unternet.org> <Pine.LNX.4.30.0101122136180.2772-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101122136180.2772-100000@e2>; from mingo@elte.hu on Fri, Jan 12, 2001 at 09:37:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:37:24PM +0100, Ingo Molnar wrote:
> okay - i just wanted to hear a definitive word from you that this fixes
> your problem, because this is what we'll have to do as a final solution.
> (barring any other solution.)

Now running with this config:

PATCHED 8390.c (using irq_safe spinlocks instead of disable_irq)
PATCHED apic.c (focus cpu ENABLED)
STOCK io_apic.c

No problems under heavy network load.

Gentleman, this (the patch to 8390.c) seems to fix the problem.

Cheers//Frank

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
