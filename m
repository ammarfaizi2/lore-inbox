Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTEOUT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbTEOUT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:19:28 -0400
Received: from imap.gmx.net ([213.165.64.20]:30865 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264268AbTEOUTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:19:17 -0400
Date: Thu, 15 May 2003 22:31:45 +0200
To: linux-kernel@vger.kernel.org
Subject: kernel version 2.4.21-rc2-ac2 / acpi oops
Message-ID: <20030515203145.GA1849@mob.wid>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
x-gpg-key: CF286A67
x-gpg-fingerprint: 717B AE57 49B3 410F A733  FE6A 2D43 E1E3 CF28 6A67
From: Felix Triebel <ernte23@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I hope the information below is helpful, please give me some feedback!
CC to me, I'm not subscribed to this list.

I'm using kernel version 2.4.21-rc2-ac2,
trying to suspend with acpi using:
"echo 1 > /proc/acpi/sleep"
"echo 2 > /proc/acpi/sleep"
"echo 3 > /proc/acpi/sleep"
does nothing.

"echo 5 > /proc/acpi/sleep"
produces:

--------------------------------------------------------------------------

ksymoops 2.4.8 on i686 2.4.21-rc2-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc2-ac2/ (default)
     -m /System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0111d2b
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[acpi_restore_pmd+11/32]    Not tainted
EFLAGS: 00210002
eax: 00000000   ebx: 00000005   ecx: 00000008   edx: 00000000
esi: 00000005   edi: 00000005   ebp: 00000002   esp: c9e9df30
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 561, stackpage=3Dc9e9d000)
Stack: c019e6a9 00000005 00000001 c019e7eb 00000005 00000005 00000005 00000=
005=20
       00000002 c9e9df64 c12f3140 c019ece1 00000005 00000a35 00000000 00000=
000=20
       0000000a 00000000 ca13f740 ffffffea c01555a0 ca13f740 080dcc08 00000=
002=20
Call Trace:    [acpi_system_restore_state+63/95] [acpi_suspend+86/159] [acp=
i_system_write_sleep+124/137] [proc_file_write+64/80] [sys_write+163/304]
Code: 89 02 0f 20 d8 0f 22 d8 a1 84 75 29 c0 31 d2 e9 a1 f6 01 00=20
Using defaults from ksymoops -t elf32-i386 -a i386


>>esp; c9e9df30 <_end+9bd9aa0/10619bf0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 02                     mov    %eax,(%edx)
Code;  00000002 Before first symbol
   2:   0f 20 d8                  mov    %cr3,%eax
Code;  00000005 Before first symbol
   5:   0f 22 d8                  mov    %eax,%cr3
Code;  00000008 Before first symbol
   8:   a1 84 75 29 c0            mov    0xc0297584,%eax
Code;  0000000d Before first symbol
   d:   31 d2                     xor    %edx,%edx
Code;  0000000f Before first symbol
   f:   e9 a1 f6 01 00            jmp    1f6b5 <_EIP+0x1f6b5>

--------------------------------------------------------------------------

Linux version 2.4.21-rc2-ac2 (root@triebel) (gcc version 3.2.3 20030415 (De=
bian prerelease)) #2 Die Mai 13 19:36:08 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
 BIOS-e820: 000000000ffec000 - 000000000ffef000 (ACPI data)
 BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65516
zone(0): 4096 pages.
zone(1): 61420 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f6a70
ACPI: RSDT (v001 ASUS   A7V-133  12336.12337) @ 0x0ffec000
ACPI: FADT (v001 ASUS   A7V-133  12336.12337) @ 0x0ffec080
ACPI: BOOT (v001 ASUS   A7V-133  12336.12337) @ 0x0ffec040
ACPI: DSDT (v001   ASUS A7V-133  00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: auto BOOT_IMAGE=3Dlinux ro root=3D801
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 999.749 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 257008k/262064k available (1228k kernel code, 4668k reserved, 268k =
data, 108k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 999.7457 MHz.
=2E.... host bus clock speed is 266.5988 MHz.
cpu: 0, clocks: 2665988, slice: 1332994
CPU0<T0:2665984,T1:1332976,D:14,S:1332994,C:2665988>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030424
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=3D1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Applying VIA southbridge workaround.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:pio
hda: LS-120/240 00 UHD Floppy, ATAPI FLOPPY drive
hdb: IOMEGA ZIP 250 ATAPI Floppy, ATAPI FLOPPY drive
hdb: set_drive_speed_status: status=3D0x51 { DriveReady SeekComplete Error }
hdb: set_drive_speed_status: error=3D0x04
ide0: Drive 1 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Partition check:
 hda:end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
 unable to read partition table
 hdb:end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
 unable to read partition table
SCSI subsystem driver Revision: 1.00
sym.0.11.0: setting PCI_COMMAND_PARITY...
sym0: <895> rev 0x1 on pci bus 0 device 11 function 0 irq 10
sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
spurious 8259A interrupt: IRQ7.
scsi0 : sym-2.1.17a
blk: queue cff11014, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: PIONEER   Model: DVD-ROM DVD-304   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue cff11214, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IBM       Model: DDYS-T18350N      Rev: S93E
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue cff11414, I/O limit 4095Mb (mask 0xffffffff)
sym0:3:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
sym0:3: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
 sda: sda1 sda2 sda3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 08:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 108k freed
Adding Swap: 249884k swap-space (priority -1)
Real Time Clock Driver v1.10e
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
matroxfb: Matrox G550 detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xE4000000, mapped to 0xd0910000, size 33554432
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
advansys: AscInitGetConfig: board 0: tag queuing enabled w/o disconnects
advansys: AscInitSetConfig: board 0: tag queuing w/o disconnects
scsi1 : AdvanSys SCSI 3.3G: PCI Ultra: IO 0x9400-0x940F, IRQ 0xB
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 32M @ 0xe6000000
reiserfs: checking transaction log (device 08:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 292 bytes per conntrack
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:09.0: 3Com PCI 3c905C Tornado at 0xa400. Vers LK1.1.18-ac
 00:01:02:f6:3c:e7, IRQ 4
  product code 4552 rev 00.13 date 11-25-00
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
00:09.0: scatter/gather enabled. h/w checksums enabled
CSLIP: code copyright 1989 Regents of the University of California
ISDN subsystem Rev: 1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1/none/1.1.4.1 loaded
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 1.1.4.1
HiSax: Layer2 Revision 1.1.4.1
HiSax: TeiMgr Revision 1.1.4.1
HiSax: Layer3 Revision 1.1.4.1
HiSax: LinkLayer Revision 1.1.4.1
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=3DHiSax (0)
HiSax: AVM PCI driver Rev. 1.1.4.1
AVM PCI: stat 0x2020a
AVM PCI: Class A Rev 2
HiSax: AVM Fritz!PCI config irq:15 base:0xA000
AVM PCI: ISAC version (0): 2086/2186 V1.1
AVM Fritz PnP/PCI: IRQ 15 count 0
AVM Fritz PnP/PCI: IRQ 15 count 6
HiSax: DSS1 Rev. 1.1.4.1
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
isdn: Verbose-Level is 0
HiSax: debugging flags card 1 set to 4
ippp, open, slot: 0, minor: 0, state: 0000
ippp_ccp: allocated reset data structure cdbf8800
mtrr: no MTRR for e4000000,800000 found
mtrr: no MTRR for e4800000,400000 found
mtrr: no MTRR for e4c00000,200000 found
mtrr: no MTRR for e4e00000,100000 found
mtrr: no MTRR for e4f00000,80000 found
mtrr: no MTRR for e4f80000,40000 found
mtrr: no MTRR for e4fc0000,20000 found
mtrr: no MTRR for e4fe0000,10000 found
mtrr: no MTRR for e4ff0000,8000 found
mtrr: no MTRR for e4ff8000,4000 found
mtrr: no MTRR for e4ffc000,2000 found
mtrr: no MTRR for e4ffe000,1000 found
mtrr: no MTRR for e4000000,800000 found
mtrr: no MTRR for e4800000,400000 found
mtrr: no MTRR for e4c00000,200000 found
mtrr: no MTRR for e4e00000,100000 found
mtrr: no MTRR for e4f00000,80000 found
mtrr: no MTRR for e4f80000,40000 found
mtrr: no MTRR for e4fc0000,20000 found
mtrr: no MTRR for e4fe0000,10000 found
mtrr: no MTRR for e4ff0000,8000 found
mtrr: no MTRR for e4ff8000,4000 found
mtrr: no MTRR for e4ffc000,2000 found
mtrr: no MTRR for e4ffe000,1000 found
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe6000000 32MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
mtrr: base(0xe4000000) is not aligned on a size(0xfff000) boundary
es1371: version v0.32 time 18:14:36 May 13 2003
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x02
es1371: found es1371 rev 2 at io 0x9000 irq 4
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: TRA3 (TriTech TR28023)

--------------------------------------------------------------------------

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iD8DBQE+w/kxLUPh488oamcRAiVMAJ9LNbMW8VqN6i4008bi9frP+JyJhwCdEvf2
uVla7OHtLiNMYTVQySvHdBI=
=2AWn
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
