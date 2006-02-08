Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWBHHnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWBHHnE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbWBHHnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:43:04 -0500
Received: from math.ut.ee ([193.40.36.2]:39927 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1030574AbWBHHnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:43:02 -0500
Date: Wed, 8 Feb 2006 09:42:58 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: libATA  PATA status report, new patch
In-Reply-To: <1139324653.18391.41.camel@localhost.localdomain>
Message-ID: <Pine.SOC.4.61.0602080939140.24319@math.ut.ee>
References: <20060207084347.54CD01430C@rhn.tartu-labor> 
 <1139310335.18391.2.camel@localhost.localdomain>  <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
  <1139312330.18391.14.camel@localhost.localdomain>
 <1139324653.18391.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've put up a -ide2 patch at
>
> http://zeniv.linux.org.uk/~alan/IDE

Tried also on a Intel 7221 with 1 PATA cdrom and 4 SATA disks attached 
to onboard ICH7 SATA (PIIX mode, not AHCI). Fails basically the same as 
the ICH5 I reported earlier (crash on partition table reading) but the 
output is much more verbose:

Linux version 2.6.16-rc2-PATA (mroos@rhn) (gcc version 4.0.3 20060128 (prerelease) (Debian 4.0.2-8)) #7 Tue Feb 7 18:20:51 EET 2006
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
CPU 0 irqstacks, hard=c0438000 soft=c0439000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2992.802 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x60
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 905580k/917504k available (2174k kernel code, 11496k reserved, 856k data, 240k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5992.59 BogoMIPS (lpj=29962987)
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
0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?)
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
Intel(R) PRO/1000 Network Driver - version 6.3.9-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
PCI: Found IRQ 7 for device 0000:01:03.0
PCI: Sharing IRQ 7 with 0000:00:1d.2
PCI: Sharing IRQ 7 with 0000:00:1f.1
e1000: 0000:01:03.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:4b:5f:68
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
pcnet32.c:v1.31c 01.Nov.2005 tsbogend@alpha.franken.de
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ThunderLAN driver v1.15
TLAN: 0 devices installed, PCI: 0  EISA: 0
ata1: dev 0 ATAPI, max UDMA/33
ata1: dev 0 configured for UDMA/33
scsi0 : ata_piix
   Vendor: TSSTcorp  Model: CD/DVDW SH-W162C  Rev: TS10
   Type:   CD-ROM                             ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFF8 irq 15
ATA: abnormal status 0x7F on port 0x177
ata2: disabling port
scsi1 : ata_piix
PCI: Found IRQ 11 for device 0000:00:1f.2
PCI: Sharing IRQ 11 with 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:00:1f.3
ata3: SATA max UDMA/133 cmd 0xDF80 ctl 0xDF02 bmdma 0xDD80 irq 11
ata4: SATA max UDMA/133 cmd 0xDE80 ctl 0xDE02 bmdma 0xDD88 irq 11
ata3: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata3: dev 1 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata3: dev 0 configured for UDMA/133
ata3: dev 1 configured for UDMA/133
scsi2 : ata_piix
ata4: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata4: dev 1 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata4: dev 0 configured for UDMA/133
ata4: dev 1 configured for UDMA/133
scsi3 : ata_piix
   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
  sda:<0>int3: 0000 [#1]
CPU:    0
EIP:    0060:[<c01016e5>]    Not tainted VLI
EFLAGS: 00000246   (2.6.16-rc2-PATA) 
EIP is at mwait_idle+0x25/0x30
eax: 00000000   ebx: c03f6000   ecx: 00000000   edx: 00000000
esi: c03f6008   edi: c03f3800   ebp: 00480007   esp: c03f6fe4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03f6000 task=c0372200)
Stack: <0>feff0000 00039100 c010167c c03f73f2 c043ae20 00020800 c0100199 
Call Trace:
  [<c010167c>] cpu_idle+0x1c/0x60
  [<c03f73f2>] start_kernel+0x1f2/0x240
Code: 90 90 90 90 90 90 56 53 fb bb 00 f0 ff ff 21 e3 8d 73 08 eb 16 90 31 c9 89 f0 89 ca 0f 01 c8 8b 43 08 0000000b  [<c0114b06>] 
printk+0x13/0x20
die+0x1eb/0x1f0
fixup_exception+0x18/0x60
  [<c01037ba>] do_int3+0x5a/0x70
  [<c031f0fe>] int3+0x1e/0x30
  [<c01016e5>] mwait_idle+0x25/0x30
  [<c010167c>] cpu_idle+0x1c/0x60
  [<c03f73f2>] start_kernel+0x1f2/0x240
Code: c0 01 c3 b8 58 89 41 00 e8 24 2c 0a 00 a1 68 d2 43 c0 8d 04 80 43 8d 04 80 8d 04 80 c1 e0 03 39 c3 7c d6 e8 89 ad 00 00 fb 31 db <8d> b6 00 00 00 00 89 d8 ff 15 6c d2 43 c0 01 c3 b8 58 89 41 00
  <0>Kernel panic - not syncing: Attempted to kill the idle task!
  <0>divide error: 0000 [#3]
CPU:    0
EIP:    0060:[<c010a78b>]    Not tainted VLI
EFLAGS: 00000293   (2.6.16-rc2-PATA) 
EIP is at delay_tsc+0xb/0x20
eax: c6d80e94   ebx: 002db862   ecx: c6cc17c4   edx: 00000027
esi: c0372200   edi: 00000000   ebp: 0000000b   esp: c03f6db0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03f6000 task=c0372200)
Stack: <0>00000002 c01b5309 c0112724 c03f6dcc c03f6000 c0114b06 c0336a88 00000206
        00000000 c033478f c0113573 c0343179 c03f6df0 00000000 00000206 00000000
        c033478f c010349b c03f6edc c03f6edc c010edd8 c03f6edc c033478f 00000000 
Call Trace:
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0<0>Kernel panic - not syncing: Attempted to kill the idle task!
<0>divide error: 0000 [#4]
CPU:    0
EIP:    0060:[<c010a789>]    Not tainted VLI
EFLAGS: 00000287   (2.6.16-rc2-PATA) 
EIP is at delay_tsc+0x9/0x20
eax: 00028a3f   ebx: 002db862   ecx: c89e2c2e   edx: 00000027
esi: c0372200   edi: 00000000   ebp: 0000000b   esp: c03f6c50
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03f6000 task=c0372200)
Stack: <0>00000005 c01b5309 c0112724 c03f6c6c c03f6000 c0114b06 c0336a88 00000206
        00000000 c033478f c0113573 c0343179 c03f6c90 00000000 00000206 00000000
        c033478f c010349b c03f6d7c c03f6d7c c010edd8 c03f6d7c c033478f 00000000 
Call Trace:
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c011270a>] panic+0xba/0xf0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c011270a>] panic+0xba/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01037ba>] do_int3+0x5a/0x70
  [<c031f0fe>] int3+0x1e/0x30
  [<c01016e5>] mwait_idle+0x25/0x30
  [<c010167c>] cpu_idle+0x1c/0x60
  [<c03f73f2>] start_kernel+0x1f2/0x240
Code: ea 0a 01 44 24 08 11 54 24 0c 8b 44 24 08 8b 54 24 0c 83 c4 10 5b 5e 5f 5d c3 90 8d b4 26 00 00 00 00 53 89 c3 0f 31 c1 31 39 f6 5b 8d 00 bc
  <0>Kernel panic - not syncing: Attempted to kill the idle task!
  <0>divide error: 0000 [#5]
CPU:    0
EIP:    0060:[<c010a78b>]    Not tainted VLI
EFLAGS: 00000297   (2.6.16-rc2-PATA) 
EIP is at delay_tsc+0xb/0x20
eax: ca695e98   ebx: 002db862   ecx: ca4ebc8a   edx: 00000027
esi: c0372200   edi: 00000000   ebp: 0000000b   esp: c03f6af0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03f6000 task=c0372200)
Stack: <0>00000003 c01b5309 c0112724 c03f6b0c c03f6000 c0114b06 c0336a88 00000206
        00000000 c033478f c0113573 c0343179 c03f6b30 00000000 00000206 00000000
        c033478f c010349b c03f6c1c c03f6c1c c010edd8 c03f6c1c c033478f 00000000 
Call Trace:
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c011270a>] panic+0xba/0xf0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c011270a>] panic+0xba/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01037ba>] do_int3+0x5a/0x70
  [<c031f0fe>] int3+0x1e/0x30
  [<c01016e5>] mwait_idle+0x25/0x30
  [<c010167c>] cpu_idle+0x1c/0x60
  [<c03f73f2>] start_kernel+0x1f2/0x240
Code: 01 44 24 08 11 54 24 0c 8b 44 24 08 8b 54 24 0c 83 c4 10 5b 5e 5f 5d c3 90 8d b4 26 00 00 00 00 53 89 c3 0f 31 89 c1 f3 90 0f 31 <29> 39 f6 c3 b6 00 00
  <0>Kernel panic - not syncing: Attempted to kill the idle task!
  <0>divide error: 0000 [#6]
CPU:    0
EIP:    0060:[<c010a78b>]    Not tainted VLI
EFLAGS: 00000293   (2.6.16-rc2-PATA) 
EIP is at delay_tsc+0xb/0x20
eax: cc320671   ebx: 002db862   ecx: cc2d0bd3   edx: 00000027
esi: c0372200   edi: 00000000   ebp: 0000000b   esp: c03f6990
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03f6000 task=c0372200)
Stack: <0>00000000 c01b5309 c0112724 c03f69ac c03f6000 c0114b06 c0336a88 00000206
        00000000 c033478f c0113573 c0343179 c03f69d0 00000000 00000206 00000000
        c033478f c010349b c03f6abc c03f6abc c010edd8 c03f6abc c033478f 00000000 
Call Trace:
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a789>] delay_tsc+0x9/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
delay_tsc+0x9/0x20
  [<c01b5309>]
  [<c0112724>]
  [<c0114b06>] do_exit+0x4f6/0x6e0
printk+0x13/0x20
  [<c010349b>]
  [<c010edd8>] fixup_exception+0x18/0x60
do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
delay_tsc+0xb/0x20 [<c029b270>]
  [<c0112847>] __call_console_drivers+0x37/0x50
vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
error_code+0x4f/0x60
  [<c010a78b>]
  [<c01b5309>] __delay+0x9/0x10
panic+0xd4/0xf0
  [<c0114b06>]
  [<c0113573>]
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
panic+0xba/0xf0
  [<c0112847>]
  [<c01134df>] vprintk+0x26f/0x2f0
__call_console_drivers+0x37/0x50
error_code+0x4f/0x60
  [<c011270a>]
  [<c0113573>]
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>]
  [<c01037ba>] do_int3+0x5a/0x70
int3+0x1e/0x30
  [<c01016e5>]
  [<c010167c>]
  [<c03f73f2>] 
Code: 44 11 8b 08 24 c4 10 5b 5e 5f 5d c3 90 8d b4 26 00 00 00 00 53 89 c3 0f 31 89 c1 f3 90 0f 31 c8 72 c3 8d 00 00 27 00 <0>Kernel panic - not syncing: Attempted to kill the idle task!
  <0>divide error: 0000 [#7]
CPU:    0
EIP:    0060:[<c010a78b>]    Not tainted VLI
EFLAGS: 00000283   (2.6.16-rc2-PATA) 
EIP is at delay_tsc+0xb/0x20
eax: cdfaae61   ebx: 002db862   ecx: cdd5de47   edx: 00000027
esi: c0372200   edi: 00000000   ebp: 0000000b   esp: c03f6830
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03f6000 task=c0372200)
Stack: <0>00000000 c01b5309 c0112724 c03f684c c03f6000 c0114b06 c0336a88 00000206
        00000000 c033478f c0113573 c0343179 c03f6870 00000000 00000206 00000000
        c033478f c010349b c03f695c c03f695c c010edd8 c03f695c c033478f 00000000 
Call Trace:
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a789>] delay_tsc+0x9/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a789>] delay_tsc+0x9/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c011270a>] panic+0xba/0xf0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c011270a>] panic+0xba/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01037ba>] do_int3+0x5a/0x70
  [<c031f0fe>] int3+0x1e/0x30
  [<c01016e5>] mwait_idle+0x25/0x30
  [<c010167c>] cpu_idle+0x1c/0x60
  [<c03f73f2>] start_kernel+0x1f2/0x240
Code: 01 44 24 08 11 54 24 0c 8b 44 24 08 8b 54 24 0c 83 c4 10 5b 5e 5f 5d 90 8d 26 00 0f f3 <29> d8 5b c3 b6 00 27 00
  <0>divide error: 0000 [#8]
CPU:    0
EIP:    0060:[<c0103386>]    Not tainted VLI
EFLAGS: 00000206   (2.6.16-rc2-PATA) 
EIP is at die+0xd6/0x1f0

c03f67fc c03f67fc 000000ff 0000000b
        00000000 c010374e 00000000
        00000000 00000086 
Call Trace:
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
do_divide_error+0x8e/0xa0
  [<c010a78b>]
  [<c029b270>] write_msg+0x0/0x50
__call_console_drivers+0x37/0x50
  [<c01134df>]
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
do_divide_error+0x8e/0xa0
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c029b270>]
  [<c0112847>] __call_console_drivers+0x37/0x50
vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
error_code+0x4f/0x60
  [<c010a78b>]
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>]
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>]
  [<c010349b>]
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
do_divide_error+0x8e/0xa0
delay_tsc+0x9/0x20
  [<c029b270>]
  [<c0112847>] __call_console_drivers+0x37/0x50
vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] 
delay_tsc+0x9/0x20
  [<c01b5309>]
  [<c0112724>]
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c011270a>] panic+0xba/0xf0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c011270a>] panic+0xba/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01037ba>] do_int3+0x5a/0x70
  [<c031f0fe>] int3+0x1e/0x30
  [<c01016e5>] mwait_idle+0x25/0x30
  [<c010167c>] cpu_idle+0x1c/0x60
  [<c03f73f2>] start_kernel+0x1f2/0x240
Code: 00 c7 44 24 2c 0b 00 00 00 e8 d7 a0 01 00 89 d8 e8 80 fc ff ff 83 c4 10 31 c0 e8 f6 ad 00 00 c7 05 48 34 37 c0 ff ff ff ff 56 9d <b8> 00 f0 ff ff 21 e0 f7 40 14 00 ff ff 0f 0f 85 ed 00 00 00 8b
  <0>divide error: 0000 [#9]
CPU:    0
EIP:    0060:[<c0103386>]    Not tainted VLI
EFLAGS: 00000206   (2.6.16-rc2-PATA) 
EIP is at die+0xd6/0x1f0
eax: c0343179   ebx: c03f66e4   ecx: f7eceec0   edx: ffff864c
esi: 00000206   edi: 00000000   ebp: c033478f   esp: c03f6600
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03f6000 task=c0372200)
Stack: <0>c03f66e4 c03f66e4 c010edd8 c03f66e4 c033478f 00000000 000000ff 0000000b
        c03f66e4 00000000 c01036c0 c033478f c010374e 00000001 c03f66e4 00000000
        00000008 c0103386 c029b270 
Call Trace:
  [<c010edd8>] fixup_exception+0x18/0x60
do_divide_error+0x0/0xa0
  [<c010374e>]
  [<c0103386>] die+0xd6/0x1f0
write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
vprintk+0x26f/0x2f0
  [<c0102eaa>] show_trace_log_lvl+0x2a/0x80
error_code+0x4f/0x60
die+0xd6/0x1f0
  [<c010edd8>]
  [<c01036c0>] do_divide_error+0x0/0xa0
do_divide_error+0x8e/0xa0
  [<c010a78b>]
  [<c029b270>]
  [<c0112847>] vprintk+0x26f/0x2f0
__call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
delay_tsc+0xb/0x20
__delay+0x9/0x10
panic+0xd4/0xf0
  [<c0114b06>]
  [<c0113573>]
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
do_divide_error+0x0/0xa0
do_divide_error+0x8e/0xa0
delay_tsc+0xb/0x20
write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
vprintk+0x26f/0x2f0
  [<c0112847>] 
error_code+0x4f/0x60
  [<c010a78b>]
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0 [<c010374e>]
  [<c010a789>]
  [<c029b270>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
__call_console_drivers+0x37/0x50
error_code+0x4f/0x60
  [<c010a789>]
  [<c01b5309>]
  [<c0112724>]
  [<c0114b06>] do_exit+0x4f6/0x6e0
printk+0x13/0x20
die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
do_divide_error+0x0/0xa0
do_divide_error+0x8e/0xa0
  [<c010a78b>]
  [<c029b270>] write_msg+0x0/0x50
__call_console_drivers+0x37/0x50
  [<c01134df>]
  [<c0112847>] __call_console_drivers+0x37/0x50
error_code+0x4f/0x60

  [<c01b5309>]
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>]
  [<c0113573>]
  [<c010349b>]
  [<c010edd8>] fixup_exception+0x18/0x60
do_divide_error+0x0/0xa0
do_divide_error+0x8e/0xa0
panic+0xba/0xf0
  [<c0112847>]
  [<c01134df>]
  [<c0112847>] __call_console_drivers+0x37/0x50
error_code+0x4f/0x60
  [<c011270a>] panic+0xba/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01037ba>] do_int3+0x5a/0x70
  [<c031f0fe>] int3+0x1e/0x30
  [<c01016e5>] mwait_idle+0x25/0x30
  [<c010167c>] cpu_idle+0x1c/0x60
  [<c03f73f2>] start_kernel+0x1f2/0x240
Code: 00 c7 44 24 2c 0b 00 00 00 e8 d7 a0 01 00 89 d8 e8 80 fc ff ff 83 c4 10 31 c0 e8 f6 ad 00 00 c7 05 48 34 37 c0 ff ff ff ff 56 9d <b8> 00 f0 ff ff 21 e0 f7 40 14 00 ff ff 0f 0f 85 ed 00 00 00 8b
  <0>divide error: 0000 [#10]
CPU:    0
EIP:    0060:[<c0103386>]    Not tainted VLI
EFLAGS: 00000206   (2.6.16-rc2-PATA) 
EIP is at die+0xd6/0x1f0
eax: c0343179   ebx: c03f65cc   ecx: f7eceec0   edx: ffff7349
esi: 00000206   edi: 00000000   ebp: c033478f   esp: c03f64e8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03f6000 task=c0372200)
Stack: <0>c03f65cc c03f65cc c010edd8 c03f65cc c033478f 00000000 000000ff 0000000b
        c03f65cc 00000000 c01036c0 c033478f c010374e 00000001 c03f65cc 00000000
        c03f652c 00000008 00000000 00030001 c0103386 00000086 c03aea80 c029b270 
Call Trace:
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c0103386>] die+0xd6/0x1f0
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0102eaa>] show_trace_log_lvl+0x2a/0x80
  [<c0102a0f>] error_code+0x4f/0x60
  [<c0103386>] die+0xd6/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
do_divide_error+0x8e/0xa0
  [<c0103386>] die+0xd6/0x1f0
  [<c029b270>]
  [<c0112847>] __call_console_drivers+0x37/0x50
vprintk+0x26f/0x2f0
  [<c0102eaa>] show_trace_log_lvl+0x2a/0x80
error_code+0x4f/0x60
  [<c0103386>]
  [<c010edd8>] fixup_exception+0x18/0x60
do_divide_error+0x0/0xa0
do_divide_error+0x8e/0xa0
  [<c010a78b>]
  [<c029b270>] 
__call_console_drivers+0x37/0x50
  [<c01134df>]
  [<c0112847>] __call_console_drivers+0x37/0x50
error_code+0x4f/0x60
  [<c010a78b>]
  [<c01b5309>] 
panic+0xd4/0xf0
do_exit+0x4f6/0x6e0
die+0x1eb/0x1f0
fixup_exception+0x18/0x60
do_divide_error+0x0/0xa0
do_divide_error+0x8e/0xa0
delay_tsc+0xb/0x20
  [<c029b270>]
  [<c0112847>] __call_console_drivers+0x37/0x50
vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
error_code+0x4f/0x60
delay_tsc+0xb/0x20
__delay+0x9/0x10
  [<c0112724>]
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>]
  [<c010349b>]
  [<c010edd8>] fixup_exception+0x18/0x60

  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
  [<c010a78b>] delay_tsc+0xb/0x20
  [<c01b5309>] __delay+0x9/0x10
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>] do_exit+0x4f6/0x6e0
  [<c0113573>] printk+0x13/0x20
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>] fixup_exception+0x18/0x60
  [<c01036c0>] do_divide_error+0x0/0xa0
  [<c010374e>] do_divide_error+0x8e/0xa0
  [<c010a789>] delay_tsc+0x9/0x20
  [<c029b270>] write_msg+0x0/0x50
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c01134df>] vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
  [<c0102a0f>] error_code+0x4f/0x60
delay_tsc+0x9/0x20
__delay+0x9/0x10
  [<c0112724>]
  [<c0114b06>]
  [<c010349b>] die+0x1eb/0x1f0
  [<c010edd8>]
  [<c01036c0>] do_divide_error+0x0/0xa0
do_divide_error+0x8e/0xa0
delay_tsc+0xb/0x20
  [<c029b270>]
  [<c0112847>] __call_console_drivers+0x37/0x50
vprintk+0x26f/0x2f0
  [<c0112847>] __call_console_drivers+0x37/0x50
error_code+0x4f/0x60
delay_tsc+0xb/0x20
  [<c01b5309>]
  [<c0112724>] panic+0xd4/0xf0
  [<c0114b06>]
  [<c0113573>]
  [<c010349b>] die+0x1eb/0x1f0
fixup_exception+0x18/0x60
  [<c01036c0>]
  [<c010374e>] do_divide_error+0x8e/0xa0
panic+0xba/0xf0
__call_console_drivers+0x37/0x50
  [<c01134df>]
  [<c0112847>] __call_console_drivers+0x37/0x50
error_code+0x4f/0x60
  [<c011270a>]
  [<c0114b06>]
  [<c0113573>] printk+0x13/0x20
die+0x1eb/0x1f0
fixup_exception+0x18/0x60
  [<c01037ba>]
  [<c031f0fe>]
  [<c01016e5>] mwait_idle+0x25/0x30
cpu_idle+0x1c/0x60
  [<c03f73f2>] start_kernel+0x1f2/0x240
c7 2c 00 d7 89 80 ff 10 31 e8 00 48 ff 0f 0f 85 ed 00 00 00 8b
  <0>divide error: 0000 [#11]
CPU:    0
EIP:    0060:[<c0103386>]    Not tainted VLI
EFLAGS: 00000206   (2.6.16-rc2-PATA) 
EIP is at die+0xd6/0x1f0
eax: c0343179   ebx: c03f64b4   ecx: f7eceec0   edx: ffff5eb6
esi: 00000206   edi: 00000000   ebp: c033478f   esp: c03f63d0
ds: 007b   es: 007b   ss: 0068

-- 
Meelis Roos (mroos@linux.ee)
