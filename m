Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132857AbRALUgr>; Fri, 12 Jan 2001 15:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132966AbRALUgh>; Fri, 12 Jan 2001 15:36:37 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:42251 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132857AbRALUgY>;
	Fri, 12 Jan 2001 15:36:24 -0500
Date: Fri, 12 Jan 2001 21:35:55 +0100
From: Frank de Lange <frank@unternet.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
Message-ID: <20010112213555.F26555@unternet.org>
In-Reply-To: <20010112212646.D26555@unternet.org> <Pine.LNX.4.30.0101122130310.2772-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101122130310.2772-100000@e2>; from mingo@elte.hu on Fri, Jan 12, 2001 at 09:31:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:31:15PM +0100, Ingo Molnar wrote:
> 
> On Fri, 12 Jan 2001, Frank de Lange wrote:
> 
> > WITH or WITHOUT the changed 8390 driver? I can already give you the
> > results for running WITH the changed driver: it works. I have not yet
> > tried it WITHOUT the changed 8390 driver (so that would be stock 8390,
> > patched apic.c, stock io_apic.c). Please let me know which you want...
> 
> WITH. patched 8390.c, patched apic.c, sock io_apic.c. My very strong
> feeling is that this will be a stable combination, and that this is what
> we want as a final solution.

It is. As I already mentioned in other messages, I already tested with JUST the
patched 8390.c driver, no other patches. It was stable. I then patched apic.c
AND io_apic.c, which did not introduce new instabilities. Unless you think that
reverting back to a stock io_apic.c would cause instabilities (which would be
weird, since I had no instabilities running only a patched 8390.c), I think the
patch to 8390.c DOES remove the symptoms all by itself. No other patches seem
necessary to get a stable box.

But I'll patch the mess again just fox kicks :-)

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
