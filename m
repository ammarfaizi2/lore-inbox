Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271641AbRHQMtc>; Fri, 17 Aug 2001 08:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271642AbRHQMtX>; Fri, 17 Aug 2001 08:49:23 -0400
Received: from traven.uol.com.br ([200.231.206.184]:59106 "EHLO
	traven.uol.com.br") by vger.kernel.org with ESMTP
	id <S271641AbRHQMtM>; Fri, 17 Aug 2001 08:49:12 -0400
Message-ID: <3B7D12D0.BE309A7@uol.com.br>
Date: Fri, 17 Aug 2001 09:49:20 -0300
From: "Michel A. S. Pereira - KIDMumU|ResolveBucha" 
	<michelcultivo@uol.com.br>
Organization: TECHS Provider
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The oops:

Aug 17 02:45:07 lucy kernel: Unable to handle kernel paging request at
virtual address 34e21396
Aug 17 02:45:07 lucy kernel:  printing eip:
Aug 17 02:45:07 lucy kernel: c013e9b7
Aug 17 02:45:07 lucy kernel: *pde = 00000000
Aug 17 02:45:07 lucy kernel: Oops: 0002
Aug 17 02:45:07 lucy kernel: CPU:    0
Aug 17 02:45:07 lucy kernel: EIP:    0010:[d_instantiate+55/80]
Aug 17 02:45:07 lucy kernel: EFLAGS: 00010282
Aug 17 02:45:07 lucy kernel: eax: 34e21392   ebx: c61a1370   ecx:
00000000   edx: c6f2a880
Aug 17 02:45:07 lucy kernel: esi: c6f2a720   edi: c61a1340   ebp:
ffffffe4   esp: cdacbefc
Aug 17 02:45:07 lucy kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 02:45:07 lucy kernel: Process enlightenment (pid: 988,
stackpage=cdacb000)
Aug 17 02:45:07 lucy kernel: Stack: c6dcf140 c6f2a720 c61a1340 c012bfe5
c61a1340 c6f2a720 cdacbf5c cee6b720
Aug 17 02:45:07 lucy kernel:        000003b6 00000001 cdacbf5c 0000000c
00000000 c0174952 cdacbf5c 00000080
Aug 17 02:45:07 lucy kernel:        00000000 cdacbf5c c0226c56 00000000
000003b6 00000000 000003b6 00000080
Aug 17 02:45:07 lucy kernel: Call Trace: [shmem_file_setup+189/284]
[newseg+142/336] [sys_shmget+100/292] [sys_ipc+584/632]
[math_state_restore+25/52] [system_call+51/56]
Aug 17 02:45:07 lucy kernel:
Aug 17 02:45:07 lucy kernel: Code: 89 58 04 89 47 30 8d 46 10 89 43 04
89 5e 10 89 77 08 5b 5e

-----------------------------------------------------------------------------------------------
Aug 17 02:45:07 lucy kernel: Unable to handle kernel paging request at
virtual address df0ff1d8
Aug 17 02:45:07 lucy kernel:  printing eip:
Aug 17 02:45:07 lucy kernel: c01258e9
Aug 17 02:45:07 lucy kernel: *pde = 00000000
Aug 17 02:45:07 lucy kernel: Oops: 0000
Aug 17 02:45:07 lucy kernel: CPU:    0
Aug 17 02:45:07 lucy kernel: EIP:    0010:[kmem_cache_alloc+33/84]
Aug 17 02:45:07 lucy kernel: EFLAGS: 00010807
Aug 17 02:45:07 lucy kernel: eax: c6075060   ebx: c1445e6c   ecx:
4db6b400   edx: c6f2b040
Aug 17 02:45:07 lucy kernel: esi: 00000246   edi: 000000f0   ebp:
c145f000   esp: cc255e40
Aug 17 02:45:07 lucy kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 02:45:07 lucy kernel: Process gkrellm (pid: 1023,
stackpage=cc255000)
Aug 17 02:45:07 lucy kernel: Stack: 00000000 cffcbd78 cffcbd78 c0140094
c1445e6c 000000f0 00000000 cffcbd78
Aug 17 02:45:07 lucy kernel:        00001007 c145f000 c0140376 c145f000
00001007 cffcbd78 00000000 00000000
Aug 17 02:45:07 lucy kernel:        c145b420 c61a14a0 c145b470 c145d040
c01449cd c145f000 00001007 00000000
Aug 17 02:45:07 lucy kernel: Call Trace: [get_new_inode+28/356]
[iget4+194/212] [proc_get_inode+65/280] [proc_lookup+117/156]
[proc_root_lookup+43/72] [real_lookup+83/196] [path_walk+1321/1864]
Aug 17 02:45:07 lucy kernel:        [open_namei+134/1380]
[free_pages+36/40] [filp_open+59/92] [sys_open+56/184]
[system_call+51/56]
Aug 17 02:45:07 lucy kernel:
Aug 17 02:45:08 lucy kernel: Code: 8b 44 82 18 03 4a 0c 89 42 14 83 f8
ff 75 08 8b 02 89 43 08

	My box dmesg.


Linux version 2.4.8 (root@lucy.inside.techs.com.br) (gcc version 2.95.3
20010315 (release) (conectiva)) #3 Qua Ago
 15 15:44:38 BRT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01442000)
Kernel command line: root=/dev/hda7 3  mem=262080K
Initializing CPU#0
Detected 501.173 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 255452k/262080k available (1074k kernel code, 6240k reserved,
372k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0387f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387f9ff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb380, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Disabled enhanced CPU to PCI posting #2
PCI: Using IRQ router VIA [1106/0596] at 00:07.0
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Calling quirk for 01:02
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: Card 'U.S. Robotics 56K Voice INT'
isapnp: 2 Plug & Play cards detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at port 0x02f8 (irq = 3) is a 16550A
Software Watchdog Timer: 0.05, timer margin: 60 sec
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c596a (rev 06) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
hda: ST38410A, ATA DISK drive
hdc: MATSHITADVD-ROM SR-8584A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16841664 sectors (8623 MB) w/512KiB Cache, CHS=1048/255/63,
UDMA(33)
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:0f.0
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:90:27:94:A2:03, IRQ
11.
  Board assembly 721383-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xe8000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (2047 buckets, 16376 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:07) ...
Warning, log replay starting on readonly filesystem
reiserfs: replayed 2 transactions in 1 seconds
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 204k freed
Real Time Clock Driver v1.10d
Adding Swap: 104380k swap-space (priority -1)
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB AWE64 PnP detected
sb: ISAPnP reports 'Creative SB AWE64 PnP' at i/o 0x220, irq 5, dma 1, 5
SB 4.16 detected OK (220)
<Sound Blaster 16 (4.16)> at 0x220 irq 5 dma 1,5
<Sound Blaster 16> at 0x330 irq 5 dma 0,0
sb: 1 Soundblaster PnP card(s) found.
ISAPnP reports AWE64 WaveTable at i/o 0x620
<SoundBlaster EMU8000 (RAM512k)>


-- 
============================================
|PIII 500MHz - 96MB RAM - HD 8.2GB - Savage4 
|USR Sportster 56K Int Voice - Sb AWE 64
|CL 6.0 - Kernel 2.4.5 - Snort 1.8
|www.kidmumu.net - UIN 4553082 - LC 83522
|Powered by Fanta Uva e suco de Acerola
============================================
