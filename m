Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268419AbRHAV6t>; Wed, 1 Aug 2001 17:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268429AbRHAV6k>; Wed, 1 Aug 2001 17:58:40 -0400
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:49157 "EHLO
	mail.applianceware.com") by vger.kernel.org with ESMTP
	id <S268419AbRHAV61>; Wed, 1 Aug 2001 17:58:27 -0400
Message-ID: <3B687B77.CA0353FE@applianceware.com>
Date: Wed, 01 Aug 2001 14:58:15 -0700
From: Craig Spurgeon <cspurgeon@applianceware.com>
Reply-To: cspurgeon@applianceware.com
Organization: ApplianceWare
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: bugs@linux-ide.org
CC: linux-kernel@vger.kernel.org
Subject: kernel panic with 2.4.7 + linux-ide 07092001 patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wasn't sure where to send this for the fastest response, so it
goes to linux-ide.org and the lkml.

I captured the following kernel panic when using a 2.4.7 source from
kernel.org patched with 'ide.2.4.7-p3.all.07092001.patch' from
linux-ide.org.

Applying the patch resulted in one .rej file: drivers/ide/slc90e66.c.rej
which appears to handle a chip I do not have.

The machine has one IBM 75GB DeskStar drive per IDE channel, all on 80-conductor
cables.

When I apply Alan Cox's patch-2.4.7-ac3 to the kernel.org 2.4.7 source, no
rejects result and the drives are properly accessible after a normal linux boot.


---
LILO 
Loading l247...............
Linux version 2.4.7 (root@ccsdev.applianceware.com) (gcc version 2.96 20000731 (
Red Hat Linux 7.1 2.96-81)) #2 Tue Jul 31 17:14:02 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=l247 ro root=306 BOOT_FILE=/boot/vmlinuz-2.
4.7 console=ttyS0,9600n8
Initializing CPU#0
Detected 935.467 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1867.77 BogoMIPS
Memory: 255400k/262080k available (1099k kernel code, 6292k reserved, 415k data,
 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU serial number disabled.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb390, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI en
abled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 169645kB/56548kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio
PDC20267: IDE controller on PCI bus 00 dev 50
PCI: Found IRQ 11 for device 00:0a.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DTLA-307075, ATA DISK drive
hdc: IBM-DTLA-307075, ATA DISK drive
hde: IBM-DTLA-307075, ATA DISK drive
hdg: IBM-DTLA-307075, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb800-0xb807,0xbc02 on irq 11
ide3 at 0xc000-0xc007,0xc402 on irq 11
hda: status error: status=0x50 { DriveReady SeekComplete }
hda: no DRQ after issuing WRITE
hda: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=9345/255/63
hdc: status error: status=0x50 { DriveReady SeekComplete }
hdc: no DRQ after issuing WRITE
hdc: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63
hde: status error: status=0x50 { DriveReady SeekComplete }
hde: no DRQ after issuing WRITE
hde: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hde: ide_intr: hwgroup->busy was 0 ??
Unable to handle kernel NULL pointer dereference at virtual address 00000040
 printing eip:
c01b1a66
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b1a66>]
EFLAGS: 00010046
eax: 00000000   ebx: c02d7adc   ecx: cff39a78   edx: 0000b807
esi: c02d7adc   edi: 00000286   ebp: c02d7a98   esp: c027df40
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c027d000)
Stack: c02d7adc cff39a60 c01ae6b0 c02d7adc c01b1a50 c145a880 04000001 0000000b 
       c027dfa8 c0107faa 0000000b cff39a60 c027dfa8 c027dfa8 0000000b c02aea60 
       c145a880 c0108128 0000000b c027dfa8 c145a880 c01051a0 c027c000 c027c000 
Call Trace: [<c01ae6b0>] [<c01b1a50>] [<c0107faa>] [<c0108128>] [<c01051a0>] [<c
01051a0>] [<c0106d64>] 
       [<c01051a0>] [<c01051a0>] [<c01051c3>] [<c0105242>] [<c0105000>] 

Code: 8b 58 40 ec e6 80 0f b6 c8 fb 88 c8 24 c9 3c 40 74 18 0f b6 
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
---

-- 

-----------------------------------------------------------------------------
Craig Spurgeon, Linux Architect        |  Microsoft Innovations List
ApplianceWare, Inc.                    |           (empty)
510-580-5148                           |
-----------------------------------------------------------------------------
