Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBGMMd>; Wed, 7 Feb 2001 07:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129110AbRBGMMX>; Wed, 7 Feb 2001 07:12:23 -0500
Received: from mail006.syd.optusnet.com.au ([203.2.75.230]:31426 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S129093AbRBGMMM>; Wed, 7 Feb 2001 07:12:12 -0500
Message-Id: <200102071212.f17CC3518463@mail006.syd.optusnet.com.au>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "BaRT" <bart11@dingoblue.net.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 Kernel Crash
X-Mailer: Pronto v2.2.3 On linux/mysql
Date: 07 Feb 2001 20:13:18 WST
Reply-To: "BaRT" <bart11@dingoblue.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On one of my linux boxen, that is used as an ISDN router after a 3 days of up
time I get this:

Thank for any help

Feb  6 18:23:14 router kernel: Code: 8b 6d 00 39 53 48 0f 85 80 00 00 00 8b 44
24 24 39 43 0c 75
Feb  6 18:23:19 router kernel: Unable to handle kernel NULL pointer dereference
at virtual address 00000000
Feb  6 18:23:19 router kernel:	printing eip:
Feb  6 18:23:19 router kernel: c013fbf4
Feb  6 18:23:19 router kernel: *pde = 00000000
Feb  6 18:23:19 router kernel: Oops: 0000
Feb  6 18:23:19 router kernel: CPU:    0
Feb  6 18:23:19 router kernel: EIP:    0010:[d_lookup+116/288]
Feb  6 18:23:19 router kernel: EFLAGS: 00010213
Feb  6 18:23:19 router kernel: eax: c113c098   ebx: ffffffe8   ecx: 0000001a  
edx: 00007242
Feb  6 18:23:19 router kernel: esi: c1bf9f9c   edi: c116d9a0   ebp: 00000000  
esp: c1bf9ef4
Feb  6 18:23:19 router kernel: ds: 0018   es: 0018   ss: 0018
Feb  6 18:23:19 router kernel: Process sh (pid: 4656, stackpage=c1bf9000)
Feb  6 18:23:19 router kernel: Stack: c113c098 c11ee001 00007242 00000003
c1bf9f54 c1bf9f9c c116d9a0 c11ee005
Feb  6 18:23:19 router kernel:	      c0137b30 c116c320 c1bf9f54 c1bf9f54
c0137fa9 c116c320 c1bf9f54 00000004
Feb  6 18:23:19 router kernel:	      000041ed 00000011 00000009 00000000
00000306 00001000 fffffff4 c11ee000
Feb  6 18:23:19 router kernel: Call Trace: [cached_lookup+16/80]
[path_walk+569/2144] [__user_walk+58/96] [sys_stat64+19/112] [error_code+52/60]
[system_call+51/56]

And the computer locks up and need a reboot.
With 2.2.18 with the same ISDN config I get forever up times.

Dmesg:

Linux version 2.4.1 (root@router.istnet.net.au) (gcc version 2.96 20000731 (Red
Hat Linux 7.0)) #5 Sat Feb 3 13:15:21 WST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000003f00000 @ 0000000000100000 (usable)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=306 BOOT_FILE=/boot/vmlinuz
Initializing CPU#0
Detected 233.869 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 466.94 BogoMIPS
Memory: 62620k/65536k available (781k kernel code, 2528k reserved, 270k data,
176k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 0080f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0080f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0080f9ff 00000000 00000000 00000000
CPU: Common caps: 0080f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Klamath) stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 12 for device 00:07.2
PCI: The same IRQ used for device 00:09.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.2 present.
30 structures occupying 818 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 02/21/00
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41541kB/13847kB, 128 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD153BA, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 30043440 sectors (15382 MB) w/2048KiB Cache, CHS=29805/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ISAPNP enabled
Real Time Clock Driver v1.10d
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding Swap: 172328k swap-space (priority -1)
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:0f.0
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:90:27:90:FF:B2, IRQ 11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 721383-007, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
CSLIP: code copyright 1989 Regents of the University of California
ISDN subsystem Rev: 1.114/1.94/1.140.6.1/1.85/none/1.5 loaded
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 2.41.6.1
HiSax: Layer2 Revision 2.25
HiSax: TeiMgr Revision 2.17
HiSax: Layer3 Revision 2.17
HiSax: LinkLayer Revision 2.51
HiSax: Approval certification valid
HiSax: Approved with ELSA Microlink PCI cards
HiSax: Approved with Eicon Technology Diva 2.01 PCI cards
HiSax: Approved with Sedlbauer Speedfax + cards
HiSax: Total 2 cards defined
HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
HiSax: Traverse Tech. NETjet-S driver Rev. 2.7.6.1
PCI: Found IRQ 12 for device 00:09.0
PCI: The same IRQ used for device 00:07.2
NETjet-S: PCI card configured at 0xe400 IRQ 12
NETjet-S: ISAC version (0): 2086/2186 V1.1
NETjet-S: IRQ 12 count 0
NETjet-S: IRQ 12 count 2
HiSax: DSS1 Rev. 2.30
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
HiSax: Card 2 Protocol EDSS1 Id=HiSax1 (1)
HiSax: Traverse Tech. NETjet-S driver Rev. 2.7.6.1
PCI: Found IRQ 10 for device 00:0b.0
NETjet-S: PCI card configured at 0xe800 IRQ 10
NETjet-S: ISAC version (0): 2086/2186 V1.1
NETjet-S: IRQ 10 count 0
NETjet-S: IRQ 10 count 2
HiSax: DSS1 Rev. 2.30
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
isdn_ppp_bind: Can't find a (free) connection to the ipppd daemon.
isdn_ppp_bind: Can't find a (free) connection to the ipppd daemon.
isdn_ppp_bind: Can't find a (free) connection to the ipppd daemon.
isdn_ppp_bind: Can't find a (free) connection to the ipppd daemon.
isdn_ppp_bind: Can't find a (free) connection to the ipppd daemon.
isdn_ppp_bind: Can't find a (free) connection to the ipppd daemon.
isdn_ppp_bind: Can't find a (free) connection to the ipppd daemon.
isdn_ppp_bind: Can't find a (free) connection to the ipppd daemon.
isdn_ppp_bind: Can't find a (free) connection to the ipppd daemon.
isdn_ppp_bind: Can't find a (free) connection to the ipppd daemon.
ippp, open, slot: 0, minor: 0, state: 0000
ippp_ccp: allocated reset data structure c2ec2800
ippp, open, slot: 1, minor: 1, state: 0000
ippp_ccp: allocated reset data structure c2bfe000
ippp, open, slot: 2, minor: 2, state: 0000
ippp_ccp: allocated reset data structure c2bfe800
ippp, open, slot: 3, minor: 3, state: 0000
ippp_ccp: allocated reset data structure c2bf9000
ippp0: dialing 1 
spurious 8259A interrupt: IRQ7.
isdn_net: ippp0 connected
ippp1: dialing 1 
ippp2: dialing 1
isdn_net: ippp1 connected
iPPP-bundle: minor: 1, slave unit: 1, master unit: 0
isdn_net: ippp2 connected
iPPP-bundle: minor: 2, slave unit: 2, master unit: 0
ippp3: dialing 1
isdn_net: ippp3 connected
iPPP-bundle: minor: 3, slave unit: 3, master unit: 0




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
