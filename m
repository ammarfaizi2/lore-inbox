Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbTBLR4S>; Wed, 12 Feb 2003 12:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267215AbTBLR4S>; Wed, 12 Feb 2003 12:56:18 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:6148
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267209AbTBLR4R>; Wed, 12 Feb 2003 12:56:17 -0500
Date: Wed, 12 Feb 2003 13:07:00 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: bgerst@didntduck.org, <ambx1@neo.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for
 i8042?
In-Reply-To: <20030212091916.1989c531.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0302121306340.289-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hmm, It appears the PS/2 was not on when I built that kernel.

But the fact remains, I'm out of IRQs some how. ;/

Shawn.

On Wed, 12 Feb 2003, Randy.Dunlap wrote:

> (see an answer at bottom)
>
> On Wed, 12 Feb 2003 11:12:02 -0500 (EST)
> Shawn Starr <spstarr@sh0n.net> wrote:
>
> |
> | Right, but this wasn't a problem in 2.4? I had a PS/2 mouse before in 2.4
> | and this didnt have the problem.
> |
> |
> | On Wed, 12 Feb 2003, Brian Gerst wrote:
> |
> | > Shawn Starr wrote:
> | > > 2.4:
> | > >            CPU0
> | > >   0:    2576292          XT-PIC  timer
> | > >   1:        661          XT-PIC  keyboard
> | > >   2:          0          XT-PIC  cascade
> | > >   3:         10          XT-PIC  serial
> | > >   5:    1104824          XT-PIC  soundblaster
> | > >   8:          1          XT-PIC  rtc
> | > >   9:          0          XT-PIC  acpi
> | > >  10:          7          XT-PIC  aic7xxx
> | > >  11:      15167          XT-PIC  usb-uhci, eth0
> | > >  14:       7554          XT-PIC  ide0
> | > >  15:          3          XT-PIC  ide1
> | > >
> | > > 2.5:
> | > >
> | > >            CPU0
> | > >   0:      36281          XT-PIC  timer
> | > >   1:         15          XT-PIC  i8042
> | > >   2:          0          XT-PIC  cascade
> | > >   3:        149          XT-PIC  serial
> | > >   5:          0          XT-PIC  soundblaster
> | > >   8:          1          XT-PIC  rtc
> | > >   9:          0          XT-PIC  acpi
> | > >  10:         20          XT-PIC  aic7xxx
> | > >  11:        324          XT-PIC  uhci-hcd, eth0
> | > >  12:         60          XT-PIC  i8042 <--???
> | > >  14:        723          XT-PIC  ide0
> | > >  15:          9          XT-PIC  ide1
> | > > NMI:          0
> | > > LOC:      35547
> | > > ERR:          0
> | > > MIS:          0
> | > >
> | > > Interesting, why are we using two interrupts for the i8042 (keyboard).
> | >
> | > IRQ12 is for the PS/2 mouse port.
> | >
> | > --
> | > 				Brian Gerst
>
> Do you have a PS/2 mouse enabled/configured in 2.4?
> I do, and it shows this on 2.4.20:
>
>   0:   78505022          XT-PIC  timer
>   1:     305438          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   3:    2013477          XT-PIC  xirc2ps_cs
>   5:          0          XT-PIC  usb-uhci
>   8:          1          XT-PIC  rtc
>  10:          4          XT-PIC  i82365
>  11:    2188569          XT-PIC  i82365, cs46xx
>  12:    1555382          XT-PIC  PS/2 Mouse
>  14:     872963          XT-PIC  ide0
>  15:          3          XT-PIC  ide1
>
> and the driver code certainly requests IRQ 12 for the PS/2 mouse
> when it's configured.
>
> --
> ~Randy
>
>

