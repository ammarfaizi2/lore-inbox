Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293712AbSCSFFt>; Tue, 19 Mar 2002 00:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293713AbSCSFFm>; Tue, 19 Mar 2002 00:05:42 -0500
Received: from smtp.polymtl.ca ([132.207.4.11]:63952 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S293712AbSCSFFb>;
	Tue, 19 Mar 2002 00:05:31 -0500
Message-ID: <3C96C714.E6967570@polymtl.ca>
Date: Tue, 19 Mar 2002 00:05:24 -0500
From: Christian Robert <christian.robert@polymtl.ca>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Christian Robert <christian.robert@polymtl.ca>
Subject: Unable to run kernel 2.4.18  it panic at boot
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've run with success kernels 2.4.5 up to 2.4.17 (the one i'm using right now).

I've tryed several times to install kernel 2.4.18 without success.
It always abort during the boot process, dump registers and halt.

here is a normal 2.4.17 boot sequence from dmesg

-----------------------------------------------------------------------------------------

$ dmesg
Linux version 2.4.17 (root@X-home) (gcc version 2.95.3 20010315 (release)) #1 Sun Mar 17 22:49:16 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffc000 (usable)
 BIOS-e820: 000000000fffc000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65532
zone(0): 4096 pages.
zone(1): 61436 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux root=2102 hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 602.575 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1202.58 BogoMIPS
Memory: 254696k/262128k available (1924k kernel code, 7040k reserved, 522k data, 224k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf06d0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
NTFS driver v1.1.21 [Flags: R/W]
udf: registering filesystem
JFS development version: $Name:  $
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8800-0x8807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8808-0x880f, BIOS settings: hdc:DMA, hdd:DMA
PDC20267: IDE controller on PCI bus 02 dev 70
PCI: Found IRQ 3 for device 02:0e.0
PCI: Sharing IRQ 3 with 02:0a.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x9400-0x9407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x9408-0x940f, BIOS settings: hdg:pio, hdh:pio
hda: QUANTUM FIREBALLlct10 30, ATA DISK drive
hdc: QUANTUM FIREBALLlct10 30, ATA DISK drive
hdd: SONY CD-RW CRX160E, ATAPI CD/DVD-ROM drive
hde: Maxtor 5T060H6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xa800-0xa807,0xa402 on irq 3
hda: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=3649/255/63, UDMA(33)
hdc: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(33)
hde: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=119150/16/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 >
 hdc: hdc1
 hde: hde1 hde2 hde4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux video capture interface: v1.00
i2c-core.o: driver tv card mixer driver registered.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX160E    Rev: 1.0e
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Creative EMU10K1 PCI Audio Driver, version 0.16, 22:51:47 Mar 17 2002
PCI: Found IRQ 9 for device 02:0b.0
PCI: Sharing IRQ 9 with 00:1f.2
emu10k1: EMU10K1 rev 7 model 0x8027 found, IO at 0xb400-0xb41f, IRQ 9
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 22:52:13 Mar 17 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:1f.2
PCI: Sharing IRQ 9 with 02:0b.0
PCI: Setting latency timer of device 00:1f.2 to 64
usb-uhci.c: USB UHCI at I/O 0x8400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
usb.c: registered new driver usblp
printer.c: v0.8:USB Printer Device Class driver
md: linear personality registered as nr 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.3(19/02/2002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (2047 buckets, 16376 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
UDF-fs DEBUG lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-5
UDF-fs DEBUG super.c:1414:udf_read_super: Multi-session=0
UDF-fs DEBUG super.c:410:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG super.c:1150:udf_check_valid: Failed to read byte 32768. Assuming open disc. Skipping validity check
hub.c: USB new device connect on bus1/2, assigned device number 2
UDF-fs DEBUG misc.c:322:udf_read_tagged: location mismatch block 256, tag 0 != 256
UDF-fs DEBUG super.c:1204:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)
printer.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 1
reiserfs: checking transaction log (device 21:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 224k freed
reiserfs: checking transaction log (device 3a:00) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on lvm(58,7), internal journal
EXT3-fs: mounted filesystem with journal data mode.
PCI: Found IRQ 3 for device 02:0a.0
PCI: Sharing IRQ 3 with 02:0e.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:0a.0: 3Com PCI 3c905C Tornado at 0xb800. Vers LK1.1.16
bttv: driver version 0.7.83 loaded
bttv: using 8 buffers with 2080k (16640k total) for capture
bttv: Host bridge is Intel Corp. 82820 820 (Camino) Chipset Host Bridge (MCH)
bttv: Bt8xx card found (0).
PCI: Found IRQ 10 for device 02:09.0
PCI: Sharing IRQ 10 with 00:1f.3
PCI: Sharing IRQ 10 with 02:09.1
bttv0: Bt878 (rev 2) at 02:09.0, irq: 10, latency: 32, memory: 0xd7000000
bttv0: detected: ATI TV Wonder [card=63], PCI subsystem ID is 1002:0001
bttv0: using: BT878(ATI TV-Wonder) [card=63,insmod option]
i2c-dev.o: Registered 'bt848 #0' as minor 0
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0xc0
bttv0: i2c attach [client=Philips NTSC,ok]
i2c-core.o: client [Philips NTSC] registered to adapter [bt848 #0](pos. 0).
i2c-core.o: driver i2c msp3400 driver registered.
msp34xx: init: chip=MSP3430G-A4, has NICAM support
msp3410: daemon started
bttv0: i2c attach [client=MSP3430G-A4,ok]
i2c-core.o: client [MSP3430G-A4] registered to adapter [bt848 #0](pos. 1).
/dev/vmmon: Module vmmon: registered with major=10 minor=165 tag=$Name: build-1455 $
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 131 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 162 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
Adding Swap: 262544k swap-space (priority -1)


My root "/"       is on /dev/hde2  Maxstor 60 Gigs disk on Promise ATA/100 ide controller (2.01 build 27) 
my boot "/boot"   is on /dev/hda1


it's a dual boot win98 / Linux  with a recent lilo as boot loader.

When I boot with 2.4.18 Kernel, everything seems the same except:

[...]
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
usb.c: registered new driver usblp
printer.c: v0.8:USB Printer Device Class driver
md: linear personality registered as nr 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.3(19/02/2002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (2047 buckets, 16376 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0

and here it goes wrong, I type it from a piece of paper since it has not started to log to file and
even ctrl-Page-Up is not working (machine completely jammed). I removed some leading zeroes. 

invalid operand: 0000
CPU: 0
EIP:  0010: [<c012dcdc>] not tainted
EFLAGS:  00010286
EAX: fffffe00 EBX: 21 ECX: 200 EDX: 0
ESI: 0  EDI: 2102 EBP: 0 ESP: c140de38
DS: 18 ES: 18 SS: 18

Process swapper (pid: 1, stackpage=c140d000)
stack: 2102 0 0 cff79120 2240 c012c17b 21d2 0
[...] other registers
CODE: 0f 0b b9 ff ff ff ff 89 fa b6 b0 8b 44 24 20 41 d3 e0 3d ff

<0>Kernel panic: ATTEMPTED to kill INIT !


I tryed removing all the kernel patches I used ( LVM, JFS, and UDF-write )
and it still panic at the same place while booting.

My only guess is it has something to do with my promise ATA/100 controller (from Maxtor but made by Promise)

Here are some info on my system ( on a working 2.4.17 +LVM +JFS +UDF-write )


[xtian@X-home:/home/xtian] $ cat /proc/partitions 
major minor  #blocks  name

  58     0    2097152 lvma
  58     1    3145728 lvmb
  58     2    4194304 lvmc
  58     3   20971520 lvmd
  58     4    4194304 lvme
  58     5    2097152 lvmf
  58     7    4194304 lvmh
  58     8    4194304 lvmi
  58    10    2097152 lvmk
  58    12    2097152 lvmm
  33     0   60051600 hde
  33     1     262552 hde1
  33     2    5120136 hde2
  33     4   49972104 hde4
  22     0   29316672 hdc
  22     1   29316640 hdc1
   3     0   29316672 hda
   3     1      16033 hda1
   3     2    3148740 hda2
   3     3          1 hda3
   3     5    4096543 hda5
   3     6   22049181 hda6

[xtian@X-home:/home/xtian] $ mount
/dev/hde2 on / type reiserfs (rw)
/dev/hda1 on /boot type ext2 (rw)
/dev/vg02/work on /work type reiserfs (rw)
/dev/vg02/spare on /spare type reiserfs (rw)
/dev/vg02/bigfs on /bigfs type reiserfs (rw)
/dev/vg02/btemp on /btemp type reiserfs (rw)
/dev/vg02/ext3 on /ext3 type ext3 (rw,data=journal)
/dev/vg02/jfs on /jfs type jfs (rw)
/tmpfs on /tmpfs type tmpfs (rw,mode=01777,size=32m)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /proc type proc (rw)
none on /proc/bus/usb type usbdevfs (rw)

[xtian@X-home:/home/xtian] $ df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hde2              5119972   3647268   1472704  72% /
/dev/hda1                15552      3964     10947  27% /boot
/dev/vg02/work         2097084   1695996    401088  81% /work
/dev/vg02/spare        3145628    843520   2302108  27% /spare
/dev/vg02/bigfs        4194172   1926244   2267928  46% /bigfs
/dev/vg02/btemp       20970876  15652996   5317880  75% /btemp
/dev/vg02/ext3         4128448     32828   3885908   1% /ext3
/dev/vg02/jfs          4177588       672   4176916   1% /jfs
/tmpfs                   32768         0     32768   0% /tmpfs



[xtian@X-home:/home/xtian] $ cat /proc/pci 
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82820 820 (Camino) Chipset Host Bridge (MCH) (rev 3).
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82820 820 (Camino) Chipset PCI to AGP Bridge (rev 3).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 2).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801AA IDE (rev 2).
      I/O at 0x8800 [0x880f].
  Bus  0, device  31, function  2:
    USB Controller: Intel Corp. 82801AA USB (rev 2).
      IRQ 9.
      I/O at 0x8400 [0x841f].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82801AA SMBus (rev 2).
      IRQ 10.
      I/O at 0xe800 [0xe80f].
  Bus  1, device   0, function  0:
    VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5 (rev 1).
      IRQ 11.
      Non-prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
      Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].
      I/O at 0xd800 [0xd8ff].
  Bus  2, device   9, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xd7000000 [0xd7000fff].
  Bus  2, device   9, function  1:
    Multimedia controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xd6800000 [0xd6800fff].
  Bus  2, device  10, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 116).
      IRQ 3.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xb800 [0xb87f].
      Non-prefetchable 32 bit memory at 0xcf800000 [0xcf80007f].
  Bus  2, device  11, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 7).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xb400 [0xb41f].
  Bus  2, device  11, function  1:
    Input device controller: Creative Labs SB Live! (rev 7).
      Master Capable.  Latency=32.  
      I/O at 0xb000 [0xb007].
  Bus  2, device  14, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 2).
      IRQ 3.
      Master Capable.  Latency=32.  
      I/O at 0xa800 [0xa807].
      I/O at 0xa400 [0xa403].
      I/O at 0xa000 [0xa007].
      I/O at 0x9800 [0x9803].
      I/O at 0x9400 [0x943f].
      Non-prefetchable 32 bit memory at 0xcf000000 [0xcf01ffff].



[xtian@X-home:/home/xtian] $ cat /proc/interrupts 
           CPU0       
  0:     300501          XT-PIC  timer
  1:       6277          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       8432          XT-PIC  ide2, eth0
  8:          4          XT-PIC  rtc
  9:          9          XT-PIC  EMU10K1, usb-uhci
 10:          4          XT-PIC  bttv
 12:      66003          XT-PIC  PS/2 Mouse
 14:         31          XT-PIC  ide0
 15:         16          XT-PIC  ide1
NMI:          0 
ERR:          0



[xtian@X-home:/home/xtian] $ ls -la /proc/ide
total 0
dr-xr-xr-x    5 root     root            0 Mar 18 23:55 ./
dr-xr-xr-x   59 root     root            0 Mar 18 23:04 ../
-r--r--r--    1 root     root            0 Mar 18 23:55 drivers
lrwxrwxrwx    1 root     root            8 Mar 18 23:55 hda -> ide0/hda/
lrwxrwxrwx    1 root     root            8 Mar 18 23:55 hdc -> ide1/hdc/
lrwxrwxrwx    1 root     root            8 Mar 18 23:55 hdd -> ide1/hdd/
lrwxrwxrwx    1 root     root            8 Mar 18 23:55 hde -> ide2/hde/
dr-xr-xr-x    3 root     root            0 Mar 18 23:55 ide0/
dr-xr-xr-x    4 root     root            0 Mar 18 23:55 ide1/
dr-xr-xr-x    3 root     root            0 Mar 18 23:55 ide2/
-r--r--r--    1 root     root            0 Mar 18 23:55 pdc202xx


[root@X-home:/usr/src/linux] # ls -la /proc/scsi
total 0
dr-xr-xr-x    4 root     root            0 Mar 19 00:01 ./
dr-xr-xr-x   60 root     root            0 Mar 18 23:04 ../
dr-xr-xr-x    2 root     root            0 Mar 19 00:01 ide-scsi/
-r--r--r--    1 root     root            0 Mar 19 00:01 scsi
dr-xr-xr-x    2 root     root            0 Mar 19 00:01 sg/

[root@X-home:/usr/src/linux] # cat /etc/lilo.conf | grep -v "^#" | grep -v "^$"
boot = /dev/hda
message = /boot/boot_message.txt
prompt
timeout = 100
linear
vga = normal
default = Linux
image    = /boot/vmlinuz
  root   = /dev/hde2
  label  = Linux
  append = "hdd=ide-scsi"
other = /dev/hda2
  label = Win98

[root@X-home:/usr/src/linux] # sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux X-home 2.4.17 #1 Sun Mar 17 22:49:16 EST 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.1a
pcmcia-cs              3.1.26
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         vmnet vmmon msp3400 tuner bttv 3c59x




if you need more info, feel free to ask.

many thanks,
Xtian.
