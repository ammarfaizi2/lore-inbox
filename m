Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315915AbSENR2u>; Tue, 14 May 2002 13:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315916AbSENR2t>; Tue, 14 May 2002 13:28:49 -0400
Received: from fungus.teststation.com ([212.32.186.211]:26642 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S315915AbSENR2s>; Tue, 14 May 2002 13:28:48 -0400
Date: Tue, 14 May 2002 19:28:01 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: "Ivan G." <ivangurdiev@linuxfreemail.com>
cc: Roger Luethi <rl@hellgate.ch>, LKML <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [PATCH] VIA Rhine stalls: TxAbort handling
In-Reply-To: <02051317475500.00917@cobra.linux>
Message-ID: <Pine.LNX.4.33.0205141917080.20379-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Ivan G. wrote:

> Speaking of VIA Rhine Cards....
> 
> THIS:
>       if (chip_id == VT86C100A) {
>                 /* More recent docs say that this bit is reserved ... */
>                 n = inb(ioaddr + ConfigA) | 0x20;
>                 outb(n, ioaddr + ConfigA);
> 
> is not right, as the comment also explains...
> So what should be done here instead??

What makes you think there are other options?

The older VT86C100A docs say the bit controls if memory mapped io is
enabled, the newer says it is reserved. That doesn't mean that the bit
doesn't control what it used to, only that it is no longer documented.
(seems unlikely that they actually changed the hardware)

Why remove it from the docs? Perhaps the chip has bugs with mmio.

It works (for me at least), but it is experimental esp. on the VT86C100A.
When you have seen stalls did you run with or without mmio?

/Urban

