Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbTIFQZe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 12:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTIFQZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 12:25:34 -0400
Received: from cm68240.red.mundo-r.com ([213.60.68.240]:23168 "EHLO
	euclides.hn.org") by vger.kernel.org with ESMTP id S261327AbTIFQYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 12:24:55 -0400
From: Momes <momes@mundo-r.com>
To: Greg KH <greg@kroah.com>
Subject: Re: USB hang
Date: Sat, 6 Sep 2003 18:24:51 +0200
User-Agent: KMail/1.5.3
References: <200309041951.37523.momes@mundo-r.com> <200309052332.10022.momes@mundo-r.com> <20030905213528.GA13018@kroah.com>
In-Reply-To: <20030905213528.GA13018@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309061824.51409.momes@mundo-r.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've enabled CONFIG_USB_DEBUG and kernel debugging. Below are dmesg and debug 
files, with and without noapic option.
I've also used "nmi_watchdog=N" and  "nmi_watchdog=1" in lilo.conf with no 
apparent result. Sorry, I don't know how to mange this feature.
Most significant thing I've found after this are two things:

1.- after this kernel modifications when the system boots with no USB device 
plugged in there is no response at the moment of plug in a device. No 
message, no hang, and device do not work.

2.-when system is hang and press the power botton this message appears:
"host/usb-ohci.c: USB suspend: usb-00.02.2
host/usb-ohci.c: USB suspend: usb-00.02.3
host/usb-ohci.c: USB continue: usb-00.02.2 from host wakeup
host/usb-ohci.c: USB continue: usb-00.02.3 from host wakeup
SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented
advanced SiS pirq mapping not  yet implemented"



===========================================================================
Here is new /var/log/dmesg without "noapic"
===========================================================================

Linux version 2.4.22-xfs-0.3momes (root@euclides.hn.org) (gcc version 3.3.2 
20030831 (Debian prerelease)) #2 SMP Sat Sep 6 15:05:56 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fbcc0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: GIGABYTE Product ID: 8SIML        APIC at: 0xFEE00000
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: BOOT_IMAGE=2.4.22 ro root=302 hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 2390.333 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 4771.02 BogoMIPS
Memory: 514700k/524224k available (2082k kernel code, 9136k reserved, 667k 
data, 136k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
per-CPU timeslice cutoff: 1462.86 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-19, 2-22 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 22.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 001 01  1    1    0   1   0    1    1    91
 11 001 01  1    1    0   1   0    1    1    99
 12 001 01  1    1    0   1   0    1    1    A1
 13 000 00  1    0    0   0   0    0    0    00
 14 001 01  1    1    0   1   0    1    1    A9
 15 001 01  1    1    0   1   0    1    1    B1
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    B9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2390.4954 MHz.
..... host bus clock speed is 99.6038 MHz.
cpu: 0, clocks: 996038, slice: 498019
CPU0<T0:996032,T1:498000,D:13,S:498019,C:996038>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdb21, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
PCI->APIC IRQ transform: (B0,I2,P3) -> 20
PCI->APIC IRQ transform: (B0,I2,P0) -> 18
PCI->APIC IRQ transform: (B0,I2,P2) -> 21
PCI->APIC IRQ transform: (B0,I2,P2) -> 21
PCI->APIC IRQ transform: (B0,I9,P0) -> 17
PCI->APIC IRQ transform: (B0,I11,P0) -> 18
PCI->APIC IRQ transform: (B0,I16,P0) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
SGI XFS snapshot 2.4.22-2003-09-03_04:09_UTC with ACLs, no debug enabled
SGI XFS Quota Management subsystem
vesafb: framebuffer at 0xd0000000, mapped to 0xe081a000, size 6144k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected mode interface info at c000:e6d0
vesafb: scrolling: redraw
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
keyboard: Timeout - AT keyboard not present?(ed)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xe0e1bf00, 00:48:54:80:57:42, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8139B'
eth1: RealTek RTL8139 Fast Ethernet at 0xe0e1de00, 00:20:ed:b0:54:ea, IRQ 17
eth1:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 4D080H4, ATA DISK drive
blk: queue c043a1a0, I/O limit 4095Mb (mask 0xffffffff)
hdc: HL-DT-STDVD-ROM GDR8160B, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST CD-RW GCE-8240B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(100)
hdc: attached ide-scsi driver.
hdd: attached ide-scsi driver.
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HL-DT-ST  Model: DVD-ROM GDR8160B  Rev: 0009
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HL-DT-ST  Model: CD-RW GCE-8240B   Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 20x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 24x/40x writer cd/rw xa/form2 cdda tray
cs4232: Must set io, irq and dma.
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
ad1848: No ISAPnP cards found, trying standard ones...
Intel 810 + AC97 Audio, version 0.24, 14:56:56 Sep  6 2003
i810: SiS 7012 found at IO 0xc400 and 0xc800, MEM 0x0000 and 0x0000, IRQ 21
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7650 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-ohci.c: USB OHCI at membase 0xe0e1f000, IRQ 20
host/usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] USB 1.0 
Controller
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF dfdf8840, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0e1f000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: no over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfdf8840
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
host/usb-ohci.c: USB OHCI at membase 0xe0e21000, IRQ 18
host/usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] USB 1.0 
Controller (#2)
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF dfdf85c0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0e21000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: no over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfdf85c0
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cramfs: wrong magic
FAT: bogus logical sector size 0
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
XFS mounting filesystem ide0(3,2)
Ending clean XFS mount for filesystem: ide0(3,2)
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 136k freed
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 10, 12 Mb/s
hub.c: new USB device 00:02.3-1, assigned address 2
Adding Swap: 1076344k swap-space (priority -1)
usb_control/bulk_msg: timeout
host/usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: port 1, portstatus 103, change 10, 12 Mb/s
hub.c: new USB device 00:02.3-1, assigned address 3
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 
c5e1.
eth1: Setting 100mbps full-duplex based on auto-negotiated partner ability 
41e1.
usb_control/bulk_msg: timeout
host/usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=3 (error=-110)
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 2, portstatus 100, change 0, 12 Mb/s



==================================================================================
This is /var/log/debug
==================================================================================

Sep  6 14:06:57 euclides kernel: CPU:     After generic, caps: 3febfbff 
00000000 00000000 00000000
Sep  6 14:06:57 euclides kernel: CPU:             Common caps: 3febfbff 
00000000 00000000 00000000
Sep  6 14:06:57 euclides kernel: CPU:     After generic, caps: 3febfbff 
00000000 00000000 00000000
Sep  6 14:06:57 euclides kernel: CPU:             Common caps: 3febfbff 
00000000 00000000 00000000
Sep  6 14:06:57 euclides kernel: Ending clean XFS mount for filesystem: 
ide0(3,2)
Sep  6 14:06:57 euclides kernel: hub.c: usb_hub_thread exiting
Sep  6 14:07:20 euclides ntpd[634]: signal_no_reset: signal 13 had flags 
4000000
Sep  6 14:07:20 euclides ntpd[641]: signal_no_reset: signal 17 had flags 
4000000
Sep  6 14:07:21 euclides afpd[649]: [afp_config.c:471]: D5:AFPDaemon: Loading 
ConfigFile
Sep  6 14:07:21 euclides afpd[649]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_dhx.so)
Sep  6 14:07:21 euclides afpd[649]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_clrtxt.so)
Sep  6 14:07:21 euclides afpd[649]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_randnum.so)
Sep  6 14:07:21 euclides afpd[649]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_dhx.so)
Sep  6 14:07:21 euclides afpd[649]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_clrtxt.so)
Sep  6 14:07:21 euclides afpd[649]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_randnum.so)
Sep  6 14:07:21 euclides afpd[649]: [afp_config.c:500]: D5:AFPDaemon: Finished 
parsing Config File
Sep  6 14:08:03 euclides ntpd_initres[641]: signal_no_reset: signal 14 had 
flags 4000000
Sep  6 16:38:48 euclides kernel: CPU:     After generic, caps: 3febfbff 
00000000 00000000 00000000
Sep  6 16:38:48 euclides kernel: CPU:             Common caps: 3febfbff 
00000000 00000000 00000000
Sep  6 16:38:48 euclides kernel: CPU:     After generic, caps: 3febfbff 
00000000 00000000 00000000
Sep  6 16:38:48 euclides kernel: CPU:             Common caps: 3febfbff 
00000000 00000000 00000000
Sep  6 16:38:48 euclides kernel: vga16fb: initializing
Sep  6 16:38:48 euclides kernel: eth0:  Identified 8139 chip type 'RTL-8139B'
Sep  6 16:38:48 euclides kernel: eth1:  Identified 8139 chip type 'RTL-8139C'
Sep  6 16:38:48 euclides kernel: Ending clean XFS mount for filesystem: 
ide0(3,2)
Sep  6 16:39:06 euclides ntpd[835]: signal_no_reset: signal 13 had flags 
4000000
Sep  6 16:39:07 euclides ntpd[842]: signal_no_reset: signal 17 had flags 
4000000
Sep  6 16:39:50 euclides afpd[848]: [afp_config.c:471]: D5:AFPDaemon: Loading 
ConfigFile
Sep  6 16:39:56 euclides afpd[848]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_dhx.so)
Sep  6 16:39:56 euclides afpd[848]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_clrtxt.so)
Sep  6 16:39:56 euclides afpd[848]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_randnum.so)
Sep  6 16:39:56 euclides afpd[848]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_dhx.so)
Sep  6 16:39:56 euclides afpd[848]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_clrtxt.so)
Sep  6 16:39:56 euclides afpd[848]: [auth.c:553]: D5:AFPDaemon: uam: loading 
(/usr/lib/netatalk/uams_randnum.so)
Sep  6 16:39:56 euclides afpd[848]: [afp_config.c:500]: D5:AFPDaemon: Finished 
parsing Config File



======================================================================================
This is /var/log/dmesg with "noapic"
======================================================================================

Linux version 2.4.22-xfs-0.3momes (root@euclides.hn.org) (gcc version 3.3.2 
20030831 (Debian prerelease)) #2 SMP Sat Sep 6 15:05:56 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fbcc0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: GIGABYTE Product ID: 8SIML        APIC at: 0xFEE00000
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: BOOT_IMAGE=2.4.22nmi ro root=302 nmi_watchdog=1 noapic 
apm=on apm=power-off hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 2390.326 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 4771.02 BogoMIPS
Memory: 514700k/524224k available (2082k kernel code, 9136k reserved, 667k 
data, 136k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
per-CPU timeslice cutoff: 1462.86 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2390.4213 MHz.
..... host bus clock speed is 99.6008 MHz.
cpu: 0, clocks: 996008, slice: 498004
CPU0<T0:996000,T1:497984,D:12,S:498004,C:996008>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdb21, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
SGI XFS snapshot 2.4.22-2003-09-03_04:09_UTC with ACLs, no debug enabled
SGI XFS Quota Management subsystem
vesafb: framebuffer at 0xd0000000, mapped to 0xe081a000, size 6144k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected mode interface info at c000:e6d0
vesafb: scrolling: redraw
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented
keyboard: Too many NACKs -- noisy kbd cable?
keyboard: Too many NACKs -- noisy kbd cable?
advanced SiS pirq mapping not yet implemented
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 9 for device 00:0b.0
eth0: RealTek RTL8139 Fast Ethernet at 0xe0e1bf00, 00:48:54:80:57:42, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139B'
PCI: Found IRQ 10 for device 00:10.0
PCI: Sharing IRQ 10 with 00:09.0
eth1: RealTek RTL8139 Fast Ethernet at 0xe0e1de00, 00:20:ed:b0:54:ea, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 4D080H4, ATA DISK drive
blk: queue c043a1a0, I/O limit 4095Mb (mask 0xffffffff)
hdc: HL-DT-STDVD-ROM GDR8160B, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST CD-RW GCE-8240B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(100)
hdc: attached ide-scsi driver.
hdd: attached ide-scsi driver.
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HL-DT-ST  Model: DVD-ROM GDR8160B  Rev: 0009
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HL-DT-ST  Model: CD-RW GCE-8240B   Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 20x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 24x/40x writer cd/rw xa/form2 cdda tray
cs4232: Must set io, irq and dma.
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
ad1848: No ISAPnP cards found, trying standard ones...
Intel 810 + AC97 Audio, version 0.24, 14:56:56 Sep  6 2003
SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented
advanced SiS pirq mapping not yet implemented
i810: SiS 7012 found at IO 0xc400 and 0xc800, MEM 0x0000 and 0x0000, IRQ 10
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7650 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
SiS router pirq escape (96)
SiS router pirq escape (96)
host/usb-ohci.c: USB OHCI at membase 0xe0e1f000, IRQ 9
host/usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] USB 1.0 
Controller
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF dfdf9840, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0e1f000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: no over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfdf9840
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
SiS router pirq escape (99)
SiS router pirq escape (99)
host/usb-ohci.c: USB OHCI at membase 0xe0e21000, IRQ 9
host/usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] USB 1.0 
Controller (#2)
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF dfdf95c0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0e21000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: no over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfdf95c0
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cramfs: wrong magic
FAT: bogus logical sector size 0
XFS mounting filesystem ide0(3,2)
Starting XFS recovery on filesystem: ide0(3,2) (dev: 3/2)
Ending XFS recovery on filesystem: ide0(3,2) (dev: 3/2)
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding Swap: 1076344k swap-space (priority -1)
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 
c5e1.
eth1: Setting 100mbps full-duplex based on auto-negotiated partner ability 
41e1.


