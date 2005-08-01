Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVHASEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVHASEG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVHASEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:04:05 -0400
Received: from nebuchadnezzar.smejdil.cz ([195.122.194.203]:47377 "EHLO
	nebuchadnezzar.smejdil.cz") by vger.kernel.org with ESMTP
	id S261551AbVHASEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:04:00 -0400
Date: Mon, 1 Aug 2005 20:03:57 +0200 (CEST)
From: CIJOML <cijoml@nebuchadnezzar.smejdil.cz>
To: mkrufky@m1k.net, Linux and Kernel Video <video4linux-list@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2 errors in 2.6.12
In-Reply-To: <42ED1016.1000804@m1k.net>
Message-ID: <20050801200248.L77478@nebuchadnezzar.smejdil.cz>
References: <200506190958.00267.cijoml@volny.cz> <20050728214851.44877164.akpm@osdl.org>
 <200507311351.52631.cijoml@volny.cz> <20050731103156.69536415.akpm@osdl.org>
 <42ED1016.1000804@m1k.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Jul 2005, Michael Krufky wrote:

> Andrew Morton wrote:
>
> >Michal Semler <cijoml@volny.cz> wrote:
> >
> >
> >> This is what I gets into dmesg:
> >>
> >> Linux video capture interface: v1.00
> >> bttv: driver version 0.9.15 loaded
> >> bttv: using 8 buffers with 2080k (520 pages) each for capture
> >> bttv: Bt8xx card found (0).
> >> ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKH] -> GSI 9 (level, low) ->
> >> IRQ 9
> >> bttv0: Bt878 (rev 17) at 0000:01:0b.0, irq: 9, latency: 32, mmio: 0xb69fe000
> >> bttv0: using: ProVideo PV951 [card=42,insmod option]
> >> bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
> >> bttv0: using tuner=1
> >> bttv0: i2c: checking for TDA9875 @ 0xb0... not found
> >> bttv0: i2c: checking for TDA7432 @ 0x8a... not found
> >> tvaudio: TV audio decoder + audio/video mux driver
> >> tvaudio: known chips:
> >> tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54
> >> (PV951),ta8874z
> >> tvaudio: found pic16c54 (PV951) @ 0x96
> >> bttv0: i2c: checking for TDA9887 @ 0x86... not found
> >> tuner: Unknown parameter `type'
> >> bttv0: registered device video0
> >> bttv0: registered device vbi0
> >> bttv0: registered device radio0
> >> bttv0: PLL: 28636363 => 35468950 .. ok
> >> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
> >> PCI: setting IRQ 10 as level-triggered
> >> ACPI: PCI Interrupt 0000:01:0c.0[A] -> Link [LNKB] -> GSI 10 (level, low) ->
> >> IRQ 10
> >>
> >>
> >
> >(cc the v4l list)
> >
> >The above is with 2.6.13-rc4.  2.6.11 was OK.
> >
> >
> Michael-
>
> Please remove the insmod options:
>
> bttv0: using: ProVideo PV951 [card=42,insmod option]
>
> ...and show us dmesg output with autodetection.
>
> Also, please try CVS and tell us if you still have the problem... Instructions at:
>
> http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS
>

Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKH] -> GSI 9 (level, low)
-> IRQ 9
bttv0: Bt878 (rev 17) at 0000:01:0b.0, irq: 9, latency: 32, mmio:
0xb69fe000
bttv0: using:  *** UNKNOWN/GENERIC ***  [card=0,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
tveeprom(bttv internal): Huh, no eeprom present (err=-121)?
bttv0: using tuner=-1
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
bttv0: registered device video0
bttv0: registered device vbi0

Same with CVS - kernel 2.6.11 with my options works for me like hell.
Card is really PV951 - it was written on box also :)

Michal

> --
> Michael Krufky
>
> --
> video4linux-list mailing list
> Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list
>
