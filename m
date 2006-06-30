Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWF3HHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWF3HHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWF3HHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:07:33 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:19163 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932074AbWF3HHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:07:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pzjS4749RTI57xHkSNhhvhY7htByvkATGcdhotCaB4oOo71X87go1htkUt6wFCCNmpx7i0O/EpEvlkpWLpfK4w94fswcI+/EPerxnpgOhoRfCDogHZttEgYsXx+QbIVyuTX4ehXTfyu4q16/VEw6nPLXUQ+lqkeX77dFoynigyQ=
Message-ID: <a44ae5cd0606300007i2f353423wa07f9e44d8d69062@mail.gmail.com>
Date: Fri, 30 Jun 2006 00:07:30 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm4 -- BUG: illegal lock usage! -- illegal {hardirq-on-W} -> {in-hardirq-W} usage.
In-Reply-To: <a44ae5cd0606292318n5a788a30xa1c28ed4fc973056@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0606292318n5a788a30xa1c28ed4fc973056@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a kernel developer's request for a full dmesg capture for a
similar BUG: report,
I am adding the full output for this report as well.  If this is not
desirable, please let me know.

Thanks,
                      Miles

Linux version 2.6.17-mm4miles (root@Dumbleedor) (gcc version 4.1.2
20060613 (prerelease) (Ubuntu 4.1.1-2ubuntu4)) #17 PREEMPT Thu Jun 29
19:12:13 PDT 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009f800 end:
000000000009f800 type: 1
copy_e820_map() type is E820_RAM
add_memory_region(0000000000000000, 000000000009f800, 1)
copy_e820_map() start: 000000000009f800 size: 0000000000000800 end:
00000000000a0000 type: 2
add_memory_region(000000000009f800, 0000000000000800, 2)
copy_e820_map() start: 00000000000ce000 size: 0000000000002000 end:
00000000000d0000 type: 2
add_memory_region(00000000000ce000, 0000000000002000, 2)
copy_e820_map() start: 00000000000dc000 size: 0000000000024000 end:
0000000000100000 type: 2
add_memory_region(00000000000dc000, 0000000000024000, 2)
copy_e820_map() start: 0000000000100000 size: 000000003dde0000 end:
000000003dee0000 type: 1
copy_e820_map() type is E820_RAM
add_memory_region(0000000000100000, 000000003dde0000, 1)
copy_e820_map() start: 000000003dee0000 size: 000000000000c000 end:
000000003deec000 type: 3
add_memory_region(000000003dee0000, 000000000000c000, 3)
copy_e820_map() start: 000000003deec000 size: 0000000000014000 end:
000000003df00000 type: 4
add_memory_region(000000003deec000, 0000000000014000, 4)
copy_e820_map() start: 000000003df00000 size: 0000000002100000 end:
0000000040000000 type: 2
add_memory_region(000000003df00000, 0000000002100000, 2)
copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end:
00000000fec10000 type: 2
add_memory_region(00000000fec00000, 0000000000010000, 2)
copy_e820_map() start: 00000000fee00000 size: 0000000000001000 end:
00000000fee01000 type: 2
add_memory_region(00000000fee00000, 0000000000001000, 2)
copy_e820_map() start: 00000000ff800000 size: 0000000000400000 end:
00000000ffc00000 type: 2
add_memory_region(00000000ff800000, 0000000000400000, 2)
copy_e820_map() start: 00000000fffffc00 size: 0000000000000400 end:
0000000100000000 type: 2
add_memory_region(00000000fffffc00, 0000000000000400, 2)
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003dee0000 (usable)
 BIOS-e820: 000000003dee0000 - 000000003deec000 (ACPI data)
 BIOS-e820: 000000003deec000 - 000000003df00000 (ACPI NVS)
 BIOS-e820: 000000003df00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
94MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 253664
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 24288 pages, LIFO batch:3
DMI present.
ACPI: RSDP (v000 HP                                    ) @ 0x000f7e00
ACPI: RSDT (v001 HP     09B8     0x06040000  LTP 0x00000000) @ 0x3dee76bb
ACPI: FADT (v001 HP     09B8     0x06040000 PTL  0x00000050) @ 0x3deebe8c
ACPI: HPET (v001 HP     09B8     0x06040000 PTL  0x00000000) @ 0x3deebf00
ACPI: MADT (v001 HP     09B8     0x06040000 PTL  0x00000050) @ 0x3deebf38
ACPI: MADT (v001 HP     09B8     0x06040000 PTL  0x00000000) @ 0x3deebf92
ACPI: BOOT (v001 HP     09B8     0x06040000  LTP 0x00000001) @ 0x3deebfd8
ACPI: SSDT (v001 HP     09B8     0x00000001 INTL 0x20030224) @ 0x3dee7afe
ACPI: SSDT (v001 HP     09B8     0x00002000 INTL 0x20030224) @ 0x3dee76fb
ACPI: DSDT (v001 HP     09B8     0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: HPET id: 0x8086a201 base: 0x0
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 1695.815 MHz processor.
Built 1 zonelists.  Total pages: 253664
Kernel command line: root=/dev/hda10 ro vga=0x027e pci=assign-busses
quiet splash
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c139b000 soft=c139a000
PID hash table entries: 4096 (order: 12, 16384 bytes)
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
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
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
-------------------------------------------------------
Good, all 218 testcases passed! |
---------------------------------
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 999856k/1014656k available (2057k kernel code, 14300k
reserved, 954k data, 204k init, 97152k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3394.71 BogoMIPS
(lpj=6789427)Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000
00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbbf 00000000 00000000 00000000 00000180
00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbbf 00000000 00000000 00000040
00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Pentium(R) M processor 1.70GHz stepping 06
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060623
ACPI: setting ELCR to 0200 (from 0c38)
PM: Adding info for No Bus:platform
Time:  5:20:36  Date: 05/30/106
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9c2, last bus=2
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:00.1
PM: Adding info for pci:0000:00:00.3
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:02.1
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:00:1f.5
PM: Adding info for pci:0000:00:1f.6
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:01:06.0
PM: Adding info for pci:0000:01:09.0
PM: Adding info for pci:0000:01:09.2
PM: Adding info for pci:0000:01:09.3
PM: Adding info for pci:0000:01:09.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
ACPI: PCI Interrupt Link [LNKC] (IRQs *4)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3)
ACPI: PCI Interrupt Link [LNKE] (IRQs *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *4)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3)
ACPI: Embedded Controller [H_EC] (gpe 29) interrupt mode.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
pnp: PnP ACPI: found 7 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bus 2, cardbus bridge: 0000:01:09.0
  IO window: 00003400-000034ff
  IO window: 00003800-000038ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 54000000-55ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: e0200000-e02fffff
  PREFETCH window: 50000000-51ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Device `[CBUS]' is not power manageableACPI: PCI Interrupt Link [LNKE] enabled
at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:09.0[A] -> Link [LNKE] -> GSI 11 (level,
low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 32768 (order: 9, 3145728 bytes)
TCP bind hash table entries: 16384 (order: 8, 1638400 bytes)
TCP: Hash tables configured (established 32768 bind 16384)
TCP reno registered
PM: Adding info for platform:pcspkr
Simple Boot Flag at 0x36 set to 0x1
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
Initializing RT-Tester: OK
audit: initializing netlink socket (disabled)
audit(1151644836.488:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
fuse init (API version 7.7)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci 0000:00:1d.0: uhci_check_and_reset_hc: legsup = 0x003b
pci 0000:00:1d.0: Performing full reset
pci 0000:00:1d.1: uhci_check_and_reset_hc: legsup = 0x0010
pci 0000:00:1d.1: Performing full reset
pci 0000:00:1d.2: uhci_check_and_reset_hc: legsup = 0x0010
pci 0000:00:1d.2: Performing full reset
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
fakephp: Fake PCI Hot Plug Controller Driver
PM: Adding info for platform:vesafb.0
vesafb: framebuffer at 0xe8000000, mapped to 0xf8880000, using 7680k,
total 32576k
vesafb: mode is 1280x768x32, linelength=5120, pages=7
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 160x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
Device `[MODM]' is not power manageableACPI: PCI Interrupt Link [LNKB] enabled
at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level,
low) -> IRQ 5
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 4 (level,
low) -> IRQ 4
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: FUJITSU MHU2100AT, ATA DISK drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
Probing IDE interface ide1...
hdc: HL-DT-ST DVDRAM GMA-4080N, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 128KiB
hda: 195371568 sectors (100030 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
Yenta: CardBus bridge found at 0000:01:09.0 [103c:3080]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:01:09.0, mfunc 0x01a01b22, devctl 0x64
Yenta: ISA IRQ mask 0x04c8, PCI irq 11
Socket status: 30000820
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe02fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PSM1] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio0
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation
<jketreno@linux.intel.com>ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
Using IPI Shortcut mode
PM: Adding info for serio:serio1
ACPI: (supports S0 S3 S4 S5<6>Time: tsc clocksource has been installed.
)
  Magic number: 10:54:316
Freeing unused kernel memory: 204k freed
Write protecting the kernel read-only data: 370k
Time: acpi_pm clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
pccard: CardBus card inserted into slot 0
PM: Adding info for pci:0000:02:00.0
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.2k
ipw2200: Copyright(c) 2003-2006 Intel Corporation
Device `[MINI]' is not power manageable<6>ACPI: PCI Interrupt
0000:01:06.0[A] -> Link [LNKC] -> GSI 4 (level, low) -> IRQ 4
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Linux agpgart interface v0.101 (c) Dave Jones
input: PC Speaker as /class/input/input1
Synaptics Touchpad, model: 1, fw: 5.10, id: 0x258eb1, caps: 0xa04713/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
ieee1394: Initialized config rom entry `ip1394'
Real Time Clock Driver v1.12ac
agpgart: Detected an Intel 855 Chipset.
agpgart: Detected 32636K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
USB Universal Host Controller Interface driver v3.0
8139too Fast Ethernet driver 0.9.27
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
sdhci: Secure Digital Host Controller Interface driver, 0.12
sdhci: Copyright(c) Pierre Ossman
ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
Device `[LAN]' is not power manageableACPI: PCI Interrupt Link [LNKA]
enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 10 (level,
low) -> IRQ 10
eth1: RealTek RTL8139 at 0xf8810800, 00:c0:9f:95:18:1b, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 10 (level,
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
uhci_hcd 0000:00:1d.0: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:1d.0: Performing full reset
uhci_hcd 0000:00:1d.0: irq 10, io base 0x00001820
usb usb1: default language 0x0409
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-mm4miles uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
PM: Adding info for usb:usb1
usb usb1: uevent
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
PM: Adding info for usb:1-0:1.0
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: trying to enable port power on non-switchable hub
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
PM: Adding info for No Bus:usbdev1.1_ep81
PM: Adding info for No Bus:usbdev1.1
drivers/usb/core/inode.c: creating file '001'
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 3 (level,
low) -> IRQ 3
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
drivers/usb/core/inode.c: creating file '002'
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
uhci_hcd 0000:00:1d.1: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:1d.1: Performing full reset
uhci_hcd 0000:00:1d.1: irq 3, io base 0x00001840
usb usb2: default language 0x0409
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17-mm4miles uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
PM: Adding info for usb:usb2
usb usb2: uevent
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
PM: Adding info for usb:2-0:1.0
usb 2-0:1.0: uevent
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: trying to enable port power on non-switchable hub
hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
PM: Adding info for No Bus:usbdev2.1_ep81
PM: Adding info for No Bus:usbdev2.1
drivers/usb/core/inode.c: creating file '001'
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 4 (level,
low) -> IRQ 4
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
drivers/usb/core/inode.c: creating file '003'
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
uhci_hcd 0000:00:1d.2: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:1d.2: Performing full reset
uhci_hcd 0000:00:1d.2: irq 4, io base 0x00001860
usb usb3: default language 0x0409
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17-mm4miles uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
PM: Adding info for usb:usb3
usb usb3: uevent
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
usb usb3: adding 3-0:1.0 (config #1, interface 0)
PM: Adding info for usb:3-0:1.0
usb 3-0:1.0: uevent
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: trying to enable port power on non-switchable hub
hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
PM: Adding info for No Bus:usbdev3.1_ep81
PM: Adding info for No Bus:usbdev3.1
drivers/usb/core/inode.c: creating file '001'
Device `[USB7]' is not power manageableACPI: PCI Interrupt Link [LNKH] enabled
at IRQ 3
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 3 (level,
low) -> IRQ 3
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
drivers/usb/core/inode.c: creating file '004'
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc
ports=6
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
ehci_hcd 0000:00:1d.7: irq 3, io mem 0xe0100000
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8
period=1024 Reset HALT
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: default language 0x0409
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: EHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.17-mm4miles ehci_hcd
usb usb4: SerialNumber: 0000:00:1d.7
PM: Adding info for usb:usb4
usb usb4: uevent
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
usb usb4: adding 4-0:1.0 (config #1, interface 0)
PM: Adding info for usb:4-0:1.0
usb 4-0:1.0: uevent
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: Single TT
hub 4-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 4-0:1.0: power on to power good time: 20ms
hub 4-0:1.0: local power source is good
hub 4-0:1.0: trying to enable port power on non-switchable hub
hub 4-0:1.0: state 7 ports 6 chg 0000 evt 0000
PM: Adding info for No Bus:usbdev4.1_ep81
PM: Adding info for No Bus:usbdev4.1
drivers/usb/core/inode.c: creating file '001'
Device `[IEEE]' is not power manageableACPI: PCI Interrupt Link [LNKG] enabled
at IRQ 4
ACPI: PCI Interrupt 0000:01:09.2[C] -> Link [LNKG] -> GSI 4 (level,
low) -> IRQ 4
PM: Adding info for ieee1394:fw-host0
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[4]
MMIO=[e0207000-e02077ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
sdhci: SDHCI controller found at 0000:01:09.4 [104c:8034] (rev 0)
sdhci [sdhci_probe()]: found 3 slot(s)
ACPI: PCI Interrupt 0000:01:09.4[A] -> Link [LNKE] -> GSI 11 (level,
low) -> IRQ 11
sdhci [sdhci_probe_slot()]: slot 0 at 0xe0208400, irq 11
sdhci: ============== REGISTER DUMP ==============
sdhci: Sys addr: 0x00000000 | Version:  0x00008400
sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
sdhci: Present:  0x01fa0000 | Host ctl: 0x00000000
sdhci: Power:    0x00000000 | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00000002
sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x00ff00fb | Sig enab: 0x00ff00fb
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
sdhci: Caps:     0x01821090 | Max curr: 0x00000000
sdhci: ===========================================
mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0
mmc0: SDHCI at 0xe0208400 irq 11 DMA
sdhci [sdhci_probe_slot()]: slot 1 at 0xe0208000, irq 11
sdhci: ============== REGISTER DUMP ==============
sdhci: Sys addr: 0x00000000 | Version:  0x00008400
sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
sdhci: Present:  0x00020000 | Host ctl: 0x00000000
sdhci: Power:    0x00000000 | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00000002
sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x00ff00fb | Sig enab: 0x00ff00fb
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
sdhci: Caps:     0x01821090 | Max curr: 0x00000000
sdhci: ===========================================
mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
mmc1: SDHCI at 0xe0208000 irq 11 DMA
sdhci [sdhci_probe_slot()]: slot 2 at 0xe0207c00, irq 11
sdhci: ============== REGISTER DUMP ==============
sdhci: Sys addr: 0x00000000 | Version:  0x00008400
sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
sdhci: Present:  0x000a0000 | Host ctl: 0x00000000
sdhci: Power:    0x00000000 | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00000002
sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x00ff00fb | Sig enab: 0x00ff00fb
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
sdhci: Caps:     0x01821898 | Max curr: 0x00000000
sdhci: ===========================================
mmc2: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
mmc2: SDHCI at 0xe0207c00 irq 11 DMA
Device `[AUD0]' is not power manageable<6>ACPI: PCI Interrupt
0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
mmc0: clock 62500Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0
mmc0: clock 62500Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0
mmc0: starting CMD0 arg 00000000 flags 00000040
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (0)
mmc0: req done (CMD0): 1/0/0: 00000000 00000000 00000000 00000000
mmc0: clock 62500Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0
mmc0: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc0: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc0: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc0: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc0: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc0: starting CMD1 arg 00000000 flags 00000061
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (1)
mmc0: req done (CMD1): 1/0/0: 00000000 00000000 00000000 00000000
mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
mmc1: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0
mmc1: clock 62500Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0
mmc1: clock 62500Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0
mmc1: starting CMD0 arg 00000000 flags 00000040
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (0)
mmc1: req done (CMD0): 1/0/0: 00000000 00000000 00000000 00000000
mmc1: clock 62500Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0
mmc1: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc1: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc1: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc1: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc1: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc1: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc1: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc1: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc1: starting CMD1 arg 00000000 flags 00000061
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (1)
mmc1: req done (CMD1): 1/0/0: 00000000 00000000 00000000 00000000
mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
mmc2: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0
mmc2: clock 93750Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0
mmc2: clock 93750Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0
mmc2: starting CMD0 arg 00000000 flags 00000040
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (0)
mmc2: req done (CMD0): 1/0/0: 00000000 00000000 00000000 00000000
mmc2: clock 93750Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0
mmc2: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc2: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc2: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc2: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc2: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc2: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc2: starting CMD55 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
mmc2: req done (CMD55): 1/0/0: 00000000 00000000 00000000 00000000
mmc2: starting CMD1 arg 00000000 flags 00000061
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (1)
mmc2: req done (CMD1): 1/0/0: 00000000 00000000 00000000 00000000
mmc2: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
intel8x0_measure_ac97_clock: measured 53546 usecs
intel8x0: clocking to 48000
PM: Adding info for ac97:0-0:unknown codec
usb usb1: suspend_rh (auto-stop)
usb usb2: suspend_rh (auto-stop)
usb usb3: suspend_rh (auto-stop)
PM: Adding info for ieee1394:00c09f00004fec18
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00004fec18]
PM: Adding info for ieee1394:00c09f00004fec18-0
lp: driver loaded but no devices found
SCSI subsystem initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
Adding 1052216k swap on /dev/hda8.  Priority:-1 extents:1 across:1052216k
EXT3 FS on hda10, internal journal
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NTFS driver 2.1.27 [Flags: R/O MODULE].
NTFS volume version 3.1.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
Using specific hotkey driver
ACPI: Thermal Zone [THRM] (63 C)
ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
eth0: link down
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6 over IPv4 tunneling driver
[drm] Initialized drm 1.0.1 20051102
Device `[GFX0]' is not power manageable<6>ACPI: PCI Interrupt
0000:00:02.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
[drm] Initialized i915 1.5.0 20060119 on minor 0
[drm] Initialized i915 1.5.0 20060119 on minor 1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
eth1: no IPv6 routers present
eth1: no IPv6 routers present
pccard: card ejected from slot 0
PM: Removing info for pci:0000:02:00.0
PCMCIA: socket c1ebc9e0: *** DANGER *** unable to remove socket power

============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {hardirq-on-W} -> {in-hardirq-W} usage.
swapper/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (&socket->thread_lock){+-..}, at: [<c1181270>] pcmcia_parse_events+0x3e/0x6b
{hardirq-on-W} state was registered at:
  [<c102d1c8>] lock_acquire+0x60/0x80
  [<c120136e>] _spin_lock+0x23/0x32
  [<c1181270>] pcmcia_parse_events+0x3e/0x6b
  [<c1181945>] pcmcia_register_socket+0x29b/0x2fc
  [<c118a8d1>] yenta_probe+0x51b/0x55c
  [<c110d537>] pci_device_probe+0x39/0x5b
  [<c1162598>] driver_probe_device+0x45/0x92
  [<c11626b2>] __driver_attach+0x5c/0x85
  [<c1162022>] bus_for_each_dev+0x36/0x5b
  [<c11624f0>] driver_attach+0x14/0x17
  [<c1161d02>] bus_add_driver+0x6b/0x109
  [<c1162968>] driver_register+0x9d/0xa2
  [<c110d6ab>] __pci_register_driver+0x4f/0x6c
  [<c13760b1>] yenta_socket_init+0xf/0x11
  [<c10002a8>] init+0x88/0x1de
  [<c1001005>] kernel_thread_helper+0x5/0xb
irq event stamp: 11031192
hardirqs last  enabled at (11031191): [<c11408c6>]
acpi_processor_idle+0x1d1/0x35b
hardirqs last disabled at (11031192): [<c1002fcf>] common_interrupt+0x1b/0x2c
softirqs last  enabled at (11031186): [<c101a767>] __do_softirq+0xab/0xb0
softirqs last disabled at (11031171): [<c1004a64>] do_softirq+0x58/0xbd

other info that might help us debug this:
no locks held by swapper/0.

stack backtrace:
 [<c1003502>] show_trace_log_lvl+0x54/0xfd
 [<c1003b6a>] show_trace+0xd/0x10
 [<c1003c0e>] dump_stack+0x19/0x1b
 [<c102b833>] print_usage_bug+0x1cc/0x1d9
 [<c102bc2b>] mark_lock+0x8a/0x360
 [<c102c922>] __lock_acquire+0x38f/0x970
 [<c102d1c8>] lock_acquire+0x60/0x80
 [<c120136e>] _spin_lock+0x23/0x32
 [<c1181270>] pcmcia_parse_events+0x3e/0x6b
 [<c118a3ac>] yenta_interrupt+0xad/0xb7
 [<c103f227>] handle_IRQ_event+0x20/0x50
 [<c103f2cc>] __do_IRQ+0x75/0xc9
 [<c1004b84>] do_IRQ+0xbb/0xcf
 [<c1002fd9>] common_interrupt+0x25/0x2c
pccard: CardBus card inserted into slot 0
PM: Adding info for pci:0000:02:00.0
pccard: card ejected from slot 0
PM: Removing info for pci:0000:02:00.0
PCMCIA: socket c1ebc9e0: *** DANGER *** unable to remove socket power
