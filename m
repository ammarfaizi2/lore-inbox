Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290157AbSBLLn4>; Tue, 12 Feb 2002 06:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290969AbSBLLnq>; Tue, 12 Feb 2002 06:43:46 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:48579 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S290157AbSBLLni>;
	Tue, 12 Feb 2002 06:43:38 -0500
Date: Tue, 12 Feb 2002 12:43:26 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Question about i820 chipset.
Message-ID: <Pine.LNX.4.21.0202121242350.19967-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I have some small questions...

Have you ever tried a motherboard with i820 chipset and two NIC's?
I have a Asus P3C-D here (dual pIII 800 with 256MB rimm) and a D-Link
DFE570-TX NIC (quad DECchip 21143 behind a DECchip 21152 pci bridge).

The problem I'm seeing is extremely crappy pci performance.
With one of the NIC's active I see no real problems but when two NIC's are
active at the same time all hell breaks loose :(

if I generate traffic out via 2 NIC's at the same time I'd expect to get
about 2 x 100Mbit/s but in reality I get 2 x 25Mbit/s with this
motherboard. and with 3 NIC's active I get about 3 x 15-20Mbit/s.

I tried replacing the motherboard with an old SMP board based on the 440bx
chipset (cpus underclocked to 600MHz) and then I can easily get 3 x
100Mbit/s with 25-30% cpu used in the machine.

So my question is, have you ever seen such pci issues? I've tried all
BIOS settings I could find and a lot of diffrent kernels. I've also tried
the vanilla tulip-driver and the NAPI'fied one (which I have been helping
to test) and both show the exact same performanceproblems.

I tried routing a lot of packets and it started dropping a lot of packets
when the cpu was only 75% used according to both vmstat and cyclesoak
(with an UP kernel). A profile shows that default_idle gets about 25% of
the time. I assume the kernel is waiting for the pci bus.

And the last question, if you have the hardware, would you mind testing
something similar on the Asus A7M266-D? We've been thinking of getting a
few of these boards to replace the crappy i820 ones.

I saw that you included a patch for MPS 1.4 in -pre9-ac1, was this the
same patch you were talking about earlier and does it work?

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.


