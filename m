Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWIMH1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWIMH1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 03:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWIMH1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 03:27:10 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:36806 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1750948AbWIMH1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 03:27:07 -0400
Message-ID: <4507B31A.8010001@rebelhomicide.demon.nl>
Date: Wed, 13 Sep 2006 09:28:26 +0200
From: Michiel de Boer <x@rebelhomicide.demon.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Ben B <kernel@bb.cactii.net>
CC: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: speedstep-centrino broke
References: <20060912193810.GA20226@cactii.net>
In-Reply-To: <20060912193810.GA20226@cactii.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben B wrote:
> Hi,
>
> My HP notebook decided that its BIOS upgrade would break
> speedstep-centrino, and trying to load the module gives me a "no such
> device" error. This is with various combinations of kernel config
> relating to cpufreq. Also tried acpi-cpufreq with the same error.
>
> I suspect that the new bios is broken, but perhaps it's correct and the
> linux driver is missing something?
>
> Anyway, relevent info below.
>
> Cheers,
> Ben
>   

I have the same problem, running kernel 2.6.17.13, and also get the 'No 
such device' error.
This problem doesn't occur when i boot 2.6.16.16, so the behaviour must 
have been introduced
somewhere in between.

Does it have anything to do with this thread? 
http://lkml.org/lkml/2004/8/6/12

Regards, Michiel de Boer

Here's my relevant info:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.80GHz
stepping        : 6
cpu MHz         : 1794.431
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov 
pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe up est tm2
bogomips        : 3591.62

dmesg:

<cut off>nterrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 6 (level, low) 
-> IRQ 6
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK1032GAX, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITADVD-RAM UJ-831S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 195371568 sectors (100030 MB), CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
3ware Storage Controller device driver for Linux v1.26.02.001.
3ware 9000 Storage Controller device driver for Linux v2.26.02.007.
libata version 1.20 loaded.
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOU2] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  4760.000 MB/sec
raid5: using function: pIII_sse (4760.000 MB/sec)
raid6: int32x1    592 MB/s
raid6: int32x2    693 MB/s
raid6: int32x4    524 MB/s
raid6: int32x8    471 MB/s
raid6: mmxx1     1639 MB/s
raid6: mmxx2     2051 MB/s
raid6: sse1x1    1298 MB/s
raid6: sse1x2    2138 MB/s
raid6: sse2x1    2207 MB/s
raid6: sse2x2    2626 MB/s
raid6: using algorithm sse2x2 (2626 MB/s)
md: raid6 personality registered for level 6
md: multipath personality registered for level -4
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
device-mapper: dm-multipath version 1.0.4 loaded
device-mapper: dm-round-robin version 1.0.0 loaded
device-mapper: dm-emc version 0.0.3 loaded
EDAC MC: Ver: 2.0.0 Sep  9 2006
EISA: Probing bus 0 at eisa.0
Cannot allocate resource for EISA slot 1
Cannot allocate resource for EISA slot 2
Cannot allocate resource for EISA slot 3
Cannot allocate resource for EISA slot 4
EISA: Detected 0 cards.
NET: Registered protocol family 1
Using IPI No-Shortcut mode
Suspend2 Core.
Suspend2 Compression Driver loading.
Suspend2 Encryption Driver loading.
Suspend2 Swap Writer loading.
Suspend2 FileWriter loading.
Replacing swsusp.
Suspend2 2.2.7.5: You need to use a resume2= command line parameter to 
tell Suspend2 where to look for an image.
Suspend2 2.2.7.5: Resume2 parameter is empty. Suspending will be disabled.
Suspend2 2.2.7.5: Missing or invalid storage location (resume2= 
parameter). Please correct and rerun lilo (or equivalent) before suspending.
ACPI wakeup devices:
GLAN MPCI T394 MDM0 USB1 USB2 USB3
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 308k freed
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
input: AT Translated Set 2 keyboard as /class/input/input0
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@linux.intel.com>
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
tg3.c:v3.59.1 (August 25, 2006)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKD] -> GSI 6 (level, low) 
-> IRQ 6
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 
10/100/1000BaseT Ethernet 00:c0:9f:6f:3a:fe
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] 
TSOcap[1]
eth0: dma_rwctrl[763f0000] dma_mask[64-bit]
NET: Registered protocol family 23
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [LNKC] -> GSI 6 (level, low) 
-> IRQ 6
Yenta: CardBus bridge found at 0000:02:06.0 [1025:0051]
Yenta O2: res at 0x94/0xD4: ea/00
Yenta O2: enabling read prefetch/write burst
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
Linux agpgart interface v0.101 (c) Dave Jones
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.1.1
ipw2200: Copyright(c) 2003-2006 Intel Corporation
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Yenta: ISA IRQ mask 0x0c38, PCI irq 6
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd07fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x35ffffff
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKE] -> GSI 10 (level, 
low) -> IRQ 10
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
USB Universal Host Controller Interface driver v3.0
Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713/0x4006
input: SynPS/2 Synaptics TouchPad as /class/input/input1
nsc-ircc, chip->init
nsc-ircc, Found chip at base=0x04e
nsc-ircc, driver loaded (Dag Brattli)
nsc_ircc_open(), can't get iobase of 0x2f8
nsc-ircc, Found chip at base=0x04e
nsc-ircc, driver loaded (Dag Brattli)
nsc_ircc_open(), can't get iobase of 0x2f8
ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 6
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 6 (level, low) 
-> IRQ 6
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 6, io base 0x00001800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
pnp: Device 00:0a disabled.
ACPI: PCI Interrupt 0000:02:06.1[A] -> Link [LNKC] -> GSI 6 (level, low) 
-> IRQ 6
Yenta: CardBus bridge found at 0000:02:06.1 [1025:0051]
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 6 (level, low) 
-> IRQ 6
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 6, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Yenta: ISA IRQ mask 0x0838, PCI irq 6
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd07fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x35ffffff
ACPI: PCI Interrupt 0000:02:06.3[A] -> Link [LNKC] -> GSI 6 (level, low) 
-> IRQ 6
Yenta: CardBus bridge found at 0000:02:06.3 [1025:0051]
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 6 (level, low) 
-> IRQ 6
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 6, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ieee1394: Initialized config rom entry `ip1394'
ts: Compaq touchscreen protocol output
Yenta: ISA IRQ mask 0x0838, PCI irq 6
Socket status: 30000410
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd07fffff
usb 2-1: new low speed USB device using uhci_hcd and address 2
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x35ffffff
agpgart: Detected an Intel 855GM Chipset.
agpgart: AGP aperture is 256M @ 0xe0000000
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 10, io mem 0xd0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 2-1: device descriptor read/all, error -71
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
pccard: PCMCIA card inserted into slot 2
usb 4-6: new high speed USB device using ehci_hcd and address 3
cs: memory probe 0xd0200000-0xd07fffff: excluding 0xd0200000-0xd025ffff
pcmcia: registering new device pcmcia2.0
usb 4-6: configuration #1 chosen from 1 choice
hub 4-6:1.0: USB hub found
hub 4-6:1.0: 4 ports detected
cs: IO port probe 0x100-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
intel8x0_measure_ac97_clock: measured 104808 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  
MMIO=[d0218000-d02187ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
hw_random: RNG not detected
usb 2-1: new low speed USB device using uhci_hcd and address 4
usb 2-1: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
input: Logitech Optical USB Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on 
usb-0000:00:1d.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Adding 497972k swap on /dev/hda5.  Priority:-1 extents:1 across:497972k
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f000034bb39]
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
Capability LSM initialized
fuse init (API version 7.6)
input: PC Speaker as /class/input/input3
NTFS driver 2.1.27 [Flags: R/W MODULE].
NTFS volume version 3.1.
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
PM: Writing back config space on device 0000:02:02.0 at offset c (was 
ffef0000, writing 0)
PM: Writing back config space on device 0000:02:02.0 at offset b (was 
165d14e4, writing 511025)
PM: Writing back config space on device 0000:02:02.0 at offset 3 (was 0, 
writing 4008)
PM: Writing back config space on device 0000:02:02.0 at offset 2 (was 
2000000, writing 2000003)
PM: Writing back config space on device 0000:02:02.0 at offset 1 (was 
2b00000, writing 2b00106)
PM: Writing back config space on device 0000:02:02.0 at offset 0 (was 
165d14e4, writing 165314e4)
NET: Registered protocol family 17
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Thermal Zone [THRM] (51 C)
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
lp0: using parport0 (interrupt-driven).
lp0: console ready
ppdev: user-space parallel port driver
ttyS1: LSR safety check engaged!
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 6 (level, low) 
-> IRQ 6
[drm] Initialized radeon 1.24.0 20060225 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
.
# dmidecode 2.8
SMBIOS 2.31 present.
27 structures occupying 1207 bytes.
Table at 0x000DF810.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
    Vendor: ACER  
    Version: 3A20
    Release Date: 01/31/2005
    Address: 0xE5240
    Runtime Size: 110016 bytes
    ROM Size: 512 kB
    Characteristics:
        ISA is supported
        PCI is supported
        PC Card (PCMCIA) is supported
        PNP is supported
        APM is supported
        BIOS is upgradeable
        BIOS shadowing is allowed
        ESCD support is available
        Boot from CD is supported
        3.5"/720 KB floppy services are supported (int 13h)
        Print screen service is supported (int 5h)
        8042 keyboard services are supported (int 9h)
        Serial services are supported (int 14h)
        Printer services are supported (int 17h)
        ACPI is supported
        USB legacy is supported
        AGP is supported
        Smart battery is supported
        BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
    Manufacturer: Acer
    Product Name: TravelMate 8000
    Version: Rev 1                  
    Serial Number: xxxxxxxxxxxxx
    UUID: xxxxxxxxxxxxxx
    Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
    Manufacturer: Acer
    Product Name: TravelMate 8000
    Version: Rev 1.0                
    Serial Number: xxxxxxxxxxxxx

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
    Manufacturer: Acer
    Type: Notebook
    Lock: Not Present
    Version: Rev.1                  
    Serial Number: xxxxxxxxxxxxxx
    Asset Tag: ................................    
    Boot-up State: Safe
    Power Supply State: Safe
    Thermal State: Safe
    Security Status: None
    OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
    Socket Designation: uFCPGA2
    Type: Central Processor
    Family: Unknown
    Manufacturer: Intel
    ID: D6 06 00 00 BF F9 E9 AF
    Version: Intel(R) Pentium(R) M processor
    Voltage: 1.2 V
    External Clock: 400 MHz
    Max Speed: 1800 MHz
    Current Speed: 1800 MHz
    Status: Populated, Enabled
    Upgrade: ZIF Socket
    L1 Cache Handle: 0x0008
    L2 Cache Handle: 0x0009
    L3 Cache Handle: Not Provided
    Serial Number: Not Specified
    Asset Tag: Not Specified
    Part Number: Not Specified

Handle 0x0005, DMI type 5, 20 bytes
Memory Controller Information
    Error Detecting Method: None
    Error Correcting Capabilities:
        None
    Supported Interleave: One-way Interleave
    Current Interleave: One-way Interleave
    Maximum Memory Module Size: 1024 MB
    Maximum Total Memory Size: 2048 MB
    Supported Speeds:
        60 ns
    Supported Memory Types:
        DIMM
    Memory Module Voltage: 3.3 V
    Associated Memory Slots: 2
        0x0006
        0x0007
    Enabled Error Correcting Capabilities:
        None

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
    Socket Designation: DIMM 1
    Bank Connections: 0 1
    Current Speed: 75 ns
    Type: DIMM SDRAM
    Installed Size: Not Installed
    Enabled Size: Not Installed
    Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes
Memory Module Information
    Socket Designation: DIMM 2
    Bank Connections: 2 3
    Current Speed: 75 ns
    Type: DIMM SDRAM
    Installed Size: 512 MB (Double-bank Connection)
    Enabled Size: 512 MB (Double-bank Connection)
    Error Status: OK

Handle 0x0008, DMI type 7, 19 bytes
Cache Information
    Socket Designation: L1 Cache
    Configuration: Enabled, Not Socketed, Level 1
    Operational Mode: Write Back
    Location: Internal
    Installed Size: 32 KB
    Maximum Size: 32 KB
    Supported SRAM Types:
        Burst
        Pipeline Burst
        Asynchronous
    Installed SRAM Type: Asynchronous
    Speed: Unknown
    Error Correction Type: Unknown
    System Type: Unknown
    Associativity: Unknown

Handle 0x0009, DMI type 7, 19 bytes
Cache Information
    Socket Designation: L2 Cache
    Configuration: Enabled, Not Socketed, Level 2
    Operational Mode: Write Back
    Location: External
    Installed Size: 2048 KB
    Maximum Size: 2048 KB
    Supported SRAM Types:
        Burst
        Pipeline Burst
        Asynchronous
    Installed SRAM Type: Burst
    Speed: Unknown
    Error Correction Type: Unknown
    System Type: Unknown
    Associativity: Unknown

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: LPT 1
    Internal Connector Type: None
    External Reference Designator: Parallel
    External Connector Type: DB-25 female
    Port Type: Parallel Port ECP/EPP

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: U28
    Internal Connector Type: None
    External Reference Designator: PS/2 Mouse
    External Connector Type: Circular DIN-8 male
    Port Type: Keyboard Port

Handle 0x000C, DMI type 9, 13 bytes
System Slot Information
    Designation: PCMCIA socket 0
    Type: 32-bit PC Card (PCMCIA)
    Current Usage: Unknown
    Length: Long
    ID: Adapter 0, Socket 0
    Characteristics:
        5.0 V is provided
        3.3 V is provided
        PC Card-16 is supported
        Cardbus is supported
        Modem ring resume is supported
        PME signal is supported
        Hot-plug devices are supported

Handle 0x000D, DMI type 10, 10 bytes
On Board Device 1 Information
    Type: Video
    Status: Disabled
    Description: ATI M11
On Board Device 2 Information
    Type: Sound
    Status: Disabled
    Description: AC97 Audio
On Board Device 3 Information
    Type: Other
    Status: Disabled
    Description: TI TSB43AB21 IEEE-1394 Controller

Handle 0x000E, DMI type 11, 5 bytes
OEM Strings
    String 1: SMBIOS 2.3
    String 2: Customer Reference Platform

Handle 0x000F, DMI type 12, 5 bytes
System Configuration Options
    Option 1: No Jumper On This Platform.

Handle 0x0010, DMI type 15, 29 bytes
System Event Log
    Area Length: 0 bytes
    Header Start Offset: 0x0000
    Header Length: 16 bytes
    Data Start Offset: 0x0010
    Access Method: Memory-mapped physical 32-bit address
    Access Address: 0x00000000
    Status: Invalid, Not Full
    Change Token: 0x00000000
    Header Format: Type 1
    Supported Log Type Descriptors: 3
    Descriptor 1: POST error
    Data Format 1: POST results bitmap
    Descriptor 2: Single-bit ECC memory error
    Data Format 2: Multiple-event
    Descriptor 3: Multi-bit ECC memory error
    Data Format 3: Multiple-event

Handle 0x0011, DMI type 16, 15 bytes
Physical Memory Array
    Location: System Board Or Motherboard
    Use: System Memory
    Error Correction Type: None
    Maximum Capacity: 3 GB
    Error Information Handle: Not Provided
    Number Of Devices: 2

Handle 0x0012, DMI type 17, 27 bytes
Memory Device
    Array Handle: 0x0011
    Error Information Handle: No Error
    Total Width: Unknown
    Data Width: Unknown
    Size: No Module Installed
    Form Factor: DIMM
    Set: 1
    Locator: DIMM 0
    Bank Locator: Bank 0, 1
    Type: SRAM
    Type Detail: Synchronous
    Speed: 333 MHz (3.0 ns)
    Manufacturer: Not Specified
    Serial Number: Not Specified
    Asset Tag: Not Specified
    Part Number: Not Specified

Handle 0x0013, DMI type 17, 27 bytes
Memory Device
    Array Handle: 0x0011
    Error Information Handle: No Error
    Total Width: 64 bits
    Data Width: 64 bits
    Size: 512 MB
    Form Factor: DIMM
    Set: 1
    Locator: DIMM 1
    Bank Locator: Bank 2, 3
    Type: SRAM
    Type Detail: Synchronous
    Speed: 333 MHz (3.0 ns)
    Manufacturer: Not Specified
    Serial Number: Not Specified
    Asset Tag: Not Specified
    Part Number: Not Specified

Handle 0x0014, DMI type 19, 15 bytes
Memory Array Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x0001FFFFFFF
    Range Size: 512 MB
    Physical Array Handle: 0x0011
    Partition Width: 0

Handle 0x0015, DMI type 20, 19 bytes
Memory Device Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x000000003FF
    Range Size: 1 kB
    Physical Device Handle: 0x0012
    Memory Array Mapped Address Handle: 0x0014
    Partition Row Position: 1
    Interleave Position: 1

Handle 0x0016, DMI type 20, 19 bytes
Memory Device Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x0001FFFFFFF
    Range Size: 512 MB
    Physical Device Handle: 0x0013
    Memory Array Mapped Address Handle: 0x0014
    Partition Row Position: 1
    Interleave Position: 1

Handle 0x0017, DMI type 21, 7 bytes
Built-in Pointing Device
    Type: Mouse
    Interface: PS/2
    Buttons: 2

Handle 0x0018, DMI type 22, 26 bytes
Portable Battery
    Location: Right Side
    Manufacturer: Sanyo
    Name: Sanyo
    Chemistry: Lithium Ion
    Design Capacity: 4400 mWh
    Design Voltage: 14800 mV
    SBDS Version: Bat123
    Maximum Error: 100%
    SBDS Serial Number: 04D2
    SBDS Manufacture Date: 1985-08-25
    OEM-specific Information: 0x00000000

Handle 0x0019, DMI type 32, 20 bytes
System Boot Information
    Status: <OUT OF SPEC>

Handle 0x001A, DMI type 127, 4 bytes
End Of Table



