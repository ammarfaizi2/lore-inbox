Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTJ3QVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 11:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbTJ3QVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 11:21:48 -0500
Received: from news.cistron.nl ([62.216.30.38]:30646 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262610AbTJ3QVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 11:21:39 -0500
From: age <ahuisman@cistron.nl>
Subject: READAHEAD
Date: Thu, 30 Oct 2003 20:23:06 +0100
Organization: Cistron
Message-ID: <bnrdqi$uho$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: ncc1701.cistron.net 1067530898 31288 62.216.17.166 (30 Oct 2003 16:21:38 GMT)
X-Complaints-To: abuse@cistron.nl
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andre

Hi,

I have a problem which i don`t understand and i hope that you
will and can  help me. The problem is that i experience strange disk
read performance. I have to set hdparm -m16 -u1 -c1 -d1 -a4096 /dev/hde
to get  timing buffered disk reads of 56 MB/SEC.
When i disable readahead i get 17 MB/SEC
When i enable readahead with -a8 i get  17 MB/SEC
When i enable readahead with -a16 i get 24,5 MB/SEC
When i enable readahead with -a32 i get 30,5 MB/SEC
When i enable readahead with -a64 i get 35 MB/SEC
When i enable readahead with -a128 i get 39 MB/SEC
When i enable readahead with -a256 i get 39 MB/SEC
When i enable readahead with -a512 i get 41 MB/SEC
When i enable readahead with -a1024 i get 50 MB/SEC
When i enable readahead with -a2048 i get 50 MB/SEC
When i enable readahead with -a4096 i get 56 MB/SEC
With -a8192,-a16384 and -a32768 i get also 56MB/SEC

Before, i never had to set readahead so high
Please could you tell me, what is going on here ?

I use 2.6.0-test9 with TCQ enabled.
The harddisk is the new Hitachi 7K250 40 GB PATA.

PS: It doesn`t matter  when i disable tcq and/or multcount, i get
      the same results.

THX

Age huisman

/dev/hde:

Model=HDS722540VLAT20, FwRev=V31OA60A, SerialNo=VN321EC2R9X1ML
Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
BuffType=DualPortCache, BuffSize=1794kB, MaxMultSect=16, MultSect=16
CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80418240
IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes:  pio0 pio1 pio2 pio3 pio4
DMA modes:  mdma0 mdma1 mdma2
UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
AdvancedPM=yes: disabled (255) WriteCache=enabled
Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:

* signifies the current active mode


ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.
        Model Number:       HDS722540VLAT20
        Serial Number:      VN321EC2R9X1ML
        Firmware Revision:  V31OA60A
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 3a
        Supported: 6 5 4 3
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:   80418240
        LBA48  user addressable sectors:   80418240
        device size with M = 1024*1024:       39266 MBytes
        device size with M = 1000*1000:       41174 MBytes (41 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 52     Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
                Release interrupt
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command
           *    Device Configuration Overlay feature set
           *    48-bit Address feature set
                Automatic Acoustic Management feature set
                SET MAX security extension
                Address Offset Reserved Area Boot
                SET FEATURES subcommand required to spinup after power up
                Power-Up In Standby feature set
                Advanced Power Management feature set
           *    READ/WRITE DMA QUEUED
           *    General Purpose Logging feature set
           *    SMART self-test
           *    SMART error logging
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        22min for SECURITY ERASE UNIT.
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct




00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev
02) (prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra133TX2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 4500ns max), Cache Line Size: 0x08 (32 
bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at eff0 [size=8]
        Region 1: I/O ports at efe4 [size=4]
        Region 2: I/O ports at efa8 [size=8]
        Region 3: I/O ports at efe0 [size=4]
        Region 4: I/O ports at ef90 [size=16]
        Region 5: Memory at febfc000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at febf8000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



wuuk:/proc/ide/hde# cat settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
acoustic                0               0               254             rw
address                 1               0               2               rw
bios_cyl                16383           0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
bswap                   0               0               1               r
current_speed           69              0               70              rw
failures                0               0               65535           rw
init_speed              69              0               70              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw
using_tcq               1               0               32              rw
wcache                  0               0               1               rw



wuuk:~# dmesg
Linux version 2.6.0-test9 (root@wuuk) (gcc version 3.3.2 (Debian)) #1 
Wed Oct
29 02:23:54 CET 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000001ffe0000 (usable)
BIOS-e820: 000000001ffe0000 - 000000001fff8000 (ACPI data)
BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131040
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126944 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
Building zonelist for node : 0
Kernel command line: root=/dev/hde2 ro vga=3845
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 448.128 MHz processor.
Console: colour VGA+ 80x30
Memory: 515404k/524160k available (1814k kernel code, 8004k reserved, 675k
data, 124k init, 0k highmem)
Calibrating delay loop... 884.73 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 447.0981 MHz.
..... host bus clock speed is 99.0551 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 0000:00:07.0
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
Limiting direct PCI/PCI transfers.
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf8000000
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 5 for device 0000:00:0f.0
eth0: RealTek RTL8139 at 0xe0823c00, 00:02:44:47:f8:69, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hdc: JLMS XJ-HD166S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20269: IDE controller at PCI slot 0000:00:0e.0
PCI: Found IRQ 10 for device 0000:00:0e.0
PDC20269: chipset revision 2
PDC20269: ROM enabled at 0xfebf8000
PDC20269: 100% native mode on irq 10
    ide2: BM-DMA at 0xef90-0xef97, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xef98-0xef9f, BIOS settings: hdg:pio, hdh:pio
hde: HDS722540VLAT20, ATA DISK drive
ide2 at 0xeff0-0xeff7,0xefe6 on irq 10
hde: max request size: 1024KiB
hde: 80418240 sectors (41174 MB) w/1794KiB Cache, CHS=16383/255/63, 
UDMA(100)
hde: tagged command queueing enabled, command queue depth 32
hde: hde1 hde2 hde3
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver
v2.1
PCI: Found IRQ 9 for device 0000:00:07.2
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 9, io base 0000ef40
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
hub 1-0:1.0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:07.2-1
Adding 124952k swap on /dev/hde1.  Priority:-1 extents:1
EXT3 FS on hde2, internal journal
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
microcode: CPU0 updated from revision 0xa to 0xe, date = 09101999



/dev/hde:
multcount    = 16 (on)
IO_support   =  1 (32-bit)
unmaskirq    =  1 (on)
using_dma    =  1 (on)
keepsettings =  0 (off)
readonly     =  0 (off)
readahead    = 4096 (on)
geometry     = 16383/255/63, sectors = 80418240, start = 0


