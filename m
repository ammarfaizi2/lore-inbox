Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275294AbRIZQWI>; Wed, 26 Sep 2001 12:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275285AbRIZQWC>; Wed, 26 Sep 2001 12:22:02 -0400
Received: from smtp1.cistron.nl ([195.64.68.40]:14609 "EHLO smtp1.cistron.nl")
	by vger.kernel.org with ESMTP id <S275294AbRIZQVw>;
	Wed, 26 Sep 2001 12:21:52 -0400
Message-ID: <3BB200C2.7D7E84B4@cistron.nl>
Date: Wed, 26 Sep 2001 18:22:26 +0200
From: Alfred Munnikes <munnikes@cistron.nl>
Reply-To: munnikes@cistron.nl
Organization: Munnikes
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: spurious 8259A interrupt: IRQ7. AND VM: killing process ..
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

With a new compiled kernel 2.4.10 I have the next problem's

first is gives the message "spurious 8259A interrupt: IRQ7." and I 
don't think that is normal for a PCI clock generator.

seconds, I have problem while I do 'md5sum a_cd_image_from_650_MByte'
The VM is killing a lot of processes while I have 512 MByte RAM and a
170 MB swap partition and there is only a just started machine with a
few services (take only 20 to 40 MByte ram)
The VM starts killing while the swap is only full for around 9 to 15
MByte (I cannot take a 'free' snapshot from that, while de bash is
killed every time) while there is room for +/- 170 MByte

I have a Abit KT7-raid with KT133 chipset, may the problem a hardware
problem.

And I'm not on a list, so if you want some more information or want to
reply, please mail 'munnikes AT cistron.nl'

Alfred Munnikes.

---------------------

Here is soms output that can help or can declare firmly my story.


'free' (before starting 'md5sum a_big_file')
             total       used       free     shared    buffers    
cached
Mem:        513460      71956     441504          0      30840     
23140
-/+ buffers/cache:      17976     495484
Swap:       176636          0     176636


'ps aux' (before starting 'md5sum a_big_file')

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  5.0  0.0  1020  460 ?        S    18:05   0:04 init
root         2  0.0  0.0     0    0 ?        SW   18:05   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SW   18:05   0:00
[kapm-idled]
root         4  0.1  0.0     0    0 ?        SWN  18:05   0:00
[ksoftirqd_CPU0]
root         5  0.0  0.0     0    0 ?        SW   18:05   0:00 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   18:05   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        SW   18:05   0:00
[kupdated]
root        67  0.0  0.0     0    0 ?        SW   18:05   0:00
[kreiserfsd]
daemon      89  0.0  0.0  1132  420 ?        S    18:05   0:00
/sbin/portmap
root       431  0.0  0.1  1352  628 ?        S    18:05   0:00
/sbin/syslogd
root       433  0.2  0.2  1660 1096 ?        S    18:05   0:00
/sbin/klogd
root       439  0.0  0.1  1056  544 ?        S    18:05   0:00
/sbin/rpc.statd
root       447  0.0  0.1  1752  788 ?        S    18:05   0:00
/usr/X11R6/bin/fontfs -daemon
root       451  0.0  0.0  1048  440 ?        S    18:05   0:00
/usr/sbin/gpm -m /dev/psaux -t imps2 -l
"a-zA-Z0-9_.:~/\300-\326\330-\366\370-\377"
root       456  0.0  0.1  1300  544 ?        S    18:05   0:00
/usr/sbin/inetd
root       465  0.0  0.1  1300  560 ?        S    18:05   0:00
/usr/sbin/tcplogd -f
root       467  0.0  0.0   992  280 ?        S    18:05   0:00
/usr/sbin/icmplogd -f
root       473  0.0  0.1  1352  560 ?        S    18:05   0:00
/usr/sbin/lpd
root       481  0.0  0.1  1772  872 ?        S    18:05   0:00 /bin/sh
/usr/bin/safe_mysqld
mysql      512  0.0  0.8 33408 4264 ?        SN   18:05   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/home/mysql --user=mysql
--pid-file=/var/run/mysqld/mysqld.pid --skip-locking
mysql      515  0.0  0.8 33408 4264 ?        SN   18:05   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/home/mysql --user=mysql
--pid-file=/var/run/mysqld/mysqld.pid --skip-locking
mysql      516  0.0  0.8 33408 4264 ?        SN   18:05   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/home/mysql --user=mysql
--pid-file=/var/run/mysqld/mysqld.pid --skip-locking
mysql      518  0.0  0.8 33408 4264 ?        SN   18:05   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/home/mysql --user=mysql
--pid-file=/var/run/mysqld/mysqld.pid --skip-locking
root       520  0.0  0.2  2236 1224 ?        S    18:05   0:00
/usr/sbin/nmbd -D
root       522  0.0  0.1  2160  948 ?        S    18:05   0:00
/usr/sbin/nmbd -D
root       523  0.0  0.2  2788 1252 ?        S    18:05   0:00
/usr/sbin/smbd -D
proxy      540  0.0  0.1  1644  720 ?        S    18:05   0:00
/usr/sbin/wwwoffled -c /etc/wwwoffle/wwwoffle.conf
root       543  0.0  0.5  4000 3028 ?        S    18:05   0:00
/usr/bin/X11/xfs -daemon
root       547  0.0  0.1  1704  768 ?        S    18:05   0:00
/usr/sbin/rpc.nfsd
root       549  0.0  0.1  1720  816 ?        S    18:05   0:00
/usr/sbin/rpc.mountd
root       552  0.0  0.1  1308  536 ?        S    18:05   0:00
/usr/sbin/cfsd
root       554  0.0  0.0     0    0 ?        SW   18:05   0:00 [rpciod]
root       555  0.0  0.0     0    0 ?        SW   18:05   0:00 [lockd]
root       560  0.0  0.1  1168  616 ?        S    18:05   0:00
/usr/sbin/cron
root       565  0.2  0.6 39256 3500 ?        S    18:05   0:00
/usr/sbin/apache
alfred     574  0.0  0.2  2008 1224 tty1     S    18:05   0:00 -bash
root       575  0.0  0.0  1004  452 tty2     S    18:05   0:00
/sbin/getty 38400 tty2
root       576  0.0  0.0  1004  452 tty3     S    18:05   0:00
/sbin/getty 38400 tty3
root       577  0.0  0.0  1004  452 tty4     S    18:05   0:00
/sbin/getty 38400 tty4
root       578  0.0  0.0  1004  452 tty5     S    18:05   0:00
/sbin/getty 38400 tty5
root       579  0.0  0.0  1004  452 tty6     S    18:05   0:00
/sbin/getty 38400 tty6
www-data   580  0.0  0.6 39256 3504 ?        S    18:05   0:00
/usr/sbin/apache
alfred     600  0.0  0.2  3264 1480 tty1     R    18:06   0:00 ps aux


'cat /proc/pci'

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
2).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 34).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
      Master Capable.  Latency=32.  
      I/O at 0xd000 [0xd00f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 48).
      IRQ 11.
  Bus  0, device   9, function  0:
    Multimedia audio controller: Ensoniq CT5880 [AudioPCI] (rev 2).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xdc00 [0xdc3f].
  Bus  0, device  11, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
(rev 0).
      IRQ 10.
      I/O at 0xe000 [0xe01f].
  Bus  0, device  13, function  0:
    Multimedia video controller: Brooktree Corporation Bt848 TV with DMA
push (rev 18).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xda002000 [0xda002fff].
  Bus  0, device  15, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875J
(rev 4).
      IRQ 11.
      Master Capable.  Latency=144.  Min Gnt=17.Max Lat=64.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 32 bit memory at 0xda000000 [0xda0000ff].
      Non-prefetchable 32 bit memory at 0xda001000 [0xda001fff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev
3).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xd4000000 [0xd5ffffff].
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd6003fff].
      Non-prefetchable 32 bit memory at 0xd7000000 [0xd77fffff].


'dmesg' output:

Linux version 2.4.10 (root@easydisk) (gcc version 2.95.2 20000220
(Debian GNU/Linux)) #1 Mon Sep 24 17:11:15 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: BOOT_IMAGE=linuxold ro root=305
BOOT_FILE=/vmlinuz.old
Initializing CPU#0
Detected 900.072 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1795.68 BogoMIPS
Memory: 513240k/524224k available (1441k kernel code, 10596k reserved,
470k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
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
..... CPU clock speed is 900.0498 MHz.
..... host bus clock speed is 200.0110 MHz.
cpu: 0, clocks: 2000110, slice: 1000055
CPU0<T0:2000096,T1:1000032,D:9,S:1000055,C:2000110>
PCI: PCI BIOS revision 2.10 entry at 0xfb4b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by
other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, HEWLETT-PACKARD OFFICEJET PRO 1150C
parport_pc: Via 686A parallel port: io=0x378
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-307045, ATA DISK drive
hdc: QUANTUM FIREBALL CR6.4A, ATA DISK drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63,
UDMA(66)
hdc: 12594960 sectors (6449 MB) w/418KiB Cache, CHS=13328/15/63,
UDMA(33)
ide-floppy driver 0.97.sv
hdd: No disk in drive
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
 hdc: [PTBL] [784/255/63] hdc1 hdc2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 10 for device 00:0b.0
eth0: RealTek RTL-8029 found at 0xe000, IRQ 10, 00:00:B4:B6:73:BC.
PPP generic driver version 2.4.1
Linux video capture interface: v1.00
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xd0000000 64MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0f.0
PCI: Sharing IRQ 11 with 00:0d.0
sym53c8xx: at PCI bus 0, device 15, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875J detected with Symbios NVRAM
sym53c875J-0: rev 0x4 on pci bus 0 device 15 function 0 irq 11
sym53c875J-0: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
sym53c875J-0: on-chip RAM at 0xda001000
sym53c875J-0: restart (scsi reset).
sym53c875J-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx-1.7.3c-20010512
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.11
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
sym53c875J-0-<3,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 15)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
sym53c875J-0-<4,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 16)
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
es1371: version v0.30 time 17:13:08 Sep 24 2001
PCI: Found IRQ 9 for device 00:09.0
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xdc00 irq 9
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 128484k swap-space (priority -1)
Adding Swap: 48152k swap-space (priority -2)
reiserfs: checking transaction log (device 03:09) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
spurious 8259A interrupt: IRQ7.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, cable problem? TSR=0x16, ISR=0x0, t=26.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, cable problem? TSR=0x16, ISR=0x0, t=23.
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
i2c-core.o: driver i2c msp3400 driver registered.
i2c-core.o: driver i2c TV tuner driver registered.
bttv: driver version 0.7.72 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Bt8xx card found (0).
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 00:0f.0
bttv0: Bt848 (rev 18) at 00:0d.0, irq: 11, latency: 32, memory:
0xda002000
bttv0: model: BT848A(MIRO PCTV pro) [insmod option]
msp34xx: init: chip=MSP3410D-B4, has NICAM support
msp3410: daemon started
bttv0: i2c attach [MSP3410D-B4]
i2c-core.o: client [MSP3410D-B4] registered to adapter [bt848 #0](pos.
0).
tuner: chip found @ 0xc0
bttv0: i2c attach [(unset)]
i2c-core.o: client [(unset)] registered to adapter [bt848 #0](pos. 1).
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: miro: id=12 tuner=5 radio=matchbox stereo=yes
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54
(PV951)
i2c-core.o: driver generic i2c audio driver registered.
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
VM: killing process bash
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0xf0/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
VM: killing process top
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
VM: killing process syslogd
__alloc_pages: 0-order allocation failed (gfp=0xf0/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
VM: killing process apache
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
VM: killing process bash
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
VM: killing process nmbd
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
VM: killing process login
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
VM: killing process rpc.nfsd
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
VM: killing process bash
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0129da6
VM: killing process rpc.mountd




(here is the old 2.4.9 kernel installed)
[/home/alfred]$ sh /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux easydisk 2.4.9 #1 Wed Sep 19 11:15:25 CEST 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux             2.10s
mount                  2.10s
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ipt_REJECT iptable_filter ip_tables ppp_deflate
bsd_comp ppp_async tvaudio bttv tuner msp3400 i2c-algo-bit i2c-core
nls_iso8859-1 nls_cp437 vfat
