Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135985AbRAMAsu>; Fri, 12 Jan 2001 19:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136029AbRAMAsk>; Fri, 12 Jan 2001 19:48:40 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:4110 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S135985AbRAMAsa>;
	Fri, 12 Jan 2001 19:48:30 -0500
Date: Sat, 13 Jan 2001 01:48:07 +0100
From: Frank de Lange <frank@unternet.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
Message-ID: <20010113014807.B29757@unternet.org>
In-Reply-To: <E14HDjY-0005Ei-00@the-village.bc.nu> <Pine.LNX.4.10.10101121635590.8097-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101121635590.8097-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 04:36:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 04:36:33PM -0800, Linus Torvalds wrote:
> It may well not be disable_irq() that is buggy. In fact, there's good
> reason to believe that it's a hardware problem.

I am inclined to believe it IS a hardware problem... If disable_irq were buggy,
wouldn't the problem occur more frequently in other irq-heavy areas? A quick
count shows that disable_irq* is used in 84 sourcefiles in the driver/*
directory. This includes drivers which generate many interrupts in a short
timeframe (like ide).

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
