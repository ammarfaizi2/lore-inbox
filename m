Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbUFFMME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUFFMME (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUFFMME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:12:04 -0400
Received: from asmtp01.eresmas.com ([62.81.235.141]:48619 "EHLO
	asmtp01.eresmas.com") by vger.kernel.org with ESMTP id S263370AbUFFMKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:10:08 -0400
From: ktech@wanadoo.es
To: manfred@colorfullife.com, torvalds@osdl.org
Subject: RE: Re: 2.6.7-rc1 breaks forcedeth
Cc: ktech@wanadoo.es, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Date: Sun, 6 Jun 2004 14:10:01 +0200
X-MAILER: ARB/3.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1BWwTR-0003d0-I6@mb07.in.mad.eresmas.com>
X-Spam-Score: 0.3 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi manfred,



My ethernet drivers don't work even with that patch.



This is the relevant part that I think you want of the dmesg:



forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.

ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11

PCI: Setting latency timer of device 0000:00:04.0 to 64

forcedeth: irq line 11, Status 0x       4, Mask 08x

eth0: forcedeth.c: subsystem: 0147b:1c00 bound to 0000:00:04.0



And this is the entire dmesg:



Linux version 2.6.7-rc2-Redeeman1 (root@evanescence) (gcc versi?n 3.4.0 20040519 (Gentoo Linux 3.4.0-r5, ssp-3.4-2, pie-8.7.6.2)) #4 Sun Jun 6 00:32:25 CEST 2004

BIOS-provided physical RAM map:

 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)

 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)

 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)

 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)

 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)

 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)

 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)

 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)

 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)

Warning only 896MB will be used.

Use a HIGHMEM enabled kernel.

896MB LOWMEM available.

On node 0 totalpages: 229376

  DMA zone: 4096 pages, LIFO batch:1

  Normal zone: 225280 pages, LIFO batch:16

  HighMem zone: 0 pages, LIFO batch:1

DMI 2.2 present.

ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6ba0

ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000

ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040

ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000

Built 1 zonelists

Initializing CPU#0

Kernel command line: BOOT_IMAGE=2.6.7rc2-rd1 ro root=304

PID hash table entries: 4096 (order 12: 32768 bytes)

Detected 2037.724 MHz processor.

Using tsc for high-res timesource

Console: colour VGA+ 80x25

Memory: 906844k/917504k available (1789k kernel code, 9912k reserved, 518k data, 120k init, 0k highmem)

Checking if this processor honours the WP bit even in supervisor mode... Ok.

Calibrating delay loop... 4030.46 BogoMIPS

Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000

CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000

CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)

CPU: L2 Cache: 512K (64 bytes/line)

CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU: AMD Athlon(tm)  stepping 00

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

NET: Registered protocol family 16

PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=2

PCI: Using configuration type 1

mtrr: v2.0 (20020519)

ACPI: Subsystem revision 20040326

ACPI: IRQ9 SCI: Edge set to Level Trigger.

ACPI: Interpreter enabled

ACPI: Using PIC for interrupt routing

ACPI: PCI Root Bridge [PCI0] (00:00)

PCI: Probing PCI hardware (bus 00)

PCI: nForce2 C1 Halt Disconnect fixup

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]

ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LAPU] (IRQs *3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 *7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 *7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [APC1] (IRQs *16)

ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.

ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.

ACPI: PCI Interrupt Link [APC4] (IRQs *19)

ACPI: PCI Interrupt Link [APCE] (IRQs *16), disabled.

ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCS] (IRQs *23)

ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.

SCSI subsystem initialized

PCI: Using ACPI for IRQ routing

ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 7

ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 7 (level, low) -> IRQ 7

ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 5

ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 5 (level, low) -> IRQ 5

ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 10

ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 10 (level, low) -> IRQ 10

ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 11

ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 11 (level, low) -> IRQ 11

ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 11

ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11

ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 3

ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 3 (level, low) -> IRQ 3

ACPI: PCI Interrupt Link [LACI] enabled at IRQ 7

ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 7 (level, low) -> IRQ 7

ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5

ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 5 (level, low) -> IRQ 5

ACPI: PCI interrupt 0000:01:08.1[A] -> GSI 5 (level, low) -> IRQ 5

ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10

ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10

Machine check exception polling timer started.

devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)

devfs: boot_options: 0x1

Initializing Cryptographic API

ACPI: Power Button (FF) [PWRF]

ACPI: Fan [FAN] (on)

ACPI: Processor [CPU0] (supports C1)

ACPI: Thermal Zone [THRM] (52 C)

Real Time Clock Driver v1.12

Linux agpgart interface v0.100 (c) Dave Jones

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

NFORCE2: IDE controller at PCI slot 0000:00:09.0

NFORCE2: chipset revision 162

NFORCE2: not 100% native mode: will probe irqs later

NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.

NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller

    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA

    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA

hda: ST380023A, ATA DISK drive

Using cfq io scheduler

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive

ide1 at 0x170-0x177,0x376 on irq 15

hda: max request size: 128KiB

hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)

hda: cache flushes supported

 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 > p3 p4

hdc: ATAPI 40X CD-ROM CD-R/RW CD-MRW drive, 2048kB Cache, UDMA(33)

Uniform CD-ROM driver Revision: 3.20

mice: PS/2 mouse device common for all mice

serio: i8042 AUX port at 0x60,0x64 irq 12

input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1

serio: i8042 KBD port at 0x60,0x64 irq 1

input: AT Translated Set 2 keyboard on isa0060/serio0

NET: Registered protocol family 2

IP: routing cache hash table of 8192 buckets, 64Kbytes

TCP: Hash tables configured (established 262144 bind 65536)

NET: Registered protocol family 1

NET: Registered protocol family 17

VFS: Mounted root (reiser4 filesystem) readonly.

Mounted devfs on /dev

Freeing unused kernel memory: 120k freed

Adding 498004k swap on /dev/hda3.  Priority:-1 extents:1

forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.

ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11

PCI: Setting latency timer of device 0000:00:04.0 to 64

forcedeth: irq line 11, Status 0x       4, Mask 08x

eth0: forcedeth.c: subsystem: 0147b:1c00 bound to 0000:00:04.0

agpgart: Detected NVIDIA nForce2 chipset

agpgart: Maximum main memory to use for agp memory: 816M

agpgart: AGP aperture is 256M @ 0xa0000000

usbcore: registered new driver usbfs

usbcore: registered new driver hub

ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 7 (level, low) -> IRQ 7

PCI: Setting latency timer of device 0000:00:06.0 to 64

intel8x0_measure_ac97_clock: measured 49429 usecs

intel8x0: clocking to 47452

ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 11 (level, low) -> IRQ 11

ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller

PCI: Setting latency timer of device 0000:00:02.2 to 64

ehci_hcd 0000:00:02.2: irq 11, pci mem f8a0c000

ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1

irq 11: nobody cared!

 [<c01059aa>]

 [<c0105ac3>]

 [<c0105db8>]

 [<c01040a8>]

 [<c01191b0>]

 [<c0119236>]

 [<c0105dc5>]

 [<c01040a8>]

 [<c01e8dbe>]

 [<f8a938a2>]

 [<c0115a38>]

 [<f8a3e870>]

 [<f8a43d6a>]

 [<c01eca72>]

 [<c01ecacc>]

 [<c01ecb0c>]

 [<c0229b9f>]

 [<c0229cf2>]

 [<c0229fb1>]

 [<c022a45f>]

 [<c01ecddc>]

 [<f8a0a020>]

 [<c012bd9f>]

 [<c0103f3b>]



handlers:

[<f8a3f800>]

Disabling IRQ #11

PCI: cache line size of 64 is not supported by device 0000:00:02.2

ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10

hub 1-0:1.0: USB hub found

hub 1-0:1.0: 6 ports detected

ACPI: PCI interrupt 0000:01:08.1[A] -> GSI 5 (level, low) -> IRQ 5

USB Universal Host Controller Interface driver v2.2

atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.

atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.

inserting floppy driver for 2.6.7-rc2-Redeeman1

Floppy drive(s): fd0 is 1.44M

FDC 0 is a post-1991 82077





Any more things to try?







----- Mensaje Original -----

Remitente: Manfred Spraul manfred@colorfullife.com

Destinatario: Linus Torvalds torvalds@osdl.org

Fecha: Domingo, Junio 6, 2004 10:36am

Asunto: Re: 2.6.7-rc1 breaks forcedeth



>Linus Torvalds wrote:

>>I suspect that the driver should at the very least make sure to 

>disable>any potentially pending interrupts in the "nv_probe()" 

>function. I have no 

>>idea how to do that, but it looks like something like

>>

>>	writel(0, base + NvRegIrqMask);

>>	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);

>>

>>should probably do it. It would be better to reset the thing 

>completely, 

>>methinks, but whatever.

>>

>>  

>>

>I'll add that, but it's only a partial fix: what if ehci_hcd is 

>loaded 

>before the forcedeth driver?

>Luis, could you apply the patch and boot with it? It should print 

>something like

>forcedeth: irq line 11, Status 0x00000020, Mask 0x00000020

>If mask and status are really not zero, then it explains your 

>problems. 

>Additionally I try to reset the nic in nv_probe - there were a few 

>reports seemed to indicate that the nic generates timer interrupts 

>even 

>if the mask is zero.

>--

>   Manfred--- 2.6/drivers/net/forcedeth.c	2004-05-10 

>04:31:59.000000000 +0200

>+++ build-2.6/drivers/net/forcedeth.c	2004-06-06 10:31:43.826368991 

>+0200@@ -1195,16 +1195,13 @@

>	enable_irq(dev->irq);

>}

>

>-static int nv_open(struct net_device *dev)

>+static void nv_reset(struct net_device *dev)

>{

>-	struct fe_priv *np = get_nvpriv(dev);

>	u8 *base = get_hwbase(dev);

>-	int ret, oom, i;

>

>-	dprintk(KERN_DEBUG "nv_open: begin\n");

>+	writel(0, base + NvRegIrqMask);

>+	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);

>

>-	/* 1) erase previous misconfiguration */

>-	/* 4.1-1: stop adapter: ignored, 4.3 seems to be overkill */

>	writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);

>	writel(0, base + NvRegMulticastAddrB);

>	writel(0, base + NvRegMulticastMaskA);

>@@ -1215,6 +1212,20 @@

>	writel(0, base + NvRegUnknownTransmitterReg);

>	nv_txrx_reset(dev);

>	writel(0, base + NvRegUnknownSetupReg6);

>+	pci_push(base);

>+}

>+

>+static int nv_open(struct net_device *dev)

>+{

>+	struct fe_priv *np = get_nvpriv(dev);

>+	u8 *base = get_hwbase(dev);

>+	int ret, oom, i;

>+

>+	dprintk(KERN_DEBUG "nv_open: begin\n");

>+

>+	/* 1) erase previous misconfiguration */

>+	/* 4.1-1: stop adapter: ignored, 4.3 seems to be overkill */

>+	nv_reset(dev);

>

>	/* 2) initialize descriptor rings */

>	np->in_shutdown = 0;

>@@ -1506,6 +1517,11 @@

>	writel(0, base + NvRegWakeUpFlags);

>	np->wolenabled = 0;

>

>+printk(KERN_ERR "forcedeth: irq line %d, Status 0x%8x, Mask %0x8x\n",

>+		       		pci_dev->irq, readl(base + NvRegIrqStatus),

>+				readl(base + NvRegIrqMask));

>+	nv_reset(dev);

>+

>	np->tx_flags = 

>cpu_to_le16(NV_TX_LASTPACKET|NV_TX_LASTPACKET1|NV_TX_VALID); 	if (id-

>>driver_data & DEV_NEED_LASTPACKET1)

>		np->tx_flags |= cpu_to_le16(NV_TX_LASTPACKET1);
