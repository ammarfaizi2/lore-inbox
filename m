Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277347AbRJJTg6>; Wed, 10 Oct 2001 15:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277374AbRJJTgj>; Wed, 10 Oct 2001 15:36:39 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:54521 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S277347AbRJJTge> convert rfc822-to-8bit;
	Wed, 10 Oct 2001 15:36:34 -0400
Subject: Re: PROBLEM: aic7xxx SCSI system hangs
From: Alexander Feigl <Alexander.Feigl@gmx.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200110101622.f9AGMrY82571@aslan.scsiguy.com>
In-Reply-To: <200110101622.f9AGMrY82571@aslan.scsiguy.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.14 (Preview Release)
Date: 10 Oct 2001 21:36:06 +0200
Message-Id: <1002742566.9219.5.camel@PowerBox.MysticWorld.de>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mit, 2001-10-10 um 18.22 schrieb 1002730973:
> >Summary : aic7xxx SCSI system hangs 
> 
> You need to send a complete console log from boot through the hang
> (serial console preferred).  It would also be userfull for you to
> add KDB to your system and get as much information about the hung
> exception handling thread (e.g. what routines it is looping through).
> 

I don't have any real kdb experiences and not much time at the
moment.But I try to post the required information. I attached a second
computer via null modem cable to serial and logged the output. Tell me
if some essential output is missing.

Where can I find information how to trace the problem with kdb or
anything else?

----------------------------- console log ---------------------------

Linux version 2.4.11-xfs (dreamer@PowerBox.MysticWorld.de) (gcc version egcs-2.9
1.66 19990314/Linux (egcs-1.1.2 release / Mandrake Linux 8.1)) #1 Mit Okt 10 20:
02:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2411 ro root=306 ramdisk_size=8192 devfs=mount v
ideo=riva:off console=ttyS1
Initializing CPU#0
Detected 908.964 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1808.79 BogoMIPS
Memory: 511756k/524224k available (1025k kernel code, 12080k reserved, 812k data
, 228k init, 0k highmem)
kdb version 1.9 by Scott Lurndal, Keith Owens. Copyright SGI, All Rights Reserve
d
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v0.117 (20010927) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI IS
APNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 7
AMD7409: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLlct15 30, ATA DISK drive
hdc: ST340823A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=3649/255/63, UDMA(33)
hdc: 78165360 sectors (40021 MB) w/1024KiB Cache, CHS=77545/16/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [4865/255/63] p1 p2 < p5 p6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1554k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Red Hat nash verSCSI subsystem driver Revision: 1.00
sion 3.1.6-mdk starting
Loadingscsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
 pagebuf module        <Adaptec 2940 Ultra2 SCSI adapter>

Loading xfs_sup        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
port module
Loa
ding scsi_mod module
Loading sd_mod module
Loading aic7xxx module
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 16)
Loading xfs module
SGI XFS with ACLs, EAs, DMAPI, realtime, quota, no debug enabled
Mounting /proc filesystem
Creating rootXFS mounting filesystem ide0(3,6)
 device
Mounting root filesystem
Remounting devfs at correct place if necessary
Freeing unused kernel memory: 228k freed
INIT: version 2.78 booting
Couldnt get a file descriptor referring to the console
get_console_fd: Das Argument ist ungültig
Standardzeichensatz setzen:  [  OK  ]
			Willkommen zu Mandrake Linux
	Drücken Sie »I«, um im interaktiven Modus zu starten.
Einhängen des Dateisystems »/proc«:  [  OK  ]
Starten des DevFS Dämons:  [  OK  ]
Unmounting initrd:  [  OK  ]
Kern-Parameter konfigurieren:  [  OK  ]
Setting clock  (utc): Mit Okt 10 20:31:56 CEST 2001 [  OK  ]
Swap-Partitionen einbinden:  [  OK  ]
Setting hostname PowerBox.MysticWorld.homenet:  [  OK  ]
Checking root filesystem
[  OK  ]
Verzeichnisbaumwurzel im Schreib-/Lese-Modus einhängen:  [  OK  ]
Finden der Modulabhängigkeiten:  [  OK  ]
Checking filesystems
[  OK  ]
Einhängen lokaler Dateisysteme:  [  OK  ]
Kontrollieren des LoopBack-Dateisystemes[  OK  ]
Einhängen der Loopback-Dateisysteme:  [  OK  ]
Running devfsd actions:  [  OK  ]
Loading compose keys: compose.latin.inc [  OK  ]
The BackSpace key sends: ^?[  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Lokale Benutzer- und Gruppen-Quotas aktivieren:  [  OK  ]
Swap-Bereich aktivieren:  [  OK  ]
Building Window Manager Sessions [  OK  ]
INIT: Entering runlevel: 1
Entering non-interactive startup
Allen Prozessen das Signal »TERM« senden ...
INIT: no more processes left in this runlevel
Sende allen Prozessen das Signal »KILL« ...
INIT anweisen, in den Einbenutzer-Betrieb zu wechseln.
INIT: Going single user
sh-2.05# cdrecord -toc dev=0,2,0
Cdrecord 1.10 (i586-mandrake-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
scsidev: '0,2,0'
scsibus: 0 target: 2 lun: 0
Linux sg driver version: 3.1.20
Using libscg version 'schily-0.5'
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : SYNC LINKED 
Vendor_info    : 'PLEXTOR '
Identifikation : 'CD-ROM PX-32TS  '
Revision       : '1.02'
Device seems to be: Generic CD-ROM.
Using generic SCSI-2 CD driver (scsi2_cd).
Driver flags   : 
first: 1 last 18
Entering kdb (current=0xc183e000, pid 3) due to Keyboard Entry
kdb> b btp 16
    EBP       EIP         Function(args)
0xdf945f6c 0xc0112d34 schedule+0x2d4 (0xc18627c0, 0xdf944000)
                               kernel .text 0xc0100000 0xc0112a60 0xc0112e80
0xdf945f9c 0xc0105df0 __down_interruptible+0x80 (0xdf945fd8, 0xe082051f, 0xdf945
fec, 0xe08189d7, 0x100)
                               kernel .text 0xc0100000 0xc0105d70 0xc0105e50
0xdf945fac 0xc0105eae __down_failed_interruptible+0xa
                               kernel .text 0xc0100000 0xc0105ea4 0xc0105eb4
           0xc0105763 kernel_thread+0x23
                               kernel .text 0xc0100000 0xc0105740 0xc0105780
kdb> 

