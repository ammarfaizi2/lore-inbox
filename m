Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWJ1DU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWJ1DU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 23:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWJ1DU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 23:20:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57610 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751678AbWJ1DU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 23:20:28 -0400
Date: Sat, 28 Oct 2006 05:20:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Chua <jeff.chua.linux@gmail.com>, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: linux-2.6.19-rc2 PCI problem
Message-ID: <20061028032024.GD27968@stusta.de>
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com> <20061025013022.GG27968@stusta.de> <b6a2187b0610251754x7dc2c51aoad2244b8cdcb1c09@mail.gmail.com> <20061026152455.GI27968@stusta.de> <b6a2187b0610270649t4cc71781y8e1695f02e1c608e@mail.gmail.com> <20061027203109.GZ27968@stusta.de> <b6a2187b0610271805w154ca251tb7db33ed0926623@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a2187b0610271805w154ca251tb7db33ed0926623@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, is this 2.6.19-rc1 regression anything you've already heard about, 
or should Jeff bisect for the commit that broke it?

On Sat, Oct 28, 2006 at 09:05:01AM +0800, Jeff Chua wrote:
> On 10/28/06, Adrian Bunk <bunk@stusta.de> wrote:
> 
> >That's still pretty terse...
> >If there is anything interesting in the dmesg, it's above this point
> >(Please send complete "dmesg -s 1000000" for both cases).
> 
> 
> The working one (2.6.18) ...
> 
> Linux version 2.6.18 (root@indiana.corp.fedex.com) (gcc version 3.4.5) #3 
>...
> Brought up 2 CPUs
> migration_cost=325
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: Using MMCONFIG
> Setting up standard PCI resources
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
> Boot video device is 0000:00:02.0
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> PCI: Transparent bridge - 0000:00:1e.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI3._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 15)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 10 devices
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
> ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
> ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
> ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
> ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
> ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 18
> ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 19
> ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 20
> ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 21
> ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 18
> ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 23 (level, low) -> IRQ 21
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
> ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 22
> ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
> ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> NET: Registered protocol family 23
>...
> The bad one (2.6.19-rc1) "diff" ..
>...
> 134,135c151,153
> < usbcore: registered new driver usbfs
> < usbcore: registered new driver hub
> ---
> >usbcore: registered new interface driver usbfs
> >usbcore: registered new interface driver hub
> >usbcore: registered new device driver usb
> 151a170,179
> >PCI: Cannot allocate resource region 8 of bridge 0000:00:01.0
> >PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
> >PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
> >PCI: Cannot allocate resource region 0 of device 0000:00:02.0
> >PCI: Cannot allocate resource region 3 of device 0000:00:02.0
> >PCI: Cannot allocate resource region 0 of device 0000:00:02.1
> >PCI: Cannot allocate resource region 0 of device 0000:00:1d.7
> 
> >PCI: Cannot allocate resource region 2 of device 0000:00:1e.2
> >PCI: Cannot allocate resource region 3 of device 0000:00:1e.2
> >PCI: Cannot allocate resource region 0 of device 0000:02:00.0
> 164a193,199
> >PCI: Failed to allocate mem resource #8:100000@e1000000 for 0000:00:1c.0
> >PCI: Failed to allocate mem resource #0:80000@e1000000 for 0000:00:02.0
> >PCI: Failed to allocate mem resource #0:80000@e1000000 for 0000:00:02.1
> >PCI: Failed to allocate mem resource #3:40000@e1000000 for 0000:00:02.0
> >PCI: Failed to allocate mem resource #0:400@e1000000 for 0000:00:1d.7
> >PCI: Failed to allocate mem resource #2:200@e1000000 for 0000:00:1e.2
> >PCI: Failed to allocate mem resource #3:100@e1000000 for 0000:00:1e.2
> 167c202
> <   MEM window: fe900000-fe9fffff
> ---
> >  MEM window: disabled.
> 168a204
> >PCI: Failed to allocate mem resource #0:10000@0 for 0000:02:00.0
> 171c207
> <   MEM window: fe800000-fe8fffff
> ---
> >  MEM window: disabled.
> 175c211
> <   MEM window: fe700000-fe7fffff
> ---
> >  MEM window: disabled.
>...

So it's a PCI problem, not a tg3 issue.

> 286,295c319,321
> < PCI: Setting latency timer of device 0000:00:1d.7 to 64
> < ehci_hcd 0000:00:1d.7: EHCI Host Controller
> < ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
> < ehci_hcd 0000:00:1d.7: debug port 1
> < PCI: cache line size of 128 is not supported by device 0000:00:1d.7
> < ehci_hcd 0000:00:1d.7: irq 18, io mem 0xffa80800
> < ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> < usb usb1: configuration #1 chosen from 1 choice
> < hub 1-0:1.0: USB hub found
> < hub 1-0:1.0: 8 ports detected
> ---
> >ACPI: PCI interrupt for device 0000:00:1d.7 disabled
> >ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -16
> >ehci_hcd: probe of 0000:00:1d.7 failed with error -16
>...

And tg3 is even not the first driver that fails after this...

> Thanks,
> Jeff.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

