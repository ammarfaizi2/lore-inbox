Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318426AbSHENFW>; Mon, 5 Aug 2002 09:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318425AbSHENFV>; Mon, 5 Aug 2002 09:05:21 -0400
Received: from pigeon.csd.abdn.ac.uk ([139.133.200.15]:34971 "EHLO
	pigeon.csd.abdn.ac.uk") by vger.kernel.org with ESMTP
	id <S318426AbSHENFQ>; Mon, 5 Aug 2002 09:05:16 -0400
From: Christos Kartsaklis <ck@csd.abdn.ac.uk>
Date: Mon, 5 Aug 2002 14:08:24 +0100 (BST)
Message-Id: <200208051308.g75D8OW28930@raven.csd.abdn.ac.uk>
To: linux-kernel@vger.kernel.org
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=2.9,
	required 5, SUBJ_MISSING, DOUBLE_CAPSWORD, SUPERLONG_LINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, I got this Oops on my box (Redhat 7.1) while mounting one of my disks. 
After the Oops report comes info which might be of some use to you. 

I have two 60.0 GB ATA133 hard disks installed on my system, a Maxtor D740X-6L
and a Quantum Fireball Plus AS 60.0 GB (not identified properly in dmesg),
both in EXT2 fs. I see why the system got poked that sharply, I don't know
why this _random_ behaviour is caused though. Note also that the BIOS cannot
identify any of them. I have been using these two disks on Redhat 7.2, and
today I tried to install them on another box (the offending one) running Redhat
7.1, not being used for ~7 months. 

If you need more info, let me know. I hope this helps, and yes, I know that I
should get a newer kernel version. 

Please CC me all, as I am not subscribed to the list.


ksymoops 2.4.1 on i686 2.4.7-10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7-10/ (default)
     -m /boot/System.map-2.4.7-10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Error (pclose_local): find_objects pclose failed 0x100
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01b3570, System.map says c0155720.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol lp_table  , lp says c885d640, /lib/modules/2.4.7-10/kernel/drivers/char/lp.o says c885d440.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/char/lp.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says c88479a0, /lib/modules/2.4.7-10/kernel/drivers/usb/usbcore.o says c88474c0.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/usb/usbcore.o entry
Warning (compare_maps): mismatch on symbol sd  , sd_mod says c881bce4, /lib/modules/2.4.7-10/kernel/drivers/scsi/sd_mod.o says c881bba0.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/sd_mod.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says c8817568, /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o says c8815df0.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says c8817594, /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o says c8815e1c.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says c8817590, /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o says c8815e18.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says c8817598, /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o says c8815e20.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says c8817564, /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o says c8815dec.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o entry
CPU:    0
EIP:    0010:[<c018cf9a>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010212
eax: 00000000   ebx: 00001640   ecx: 00000000   edx: 00000000
esi: c02de2c4   edi: 00001100   ebp: 00000040   esp: c440dee8
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 1190, stackpage=c440d000)
Stack: 00001600 00000040 00000464 00000001 c02de458 00000330 c018d031 00001640
       00000001 c02de2c4 c75ce440 c449faa0 c449faa0 c018d0ef c75d2860 c75ce440
       c013cb97 c75ce440 c449faa0 c449faa0 c75ce440 c13df300 c0134e03 c75ce440
Call Trace: [<c018d031>] [<c018d0ef>] [<c013cb97>] [<c0134e03>] [<c0134d2d>]
   [<c013f63e>] [<c0135006>] [<c0106f0b>]
Code: 8b 40 28 85 c0 74 04 56 ff d0 5a 80 a6 ae 00 00 00 fb 8d 86

>>EIP; c018cf9a <ide_revalidate_disk+da/110>   <=====
Trace; c018d031 <revalidate_drives+61/90>
Trace; c018d0ef <ide_open+2f/100>
Trace; c013cb97 <blkdev_open+47/80>
Trace; c0134e03 <dentry_open+c3/140>
Trace; c0134d2d <filp_open+4d/60>
Trace; c013f63e <getname+5e/a0>
Trace; c0135006 <sys_open+36/b0>
Trace; c0106f0b <system_call+33/38>
Code;  c018cf9a <ide_revalidate_disk+da/110>
00000000 <_EIP>:
Code;  c018cf9a <ide_revalidate_disk+da/110>   <=====
   0:   8b 40 28                  mov    0x28(%eax),%eax   <=====
Code;  c018cf9d <ide_revalidate_disk+dd/110>
   3:   85 c0                     test   %eax,%eax
Code;  c018cf9f <ide_revalidate_disk+df/110>
   5:   74 04                     je     b <_EIP+0xb> c018cfa5 <ide_revalidate_disk+e5/110>
Code;  c018cfa1 <ide_revalidate_disk+e1/110>
   7:   56                        push   %esi
Code;  c018cfa2 <ide_revalidate_disk+e2/110>
   8:   ff d0                     call   *%eax
Code;  c018cfa4 <ide_revalidate_disk+e4/110>
   a:   5a                        pop    %edx
Code;  c018cfa5 <ide_revalidate_disk+e5/110>
   b:   80 a6 ae 00 00 00 fb      andb   $0xfb,0xae(%esi)
Code;  c018cfac <ide_revalidate_disk+ec/110>
  12:   8d 86 00 00 00 00         lea    0x0(%esi),%eax


10 warnings and 3 errors issued.  Results may not be reliable.


cat /proc/version:
------------------
Linux version 2.4.7-10 (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Thu Sep 6 17:27:27 EDT 2001

dmesg:
------
Linux version 2.4.7-10 (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Thu Sep 6 17:27:27 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scanning bios EBDA for MXT signature
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=302 BOOT_FILE=/boot/vmlinuz-2.4.7-10
Initializing CPU#0
Detected 451.033 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 897.84 BogoMIPS
Memory: 125148k/131008k available (1269k kernel code, 4576k reserved, 90k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb230, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
mxt_scan_bios: enter
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
block: queued sectors max/low 83064kB/27688kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL CR8.4A, ATA DISK drive
hdc: MAXTOR 6L060J3, ATA DISK drive
hdd: AEA@, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16514064 sectors (8455 MB) w/418KiB Cache, CHS=1027/255/63, UDMA(33)
hdc: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=116336/16/63, UDMA(33)
hdd: 0 sectors (0 MB) w/1900KiB Cache, CHS=513/0/3
hdd: INVALID GEOMETRY: 0 PHYSICAL HEADS?
ide-floppy driver 0.97
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
 hdc: hdc1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
hdd: 0 sectors (0 MB) w/1900KiB Cache, CHS=513/0/3
hdd: INVALID GEOMETRY: 0 PHYSICAL HEADS?
ide-floppy driver 0.97
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 378k freed
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
Freeing unused kernel memory: 220k freed
Adding Swap: 136512k swap-space (priority -1)
Adding Swap: 88316k swap-space (priority -2)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.259 $ time 17:36:49 Sep  6 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 3
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.251:USB Universal Host Controller Interface driver
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
8139too Fast Ethernet driver 0.9.18a
PCI: Found IRQ 10 for device 00:10.0
PCI: Sharing IRQ 10 with 00:04.0
eth0: RealTek RTL8139 Fast Ethernet at 0xc8866100, 00:00:21:db:01:e7, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139B'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
lp0: console ready
