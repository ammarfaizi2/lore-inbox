Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWH3G6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWH3G6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 02:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWH3G6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 02:58:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:49867 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750721AbWH3G6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 02:58:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=inTQmELWgOt7uSmbq4Tz3+W4VPgUFKrTNR+0CBEhsUBCFldTWOb7PnVdt5DX7SY2Z6kil4deWh7F46e8KaQVVKJs/Cz4FqJPr0HWKyZnF7GDF8RMlYhEAR3bc9Enc4s1FxPzx2B7nL3d65oc/HTQhZn611Pj2BDWIF1C4ji1Bpg=
Message-ID: <742b1fb30608292358y6cebdf4eg654d7a1973a91c3@mail.gmail.com>
Date: Wed, 30 Aug 2006 08:58:17 +0200
From: "Patrizio Bassi" <patrizio.bassi@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [BUG?] 2.6.17.x suspend problems
Cc: linux-kernel@vger.kernel.org, "Pavel Machek" <pavel@ucw.cz>
In-Reply-To: <742b1fb30608290414w5d7efc2et349f5ca32f241834@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <742b1fb30608280446x2b0cf2d4p5aae2bb66ba41555@mail.gmail.com>
	 <200608291216.55551.rjw@sisk.pl>
	 <742b1fb30608290414w5d7efc2et349f5ca32f241834@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/8/29, Patrizio Bassi <patrizio.bassi@gmail.com>:
> 2006/8/29, Rafael J. Wysocki <rjw@sisk.pl>:
> > On Monday 28 August 2006 13:46, Patrizio Bassi wrote:
> > > when i try to suspend my notebook i have problems with ide controller.
> > > the copy lasts a lot and i get oops.
> >
> > I haven't seen any patches related to SIS chipsets recently.
> >
> > There is a chance the latest -mm will work, so you can try it (no warranty,
> > though).  If not, please file a bug report at http://bugzilla.kernel.org
> > (with a Cc to rjwysocki@sisk.pl).
>
>
> do you mean the .18-mm sources i guess, not the .17 ones.
>
> Ok, i'll try as soon as possibile.
>
>
>
> >
> > Greetings,
> > Rafael
> >
> >
> > > Stopping tasks: ==========================================|
> > > Shrinking memory... done (22776 pages freed)
> > > pnp: Device 00:08 disabled.
> > > swsusp: Need to copy 30898 pages
> > > ACPI: PCI Interrupt 0000:00:00.1[A]: no GSI - using IRQ 14
> > > eth0: Media Link Off
> > > ACPI: PCI Interrupt 0000:00: 01.2[D] -> Link [LNKD] -> GSI 5 (level,
> > > low) -> IRQ 5
> > > ACPI: PCI Interrupt 0000:00:01.3[D] -> Link [LNKD] -> GSI 5 (level,
> > > low) -> IRQ 5
> > > ACPI: PCI Interrupt 0000:00:01.4[B] -> Link [LNKB] -> GSI 5 (level,
> > > low) -> IRQ 5
> > > ACPI: PCI Interrupt 0000:00:01.6[B] -> Link [LNKB] -> GSI 5 (level,
> > > low) -> IRQ 5
> > > PCI: Setting latency timer of device 0000:00:02.0 to 64
> > > PM: Writing back config space on device 0000:00:0a.0 at offset 1 (was
> > > 82100003, writing 82100007)
> > > ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKA] -> GSI 11 (level,
> > > low) -> IRQ 11
> > > PM: Writing back config space on device 0000:00:0a.1 at offset 1 (was
> > > 2100003, writing 82100007)
> > > ACPI: PCI Interrupt 0000:00: 0a.1[B] -> Link [LNKC] -> GSI 5 (level,
> > > low) -> IRQ 5
> > > pnp: Device 00:08 activated.
> > > pnp: Failed to activate device 00:0c.
> > > pnp: Failed to activate device 00:0d.
> > > irq 14: nobody cared (try booting with the "irqpoll" option)
> > >  <c012c987> __report_bad_irq+0x2b/0x69  <c012cb3d> note_interrupt+0x178/0x1a7
> > >  <c012c53d> handle_IRQ_event+0x22/0x4e  <c012c5ce> __do_IRQ+0x65/0x8f
> > >  <c0104b2d> do_IRQ+0x19/0x24  <c01033da> common_interrupt+0x1a/0x20
> > >  <c0118f4b> __do_softirq+0x2c/0x7f  <c0118fc0> do_softirq+0x22/0x26
> > >  <c0104b32> do_IRQ+0x1e/0x24  <c01033da> common_interrupt+0x1a/0x20
> > >  <c0214224> acpi_processor_idle+0x157/0x323  <c0101da2> cpu_idle+0x3a/0x4f
> > >  <c03b0635> start_kernel+0x29c/0x29e
> > > handlers:
> > > [<c0230301>] (ide_intr+0x0/0x16c)
> > > Disabling IRQ #14
> > > Restarting tasks... done
> > > hda: dma_timer_expiry: dma status == 0x24
> > > hda: DMA interrupt recovery
> > > hda: lost interrupt
> > >
> > >            CPU0
> > >   0:     431861          XT-PIC  timer
> > >   1:        638          XT-PIC  i8042
> > >   2:          0          XT-PIC  cascade
> > >   5:          0          XT-PIC  yenta, ohci_hcd:usb1, ohci_hcd:usb2,
> > > Trident Audio, SiS630, eth0
> > >   7:          0          XT-PIC  parport0
> > >   8:          2          XT-PIC  rtc
> > >   9:          1          XT-PIC  acpi
> > >  11:          0          XT-PIC  yenta
> > >  12:      10982          XT-PIC  i8042
> > >  14:     200771          XT-PIC  ide0
> > >  15:         26          XT-PIC  ide1
> > > NMI:          0
> > > LOC:          0
> > > ERR:          0
> > > MIS:          0
> > > 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 11)
> > > 00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
> > > 00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC Bridge)
> > > 00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
> > > PCI Fast Ethernet (rev 80)
> > > 00:01.2 USB Controller: Silicon Integrated Systems [SiS] USB  1.0
> > > Controller (rev 07)
> > > 00:01.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
> > > Controller (rev 07)
> > > 00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS]
> > > SiS PCI Audio Accelerator (rev 01)
> > >   00:01.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem
> > > Controller (rev a0)
> > > 00:02.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual
> > > PCI-to-PCI bridge (AGP)
> > > 00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
> > > 00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
> > > 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
> > > 630/730 PCI/AGP VGA Display Adapter (rev 11)
> > >
> > >
> > >
> > > I have another two problems too:
> > > 1) have to disable synaptics driver (editing sources) otherwise i get
> > > kernel panic
> > >  2) dri accelleration is working no more after suspend. glxgears shows
> > > a black window only.
> > >
> > > i think i should open 2 different threads for the last two.
> > >
> > > please CC me, i'm not subscribed.
> > >
> > >
> >
> > --
> > You never change things by fighting the existing reality.
> >                 R. Buckminster Fuller
> >


i just tested 2.6.18-rc4-mm3.

as soon as i ask for suspending i get a black screen.
waiting for lots of time...something like 1 min i see:

Disabling Interrupt #14
and after, even waiting some means...nothing more.


2.6.18-rc5 gives me a panic:

www.patriziobassi.it/b.jpg

i see the same like, but the interrupt is disabled immediatly, without
waiting for a long time as rc4-mm3.

and now it seems to crash due to the synaptics problem i announced in
my first mail.
maybe fixing that may allow me to suspend.

Ready to test patches!

(please always CC me, i'm not subscribed)


ps. my config
www.patriziobassi.it/config

-- 

Patrizio Bassi
www.patriziobassi.it
