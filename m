Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132397AbRALTIW>; Fri, 12 Jan 2001 14:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132398AbRALTIM>; Fri, 12 Jan 2001 14:08:12 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:23047 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132397AbRALTII>;
	Fri, 12 Jan 2001 14:08:08 -0500
Date: Fri, 12 Jan 2001 20:07:53 +0100
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010112200753.B25675@unternet.org>
In-Reply-To: <3A5F3BF4.7C5567F8@colorfullife.com> <20010112183314.A24174@unternet.org> <3A5F4428.F3249D2@colorfullife.com> <20010112192500.A25057@unternet.org> <3A5F5538.57F3FDC5@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5F5538.57F3FDC5@colorfullife.com>; from manfred@colorfullife.com on Fri, Jan 12, 2001 at 08:04:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 08:04:24PM +0100, Manfred Spraul wrote:
> Linus wrote:
> > Does this seem to happen mainly with drivers that use "disable_irq()" 
> > and "enable_irq()"? I know the ne drivers do (through the 8390 module), 
> > and some others do too (3c59x). 
> 
> I removed the disable_irq lines from 8390.c, and that fixed the problem:
> no hang within 2 minutes - the test is still running.
> 
> Frank, could you double check it?

Hm, I also sent in a (somewhat different) patch on my own... :-)]

Anyway, still running under heavy load...

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
