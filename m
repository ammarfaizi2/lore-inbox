Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132653AbRALU1r>; Fri, 12 Jan 2001 15:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRALU1i>; Fri, 12 Jan 2001 15:27:38 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:12811 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132653AbRALU1b>;
	Fri, 12 Jan 2001 15:27:31 -0500
Date: Fri, 12 Jan 2001 21:26:46 +0100
From: Frank de Lange <frank@unternet.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
Message-ID: <20010112212646.D26555@unternet.org>
In-Reply-To: <20010112211638.C26555@unternet.org> <Pine.LNX.4.30.0101122117540.2772-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101122117540.2772-100000@e2>; from mingo@elte.hu on Fri, Jan 12, 2001 at 09:19:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:19:53PM +0100, Ingo Molnar wrote:
> > In addition, I patched apic.c (focus cpu enabled)
> > In addition, I patched io_apic ((TARGET_CPUS 0xff)
> 
> please try it with the focus CPU enabling change (we want to enable that
> feature, i only disabled it due to the stuck-ne2k bug), but with
> TARGET_CPUS set to cpu_online_mask. (this later is needed for certain
> crappy BIOSes.)

WITH or WITHOUT the changed 8390 driver? I can already give you the results for
running WITH the changed driver: it works. I have not yet tried it WITHOUT the
changed 8390 driver (so that would be stock 8390, patched apic.c, stock
io_apic.c). Please let me know which you want...

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
