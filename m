Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWCNHgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWCNHgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 02:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWCNHgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 02:36:09 -0500
Received: from math.ut.ee ([193.40.36.2]:1505 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932096AbWCNHgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 02:36:07 -0500
Date: Tue, 14 Mar 2006 09:36:05 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: New libata PATA patch for 2.6.16-rc1
In-Reply-To: <1142299273.25773.39.camel@localhost.localdomain>
Message-ID: <Pine.SOC.4.61.0603140931590.17208@math.ut.ee>
References: <20060313195722.6ADBF1401F@rhn.tartu-labor> 
 <Pine.SOC.4.61.0603132202080.14431@math.ut.ee> <1142299273.25773.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also tried on a Intel 7221 board with 4 SATA disks on AHCI and one PATA 
cdrom (also onboard ICH6R/ICH6RW) and it crashed on first read from sda. 
But the crash is slightly different than the early read crashes before - 
maybe it's just by accident, maybe it is just another variation. The 
server works fine without the patch, currently running 2.6.15.1.

Linux version 2.6.16-rc6-PATA (mroos@rhn) (gcc version 4.0.3 (Debian 4.0.3-1)) #2 Mon Mar 13 19:33:24 EET 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003f7e557a (usable)
  BIOS-e820: 000000003f7e557a - 000000003f7f0000 (reserved)
  BIOS-e820: 000000003f7f0000 - 000000003f7fe000 (ACPI data)
  BIOS-e820: 000000003f7fe000 - 000000003f800000 (ACPI NVS)
  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
DMI 2.3 present.
Allocating PCI resources starting at 40000000 (gap: 3f800000:c0000000)
Built 1 zonelists
Kernel command line: root=/dev/sr0 init=/bin/bash libata.atapi_enabled=1 vga=0xf07 netconsole=1980@192.168.74.66/eth0,1975@192.168.74.17/00:03:47:a4:64:d5 BOOT_IMAGE=vmlinuz 
netconsole: local port 1980
netconsole: local IP 192.168.74.66
netconsole: interface eth0
netconsole: remote port 1975
netconsole: remote IP 192.168.74.17
netconsole: remote ethernet address 00:03:47:a4:64:d5
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0483000 soft=c0484000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2992.883 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x60
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 905276k/917504k available (2398k kernel code, 11820k reserved, 917k data, 252k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5992.55 BogoMIPS (lpj=29962776)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=4
PCI: Using configuration type 1
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5610
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x629a, dseg 0xf0000
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2640] at 0000:00:1f.0
PCI: Found IRQ 7 for device 0000:00:1f.1
PCI: Sharing IRQ 7 with 0000:00:1d.2
PCI: Sharing IRQ 7 with 0000:01:03.0
pnp: 00:0c: ioport range 0x5a0-0x5a7 has been reserved
pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0d: ioport range 0xcf8-0xcff could not be reserved
pnp: 00:0d: ioport range 0x480-0x4bf has been reserved
pnp: 00:0d: ioport range 0x800-0x87f has been reserved
pnp: 00:0d: ioport range 0x540-0x55f has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:02:00.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:02:00.2
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
   IO window: e000-efff
   MEM window: dff00000-dfffffff
   PREFETCH window: disabled.
PCI: Found IRQ 10 for device 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:02.0
apm: BIOS not found.
io scheduler noop registered
io scheduler anticipatory registered (default)
0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
PNP: PS/2 Controller [PNP0303] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.3.9-k4-NAPI
Copyright (c) 1999-2005 Intel Corporation.
PCI: Found IRQ 7 for device 0000:01:03.0
PCI: Sharing IRQ 7 with 0000:00:1d.2
PCI: Sharing IRQ 7 with 0000:00:1f.1
e1000: 0000:01:03.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:4b:5f:68
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq stag pm led slum part 
ata1: SATA max PIO4 cmd 0xF8812D00 ctl 0x0 bmdma 0x0 irq 11
ata2: SATA max PIO4 cmd 0xF8812D80 ctl 0x0 bmdma 0x0 irq 11
ata3: SATA max PIO4 cmd 0xF8812E00 ctl 0x0 bmdma 0x0 irq 11
ata4: SATA max PIO4 cmd 0xF8812E80 ctl 0x0 bmdma 0x0 irq 11
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata1: dev 0 configured for PIO4
scsi0 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata2: dev 0 configured for PIO4
scsi1 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata3: dev 0 configured for PIO4
scsi2 : ahci
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata4: dev 0 configured for PIO4
scsi3 : ahci
   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
PCI: Found IRQ 7 for device 0000:00:1f.1
PCI: Sharing IRQ 7 with 0000:00:1d.2
PCI: Sharing IRQ 7 with 0000:01:03.0
ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFF0 irq 14
ata5: dev 0 ATAPI, max UDMA/33
ata5: dev 0 configured for UDMA/33
scsi4 : ata_piix
   Vendor: TSSTcorp  Model: CD/DVDW SH-W162C  Rev: TS10
   Type:   CD-ROM                             ANSI SCSI revision: 05
ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFFF8 irq 15
ATA: abnormal status 0x7F on port 0x177
ata6: disabling port
scsi5 : ata_piix
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
  sda:<0>divide error: 0000 [#1]
CPU:    0
EIP:    0060:[<c0101707>]    Not tainted VLI
EFLAGS: 00000246   (2.6.16-rc6-PATA #2) 
EIP is at mwait_idle+0x27/0x40
eax: 00000000   ebx: c043e000   ecx: 00000000   edx: 00000000
esi: c043e008   edi: c043a800   ebp: c043efd8   esp: c043efd0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c043e000 task=c03ae300)
Stack: <0>c036c6c2 00039100 c043efe0 c010169d c043efe8 c010025e c043eff8 c043f433
        c0485e20 00020800 004cc007 c0100199 
Call Trace:
  [<c0103177>] show_stack_log_lvl+0xa7/0xf0
  [<c01032fb>] show_registers+0x13b/0x1c0
  [<c0103586>] die+0xc6/0x200
  [<c010389d>] do_trap+0x7d/0xb0
  [<c0103956>] do_divide_error+0x86/0x90
  [<c0102b4f>] error_code+0x4f/0x60
  [<c010169d>] cpu_idle+0x1d/0x60
  [<c010025e>] rest_init+0x1e/0x20
  [<c043f433>] start_kernel+0x1f3/0x250
  [<c0100199>] 0xc0100199
Code: 00 00 00 00 55 89 e5 56 53 fb bb 00 f0 ff ff 21 e3 8d 73 08 eb 15 31 c9 89 f0 89 ca 0f 01 c8 8b 43 08 a8 08 75 0c 89 c8 0f 01 c9 <8b> 43 08 a8 08 74 e4 5b 5e 5d c3 8d b4 26 00 00 00 00 8d bc 27
  <0>Kernel panic - not syncing: Attempted to kill the idle task!


-- 
Meelis Roos (mroos@linux.ee)
