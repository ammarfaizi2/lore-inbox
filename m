Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132619AbRDCGnV>; Tue, 3 Apr 2001 02:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132624AbRDCGnL>; Tue, 3 Apr 2001 02:43:11 -0400
Received: from cr65188-a.crdva1.bc.wave.home.com ([24.153.54.85]:3847 "HELO
	brewt.org") by vger.kernel.org with SMTP id <S132619AbRDCGm4>;
	Tue, 3 Apr 2001 02:42:56 -0400
Date: Mon, 2 Apr 2001 23:42:08 -0700 (PDT)
From: xcp <xcp@brewt.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: what is pci=biosirq
In-Reply-To: <3AC93F7B.9E46D40E@vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0104022339450.20793-100000@stinky.brewt.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Apr 2001, Petr Vandrovec wrote:

> It looks more like that Acer misimplemented PCI_IRQPIN register - if it
> is legacy IDE interface using ports 1F0-1F7/170-177, with IRQs 14 & 15,
> it should report zero as IRQ pin. What 'lspci -vx -s 0:f.0' says?
> Last four bytes it prints should read 'YY 00 XX XX' - where YY is IRQ
> number assigned by BIOS - either hardwired to zero in chip, or just left
> alone by BIOS (00 or FF) and next 00 is IRQ pin number - 0 = none, 1 =
> A,
> 2 = B ... Intel IDE interfaces returns 00 00 here, VIA returns FF 00,
> and
> I have no hardware with an additional IDE around.
>
> 					Petr Vandrovec
> 					vandrove@vc.cvut.cz
>
Here is the output of lspci -vx -s 0:f.0

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
(prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at b000 [size=16]
00: b9 10 29 52 05 00 80 02 c1 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 02 04

I'm not sure what to make of it.  At this time I am unable to
append="pci=biosirq" as I don't use lilo.  Is there a way to put this
arguement directly into the kernel image?

