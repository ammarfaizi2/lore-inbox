Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSHOUng>; Thu, 15 Aug 2002 16:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSHOUng>; Thu, 15 Aug 2002 16:43:36 -0400
Received: from freemail.agrinet.ch ([212.28.134.90]:20745 "EHLO
	FREEMAIL.agrinet.ch") by vger.kernel.org with ESMTP
	id <S317457AbSHOUnc>; Thu, 15 Aug 2002 16:43:32 -0400
Date: Thu, 15 Aug 2002 22:47:59 +0200
From: Andreas Tscharner <starfire@dplanet.ch>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Kernel Bug in 2.4.19
Message-Id: <20020815224759.25515c5c.starfire@dplanet.ch>
Organization: No Such Penguin
X-Mailer: Sylpheed version 0.8.1claws38 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.m'TG8xydVVer9G"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.m'TG8xydVVer9G
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__15_Aug_2002_22:47:59_+0200_09c90050"


--Multipart_Thu__15_Aug_2002_22:47:59_+0200_09c90050
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello World,

After compiling 2.4.19 (Debian kernel-source-2.4.19-1), I've had several
kernel bugs. I've added the messages of two that I got in the log. The
others are similar.
I re-changed to 2.4.18 (Debian kernel-source-2.4.18-5) and everything
works fine.

System: See attached dmesg
Debian unstable

Regards
	Andreas
-- 
Andreas Tscharner                                  starfire@dplanet.ch
----------------------------------------------------------------------
"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the Universe trying
to produce bigger and better idiots. So far, the Universe is winning."
                                                          -- Rich Cook 

--Multipart_Thu__15_Aug_2002_22:47:59_+0200_09c90050
Content-Type: text/plain;
 name="Bug1.txt"
Content-Disposition: attachment;
 filename="Bug1.txt"
Content-Transfer-Encoding: 7bit

Aug 14 20:10:27 shannara kernel: kernel BUG at page_alloc.c:220!
Aug 14 20:10:27 shannara kernel: invalid operand: 0000
Aug 14 20:10:27 shannara kernel: CPU:    0
Aug 14 20:10:27 shannara kernel: EIP:    0010:[rmqueue+491/556]    Not tainted
Aug 14 20:10:27 shannara kernel: EFLAGS: 00010202
Aug 14 20:10:27 shannara kernel: eax: 01000040   ebx: c14f584c   ecx:00001000   edx: 0001cda4
Aug 14 20:10:27 shannara kernel: esi: c025a2d4   edi: 00000001   ebp:c025a2d4   esp: dd6f1e50
Aug 14 20:10:27 shannara kernel: ds: 0018   es: 0018   ss: 0018
Aug 14 20:10:27 shannara kernel: Process dh_testdir (pid: 936,stackpage=dd6f1000)
Aug 14 20:10:27 shannara kernel: Stack: c025a460 000001ff 00000001 00000000 dda0d500 0001bda4 00000286 c025a2ec 
Aug 14 20:10:27 shannara kernel:        00000000 c025a2d4 c012bf14 000001d2 dda0d500 00000001 dda0d500 c025a2d4 
Aug 14 20:10:27 shannara kernel:        c025a45c 000001d2 c1511cac c012bd26 00104025 c0123210 080fb30c dda0d500 
Aug 14 20:10:27 shannara kernel: Call Trace:    [__alloc_pages+64/376] [_alloc_pages+22/24] [do_anonymous_page+52/212] [do_no_page+51/380] [handle_mm_fault+82/176]
Aug 14 20:10:27 shannara kernel:   [do_page_fault+352/1168] [do_page_fault+0/1168] [__vma_link+98/176] [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Aug 14 20:10:27 shannara kernel: 
Aug 14 20:10:27 shannara kernel: Code: 0f 0b dc 00 93 44 22 c0 8b 43 18 a8 80 74 08 0f 0b de 00 93 


--Multipart_Thu__15_Aug_2002_22:47:59_+0200_09c90050
Content-Type: text/plain;
 name="Bug2.txt"
Content-Disposition: attachment;
 filename="Bug2.txt"
Content-Transfer-Encoding: 7bit

Aug 14 20:22:26 shannara kernel: kernel BUG at page_alloc.c:95!
Aug 14 20:22:26 shannara kernel: invalid operand: 0000
Aug 14 20:22:26 shannara kernel: CPU:    0
Aug 14 20:22:26 shannara kernel: EIP:    0010:[__free_pages_ok+93/612]   Not tainted
Aug 14 20:22:26 shannara kernel: EFLAGS: 00010202
Aug 14 20:22:26 shannara kernel: eax: 01000005   ebx: c13efce8   ecx:c13efce8   edx: 00000000
Aug 14 20:22:26 shannara kernel: esi: 00000000   edi: d9ddbef8   ebp:00000000   esp: d9ddbe74
Aug 14 20:22:26 shannara kernel: ds: 0018   es: 0018   ss: 0018
Aug 14 20:22:26 shannara kernel: Process dpkg (pid: 2304,stackpage=d9ddb000)
Aug 14 20:22:26 shannara kernel: Stack: c13efce8 00000000 d9ddbef8 00000000 00000000 c13efce8 00000000 d9ddbef8 
Aug 14 20:22:26 shannara kernel:        00000000 c0124bca c13efce8 00000000 c0124ad6 c012c0f3 c0124c12 c13efce8 
Aug 14 20:22:26 shannara kernel:        c13efce8 c0124d58 c13efce8 00000000 d9ddbef8 00000001 d5acae10 00000000 
Aug 14 20:22:26 shannara kernel: Call Trace:    [do_flushpage+38/44] [remove_inode_page+26/32] [__free_pages+27/28] [truncate_complete_page+66/72] [truncate_list_pages+320/420]
Aug 14 20:22:26 shannara kernel:   [truncate_inode_pages+65/104] [vmtruncate+157/292] [inode_setattr+35/176] [notify_change+237/332] [do_truncate+77/100] [sys_ftruncate+274/296]
Aug 14 20:22:26 shannara kernel:   [system_call+51/56]
Aug 14 20:22:26 shannara kernel: 
Aug 14 20:22:26 shannara kernel: Code: 0f 0b 5f 00 93 44 22 c0 8b 43 18 a8 80 74 08 0f 0b 61 00 93 

--Multipart_Thu__15_Aug_2002_22:47:59_+0200_09c90050
Content-Type: text/plain;
 name="dmesg.txt"
Content-Disposition: attachment;
 filename="dmesg.txt"
Content-Transfer-Encoding: 7bit

Linux version 2.4.18 (root@shannara) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Wed Aug 14 20:36:10 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffeb000 (usable)
 BIOS-e820: 000000001ffeb000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131051
zone(0): 4096 pages.
zone(1): 126955 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux ro root=305 reboot=warm parport=auto hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 1005.049 MHz processor.
Console: colour VGA+ 132x43
Calibrating delay loop... 2005.40 BogoMIPS
Memory: 513796k/524204k available (1084k kernel code, 10020k reserved, 290k data, 216k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0d90, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (interrupt-driven).
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-307045, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CD/DVD-ROM drive
hdd: PCRW804, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PCI: Found IRQ 9 for device 02:0d.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:0d.0: 3Com PCI 3c905C Tornado at 0xd000. Vers LK1.1.16
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i815 chipset
agpgart: AGP aperture is 64M @ 0xf8000000
SCSI subsystem driver Revision: 1.00
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Communication established with ID 6 using EPP 32 bit
scsi0 : Iomega VPI0 (ppa) interface
  Vendor: IOMEGA    Model: ZIP 100           Rev: L.01
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 6, lun 0
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x00 0x00 0x00 0x00 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 216k freed
Device not ready.  Make sure there is a disc in the drive.
VFS: Disk change detected on device 08:00
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x00 0x00 0x00 0x00 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
Adding Swap: 498004k swap-space (priority -1)
nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
Device not ready.  Make sure there is a disc in the drive.
VFS: Disk change detected on device 08:00
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x00 0x00 0x00 0x00 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
reiserfs: checking transaction log (device 03:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:09) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 9 for device 02:0b.0
PCI: Sharing IRQ 9 with 00:1f.4
Device not ready.  Make sure there is a disc in the drive.
VFS: Disk change detected on device 08:00
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x00 0x00 0x00 0x00 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
lp0: compatibility mode
NVRM: AGPGART: Intel i815 chipset
NVRM: AGPGART: aperture: 64M @ 0xf8000000
NVRM: AGPGART: aperture mapped from 0xf8000000 to 0xe1ba8000
NVRM: AGPGART: mode 4x
NVRM: AGPGART: allocated 16 pages
Device not ready.  Make sure there is a disc in the drive.
VFS: Disk change detected on device 08:00
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x00 0x00 0x00 0x00 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
lp0: compatibility mode
lp0: compatibility mode

--Multipart_Thu__15_Aug_2002_22:47:59_+0200_09c90050--

--=.m'TG8xydVVer9G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9XBOHd6icl+PTsS8RAgpAAJ0U0/aNVlghlC4CYhL9BFIsFxhK9ACfYcE1
ZDEqSDXTmn9IWhm/EEEyy24=
=xNYy
-----END PGP SIGNATURE-----

--=.m'TG8xydVVer9G--
