Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132138AbRALTxW>; Fri, 12 Jan 2001 14:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132591AbRALTxM>; Fri, 12 Jan 2001 14:53:12 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:27913 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132138AbRALTwz>;
	Fri, 12 Jan 2001 14:52:55 -0500
Date: Fri, 12 Jan 2001 20:52:45 +0100
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010112205245.A26555@unternet.org>
In-Reply-To: <3A5F3BF4.7C5567F8@colorfullife.com> <20010112183314.A24174@unternet.org> <3A5F4428.F3249D2@colorfullife.com> <20010112192500.A25057@unternet.org> <3A5F5538.57F3FDC5@colorfullife.com> <20010112202104.C25675@unternet.org> <3A5F5BFB.69134DB9@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5F5BFB.69134DB9@colorfullife.com>; from manfred@colorfullife.com on Fri, Jan 12, 2001 at 08:33:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 08:33:15PM +0100, Manfred Spraul wrote:
> Frank, the 2.4.0 contains 2 band aids that were added for ne2k smp:
> 
> * From Ingo: focus cpu disabled, in arch/i386/kernel/apic.c
> * From myself: TARGET_CPU = cpu_online_mask, was 0xFF.
> 
> Could you disable both bandaids? I disabled them, no problems so far.

I disabled both (I guess you meant the 'define TARGET_CPUS cpu_online' in
io_apic.c?), and reverted my own patch, added your patch... Now running with
the usual heavy network load, no problems so far... Also made USB produce
interrupts (shares irq with network), no problems...

Could this really be the solution?

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
