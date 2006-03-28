Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWC1VZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWC1VZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWC1VZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:25:25 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:57224 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751258AbWC1VZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:25:24 -0500
Date: Tue, 28 Mar 2006 23:25:11 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: dtor_core@ameritech.net
cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] PS/2-mouse not found in 2.6.16
In-Reply-To: <d120d5000603281223p28792d7la7a13438a2a68149@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0603282324120.2192@be1.lrz>
References: <Pine.LNX.4.58.0603272148050.2266@be1.lrz> 
 <d120d5000603271256g6ff971daq57282287fd1d5434@mail.gmail.com> 
 <Pine.LNX.4.58.0603282044060.2538@be1.lrz> <d120d5000603281223p28792d7la7a13438a2a68149@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Dmitry Torokhov wrote:
> On 3/28/06, Bodo Eggert <7eggert@gmx.de> wrote:
> > On Mon, 27 Mar 2006, Dmitry Torokhov wrote:
> > > On 3/27/06, Bodo Eggert <7eggert@gmx.de> wrote:
> >
> > > > With kernel 2.6.16, my Logitech mouse is no longer detected (not reported
> > > > in dmesg, not working).
> > > >
> > >
> > > Does it help if you comment out call to quirk_usb_handoff_ohci() (your
> > > USB host controller is an OHCI one, isn't it?) in
> > > drivers/usb/host/pci-quirks.c::quirk_usb_early_handoff()?
> >
> > It's uhci, and turning
> > drivers/usb/host/pci-quirks.c::quirk_usb_early_handoff into a noop did not
> > help.
> 
> OK, then please boot with i8042.debug=1 and post your full dmesg.

Linux version 2.6.16 (7eggert@be1) (gcc version 3.3.1 (SuSE Linux)) #16 Tue Mar 28 22:47:45 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126960 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI not present or invalid.
Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=l ro root=345 netconsole=514@192.168.7.201/eth0,514@192.168.7.210/00:0E:2E:27:8B:8E i8042.debug=1
netconsole: local port 514
netconsole: local IP 192.168.7.201
netconsole: interface eth0
netconsole: remote port 514
netconsole: remote IP 192.168.7.210
netconsole: remote ethernet address 00:0e:2e:27:8b:8e
Enabling fast FPU save and restore... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c04bb000 soft=c04ba000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 901.725 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514684k/524224k available (2553k kernel code, 9008k reserved, 1098k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1806.32 BogoMIPS (lpj=3612657)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: Using configuration type 1
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 6000-607f claimed by vt82c686 HW-mon
PCI quirk: region 5000-500f claimed by vt82c686 SMB
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: e8000000-e9ffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.26 [Flags: R/O].
fuse init (API version 7.6)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Applying VIA southbridge workaround.
radeonfb_pci_register BEGIN
radeonfb (0000:01:00.0): Found 131072k of DDR 128 bits wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
hStart = 737, hEnd = 808, hTotal = 896
vStart = 401, vEnd = 404, vTotal = 417
h_total_disp = 0x59006f	   hsync_strt_wid = 0x8802eb
v_total_disp = 0x18f01a0	   vsync_strt_wid = 0x830190
pixclock = 38210
freq = 2617
freq = 2617, PLL min = 20000, PLL max = 40000
ref_div = 12, ref_clk = 2700, output_freq = 20936
ref_div = 12, ref_clk = 2700, output_freq = 20936
post div = 0x3
fb_div = 0x5d
ppll_div_3 = 0x3005d
Console: switching to colour frame buffer device 90x25
radeonfb (0000:01:00.0): ATI Radeon AS 
radeonfb_pci_register END
PCI: Enabling device 0000:00:09.0 (0000 -> 0003)
PCI: Found IRQ 9 for device 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:0d.0
fb: 3Dfx Banshee memory = 16384K
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized drm 1.0.1 20051102
PCI: Found IRQ 9 for device 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:0d.0
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized radeon 1.22.0 20051229 on minor 1
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 5a <- i8042 (return) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: a7 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 76 <- i8042 (return) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: a8 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 56 <- i8042 (return) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: f0 <- i8042 (return) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 56 <- i8042 (return) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: a4 <- i8042 (return) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [0]
serio: i8042 AUX port at 0x60,0x64 irq 12
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [0]
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport_pc: VIA parallel port: io=0x378, irq=7
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
PCI: Found IRQ 10 for device 0000:00:0b.0
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xe080e000, 00:0e:2e:27:8b:8a, IRQ 10
netconsole: device eth0 not up yet, forcing it
r8169: eth0: link down
r8169: eth0: link up
netconsole: network logging started
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 2F040L0, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ST36451A, ATA DISK drive
hdd: LITE-ON LTR-48246K, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
hdb: max request size: 128KiB
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 > hdb4
hdc: max request size: 128KiB
hdc: 12594960 sectors (6448 MB) w/448KiB Cache, CHS=13328/15/63, UDMA(33)
 hdc: hdc1 hdc2
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
PCI: Found IRQ 11 for device 0000:00:0c.0
PCI: Sharing IRQ 11 with 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:07.3
DC390_init: No EEPROM found! Trying default settings ...
DC390: Used defaults: AdaptID=7, SpeedIdx=0 (10.0 MHz), DevMode=0x1f, AdaptMode=0x2f, TaggedCmnds=3 (16), DelayReset=1s
scsi0 : Tekram DC390/AM53C974 V2.1d 2004-05-27
  Vendor: IBM       Model: DCAS-34330        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DCAS-34330        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: CD-ROM XM-6201TA  Rev: 1030
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: CD-ROM CR-8004    Rev: 1.1f
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DORS-32160        Rev: S82C
  Type:   Direct-Access                      ANSI SCSI revision: 02
st: Version 20050830, fixed bufsize 32768, s/g segs 256
DC390: Target 0: Sync transfer 10.0 MHz, Offset 15
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
sda: Write Protect is off
sda: Mode Sense: b3 00 00 08
SCSI device sda: drive cache: write back
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
sda: Write Protect is off
sda: Mode Sense: b3 00 00 08
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
DC390: Target 1: Sync transfer 10.0 MHz, Offset 15
SCSI device sdb: 8467200 512-byte hdwr sectors (4335 MB)
sdb: Write Protect is off
sdb: Mode Sense: b3 00 00 08
SCSI device sdb: drive cache: write back
SCSI device sdb: 8467200 512-byte hdwr sectors (4335 MB)
sdb: Write Protect is off
sdb: Mode Sense: b3 00 00 08
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 0:0:1:0: Attached scsi disk sdb
DC390: Target 5: Sync transfer 10.0 MHz, Offset 15
SCSI device sdc: 4226725 512-byte hdwr sectors (2164 MB)
sdc: Write Protect is off
sdc: Mode Sense: b3 00 00 08
SCSI device sdc: drive cache: write back
SCSI device sdc: 4226725 512-byte hdwr sectors (2164 MB)
sdc: Write Protect is off
sdc: Mode Sense: b3 00 00 08
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 0:0:5:0: Attached scsi disk sdc
DC390: Target 3: Sync transfer 10.0 MHz, Offset 15
sr0: scsi3-mmc drive: 0x/0x caddy
sr 0:0:3:0: Attached scsi CD-ROM sr0
DC390: Target 4: Sync transfer 2.1 MHz, Offset 8
sr1: scsi3-mmc drive: 0x/0x caddy
sr 0:0:4:0: Attached scsi CD-ROM sr1
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
sr 0:0:3:0: Attached scsi generic sg2 type 5
sr 0:0:4:0: Attached scsi generic sg3 type 5
sd 0:0:5:0: Attached scsi generic sg4 type 0
USB Universal Host Controller Interface driver v2.3
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:07.3
PCI: Sharing IRQ 11 with 0000:00:0c.0
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x0000a400
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:07.3
PCI: Sharing IRQ 11 with 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:0c.0
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.3: irq 11, io base 0x0000a800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
/home/7eggert/l/linux/2.6.16/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbserial
/home/7eggert/l/linux/2.6.16/drivers/usb/serial/usb-serial.c: USB Serial Driver core
/home/7eggert/l/linux/2.6.16/drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
usbcore: registered new driver pl2303
/home/7eggert/l/linux/2.6.16/drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
mice: PS/2 mouse device common for all mice
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 60 -> i8042 (command) [2237]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 46 -> i8042 (parameter) [2237]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d4 -> i8042 (command) [2237]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [2237]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, AUX, 12) [2238]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [2238]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 60 -> i8042 (command) [2238]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [2238]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 60 -> i8042 (command) [2238]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [2238]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [2238]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [2239]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: ab <- i8042 (interrupt, KBD, 1) [2239]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, KBD, 1) [2239]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [2239]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [2240]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [2240]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [2241]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [2241]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [2242]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [2242]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [2242]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [2242]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [2243]
input: AT Translated Set 2 keyboard as /class/input/input0
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 60 -> i8042 (command) [2244]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [2244]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d4 -> i8042 (command) [2244]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [2244]
input: PC Speaker as /class/input/input1
i2c /dev entries driver
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, AUX, 12) [2244]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [2245]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 60 -> i8042 (command) [2567]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [2567]
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.5
wbsd: Copyright(c) Pierre Ossman
es1371: version v0.32 time 20:53:46 Mar 26 2006
PCI: Found IRQ 9 for device 0000:00:0d.0
PCI: Sharing IRQ 9 with 0000:00:09.0
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xc800 irq 9
ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
SCTP: Hash tables configured (established 16384 bind 32768)
Using IPI Shortcut mode
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding 120476k swap on /dev/hdb4.  Priority:2 extents:1 across:120476k
EXT2-fs: quota operations not supported.
EXT2-fs: quota operations not supported.
ReiserFS: hdb6: found reiserfs format "3.6" with standard journal
ReiserFS: hdb6: using ordered data mode
ReiserFS: hdb6: journal params: device hdb6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb6: checking transaction log (hdb6)
ReiserFS: hdb6: Using r5 hash to sort names
ReiserFS: hdb7: found reiserfs format "3.6" with standard journal
ReiserFS: hdb7: using ordered data mode
ReiserFS: hdb7: journal params: device hdb7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb7: checking transaction log (hdb7)
ReiserFS: hdb7: Using r5 hash to sort names
ReiserFS: hdb8: found reiserfs format "3.6" with standard journal
ReiserFS: hdb8: using ordered data mode
ReiserFS: hdb8: journal params: device hdb8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb8: checking transaction log (hdb8)
ReiserFS: hdb8: Using r5 hash to sort names
ReiserFS: dm-0: found reiserfs format "3.5" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
ReiserFS: dm-0: using 3.5.x disk format
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
PCI: Found IRQ 11 for device 0000:00:0a.0
bttv0: Bt848 (rev 18) at 0000:00:0a.0, irq: 11, latency: 32, mmio: 0xeb000000
bttv0: using: Terratec TerraTV+ Version 1.1 (bt878) [card=28,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
tuner 5-0060: All bytes are equal. It is not a TEA5767
tuner 5-0060: chip found @ 0xc0 (bt848 #0 [sw])
bttv0: tea5757: read timeout
bttv0: using tuner=5
tuner 5-0060: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
bttv: Overlay support disabled.
bttv0: registered device video0
bttv0: registered device vbi0
input: Multisystem joystick (2 fire) as /class/input/input2
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdd: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [18896]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [18896]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 20 -> i8042 (kbd-data) [18896]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [18897]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [25129]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [25257]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [25266]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [25275]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, KBD, 1) [25281]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, KBD, 1) [25300]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [25305]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 16 <- i8042 (interrupt, KBD, 1) [25349]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 96 <- i8042 (interrupt, KBD, 1) [25365]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, KBD, 1) [25407]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, KBD, 1) [25423]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, KBD, 1) [25439]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, KBD, 1) [25465]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [25480]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, KBD, 1) [25503]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, KBD, 1) [25520]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [25525]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, KBD, 1) [25546]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 93 <- i8042 (interrupt, KBD, 1) [25560]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, KBD, 1) [25578]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, KBD, 1) [25597]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2e <- i8042 (interrupt, KBD, 1) [25659]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: ae <- i8042 (interrupt, KBD, 1) [25682]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 25 <- i8042 (interrupt, KBD, 1) [25694]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: a5 <- i8042 (interrupt, KBD, 1) [25707]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [25764]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [25783]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [30158]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [30158]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) [30158]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [30159]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 38 <- i8042 (interrupt, KBD, 1) [37188]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 3b <- i8042 (interrupt, KBD, 1) [37219]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: b8 <- i8042 (interrupt, KBD, 1) [37230]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: bb <- i8042 (interrupt, KBD, 1) [37242]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37357]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [37357]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37358]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [37358]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37381]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d0 <- i8042 (interrupt, KBD, 1) [37382]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37382]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [37383]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37468]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [37468]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37469]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 4b <- i8042 (interrupt, KBD, 1) [37469]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37494]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: cb <- i8042 (interrupt, KBD, 1) [37495]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37496]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [37497]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37551]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [37552]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37552]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 48 <- i8042 (interrupt, KBD, 1) [37553]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37573]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: c8 <- i8042 (interrupt, KBD, 1) [37574]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37575]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [37576]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37623]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [37623]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37624]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 48 <- i8042 (interrupt, KBD, 1) [37624]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37642]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: c8 <- i8042 (interrupt, KBD, 1) [37643]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37644]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [37645]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37662]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [37663]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37663]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 48 <- i8042 (interrupt, KBD, 1) [37664]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37679]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: c8 <- i8042 (interrupt, KBD, 1) [37680]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37680]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [37681]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37699]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [37700]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37700]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 48 <- i8042 (interrupt, KBD, 1) [37701]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37731]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: c8 <- i8042 (interrupt, KBD, 1) [37732]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37732]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [37733]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37790]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [37790]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37791]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 4d <- i8042 (interrupt, KBD, 1) [37791]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37824]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: cd <- i8042 (interrupt, KBD, 1) [37825]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [37825]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [37826]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [37936]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [37955]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 1d <- i8042 (interrupt, KBD, 1) [39081]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 3a <- i8042 (interrupt, KBD, 1) [39090]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2d <- i8042 (interrupt, KBD, 1) [39110]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 9d <- i8042 (interrupt, KBD, 1) [39128]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: ad <- i8042 (interrupt, KBD, 1) [39137]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: ba <- i8042 (interrupt, KBD, 1) [39138]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, KBD, 1) [39490]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, KBD, 1) [39509]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, KBD, 1) [39562]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, KBD, 1) [39578]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, KBD, 1) [39623]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, KBD, 1) [39644]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, KBD, 1) [39686]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, KBD, 1) [39705]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 22 <- i8042 (interrupt, KBD, 1) [39770]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, KBD, 1) [39783]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 39 <- i8042 (interrupt, KBD, 1) [39816]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: b9 <- i8042 (interrupt, KBD, 1) [39830]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [39898]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 38 <- i8042 (interrupt, KBD, 1) [39899]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 56 <- i8042 (interrupt, KBD, 1) [39925]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d6 <- i8042 (interrupt, KBD, 1) [39948]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [39958]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: b8 <- i8042 (interrupt, KBD, 1) [39959]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, KBD, 1) [40016]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, KBD, 1) [40032]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [40103]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [40110]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43416]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [43417]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43417]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43418]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43545]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43546]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43554]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43554]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43562]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43563]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43571]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43571]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43580]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43580]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43588]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43589]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43597]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43597]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43605]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43606]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43614]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43615]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43623]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43623]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43631]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43632]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43640]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43640]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43649]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43649]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43657]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43658]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43666]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, KBD, 1) [43666]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43673]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d0 <- i8042 (interrupt, KBD, 1) [43674]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [43675]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [43676]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [44678]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [44679]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [44679]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [44680]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [44715]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d1 <- i8042 (interrupt, KBD, 1) [44716]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [44716]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [44717]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [45461]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [45461]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [45462]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [45462]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [45500]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d1 <- i8042 (interrupt, KBD, 1) [45501]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [45501]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [45502]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50446]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [50447]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50447]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50448]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50575]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50576]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50584]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50584]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50593]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50593]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50601]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50602]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50610]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50610]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50618]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50619]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50627]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50627]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50636]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50636]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50644]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50645]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50653]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50653]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50661]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50662]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50670]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 51 <- i8042 (interrupt, KBD, 1) [50671]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50677]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d1 <- i8042 (interrupt, KBD, 1) [50678]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [50678]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [50679]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 10 <- i8042 (interrupt, KBD, 1) [51281]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 90 <- i8042 (interrupt, KBD, 1) [51292]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [51619]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [51620]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [51620]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 48 <- i8042 (interrupt, KBD, 1) [51621]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [51648]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: c8 <- i8042 (interrupt, KBD, 1) [51649]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [51650]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [51651]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 0e <- i8042 (interrupt, KBD, 1) [51726]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 8e <- i8042 (interrupt, KBD, 1) [51745]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 0e <- i8042 (interrupt, KBD, 1) [51763]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 8e <- i8042 (interrupt, KBD, 1) [51786]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [51860]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 56 <- i8042 (interrupt, KBD, 1) [51883]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [51901]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: d6 <- i8042 (interrupt, KBD, 1) [51903]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 39 <- i8042 (interrupt, KBD, 1) [51956]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: b9 <- i8042 (interrupt, KBD, 1) [51979]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [52196]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 38 <- i8042 (interrupt, KBD, 1) [52196]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 1b <- i8042 (interrupt, KBD, 1) [52208]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [52217]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: b8 <- i8042 (interrupt, KBD, 1) [52219]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 9b <- i8042 (interrupt, KBD, 1) [52231]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [52277]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, KBD, 1) [52326]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 88 <- i8042 (interrupt, KBD, 1) [52342]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [52345]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, KBD, 1) [52486]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, KBD, 1) [52507]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, KBD, 1) [52528]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, KBD, 1) [52547]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 19 <- i8042 (interrupt, KBD, 1) [52624]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 99 <- i8042 (interrupt, KBD, 1) [52645]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, KBD, 1) [52728]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, KBD, 1) [52750]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 09 <- i8042 (interrupt, KBD, 1) [52751]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 88 <- i8042 (interrupt, KBD, 1) [52767]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 89 <- i8042 (interrupt, KBD, 1) [52768]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: aa <- i8042 (interrupt, KBD, 1) [52808]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 0e <- i8042 (interrupt, KBD, 1) [52885]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 8e <- i8042 (interrupt, KBD, 1) [52899]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, KBD, 1) [53131]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, KBD, 1) [53149]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, KBD, 1) [53212]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, KBD, 1) [53226]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, KBD, 1) [53231]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, KBD, 1) [53249]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, KBD, 1) [53282]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, KBD, 1) [53301]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 22 <- i8042 (interrupt, KBD, 1) [53356]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, KBD, 1) [53372]
/home/7eggert/l/linux/2.6.16/drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [53555]
-- 
Justify my text? I'm sorry but it has no excuse. 
