Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbRL0VwX>; Thu, 27 Dec 2001 16:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282705AbRL0VwK>; Thu, 27 Dec 2001 16:52:10 -0500
Received: from [217.7.64.198] ([217.7.64.198]:51617 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id <S282850AbRL0Vvo>;
	Thu, 27 Dec 2001 16:51:44 -0500
Message-Id: <200112272151.fBRLpe415377@mx1.net4u.de>
Content-Type: text/plain; charset=US-ASCII
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 with acpi on a Laptop
Date: Thu, 27 Dec 2001 22:51:39 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

i've got a Gericom m6-t Laptop, and i try to install Linux on it (suse-7.3).  
With kernel 2.4.16 every works fine, but the internal tulip-adaper and sound. 
Analyses shows, that there are something going wrong with the irq-routing 
tables. I tried to install the acpi.sf.net on this kernel, but that does'n 
work. With 2.4.17 i can see the first time /proc/acpi, but the laptop will 
overheat after about 10 minutes. PCMCIA is also not working, if there is a 
card sticking in a slot, the PC will die without any errormessage (Starting 
kernel PCMCIA (using scheme: SuSE)). Any idea? The Laptop has in the moment a 
direct internet-connecton with a fixed ip-address (with 2.4.16 and 2.4.10 
over a PCMCIA-Card).

Pls help :-)

Thanks,

Earny

##### dmesg 2.4.17

Linux version 2.4.17 (root@lacpi) (gcc version 2.95.3 20010315 (SuSE)) #4 Thu 
Dec 27 20:34:20 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI data)
 BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=303 
BOOT_FILE=/boot/vmlinuz enableapic vga=794 hdc=ide-scsi acpi=on acpi_boot=on
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1199.823 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 2392.06 BogoMIPS
Memory: 512764k/524288k available (1454k kernel code, 11072k reserved, 443k 
data, 108k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III CPU             1200MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd82e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Found IRQ 4 for device 00:07.5
IRQ routing conflict for 00:0c.1, have irq 10, want irq 4
PCI: Via IRQ fixup for 00:07.5, from 255 to 4
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing 
Methods:...................................................................................................
99 Control Methods found and parsed (350 nodes total)
ACPI Namespace successfully loaded at root c030ad80
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:...[ACPI Debug] String: 
__________________________________
[ACPI Debug] String:
[ACPI Debug] String: BAT0_STA
[ACPI Debug] String: __________________________________
...................................
38 Devices found: 38 _STA, 2 _INI
Completing Region and Field initialization:..................
8/13 Regions, 10/11 Fields initialized (350 nodes total)
ACPI: Subsystem enabled
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: BAT0_STA
[ACPI Debug] String: __________________________________
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: BAT0_STA
[ACPI Debug] String: __________________________________
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: BAT0_STA
[ACPI Debug] String: __________________________________
Power Resource: found
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1 C2, 8 throttling states
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: BAT0_STA
[ACPI Debug] String: __________________________________
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: BAT0_STA
[ACPI Debug] String: __________________________________
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: BAT0_BIF
[ACPI Debug] String: __________________________________
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: BAT0_BIF_RETURN:
[ACPI Debug] String: __________________________________
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] Package: Elements - 0xC1878608
[ACPI Debug] Str[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: BAT0_BIF
[ACPI Debug] String: __________________________________
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: BAT0_BIF_RETURN:
[ACPI Debug] String: __________________________________
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] Package: Elements - 0xC1878608
[ACPI Debug] String: __________________________________
ACPI: Battery socket found, battery present
ACPI: AC Adapter found
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Lid Switch (CM) found
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: THRM_TMP
[ACPI Debug] String: __________________________________
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: THRM_TMP
[ACPI Debug] String: __________________________________
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: THRM_TMP
[ACPI Debug] String: __________________________________
[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: THRM_TMP
[ACPI Debug] String: __________________________________
ACPI: Thermal Zone found
vesafb: framebuffer at 0xf0000000, mapped to 0xe0814000, size 32768k
vesafb: mode is 1280x1024x16, linelength=2560, pages=11
vesafb: protected mode interface info at c000:51a4
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHN2300AT, ATA DISK drive
hdc: UJDA710, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3648/255/63, UDMA(100)
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 571k freed
VFS: Mounted root (ext2 filesystem).
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: UJDA710           Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA710           Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA710           Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA710           Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA710           Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA710           Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA710           Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 0, lun 1
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 0, lun 2
Attached scsi CD-ROM sr3 at scsi0, channel 0, id 0, lun 3
Attached scsi CD-ROM sr4 at scsi0, channel 0, id 0, lun 4
Attached scsi CD-ROM sr5 at scsi0, channel 0, id 0, lun 5
Attached scsi CD-ROM sr6 at scsi0, channel 0, id 0, lun 6
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
sr2: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
sr3: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
sr4: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
sr5: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
sr6: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
reiserfs: checking transaction log (device 03:03) ...
Warning, log replay starting on readonly filesystem
reiserfs: replayed 3 transactions in 4 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
change_root: old root has d_count=2
Trying to unmount old root ... okay
Freeing unused kernel memory: 108k freed
Adding Swap: 1052248k swap-space (priority 42)
ip_tables: (c)2000 Netfilter core team
ip_conntrack (4096 buckets, 32768 max)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Assigned IRQ 5 for device 00:07.2
uhci.c: USB UHCI at I/O 0x1020, IRQ 5
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:06.0
PCI: Sharing IRQ 10 with 00:0d.0
PCI: Found IRQ 4 for device 00:0c.1
PCI: Sharing IRQ 4 with 00:07.5
IRQ routing conflict for 00:0c.1, have irq 10, want irq 4
Yenta IRQ list 0800, PCI irq10
Socket status: 30000006
Yenta IRQ list 0800, PCI irq10
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

##### lspci -vvx

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 91 06 06 00 10 a2 c4 00 00 06 00 00 00 00
10: 08 00 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e0100000-e01fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 98 85 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 90 90 00 00
20: 10 e0 10 e0 00 f0 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:06.0 Communication controller: Lucent Microelectronics LT WinModem
        Subsystem: Askey Computer Corp.: Unknown device 4005
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [disabled] 
[size=256]
        Region 1: I/O ports at 1010 [disabled] [size=8]
        Region 2: I/O ports at 1400 [disabled] [size=256]
        Capabilities: [f8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=160mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c1 11 50 04 00 00 90 02 00 00 80 07 00 40 00 00
10: 00 00 00 e0 11 10 00 00 01 14 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 40 00 00 00 4f 14 05 40
30: 00 00 00 00 f8 00 00 00 00 00 00 00 ff 01 fc 0e

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 05 00 90 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 
[UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at 1020 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 15 00 10 02 1a 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 10 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 04 00 0000:07.4 ISA bridge: VIA 
Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 57 30 00 00 90 02 40 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 57 30
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 50)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1840
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 4
        Region 0: I/O ports at 1800 [size=256]
        Region 1: I/O ports at 101c [size=4]
        Region 2: I/O ports at 1018 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 58 30 01 00 10 02 50 00 01 04 00 00 00 00
10: 01 18 00 00 1d 10 00 00 19 10 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 15 40 18
30: 00 00 00 00 c0 00 00 00 00 00 00 00 04 03 00 00

00:09.0 Ethernet controller: Accton Technology Corporation: Unknown device 
1216 (rev 11)
        Subsystem: Accton Technology Corporation: Unknown device 2242
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 1c00 [disabled] [size=256]
        Region 1: Memory at 20000000 (32-bit, non-prefetchable) [disabled] 
[size=1K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 13 11 16 12 00 00 90 02 11 00 00 02 00 00 00 00
10: 01 1c 00 00 00 00 00 20 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 13 11 42 22
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 01 ff ff

00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001
00: 17 12 33 69 87 00 10 04 01 00 07 06 00 a8 82 00
10: 00 10 00 20 a0 00 00 02 00 02 05 b0 00 00 40 20
20: 00 f0 7f 20 00 00 80 20 00 f0 bf 20 01 40 00 00
30: fd 40 00 00 01 44 00 00 fd 44 00 00 0a 01 80 05
40: 09 15 60 18 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at 20002000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001
00: 17 12 33 69 87 00 10 04 01 00 07 06 00 a8 82 00
10: 00 20 00 20 a0 00 00 02 00 06 09 b0 00 00 c0 20
20: 00 f0 ff 20 00 00 00 21 00 f0 3f 21 01 48 00 00
30: fd 48 00 00 01 4c 00 00 fd 4c 00 00 0a 02 80 05
40: 09 15 60 18 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0d.0 FireWire (IEEE 1394): Lucent Microelectronics: Unknown device 5811 
(rev 04) (prog-if 10 [OHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1881
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0001000 (32-bit, non-prefetchable) [disabled] 
[size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c1 11 11 58 10 00 90 02 04 10 00 0c 08 60 00 00
10: 00 10 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 15 81 18
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 01 0c 18

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c59 
(prog-if 00 [VGA])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1930
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at e0100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 59 4c 83 02 b0 02 00 00 00 03 08 42 00 00
10: 08 00 00 f0 01 90 00 00 00 00 10 e0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 15 30 19
30: 00 00 00 00 58 00 00 00 00 00 00 00 05 01 08 00



