Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbTIWQqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTIWQqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:46:44 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:44941 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S261958AbTIWQqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:46:31 -0400
Date: Tue, 23 Sep 2003 12:46:29 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: cs: warning: no high memory space available
In-Reply-To: <Pine.LNX.4.58.0309231238580.15947@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.58.0309231243550.15947@filesrv1.baby-dragons.com>
References: <Pine.LNX.4.58.0309231238580.15947@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello All ,  Just after recompiling pcmcia-cs & rebooting I got
	this oops .  Most of the information is the same as the previous
	email with this subject .  Again any pointer are welcome .
		Tia ,  JimL

 # ksymoops < pcmcia-oops.log 2>&1 > pcmcia-oops-ksymoops-d.log
ksymoops 2.4.9 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cs: warning: no high memory space available!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
Unable to handle kernel paging request at virtual address ffffffbc
c029d9e6
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c029d9e6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000029   ebx: ffffffbc   ecx: ffffffbc   edx: df7d78cc
esi: df759484   edi: 00000000   ebp: df7d787c   esp: df7d7864
ds: 0018   es: 0018   ss: 0018
Process cardmgr (pid: 72, stackpage=df7d7000)
Stack: c029e4b6 c15dd890 00001000 ffffffbc df759484 00000000 df7d78a0 c029ebaf
       ffffffbc c037e93a c03b7f66 c03b7cfd df759484 df759484 dfab4800 df7d78c0
       e0a13185 00000029 ffffffbc ffffffbc df7d78cc 0000003a df7d7900 df7d7b50
Call Trace:    [<c029e4b6>] [<c029ebaf>] [<e0a13185>] [<e0a13787>] [<c0295ca6>]
  [<c02963ff>] [<c0296643>] [<c0295ca6>] [<c0296a63>] [<c0296dee>] [<c0296935>]
  [<c0296dee>] [<c029831e>] [<c0296935>] [<c0296a63>] [<c029831e>] [<c0296dee>]
  [<c0296935>] [<e0a131d4>] [<c029d632>] [<e0a15120>] [<c0299d57>] [<c02243ea>]
  [<c029eb5b>] [<e0a148da>] [<e0a15120>] [<e0a1318c>] [<c029ab94>] [<c029a027>]
  [<c029b7db>] [<c02d294d>] [<c02d246f>] [<c032b1c5>] [<c02cf343>] [<c02cf14a>]
  [<c02d030f>] [<c036437a>] [<c0136aad>] [<c0136aad>] [<c012eb7d>] [<c014d9f1>]
  [<c01092df>]
Code: 66 81 3b 5c b3 74 13 b8 21 00 00 00 8b 5d f4 8b 75 f8 8b 7d


>>EIP; c029d9e6 <pcmcia_release_window+16/b0>   <=====

>>edx; df7d78cc <_end+1f32f054/2055e7e8>
>>esi; df759484 <_end+1f2b0c0c/2055e7e8>
>>ebp; df7d787c <_end+1f32f004/2055e7e8>
>>esp; df7d7864 <_end+1f32efec/2055e7e8>

Trace; c029e4b6 <pcmcia_request_window+176/250>
Trace; c029ebaf <CardServices+1ff/360>
Trace; e0a13185 <[memory_cs]memory_release+75/7c>
Trace; e0a13787 <[memory_cs]memory_config+e3/528>
Trace; c0295ca6 <read_cis_mem+26/250>
Trace; c02963ff <setup_cis_mem+9f/e0>
Trace; c0296643 <read_cis_cache+183/1d0>
Trace; c0295ca6 <read_cis_mem+26/250>
Trace; c0296a63 <follow_link+83/1a0>
Trace; c0296dee <pcmcia_get_next_tuple+26e/2c0>
Trace; c0296935 <pcmcia_get_first_tuple+b5/160>
Trace; c0296dee <pcmcia_get_next_tuple+26e/2c0>
Trace; c029831e <read_tuple+2e/80>
Trace; c0296935 <pcmcia_get_first_tuple+b5/160>
Trace; c0296a63 <follow_link+83/1a0>
Trace; c029831e <read_tuple+2e/80>
Trace; c0296dee <pcmcia_get_next_tuple+26e/2c0>
Trace; c0296935 <pcmcia_get_first_tuple+b5/160>
Trace; e0a131d4 <[memory_cs]memory_event+48/d8>
Trace; c029d632 <pcmcia_register_client+212/2b0>
Trace; e0a15120 <[memory_cs]dev_info+0/20>
Trace; c0299d57 <setup_regions+37/220>
Trace; c02243ea <__make_request+24a/740>
Trace; c029eb5b <CardServices+1ab/360>
Trace; e0a148da <[memory_cs]memory_attach+b2/170>
Trace; e0a15120 <[memory_cs]dev_info+0/20>
Trace; e0a1318c <[memory_cs]memory_event+0/d8>
Trace; c029ab94 <bind_request+184/1f0>
Trace; c029a027 <pcmcia_get_first_region+67/c0>
Trace; c029b7db <ds_ioctl+60b/730>
Trace; c02d294d <alloc_skb+ad/1c0>
Trace; c02d246f <sock_def_readable+5f/70>
Trace; c032b1c5 <unix_dgram_sendmsg+275/3d0>
Trace; c02cf343 <sock_sendmsg+73/b0>
Trace; c02cf14a <sockfd_lookup+1a/80>
Trace; c02d030f <sys_sendto+ef/100>
Trace; c036437a <vsnprintf+21a/440>
Trace; c0136aad <kmem_cache_free_one+fd/210>
Trace; c0136aad <kmem_cache_free_one+fd/210>
Trace; c012eb7d <do_munmap+25d/280>
Trace; c014d9f1 <sys_ioctl+b1/240>
Trace; c01092df <system_call+33/38>

Code;  c029d9e6 <pcmcia_release_window+16/b0>
00000000 <_EIP>:
Code;  c029d9e6 <pcmcia_release_window+16/b0>   <=====
   0:   66 81 3b 5c b3            cmpw   $0xb35c,(%ebx)   <=====
Code;  c029d9eb <pcmcia_release_window+1b/b0>
   5:   74 13                     je     1a <_EIP+0x1a>
Code;  c029d9ed <pcmcia_release_window+1d/b0>
   7:   b8 21 00 00 00            mov    $0x21,%eax
Code;  c029d9f2 <pcmcia_release_window+22/b0>
   c:   8b 5d f4                  mov    0xfffffff4(%ebp),%ebx
Code;  c029d9f5 <pcmcia_release_window+25/b0>
   f:   8b 75 f8                  mov    0xfffffff8(%ebp),%esi
Code;  c029d9f8 <pcmcia_release_window+28/b0>
  12:   8b 7d 00                  mov    0x0(%ebp),%edi


1 warning issued.  Results may not be reliable.

 # hinv.sh >> pcmcia-oops-ksymoops-d.log

Main memory size: 511.9140625 Mbytes
1 GenuineIntel  processor
1 16550A serial port
1 1.44M floppy drive
1 keyboard
IDE devices:
  23579136 sectors (12073 MB) w/512KiB Cache, CHS=1467/255/63, UDMA(66)
  attached ide-scsi driver.
PCI bus devices:
    Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 4).
    PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 4).
    PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 3).
    ISA bridge: Intel Corp. 82801BAM ISA Bridge (LPC) (rev 3).
    IDE interface: Intel Corp. 82801BAM IDE U100 (rev 3).
    USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 3).
    VGA compatible controller: nVidia Corporation NV11 [GeForce2 Go] (rev 178).
    Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 16).
    Ethernet controller: 3Com Corporation 3c556 Hurricane CardBus (rev 16).
    Communication controller: 3Com Corporation Mini PCI 56k Winmodem (rev 16).
    CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller (rev 0).
    CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller (#2) (rev 0).
    FireWire (IEEE 1394): Texas Instruments PCI4451 IEEE-1394 Controller (rev 0).


 # sh /usr/src/linux/scripts/ver_linux >> pcmcia-oops-ksymoops-d.log

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux jimlabs 2.4.22 #9 Mon Sep 22 06:08:52 EDT 2003 i686 unknown

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.32
jfsutils               1.1.1
reiserfsprogs          3.6.4
pcmcia-cs              3.2.4
quota-tools            3.08.
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         memory_cs 3c59x

	Before the oops .
 # dmesg
Linux version 2.4.22 (root@jimlabs) (gcc version 3.2.2) #9 Mon Sep 22 06:08:52 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffea800 (usable)
 BIOS-e820: 000000001ffea800 - 0000000020000000 (reserved)
 BIOS-e820: 00000000feea0000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131050
zone(0): 4096 pages.
zone(1): 126954 pages.
zone(2): 0 pages.
Dell Latitude with broken BIOS detected. Refusing to enable the local APIC.
Kernel command line: auto BOOT_IMAGE=jimlabs ro root=301 hdb=ide-scsi
ide_setup: hdb=ide-scsi
Initializing CPU#0
Detected 1129.586 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 2254.43 BogoMIPS
Memory: 514384k/524200k available (2497k kernel code, 9428k reserved, 759k data, 188k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III Mobile CPU      1133MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfc06e, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Using IRQ router PIIX [8086/244c] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver v1.1.22 [Flags: R/W]
udf: registering filesystem
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
vesafb: framebuffer at 0xe0000000, mapped to 0xe081a000, size 1536k
vesafb: mode is 1024x768x8, linelength=1024, pages=3
vesafb: protected mode interface info at c000:d690
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 512 Unix98 ptys configured
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz@debian.org)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
lp0: using parport0 (polling).

DoubleTalk PC - not found
r3964: Philips r3964 Driver $Revision: 1.8 $
Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dwmw2 Exp $
ac.o: No PCI boards found.
ac.o: For an ISA board you must supply memory and irq parameters.
Real Time Clock Driver v1.10e
i810_rng: RNG not detected
smapi::smapi_init, ERROR invalid usSmapiID
mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is not available on this machine
mwave: mwavedd::mwave_init: Error: Failed to initialize board data
mwave: mwavedd::mwave_init: Error: Failed to initialize
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
bonding.c:v2.2.14 (June 30, 2003)
bonding_init(): either miimon or arp_interval and arp_ip_target module parameters must be specified, otherwise bonding will not detect link failures! see bonding.txt for details.
bond0 registered without MII link monitoring, in load balancing (round-robin) mode.
bond0 registered without ARP monitoring
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2M: IDE controller at PCI slot 00:1f.1
ICH2M: chipset revision 3
ICH2M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
hda: FUJITSU MHK2120AT, ATA DISK drive
hdb: TOSHIBA CD-RW/DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive
blk: queue c049a360, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 23579136 sectors (12073 MB) w/512KiB Cache, CHS=1467/255/63, UDMA(66)
hdb: attached ide-scsi driver.
Partition check:
 hda: hda1 hda2 hda3
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 10 for device 02:0f.0
PCI: Sharing IRQ 10 with 00:1f.2
PCI: Sharing IRQ 10 with 02:06.0
PCI: Sharing IRQ 10 with 02:06.1
PCI: Sharing IRQ 10 with 02:0f.1
PCI: Sharing IRQ 10 with 02:0f.2
PCI: Found IRQ 10 for device 02:0f.1
PCI: Sharing IRQ 10 with 00:1f.2
PCI: Sharing IRQ 10 with 02:06.0
PCI: Sharing IRQ 10 with 02:06.1
PCI: Sharing IRQ 10 with 02:0f.0
PCI: Sharing IRQ 10 with 02:0f.2
Intel PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
cpqphp.o: Compaq Hot Plug PCI Controller Driver version: 0.9.7
ibmphpd: IBM Hot Plug PCI Controller Driver version: 0.6
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
IPv4 over IPv4 tunneling driver
Yenta IRQ list 0298, PCI irq10
Socket status: 30000006
Yenta IRQ list 0298, PCI irq10
Socket status: 30000006
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 530136k swap-space (priority -1)
PCI: Found IRQ 10 for device 02:06.0
PCI: Sharing IRQ 10 with 00:1f.2
PCI: Sharing IRQ 10 with 02:06.1
PCI: Sharing IRQ 10 with 02:0f.0
PCI: Sharing IRQ 10 with 02:0f.1
PCI: Sharing IRQ 10 with 02:0f.2
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
02:06.0: 3Com PCI 3c556 Laptop Tornado at 0xe800. Vers LK1.1.18-ac
 00:04:76:4f:5d:41, IRQ 10
  product code 0000 rev 00.0 date 03-01-00
02:06.0: CardBus functions mapped f8ffd800->e0a11800
  Internal config register is 80600000, transceivers 0x40.
  8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
  MII transceiver found at address 0, status 7809.
  Enabling bus-master transmits and whole-frame receives.
02:06.0: scatter/gather enabled. h/w checksums enabled
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
eth0: no IPv6 routers present

-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
