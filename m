Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263358AbRFKCxM>; Sun, 10 Jun 2001 22:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263359AbRFKCxC>; Sun, 10 Jun 2001 22:53:02 -0400
Received: from nalserver.nal.go.jp ([202.26.95.66]:55503 "EHLO
	nalserver.nal.go.jp") by vger.kernel.org with ESMTP
	id <S263358AbRFKCws>; Sun, 10 Jun 2001 22:52:48 -0400
Date: Mon, 11 Jun 2001 11:51:08 +0900 (JST)
From: Aron Lentsch <lentsch@nal.go.jp>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ problems on new Toshiba Libretto
In-Reply-To: <200106091737.KAA26056@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0106111107270.1065-100000@triton.nal.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Linus, Alan and Jeff,

thank you very much for your replies. I though it is
best, if I respond with one email so we have all in one
place.


On Sat, 9 Jun 2001, Linus Torvalds wrote:

> Can you add the output of "dump_pirq" to your logs? 
> ... 
> together with "lspci -vvvxx" would be useful.

dump_irq returns the following:
-----------------------------------------------------------------------
No PCI interrupt routing table was found.

Interrupt router at 00:07.0: AcerLabs Aladdin M1533
PCI-to-ISA bridge
  INT1 (link 1): irq 11
  INT2 (link 2): unrouted
  INT3 (link 3): unrouted
  INT4 (link 4): unrouted
  INT5 (link 5): unrouted
  INT6 (link 6): unrouted
  INT7 (link 7): unrouted
  INT8 (link 8): unrouted
  Serial IRQ: [enabled] [continuous] [frame=21]
[pulse=8]
-----------------------------------------------------------------------

The output of lspci -vvvxx is a bit longer, so I
have put it in:
http://launchers.tripod.com/linux/lspci_vvvxx.txt


On Sat, 9 Jun 2001, Alan Cox wrote:
> 
> Did you try the pci=biosirq boot option btw ?
> 

Yes, I tried 'pci=biosirq' as well as
'pci=irqmask=0xfff8', but unfortunately I couldn't see
any change.


On Sat, 9 Jun 2001, Jeff Garzik wrote:

> I request two additional outputs:
>  
> 1) lspci -vvvxxx

The putput of lspci -vvvxxx is in:
http://launchers.tripod.com/linux/lspci_vvvxxx.txt              

> 2) Change arch/i386/kernel/pci-i386.h near the top to enable debugging:
> -#undef DEBUG
> +#define DEBUG 1
> 
> and then provide dmesg output as before.  

OK, I recompiled the kernel with this change and the
output of 'dmesg' is in 

http://launchers.tripod.com/linux/dmesg.wDEBUG1.txt


Hope this helps to trace back my problem!
Thank you very much again for your help!

Aron


