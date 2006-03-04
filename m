Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWCDOqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWCDOqN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 09:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWCDOqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 09:46:13 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:19811 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751763AbWCDOqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 09:46:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=FQVjUHCLORAseKXPpd67rHKOCYieBqjSn146u5BeqYehgl2cOHySUcb2htwIL/yRFLovwissZ5rO035CSIt8mZhA8MYpvHwx1IQOhOD1hVyiKH9KZMBOMAOm7GmARRsJkqvVN8gQTp3cxBLSINaQaOIFiFhK/XWPPDcGUwzLf1o=
Message-ID: <8be2e100603040646k7f40e8eai391eb914040cb8f8@mail.gmail.com>
Date: Sat, 4 Mar 2006 22:46:11 +0800
From: "Shinichi Kudo" <randomshinichi4869@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: VIA C3 (Ezra C5C) Crashes with longhaul Freq scaling
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9631_27067910.1141483571503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_9631_27067910.1141483571503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

After compiling my own kernels from 2.6.11 to 2.6.14, I found that
only the Ubuntu official kernel didn't lock up hard after 2 hours or
so. Why? Because it didn't provide the frequency scaling driver
longhaul.ko for my VIA C3 CPU. WIthout longhaul frequency scaling, my
laptop is rock stable.

According to http://tinyurl.com/k7wlw , this has been going on since kernel=
 2.4!

In http://tinyurl.com/oxetd Dave Jones says,
Version 2 of longhaul is the same as v1, but adds voltage scaling.
 12  *   Present in Samuel 2 (steppings 1-7 only) (C5B), and Ezra (C5C)

Output of cat /proc/cpuinfo included.
Output of dmesg also included.

As you can see, dmesg says the kernel detected a Ezra C5C version of
VIA C3. However, it also goes on to say, only longhaul v1 supported.
What's with that? Does that have anything to do with the laptop
locking?

When the laptop locks, nothing on the screen moves. I can adjust
screen brightness even in the bios, but once it locks, I cannot do
that. Numlock,Capslock,Scrolllock do not change when I press their
buttons either, and pinging my lockedup laptop does not solicit a
reply.

So, it is unfortunate, but I don't think any kernel dumps or panic
messages were output. I should know. I've been experiencing this for a
year or so.

Please, somebody fix this frequency scaling issue!
Randomshinichi

--
....pi......pi......kaaaaaaa....
AMD Throughbred-A 1533MHz, 768MB PC2100 RAM, Maxtor 6EL040,
NV25 Ti4200 128MB

------=_Part_9631_27067910.1141483571503
Content-Type: application/octet-stream; name=cpuinfo
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eke1m45u
Content-Disposition: attachment; filename="cpuinfo"

processor	: 0
vendor_id	: CentaurHauls
cpu family	: 6
model		: 7
model name	: VIA Ezra
stepping	: 10
cpu MHz		: 933.545
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips	: 1868.19






------=_Part_9631_27067910.1141483571503
Content-Type: application/octet-stream; name=dmesg
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eke1mycp
Content-Disposition: attachment; filename="dmesg"

Linux version 2.6.15.1-ubuntu1athenacustom (root@athena-asamiya) (gcc version 4.0.3 20060212 (prerelease) (Ubuntu 4.0.2-9ubuntu1)) #25 PREEMPT Fri Mar 3 13:16:56 MYT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eefc000 (ACPI data)
 BIOS-e820: 000000000eefc000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
238MB LOWMEM available.
On node 0 totalpages: 61168
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 57072 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7d50
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0eefa00c
ACPI: FADT (v001 DEMOBD PTLTW    0x06040000 PTL_ 0x000f4240) @ 0x0eefbf64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0eefbfd8
ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Allocating PCI resources starting at 10000000 (gap: 0f000000:f0fe0000)
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro vga=789 video:ywrap,mtrr splash
No local APIC present or hardware disabled
mapped APIC to ffffd000 (011df000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 933.545 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 238412k/244672k available (1876k kernel code, 5768k reserved, 1111k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1868.19 BogoMIPS (lpj=934096)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 00803035 80803035 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 64K (32 bytes/line)
CPU: After all inits, caps: 00803135 80803035 00000000 00000000 00000000 00000000 00000000
mtrr: v2.0 (20020519)
CPU: Centaur VIA Ezra stepping 0a
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0400 (from 0a80)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd94e, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050916
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 4000-407f claimed by vt8235 PM
PCI quirk: region 8100-810f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 1) interrupt mode.
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 9 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 9 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 9 11) *7
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *9 11)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 8 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:05: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:05: ioport range 0x4000-0x407f could not be reserved
pnp: 00:05: ioport range 0x8100-0x811f could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e8100000-e81fffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bus 2, cardbus bridge: 0000:00:0a.0
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 10000000-11ffffff
  MEM window: 12000000-13ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Enabling device 0000:00:0a.0 (0001 -> 0003)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:0a.0 to 64
Simple Boot Flag at 0x36 set to 0x1
longhaul: VIA C3 'Ezra' [C5C] CPU detected.  Longhaul v1 supported.
audit: initializing netlink socket (disabled)
audit(1141482143.282:1): initialized
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
vesafb: framebuffer at 0xf0000000, mapped to 0xcf880000, using 3750k, total 15296k
vesafb: mode is 800x600x32, linelength=3200, pages=6
vesafb: protected mode interface info at c000:8426
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ACPI: bus type ide registered
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Via IRQ fixup for 0000:00:11.1, from 0 to 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1c40-0x1c47, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: FUJITSU MHT2030AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=58140/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
mice: PS/2 mouse device common for all mice
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
TCP bic registered
Using IPI Shortcut mode
ACPI wakeup devices: 
LIDB SLPB PWRB USB1 USB2 USB4 
ACPI: (supports S0 S1 S4 S5)
input: AT Translated Set 2 keyboard as /class/input/input0
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed
kjournald starting.  Commit interval 5 seconds
NET: Registered protocol family 1
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo Pro266 chipset
agpgart: AGP aperture is 32M @ 0xea000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
eth0: RealTek RTL8139 at 0xcf82e000, 0a:02:40:00:00:3a, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 9, io base 0x00001c00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.0 [17c4:7230]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.0, mfunc 0x015c1d22, devctl 0x66
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 9, io base 0x00001c20
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Real Time Clock Driver v1.12
Yenta: ISA IRQ mask 0x0078, PCI irq 11
Socket status: 30000006
ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:10.3: irq 9, io mem 0xe8000400
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:11.6[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
PCI: Via IRQ fixup for 0000:00:11.6, from 7 to 9
PCI: Setting latency timer of device 0000:00:11.6 to 64
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
Synaptics Touchpad, model: 1, fw: 5.8, id: 0x114cb1, caps: 0x804753/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input1
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=5 option
         and report if it works on your machine.
         For more details, read ALSA-Configuration.txt.
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
PCI: Via IRQ fixup for 0000:00:11.5, from 7 to 9
PCI: Setting latency timer of device 0000:00:11.5 to 64
Adding 750448k swap on /dev/hda2.  Priority:-1 extents:1 across:750448k
EXT3 FS on hda3, internal journal
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Lid Switch [LIDB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports 16 throttling states)
usb 1-1: new low speed USB device using uhci_hcd and address 2
input: USB_PS2 Optical Mouse as /class/input/input2
input: USB HID v1.10 Mouse [USB_PS2 Optical Mouse] on usb-0000:00:10.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
mtrr: base(0xf2000000) is not aligned on a size(0x5000000) boundary
[drm] Initialized savage 2.4.1 20050313 on minor 0: 
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present




------=_Part_9631_27067910.1141483571503
Content-Type: application/octet-stream; name=lspci
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eke1rbpw
Content-Disposition: attachment; filename="lspci"

0000:00:00.0 Host bridge: VIA Technologies, Inc. P/KN266 Host Bridge
	Subsystem: VIA Technologies, Inc. P/KN266 Host Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at ea000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e8100000-e81fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
	Subsystem: Unknown device 17c4:7230
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 14000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10000000-11fff000 (prefetchable)
	Memory window 1: 12000000-13fff000
	I/O window 0: 00002000-000020ff
	I/O window 1: 00002400-000024ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: Unknown device 17c4:0230
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 4: I/O ports at 1c00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: Unknown device 17c4:0230
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 1c20 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: Unknown device 17c4:0230
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at e8000400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: Unknown device 17c4:0230
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 17c4:0230
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 1c40 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: Unknown device 17c4:0230
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 9
	Region 0: I/O ports at 1400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 80)
	Subsystem: Unknown device 17c4:2230
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 9
	Region 0: I/O ports at 1800 [size=256]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: S3 Inc. VT8375 [ProSavage8 KM266/KL266] (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at e8180000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4



------=_Part_9631_27067910.1141483571503
Content-Type: application/octet-stream; name=ver_linux
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eke1rkap
Content-Disposition: attachment; filename="ver_linux"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux athena-asamiya 2.6.15.1-ubuntu1athenacustom-DRI #22 PREEMPT Thu Mar 2 22:04:06 MYT 2006 i686 GNU/Linux
 
Gnu C                  4.0.3
Gnu make               3.81beta4
binutils               2.16.91
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.7.7
pcmcia-cs              3.2.8
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.93
udev                   079
Modules Loaded         usbhid ipv6 savage drm video thermal processor fan button battery ac snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx_modem snd_via82xx snd_ac97_codec snd_ac97_bus snd_mpu401_uart snd_pcm_oss snd_mixer_oss pcmcia firmware_class snd_rawmidi snd_seq_device snd_pcm snd_timer snd i2c_viapro uhci_hcd ehci_hcd rtc snd_page_alloc usbcore 8139too mii yenta_socket rsrc_nonstatic pcmcia_core i2c_prosavage i2c_algo_bit i2c_core psmouse soundcore via_agp agpgart evdev unix


------=_Part_9631_27067910.1141483571503--
