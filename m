Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbQKPQ7M>; Thu, 16 Nov 2000 11:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbQKPQ6w>; Thu, 16 Nov 2000 11:58:52 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:56836 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S130454AbQKPQ6q>;
	Thu, 16 Nov 2000 11:58:46 -0500
Date: Thu, 16 Nov 2000 17:28:15 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd) 
In-Reply-To: <12129.974384071@redhat.com>
Message-ID: <Pine.LNX.4.21.0011161719180.23397-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, David Woodhouse wrote:
> 
> alan@lxorguk.ukuu.org.uk said:
> >  Umm..  Linus drivers dont appear to be SMP safe on unload 
> 
> AFAIK, no kernel threads are currently SMP safe on unload. However, 
> the PCMCIA thread would be safe with the patch below, and we could fairly 
> easily convert the others to use up_and_exit() once it's available.
> 
> Anyone using PCMCIA or CardBus with 2.4, even if you have a non-CardBus
> i82365 or TCIC controller for which the driver was disabled in test11-pre5,
> please could you test this? Especially if you have TCIC, in fact, because
> it's already been tested successfully on yenta and i82365. 
> 
> (pcmcia-dif-7). Linus, this is the full patch against pre5, including the 
> incremental part I sent this morning.

I have finally managed to find time to test it, and after five minutes, I
must say that it looks very good. I was able to both plug and unplug
cards, and cardmgr did what it was supposed to do. If something bad turns
up, I will let you know.

I vote for inclusion! :-)

/Tobias


dmesg info:

Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: 
  Vadem VG-469 ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
    host opts [0]: none
    host opts [1]: none
    ISA irqs (scanned) = 3,4,5,7 polling interval = 1000 ms


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
