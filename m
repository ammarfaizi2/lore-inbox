Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbTJJDd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 23:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTJJDd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 23:33:57 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:35089 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S262364AbTJJDdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 23:33:50 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.0test6 doesn't like the APA-1460
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Date: 10 Oct 2003 05:33:49 +0200
Message-ID: <tpk77d3gwy.fsf@helium.pps.jussieu.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Antivirus: scanned by sophie at shiva.jussieu.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Under 2.6.0test6, inserting an APA-1460 SCSI card (a PCMCIA version of
the Adaptec ISA cards) causes an OOPS and no devices are seen.  I'm
attaching the log.

I haven't tried test7 yet, but I didn't see any related changes in the
changelog.

                                        Juliusz Chroboczek


--=-=-=
Content-Disposition: attachment; filename=pcmcia.log

Linux version 2.6.0-test6 (root@trurl) (gcc version 3.3.1 20030626 (Debian prerelease)) #1 Sat Oct 4 06:37:40 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eeff000 (ACPI data)
 BIOS-e820: 000000000eeff000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
240MB LOWMEM available.
On node 0 totalpages: 61440
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57344 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6dc0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0eefb63b
ACPI: FADT (v001 COMPAQ  EAGLES  0x06040000 PTL_ 0x000f4240) @ 0x0eefeeb6
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x0eefef2a
ACPI: DSDT (v001 COMAPQ   EAGLES 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: Vendor "COMAPQ" System "  EAGLES" Revision 0x6040000 has a known ACPI BIOS problem.
ACPI: Reason: SCI issues (C2 disabled). This is a recoverable error
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=305 hdc=scsi
ide_setup: hdc=scsi
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 946.875 MHz processor.
Console: colour VGA+ 80x25
Memory: 239804k/245760k available (1713k kernel code, 5144k reserved, 702k data, 116k init, 0k highmem)
Calibrating delay loop... 1863.68 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Mobile AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd7ae, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 80): [55] 3c & 1f -> 1c
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *4)
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: Embedded Controller [EC] (gpe 6)
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f6b30
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 36 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:25 (@c00f6cb8)
powernow:  cpuid: 0x771	fsb: 100	maxFID: 0xd	startvid: 0xb
powernow:    FID: 0x4 (5.0x [500MHz])	VID: 0xe (1.300V)
powernow:    FID: 0x8 (7.0x [700MHz])	VID: 0xe (1.300V)
powernow:    FID: 0xd (9.5x [950MHz])	VID: 0xb (1.450V)

powernow: Minimum speed 500 MHz. Maximum speed 950 MHz.
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Applying VIA southbridge workaround.
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 190M
agpgart: AGP aperture is 64M @ 0xec000000
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xcf821000, 00:08:02:2d:07:35, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 42) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHN2200AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 > p4
ide-cd: passing drive hdc to ide-scsi emulation.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-C2502  Rev: 1011
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
Yenta: CardBus bridge found at 0000:00:0a.0 [0e11:b103]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0008, PCI irq11
Socket status: 30000006
mice: PS/2 mouse device common for all mice
input: PS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI: (supports S0 S3 S4 S5)
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 116k freed
Adding 248968k swap on /dev/hda7.  Priority:-1 extents:1
blk: queue c13d2600, I/O limit 4095Mb (mask 0xffffffff)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda6) for (hda6)
Using r5 hash to sort names
NTFS driver 2.1.4 [Flags: R/O MODULE].
NTFS volume version 3.1.
PCI: Setting latency timer of device 0000:00:07.5 to 64
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c02258e1
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c02258e1>]    Not tainted
EFLAGS: 00010286
EIP is at scsi_register+0x41/0x70
eax: cd8089a4   ebx: cd808800   ecx: 00000000   edx: cfa0c074
esi: cfa0c000   edi: ce869a54   ebp: ce869a2c   esp: ce8697d8
ds: 007b   es: 007b   ss: 0068
Process cardmgr (pid: 459, threadinfo=ce868000 task=cebd4720)
Stack: cfa0c000 00000334 00000000 ce869a2c cfa03a2f cfa0c000 00000334 00002000 
       00000500 035f0340 cd8066c0 ce048a80 ce869a0c ce048a80 0000002b c0243978 
       ce048a80 00000282 ce86988c 00000000 ce869a2c ce869a54 0000002b cfa034b8 
Call Trace:
 [<cfa03a2f>] aha152x_probe_one+0x1f/0x420 [aha152x_cs]
 [<c0243978>] CardServices+0x208/0x351
 [<cfa034b8>] aha152x_config_cs+0x2f8/0x3a0 [aha152x_cs]
 [<c01eb12a>] scrup+0x11a/0x130
 [<c0245bf5>] yenta_set_mem_map+0x1a5/0x1f0
 [<c01ef201>] vt_console_print+0x151/0x2f0
 [<c0245bf5>] yenta_set_mem_map+0x1a5/0x1f0
 [<c023bbc0>] set_cis_map+0x40/0x110
 [<c023bdac>] read_cis_mem+0x11c/0x1a0
 [<c023c0de>] read_cis_cache+0x14e/0x250
 [<c023cadc>] pcmcia_get_tuple_data+0x8c/0x90
 [<c023dcf0>] pcmcia_parse_tuple+0x100/0x170
 [<c023de02>] read_tuple+0xa2/0xb0
 [<c0245bf5>] yenta_set_mem_map+0x1a5/0x1f0
 [<c01171ef>] __ioremap+0xdf/0x110
 [<cfa03666>] aha152x_event+0x76/0x110 [aha152x_cs]
 [<c023bdac>] read_cis_mem+0x11c/0x1a0
 [<c023dda7>] read_tuple+0x47/0xb0
 [<c023c0de>] read_cis_cache+0x14e/0x250
 [<c023c9f4>] pcmcia_get_next_tuple+0x224/0x280
 [<c023df35>] pcmcia_validate_cis+0x125/0x1f0
 [<c014ec2a>] bh_lru_install+0x8a/0xc0
 [<c014ec06>] bh_lru_install+0x66/0xc0
 [<c0242521>] pcmcia_register_client+0x221/0x270
 [<c014edef>] __bread+0x1f/0x40
 [<c0245bf5>] yenta_set_mem_map+0x1a5/0x1f0
 [<c023bbc0>] set_cis_map+0x40/0x110
 [<c0243911>] CardServices+0x1a1/0x351
 [<cfa030f5>] aha152x_attach+0xf5/0x140 [aha152x_cs]
 [<cfa035f0>] aha152x_event+0x0/0x110 [aha152x_cs]
 [<c0245447>] get_pcmcia_driver+0x37/0x70
 [<c0244598>] bind_request+0xd8/0x1b0
 [<c011799e>] recalc_task_prio+0x8e/0x1b0
 [<c024509f>] ds_ioctl+0x4cf/0x600
 [<c0256bf8>] sock_def_readable+0x58/0x60
 [<c02a3500>] unix_dgram_sendmsg+0x3e0/0x4c0
 [<c025393e>] sock_sendmsg+0x9e/0xd0
 [<c016302d>] get_new_inode_fast+0x3d/0xc0
 [<c0172737>] proc_read_inode+0x17/0x40
 [<c0163a8f>] wake_up_inode+0xf/0x30
 [<c0172a2c>] proc_get_inode+0xcc/0xf0
 [<c011b184>] __mmdrop+0x34/0x46
 [<c01186ed>] schedule+0x34d/0x500
 [<c013e89b>] zap_pmd_range+0x4b/0x70
 [<c013e903>] unmap_page_range+0x43/0x70
 [<c013ea11>] unmap_vmas+0xe1/0x210
 [<c0141cfb>] unmap_region+0x9b/0xe0
 [<c0141bf0>] unmap_vma+0x40/0x80
 [<c0141c4f>] unmap_vma_list+0x1f/0x30
 [<c0141ff0>] do_munmap+0x130/0x180
 [<c015c9f5>] sys_ioctl+0xb5/0x240
 [<c010918b>] syscall_call+0x7/0xb

Code: 89 01 89 48 04 89 d8 8b 74 24 0c 8b 5c 24 08 83 c4 10 c3 8b 
 

--=-=-=--
