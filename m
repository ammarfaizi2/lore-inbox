Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHVEJ>; Thu, 8 Feb 2001 16:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130259AbRBHVEA>; Thu, 8 Feb 2001 16:04:00 -0500
Received: from nn.net.uni-c.dk ([130.226.0.34]:34310 "HELO nn.net.uni-c.dk")
	by vger.kernel.org with SMTP id <S129031AbRBHVDo>;
	Thu, 8 Feb 2001 16:03:44 -0500
Date: Thu, 8 Feb 2001 22:03:42 +0100
From: torben fjerdingstad <unitfj-lk@tfj.rnd.uni-c.dk>
To: linux-kernel@vger.kernel.org
Subject: No sound on SB line2 anymore?
Message-ID: <20010208220341.A21133@tfj.rnd.uni-c.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.4.0-test5, line2 on my Soundblaster 128 soundcard, which is
connected to on my hauppauge winTV/pci TV card has been silent.
I sure have turned line2 on with a mixer program.
The external line connector sounds OK.

lspci says:
00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 11)

Since linux-2.4.0-test5 (which worked), I have tried the following
kernel versions:
linux-2.4.0-prerelease
linux-2.4.0-ac12
linux-2.4.1-ac6

dmesg says:
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
Linux video capture interface: v1.00
bttv: driver version 0.7.50 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Bt8xx card found (0).
bttv0: Bt848 (rev 17) at 00:0b.0, irq: 10, latency: 32, memory: 0xdd000000
bttv0: model: BT848( *** UNKNOWN *** ) [autodetected]
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0x61
bttv0: i2c attach [Temic PAL]
i2c-core.o: client [Temic PAL] registered to adapter [bt848 #0](pos. 0).
es1370: version v0.34 time 21:31:10 Feb  8 2001
es1370: found adapter at io 0xa800 irq 5
es1370: features: joystick off, line in, mic impedance 0

Currently I'm using xawtv:
This is xawtv-3.30, running on Linux/i686 (2.4.1-ac6)

In .xawtv I have:
mixer   = line2

It seems to both aumix and xawtv that there is a mixer there,
but no sound comes out, even when line2 is on, and volume=100%.
Otherwise the sound card works fine.

What's up?

-- 
Med venlig hilsen / Regards 
Netdriftgruppen / Network Management Group
UNI-C          

Tlf./Phone   +45 35 87 89 41        Mail:  UNI-C                                
Fax.         +45 35 87 89 90               Bygning 304
E-mail: torben.fjerdingstad@uni-c.dk       DK-2800 Lyngby

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
