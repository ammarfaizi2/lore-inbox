Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWGYWIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWGYWIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWGYWIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:08:39 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:59462 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932496AbWGYWIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:08:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=H/xWotaGDkfWziC8Pvi5/7wYWYQvmyuDTKbBD8J25BF3MdIFXcg3M1pBDUX8VrxDR8QtrgMpKB4I8sFdnTPmIKEdnT+8S0/lbQJ4+IuqrzecuDlcm7nk/UmmaVJQXt/UnnszUHgkBWCLZg9gBS4TaDh6rjg7vwYj9R1AdQuhyG8=
Date: Tue, 25 Jul 2006 18:08:32 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PCI bus is hidden behind transparent bridge
Message-ID: <20060725220832.GA8214@phoenix>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060725215639.GB8113@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20060725215639.GB8113@phoenix>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: multipart/mixed; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry to reply to my own message... but I wanted to add something.

Since I upgraded my kernel back around 2.6.16, I stopped seeing my SMBus
adapter on the PCI bus, and thus could not get readings from the LM90
sensor chip on my laptop.  After trying the pci=assign-busses parameter,
the error messages about transparent busses go away, but I still can't
access the SMBus controller (it uses the i2c-i801 module, in case that
helps).

I've attached the dmesg that I get when I specify that parameter; the
lspci output remains the same.

--Thomas Tuttle

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.6.18-rc2-assign-buses"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.18-rc2 (tom@phoenix) (gcc version 3.4.6 (Gentoo 3.4.6-r1,=
 ssp-3.4.5-1.0, pie-8.7.9)) #2 PREEMPT Tue Jul 25 17:36:09 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f740000 (usable)
 BIOS-e820: 000000001f740000 - 000000001f750000 (ACPI data)
 BIOS-e820: 000000001f750000 - 000000001f800000 (ACPI NVS)
503MB LOWMEM available.
On node 0 totalpages: 128832
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 124736 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f4f70
ACPI: RSDT (v001 A M I  OEMRSDT  0x09000409 MSFT 0x00000097) @ 0x1f740000
ACPI: FADT (v002 A M I  OEMFACP  0x09000409 MSFT 0x00000097) @ 0x1f740200
ACPI: MADT (v001 A M I  OEMAPIC  0x09000409 MSFT 0x00000097) @ 0x1f740300
ACPI: OEMB (v001 A M I  OEMBIOS  0x09000409 MSFT 0x00000097) @ 0x1f750040
ACPI: DSDT (v001  0ABBD 0ABBD001 0x00000001 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 1f800000:e0800000)
Detected 1700.138 MHz processor.
Built 1 zonelists.  Total pages: 128832
Kernel command line: root=3D/dev/hda5 vga=3D0x318 pci=3Dassign-busses
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc049b000 soft=3Dc049a000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 505532k/515328k available (2378k kernel code, 9372k reserved, 744k =
data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3401.12 BogoMIPS (lpj=3D17=
00560)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000 0000=
0180 00000000 00000000
CPU: After vendor identify, caps: afe9fbbf 00000000 00000000 00000000 00000=
180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbbf 00000000 00000000 00000040 00000180 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Pentium(R) M processor 1.70GHz stepping 06
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region e400-e47f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region ec00-ec3f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 28) interrupt mode.
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *4 5 6 7 12)
ACPI: Power Resource [GFAN] (off)
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bus 2, cardbus bridge: 0000:01:03.0
  IO window: 0000c000-0000c0ff
  IO window: 0000c400-0000c4ff
  PREFETCH window: 22000000-23ffffff
  MEM window: 24000000-25ffffff
PCI: Bus 6, cardbus bridge: 0000:01:03.1
  IO window: 0000cc00-0000ccff
  IO window: 00001000-000010ff
  PREFETCH window: 26000000-27ffffff
  MEM window: 28000000-29ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: c000-cfff
  MEM window: fe700000-fe8fffff
  PREFETCH window: de500000-de6fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 17 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:01:03.1[B] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:01:03.1 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1153864808.431:1): initialized
Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
vesafb: framebuffer at 0xf0000000, mapped to 0xe0080000, using 6144k, total=
 8000k
vesafb: mode is 1024x768x32, linelength=3D4096, pages=3D1
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK6026GAX, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-R2512, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB), CHS=3D65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: bitmap version 4.39
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat=
=2Ecom
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI: (supports S0 S1 S3 S4 S5)
Time: tsc clocksource has been installed.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
input: AT Translated Set 2 keyboard as /class/input/input0
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 192k freed
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
Asus Laptop ACPI Extras version 0.30
  M2NE model detected, supported
Registered led device: asus:mail
Registered led device: asus:wireless
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Transitioning device [FN00] to D3
ACPI: Transitioning device [FN00] to D3
ACPI: Fan [FN00] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
Time: acpi_pm clocksource has been installed.
ACPI: Thermal Zone [THRM] (54 C)
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 18
[drm] Initialized i915 1.5.0 20060119 on minor 0
[drm] Initialized i915 1.5.0 20060119 on minor 1
input: PC Speaker as /class/input/input1
Synaptics Touchpad, model: 1, fw: 4.6, id: 0x925ea1, caps: 0x80471b/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
Yenta: CardBus bridge found at 0000:01:03.0 [1043:1754]
Yenta: ISA IRQ mask 0x04b8, PCI irq 16
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xc000 - 0xcfff
pcmcia: parent PCI bridge Memory window: 0xfe700000 - 0xfe8fffff
pcmcia: parent PCI bridge Memory window: 0xde500000 - 0xde6fffff
Yenta: CardBus bridge found at 0000:01:03.1 [1043:1754]
Yenta: ISA IRQ mask 0x04b8, PCI irq 17
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xc000 - 0xcfff
pcmcia: parent PCI bridge Memory window: 0xfe700000 - 0xfe8fffff
pcmcia: parent PCI bridge Memory window: 0xde500000 - 0xde6fffff
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 19, io mem 0xfebff800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 18, io base 0x0000d480
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 20, io base 0x0000d800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 17, io base 0x0000d880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 16 (level, low) -> IRQ 18
eth0: RealTek RTL8139 at 0xe06bc800, 00:11:2f:12:5a:dc, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8101'
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
ReiserFS: dm-3: found reiserfs format "3.6" with standard journal
ReiserFS: dm-3: using ordered data mode
ReiserFS: dm-3: journal params: device dm-3, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-3: checking transaction log (dm-3)
ReiserFS: dm-3: Using r5 hash to sort names
ReiserFS: dm-2: found reiserfs format "3.6" with standard journal
ReiserFS: dm-2: using ordered data mode
ReiserFS: dm-2: journal params: device dm-2, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-2: checking transaction log (dm-2)
ReiserFS: dm-2: Using r5 hash to sort names
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
Adding 1052248k swap on /dev/hda2.  Priority:-1 extents:1 across:1052248k
Real Time Clock Driver v1.12ac
PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 50314 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.6 to 64
i2c-core: driver [lm90] registered
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
microcode: CPU0 updated from revision 0x17 to 0x18, date =3D 10172004=20

--yEPQxsgoJgBvi8ip--

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFExpZg/UG6u69REsYRAlIsAJ0WK/ic+zHv+7oV49dt4bt5ZLd23QCeM9mY
pgLfwdMmoyqd0FXg2dh1efo=
=uwZ0
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
