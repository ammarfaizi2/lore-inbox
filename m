Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279991AbRKDNvl>; Sun, 4 Nov 2001 08:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279992AbRKDNvd>; Sun, 4 Nov 2001 08:51:33 -0500
Received: from ulima.unil.ch ([130.223.144.143]:29824 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S279991AbRKDNvT>;
	Sun, 4 Nov 2001 08:51:19 -0500
Date: Sun, 4 Nov 2001 14:51:15 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic: Loop 1 (aic7xxx under 2.4.13-ac[246])
Message-ID: <20011104145115.B19746@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

With 2.4.10-ac7 no problems at all, but with 2.4.13-ac[246] (not tested the other
ones), compiled either with gcc-2.96 from Mandrake or gcc-3.02 also from Mandrake,
on the first power on of my computer, ends so:

scsi0:A:0:0: Tagged Queuing enabled. Depth 64
scsi1: brkadrint, Scratch or SCB Memory Parity Error at seqaddr = 0x1
scsi1: Dumping Card State while idle, at SEQADDR 0x1
ACCUM = 0x3, SINDEX = 0x20, DINDEX = 0xc0, ARG_2 = 0x0
HCNT = 0x0
SCSIEQ = 0x12, SBLKCTL = 0x0
 DFCNTRL = 0x4, DFSTATUS = 0x6d
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x5, SSTAT1 = 0x0
STACK == 0x17, 0x186, 0x0, 0x0
SCB count =4
Kernel NEXTQSCB =2
Card NEXTQSCB =2
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
Pending list:
Kernel Free SCB list: 3 1 0
scsi1:0:1:0: Attempting to queue an ABORT message
scsi1: Dumping Card State while idle, at SEQADDR 0x18
ACCUM = 0x0, SINDEX = 0x0, DINDEX = 0x0, ARG_2 = 0x0
HCNT = 0x0
SCSIEQ = 0x0, SBLKCTL = 0xc0
 DFCNTRL = 0x0, DFSTATUS = 0x29
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x0
SSTAT0 = 0x0, SSTAT1 = 0x8
STACK == 0x17, 0x0, 0x0, 0x0
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 0
QINFIFO entries: 3 2
Waiting Queue entries: 0:255 1:255 2:255 3:255 4:255 5:255 6:255 7:255 8:255 9:255 10:255 11:255 12:255 13:255 14:255 15:255
Disconnected Queue entries: 0:255 1:255 2:255 3:255 4:255 5:255 6:255 7:255 8:255 9:255 10:255 11:255 12:255 13:255 14:255 15:255
QOUTFIFO entries:
Sequencer Free SCB list: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
Pending list: 2
Kernel Free SCB list: 1 0
Untagged Q(1): 2
DevQ(0:1:0): 0 waiting
qinpos =0, SCB index +3
Kernel panic: Loop 1

And if I reboot, no more problem:

v  4 13:53:38 localhost syslogd 1.4-0: restart (remote reception).
Nov  4 13:53:38 localhost kernel: klogd 1.4-0, log source = /proc/kmsg started.
Nov  4 13:53:38 localhost kernel: Inspecting /boot/System.map-2.4.13-ac6
Nov  4 13:53:39 localhost random: Initializing random number generator:  succeeded
Nov  4 13:53:39 localhost kernel: Loaded 16503 symbols from /boot/System.map-2.4.13-ac6.
Nov  4 13:53:39 localhost kernel: Symbols match kernel version 2.4.13.
Nov  4 13:53:39 localhost kernel: Loaded 6 symbols from 1 module.
Nov  4 13:53:39 localhost kernel: Linux version 2.4.13-ac6 (greg@localhost.localdomain) (gcc version 3.0.2) #1 Fri Nov 2 20:42:36 CET 2001
Nov  4 13:53:39 localhost kernel: BIOS-provided physical RAM map:
Nov  4 13:53:39 localhost kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Nov  4 13:53:39 localhost kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Nov  4 13:53:39 localhost kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Nov  4 13:53:39 localhost kernel:  BIOS-e820: 0000000000100000 - 000000001fffd000 (usable)
Nov  4 13:53:39 localhost kernel:  BIOS-e820: 000000001fffd000 - 000000001ffff000 (ACPI data)
Nov  4 13:53:39 localhost kernel:  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
Nov  4 13:53:39 localhost kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Nov  4 13:53:39 localhost kernel: On node 0 totalpages: 131069
Nov  4 13:53:39 localhost kernel: zone(0): 4096 pages.
Nov  4 13:53:39 localhost kernel: zone(1): 126973 pages.
Nov  4 13:53:39 localhost kernel: zone(2): 0 pages.
Nov  4 13:53:39 localhost kernel: Local APIC disabled by BIOS -- reenabling.
Nov  4 13:53:39 localhost kernel: Found and enabled local APIC!
Nov  4 13:53:39 localhost kernel: Kernel command line: BOOT_IMAGE=2.4.13-ac6 root=306 video=matrox:1280x1024-16@85
Nov  4 13:53:39 localhost kernel: Initializing CPU#0
Nov  4 13:53:39 localhost kernel: Detected 451.031 MHz processor.
Nov  4 13:53:39 localhost kernel: Console: colour VGA+ 80x25
Nov  4 13:53:39 localhost kernel: Calibrating delay loop... 897.84 BogoMIPS
Nov  4 13:53:39 localhost kernel: Memory: 513312k/524276k available (1481k kernel code, 10576k reserved, 374k data, 232k init, 0k highmem)
Nov  4 13:53:39 localhost kernel: Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Nov  4 13:53:39 localhost kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Nov  4 13:53:39 localhost kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Nov  4 13:53:39 localhost kernel: Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Nov  4 13:53:39 localhost kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Nov  4 13:53:39 localhost kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Nov  4 13:53:39 localhost kernel: CPU: L2 cache: 512K
Nov  4 13:53:39 localhost kernel: Intel machine check architecture supported.
Nov  4 13:53:39 localhost kernel: Intel machine check reporting enabled on CPU#0.
Nov  4 13:53:39 localhost kernel: CPU: Intel Pentium III (Katmai) stepping 02
Nov  4 13:53:39 localhost kernel: Enabling fast FPU save and restore... done.
Nov  4 13:53:39 localhost kernel: Enabling unmasked SIMD FPU exception support... done.
Nov  4 13:53:39 localhost kernel: Checking 'hlt' instruction... OK.
Nov  4 13:53:39 localhost kernel: POSIX conformance testing by UNIFIX
Nov  4 13:53:39 localhost kernel: enabled ExtINT on CPU#0
Nov  4 13:53:39 localhost kernel: ESR value before enabling vector: 00000040
Nov  4 13:53:39 localhost kernel: ESR value after enabling vector: 00000000
Nov  4 13:53:39 localhost kernel: Using local APIC timer interrupts.
Nov  4 13:53:39 localhost kernel: calibrating APIC timer ...
Nov  4 13:53:39 localhost kernel: ..... CPU clock speed is 451.0216 MHz.
Nov  4 13:53:39 localhost kernel: ..... host bus clock speed is 100.2268 MHz.
Nov  4 13:53:39 localhost kernel: cpu: 0, clocks: 1002268, slice: 501134
Nov  4 13:53:39 localhost kernel: CPU0<T0:1002256,T1:501120,D:2,S:501134,C:1002268>
Nov  4 13:53:39 localhost kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Nov  4 13:53:39 localhost kernel: mtrr: detected mtrr type: Intel
Nov  4 13:53:39 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
Nov  4 13:53:39 localhost kernel: PCI: Using configuration type 1
Nov  4 13:53:39 localhost kernel: PCI: Probing PCI hardware
Nov  4 13:53:39 localhost kernel: Unknown bridge resource 0: assuming transparent
Nov  4 13:53:39 localhost kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Nov  4 13:53:39 localhost kernel: Limiting direct PCI/PCI transfers.
Nov  4 13:53:39 localhost kernel: Linux NET4.0 for Linux 2.4
Nov  4 13:53:39 localhost kernel: Based upon Swansea University Computer Society NET3.039
Nov  4 13:53:39 localhost kernel: Initializing RT netlink socket
Nov  4 13:53:39 localhost kernel: SBF: Simple Boot Flag extension found and enabled.
Nov  4 13:53:39 localhost kernel: SBF: Setting boot flags 0x1
Nov  4 13:53:39 localhost kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
Nov  4 13:53:39 localhost kernel: Starting kswapd v1.8
Nov  4 13:53:39 localhost kernel: Journalled Block Device driver loaded
Nov  4 13:53:39 localhost kernel: NTFS driver v1.1.20 [Flags: R/O]
Nov  4 13:53:39 localhost kernel: udf: registering filesystem
Nov  4 13:53:39 localhost kernel: i2c-core.o: i2c core module
Nov  4 13:53:39 localhost kernel: i2c-algo-bit.o: i2c bit algorithm module
Nov  4 13:53:39 localhost kernel: matroxfb: Matrox Millennium G400 MAX (AGP) detected
Nov  4 13:53:39 localhost kernel: matroxfb: MTRR's turned on
Nov  4 13:53:39 localhost kernel: matroxfb: 1280x1024x16bpp (virtual: 1280x6552)
Nov  4 13:53:39 localhost kernel: matroxfb: framebuffer at 0xE4000000, mapped to 0xe0812000, size 33554432
Nov  4 13:53:39 localhost kernel: Console: switching to colour frame buffer device 160x64
Nov  4 13:53:39 localhost kernel: fb0: MATROX VGA frame buffer device
Nov  4 13:53:39 localhost kernel: pty: 256 Unix98 ptys configured
Nov  4 13:53:39 localhost kernel: Real Time Clock Driver v1.10e
Nov  4 13:53:39 localhost kernel: block: queued sectors max/low 341008kB/209936kB, 1024 slots per queue
Nov  4 13:53:39 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Nov  4 13:53:39 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov  4 13:53:39 localhost kernel: PIIX4: IDE controller on PCI bus 00 dev 21
Nov  4 13:53:39 localhost kernel: PIIX4: chipset revision 1
Nov  4 13:53:39 localhost kernel: PIIX4: not 100%% native mode: will probe irqs later
Nov  4 13:53:39 localhost kernel: hda: IBM-DTTA-371440, ATA DISK drive
Nov  4 13:53:39 localhost kernel: hdc: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
Nov  4 13:53:39 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov  4 13:53:39 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov  4 13:53:39 localhost kernel: hda: 28229040 sectors (14453 MB) w/462KiB Cache, CHS=1757/255/63
Nov  4 13:53:39 localhost kernel: ide-floppy driver 0.97.sv
Nov  4 13:53:39 localhost kernel: hdc: 244766kB, 489532 blocks, 512 sector size
Nov  4 13:53:39 localhost kernel: hdc: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
Nov  4 13:53:39 localhost kernel: hdc: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
Nov  4 13:53:39 localhost kernel: Partition check:
Nov  4 13:53:39 localhost kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Nov  4 13:53:39 localhost kernel:  hdc: unknown partition table
Nov  4 13:53:39 localhost kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Nov  4 13:53:39 localhost kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Nov  4 13:53:39 localhost kernel: PCI: Found IRQ 10 for device 00:07.0
Nov  4 13:53:39 localhost kernel: PCI: Sharing IRQ 10 with 00:0a.0
Nov  4 13:53:39 localhost kernel: PCI: Sharing IRQ 10 with 00:0a.1
Nov  4 13:53:39 localhost kernel: eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:E0:18:90:14:C5, IRQ 10.
Nov  4 13:53:39 localhost kernel:   Receiver lock-up bug exists -- enabling work-around.
Nov  4 13:53:39 localhost kernel:   Board assembly 668081-002, Physical connectors present: RJ45
Nov  4 13:53:39 localhost kernel:   Primary interface chip i82555 PHY #1.
Nov  4 13:53:39 localhost kernel:   General self-test: passed.
Nov  4 13:53:39 localhost kernel:   Serial sub-system self-test: passed.
Nov  4 13:53:39 localhost kernel:   Internal registers self-test: passed.
Nov  4 13:53:39 localhost kernel:   ROM checksum self-test: passed (0x24c9f043).
Nov  4 13:53:39 localhost kernel:   Receiver lock-up workaround activated.
Nov  4 13:53:39 localhost kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Nov  4 13:53:39 localhost kernel: agpgart: Maximum main memory to use for agp memory: 439M
Nov  4 13:53:39 localhost kernel: agpgart: Detected Intel 440BX chipset
Nov  4 13:53:39 localhost kernel: agpgart: AGP aperture is 32M @ 0xe6000000
Nov  4 13:53:39 localhost kernel: [drm] AGP 0.99 on Intel 440BX @ 0xe6000000 32MB
Nov  4 13:53:39 localhost kernel: [drm] Initialized mga 3.0.2 20010321 on minor 0
Nov  4 13:53:39 localhost kernel: ide-floppy driver 0.97.sv
Nov  4 13:53:39 localhost kernel: SCSI subsystem driver Revision: 1.00
Nov  4 13:53:39 localhost kernel: PCI: Found IRQ 5 for device 00:06.0
Nov  4 13:53:39 localhost kernel: PCI: Sharing IRQ 5 with 00:04.2
Nov  4 13:53:39 localhost kernel: PCI: Sharing IRQ 5 with 00:09.0
Nov  4 13:53:39 localhost kernel: PCI: Found IRQ 11 for device 00:0b.0
Nov  4 13:53:39 localhost kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
Nov  4 13:53:39 localhost kernel:         <Adaptec aic7890/91 Ultra2 SCSI adapter>
Nov  4 13:53:39 localhost kernel:         aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
Nov  4 13:53:39 localhost kernel: 
Nov  4 13:53:39 localhost kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
Nov  4 13:53:39 localhost kernel:         <Adaptec 2940 SCSI adapter>
Nov  4 13:53:39 localhost kernel:         aic7870: Single Channel A, SCSI Id=7, 16/253 SCBs
Nov  4 13:53:39 localhost kernel: 
Nov  4 13:53:39 localhost kernel:   Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
Nov  4 13:53:39 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Nov  4 13:53:39 localhost kernel:   Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R04
Nov  4 13:53:39 localhost kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Nov  4 13:53:39 localhost kernel:   Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.07
Nov  4 13:53:39 localhost kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Nov  4 13:53:39 localhost kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
Nov  4 13:53:39 localhost kernel: (scsi1:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
Nov  4 13:53:39 localhost kernel:   Vendor: PIONEER   Model: CD-ROM DR-U06S    Rev: 1.05
Nov  4 13:53:39 localhost kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Nov  4 13:53:39 localhost kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Nov  4 13:53:39 localhost kernel: (scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
Nov  4 13:53:39 localhost kernel: SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
Nov  4 13:53:39 localhost kernel:  sda: sda1 sda2
Nov  4 13:53:39 localhost kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Nov  4 13:53:39 localhost kernel: Attached scsi CD-ROM sr1 at scsi0, channel 0, id 3, lun 0
Nov  4 13:53:39 localhost kernel: Attached scsi CD-ROM sr2 at scsi1, channel 0, id 2, lun 0
Nov  4 13:53:39 localhost kernel: (scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 16)
Nov  4 13:53:39 localhost kernel: sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Nov  4 13:53:39 localhost kernel: Uniform CD-ROM driver Revision: 3.12
Nov  4 13:53:39 localhost kernel: (scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 8)
Nov  4 13:53:39 localhost kernel: sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Nov  4 13:53:39 localhost kernel: sr2: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Nov  4 13:53:39 localhost kernel: usb.c: registered new driver usbdevfs
Nov  4 13:53:39 localhost kernel: usb.c: registered new driver hub
Nov  4 13:53:39 localhost kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Nov  4 13:53:39 localhost kernel: IP Protocols: ICMP, UDP, TCP
Nov  4 13:53:39 localhost kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Nov  4 13:53:39 localhost kernel: TCP: Hash tables configured (established 32768 bind 65536)
Nov  4 13:53:39 localhost kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Nov  4 13:53:39 localhost kernel: kjournald starting.  Commit interval 5 seconds
Nov  4 13:53:39 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov  4 13:53:39 localhost kernel: VFS: Mounted root (ext3 filesystem) readonly.
Nov  4 13:53:39 localhost kernel: Freeing unused kernel memory: 232k freed
Nov  4 13:53:39 localhost kernel: Adding Swap: 136512k swap-space (priority -1)
Nov  4 13:53:39 localhost kernel: Adding Swap: 130748k swap-space (priority -2)
Nov  4 13:53:39 localhost kernel: EXT3 FS 2.4-0.9.13, 21 Oct 2001 on ide0(3,6), internal journal
Nov  4 13:53:39 localhost kernel: hdc: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
Nov  4 13:53:39 localhost kernel:  hdc: unknown partition table
Nov  4 13:53:39 localhost kernel: reiserfs: checking transaction log (device 08:02) ...
Nov  4 13:53:39 localhost kernel: Using r5 hash to sort names
Nov  4 13:53:39 localhost kernel: ReiserFS version 3.6.25
Nov  4 13:53:39 localhost kernel: kjournald starting.  Commit interval 5 seconds
Nov  4 13:53:39 localhost kernel: EXT3 FS 2.4-0.9.13, 21 Oct 2001 on ide0(3,3), internal journal
Nov  4 13:53:39 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov  4 13:53:39 localhost kernel: hdc: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
Nov  4 13:53:39 localhost kernel:  hdc: unknown partition table
Nov  4 13:53:39 localhost kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
Nov  4 13:53:39 localhost kernel: PCI: Found IRQ 5 for device 00:04.2
Nov  4 13:53:39 localhost kernel: PCI: Sharing IRQ 5 with 00:06.0
Nov  4 13:53:39 localhost kernel: PCI: Sharing IRQ 5 with 00:09.0
Nov  4 13:53:39 localhost kernel: uhci.c: USB UHCI at I/O 0xd400, IRQ 5
Nov  4 13:53:39 localhost kernel: usb.c: new USB bus registered, assigned bus number 1
Nov  4 13:53:39 localhost kernel: hub.c: USB hub found
Nov  4 13:53:39 localhost kernel: hub.c: 2 ports detected
...

lspci -v gives:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
        Flags: bus master, medium devsel, latency 64
        Memory at e6000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: e0000000-e16fffff
        Prefetchable memory behind bridge: e3f00000-e5ffffff

00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 32
        I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Flags: medium devsel, IRQ 9

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
        Subsystem: Adaptec 2940U2W SCSI Controller
        Flags: bus master, medium devsel, latency 32, IRQ 5
        BIST result: 00
        I/O ports at d000 [disabled] [size=256]
        Memory at df800000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

00:07.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)
        Subsystem: Intel Corporation 82558 10/100 with Wake on LAN
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at e3000000 (32-bit, prefetchable) [size=4K]
        I/O ports at b800 [size=32]
        Memory at df000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1

00:09.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
        Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at de800000 (32-bit, non-prefetchable) [size=512]

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at e2000000 (32-bit, prefetchable) [size=4K]

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at e1800000 (32-bit, prefetchable) [size=4K]

00:0b.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at b400 [disabled] [size=256]
        Memory at de000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=32K]

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 06)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at b000 [size=32]
        Capabilities: [dc] Power Management version 1

00:0c.1 Input device controller: Creative Labs SB Live! (rev 06)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at a800 [size=8]
        Capabilities: [dc] Power Management version 1

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at e4000000 (32-bit, prefetchable) [size=32M]
        Memory at e0800000 (32-bit, non-prefetchable) [size=16K]
        Memory at e0000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at e3ff0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0

I don't know if I should say anything more?
Please CC to me as I am not on the mailing list, thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
