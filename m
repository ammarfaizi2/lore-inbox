Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSKNK6p>; Thu, 14 Nov 2002 05:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSKNK6p>; Thu, 14 Nov 2002 05:58:45 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:19906 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264853AbSKNK6m>; Thu, 14 Nov 2002 05:58:42 -0500
Date: Thu, 14 Nov 2002 12:05:26 +0100
From: Thorsten Mika <tmika@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: system lockups and shutdowns fo running processes
Message-Id: <20021114120526.4fe115ed.tmika@t-online.de>
Reply-To: tmika@t-online.de
X-Mailer: Sylpheed version 0.8.5claws56 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

i have been facing problems on a machine (amd k6-2) running debian
unstable, kernel 2.4.17 (homemade of ftp.kernel.org sources). the x-window
systems dies unfrequently, sometimes the whole box even hangs. i never
found anything inside the logfiles giving me a clue.

today i found this:

Linux version 2.4.17 (root@nostromo.ppp) (gcc version 2.95.2 20000220
(Debian GNU/L$
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
No local APIC present or hardware disabled
Kernel command line: auto BOOT_IMAGE=Linux ro root=301
Initializing CPU#0
Detected 334.091 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 666.82 BogoMIPS
Memory: 62308k/65536k available (1057k kernel code, 2844k reserved, 292k
data, 232k$
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008001bf 808009bf 00000000, vendor = 2
Enabling old style K6 write allocation for 64 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008001bf 808009bf 00000000 00000000
CPU:     After generic, caps: 008001bf 808009bf 00000000 00000000
CPU:             Common caps: 008001bf 808009bf 00000000 00000000
CPU: AMD-K6(tm) 3D processor stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfb330, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.15)
Starting kswapd
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: Printer, HEWLETT-PACKARD DESKJET 690C
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPN$
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 09
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS5597
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:pio, hdd:pio
hda: ST38641A, ATA DISK drive
hdb: CDA46801I, ATAPI CD/DVD-ROM drive
hdc: QUANTUM LPS420A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16809660 sectors (8607 MB) w/128KiB Cache, CHS=1046/255/63, UDMA(33)
hdc: 824160 sectors (422 MB) w/98KiB Cache, CHS=1010/16/51, DMA
hdb: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdb: set_drive_speed_status: error=0x04
hdb: ATAPI 4X CD-ROM drive, 240kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
 hdc: hdc1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PPP generic driver version 2.4.1
8139too Fast Ethernet driver 0.9.22
eth0: RealTek RTL8139 Fast Ethernet at 0x6300, 00:30:84:40:cb:8a, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 28M
agpgart: no supported devices found.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Adding Swap: 130748k swap-space (priority -1)
reiserfs: checking transaction log (device 03:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
spurious 8259A interrupt: IRQ7.
hda: set_drive_speed_status: status=0x58hda: dma_intr: status=0x58 {
DriveReady See$
 { DriveReady SeekComplete DataRequest }
general protection fault: 9920
CPU:    0
EIP:    0010:[<c3130187>]    Not tainted
EFLAGS: 00013206
eax: 00000008   ebx: 00000001   ecx: c2059920   edx: 00001000
esi: c2059920   edi: 0000000a   ebp: 00000005   esp: c116bf30
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 7, stackpage=c116b000)
Stack: c2059920 c2059920 c0c8dce0 c012f5b4 c2059920 c116a000 c0211a17
c116a24b
       0008e000 00000036 c19c0a40 c340b740 c32bd840 c38ee740 c18b0ea0
c2ff2500
       c3e95d80 c3a25d20 c11cc8c0 c3a35aa0 c1ed4600 c1ed49c0 c3f530c0
c27b4600
Call Trace: [<c012f5b4>] [<c0131c47>] [<c0131eb5>] [<c010546c>]

Code: 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20
 <1>Unable to handle kernel paging request at virtual address 11b9fcef
 printing eip:
c0126416
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0126416>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c25a47e0   ecx: 00000001   edx: 000003e8
esi: ffffffec   edi: c1fb9fa4   ebp: c2593680   esp: c1fb9f40
ds: 0018   es: 0018   ss: 0018
Process wmaker (pid: 425, stackpage=c1fb9000)
Stack: c2593680 00000001 c0136d19 c2593680 00000001 c3ccd000 00000000
c1fb9fa4
       00000009 c01362be 00000009 c3ccd00f c25a47e0 c3ccd006 00000008
82ddc30a
       c0136d5a c01370b1 c1fb8000 c1fb9fa4 08162a90 bffffb8c c013446d
c1fb8000
Call Trace: [<c0136d19>] [<c01362be>] [<c0136d5a>] [<c01370b1>]
[<c013446d>]
   [<c0106b23>]

Code: 10 89 ee fc b9 11 00 00 00 f3 a5 8b 7c 24 1c 89 7b 08 8b 54

any hint?

  thx in advance,

thorsten

p.s.: as i am not a subscriber to the list, could you please cc me? 

-- 
BOFH excuse #213:

Change your language to Finnish.
