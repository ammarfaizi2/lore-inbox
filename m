Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264902AbUGIKA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUGIKA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbUGIKAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:00:52 -0400
Received: from ezoffice.mandrakesoft.com ([212.11.15.34]:32139 "EHLO
	ezoffice.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S264819AbUGIJzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:55:39 -0400
From: Thibauld Favre <tfavre@mandrakesoft.com>
Reply-To: tfavre@mandrakesoft.com
Organization: Mandrakesoft
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.7 : kernel panic while ripping CD
Date: Fri, 9 Jul 2004 11:57:20 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Awm7AOYdjESRh/m"
Message-Id: <200407091157.20508.tfavre@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Awm7AOYdjESRh/m
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

When I rip a CD (I use kaudiocreator), I cannot rip all tracks in one go. When 
I do so, after a while (as far as I can say there's no logic) I can hear the 
CDrom drive stop and the ripping stalls. If I kill the process that stalled 
(the only thing I can do), then I get a bad kernel panic. So basically, when 
the ripping stalls I'm done ! I can continue working without problems but as 
soon as I want to close kaudiocreator : badaboom.

I first thought it could come from kaudiocreator but then I realized that my 
CDrom drive was generating errors. Here's a summary of the interesting parts 
(the full dmesg and lsmod output can be found as attachments).

----------------------------------------------------------------
hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
[...]
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: UJDA745 DVD/CDRW  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
[...]
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
spurious 8259A interrupt: IRQ7.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: status error: error=0x00
hdc: drive not ready for command
hdc: lost interrupt
hdc: lost interrupt
hdc: DMA disabled
hdc: ATAPI reset complete
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 8 
lun 0
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 8 
lun 0
sr0: CDROM (ioctl) error, command: 0x42 02 40 01 00 00 00 00 10 00
sr: sense =  0  0
Non-extended sense class 0 code 0x0
Raw sense data:0x00 0x00 0x00 0x00
sr0: CDROM (ioctl) error, command: 0x42 02 40 01 00 00 00 00 10 00
sr: sense =  0  0
Non-extended sense class 0 code 0x0
Raw sense data:0x00 0x00 0x00 0x00
------------------------------------------------------------------------

I use a Debian unstable on a T40p laptop with a self compiled 2.6.7 kernel. I 
access my CD-rom drive through /dev/sr0 I'd like to be able to help further 
but I don't know what might interest you. Just ask me if you need more 
info...

Thanks a lot,

Thibauld Favre

--Boundary-00=_Awm7AOYdjESRh/m
Content-Type: text/plain;
  charset="us-ascii";
  name="cdrom-error.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cdrom-error.txt"

Linux version 2.6.7 (root@simbad) (version gcc 3.2.3 (Debian)) #2 Wed Jun 16 22:58:48 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff78000 (ACPI data)
 BIOS-e820: 000000001ff78000 - 000000001ff7a000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130912
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126816 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux ro root=307 video=radeonfb
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1594.822 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 516232k/523648k available (1410k kernel code, 6648k reserved, 634k data, 108k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3153.92 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9f9bf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 144k freed
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/24cc] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:02.0
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Initializing Cryptographic API
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xd0000000
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:02.0
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS05-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 71973874 sectors (36850 MB)
	native  capacity is 78140160 sectors (40007 MB)
hda: 71973874 sectors (36850 MB) w/7898KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
RAMDISK: Compressed image found at block 0
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 108k freed
Adding 196520k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda7, internal journal
Real Time Clock Driver v1.12
Intel 810 + AC97 Audio, version 1.01, 17:26:18 Jun 19 2004
PCI: Found IRQ 11 for device 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:02:00.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH4 found at IO 0x18c0 and 0x1c00, MEM 0xc0000c00 and 0xc0000800, IRQ 11
i810: Intel ICH4 mmio at 0xe0861c00 and 0xe0868800
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
i810_audio: setting clocking to 48566
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
PCI: Found IRQ 11 for device 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:02:00.1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Found IRQ 11 for device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem e0875000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
SCSI subsystem initialized
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: UJDA745 DVD/CDRW  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB modems and ISDN adapters
thinkpad: I have registered to handle major: 10 minor: 170.
smapi: 32-bit protected mode SMAPI BIOS found. :-)
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 44
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:02:01.0
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.1
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:02:02.0
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 5.0
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
Non-volatile memory driver v1.2
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
PCI: Found IRQ 11 for device 0000:02:01.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:00.0
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.9.3
wlan: 0.7.3.2 BETA
ath_pci: 0.8.5.5 BETA
ath_pci: 0.8.5.5 BETA
PCI: Found IRQ 11 for device 0000:02:02.0
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
Setup queue (0) for WME_AC_BK
Setup queue (0) for WME_AC_BE
Setup queue (0) for WME_AC_VI
Setup queue (0) for WME_AC_VO
ath0: mac 4.2 phy 3.0 5ghz radio 1.7 2ghz radio 2.3
ath0: 11a rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: 802.11 address: 00:05:4e:40:d1:04
ath0: Atheros 5211: mem=0xc0210000, irq=11
thinkpadpm: Found APM BIOS version 1.2 flags 0x03 entry 0xb8:0x5703. :-)
rtcmosram: I/O ports for RT CMOS RAM not available, but ignoring this.
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
NTFS driver 2.1.14 [Flags: R/W MODULE].
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:01.0
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.0, mfunc 0x01d21022, devctl 0x64
Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:02:00.1
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:00:1f.6
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.1, mfunc 0x01d21022, devctl 0x64
Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Socket status: 30000006
ttyS0: LSR safety check engaged!
ttyS0: LSR safety check engaged!
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
smapi: SMAPI BIOS return codes differ!
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
[drm] Loading R200 Microcode
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
spurious 8259A interrupt: IRQ7.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d 
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: status error: error=0x00
hdc: drive not ready for command
hdc: lost interrupt
hdc: lost interrupt
hdc: DMA disabled
hdc: ATAPI reset complete
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 8 lun 0
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 8 lun 0
sr0: CDROM (ioctl) error, command: 0x42 02 40 01 00 00 00 00 10 00 
sr: sense =  0  0
Non-extended sense class 0 code 0x0
Raw sense data:0x00 0x00 0x00 0x00 
sr0: CDROM (ioctl) error, command: 0x42 02 40 01 00 00 00 00 10 00 
sr: sense =  0  0
Non-extended sense class 0 code 0x0
Raw sense data:0x00 0x00 0x00 0x00 

--Boundary-00=_Awm7AOYdjESRh/m
Content-Type: text/plain;
  charset="us-ascii";
  name="modules-list.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="modules-list.txt"

Module                  Size  Used by
snd_intel8x0           30408  0 
snd_ac97_codec         67204  1 snd_intel8x0
snd_pcm                86976  1 snd_intel8x0
snd_timer              21632  1 snd_pcm
snd_page_alloc          9096  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         6336  1 snd_intel8x0
snd_rawmidi            20448  1 snd_mpu401_uart
snd_seq_device          6468  1 snd_rawmidi
yenta_socket           18432  0 
ds                     14208  4 
pcmcia_core            52224  2 yenta_socket,ds
msdos                   8064  0 
ntfs                  120212  0 
nls_iso8859_1           3712  0 
autofs4                16964  1 
radeon                128836  44 
rtcmosram               3716  0 
thinkpadpm              4936  0 
ath_pci                40144  0 
wlan                   60392  2 ath_pci
ath_hal               128784  2 ath_pci
usbhid                 23680  0 
e1000                  82048  0 
nvram                   7816  0 
visor                  16144  0 
usbserial              23268  1 visor
usb_storage            58448  0 
freq_table              3204  0 
ide_cd                 39104  0 
vfat                   11968  0 
fat                    40288  2 msdos,vfat
uhci_hcd               29832  0 
sr_mod                 14112  1 
cdrom                  37536  2 ide_cd,sr_mod
sg                     23952  0 
psmouse                18888  0 
evdev                   7296  0 
smapi                   4292  0 
thinkpad                5956  3 rtcmosram,thinkpadpm,smapi
cdc_acm                 8416  0 
ide_scsi               14340  2 
cpufreq_powersave       1344  0 
sd_mod                 17088  0 
scsi_mod               66080  5 usb_storage,sr_mod,sg,ide_scsi,sd_mod
ehci_hcd               26624  0 
usbcore               100628  9 usbhid,visor,usbserial,usb_storage,uhci_hcd,cdc_acm,ehci_hcd
8250_pci               16384  0 
8250                   18176  1 8250_pci
serial_core            19840  1 8250
i810_audio             31440  1 
ac97_codec             17088  1 i810_audio
snd_mixer_oss          17728  0 
snd                    46724  8 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_mixer_oss
rtc                    10600  0 

--Boundary-00=_Awm7AOYdjESRh/m--
