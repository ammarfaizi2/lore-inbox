Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271319AbRH3FJZ>; Thu, 30 Aug 2001 01:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271320AbRH3FJQ>; Thu, 30 Aug 2001 01:09:16 -0400
Received: from mx3.port.ru ([194.67.57.13]:15634 "EHLO mx3.port.ru")
	by vger.kernel.org with ESMTP id <S271319AbRH3FJH>;
	Thu, 30 Aug 2001 01:09:07 -0400
From: "Dmitry Vyatchaninov" <fan_vyi@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM : Linux hangs & is not generating any message when I use sound.
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 212.192.67.73, 212.192.64.3 via proxy [194.226.67.5]
Date: Thu, 30 Aug 2001 05:09:24 +0000 (GMT)
Reply-To: "Dmitry Vyatchaninov" <fan_vyi@mail.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Message-Id: <E15cK4y-000B10-00@f12.port.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for my English, it's not my native.

My sound card Creative PCI 128 (model CT4810) work perfect under Windows, but
doesn't work under Linux & under DOS too. I have Red Hat 7.1, on Pentium 
133 (overclocked from 120) & ZIDA 5SVA motherboard.

I tried ALSA-drivers, upgraded kernel from 2.4.2-2 to 2.4.9 but it did nothing.


Some useful sysinfo (kernel 2.4.9):

#    proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 12
cpu MHz		: 132.875
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 264.60

#    proc/version
    
Linux version 2.4.9 (root@localhost.localdomain) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #4 ÷ÔÒ á×Ç 28 21:25:11 YEKST 2001

#    proc/modules

loop                    8400   2 (autoclean)
nls_koi8-r              3888   1 (autoclean)
nls_cp866               3872   1 (autoclean)
vfat                    9456   1 (autoclean)
fat                    32512   0 (autoclean) [vfat]
usb-uhci               21408   0 (unused)
usbcore                48736   1 [usb-uhci]

#    proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-001c03b1 : Kernel code
  001c03b2-001ff27f : Kernel data
e0000000-e3ffffff : S3 Inc. Trio 64V2/DX or /GX
ffff0000-ffffffff : reserved

#    proc/ioports
    
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
6000-601f : VIA Technologies, Inc. UHCI USB
  6000-601f : usb-uhci
6400-643f : Ensoniq CT5880 [AudioPCI]
f000-f00f : VIA Technologies, Inc. Bus Master IDE
  f000-f007 : ide0
  f008-f00f : ide1

#    lspci -vvv
    
00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX] (rev 23)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 27)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 6000 [size=32]

00:0e.0 Multimedia audio controller: Ensoniq CT5880 [AudioPCI] (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 6400 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 VGA compatible controller: S3 Inc. Trio 64V2/DX or /GX (rev 16) (prog-if 00 [VGA])
	Subsystem: S3 Inc. 86C775 Trio64V2/DX, 86C785 Trio64V2/GX
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

#   ver_kernel script

Linux localhost.localdomain 2.4.9 #4 ÷ÔÒ á×Ç 28 21:25:11 YEKST 2001 i586 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.10r
modutils               2.4.2
e2fsprogs              1.19
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         loop nls_koi8-r nls_cp866 vfat fat usb-uhci usbcore

#    dmesg

Linux version 2.4.9 (root@localhost.localdomain) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #4 ÷ÔÒ á×Ç 28 21:25:11 YEKST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=302 BOOT_FILE=/boot/vmlinuz
Initializing CPU#0
Detected 132.875 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 264.60 BogoMIPS
Memory: 62652k/65536k available (768k kernel code, 2496k reserved, 251k data, 180k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10d
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST34311A, ATA DISK drive
hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8452080 sectors (4327 MB) w/256KiB Cache, CHS=526/255/63, UDMA(33)
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 < hda5 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding Swap: 56188k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.259 $ time 22:01:02 Aug 28 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0x6000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.251:USB Universal Host Controller Interface driver
MSDOS FS: IO charset koi8-r
MSDOS FS: Using codepage 866

Please, send answer/comments to e-mail: fan_vyi@mail.ru

THANK YOU for reading this message to the end.
