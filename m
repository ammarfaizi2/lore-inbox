Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWH2KNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWH2KNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 06:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWH2KNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 06:13:13 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:55476 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964887AbWH2KNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 06:13:11 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Patrizio Bassi" <patrizio.bassi@gmail.com>
Subject: Re: [BUG?] 2.6.17.x suspend problems
Date: Tue, 29 Aug 2006 12:16:55 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <742b1fb30608280446x2b0cf2d4p5aae2bb66ba41555@mail.gmail.com>
In-Reply-To: <742b1fb30608280446x2b0cf2d4p5aae2bb66ba41555@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608291216.55551.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 13:46, Patrizio Bassi wrote:
> when i try to suspend my notebook i have problems with ide controller.
> the copy lasts a lot and i get oops.

I haven't seen any patches related to SIS chipsets recently.

There is a chance the latest -mm will work, so you can try it (no warranty,
though).  If not, please file a bug report at http://bugzilla.kernel.org
(with a Cc to rjwysocki@sisk.pl).

Greetings,
Rafael


> Stopping tasks: ==========================================|
> Shrinking memory... done (22776 pages freed)
> pnp: Device 00:08 disabled.
> swsusp: Need to copy 30898 pages
> ACPI: PCI Interrupt 0000:00:00.1[A]: no GSI - using IRQ 14
> eth0: Media Link Off
> ACPI: PCI Interrupt 0000:00: 01.2[D] -> Link [LNKD] -> GSI 5 (level,
> low) -> IRQ 5
> ACPI: PCI Interrupt 0000:00:01.3[D] -> Link [LNKD] -> GSI 5 (level,
> low) -> IRQ 5
> ACPI: PCI Interrupt 0000:00:01.4[B] -> Link [LNKB] -> GSI 5 (level,
> low) -> IRQ 5
> ACPI: PCI Interrupt 0000:00:01.6[B] -> Link [LNKB] -> GSI 5 (level,
> low) -> IRQ 5
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> PM: Writing back config space on device 0000:00:0a.0 at offset 1 (was
> 82100003, writing 82100007)
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKA] -> GSI 11 (level,
> low) -> IRQ 11
> PM: Writing back config space on device 0000:00:0a.1 at offset 1 (was
> 2100003, writing 82100007)
> ACPI: PCI Interrupt 0000:00: 0a.1[B] -> Link [LNKC] -> GSI 5 (level,
> low) -> IRQ 5
> pnp: Device 00:08 activated.
> pnp: Failed to activate device 00:0c.
> pnp: Failed to activate device 00:0d.
> irq 14: nobody cared (try booting with the "irqpoll" option)
>  <c012c987> __report_bad_irq+0x2b/0x69  <c012cb3d> note_interrupt+0x178/0x1a7
>  <c012c53d> handle_IRQ_event+0x22/0x4e  <c012c5ce> __do_IRQ+0x65/0x8f
>  <c0104b2d> do_IRQ+0x19/0x24  <c01033da> common_interrupt+0x1a/0x20
>  <c0118f4b> __do_softirq+0x2c/0x7f  <c0118fc0> do_softirq+0x22/0x26
>  <c0104b32> do_IRQ+0x1e/0x24  <c01033da> common_interrupt+0x1a/0x20
>  <c0214224> acpi_processor_idle+0x157/0x323  <c0101da2> cpu_idle+0x3a/0x4f
>  <c03b0635> start_kernel+0x29c/0x29e
> handlers:
> [<c0230301>] (ide_intr+0x0/0x16c)
> Disabling IRQ #14
> Restarting tasks... done
> hda: dma_timer_expiry: dma status == 0x24
> hda: DMA interrupt recovery
> hda: lost interrupt
> 
>            CPU0
>   0:     431861          XT-PIC  timer
>   1:        638          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:          0          XT-PIC  yenta, ohci_hcd:usb1, ohci_hcd:usb2,
> Trident Audio, SiS630, eth0
>   7:          0          XT-PIC  parport0
>   8:          2          XT-PIC  rtc
>   9:          1          XT-PIC  acpi
>  11:          0          XT-PIC  yenta
>  12:      10982          XT-PIC  i8042
>  14:     200771          XT-PIC  ide0
>  15:         26          XT-PIC  ide1
> NMI:          0
> LOC:          0
> ERR:          0
> MIS:          0
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 11)
> 00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
> 00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC Bridge)
> 00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
> PCI Fast Ethernet (rev 80)
> 00:01.2 USB Controller: Silicon Integrated Systems [SiS] USB  1.0
> Controller (rev 07)
> 00:01.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
> Controller (rev 07)
> 00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS]
> SiS PCI Audio Accelerator (rev 01)
>   00:01.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem
> Controller (rev a0)
> 00:02.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual
> PCI-to-PCI bridge (AGP)
> 00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
> 00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
> 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
> 630/730 PCI/AGP VGA Display Adapter (rev 11)
> 
> 
> 
> I have another two problems too:
> 1) have to disable synaptics driver (editing sources) otherwise i get
> kernel panic
>  2) dri accelleration is working no more after suspend. glxgears shows
> a black window only.
> 
> i think i should open 2 different threads for the last two.
> 
> please CC me, i'm not subscribed.
> 
> 

-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
