Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKPSgd>; Thu, 16 Nov 2000 13:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbQKPSgY>; Thu, 16 Nov 2000 13:36:24 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:51908 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129076AbQKPSgL>;
	Thu, 16 Nov 2000 13:36:11 -0500
Date: Thu, 16 Nov 2000 13:05:53 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, netdev@oss.sgi.com
Subject: Re: PATCH: 8139too kernel thread
In-Reply-To: <E13wTKL-000899-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0011161302200.13047-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Alan Cox wrote:

> > The only disadvantage to this scheme is the added cost of a kernel
> > thread over a kernel timer.  I think this is an ok cost, because this
> > is a low-impact thread that sleeps a lot..
> 
> 8K of memory, two tlb flushes, cache misses on the scheduler. The price is
                ^^^^^^^^^^^^^^^
> actually extremely high.

<confused>
Does it really need non-lazy TLB?

I'm not saying that it's a good idea, but...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
