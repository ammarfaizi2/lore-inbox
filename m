Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbRGPHCw>; Mon, 16 Jul 2001 03:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267220AbRGPHCn>; Mon, 16 Jul 2001 03:02:43 -0400
Received: from lilly.ping.de ([62.72.90.2]:8452 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S267216AbRGPHCd> convert rfc822-to-8bit;
	Mon, 16 Jul 2001 03:02:33 -0400
Date: 16 Jul 2001 09:02:06 +0200
Message-ID: <20010716070206.2056.qmail@toyland.ping.de>
From: "Michael Stiller" <michael@toyland.ping.de>
To: "Erik Mouw" <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: linux-kernel@vger.kernel.org
X-Mailer: exmh version 2.0.2 2/24/98
Subject: Re: Cardbus Bridge no IRQ in 2.4.6 
In-Reply-To: Your message of "Mon, 16 Jul 2001 00:31:08 +0200."
             <20010716003107.I13239@arthur.ubicom.tudelft.nl> 
X-Url: http://www.ping.de/~michael
X-Face: "wBy`XBjk-b]Wks].wV-RmZmir({Qfv85d&!VDrjx+4Ra(/ZyXjaV-x^QXX-Ab5X#3Eap^/
  W^Zo.K9=py=t6/F&p3cl/.zrgKH)0uxy{#5Y(_dD=ftF*Q}-lp\&Z-563qR3X5qv^o9~iP(pw3_1q
  !ti@9"V[C?^iW\BVArF#(YjjLJ/[R%Ri*sw
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Let me guess: a Lucent Orinico PCI adapter, right? It should work with
> linux-2.4.6, I submitted a patch for 2.4.6-pre8 (or so) and it is
> included in linux-2.4.6. I currently have it working on two non-SMP
> systems (ALi 1541 and Intel 440FX chipsets).

Actually it is something compatible from ELSA. 
I tried your suggestions and it didn't work. On your machines, does the card
get an interrupt from the bios during init?

My Bios (PCI v2.1) only prints CardBus Adapter, no IRQ is assigned.
I already tried different slots. I guess it's a bios problem but i'm interested
to make it work without the help of the bios. At least the bios is only
a pice of software... 

> Make sure that the Cardbus driver is not a module. IOW: your kernel
> configuration should have these lines:

Did that. Interesting messages during kernel boot:

PCI->APIC IRQ transform: (B1,I0,P0) -> 16
  got res[20000000:20000fff] for resource 0 of Texas Instruments PCI1410 \
PCcard Cardbus Controller

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
PCI: Enabling device 00:13.0 (0000 -> 0002)
PCI: No IRQ known for interrupt pin A of device 00:13.0. Probably buggy MP 
table.

Isn't it possible to assign an interrupt to INT A of this device ? IOW, fix 
what
is considered a buggy MP table ?

Yenta IRQ list 0000, PCI irq0
Socket status: 10000047

Cheers,

-Michael







