Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUGLMey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUGLMey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 08:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUGLMey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 08:34:54 -0400
Received: from stud4.tuwien.ac.at ([193.170.75.21]:6888 "EHLO
	stud4.tuwien.ac.at") by vger.kernel.org with ESMTP id S266810AbUGLMeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 08:34:24 -0400
From: Martin Bammer <e9525103@student.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Weird kernel message about irq when loading ehci_hcd
Date: Mon, 12 Jul 2004 14:39:08 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407121439.08256.e9525103@stud4.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this problem is grave for some other users. On my PC the 
system works perfectly, but the output of dmesg may indicate a kernel (driver 
usbcore?) bug.

Kernel version is 2.6.7 downloaded from kernel.org without any additional 
patches and self compiled on a Debian sid system with gcc3.3 for Athlon XP 
and preempt activated.

Output of dmesg (see ehci_hcd part -> irq 11):

Linux version 2.6.7 (root@bender) (gcc-Version 3.3.3 (Debian 20040429)) #1 Wed 
Jun 16 16:13:29 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
MSI K7N2-Delta detected: BIOS IRQ0 pin2 override will be ignored
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f73d0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 lang=de apm=power-off 
mem=nopentium nomce
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1604.033 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 516212k/524224k available (1550k kernel code, 7248k reserved, 701k 
data, 132k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3178.49 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbf7 c1c3fbff 00000000 00000020
CPU: AMD Athlon(tm) XP 1900+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfbbd0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs *17)
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
vesafb: framebuffer at 0xc8000000, mapped to 0xe0808000, size 5120k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:f880
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
Initializing Cryptographic API
Console: switching to colour frame buffer device 160x64
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: HDS722516VLAT80, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: _NEC DVD_RW ND-2500A, ATAPI CD/DVD-ROM drive
hdd: LITE-ON DVD+RW LDW-401S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 321672960 sectors (164696 MB) w/7938KiB Cache, CHS=20023/255/63, 
UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S4 S5)
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 132k freed
Adding 1204832k swap on /dev/hda6.  Priority:-1 extents:1
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 11, pci mem e0e4d000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
irq 11: nobody cared!
 [<c0107a1a>] __report_bad_irq+0x2a/0x90
 [<c0107b10>] note_interrupt+0x70/0xa0
 [<c0107db1>] do_IRQ+0x121/0x130
 [<c01061f4>] common_interrupt+0x18/0x20
 [<c011cab0>] __do_softirq+0x30/0x80
 [<c011cb26>] do_softirq+0x26/0x30
 [<c0107d8d>] do_IRQ+0xfd/0x130
 [<c01061f4>] common_interrupt+0x18/0x20
 [<c01beb9f>] pci_bus_read_config_byte+0x5f/0x90
 [<e0e75acc>] ehci_start+0x2cc/0x360 [ehci_hcd]
 [<c011967d>] printk+0x10d/0x170
 [<e0e974f7>] usb_register_bus+0x137/0x160 [usbcore]
 [<e0e9c54b>] usb_hcd_pci_probe+0x2ab/0x4e0 [usbcore]
 [<c01c24c2>] pci_device_probe_static+0x52/0x70
 [<c01c251b>] __pci_device_probe+0x3b/0x50
 [<c01c255c>] pci_device_probe+0x2c/0x50
 [<c01f698f>] bus_match+0x3f/0x70
 [<c01f6ab9>] driver_attach+0x59/0x90
 [<c01f6d61>] bus_add_driver+0x91/0xb0
 [<c01f721f>] driver_register+0x2f/0x40
 [<c01c27dc>] pci_register_driver+0x5c/0x90
 [<e0e57023>] init+0x23/0x30 [ehci_hcd]
 [<c012ed7f>] sys_init_module+0xff/0x210
 [<c0106087>] syscall_call+0x7/0xb

handlers:
[<e0e982e0>] (usb_hcd_irq+0x0/0x70 [usbcore])
Disabling IRQ #11
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 5, pci mem e0e4f000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 10, pci mem e0e51000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
SCSI subsystem initialized
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
Real Time Clock Driver v1.12
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (33 C)
Linux video capture interface: v1.00
bttv: driver version 0.9.14 loaded
bttv: using 4 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 0000:01:07.0, irq: 5, latency: 32, mmio: 0xd8000000
bttv0: detected: (Askey Magic/others) TView99 CPH05x [card=24], PCI subsystem 
ID is 144f:3002
bttv0: using: Askey CPH05X/06X (bt878) [many vendors] [card=24,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00feffff [init]
bttv0: radio detected by subsystem id (CPH05x)
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951),ta8874z
tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by bt878 #0 
[sw]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: add subdevice "remote0"
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:01:08.0: 3Com PCI 3c905C Tornado at 0xd000. Vers LK1.1.19
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xc0000000
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 1624 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: enabling the bridge
bridge-eth0: up
bridge-eth0: already up
bridge-eth0: attached
/dev/vmnet: open called by PID 1639 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
0: nvidia: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-5336  Wed Jan 14 
18:29:26 PST 2004
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:02:00.0 into 4x mode
/dev/vmnet: open called by PID 1758 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 1757 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 1807 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 1808 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened


/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 1900+
stepping        : 1
cpu MHz         : 1604.033
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3178.49


nvidia 2074856 12 - Live 0xe14a5000
vmnet 30224 12 - Live 0xe112e000
vmmon 48024 0 - Live 0xe1252000
parport_pc 39360 1 - Live 0xe1247000
lp 10564 0 - Live 0xe1114000
parport 41160 2 parport_pc,lp, Live 0xe11ac000
snd_emu10k1 98440 3 - Live 0xe11b8000
snd_rawmidi 25408 1 snd_emu10k1, Live 0xe115c000
snd_pcm_oss 54312 0 - Live 0xe118c000
snd_mixer_oss 19904 1 snd_pcm_oss, Live 0xe1156000
snd_pcm 97508 3 snd_emu10k1,snd_pcm_oss, Live 0xe1173000
snd_timer 25540 1 snd_pcm, Live 0xe1137000
snd_seq_device 8264 2 snd_emu10k1,snd_rawmidi, Live 0xe1118000
snd_ac97_codec 69572 1 snd_emu10k1, Live 0xe1144000
snd_page_alloc 11720 2 snd_emu10k1,snd_pcm, Live 0xe10b8000
snd_util_mem 4608 1 snd_emu10k1, Live 0xe1111000
snd_hwdep 9504 1 snd_emu10k1, Live 0xe110d000
snd 56292 15 
snd_emu10k1,snd_rawmidi,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep, 
Live 0xe111f000
nvidia_agp 7836 1 - Live 0xe10c0000
evdev 9344 0 - Live 0xe10bc000
8250 20928 0 - Live 0xe0f61000
serial_core 23680 1 8250, Live 0xe0f18000
autofs4 19972 2 - Live 0xe0f12000
agpgart 33896 2 nvidia_agp, Live 0xe0f57000
3c59x 38568 0 - Live 0xe0f4c000
forcedeth 15360 0 - Live 0xe0f0d000
tuner 18380 0 - Live 0xe0f07000
tvaudio 22348 0 - Live 0xe0f00000
bttv 152300 0 - Live 0xe0f25000
video_buf 21060 1 bttv, Live 0xe0ef9000
i2c_algo_bit 9800 1 bttv, Live 0xe0ee4000
v4l2_common 6208 1 bttv, Live 0xe0ee1000
btcx_risc 4808 1 bttv, Live 0xe0ec8000
i2c_core 24020 4 tuner,tvaudio,bttv,i2c_algo_bit, Live 0xe0eea000
videodev 9728 1 bttv, Live 0xe0ec4000
soundcore 10016 2 snd,bttv, Live 0xe0e53000
thermal 12752 0 - Live 0xe0ebf000
processor 12964 1 thermal, Live 0xe0eba000
button 6360 0 - Live 0xe0e57000
rtc 12728 0 - Live 0xe0eb0000
usb_storage 67840 0 - Live 0xe0e81000
scsi_mod 83328 1 usb_storage, Live 0xe0ecb000
ohci_hcd 21444 0 - Live 0xe0e7a000
ehci_hcd 31172 0 - Live 0xe0e71000
usbcore 113440 5 usb_storage,ohci_hcd,ehci_hcd, Live 0xe0e93000
ide_cd 42820 0 - Live 0xe0e65000
cdrom 39840 1 ide_cd, Live 0xe0e5a000


/proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #01
  d000-d07f : 0000:01:08.0
    d000-d07f : 0000:01:08.0
  d400-d41f : 0000:01:09.0
    d400-d41f : EMU10K1
  d800-d807 : 0000:01:09.1
e000-e01f : 0000:00:01.1
f000-f00f : 0000:00:09.0
  f000-f007 : ide0
  f008-f00f : ide1


/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cfbff : Video ROM
000d0000-000d07ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00283bee : Kernel code
  00283bef-003330ff : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
c0000000-c7ffffff : 0000:00:00.0
c8000000-d7ffffff : PCI Bus #02
  c8000000-cfffffff : 0000:02:00.0
    c8000000-c84fffff : vesafb
  d0000000-d007ffff : 0000:02:00.0
d8000000-d8ffffff : PCI Bus #01
  d8000000-d8000fff : 0000:01:07.0
    d8000000-d8000fff : bttv0
  d8001000-d8001fff : 0000:01:07.1
d9000000-daffffff : PCI Bus #02
  d9000000-d9ffffff : 0000:02:00.0
db000000-dcffffff : PCI Bus #01
  dc000000-dc00007f : 0000:01:08.0
dd000000-dd000fff : 0000:00:02.1
  dd000000-dd000fff : ohci_hcd
dd001000-dd0010ff : 0000:00:02.2
  dd001000-dd0010ff : ehci_hcd
dd002000-dd002fff : 0000:00:02.0
  dd002000-dd002fff : ohci_hcd


lspci -vvv:
0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) 
(rev a2)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at c0000000 (32-bit, prefetchable)
        Capabilities: [40] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- 
Rate=x4
        Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev 
a2)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev 
a2)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev 
a2)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev 
a2)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev 
a2)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e000
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dd002000 (32-bit, non-prefetchable)
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at dd000000 (32-bit, non-prefetchable)
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at dd001000 (32-bit, non-prefetchable)
        Capabilities: [44] #0a [2080]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev 
a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: db000000-dcffffff
        Prefetchable memory behind bridge: d8000000-d8ffffff
        Expansion ROM at 0000d000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 
8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2) (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d9000000-daffffff
        Prefetchable memory behind bridge: c8000000-d7ffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 02)
        Subsystem: Askey Computer Corp.: Unknown device 3002
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d8000000 (32-bit, prefetchable)

0000:01:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 02)
        Subsystem: Askey Computer Corp.: Unknown device 3002
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d8001000 (32-bit, prefetchable)

0000:01:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management 
NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d000
        Region 1: Memory at dc000000 (32-bit, non-prefetchable) [size=128]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:01:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 
05)
        Subsystem: Creative Labs CT4760 SBLive!
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d400
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 05)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at d800
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 
440] (rev a3) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d9000000 (32-bit, non-prefetchable)
        Region 1: Memory at c8000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at d0000000 (32-bit, prefetchable) [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- 
Rate=x4


I tried to reload the usbcore driver module (and also the network driver 3c95x 
to completely free irq 11 because these 2 drivers share this irq) at runtime 
and watched syslog, but the error does not occur. It only occurs at startup 
of the system.

Cheers, Martin
