Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262060AbRE2M7L>; Tue, 29 May 2001 08:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbRE2M7C>; Tue, 29 May 2001 08:59:02 -0400
Received: from zeus.kernel.org ([209.10.41.242]:23221 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262081AbRE2M6q>;
	Tue, 29 May 2001 08:58:46 -0400
Subject: Re: Status of ALi MAGiK 1 support in 2.4.?
To: bdbryant@mail.utexas.edu (Bobby D. Bryant)
Date: Tue, 29 May 2001 13:35:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        mfrisch@saturn.tlug.org, Axel.Thimm@physik.fu-berlin.de
In-Reply-To: <3B12DCCF.6524A99@mail.utexas.edu> from "Bobby D. Bryant" at May 29, 2001 05:18:39 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154iiK-0004Mb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I actually saw a consistent 2.7% speedup on a FP-intensive benchmark
> that my research group uses, comparing the A7A266 to the 8KTA3 after the
> switch, using the same hardware for everything else and with the BIOS
> settings matched as closely as possible.

One thing you also want to do is to go through your benchmark adding prefetch
instructions about 320 bytes ahead of current data. Even with 133MHz SDRAM on
an Athlon that can add 40% to your throughput.

Prefetch data, prefetchw data you will be writing too. On DDR it should be an
even bigger win.

> May 22 21:45:07 pollux kernel: PCI: No IRQ known for interrupt pin A of
> device 00:04.0. Please try using pci=biosirq.

Yes that is a bit odd. 

> May 22 21:45:07 pollux kernel: ALI15X3: simplex device:  DMA disabled
> May 22 21:45:07 pollux kernel: ide0: ALI15X3 Bus-Master DMA disabled
> (BIOS)
> May 22 21:45:07 pollux kernel: ALI15X3: simplex device:  DMA disabled
> May 22 21:45:07 pollux kernel: ide1: ALI15X3 Bus-Master DMA disabled

The DMA was off because the BIOS left it off.
