Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268078AbTBRWzV>; Tue, 18 Feb 2003 17:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268087AbTBRWzV>; Tue, 18 Feb 2003 17:55:21 -0500
Received: from achenar.cyan.com ([216.64.128.131]:13249 "EHLO cyan.com")
	by vger.kernel.org with ESMTP id <S268078AbTBRWyn>;
	Tue, 18 Feb 2003 17:54:43 -0500
From: "Rob Emanuele" <rje@cyan.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fixing a non-redundant raid
Date: Tue, 18 Feb 2003 15:04:44 -0800
Organization: Cyan Worlds, Inc.
Message-ID: <002d01c2d7a2$2071adf0$a301a8c0@rje1xp>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002E_01C2D75F.124E6DF0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_002E_01C2D75F.124E6DF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I've got a raid that I was running w/o a spare disk.  One of the drives
was being flakey and I restarted the machine and I was wondering if I
can recover the data on the raid.  It did not have a spare disk.  There
are 12 drives in the stripe set.  According the the logs one drive isn't
listed as a raid drive (sdi1) and the other's (sdb1) event counter is
behind.  Is there anything I can do or is it a loss and I should rebuild
the array with a hot spare :)?

I attached the logs.

Thanks for any help,

Rob

------=_NextPart_000_002E_01C2D75F.124E6DF0
Content-Type: application/octet-stream;
	name="raid.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="raid.log"

Feb  4 00:12:38 blackhole syslogd 1.4.1: restart.
Feb  4 00:12:38 blackhole syslog: syslogd startup succeeded
Feb  4 00:12:38 blackhole syslog: klogd startup succeeded
Feb  4 00:12:38 blackhole kernel: klogd 1.4.1, log source =3D /proc/kmsg =
started.
Feb  4 00:12:38 blackhole kernel: Inspecting /boot/System.map-2.4.7-10
Feb  4 00:12:39 blackhole portmap: portmap startup succeeded
Feb  4 00:12:39 blackhole kernel: Loaded 15046 symbols from =
/boot/System.map-2.4.7-10.
Feb  4 00:12:39 blackhole kernel: Symbols match kernel version 2.4.7.
Feb  4 00:12:39 blackhole kernel: Loaded 407 symbols from 18 modules.
Feb  4 00:12:39 blackhole kernel: Linux version 2.4.7-10 =
(bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red =
Hat Linux 7.1 2.96-98)) #1 Thu Sep 6 17:27:27 EDT 2001
Feb  4 00:12:39 blackhole kernel: BIOS-provided physical RAM map:
Feb  4 00:12:39 blackhole kernel:  BIOS-e820: 0000000000000000 - =
00000000000a0000 (usable)
Feb  4 00:12:39 blackhole kernel:  BIOS-e820: 00000000000f0000 - =
0000000000100000 (reserved)
Feb  4 00:12:39 blackhole kernel:  BIOS-e820: 0000000000100000 - =
0000000007ffe000 (usable)
Feb  4 00:12:39 blackhole kernel:  BIOS-e820: 0000000007ffe000 - =
0000000008000000 (reserved)
Feb  4 00:12:39 blackhole kernel:  BIOS-e820: 00000000ffe00000 - =
0000000100000000 (reserved)
Feb  4 00:12:39 blackhole kernel: Scanning bios EBDA for MXT signature
Feb  4 00:12:39 blackhole kernel: On node 0 totalpages: 32766
Feb  4 00:12:39 blackhole nfslock: rpc.statd startup succeeded
Feb  4 00:12:39 blackhole rpc.statd[624]: Version 0.3.1 Starting
Feb  4 00:12:39 blackhole kernel: zone(0): 4096 pages.
Feb  4 00:12:39 blackhole kernel: zone(1): 28670 pages.
Feb  4 00:12:39 blackhole kernel: zone(2): 0 pages.
Feb  4 00:12:40 blackhole kernel: Kernel command line: ro =
root=3D/dev/hda2 console=3DttyS1,9600
Feb  4 00:12:40 blackhole kernel: Initializing CPU#0
Feb  4 00:12:40 blackhole kernel: Detected 298.002 MHz processor.
Feb  4 00:12:40 blackhole kernel: Console: colour VGA+ 80x25
Feb  4 00:12:40 blackhole kernel: Calibrating delay loop... 594.73 =
BogoMIPS
Feb  4 00:12:11 blackhole rc.sysinit: Mounting proc filesystem:  =
succeeded=20
Feb  4 00:12:40 blackhole kernel: Memory: 125156k/131064k available =
(1269k kernel code, 4628k reserved, 90k data, 220k init, 0k highmem)
Feb  4 00:12:11 blackhole rc.sysinit: Unmounting initrd:  succeeded=20
Feb  4 00:12:40 blackhole kernel: Dentry-cache hash table entries: 16384 =
(order: 5, 131072 bytes)
Feb  4 00:12:11 blackhole sysctl: net.ipv4.ip_forward =3D 1 # needed for =
ppp=20
Feb  4 00:12:41 blackhole kernel: Inode-cache hash table entries: 8192 =
(order: 4, 65536 bytes)
Feb  4 00:12:11 blackhole sysctl: net.ipv4.conf.default.rp_filter =3D 1=20
Feb  4 00:12:41 blackhole keytable: Loading keymap:  succeeded
Feb  4 00:12:41 blackhole kernel: Mount-cache hash table entries: 2048 =
(order: 2, 16384 bytes)
Feb  4 00:12:11 blackhole sysctl: kernel.sysrq =3D 0=20
Feb  4 00:12:41 blackhole kernel: Buffer-cache hash table entries: 4096 =
(order: 2, 16384 bytes)
Feb  4 00:12:11 blackhole rc.sysinit: Configuring kernel parameters:  =
succeeded=20
Feb  4 00:12:41 blackhole kernel: Page-cache hash table entries: 32768 =
(order: 6, 262144 bytes)
Feb  4 00:12:11 blackhole date: Tue Feb  4 00:12:00 PST 2003=20
Feb  4 00:12:11 blackhole rc.sysinit: Setting clock  (utc): Tue Feb  4 =
00:12:00 PST 2003 succeeded=20
Feb  4 00:12:41 blackhole kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Feb  4 00:12:11 blackhole rc.sysinit: Activating swap partitions:  =
succeeded=20
Feb  4 00:12:42 blackhole kernel: CPU: L2 cache: 512K
Feb  4 00:12:11 blackhole rc.sysinit: Setting hostname =
localhost.localdomain:  succeeded=20
Feb  4 00:12:42 blackhole keytable: Loading system font:  succeeded
Feb  4 00:12:42 blackhole kernel: Intel machine check architecture =
supported.
Feb  4 00:12:11 blackhole rc.sysinit: Mounting USB filesystem:  =
succeeded=20
Feb  4 00:12:42 blackhole kernel: Intel machine check reporting enabled =
on CPU#0.
Feb  4 00:12:11 blackhole rc.sysinit: Initializing USB controller =
(usb-uhci):  succeeded=20
Feb  4 00:12:11 blackhole fsck: /: clean, 177323/749248 files, =
745649/1498061 blocks=20
Feb  4 00:12:11 blackhole fsck: [/sbin/fsck.ext3 -- /] fsck.ext3 -a =
/dev/hda2 =20
Feb  4 00:12:11 blackhole rc.sysinit: Checking root filesystem succeeded =

Feb  4 00:12:11 blackhole rc.sysinit: Remounting root filesystem in =
read-write mode:  succeeded=20
Feb  4 00:12:24 blackhole rc.sysinit: Finding module dependencies:  =
succeeded=20
Feb  4 00:12:26 blackhole rc.sysinit: Loading sound module (cs4232):  =
succeeded=20
Feb  4 00:12:42 blackhole random: Initializing random number generator:  =
succeeded
Feb  4 00:12:42 blackhole kernel: CPU: Intel Pentium II (Klamath) =
stepping 04
Feb  4 00:12:28 blackhole fsck: /boot: clean, 43/12048 files, =
12261/48163 blocks=20
Feb  4 00:12:42 blackhole kernel: Checking 'hlt' instruction... OK.
Feb  4 00:12:28 blackhole fsck: Checking all file systems.=20
Feb  4 00:12:28 blackhole rc.sysinit: Checking filesystems succeeded=20
Feb  4 00:12:28 blackhole fsck: [/sbin/fsck.ext3 -- /boot] fsck.ext3 -a =
/dev/hda1 =20
Feb  4 00:12:42 blackhole kernel: POSIX conformance testing by UNIFIX
Feb  4 00:12:42 blackhole kernel: mtrr: v1.40 (20010327) Richard Gooch =
(rgooch@atnf.csiro.au)
Feb  4 00:12:28 blackhole mount: =
/home/dist/linux/redhat/8.0/iso/psyche-i386-disc1.iso: No such file or =
directory=20
Feb  4 00:12:28 blackhole mount: =
/home/dist/linux/redhat/8.0/iso/psyche-i386-disc2.iso: No such file or =
directory=20
Feb  4 00:12:28 blackhole mount: =
/home/dist/linux/redhat/8.0/iso/psyche-i386-disc3.iso: No such file or =
directory=20
Feb  4 00:12:42 blackhole kernel: mtrr: detected mtrr type: Intel
Feb  4 00:12:28 blackhole mount: =
/home/dist/linux/redhat/8.0/iso/psyche-i386-disc4.iso: No such file or =
directory=20
Feb  4 00:12:42 blackhole kernel: PCI: PCI BIOS revision 2.10 entry at =
0xfcaae, last bus=3D2
Feb  4 00:12:28 blackhole mount: =
/home/dist/linux/redhat/8.0/iso/psyche-i386-disc5.iso: No such file or =
directory=20
Feb  4 00:12:43 blackhole kernel: PCI: Using configuration type 1
Feb  4 00:12:28 blackhole rc.sysinit: Mounting local filesystems:  =
failed=20
Feb  4 00:12:43 blackhole kernel: PCI: Probing PCI hardware
Feb  4 00:12:29 blackhole rc.sysinit: Enabling local filesystem quotas:  =
succeeded=20
Feb  4 00:12:43 blackhole kernel: PCI: Using IRQ router PIIX [8086/7110] =
at 00:07.0
Feb  4 00:12:29 blackhole rc.sysinit: Turning on process accounting =
succeeded=20
Feb  4 00:12:43 blackhole kernel: Limiting direct PCI/PCI transfers.
Feb  4 00:12:30 blackhole rc.sysinit: Enabling swap space:  succeeded=20
Feb  4 00:12:45 blackhole mount: =
/home/dist/linux/redhat/8.0/iso/psyche-i386-disc1.iso: No such file or =
directory
Feb  4 00:12:45 blackhole kernel: isapnp: Scanning for PnP cards...
Feb  4 00:12:32 blackhole init: Entering runlevel: 3=20
Feb  4 00:12:45 blackhole mount: =
/home/dist/linux/redhat/8.0/iso/psyche-i386-disc2.iso: No such file or =
directory
Feb  4 00:12:45 blackhole kernel: isapnp: Card 'CS4236B'
Feb  4 00:12:34 blackhole kudzu: Updating /etc/fstab succeeded=20
Feb  4 00:12:45 blackhole mount: =
/home/dist/linux/redhat/8.0/iso/psyche-i386-disc3.iso: No such file or =
directory
Feb  4 00:12:45 blackhole kernel: isapnp: 1 Plug & Play card detected =
total
Feb  4 00:12:35 blackhole kudzu:  succeeded=20
Feb  4 00:12:45 blackhole mount: =
/home/dist/linux/redhat/8.0/iso/psyche-i386-disc4.iso: No such file or =
directory
Feb  4 00:12:45 blackhole kernel: Linux NET4.0 for Linux 2.4
Feb  4 00:12:36 blackhole sysctl: net.ipv4.ip_forward =3D 1 # needed for =
ppp=20
Feb  4 00:12:45 blackhole mount: =
/home/dist/linux/redhat/8.0/iso/psyche-i386-disc5.iso: No such file or =
directory
Feb  4 00:12:45 blackhole kernel: Based upon Swansea University Computer =
Society NET3.039
Feb  4 00:12:36 blackhole sysctl: net.ipv4.conf.default.rp_filter =3D 1=20
Feb  4 00:12:45 blackhole netfs: Mounting other filesystems:  failed
Feb  4 00:12:45 blackhole kernel: Initializing RT netlink socket
Feb  4 00:12:36 blackhole sysctl: kernel.sysrq =3D 0=20
Feb  4 00:12:45 blackhole kernel: apm: BIOS version 1.2 Flags 0x03 =
(Driver version 1.14)
Feb  4 00:12:36 blackhole network: Setting network parameters:  =
succeeded=20
Feb  4 00:12:45 blackhole kernel: mxt_scan_bios: enter
Feb  4 00:12:37 blackhole network: Bringing up interface lo:  succeeded=20
Feb  4 00:12:45 blackhole kernel: Starting kswapd v1.8
Feb  4 00:12:37 blackhole ifup: Determining IP information for eth0...=20
Feb  4 00:12:45 blackhole kernel: VFS: Diskquotas version dquot_6.5.0 =
initialized
Feb  4 00:12:37 blackhole ifup:  done.=20
Feb  4 00:12:45 blackhole apmd[736]: Version 3.0final (APM BIOS 1.2, =
Linux driver 1.14)
Feb  4 00:12:45 blackhole apmd: apmd startup succeeded
Feb  4 00:12:45 blackhole kernel: Detected PS/2 Mouse Port.
Feb  4 00:12:38 blackhole network: Bringing up interface eth0:  =
succeeded=20
Feb  4 00:12:46 blackhole kernel: pty: 2048 Unix98 ptys configured
Feb  4 00:12:46 blackhole apmd[736]: Charge: * * * (-1% unknown)
Feb  4 00:12:46 blackhole kernel: Serial driver version 5.05c =
(2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP =
enabled
Feb  4 00:12:46 blackhole kernel: ttyS00 at 0x03f8 (irq =3D 4) is a =
16550A
Feb  4 00:12:46 blackhole kernel: ttyS01 at 0x02f8 (irq =3D 3) is a =
16550A
Feb  4 00:12:46 blackhole ntpd: ntpd startup succeeded
Feb  4 00:12:46 blackhole kernel: Real Time Clock Driver v1.10d
Feb  4 00:12:46 blackhole ntpd[756]: ntpd 4.1.0 Wed Sep  5 06:54:30 EDT =
2001 (1)
Feb  4 00:12:46 blackhole kernel: block: queued sectors max/low =
83069kB/27689kB, 256 slots per queue
Feb  4 00:12:46 blackhole kernel: RAMDISK driver initialized: 16 RAM =
disks of 4096K size 1024 blocksize
Feb  4 00:12:46 blackhole kernel: Uniform Multi-Platform E-IDE driver =
Revision: 6.31
Feb  4 00:12:47 blackhole kernel: ide: Assuming 33MHz PCI bus speed for =
PIO modes; override with idebus=3Dxx
Feb  4 00:12:47 blackhole kernel: PIIX4: IDE controller on PCI bus 00 =
dev 39
Feb  4 00:12:47 blackhole kernel: PIIX4: chipset revision 1
Feb  4 00:12:47 blackhole ntpd[756]: precision =3D 110 usec
Feb  4 00:12:47 blackhole kernel: PIIX4: not 100%% native mode: will =
probe irqs later
Feb  4 00:12:47 blackhole ntpd[756]: kernel time discipline status 0040
Feb  4 00:12:47 blackhole kernel:     ide0: BM-DMA at 0xffa0-0xffa7, =
BIOS settings: hda:DMA, hdb:pio
Feb  4 00:12:47 blackhole kernel: hda: Maxtor 86480D6, ATA DISK drive
Feb  4 00:12:47 blackhole ntpd[756]: frequency initialized 8.138 from =
/etc/ntp/drift
Feb  4 00:12:47 blackhole kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  4 00:12:47 blackhole kernel: hda: 12594960 sectors (6449 MB) =
w/256KiB Cache, CHS=3D784/255/63, UDMA(33)
Feb  4 00:12:47 blackhole kernel: ide-floppy driver 0.97
Feb  4 00:12:47 blackhole kernel: Partition check:
Feb  4 00:12:47 blackhole kernel:  hda: hda1 hda2 hda3
Feb  4 00:12:47 blackhole kernel: Floppy drive(s): fd0 is 1.44M
Feb  4 00:12:47 blackhole kernel: FDC 0 is a National Semiconductor =
PC87306
Feb  4 00:12:47 blackhole kernel: ide-floppy driver 0.97
Feb  4 00:12:47 blackhole kernel: md: md driver 0.90.0 =
MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
Feb  4 00:12:48 blackhole kernel: md: Autodetecting RAID arrays.
Feb  4 00:12:48 blackhole kernel: md: autorun ...
Feb  4 00:12:48 blackhole kernel: md: ... autorun DONE.
Feb  4 00:12:48 blackhole kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb  4 00:12:48 blackhole kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Feb  4 00:12:48 blackhole kernel: IP: routing cache hash table of 512 =
buckets, 4Kbytes
Feb  4 00:12:48 blackhole kernel: TCP: Hash tables configured =
(established 8192 bind 8192)
Feb  4 00:12:48 blackhole kernel: Linux IP multicast router 0.06 plus =
PIM-SM
Feb  4 00:12:48 blackhole kernel: NET4: Unix domain sockets 1.0/SMP for =
Linux NET4.0.
Feb  4 00:12:48 blackhole kernel: RAMDISK: Compressed image found at =
block 0
Feb  4 00:12:48 blackhole kernel: Freeing initrd memory: 425k freed
Feb  4 00:12:48 blackhole kernel: EXT2-fs warning: checktime reached, =
running e2fsck is recommended
Feb  4 00:12:48 blackhole kernel: VFS: Mounted root (ext2 filesystem).
Feb  4 00:12:48 blackhole kernel: SCSI subsystem driver Revision: 1.00
Feb  4 00:12:48 blackhole kernel: PCI: Found IRQ 10 for device 00:0d.0
Feb  4 00:12:48 blackhole kernel: sym53c8xx: at PCI bus 0, device 13, =
function 0
Feb  4 00:12:48 blackhole kernel: sym53c8xx: setting =
PCI_COMMAND_PARITY...(fix-up)
Feb  4 00:12:48 blackhole kernel: sym53c8xx: 53c875 detected with =
Symbios NVRAM
Feb  4 00:12:48 blackhole kernel: PCI: Found IRQ 11 for device 00:0e.0
Feb  4 00:12:48 blackhole kernel: sym53c8xx: at PCI bus 0, device 14, =
function 0
Feb  4 00:12:48 blackhole autofs: automount startup succeeded
Feb  4 00:12:48 blackhole kernel: sym53c8xx: setting =
PCI_COMMAND_PARITY...(fix-up)
Feb  4 00:12:48 blackhole kernel: sym53c8xx: 53c875 detected with =
Symbios NVRAM
Feb  4 00:12:48 blackhole kernel: sym53c875-0: rev 0x26 on pci bus 0 =
device 13 function 0 irq 10
Feb  4 00:12:48 blackhole kernel: sym53c875-0: Symbios format NVRAM, ID =
7, Fast-20, Parity Checking
Feb  4 00:12:48 blackhole kernel: sym53c875-0: on-chip RAM at 0xff001000
Feb  4 00:12:48 blackhole kernel: sym53c875-0: restart (scsi reset).
Feb  4 00:12:48 blackhole kernel: sym53c875-0: Downloading SCSI SCRIPTS.
Feb  4 00:12:48 blackhole kernel: sym53c875-1: rev 0x26 on pci bus 0 =
device 14 function 0 irq 11
Feb  4 00:12:48 blackhole kernel: sym53c875-1: Symbios format NVRAM, ID =
7, Fast-20, Parity Checking
Feb  4 00:12:48 blackhole kernel: sym53c875-1: on-chip RAM at 0xff000000
Feb  4 00:12:48 blackhole kernel: sym53c875-1: restart (scsi reset).
Feb  4 00:12:48 blackhole kernel: sym53c875-1: Downloading SCSI SCRIPTS.
Feb  4 00:12:48 blackhole kernel: scsi0 : sym53c8xx-1.7.3c-20010512
Feb  4 00:12:48 blackhole kernel: scsi1 : sym53c8xx-1.7.3c-20010512
Feb  4 00:12:48 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1806
Feb  4 00:12:48 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:48 blackhole nscd: nscd startup succeeded
Feb  4 00:12:48 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1705
Feb  4 00:12:48 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:48 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1705
Feb  4 00:12:48 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:48 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1806
Feb  4 00:12:48 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:48 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1705
Feb  4 00:12:48 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:48 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1705
Feb  4 00:12:49 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<9,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<10,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<11,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<12,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<13,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<14,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel:   Vendor: MATSHITA  Model: CD-ROM =
CR-8005A   Rev: 4.0i
Feb  4 00:12:49 blackhole kernel:   Type:   CD-ROM                       =
      ANSI SCSI revision: 02
Feb  4 00:12:49 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1806
Feb  4 00:12:49 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:49 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1806
Feb  4 00:12:49 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:49 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1806
Feb  4 00:12:49 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:49 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1806
Feb  4 00:12:49 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:49 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1806
Feb  4 00:12:49 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:49 blackhole kernel:   Vendor: FUJITSU   Model: MAB3091S =
SUN9.0G  Rev: 1806
Feb  4 00:12:49 blackhole kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 02
Feb  4 00:12:49 blackhole kernel: sym53c875-1-<9,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel: sym53c875-1-<10,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel: sym53c875-1-<11,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel: sym53c875-1-<12,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel: sym53c875-1-<13,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel: sym53c875-1-<14,0>: tagged command =
queue depth set to 8
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sda at scsi0, =
channel 0, id 9, lun 0
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sdb at scsi0, =
channel 0, id 10, lun 0
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sdc at scsi0, =
channel 0, id 11, lun 0
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sdd at scsi0, =
channel 0, id 12, lun 0
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sde at scsi0, =
channel 0, id 13, lun 0
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sdf at scsi0, =
channel 0, id 14, lun 0
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sdg at scsi1, =
channel 0, id 9, lun 0
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sdh at scsi1, =
channel 0, id 10, lun 0
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sdi at scsi1, =
channel 0, id 11, lun 0
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sdj at scsi1, =
channel 0, id 12, lun 0
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sdk at scsi1, =
channel 0, id 13, lun 0
Feb  4 00:12:49 blackhole kernel: Attached scsi disk sdl at scsi1, =
channel 0, id 14, lun 0
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<9,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:49 blackhole kernel: SCSI device sda: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:49 blackhole kernel:  sda: sda1
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<10,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:49 blackhole kernel: SCSI device sdb: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:49 blackhole kernel:  sdb: sdb1
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<11,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:49 blackhole kernel: SCSI device sdc: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:49 blackhole kernel:  sdc: sdc1
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<12,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:49 blackhole kernel: SCSI device sdd: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:49 blackhole kernel:  sdd: sdd1
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<13,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:49 blackhole kernel: SCSI device sde: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:49 blackhole kernel:  sde: sde1
Feb  4 00:12:49 blackhole kernel: sym53c875-0-<14,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:49 blackhole kernel: SCSI device sdf: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:49 blackhole kernel:  sdf: sdf1
Feb  4 00:12:49 blackhole kernel: sym53c875-1-<9,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:50 blackhole kernel: SCSI device sdg: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:50 blackhole kernel:  sdg: sdg1
Feb  4 00:12:50 blackhole kernel: sym53c875-1-<10,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:50 blackhole kernel: SCSI device sdh: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:50 blackhole kernel:  sdh: sdh1
Feb  4 00:12:50 blackhole kernel: sym53c875-1-<11,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:50 blackhole kernel: SCSI device sdi: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:50 blackhole kernel:  sdi: sdi1
Feb  4 00:12:50 blackhole kernel: sym53c875-1-<12,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:50 blackhole kernel: SCSI device sdj: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:50 blackhole kernel:  sdj: sdj1
Feb  4 00:12:50 blackhole kernel: sym53c875-1-<13,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:50 blackhole kernel: SCSI device sdk: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:50 blackhole kernel:  sdk: sdk1
Feb  4 00:12:50 blackhole kernel: sym53c875-1-<14,*>: FAST-20 WIDE SCSI =
40.0 MB/s (50.0 ns, offset 16)
Feb  4 00:12:50 blackhole kernel: SCSI device sdl: 17689267 512-byte =
hdwr sectors (9057 MB)
Feb  4 00:12:50 blackhole kernel:  sdl: sdl1
Feb  4 00:12:50 blackhole kernel: Journalled Block Device driver loaded
Feb  4 00:12:50 blackhole kernel: EXT3-fs: INFO: recovery required on =
readonly filesystem.
Feb  4 00:12:50 blackhole kernel: EXT3-fs: write access will be enabled =
during recovery.
Feb  4 00:12:50 blackhole kernel: kjournald starting.  Commit interval 5 =
seconds
Feb  4 00:12:50 blackhole kernel: EXT3-fs: recovery complete.
Feb  4 00:12:50 blackhole kernel: EXT3-fs: mounted filesystem with =
ordered data mode.
Feb  4 00:12:50 blackhole kernel: Freeing unused kernel memory: 220k =
freed
Feb  4 00:12:50 blackhole kernel: Adding Swap: 257032k swap-space =
(priority -1)
Feb  4 00:12:50 blackhole kernel: usb.c: registered new driver usbdevfs
Feb  4 00:12:50 blackhole kernel: usb.c: registered new driver hub
Feb  4 00:12:50 blackhole kernel: usb-uhci.c: $Revision: 1.259 $ time =
17:36:49 Sep  6 2001
Feb  4 00:12:50 blackhole kernel: usb-uhci.c: High bandwidth mode =
enabled
Feb  4 00:12:50 blackhole kernel: PCI: Found IRQ 11 for device 00:07.2
Feb  4 00:12:50 blackhole kernel: PCI: Sharing IRQ 11 with 00:11.0
Feb  4 00:12:50 blackhole kernel: usb-uhci.c: USB UHCI at I/O 0xcce0, =
IRQ 11
Feb  4 00:12:50 blackhole kernel: usb-uhci.c: Detected 2 ports
Feb  4 00:12:50 blackhole kernel: usb.c: new USB bus registered, =
assigned bus number 1
Feb  4 00:12:50 blackhole kernel: hub.c: USB hub found
Feb  4 00:12:50 blackhole kernel: hub.c: 2 ports detected
Feb  4 00:12:50 blackhole kernel: usb-uhci.c: v1.251:USB Universal Host =
Controller Interface driver
Feb  4 00:12:50 blackhole ldap: slapd startup succeeded
Feb  4 00:12:50 blackhole kernel: EXT3 FS 2.4-0.9.8, 25 Aug 2001 on =
ide0(3,2), internal journal
Feb  4 00:12:50 blackhole kernel: ad1848/cs4248 codec driver Copyright =
(C) by Hannu Savolainen 1993-1996
Feb  4 00:12:50 blackhole kernel: cs4232: set synthio and synthirq to =
use the wavefront facilities.
Feb  4 00:12:50 blackhole kernel: (read) sda1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:12:51 blackhole kernel: (read) sdb1's sb offset: 8844160 =
[events: 00000087]
Feb  4 00:12:51 blackhole kernel: (read) sdc1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:12:51 blackhole kernel: (read) sdd1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:12:51 blackhole kernel: (read) sde1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:12:51 blackhole kernel: (read) sdf1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:12:51 blackhole kernel: (read) sdg1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:12:51 blackhole kernel: (read) sdh1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:12:51 blackhole kernel: (read) sdj1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:12:51 blackhole kernel: (read) sdk1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:12:51 blackhole kernel: (read) sdl1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:12:51 blackhole kernel: md: autorun ...
Feb  4 00:12:51 blackhole kernel: md: considering sdl1 ...
Feb  4 00:12:51 blackhole sshd: Starting sshd:
Feb  4 00:12:51 blackhole kernel: md:  adding sdl1 ...
Feb  4 00:12:51 blackhole kernel: md:  adding sdk1 ...
Feb  4 00:12:51 blackhole kernel: md:  adding sdj1 ...
Feb  4 00:12:51 blackhole kernel: md:  adding sdh1 ...
Feb  4 00:12:51 blackhole kernel: md:  adding sdg1 ...
Feb  4 00:12:51 blackhole kernel: md:  adding sdf1 ...
Feb  4 00:12:51 blackhole kernel: md:  adding sde1 ...
Feb  4 00:12:51 blackhole kernel: md:  adding sdd1 ...
Feb  4 00:12:51 blackhole kernel: md:  adding sdc1 ...
Feb  4 00:12:51 blackhole kernel: md:  adding sdb1 ...
Feb  4 00:12:51 blackhole kernel: md:  adding sda1 ...
Feb  4 00:12:51 blackhole sshd:  succeeded
Feb  4 00:12:51 blackhole kernel: md: created md0
Feb  4 00:12:51 blackhole kernel: md: bind<sda1,1>
Feb  4 00:12:51 blackhole sshd:=20
Feb  4 00:12:51 blackhole kernel: md: bind<sdb1,2>
Feb  4 00:12:52 blackhole rc: Starting sshd:  succeeded
Feb  4 00:12:52 blackhole kernel: md: bind<sdc1,3>
Feb  4 00:12:52 blackhole kernel: md: bind<sdd1,4>
Feb  4 00:12:52 blackhole kernel: md: bind<sde1,5>
Feb  4 00:12:52 blackhole kernel: md: bind<sdf1,6>
Feb  4 00:12:52 blackhole kernel: md: bind<sdg1,7>
Feb  4 00:12:52 blackhole kernel: md: bind<sdh1,8>
Feb  4 00:12:52 blackhole kernel: md: bind<sdj1,9>
Feb  4 00:12:52 blackhole kernel: md: bind<sdk1,10>
Feb  4 00:12:52 blackhole kernel: md: bind<sdl1,11>
Feb  4 00:12:52 blackhole kernel: md: running: =
<sdl1><sdk1><sdj1><sdh1><sdg1><sdf1><sde1><sdd1><sdc1><sdb1><sda1>
Feb  4 00:12:52 blackhole kernel: md: sdl1's event counter: 00000089
Feb  4 00:12:52 blackhole kernel: md: sdk1's event counter: 00000089
Feb  4 00:12:52 blackhole kernel: md: sdj1's event counter: 00000089
Feb  4 00:12:52 blackhole kernel: md: sdh1's event counter: 00000089
Feb  4 00:12:52 blackhole kernel: md: sdg1's event counter: 00000089
Feb  4 00:12:52 blackhole kernel: md: sdf1's event counter: 00000089
Feb  4 00:12:52 blackhole kernel: md: sde1's event counter: 00000089
Feb  4 00:12:52 blackhole kernel: md: sdd1's event counter: 00000089
Feb  4 00:12:52 blackhole kernel: md: sdc1's event counter: 00000089
Feb  4 00:12:52 blackhole kernel: md: sdb1's event counter: 00000087
Feb  4 00:12:52 blackhole kernel: md: sda1's event counter: 00000089
Feb  4 00:12:52 blackhole kernel: md: superblock update time =
inconsistency -- using the most recent one
Feb  4 00:12:53 blackhole kernel: md: freshest: sdl1
Feb  4 00:12:53 blackhole kernel: md: kicking non-fresh sdb1 from array!
Feb  4 00:12:53 blackhole kernel: md: unbind<sdb1,10>
Feb  4 00:12:53 blackhole kernel: md: export_rdev(sdb1)
Feb  4 00:12:53 blackhole kernel: md0: removing former faulty sdb1!
Feb  4 00:12:53 blackhole kernel: raid5: measuring checksumming speed
Feb  4 00:12:53 blackhole kernel:    8regs     :   549.600 MB/sec
Feb  4 00:12:53 blackhole kernel:    32regs    :   258.800 MB/sec
Feb  4 00:12:53 blackhole kernel:    pII_mmx   :   671.200 MB/sec
Feb  4 00:12:53 blackhole kernel:    p5_mmx    :   700.800 MB/sec
Feb  4 00:12:53 blackhole kernel: raid5: using function: p5_mmx (700.800 =
MB/sec)
Feb  4 00:12:53 blackhole kernel: md: raid5 personality registered as nr =
4
Feb  4 00:12:53 blackhole kernel: md0: max total readahead window set to =
2816k
Feb  4 00:12:53 blackhole kernel: md0: 11 data-disks, max readahead per =
data-disk: 256k
Feb  4 00:12:53 blackhole kernel: raid5: device sdl1 operational as raid =
disk 11
Feb  4 00:12:53 blackhole kernel: raid5: device sdk1 operational as raid =
disk 10
Feb  4 00:12:53 blackhole kernel: raid5: device sdj1 operational as raid =
disk 9
Feb  4 00:12:53 blackhole kernel: raid5: device sdh1 operational as raid =
disk 7
Feb  4 00:12:53 blackhole kernel: raid5: device sdg1 operational as raid =
disk 6
Feb  4 00:12:53 blackhole kernel: raid5: device sdf1 operational as raid =
disk 5
Feb  4 00:12:53 blackhole kernel: raid5: device sde1 operational as raid =
disk 4
Feb  4 00:12:53 blackhole kernel: raid5: device sdd1 operational as raid =
disk 3
Feb  4 00:12:53 blackhole kernel: raid5: device sdc1 operational as raid =
disk 2
Feb  4 00:12:53 blackhole kernel: raid5: device sda1 operational as raid =
disk 0
Feb  4 00:12:53 blackhole kernel: raid5: not enough operational devices =
for md0 (2/12 failed)
Feb  4 00:12:53 blackhole kernel: RAID5 conf printout:
Feb  4 00:12:53 blackhole kernel:  --- rd:12 wd:10 fd:2
Feb  4 00:12:53 blackhole kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 =
dev:sda1
Feb  4 00:12:53 blackhole kernel:  disk 1, s:0, o:0, n:1 rd:1 us:1 =
dev:[dev 00:00]
Feb  4 00:12:53 blackhole kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 =
dev:sdc1
Feb  4 00:12:53 blackhole kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 =
dev:sdd1
Feb  4 00:12:53 blackhole kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 =
dev:sde1
Feb  4 00:12:53 blackhole kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 =
dev:sdf1
Feb  4 00:12:53 blackhole kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 =
dev:sdg1
Feb  4 00:12:53 blackhole kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 =
dev:sdh1
Feb  4 00:12:53 blackhole kernel:  disk 8, s:0, o:0, n:8 rd:8 us:1 =
dev:[dev 00:00]
Feb  4 00:12:53 blackhole kernel:  disk 9, s:0, o:1, n:9 rd:9 us:1 =
dev:sdj1
Feb  4 00:12:53 blackhole kernel:  disk 10, s:0, o:1, n:10 rd:10 us:1 =
dev:sdk1
Feb  4 00:12:53 blackhole kernel:  disk 11, s:0, o:1, n:11 rd:11 us:1 =
dev:sdl1
Feb  4 00:12:53 blackhole kernel: raid5: failed to run raid set md0
Feb  4 00:12:53 blackhole kernel: md: pers->run() failed ...
Feb  4 00:12:53 blackhole kernel: md :do_md_run() returned -22
Feb  4 00:12:53 blackhole kernel: md: md0 stopped.
Feb  4 00:12:54 blackhole kernel: md: unbind<sdl1,9>
Feb  4 00:12:54 blackhole kernel: md: export_rdev(sdl1)
Feb  4 00:12:54 blackhole kernel: md: unbind<sdk1,8>
Feb  4 00:12:54 blackhole kernel: md: export_rdev(sdk1)
Feb  4 00:12:54 blackhole kernel: md: unbind<sdj1,7>
Feb  4 00:12:54 blackhole kernel: md: export_rdev(sdj1)
Feb  4 00:12:54 blackhole kernel: md: unbind<sdh1,6>
Feb  4 00:12:54 blackhole kernel: md: export_rdev(sdh1)
Feb  4 00:12:54 blackhole kernel: md: unbind<sdg1,5>
Feb  4 00:12:54 blackhole kernel: md: export_rdev(sdg1)
Feb  4 00:12:54 blackhole kernel: md: unbind<sdf1,4>
Feb  4 00:12:54 blackhole kernel: md: export_rdev(sdf1)
Feb  4 00:12:54 blackhole kernel: md: unbind<sde1,3>
Feb  4 00:12:54 blackhole kernel: md: export_rdev(sde1)
Feb  4 00:12:54 blackhole kernel: md: unbind<sdd1,2>
Feb  4 00:12:54 blackhole kernel: md: export_rdev(sdd1)
Feb  4 00:12:54 blackhole kernel: md: unbind<sdc1,1>
Feb  4 00:12:54 blackhole kernel: md: export_rdev(sdc1)
Feb  4 00:12:54 blackhole kernel: md: unbind<sda1,0>
Feb  4 00:12:54 blackhole kernel: md: export_rdev(sda1)
Feb  4 00:12:54 blackhole kernel: md: ... autorun DONE.
Feb  4 00:12:54 blackhole kernel: kjournald starting.  Commit interval 5 =
seconds
Feb  4 00:12:54 blackhole kernel: EXT3 FS 2.4-0.9.8, 25 Aug 2001 on =
ide0(3,1), internal journal
Feb  4 00:12:54 blackhole kernel: EXT3-fs: mounted filesystem with =
ordered data mode.
Feb  4 00:12:54 blackhole kernel: loop: loaded (max 8 devices)
Feb  4 00:12:54 blackhole kernel: 0x378: FIFO is 16 bytes
Feb  4 00:12:54 blackhole kernel: 0x378: writeIntrThreshold is 8
Feb  4 00:12:54 blackhole kernel: 0x378: readIntrThreshold is 8
Feb  4 00:12:54 blackhole kernel: parport0: PC-style at 0x378 (0x778) =
[PCSPP,TRISTATE,COMPAT,EPP,ECP]
Feb  4 00:12:54 blackhole kernel: parport0: irq 7 detected
Feb  4 00:12:54 blackhole kernel: NET4: Linux IPX 0.47 for NET4.0
Feb  4 00:12:54 blackhole kernel: IPX Portions Copyright (c) 1995 =
Caldera, Inc.
Feb  4 00:12:54 blackhole kernel: IPX Portions Copyright (c) 2000, 2001 =
Conectiva, Inc.
Feb  4 00:12:54 blackhole kernel: NET4: AppleTalk 0.18a for Linux NET4.0
Feb  4 00:12:54 blackhole kernel: PCI: Found IRQ 11 for device 00:11.0
Feb  4 00:12:54 blackhole kernel: PCI: Sharing IRQ 11 with 00:07.2
Feb  4 00:12:54 blackhole kernel: 3c59x: Donald Becker and others. =
www.scyld.com/network/vortex.html
Feb  4 00:12:54 blackhole kernel: 00:11.0: 3Com PCI 3c905 Boomerang =
100baseTx at 0xcc80. Vers LK1.1.16
Feb  4 00:12:55 blackhole xinetd[893]: amanda disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: amandaidx disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: amidxtape disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: chargen disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: chargen disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: comsat disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: daytime disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: daytime disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: skkserv disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: echo disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: echo disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: eklogin disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: finger disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: ftp disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: imap disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: imaps disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: pop2 disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: pop3 disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: klogin disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: telnet disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: kshell disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: linuxconf disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: ntalk disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: pop3s disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: exec disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: login disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: shell disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: swat disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: talk disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: telnet disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: time disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: time disabled, removing
Feb  4 00:12:55 blackhole xinetd[893]: ftp disabled, removing
Feb  4 00:12:56 blackhole xinetd: xinetd startup succeeded
Feb  4 00:12:56 blackhole xinetd[893]: xinetd Version 2.3.3 started with =
libwrap options compiled in.
Feb  4 00:12:56 blackhole xinetd[893]: Started working: 3 available =
services
Feb  4 00:12:58 blackhole lpd: lpd startup succeeded
Feb  4 00:12:58 blackhole kernel:  ***INVALID CHECKSUM 003e*** =
<6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Feb  4 00:12:59 blackhole nfs: Starting NFS services:  succeeded
Feb  4 00:12:59 blackhole nfs: rpc.rquotad startup succeeded
Feb  4 00:12:59 blackhole nfs: rpc.mountd startup succeeded
Feb  4 00:12:59 blackhole nfs: rpc.nfsd startup succeeded
Feb  4 00:13:00 blackhole sendmail: sendmail startup succeeded
Feb  4 00:13:01 blackhole kernel: iSCSI version 2.0.1.8 ( 8-Aug-2001)
Feb  4 00:13:01 blackhole kernel: iSCSI control device major number 254
Feb  4 00:13:01 blackhole kernel: iSCSI: detected HBA c3664cfc, host #2
Feb  4 00:13:01 blackhole kernel: scsi2 : iSCSI (2.0.1.8)
Feb  4 00:13:01 blackhole iscsi: iscsilun startup succeeded
Feb  4 00:13:06 blackhole httpd: httpd startup succeeded
Feb  4 00:13:07 blackhole crond: crond startup succeeded
Feb  4 00:13:09 blackhole xfs: xfs startup succeeded
Feb  4 00:13:09 blackhole xfs: listening on port 7100=20
Feb  4 00:13:10 blackhole xfs: ignoring font path element =
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable)=20
Feb  4 00:13:10 blackhole xfs: ignoring font path element =
/usr/X11R6/lib/X11/fonts/local (unreadable)=20
Feb  4 00:13:10 blackhole smb: smbd startup succeeded
Feb  4 00:13:11 blackhole smb: nmbd startup succeeded
Feb  4 00:13:11 blackhole anacron: anacron startup succeeded
Feb  4 00:13:12 blackhole atd: atd startup succeeded
Feb  4 00:13:13 blackhole linuxconf: Running Linuxconf hooks:  succeeded
Feb  4 00:13:13 blackhole rc: Starting wine:  succeeded
Feb  4 00:14:29 blackhole sshd(pam_unix)[1253]: session opened for user =
root by (uid=3D0)
Feb  4 00:14:46 blackhole kernel: (read) sda1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:14:46 blackhole kernel: (read) sdb1's sb offset: 8844160 =
[events: 00000087]
Feb  4 00:14:46 blackhole kernel: (read) sdc1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:14:46 blackhole kernel: (read) sdd1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:14:46 blackhole kernel: (read) sde1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:14:46 blackhole kernel: (read) sdf1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:14:46 blackhole kernel: (read) sdg1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:14:46 blackhole kernel: (read) sdh1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:14:46 blackhole kernel: (read) sdj1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:14:46 blackhole kernel: (read) sdk1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:14:46 blackhole kernel: (read) sdl1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:14:46 blackhole kernel: md: autorun ...
Feb  4 00:14:46 blackhole kernel: md: considering sdl1 ...
Feb  4 00:14:46 blackhole kernel: md:  adding sdl1 ...
Feb  4 00:14:46 blackhole kernel: md:  adding sdk1 ...
Feb  4 00:14:46 blackhole kernel: md:  adding sdj1 ...
Feb  4 00:14:46 blackhole kernel: md:  adding sdh1 ...
Feb  4 00:14:46 blackhole kernel: md:  adding sdg1 ...
Feb  4 00:14:46 blackhole kernel: md:  adding sdf1 ...
Feb  4 00:14:46 blackhole kernel: md:  adding sde1 ...
Feb  4 00:14:46 blackhole kernel: md:  adding sdd1 ...
Feb  4 00:14:46 blackhole kernel: md:  adding sdc1 ...
Feb  4 00:14:46 blackhole kernel: md:  adding sdb1 ...
Feb  4 00:14:46 blackhole kernel: md:  adding sda1 ...
Feb  4 00:14:46 blackhole kernel: md: created md0
Feb  4 00:14:46 blackhole kernel: md: bind<sda1,1>
Feb  4 00:14:46 blackhole kernel: md: bind<sdb1,2>
Feb  4 00:14:46 blackhole kernel: md: bind<sdc1,3>
Feb  4 00:14:46 blackhole kernel: md: bind<sdd1,4>
Feb  4 00:14:46 blackhole kernel: md: bind<sde1,5>
Feb  4 00:14:46 blackhole kernel: md: bind<sdf1,6>
Feb  4 00:14:46 blackhole kernel: md: bind<sdg1,7>
Feb  4 00:14:46 blackhole kernel: md: bind<sdh1,8>
Feb  4 00:14:46 blackhole kernel: md: bind<sdj1,9>
Feb  4 00:14:46 blackhole kernel: md: bind<sdk1,10>
Feb  4 00:14:46 blackhole kernel: md: bind<sdl1,11>
Feb  4 00:14:46 blackhole kernel: md: running: =
<sdl1><sdk1><sdj1><sdh1><sdg1><sdf1><sde1><sdd1><sdc1><sdb1><sda1>
Feb  4 00:14:46 blackhole kernel: md: sdl1's event counter: 00000089
Feb  4 00:14:46 blackhole kernel: md: sdk1's event counter: 00000089
Feb  4 00:14:46 blackhole kernel: md: sdj1's event counter: 00000089
Feb  4 00:14:46 blackhole kernel: md: sdh1's event counter: 00000089
Feb  4 00:14:46 blackhole kernel: md: sdg1's event counter: 00000089
Feb  4 00:14:46 blackhole kernel: md: sdf1's event counter: 00000089
Feb  4 00:14:46 blackhole kernel: md: sde1's event counter: 00000089
Feb  4 00:14:46 blackhole kernel: md: sdd1's event counter: 00000089
Feb  4 00:14:46 blackhole kernel: md: sdc1's event counter: 00000089
Feb  4 00:14:46 blackhole kernel: md: sdb1's event counter: 00000087
Feb  4 00:14:46 blackhole kernel: md: sda1's event counter: 00000089
Feb  4 00:14:46 blackhole kernel: md: superblock update time =
inconsistency -- using the most recent one
Feb  4 00:14:46 blackhole kernel: md: freshest: sdl1
Feb  4 00:14:46 blackhole kernel: md: kicking non-fresh sdb1 from array!
Feb  4 00:14:46 blackhole kernel: md: unbind<sdb1,10>
Feb  4 00:14:46 blackhole kernel: md: export_rdev(sdb1)
Feb  4 00:14:46 blackhole kernel: md0: removing former faulty sdb1!
Feb  4 00:14:46 blackhole kernel: md0: max total readahead window set to =
2816k
Feb  4 00:14:46 blackhole kernel: md0: 11 data-disks, max readahead per =
data-disk: 256k
Feb  4 00:14:46 blackhole kernel: raid5: device sdl1 operational as raid =
disk 11
Feb  4 00:14:46 blackhole kernel: raid5: device sdk1 operational as raid =
disk 10
Feb  4 00:14:46 blackhole kernel: raid5: device sdj1 operational as raid =
disk 9
Feb  4 00:14:46 blackhole kernel: raid5: device sdh1 operational as raid =
disk 7
Feb  4 00:14:46 blackhole kernel: raid5: device sdg1 operational as raid =
disk 6
Feb  4 00:14:46 blackhole kernel: raid5: device sdf1 operational as raid =
disk 5
Feb  4 00:14:46 blackhole kernel: raid5: device sde1 operational as raid =
disk 4
Feb  4 00:14:46 blackhole kernel: raid5: device sdd1 operational as raid =
disk 3
Feb  4 00:14:46 blackhole kernel: raid5: device sdc1 operational as raid =
disk 2
Feb  4 00:14:46 blackhole kernel: raid5: device sda1 operational as raid =
disk 0
Feb  4 00:14:46 blackhole kernel: raid5: not enough operational devices =
for md0 (2/12 failed)
Feb  4 00:14:46 blackhole kernel: RAID5 conf printout:
Feb  4 00:14:46 blackhole kernel:  --- rd:12 wd:10 fd:2
Feb  4 00:14:46 blackhole kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 =
dev:sda1
Feb  4 00:14:46 blackhole kernel:  disk 1, s:0, o:0, n:1 rd:1 us:1 =
dev:[dev 00:00]
Feb  4 00:14:46 blackhole kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 =
dev:sdc1
Feb  4 00:14:46 blackhole kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 =
dev:sdd1
Feb  4 00:14:46 blackhole kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 =
dev:sde1
Feb  4 00:14:46 blackhole kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 =
dev:sdf1
Feb  4 00:14:46 blackhole kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 =
dev:sdg1
Feb  4 00:14:46 blackhole kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 =
dev:sdh1
Feb  4 00:14:46 blackhole kernel:  disk 8, s:0, o:0, n:8 rd:8 us:1 =
dev:[dev 00:00]
Feb  4 00:14:46 blackhole kernel:  disk 9, s:0, o:1, n:9 rd:9 us:1 =
dev:sdj1
Feb  4 00:14:46 blackhole kernel:  disk 10, s:0, o:1, n:10 rd:10 us:1 =
dev:sdk1
Feb  4 00:14:46 blackhole kernel:  disk 11, s:0, o:1, n:11 rd:11 us:1 =
dev:sdl1
Feb  4 00:14:46 blackhole kernel: raid5: failed to run raid set md0
Feb  4 00:14:46 blackhole kernel: md: pers->run() failed ...
Feb  4 00:14:46 blackhole kernel: md :do_md_run() returned -22
Feb  4 00:14:46 blackhole kernel: md: md0 stopped.
Feb  4 00:14:46 blackhole kernel: md: unbind<sdl1,9>
Feb  4 00:14:46 blackhole kernel: md: export_rdev(sdl1)
Feb  4 00:14:46 blackhole kernel: md: unbind<sdk1,8>
Feb  4 00:14:46 blackhole kernel: md: export_rdev(sdk1)
Feb  4 00:14:46 blackhole kernel: md: unbind<sdj1,7>
Feb  4 00:14:46 blackhole kernel: md: export_rdev(sdj1)
Feb  4 00:14:46 blackhole kernel: md: unbind<sdh1,6>
Feb  4 00:14:46 blackhole kernel: md: export_rdev(sdh1)
Feb  4 00:14:46 blackhole kernel: md: unbind<sdg1,5>
Feb  4 00:14:46 blackhole kernel: md: export_rdev(sdg1)
Feb  4 00:14:46 blackhole kernel: md: unbind<sdf1,4>
Feb  4 00:14:46 blackhole kernel: md: export_rdev(sdf1)
Feb  4 00:14:46 blackhole kernel: md: unbind<sde1,3>
Feb  4 00:14:46 blackhole kernel: md: export_rdev(sde1)
Feb  4 00:14:46 blackhole kernel: md: unbind<sdd1,2>
Feb  4 00:14:46 blackhole kernel: md: export_rdev(sdd1)
Feb  4 00:14:46 blackhole kernel: md: unbind<sdc1,1>
Feb  4 00:14:46 blackhole kernel: md: export_rdev(sdc1)
Feb  4 00:14:46 blackhole kernel: md: unbind<sda1,0>
Feb  4 00:14:46 blackhole kernel: md: export_rdev(sda1)
Feb  4 00:14:46 blackhole kernel: md: ... autorun DONE.
Feb  4 00:15:42 blackhole kernel: EXT2-fs: unable to read superblock
Feb  4 00:16:28 blackhole kernel: (read) sda1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:16:28 blackhole kernel: (read) sdb1's sb offset: 8844160 =
[events: 00000087]
Feb  4 00:16:28 blackhole kernel: (read) sdc1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:16:28 blackhole kernel: (read) sdd1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:16:28 blackhole kernel: (read) sde1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:16:28 blackhole kernel: (read) sdf1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:16:28 blackhole kernel: (read) sdg1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:16:28 blackhole kernel: (read) sdh1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:16:28 blackhole kernel: (read) sdj1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:16:28 blackhole kernel: (read) sdk1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:16:28 blackhole kernel: (read) sdl1's sb offset: 8844160 =
[events: 00000089]
Feb  4 00:16:28 blackhole kernel: md: autorun ...
Feb  4 00:16:28 blackhole kernel: md: considering sdl1 ...
Feb  4 00:16:28 blackhole kernel: md:  adding sdl1 ...
Feb  4 00:16:28 blackhole kernel: md:  adding sdk1 ...
Feb  4 00:16:28 blackhole kernel: md:  adding sdj1 ...
Feb  4 00:16:28 blackhole kernel: md:  adding sdh1 ...
Feb  4 00:16:28 blackhole kernel: md:  adding sdg1 ...
Feb  4 00:16:28 blackhole kernel: md:  adding sdf1 ...
Feb  4 00:16:28 blackhole kernel: md:  adding sde1 ...
Feb  4 00:16:28 blackhole kernel: md:  adding sdd1 ...
Feb  4 00:16:28 blackhole kernel: md:  adding sdc1 ...
Feb  4 00:16:28 blackhole kernel: md:  adding sdb1 ...
Feb  4 00:16:28 blackhole kernel: md:  adding sda1 ...
Feb  4 00:16:28 blackhole kernel: md: created md0
Feb  4 00:16:28 blackhole kernel: md: bind<sda1,1>
Feb  4 00:16:28 blackhole kernel: md: bind<sdb1,2>
Feb  4 00:16:28 blackhole kernel: md: bind<sdc1,3>
Feb  4 00:16:28 blackhole kernel: md: bind<sdd1,4>
Feb  4 00:16:28 blackhole kernel: md: bind<sde1,5>
Feb  4 00:16:28 blackhole kernel: md: bind<sdf1,6>
Feb  4 00:16:28 blackhole kernel: md: bind<sdg1,7>
Feb  4 00:16:28 blackhole kernel: md: bind<sdh1,8>
Feb  4 00:16:28 blackhole kernel: md: bind<sdj1,9>
Feb  4 00:16:28 blackhole kernel: md: bind<sdk1,10>
Feb  4 00:16:28 blackhole kernel: md: bind<sdl1,11>
Feb  4 00:16:28 blackhole kernel: md: running: =
<sdl1><sdk1><sdj1><sdh1><sdg1><sdf1><sde1><sdd1><sdc1><sdb1><sda1>
Feb  4 00:16:28 blackhole kernel: md: sdl1's event counter: 00000089
Feb  4 00:16:28 blackhole kernel: md: sdk1's event counter: 00000089
Feb  4 00:16:28 blackhole kernel: md: sdj1's event counter: 00000089
Feb  4 00:16:28 blackhole kernel: md: sdh1's event counter: 00000089
Feb  4 00:16:28 blackhole kernel: md: sdg1's event counter: 00000089
Feb  4 00:16:28 blackhole kernel: md: sdf1's event counter: 00000089
Feb  4 00:16:28 blackhole kernel: md: sde1's event counter: 00000089
Feb  4 00:16:28 blackhole kernel: md: sdd1's event counter: 00000089
Feb  4 00:16:28 blackhole kernel: md: sdc1's event counter: 00000089
Feb  4 00:16:28 blackhole kernel: md: sdb1's event counter: 00000087
Feb  4 00:16:28 blackhole kernel: md: sda1's event counter: 00000089
Feb  4 00:16:28 blackhole kernel: md: superblock update time =
inconsistency -- using the most recent one
Feb  4 00:16:28 blackhole kernel: md: freshest: sdl1
Feb  4 00:16:28 blackhole kernel: md: kicking non-fresh sdb1 from array!
Feb  4 00:16:28 blackhole kernel: md: unbind<sdb1,10>
Feb  4 00:16:28 blackhole kernel: md: export_rdev(sdb1)
Feb  4 00:16:28 blackhole kernel: md0: removing former faulty sdb1!
Feb  4 00:16:28 blackhole kernel: md0: max total readahead window set to =
2816k
Feb  4 00:16:28 blackhole kernel: md0: 11 data-disks, max readahead per =
data-disk: 256k
Feb  4 00:16:28 blackhole kernel: raid5: device sdl1 operational as raid =
disk 11
Feb  4 00:16:28 blackhole kernel: raid5: device sdk1 operational as raid =
disk 10
Feb  4 00:16:28 blackhole kernel: raid5: device sdj1 operational as raid =
disk 9
Feb  4 00:16:28 blackhole kernel: raid5: device sdh1 operational as raid =
disk 7
Feb  4 00:16:28 blackhole kernel: raid5: device sdg1 operational as raid =
disk 6
Feb  4 00:16:28 blackhole kernel: raid5: device sdf1 operational as raid =
disk 5
Feb  4 00:16:28 blackhole kernel: raid5: device sde1 operational as raid =
disk 4
Feb  4 00:16:28 blackhole kernel: raid5: device sdd1 operational as raid =
disk 3
Feb  4 00:16:28 blackhole kernel: raid5: device sdc1 operational as raid =
disk 2
Feb  4 00:16:28 blackhole kernel: raid5: device sda1 operational as raid =
disk 0
Feb  4 00:16:28 blackhole kernel: raid5: not enough operational devices =
for md0 (2/12 failed)
Feb  4 00:16:28 blackhole kernel: RAID5 conf printout:
Feb  4 00:16:28 blackhole kernel:  --- rd:12 wd:10 fd:2
Feb  4 00:16:28 blackhole kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 =
dev:sda1
Feb  4 00:16:28 blackhole kernel:  disk 1, s:0, o:0, n:1 rd:1 us:1 =
dev:[dev 00:00]
Feb  4 00:16:28 blackhole kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 =
dev:sdc1
Feb  4 00:16:28 blackhole kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 =
dev:sdd1
Feb  4 00:16:28 blackhole kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 =
dev:sde1
Feb  4 00:16:28 blackhole kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 =
dev:sdf1
Feb  4 00:16:28 blackhole kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 =
dev:sdg1
Feb  4 00:16:28 blackhole kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 =
dev:sdh1
Feb  4 00:16:28 blackhole kernel:  disk 8, s:0, o:0, n:8 rd:8 us:1 =
dev:[dev 00:00]
Feb  4 00:16:28 blackhole kernel:  disk 9, s:0, o:1, n:9 rd:9 us:1 =
dev:sdj1
Feb  4 00:16:28 blackhole kernel:  disk 10, s:0, o:1, n:10 rd:10 us:1 =
dev:sdk1
Feb  4 00:16:28 blackhole kernel:  disk 11, s:0, o:1, n:11 rd:11 us:1 =
dev:sdl1
Feb  4 00:16:28 blackhole kernel: raid5: failed to run raid set md0
Feb  4 00:16:28 blackhole kernel: md: pers->run() failed ...
Feb  4 00:16:28 blackhole kernel: md :do_md_run() returned -22
Feb  4 00:16:28 blackhole kernel: md: md0 stopped.
Feb  4 00:16:28 blackhole kernel: md: unbind<sdl1,9>
Feb  4 00:16:28 blackhole kernel: md: export_rdev(sdl1)
Feb  4 00:16:28 blackhole kernel: md: unbind<sdk1,8>
Feb  4 00:16:28 blackhole kernel: md: export_rdev(sdk1)
Feb  4 00:16:28 blackhole kernel: md: unbind<sdj1,7>
Feb  4 00:16:28 blackhole kernel: md: export_rdev(sdj1)
Feb  4 00:16:28 blackhole kernel: md: unbind<sdh1,6>
Feb  4 00:16:28 blackhole kernel: md: export_rdev(sdh1)
Feb  4 00:16:28 blackhole kernel: md: unbind<sdg1,5>
Feb  4 00:16:28 blackhole kernel: md: export_rdev(sdg1)
Feb  4 00:16:28 blackhole kernel: md: unbind<sdf1,4>
Feb  4 00:16:28 blackhole kernel: md: export_rdev(sdf1)
Feb  4 00:16:28 blackhole kernel: md: unbind<sde1,3>
Feb  4 00:16:28 blackhole kernel: md: export_rdev(sde1)
Feb  4 00:16:28 blackhole kernel: md: unbind<sdd1,2>
Feb  4 00:16:28 blackhole kernel: md: export_rdev(sdd1)
Feb  4 00:16:28 blackhole kernel: md: unbind<sdc1,1>
Feb  4 00:16:28 blackhole kernel: md: export_rdev(sdc1)
Feb  4 00:16:28 blackhole kernel: md: unbind<sda1,0>
Feb  4 00:16:28 blackhole kernel: md: export_rdev(sda1)
Feb  4 00:16:28 blackhole kernel: md: ... autorun DONE.

------=_NextPart_000_002E_01C2D75F.124E6DF0--

