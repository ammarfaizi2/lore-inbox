Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271161AbRHOMCx>; Wed, 15 Aug 2001 08:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271164AbRHOMCo>; Wed, 15 Aug 2001 08:02:44 -0400
Received: from cnxt10002.conexant.com ([198.62.10.2]:37274 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S271161AbRHOMCa>; Wed, 15 Aug 2001 08:02:30 -0400
Date: Wed, 15 Aug 2001 14:02:18 +0200 (CEST)
From: <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: "Udo A. Steinberg" <reality@delusion.de>
cc: Gerd Knorr <kraxel@bytesex.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BT878 audio dma
In-Reply-To: <3B7A5FCF.F4C9561F@delusion.de>
Message-ID: <Pine.LNX.4.33.0108151358390.9296-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Udo A. Steinberg wrote:

The bt878 must be grabing an audio device. If so, and when the bt878
module is loaded first, thememu10k1 should be using /dev/dsp1 (and
/dev/dsp2).

When you compile the bt878 as a module and _loaded it after_ the
emu10k1 module does it still work (proving my point above)?

Rui Sousa

>
> Hi Gerd,
>
> When compiling kernels from Alan's -ac tree, i.e. 2.4.8-ac5, and configuring
> CONFIG_SOUND_BT878=y, I completely lose the ability to play sound on my
> machine over my Emu10K1 soundcard. The kernel log contains the following
> message over and over again:
>
> kernel: btaudio: stereo=1 channels=2
>
> When compiled as a module, the module is never auto-loaded and therefore
> sound works fine. The relevant info for my card is below - if more info
> is required, let me know.
>
> Regards,
> Udo.
>
> bttv: driver version 0.7.72 loaded
> bttv: using 2 buffers with 2080k (4160k total) for capture
> bttv: Bt8xx card found (0).
> PCI: Enabling device 00:09.0 (0004 -> 0006)
> PCI: Found IRQ 9 for device 00:09.0
> PCI: Sharing IRQ 9 with 00:04.2
> PCI: Sharing IRQ 9 with 00:04.3
> PCI: Sharing IRQ 9 with 00:09.1
> PCI: Sharing IRQ 9 with 00:0d.0
> bttv0: Bt878 (rev 2) at 00:09.0, irq: 9, latency: 32, memory: 0xd7000000
> bttv0: subsystem: 0070:13eb  =>  Hauppauge WinTV  =>  card=10
> bttv0: model: BT878(Hauppauge new (bt878)) [autodetected]
> bttv0: Hauppauge msp34xx: reset line init
> i2c-dev.o: Registered 'bt848 #0' as minor 0
> i2c-core.o: adapter bt848 #0 registered as adapter 0.
> bttv0: Hauppauge eeprom: model=37284, tuner=Philips FM1216 (5), radio=yes
> bttv0: i2c: checking for MSP34xx @ 0x80... found
> i2c-core.o: driver i2c msp3400 driver registered.
> msp34xx: init: chip=MSP3410D-B4, has NICAM support
> msp3410: daemon started
> bttv0: i2c attach [MSP3410D-B4]
> i2c-core.o: client [MSP3410D-B4] registered to adapter [bt848 #0](pos. 0).
> bttv0: i2c: checking for TDA9875 @ 0xb0... not found
> bttv0: i2c: checking for TDA7432 @ 0x8a... not found
> tvaudio: TV audio decoder + audio/video mux driver
> tvaudio: known chips: tda9840,tda9873h,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951)
> i2c-core.o: driver generic i2c audio driver registered.
> bttv0: i2c attach [tda9840]
> i2c-core.o: client [tda9840] registered to adapter [bt848 #0](pos. 1).
> i2c-core.o: driver i2c TV tuner driver registered.
> tuner: chip found @ 0xc2
> bttv0: i2c attach [Philips PAL]
> i2c-core.o: client [Philips PAL] registered to adapter [bt848 #0](pos. 2).
> bttv0: PLL: 28636363 => 35468950 ... ok
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

