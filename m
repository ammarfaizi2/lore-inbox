Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKPStz>; Thu, 16 Nov 2000 13:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129770AbQKPStp>; Thu, 16 Nov 2000 13:49:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17216 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129132AbQKPStd>; Thu, 16 Nov 2000 13:49:33 -0500
Subject: Re: PATCH: 8139too kernel thread
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 16 Nov 2000 18:19:40 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, netdev@oss.sgi.com
In-Reply-To: <Pine.GSO.4.21.0011161302200.13047-100000@weyl.math.psu.edu> from "Alexander Viro" at Nov 16, 2000 01:05:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wTdO-0008BQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 8K of memory, two tlb flushes, cache misses on the scheduler. The price is
>                 ^^^^^^^^^^^^^^^
> > actually extremely high.
> 
> <confused>
> Does it really need non-lazy TLB?

Good point, so its a mere 8K of memory and the scheduler cache misses

> I'm not saying that it's a good idea, but...

It seems a very bad idea for the general case. It might be justified for a few
drivers but then they should not use their own thread but (to merge two mail
discussions together) use the generic api dwmw2 is doing to solve the pcmcia
problem.

Now we can sleep and we are back to a single 8K stack for all of it

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
