Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWJSOpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWJSOpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWJSOpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:45:12 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:59153 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1946095AbWJSOpG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:45:06 -0400
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm1 // errors in verify_redzone_free()
Date: Thu, 19 Oct 2006 16:45:39 +0200
User-Agent: KMail/1.9.1
References: <20061016230645.fed53c5b.akpm@osdl.org>
In-Reply-To: <20061016230645.fed53c5b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_U+4NF/SLe2NKE+G"
Message-Id: <200610191645.40308.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_U+4NF/SLe2NKE+G
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

	Multiple of verif were found with 2.6.19-rc2-mm1 kernel:

slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f4e410>] 0xb7f4e410
 =======================
dd20cb64: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50 
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f4e410>] 0xb7f4e410

Full dmesg and config attached. System info:

Linux orion 2.6.19-rc2 #3 PREEMPT Thu Oct 19 16:04:17 CEST 2006 i686 Intel(R) 
Pentium(R) 4 CPU 2.40GHz GNU/Linux
 
Gnu C                  4.1.1
Gnu make               3.81
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
pcmcia-cs              3.2.8
nfs-utils              1.0.6
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   087
Modules Loaded         orinoco_cs orinoco hermes pcmcia firmware_class 
yenta_socket rsrc_nonstatic pcmcia_core

Regards,

	Mariusz Kozlowski

--Boundary-00=_U+4NF/SLe2NKE+G
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.6.19-rc2 (root@orion) (gcc version 4.1.1 (Gentoo 4.1.1)) #3 PREEMPT Thu Oct 19 16:04:17 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001df70000 (usable)
 BIOS-e820: 000000001df70000 - 000000001df7c000 (ACPI data)
 BIOS-e820: 000000001df7c000 - 000000001df80000 (ACPI NVS)
 BIOS-e820: 000000001df80000 - 000000001e000000 (reserved)
 BIOS-e820: 000000002df80000 - 000000002e000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
479MB LOWMEM available.
Entering add_active_range(0, 0, 122736) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   122736
early_node_map[1] active PFN ranges
    0:        0 ->   122736
On node 0 totalpages: 122736
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 926 pages used for memmap
  Normal zone: 117714 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6fe0
ACPI: RSDT (v001 SONY   K7       0x06040000  LTP 0x00000000) @ 0x1df774d1
ACPI: FADT (v001 SONY   K7       0x06040000 PTL  0x000f4240) @ 0x1df7bf64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1df7bfd8
ACPI: DSDT (v001  SONY  K7       0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 30000000 (gap: 2e000000:d1f80000)
Detected 2392.397 MHz processor.
Built 1 zonelists.  Total pages: 121778
Kernel command line: root=/dev/hda3 vga=0x318 video=vesafb:mtrr
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:failed|failed|  ok  |failed|failed|failed|
                 A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
                    double unlock:  ok  |  ok  |failed|  ok  |failed|failed|
                  initialize held:failed|failed|failed|failed|failed|failed|
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |failed|
           recursive read-lock #2:             |  ok  |             |failed|
            mixed read-write-lock:             |failed|             |failed|
            mixed write-read-lock:             |failed|             |failed|
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
         hard-safe-A + irqs-on/12:failed|failed|  ok  |
         soft-safe-A + irqs-on/12:failed|failed|  ok  |
         hard-safe-A + irqs-on/21:failed|failed|  ok  |
         soft-safe-A + irqs-on/21:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
      hard-irq lock-inversion/123:failed|failed|  ok  |
      soft-irq lock-inversion/123:failed|failed|  ok  |
      hard-irq lock-inversion/132:failed|failed|  ok  |
      soft-irq lock-inversion/132:failed|failed|  ok  |
      hard-irq lock-inversion/213:failed|failed|  ok  |
      soft-irq lock-inversion/213:failed|failed|  ok  |
      hard-irq lock-inversion/231:failed|failed|  ok  |
      soft-irq lock-inversion/231:failed|failed|  ok  |
      hard-irq lock-inversion/312:failed|failed|  ok  |
      soft-irq lock-inversion/312:failed|failed|  ok  |
      hard-irq lock-inversion/321:failed|failed|  ok  |
      soft-irq lock-inversion/321:failed|failed|  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
--------------------------------------------------------
142 out of 218 testcases failed, as expected. |
----------------------------------------------------
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 481312k/490944k available (2923k kernel code, 9088k reserved, 964k data, 184k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffff8000 - 0xfffff000   (  28 kB)
    vmalloc : 0xde800000 - 0xffff6000   ( 535 MB)
    lowmem  : 0xc0000000 - 0xddf70000   ( 479 MB)
      .init : 0xc0536000 - 0xc0564000   ( 184 kB)
      .data : 0xc03dadba - 0xc04cc00c   ( 964 kB)
      .text : 0xc0100000 - 0xc03dadba   (2923 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4786.48 BogoMIPS (lpj=2393240)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebf9ff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0c00)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8a0, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 8000-803f claimed by ali7101 ACPI
PCI quirk: region 8040-805f claimed by ali7101 SMB
Boot video device is 0000:01:05.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 *10 11)
ACPI: PCI Interrupt Link [LNK5] (IRQs 10) *11
ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: Embedded Controller [EC0] (gpe 24) interrupt mode.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:05: ioport range 0x40b-0x40b has been reserved
pnp: 00:05: ioport range 0x480-0x48f has been reserved
pnp: 00:05: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:05: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:05: ioport range 0x8000-0x807f could not be reserved
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.2[C] -> Link [LNK5] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[f0404000-f04047ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: f0500000-f05fffff
  PREFETCH window: f8000000-fbffffff
PCI: Bus 2, cardbus bridge: 0000:00:0a.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 6, cardbus bridge: 0000:00:0a.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNK2] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNK4] -> GSI 10 (level, low) -> IRQ 10
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x35 set to 0x1
Machine check exception polling timer started.
Initializing RT-Tester: OK
audit: initializing netlink socket (disabled)
audit(1161275627.516:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/W].
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Activating ISA DMA hang workarounds.
vesafb: framebuffer at 0xf8000000, mapped to 0xde880000, using 4608k, total 32704k
vesafb: mode is 1024x768x24, linelength=3072, pages=13
vesafb: protected mode interface info at c000:51eb
vesafb: pmi: set display start = c00c527f, set palette = c00c52cb
vesafb: pmi: ports = a010 a016 a054 a038 a03c a05c a000 a004 a0b0 a0b2 a0b4 
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PBTN]
ACPI: Lid Switch [LID]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [TZ01] (50 C)
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected Ati IGP345M chipset
agpgart: AGP aperture is 64M @ 0xf4000000
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 11
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK0] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.25.0 20060524 on minor 0
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
ACPI: Unable to derive IRQ for device 0000:00:0f.0
ACPI: PCI Interrupt 0000:00:0f.0[A]: no GSI
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x80c0-0x80c7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x80c8-0x80cf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HITACHI_DK23EA-30, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0800460301683fec]
hdc: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=58140/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ieee1394: raw1394: /dev/raw1394 device initialized
ACPI: PCI Interrupt 0000:00:0c.2[C] -> Link [LNK5] -> GSI 10 (level, low) -> IRQ 10
PCI: VIA IRQ fixup for 0000:00:0c.2, from 11 to 10
ehci_hcd 0000:00:0c.2: EHCI Host Controller
ehci_hcd 0000:00:0c.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0c.2: irq 10, io mem 0xf0404800
ehci_hcd 0000:00:0c.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNK2] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:0c.0: UHCI Host Controller
uhci_hcd 0000:00:0c.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:0c.0: irq 11, io base 0x00008080
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:0c.1[B] -> Link [LNK4] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:0c.1: UHCI Host Controller
uhci_hcd 0000:00:0c.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:0c.1: irq 10, io base 0x000080a0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-2: new low speed USB device using uhci_hcd and address 2
usb 2-2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
input: Logitech USB-PS/2 Optical Mouse as /class/input/input0
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:0c.0-2
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.0.1 Oct 19 2006
Advanced Linux Sound Architecture Driver Version 1.0.13 (Fri Oct 06 18:28:19 2006 UTC).
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNK7] -> GSI 11 (level, low) -> IRQ 11
input: AT Translated Set 2 keyboard as /class/input/input1
input: PS/2 Mouse as /class/input/input2
input: AlpsPS/2 ALPS GlidePoint as /class/input/input3
AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
ali mixer 1 creating error.
ALSA device list:
  #0: ALI 5451 at 0x8800, irq 11
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 184k freed
warning: process `touch' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
EXT3 FS on hda3, internal journal
warning: process `touch' used the removed sysctl system call
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1 across:498004k
warning: process `touch' used the removed sysctl system call
Yenta: CardBus bridge found at 0000:00:0a.0 [104d:8158]
Yenta: ISA IRQ mask 0x0028, PCI irq 11
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:0a.1 [104d:8158]
Yenta: ISA IRQ mask 0x0028, PCI irq 10
Socket status: 30000410
pccard: PCMCIA card inserted into slot 1
pcmcia: Detected deprecated PCMCIA ioctl usage from process: cardmgr.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x200-0x207 0x220-0x22f 0x330-0x337 0x388-0x38f 0x3f8-0x3ff
cs: IO port probe 0x100-0x4ff: excluding 0x200-0x207 0x220-0x22f 0x330-0x337 0x388-0x38f 0x3f8-0x3ff
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_cs 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
pcmcia: registering new device pcmcia1.0
eth0: Hardware identity 0001:0001:0004:0000
eth0: Station identity  001f:0001:0008:0048
eth0: Firmware determined as Lucent/Agere 8.72
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:E0:63:82:2D:3F
eth0: Station name "HERMES I"
eth0: ready
eth0: orinoco_cs at 1.0, irq 3, io 0x0100-0x013f
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f4e410>] 0xb7f4e410
 =======================
dd20cb64: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f4e410>] 0xb7f4e410
 =======================
dd20cb64: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f96410>] 0xb7f96410
 =======================
dd20cab4: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f96410>] 0xb7f96410
 =======================
dd20cab4: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f8a410>] 0xb7f8a410
 =======================
dd20cab4: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f8a410>] 0xb7f8a410
 =======================
dd20cab4: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
eth0: New link status: Connected (0001)
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7fa2410>] 0xb7fa2410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f2c410>] 0xb7f2c410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f2c410>] 0xb7f2c410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7eef410>] 0xb7eef410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7eef410>] 0xb7eef410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f59410>] 0xb7f59410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
mtrr: 0xf8000000,0x4000000 overlaps existing 0xf8000000,0x2000000
mtrr: 0xf8000000,0x4000000 overlaps existing 0xf8000000,0x2000000
mtrr: 0xf8000000,0x4000000 overlaps existing 0xf8000000,0x2000000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 4x mode
[drm] Setting GART location based on old memory map
[drm] writeback test succeeded in 1 usecs
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 4x mode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 4x mode

--Boundary-00=_U+4NF/SLe2NKE+G
Content-Type: text/plain;
  charset="iso-8859-1";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.19-rc2
# Thu Oct 19 15:48:47 2006
#
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
# CONFIG_HPET_TIMER is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=0x100000
CONFIG_COMPAT_VDSO=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION="/dev/hda2"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MULTITHREAD_PROBE is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_I82365=m
CONFIG_TCIC=m
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=m

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=m
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set
CONFIG_WIRELESS_EXT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_INITRD=y
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
# CONFIG_ATA is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=y

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set
# CONFIG_IEEE1394_EXPORT_FULL_API is not set

#
# Device Drivers
#

#
# Texas Instruments PCILynx requires I2C
#
CONFIG_IEEE1394_OHCI1394=y

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
# CONFIG_IEEE1394_SBP2 is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=y

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
# CONFIG_NET_WIRELESS_RTNETLINK is not set

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_AIRO is not set
CONFIG_HERMES=m
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
# CONFIG_NORTEL_HERMES is not set
# CONFIG_PCI_HERMES is not set
# CONFIG_ATMEL is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
# CONFIG_PCMCIA_SPECTRUM is not set
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
# CONFIG_USB_ZD1201 is not set
# CONFIG_HOSTAP is not set
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=m

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
CONFIG_AGP_ATI=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set

#
# SPI Protocol Masters
#

#
# Dallas's 1-wire bus
#

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set
# CONFIG_TIFM_CORE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=y
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_AC97_BUS=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_ADLIB is not set
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_MIRO is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set
# CONFIG_SND_WAVEFRONT is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=y
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_AC97_POWER_SAVE is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set
# CONFIG_USB_TRANCEVIBRATOR is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
CONFIG_MMC=m
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_BLOCK=m
CONFIG_MMC_SDHCI=m
CONFIG_MMC_WBSD=m
# CONFIG_MMC_TIFM_SD is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
CONFIG_EDAC=y

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=y
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
CONFIG_EDAC_POLL=y

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=1250
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-2"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp1250"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-2"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_RT_MUTEX_TESTER=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_RWSEMS=y
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_LIST=y
CONFIG_FRAME_POINTER=y
CONFIG_UNWIND_INFO=y
CONFIG_STACK_UNWIND=y
CONFIG_FORCED_INLINING=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACK_USAGE is not set

#
# Page alloc debug is incompatible with Software Suspend on i386
#
# CONFIG_DEBUG_RODATA is not set
# CONFIG_4KSTACKS is not set
CONFIG_DOUBLEFAULT=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_AUDIT_GENERIC=y
CONFIG_PLIST=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y

--Boundary-00=_U+4NF/SLe2NKE+G--
