Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290987AbSBLMXy>; Tue, 12 Feb 2002 07:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291000AbSBLMXp>; Tue, 12 Feb 2002 07:23:45 -0500
Received: from unicef.org.yu ([194.247.200.148]:36621 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S290987AbSBLMX3>;
	Tue, 12 Feb 2002 07:23:29 -0500
Date: Tue, 12 Feb 2002 13:23:20 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Question about i820 chipset.
In-Reply-To: <Pine.LNX.4.21.0202121242350.19967-100000@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.33.0202121321400.7616-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try to change slot
perhaps one of your nic is sharing irq with mouse usb ide
etc so change slot
check with more /proc/interrupts

On Tue, 12 Feb 2002, Martin Josefsson wrote:

> Hi Alan,
>
> I have some small questions...
>
> Have you ever tried a motherboard with i820 chipset and two NIC's?
> I have a Asus P3C-D here (dual pIII 800 with 256MB rimm) and a D-Link
> DFE570-TX NIC (quad DECchip 21143 behind a DECchip 21152 pci bridge).
>
> The problem I'm seeing is extremely crappy pci performance.
> With one of the NIC's active I see no real problems but when two NIC's are
> active at the same time all hell breaks loose :(
>
> if I generate traffic out via 2 NIC's at the same time I'd expect to get
> about 2 x 100Mbit/s but in reality I get 2 x 25Mbit/s with this
> motherboard. and with 3 NIC's active I get about 3 x 15-20Mbit/s.
>
> I tried replacing the motherboard with an old SMP board based on the 440bx
> chipset (cpus underclocked to 600MHz) and then I can easily get 3 x
> 100Mbit/s with 25-30% cpu used in the machine.
>
> So my question is, have you ever seen such pci issues? I've tried all
> BIOS settings I could find and a lot of diffrent kernels. I've also tried
> the vanilla tulip-driver and the NAPI'fied one (which I have been helping
> to test) and both show the exact same performanceproblems.
>
> I tried routing a lot of packets and it started dropping a lot of packets
> when the cpu was only 75% used according to both vmstat and cyclesoak
> (with an UP kernel). A profile shows that default_idle gets about 25% of
> the time. I assume the kernel is waiting for the pci bus.
>
> And the last question, if you have the hardware, would you mind testing
> something similar on the Asus A7M266-D? We've been thinking of getting a
> few of these boards to replace the crappy i820 ones.
>
> I saw that you included a patch for MPS 1.4 in -pre9-ac1, was this the
> same patch you were talking about earlier and does it work?
>
> /Martin
>
> Never argue with an idiot. They drag you down to their level, then beat you with experience.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

