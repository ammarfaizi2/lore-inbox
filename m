Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753233AbWKFPd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbWKFPd6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 10:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbWKFPd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 10:33:58 -0500
Received: from mx27.mail.ru ([194.67.23.64]:13632 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1753233AbWKFPd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 10:33:57 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18.2: lockdep warnings on rmmod ohci_hcd
Date: Mon, 6 Nov 2006 18:33:51 +0300
User-Agent: KMail/1.9.5
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200611061546.48062.arvidjaar@mail.ru> <1162822695.3138.30.camel@laptopd505.fenrus.org>
In-Reply-To: <1162822695.3138.30.camel@laptopd505.fenrus.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611061833.53017.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 06 November 2006 17:18, Arjan van de Ven wrote:
> On Mon, 2006-11-06 at 15:46 +0300, Andrey Borzenkov wrote:
> > I presume this is lockdep; this looks initially truncated,
> > unfortunately this
> > is how it was stored in messages. I will try to get more complete
> > output ig
> > required.
>
> the interesting bits are missing unfortunately (the first 10 lines or
> so).
>
> Also this will be in "dmesg" if your system actually survives...

well, dmesg had exactly the same contents. Here full dmesg with increased 
LOG_SHIFT.

Linux version 2.6.18.2-1avb (bor@cooker) (gcc version 4.1.1 20060724 
(prerelease) (4.1.1-3mdk)) #9 Mon Nov 6 18:22:22 MSK 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
 BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
 BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ef60000 (usable)
 BIOS-e820: 000000001ef60000 - 000000001ef70000 (ACPI data)
 BIOS-e820: 000000001ef70000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
495MB LOWMEM available.
On node 0 totalpages: 126816
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 122720 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 TOSHIB                                ) @ 0x000f0090
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x1ef60000
ACPI: FADT (v002 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x1ef60054
ACPI: DSDT (v001 TOSHIB 4000     0x20020417 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0xee08
Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
Detected 747.771 MHz processor.
Built 1 zonelists.  Total pages: 126816
Kernel command line: root=/dev/hda2 BOOT_IMAGE=2.6.18.2-1avb-dmesg hdc=ide-cd 
resume=/dev/hda1 splash=silent vga=791 1
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (013e7000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1200 bytes
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 496628k/507264k available (1735k kernel code, 10056k reserved, 758k 
data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1497.13 BogoMIPS (lpj=748565)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 
00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0a00)
checking if image is initramfs... it is
Freeing initrd memory: 648k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfe5ae, last bus=5
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region ee00-ee3f claimed by ali7101 ACPI
PCI quirk: region ef00-ef1f claimed by ali7101 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f7f00000-fdffffff
  PREFETCH window: 3c000000-3c0fffff
PCI: Bus 2, cardbus bridge: 0000:00:10.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 6, cardbus bridge: 0000:00:11.0
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
PCI: Bus 10, cardbus bridge: 0000:00:11.1
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 38000000-39ffffff
  MEM window: 3a000000-3bffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Enabling device 0000:00:10.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Enabling device 0000:00:11.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Enabling device 0000:00:11.1 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 7, 655360 bytes)
TCP bind hash table entries: 8192 (order: 6, 360448 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1162826795.801:1): initialized
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Activating ISA DMA hang workarounds.
vesafb: framebuffer at 0xfc000000, mapped to 0xdf880000, using 3072k, total 
16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: protected mode interface info at c000:775e
vesafb: pmi: set display start = c00c777f, set palette = c00c77e2
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 1
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Freeing unused kernel memory: 184k freed
Write protecting the kernel read-only data: 274k
input: AT Translated Set 2 keyboard as /class/input/input0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:04.0
ACPI: Unable to derive IRQ for device 0000:00:04.0
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xeff0-0xeff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xeff8-0xefff, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N020ATDA04-0, ATA DISK drive
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1806KiB Cache, CHS=38760/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
ts: Compaq touchscreen protocol output
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 11, io mem 0xf7eff000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected ALi M1644 chipset
agpgart: AGP aperture is 64M @ 0xf0000000
Yenta: CardBus bridge found at 0000:00:10.0 [12a3:ab01]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:10.0, mfunc 0x01000002, devctl 0x60
ohci_hcd 0000:00:02.0: wakeup
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000059
Yenta: CardBus bridge found at 0000:00:11.0 [1179:0001]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
pccard: PCMCIA card inserted into slot 0
ohci_hcd 0000:00:02.0: wakeup
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xe0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
Yenta: CardBus bridge found at 0000:00:11.1 [1179:0001]
wlags49_h1_cs v7.18 for PCMCIA, 03/31/2004 14:31:00 by Agere Systems, 
http://www.agere.com
*** Modified for kernel 2.6 by Andrey Borzenkov <arvidjaar@mail.ru> $Revision: 
27 $
*** Station Mode (STA) Support: YES
*** Access Point Mode (AP) Support: YES
eth0: PRI 31 variant 2 version 9.48
eth0: NIC 5 variant 2 version 1.02
eth0: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Transitioning device [FAN] to D3
ACPI: Transitioning device [FAN] to D3
ACPI: Fan [FAN] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
Time: acpi_pm clocksource has been installed.
ACPI: Thermal Zone [THRM] (54 C)
toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
ACPI: Video Device [VGA] (multi-head: yes  rom: yes  post: no)
ohci_hcd 0000:00:02.0: wakeup
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: 
dm-devel@redhat.com
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
loop: loaded (max 8 devices)
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
Adding 500432k swap on /dev/hda1.  Priority:-1 extents:1 across:500432k
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: remove, state 1
usb usb1: USB disconnect, address 1

=========================================================
[ INFO: possible irq lock inversion dependency detected ]
- ---------------------------------------------------------
rmmod/1514 just changed the state of lock:
 (hcd_data_lock){-+..}, at: [<dfca30bf>] hcd_endpoint_disable+0x3f/0x140 
[usbcore]
but this lock was taken by another, hard-irq-safe lock in the past:
 (&ohci->lock){++..}

and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
1 lock held by rmmod/1514:
 #0:  (usb_bus_list_lock){--..}, at: [<c02ada91>] mutex_lock+0x21/0x30

the first lock's dependencies:
- -> (hcd_data_lock){-+..} ops: 0 {
   initial-use  at:
                        [<c0133ccd>] lock_acquire+0x5d/0x80
                        [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                        [<dfca3ea6>] hcd_submit_urb+0x36/0x950 [usbcore]
                        [<dfca4acc>] usb_submit_urb+0x19c/0x200 [usbcore]
                        [<dfca537e>] usb_start_wait_urb+0x3e/0xf0 [usbcore]
                        [<dfca565b>] usb_control_msg+0xcb/0xf0 [usbcore]
                        [<dfca5fe8>] usb_get_descriptor+0x88/0xc0 [usbcore]
                        [<dfca62e3>] usb_get_device_descriptor+0x63/0x90 
[usbcore]
                        [<dfca37ca>] usb_add_hcd+0x2fa/0x5a0 [usbcore]
                        [<dfcaca6f>] usb_hcd_pci_probe+0x19f/0x2b0 [usbcore]
                        [<c01ca83e>] pci_device_probe+0x5e/0x80
                        [<c021f974>] driver_probe_device+0x44/0xc0
                        [<c021fb25>] __driver_attach+0xa5/0xb0
                        [<c021f2d9>] bus_for_each_dev+0x49/0x70
                        [<c021f8b9>] driver_attach+0x19/0x20
                        [<c021eef1>] bus_add_driver+0x71/0x140
                        [<c021fdbd>] driver_register+0x5d/0x90
                        [<c01ca9f0>] __pci_register_driver+0x50/0x70
                        [<df820038>] 0xdf820038
                        [<c013948d>] sys_init_module+0x12d/0x17c0
                        [<c0103009>] sysenter_past_esp+0x56/0x8d
   in-softirq-W at:
                        [<c0133ccd>] lock_acquire+0x5d/0x80
                        [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                        [<dfca2e9f>] urb_unlink+0x2f/0x60 [usbcore]
                        [<dfca2ee7>] usb_hcd_giveback_urb+0x17/0x60 [usbcore]
                        [<dfca3b2f>] usb_hcd_suspend_root_hub+0x6f/0x90 
[usbcore]
                        [<df86c46a>] ohci_bus_suspend+0xfa/0x1d0 [ohci_hcd]
                        [<df86db22>] ohci_hub_status_data+0x242/0x260 
[ohci_hcd]
                        [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 
[usbcore]
                        [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
                        [<c0122359>] run_timer_softirq+0x159/0x180
                        [<c011e785>] __do_softirq+0x55/0xc0
                        [<c011e836>] do_softirq+0x46/0x50
                        [<c011ec65>] irq_exit+0x35/0x40
                        [<c01054bd>] do_IRQ+0x4d/0xa0
                        [<c0103a75>] common_interrupt+0x25/0x2c
                        [<c0179213>] vfs_readdir+0x73/0x90
                        [<c017929d>] sys_getdents64+0x6d/0xd0
                        [<c0103009>] sysenter_past_esp+0x56/0x8d
   hardirq-on-W at:
                        [<c0133ccd>] lock_acquire+0x5d/0x80
                        [<c02aedec>] _spin_lock+0x2c/0x40
                        [<dfca30bf>] hcd_endpoint_disable+0x3f/0x140 [usbcore]
                        [<dfca4c4d>] usb_disable_endpoint+0x3d/0x60 [usbcore]
                        [<dfca4dc7>] usb_disable_device+0x37/0x100 [usbcore]
                        [<dfca0f74>] usb_disconnect+0xa4/0x100 [usbcore]
                        [<dfca2d6b>] usb_remove_hcd+0x7b/0xd0 [usbcore]
                        [<dfcac870>] usb_hcd_pci_remove+0x20/0x80 [usbcore]
                        [<c01ca6a9>] pci_device_remove+0x19/0x30
                        [<c021f874>] __device_release_driver+0x64/0x90
                        [<c021fc53>] driver_detach+0xe3/0xe5
                        [<c021ee1c>] bus_remove_driver+0x6c/0x90
                        [<c021fd4b>] driver_unregister+0xb/0x20
                        [<c01ca873>] pci_unregister_driver+0x13/0x80
                        [<df86dfed>] ohci_hcd_pci_cleanup+0xd/0x15 [ohci_hcd]
                        [<c0138c35>] sys_delete_module+0x145/0x1b0
                        [<c0103009>] sysenter_past_esp+0x56/0x8d
 }
 ... key      at: [<dfcbeb9c>] hcd_data_lock+0x1c/0xfffef9e9 [usbcore]

the second lock's dependencies:
- -> (&ohci->lock){++..} ops: 0 {
   initial-use  at:
                        [<c0133ccd>] lock_acquire+0x5d/0x80
                        [<c02af102>] _spin_lock_irq+0x32/0x40
                        [<df86c141>] ohci_run+0x131/0x360 [ohci_hcd]
                        [<df86cabc>] ohci_pci_start+0x5c/0x140 [ohci_hcd]
                        [<dfca3748>] usb_add_hcd+0x278/0x5a0 [usbcore]
                        [<dfcaca6f>] usb_hcd_pci_probe+0x19f/0x2b0 [usbcore]
                        [<c01ca83e>] pci_device_probe+0x5e/0x80
                        [<c021f974>] driver_probe_device+0x44/0xc0
                        [<c021fb25>] __driver_attach+0xa5/0xb0
                        [<c021f2d9>] bus_for_each_dev+0x49/0x70
                        [<c021f8b9>] driver_attach+0x19/0x20
                        [<c021eef1>] bus_add_driver+0x71/0x140
                        [<c021fdbd>] driver_register+0x5d/0x90
                        [<c01ca9f0>] __pci_register_driver+0x50/0x70
                        [<df820038>] 0xdf820038
                        [<c013948d>] sys_init_module+0x12d/0x17c0
                        [<c0103009>] sysenter_past_esp+0x56/0x8d
   in-hardirq-W at:
                        [<c0133ccd>] lock_acquire+0x5d/0x80
                        [<c02aedec>] _spin_lock+0x2c/0x40
                        [<df86d797>] ohci_irq+0x87/0x1d0 [ohci_hcd]
                        [<dfca3c17>] usb_hcd_irq+0x27/0x60 [usbcore]
                        [<c0146d43>] handle_IRQ_event+0x33/0x70
                        [<c0146e09>] __do_IRQ+0x89/0x110
                        [<c01054b8>] do_IRQ+0x48/0xa0
                        [<c0103a75>] common_interrupt+0x25/0x2c
                        [<df86c474>] ohci_bus_suspend+0x104/0x1d0 [ohci_hcd]
                        [<df86db22>] ohci_hub_status_data+0x242/0x260 
[ohci_hcd]
                        [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 
[usbcore]
                        [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
                        [<c0122359>] run_timer_softirq+0x159/0x180
                        [<c011e785>] __do_softirq+0x55/0xc0
                        [<c011e836>] do_softirq+0x46/0x50
                        [<c011ec65>] irq_exit+0x35/0x40
                        [<c01054bd>] do_IRQ+0x4d/0xa0
                        [<c0103a75>] common_interrupt+0x25/0x2c
                        [<c0179213>] vfs_readdir+0x73/0x90
                        [<c017929d>] sys_getdents64+0x6d/0xd0
                        [<c0103009>] sysenter_past_esp+0x56/0x8d
   in-softirq-W at:
                        [<c0133ccd>] lock_acquire+0x5d/0x80
                        [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                        [<df86d907>] ohci_hub_status_data+0x27/0x260 
[ohci_hcd]
                        [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 
[usbcore]
                        [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
                        [<c0122359>] run_timer_softirq+0x159/0x180
                        [<c011e785>] __do_softirq+0x55/0xc0
                        [<c011e836>] do_softirq+0x46/0x50
                        [<c011ec65>] irq_exit+0x35/0x40
                        [<c01054bd>] do_IRQ+0x4d/0xa0
                        [<c0103a75>] common_interrupt+0x25/0x2c
                        [<c0179213>] vfs_readdir+0x73/0x90
                        [<c017929d>] sys_getdents64+0x6d/0xd0
                        [<c0103009>] sysenter_past_esp+0x56/0x8d
 }
 ... key      at: [<df870684>] __key.16907+0x0/0xffffd971 [ohci_hcd]
 -> (hcd_root_hub_lock){++..} ops: 0 {
    initial-use  at:
                          [<c0133ccd>] lock_acquire+0x5d/0x80
                          [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                          [<dfca40cb>] hcd_submit_urb+0x25b/0x950 [usbcore]
                          [<dfca4acc>] usb_submit_urb+0x19c/0x200 [usbcore]
                          [<dfca047f>] hub_activate+0x2f/0xa0 [usbcore]
                          [<dfca16ad>] hub_probe+0x59d/0x730 [usbcore]
                          [<dfca6ca8>] usb_probe_interface+0x68/0xa0 [usbcore]
                          [<c021f974>] driver_probe_device+0x44/0xc0
                          [<c021f9f8>] __device_attach+0x8/0x10
                          [<c021f1c7>] bus_for_each_drv+0x57/0x80
                          [<c021fa76>] device_attach+0x76/0x80
                          [<c021ee5e>] bus_attach_device+0x1e/0x40
                          [<c021defc>] device_add+0x26c/0x330
                          [<dfca5e00>] usb_set_configuration+0x330/0x490 
[usbcore]
                          [<dfca0da5>] usb_new_device+0x1d5/0x300 [usbcore]
                          [<dfca3917>] usb_add_hcd+0x447/0x5a0 [usbcore]
                          [<dfcaca6f>] usb_hcd_pci_probe+0x19f/0x2b0 [usbcore]
                          [<c01ca83e>] pci_device_probe+0x5e/0x80
                          [<c021f974>] driver_probe_device+0x44/0xc0
                          [<c021fb25>] __driver_attach+0xa5/0xb0
                          [<c021f2d9>] bus_for_each_dev+0x49/0x70
                          [<c021f8b9>] driver_attach+0x19/0x20
                          [<c021eef1>] bus_add_driver+0x71/0x140
                          [<c021fdbd>] driver_register+0x5d/0x90
                          [<c01ca9f0>] __pci_register_driver+0x50/0x70
                          [<df820038>] 0xdf820038
                          [<c013948d>] sys_init_module+0x12d/0x17c0
                          [<c0103009>] sysenter_past_esp+0x56/0x8d
    in-hardirq-W at:
                          [<c0133ccd>] lock_acquire+0x5d/0x80
                          [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                          [<dfca3a89>] usb_hcd_resume_root_hub+0x19/0x50 
[usbcore]
                          [<df86d838>] ohci_irq+0x128/0x1d0 [ohci_hcd]
                          [<dfca3c17>] usb_hcd_irq+0x27/0x60 [usbcore]
                          [<c0146d43>] handle_IRQ_event+0x33/0x70
                          [<c0146e09>] __do_IRQ+0x89/0x110
                          [<c01054b8>] do_IRQ+0x48/0xa0
                          [<c0103a75>] common_interrupt+0x25/0x2c
                          [<df86c474>] ohci_bus_suspend+0x104/0x1d0 [ohci_hcd]
                          [<df86db22>] ohci_hub_status_data+0x242/0x260 
[ohci_hcd]
                          [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 
[usbcore]
                          [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
                          [<c0122359>] run_timer_softirq+0x159/0x180
                          [<c011e785>] __do_softirq+0x55/0xc0
                          [<c011e836>] do_softirq+0x46/0x50
                          [<c011ec65>] irq_exit+0x35/0x40
                          [<c01054bd>] do_IRQ+0x4d/0xa0
                          [<c0103a75>] common_interrupt+0x25/0x2c
                          [<c0179213>] vfs_readdir+0x73/0x90
                          [<c017929d>] sys_getdents64+0x6d/0xd0
                          [<c0103009>] sysenter_past_esp+0x56/0x8d
    in-softirq-W at:
                          [<c0133ccd>] lock_acquire+0x5d/0x80
                          [<c02aedec>] _spin_lock+0x2c/0x40
                          [<dfca3ad1>] usb_hcd_suspend_root_hub+0x11/0x90 
[usbcore]
                          [<df86c46a>] ohci_bus_suspend+0xfa/0x1d0 [ohci_hcd]
                          [<df86db22>] ohci_hub_status_data+0x242/0x260 
[ohci_hcd]
                          [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 
[usbcore]
                          [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
                          [<c0122359>] run_timer_softirq+0x159/0x180
                          [<c011e785>] __do_softirq+0x55/0xc0
                          [<c011e836>] do_softirq+0x46/0x50
                          [<c011ec65>] irq_exit+0x35/0x40
                          [<c01054bd>] do_IRQ+0x4d/0xa0
                          [<c0103a75>] common_interrupt+0x25/0x2c
                          [<c0179213>] vfs_readdir+0x73/0x90
                          [<c017929d>] sys_getdents64+0x6d/0xd0
                          [<c0103009>] sysenter_past_esp+0x56/0x8d
  }
  ... key      at: [<dfcbeb5c>] hcd_root_hub_lock+0x1c/0xfffefa29 [usbcore]
  -> (base_lock_keys + cpu){++..} ops: 0 {
     initial-use  at:
                            [<c0133ccd>] lock_acquire+0x5d/0x80
                            [<c02af102>] _spin_lock_irq+0x32/0x40
                            [<c0122229>] run_timer_softirq+0x29/0x180
                            [<c011e785>] __do_softirq+0x55/0xc0
                            [<c011e836>] do_softirq+0x46/0x50
                            [<c011ec65>] irq_exit+0x35/0x40
                            [<c01054bd>] do_IRQ+0x4d/0xa0
                            [<c0103a75>] common_interrupt+0x25/0x2c
                            [<00000000>] 0x0
     in-hardirq-W at:
                            [<c0133ccd>] lock_acquire+0x5d/0x80
                            [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                            [<c0122f83>] lock_timer_base+0x23/0x50
                            [<c0123049>] __mod_timer+0x29/0xb0
                            [<c0123134>] mod_timer+0x14/0x40
                            [<c022e7a2>] i8042_interrupt+0x22/0x240
                            [<c0146d43>] handle_IRQ_event+0x33/0x70
                            [<c0146e09>] __do_IRQ+0x89/0x110
                            [<c01054b8>] do_IRQ+0x48/0xa0
                            [<c0103a75>] common_interrupt+0x25/0x2c
                            [<c011a0bb>] printk+0x1b/0x20
                            [<c03cdacc>] acpi_sleep_init+0x26/0x92
                            [<c0100300>] init+0x80/0x290
                            [<c0101005>] kernel_thread_helper+0x5/0x10
     in-softirq-W at:
                            [<c0133ccd>] lock_acquire+0x5d/0x80
                            [<c02af102>] _spin_lock_irq+0x32/0x40
                            [<c0122229>] run_timer_softirq+0x29/0x180
                            [<c011e785>] __do_softirq+0x55/0xc0
                            [<c011e836>] do_softirq+0x46/0x50
                            [<c011ec65>] irq_exit+0x35/0x40
                            [<c01054bd>] do_IRQ+0x4d/0xa0
                            [<c0103a75>] common_interrupt+0x25/0x2c
                            [<00000000>] 0x0
   }
   ... key      at: [<c0413a34>] base_lock_keys+0x0/0xc
  ... acquired at:
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
   [<c0122f83>] lock_timer_base+0x23/0x50
   [<c0123049>] __mod_timer+0x29/0xb0
   [<c0123134>] mod_timer+0x14/0x40
   [<dfca46e4>] hcd_submit_urb+0x874/0x950 [usbcore]
   [<dfca4acc>] usb_submit_urb+0x19c/0x200 [usbcore]
   [<dfca047f>] hub_activate+0x2f/0xa0 [usbcore]
   [<dfca16ad>] hub_probe+0x59d/0x730 [usbcore]
   [<dfca6ca8>] usb_probe_interface+0x68/0xa0 [usbcore]
   [<c021f974>] driver_probe_device+0x44/0xc0
   [<c021f9f8>] __device_attach+0x8/0x10
   [<c021f1c7>] bus_for_each_drv+0x57/0x80
   [<c021fa76>] device_attach+0x76/0x80
   [<c021ee5e>] bus_attach_device+0x1e/0x40
   [<c021defc>] device_add+0x26c/0x330
   [<dfca5e00>] usb_set_configuration+0x330/0x490 [usbcore]
   [<dfca0da5>] usb_new_device+0x1d5/0x300 [usbcore]
   [<dfca3917>] usb_add_hcd+0x447/0x5a0 [usbcore]
   [<dfcaca6f>] usb_hcd_pci_probe+0x19f/0x2b0 [usbcore]
   [<c01ca83e>] pci_device_probe+0x5e/0x80
   [<c021f974>] driver_probe_device+0x44/0xc0
   [<c021fb25>] __driver_attach+0xa5/0xb0
   [<c021f2d9>] bus_for_each_dev+0x49/0x70
   [<c021f8b9>] driver_attach+0x19/0x20
   [<c021eef1>] bus_add_driver+0x71/0x140
   [<c021fdbd>] driver_register+0x5d/0x90
   [<c01ca9f0>] __pci_register_driver+0x50/0x70
   [<df820038>] 0xdf820038
   [<c013948d>] sys_init_module+0x12d/0x17c0
   [<c0103009>] sysenter_past_esp+0x56/0x8d

  -> (hub_event_lock){++..} ops: 0 {
     initial-use  at:
                            [<c0133ccd>] lock_acquire+0x5d/0x80
                            [<c02af102>] _spin_lock_irq+0x32/0x40
                            [<dfca199a>] hub_thread+0x1a/0xbc0 [usbcore]
                            [<c012cb25>] kthread+0xd5/0xe0
                            [<c0101005>] kernel_thread_helper+0x5/0x10
     in-hardirq-W at:
                            [<c0133ccd>] lock_acquire+0x5d/0x80
                            [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                            [<dfc9fcc8>] kick_khubd+0x18/0x70 [usbcore]
                            [<dfc9fd3e>] usb_resume_root_hub+0x1e/0x20 
[usbcore]
                            [<dfca3a9c>] usb_hcd_resume_root_hub+0x2c/0x50 
[usbcore]
                            [<df86d838>] ohci_irq+0x128/0x1d0 [ohci_hcd]
                            [<dfca3c17>] usb_hcd_irq+0x27/0x60 [usbcore]
                            [<c0146d43>] handle_IRQ_event+0x33/0x70
                            [<c0146e09>] __do_IRQ+0x89/0x110
                            [<c01054b8>] do_IRQ+0x48/0xa0
                            [<c0103a75>] common_interrupt+0x25/0x2c
                            [<df86c474>] ohci_bus_suspend+0x104/0x1d0 
[ohci_hcd]
                            [<df86db22>] ohci_hub_status_data+0x242/0x260 
[ohci_hcd]
                            [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 
[usbcore]
                            [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
                            [<c0122359>] run_timer_softirq+0x159/0x180
                            [<c011e785>] __do_softirq+0x55/0xc0
                            [<c011e836>] do_softirq+0x46/0x50
                            [<c011ec65>] irq_exit+0x35/0x40
                            [<c01054bd>] do_IRQ+0x4d/0xa0
                            [<c0103a75>] common_interrupt+0x25/0x2c
                            [<c0179213>] vfs_readdir+0x73/0x90
                            [<c017929d>] sys_getdents64+0x6d/0xd0
                            [<c0103009>] sysenter_past_esp+0x56/0x8d
     in-softirq-W at:
                            [<c0133ccd>] lock_acquire+0x5d/0x80
                            [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                            [<dfc9fcc8>] kick_khubd+0x18/0x70 [usbcore]
                            [<dfc9fd3e>] usb_resume_root_hub+0x1e/0x20 
[usbcore]
                            [<dfca3a9c>] usb_hcd_resume_root_hub+0x2c/0x50 
[usbcore]
                            [<df86d838>] ohci_irq+0x128/0x1d0 [ohci_hcd]
                            [<dfca3c17>] usb_hcd_irq+0x27/0x60 [usbcore]
                            [<c0146d43>] handle_IRQ_event+0x33/0x70
                            [<c0146e09>] __do_IRQ+0x89/0x110
                            [<c01054b8>] do_IRQ+0x48/0xa0
                            [<c0103a75>] common_interrupt+0x25/0x2c
                            [<df86c474>] ohci_bus_suspend+0x104/0x1d0 
[ohci_hcd]
                            [<df86db22>] ohci_hub_status_data+0x242/0x260 
[ohci_hcd]
                            [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 
[usbcore]
                            [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
                            [<c0122359>] run_timer_softirq+0x159/0x180
                            [<c011e785>] __do_softirq+0x55/0xc0
                            [<c011e836>] do_softirq+0x46/0x50
                            [<c011ec65>] irq_exit+0x35/0x40
                            [<c01054bd>] do_IRQ+0x4d/0xa0
                            [<c0103a75>] common_interrupt+0x25/0x2c
                            [<c0179213>] vfs_readdir+0x73/0x90
                            [<c017929d>] sys_getdents64+0x6d/0xd0
                            [<c0103009>] sysenter_past_esp+0x56/0x8d
   }
   ... key      at: [<dfcbe7bc>] hub_event_lock+0x1c/0xfffefdc9 [usbcore]
   -> (khubd_wait.lock){++..} ops: 0 {
      initial-use  at:
                              [<c0133ccd>] lock_acquire+0x5d/0x80
                              [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                              [<c012ce6e>] prepare_to_wait+0x1e/0x70
                              [<dfca1cd7>] hub_thread+0x357/0xbc0 [usbcore]
                              [<c012cb25>] kthread+0xd5/0xe0
                              [<c0101005>] kernel_thread_helper+0x5/0x10
      in-hardirq-W at:
                              [<c0133ccd>] lock_acquire+0x5d/0x80
                              [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                              [<c011525b>] __wake_up+0x1b/0x50
                              [<dfc9fd04>] kick_khubd+0x54/0x70 [usbcore]
                              [<dfc9fd3e>] usb_resume_root_hub+0x1e/0x20 
[usbcore]
                              [<dfca3a9c>] usb_hcd_resume_root_hub+0x2c/0x50 
[usbcore]
                              [<df86d838>] ohci_irq+0x128/0x1d0 [ohci_hcd]
                              [<dfca3c17>] usb_hcd_irq+0x27/0x60 [usbcore]
                              [<c0146d43>] handle_IRQ_event+0x33/0x70
                              [<c0146e09>] __do_IRQ+0x89/0x110
                              [<c01054b8>] do_IRQ+0x48/0xa0
                              [<c0103a75>] common_interrupt+0x25/0x2c
                              [<df86c474>] ohci_bus_suspend+0x104/0x1d0 
[ohci_hcd]
                              [<df86db22>] ohci_hub_status_data+0x242/0x260 
[ohci_hcd]
                              [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 
[usbcore]
                              [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
                              [<c0122359>] run_timer_softirq+0x159/0x180
                              [<c011e785>] __do_softirq+0x55/0xc0
                              [<c011e836>] do_softirq+0x46/0x50
                              [<c011ec65>] irq_exit+0x35/0x40
                              [<c01054bd>] do_IRQ+0x4d/0xa0
                              [<c0103a75>] common_interrupt+0x25/0x2c
                              [<c0179213>] vfs_readdir+0x73/0x90
                              [<c017929d>] sys_getdents64+0x6d/0xd0
                              [<c0103009>] sysenter_past_esp+0x56/0x8d
      in-softirq-W at:
                              [<c0133ccd>] lock_acquire+0x5d/0x80
                              [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                              [<c011525b>] __wake_up+0x1b/0x50
                              [<dfc9fd04>] kick_khubd+0x54/0x70 [usbcore]
                              [<dfc9fd3e>] usb_resume_root_hub+0x1e/0x20 
[usbcore]
                              [<dfca3a9c>] usb_hcd_resume_root_hub+0x2c/0x50 
[usbcore]
                              [<df86d838>] ohci_irq+0x128/0x1d0 [ohci_hcd]
                              [<dfca3c17>] usb_hcd_irq+0x27/0x60 [usbcore]
                              [<c0146d43>] handle_IRQ_event+0x33/0x70
                              [<c0146e09>] __do_IRQ+0x89/0x110
                              [<c01054b8>] do_IRQ+0x48/0xa0
                              [<c0103a75>] common_interrupt+0x25/0x2c
                              [<df86c474>] ohci_bus_suspend+0x104/0x1d0 
[ohci_hcd]
                              [<df86db22>] ohci_hub_status_data+0x242/0x260 
[ohci_hcd]
                              [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 
[usbcore]
                              [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
                              [<c0122359>] run_timer_softirq+0x159/0x180
                              [<c011e785>] __do_softirq+0x55/0xc0
                              [<c011e836>] do_softirq+0x46/0x50
                              [<c011ec65>] irq_exit+0x35/0x40
                              [<c01054bd>] do_IRQ+0x4d/0xa0
                              [<c0103a75>] common_interrupt+0x25/0x2c
                              [<c0179213>] vfs_readdir+0x73/0x90
                              [<c017929d>] sys_getdents64+0x6d/0xd0
                              [<c0103009>] sysenter_past_esp+0x56/0x8d
    }
    ... key      at: [<dfcbe7fc>] khubd_wait+0x1c/0xfffefd89 [usbcore]
    -> (&rq->rq_lock_key){++..} ops: 0 {
       initial-use  at:
                                [<c0133ccd>] lock_acquire+0x5d/0x80
                                [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                                [<c011545c>] init_idle+0x4c/0x80
                                [<c03c6982>] sched_init+0xe2/0xf0
                                [<c03b656d>] start_kernel+0x5d/0x360
                                [<00000000>] 0x0
       in-hardirq-W at:
                                [<c0133ccd>] lock_acquire+0x5d/0x80
                                [<c02aedec>] _spin_lock+0x2c/0x40
                                [<c0115557>] scheduler_tick+0xc7/0x300
                                [<c0123206>] update_process_times+0x46/0x70
                                [<c01067b1>] timer_interrupt+0x41/0xa0
                                [<c0146d43>] handle_IRQ_event+0x33/0x70
                                [<c0146e09>] __do_IRQ+0x89/0x110
                                [<c01054b8>] do_IRQ+0x48/0xa0
                                [<c0103a75>] common_interrupt+0x25/0x2c
                                [<c03bc1a8>] populate_rootfs+0x58/0x100
                                [<c01002b5>] init+0x35/0x290
                                [<c0101005>] kernel_thread_helper+0x5/0x10
       in-softirq-W at:
                                [<c0133ccd>] lock_acquire+0x5d/0x80
                                [<c02aedec>] _spin_lock+0x2c/0x40
                                [<c0115ad7>] task_rq_lock+0x17/0x20
                                [<c0115c20>] try_to_wake_up+0x20/0x120
                                [<c0115d2b>] default_wake_function+0xb/0x10
                                [<c0114dc9>] __wake_up_common+0x39/0x70
                                [<c01151bd>] complete+0x3d/0x60
                                [<c012a74b>] wakeme_after_rcu+0xb/0x10
                                [<c012a8e9>] 
__rcu_process_callbacks+0x69/0x1c0
                                [<c012aa52>] rcu_process_callbacks+0x12/0x30
                                [<c011e880>] tasklet_action+0x40/0x90
                                [<c011e785>] __do_softirq+0x55/0xc0
                                [<c011e836>] do_softirq+0x46/0x50
                                [<c011ec65>] irq_exit+0x35/0x40
                                [<c01054bd>] do_IRQ+0x4d/0xa0
                                [<c0103a75>] common_interrupt+0x25/0x2c
                                [<c0101c59>] cpu_idle+0x39/0x50
                                [<c010052e>] rest_init+0x1e/0x30
                                [<c03b67c3>] start_kernel+0x2b3/0x360
                                [<00000000>] 0x0
     }
     ... key      at: [<c03f1d54>] per_cpu__runqueues+0x954/0x95c
    ... acquired at:
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [<c02aedec>] _spin_lock+0x2c/0x40
   [<c0115ad7>] task_rq_lock+0x17/0x20
   [<c0115c20>] try_to_wake_up+0x20/0x120
   [<c0115d2b>] default_wake_function+0xb/0x10
   [<c012ccdb>] autoremove_wake_function+0x1b/0x50
   [<c0114dc9>] __wake_up_common+0x39/0x70
   [<c0115277>] __wake_up+0x37/0x50
   [<dfc9fd04>] kick_khubd+0x54/0x70 [usbcore]
   [<dfca049e>] hub_activate+0x4e/0xa0 [usbcore]
   [<dfca16ad>] hub_probe+0x59d/0x730 [usbcore]
   [<dfca6ca8>] usb_probe_interface+0x68/0xa0 [usbcore]
   [<c021f974>] driver_probe_device+0x44/0xc0
   [<c021f9f8>] __device_attach+0x8/0x10
   [<c021f1c7>] bus_for_each_drv+0x57/0x80
   [<c021fa76>] device_attach+0x76/0x80
   [<c021ee5e>] bus_attach_device+0x1e/0x40
   [<c021defc>] device_add+0x26c/0x330
   [<dfca5e00>] usb_set_configuration+0x330/0x490 [usbcore]
   [<dfca0da5>] usb_new_device+0x1d5/0x300 [usbcore]
   [<dfca3917>] usb_add_hcd+0x447/0x5a0 [usbcore]
   [<dfcaca6f>] usb_hcd_pci_probe+0x19f/0x2b0 [usbcore]
   [<c01ca83e>] pci_device_probe+0x5e/0x80
   [<c021f974>] driver_probe_device+0x44/0xc0
   [<c021fb25>] __driver_attach+0xa5/0xb0
   [<c021f2d9>] bus_for_each_dev+0x49/0x70
   [<c021f8b9>] driver_attach+0x19/0x20
   [<c021eef1>] bus_add_driver+0x71/0x140
   [<c021fdbd>] driver_register+0x5d/0x90
   [<c01ca9f0>] __pci_register_driver+0x50/0x70
   [<df820038>] 0xdf820038
   [<c013948d>] sys_init_module+0x12d/0x17c0
   [<c0103009>] sysenter_past_esp+0x56/0x8d

   ... acquired at:
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
   [<c011525b>] __wake_up+0x1b/0x50
   [<dfc9fd04>] kick_khubd+0x54/0x70 [usbcore]
   [<dfca049e>] hub_activate+0x4e/0xa0 [usbcore]
   [<dfca16ad>] hub_probe+0x59d/0x730 [usbcore]
   [<dfca6ca8>] usb_probe_interface+0x68/0xa0 [usbcore]
   [<c021f974>] driver_probe_device+0x44/0xc0
   [<c021f9f8>] __device_attach+0x8/0x10
   [<c021f1c7>] bus_for_each_drv+0x57/0x80
   [<c021fa76>] device_attach+0x76/0x80
   [<c021ee5e>] bus_attach_device+0x1e/0x40
   [<c021defc>] device_add+0x26c/0x330
   [<dfca5e00>] usb_set_configuration+0x330/0x490 [usbcore]
   [<dfca0da5>] usb_new_device+0x1d5/0x300 [usbcore]
   [<dfca3917>] usb_add_hcd+0x447/0x5a0 [usbcore]
   [<dfcaca6f>] usb_hcd_pci_probe+0x19f/0x2b0 [usbcore]
   [<c01ca83e>] pci_device_probe+0x5e/0x80
   [<c021f974>] driver_probe_device+0x44/0xc0
   [<c021fb25>] __driver_attach+0xa5/0xb0
   [<c021f2d9>] bus_for_each_dev+0x49/0x70
   [<c021f8b9>] driver_attach+0x19/0x20
   [<c021eef1>] bus_add_driver+0x71/0x140
   [<c021fdbd>] driver_register+0x5d/0x90
   [<c01ca9f0>] __pci_register_driver+0x50/0x70
   [<df820038>] 0xdf820038
   [<c013948d>] sys_init_module+0x12d/0x17c0
   [<c0103009>] sysenter_past_esp+0x56/0x8d

  ... acquired at:
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
   [<dfc9fcc8>] kick_khubd+0x18/0x70 [usbcore]
   [<dfc9fd3e>] usb_resume_root_hub+0x1e/0x20 [usbcore]
   [<dfca3a9c>] usb_hcd_resume_root_hub+0x2c/0x50 [usbcore]
   [<df86d838>] ohci_irq+0x128/0x1d0 [ohci_hcd]
   [<dfca3c17>] usb_hcd_irq+0x27/0x60 [usbcore]
   [<c0146d43>] handle_IRQ_event+0x33/0x70
   [<c0146e09>] __do_IRQ+0x89/0x110
   [<c01054b8>] do_IRQ+0x48/0xa0
   [<c0103a75>] common_interrupt+0x25/0x2c
   [<df86c474>] ohci_bus_suspend+0x104/0x1d0 [ohci_hcd]
   [<df86db22>] ohci_hub_status_data+0x242/0x260 [ohci_hcd]
   [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 [usbcore]
   [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
   [<c0122359>] run_timer_softirq+0x159/0x180
   [<c011e785>] __do_softirq+0x55/0xc0
   [<c011e836>] do_softirq+0x46/0x50
   [<c011ec65>] irq_exit+0x35/0x40
   [<c01054bd>] do_IRQ+0x4d/0xa0
   [<c0103a75>] common_interrupt+0x25/0x2c
   [<c0179213>] vfs_readdir+0x73/0x90
   [<c017929d>] sys_getdents64+0x6d/0xd0
   [<c0103009>] sysenter_past_esp+0x56/0x8d

 ... acquired at:
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [<c02aedec>] _spin_lock+0x2c/0x40
   [<dfca3ad1>] usb_hcd_suspend_root_hub+0x11/0x90 [usbcore]
   [<df86c46a>] ohci_bus_suspend+0xfa/0x1d0 [ohci_hcd]
   [<df86db22>] ohci_hub_status_data+0x242/0x260 [ohci_hcd]
   [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 [usbcore]
   [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
   [<c0122359>] run_timer_softirq+0x159/0x180
   [<c011e785>] __do_softirq+0x55/0xc0
   [<c011e836>] do_softirq+0x46/0x50
   [<c011ec65>] irq_exit+0x35/0x40
   [<c01054bd>] do_IRQ+0x4d/0xa0
   [<c0103a75>] common_interrupt+0x25/0x2c
   [<c0179213>] vfs_readdir+0x73/0x90
   [<c017929d>] sys_getdents64+0x6d/0xd0
   [<c0103009>] sysenter_past_esp+0x56/0x8d

 -> (hcd_data_lock){-+..} ops: 0 {
    initial-use  at:
                          [<c0133ccd>] lock_acquire+0x5d/0x80
                          [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                          [<dfca3ea6>] hcd_submit_urb+0x36/0x950 [usbcore]
                          [<dfca4acc>] usb_submit_urb+0x19c/0x200 [usbcore]
                          [<dfca537e>] usb_start_wait_urb+0x3e/0xf0 [usbcore]
                          [<dfca565b>] usb_control_msg+0xcb/0xf0 [usbcore]
                          [<dfca5fe8>] usb_get_descriptor+0x88/0xc0 [usbcore]
                          [<dfca62e3>] usb_get_device_descriptor+0x63/0x90 
[usbcore]
                          [<dfca37ca>] usb_add_hcd+0x2fa/0x5a0 [usbcore]
                          [<dfcaca6f>] usb_hcd_pci_probe+0x19f/0x2b0 [usbcore]
                          [<c01ca83e>] pci_device_probe+0x5e/0x80
                          [<c021f974>] driver_probe_device+0x44/0xc0
                          [<c021fb25>] __driver_attach+0xa5/0xb0
                          [<c021f2d9>] bus_for_each_dev+0x49/0x70
                          [<c021f8b9>] driver_attach+0x19/0x20
                          [<c021eef1>] bus_add_driver+0x71/0x140
                          [<c021fdbd>] driver_register+0x5d/0x90
                          [<c01ca9f0>] __pci_register_driver+0x50/0x70
                          [<df820038>] 0xdf820038
                          [<c013948d>] sys_init_module+0x12d/0x17c0
                          [<c0103009>] sysenter_past_esp+0x56/0x8d
    in-softirq-W at:
                          [<c0133ccd>] lock_acquire+0x5d/0x80
                          [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                          [<dfca2e9f>] urb_unlink+0x2f/0x60 [usbcore]
                          [<dfca2ee7>] usb_hcd_giveback_urb+0x17/0x60 
[usbcore]
                          [<dfca3b2f>] usb_hcd_suspend_root_hub+0x6f/0x90 
[usbcore]
                          [<df86c46a>] ohci_bus_suspend+0xfa/0x1d0 [ohci_hcd]
                          [<df86db22>] ohci_hub_status_data+0x242/0x260 
[ohci_hcd]
                          [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 
[usbcore]
                          [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
                          [<c0122359>] run_timer_softirq+0x159/0x180
                          [<c011e785>] __do_softirq+0x55/0xc0
                          [<c011e836>] do_softirq+0x46/0x50
                          [<c011ec65>] irq_exit+0x35/0x40
                          [<c01054bd>] do_IRQ+0x4d/0xa0
                          [<c0103a75>] common_interrupt+0x25/0x2c
                          [<c0179213>] vfs_readdir+0x73/0x90
                          [<c017929d>] sys_getdents64+0x6d/0xd0
                          [<c0103009>] sysenter_past_esp+0x56/0x8d
    hardirq-on-W at:
                          [<c0133ccd>] lock_acquire+0x5d/0x80
                          [<c02aedec>] _spin_lock+0x2c/0x40
                          [<dfca30bf>] hcd_endpoint_disable+0x3f/0x140 
[usbcore]
                          [<dfca4c4d>] usb_disable_endpoint+0x3d/0x60 
[usbcore]
                          [<dfca4dc7>] usb_disable_device+0x37/0x100 [usbcore]
                          [<dfca0f74>] usb_disconnect+0xa4/0x100 [usbcore]
                          [<dfca2d6b>] usb_remove_hcd+0x7b/0xd0 [usbcore]
                          [<dfcac870>] usb_hcd_pci_remove+0x20/0x80 [usbcore]
                          [<c01ca6a9>] pci_device_remove+0x19/0x30
                          [<c021f874>] __device_release_driver+0x64/0x90
                          [<c021fc53>] driver_detach+0xe3/0xe5
                          [<c021ee1c>] bus_remove_driver+0x6c/0x90
                          [<c021fd4b>] driver_unregister+0xb/0x20
                          [<c01ca873>] pci_unregister_driver+0x13/0x80
                          [<df86dfed>] ohci_hcd_pci_cleanup+0xd/0x15 
[ohci_hcd]
                          [<c0138c35>] sys_delete_module+0x145/0x1b0
                          [<c0103009>] sysenter_past_esp+0x56/0x8d
  }
  ... key      at: [<dfcbeb9c>] hcd_data_lock+0x1c/0xfffef9e9 [usbcore]
 ... acquired at:
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
   [<dfca2e9f>] urb_unlink+0x2f/0x60 [usbcore]
   [<dfca2ee7>] usb_hcd_giveback_urb+0x17/0x60 [usbcore]
   [<dfca3b2f>] usb_hcd_suspend_root_hub+0x6f/0x90 [usbcore]
   [<df86c46a>] ohci_bus_suspend+0xfa/0x1d0 [ohci_hcd]
   [<df86db22>] ohci_hub_status_data+0x242/0x260 [ohci_hcd]
   [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 [usbcore]
   [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
   [<c0122359>] run_timer_softirq+0x159/0x180
   [<c011e785>] __do_softirq+0x55/0xc0
   [<c011e836>] do_softirq+0x46/0x50
   [<c011ec65>] irq_exit+0x35/0x40
   [<c01054bd>] do_IRQ+0x4d/0xa0
   [<c0103a75>] common_interrupt+0x25/0x2c
   [<c0179213>] vfs_readdir+0x73/0x90
   [<c017929d>] sys_getdents64+0x6d/0xd0
   [<c0103009>] sysenter_past_esp+0x56/0x8d


stack backtrace:
 [<c0104195>] show_trace_log_lvl+0x185/0x1a0
 [<c01047a2>] show_trace+0x12/0x20
 [<c0104879>] dump_stack+0x19/0x20
 [<c0131c37>] print_irq_inversion_bug+0x107/0x130
 [<c0131d92>] check_usage_backwards+0x42/0x50
 [<c013201f>] mark_lock+0x18f/0x5c0
 [<c0132d96>] __lock_acquire+0x106/0xd00
 [<c0133ccd>] lock_acquire+0x5d/0x80
 [<c02aedec>] _spin_lock+0x2c/0x40
 [<dfca30bf>] hcd_endpoint_disable+0x3f/0x140 [usbcore]
 [<dfca4c4d>] usb_disable_endpoint+0x3d/0x60 [usbcore]
 [<dfca4dc7>] usb_disable_device+0x37/0x100 [usbcore]
 [<dfca0f74>] usb_disconnect+0xa4/0x100 [usbcore]
 [<dfca2d6b>] usb_remove_hcd+0x7b/0xd0 [usbcore]
 [<dfcac870>] usb_hcd_pci_remove+0x20/0x80 [usbcore]
 [<c01ca6a9>] pci_device_remove+0x19/0x30
 [<c021f874>] __device_release_driver+0x64/0x90
 [<c021fc53>] driver_detach+0xe3/0xe5
 [<c021ee1c>] bus_remove_driver+0x6c/0x90
 [<c021fd4b>] driver_unregister+0xb/0x20
 [<c01ca873>] pci_unregister_driver+0x13/0x80
 [<df86dfed>] ohci_hcd_pci_cleanup+0xd/0x15 [ohci_hcd]
 [<c0138c35>] sys_delete_module+0x145/0x1b0
 [<c0103009>] sysenter_past_esp+0x56/0x8d
 [<b7fa8410>] 0xb7fa8410
ohci_hcd 0000:00:02.0: USB bus 1 deregistered
ACPI: PCI interrupt for device 0000:00:02.0 disabled
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFT1XgR6LMutpd94wRAvGFAKCI+2N2DvvIu12rcKRbW0buM8l7qgCfQQ7k
qvnyQBWD93UOY32Np9XQEzE=
=5IDC
-----END PGP SIGNATURE-----
