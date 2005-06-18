Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVFRQSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVFRQSc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 12:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVFRQSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 12:18:31 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:5897 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262148AbVFRQRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 12:17:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=cwrQHE1lLtydKGtj4IBAnmybEzaB0ERQYriUf//sMBXnuaRysBBrMYvohGKCfD1oFoUPbPvoRdqzDdTNxylFHIXYqIz90ps5eVOHFsqhOR6IacUohen9GrkMWNb/tZas5Bi+SvOR+WsE/YcK1nFwc0t0yKDT93sD1CoEuWPFiqY=
Message-ID: <42B44919.7070300@gmail.com>
Date: Sat, 18 Jun 2005 18:17:29 +0200
From: Alessandro <alezzandro@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining"
 on Kernel 2.6.12
Content-Type: multipart/mixed;
 boundary="------------040908080305090305090608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040908080305090305090608
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Today I downloaded and installed the Kernel 2.6.12
(I use the old .config of kernel 2.6.11.12 but i tried also a new 
configuration starting from the default config that the make menuconfig 
generated).
When I reboot my Slackware 10.1 in Kernel 2.6.12 this is the output of 
my dmesg:

bash-3.00$ dmesg
Linux version 2.6.12 (root@freedom) (gcc version 3.3.5) #1 SMP Sat Jun 
18 15:16:59 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffba0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 130864
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126768 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f9e70
ACPI: RSDT (v001 A M I  OEMRSDT  0x02000424 MSFT 0x00000097) @ 0x1ff30000
ACPI: FADT (v002 A M I  OEMFACP  0x02000424 MSFT 0x00000097) @ 0x1ff30200
ACPI: MADT (v001 A M I  OEMAPIC  0x02000424 MSFT 0x00000097) @ 0x1ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x02000424 MSFT 0x00000097) @ 0x1ff40040
ACPI: DSDT (v001  P4PSS P4PSS023 0x00000023 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:dfba0000)
Built 1 zonelists
Kernel command line: ro root=/dev/hda1 vga=792
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2999.507 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513212k/523456k available (2918k kernel code, 9684k reserved, 
1121k data, 232k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5914.62 BogoMIPS (lpj=2957312)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
0000041d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 
0000041d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000041d 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay loop... 5980.16 BogoMIPS (lpj=2990080)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
0000041d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 
0000041d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000041d 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Total of 2 processors activated (11894.78 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 03
  groups: 01 02
  domain 1: span 03
   groups: 03
CPU1 attaching sched-domain:
 domain 0: span 03
  groups: 02 01
  domain 1: span 03
   groups: 03
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
pnp: 00:09: ioport range 0x680-0x6ff has been reserved
pnp: 00:09: ioport range 0x290-0x297 has been reserved
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1119108222.761:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 4608k, 
total 131072k
vesafb: mode is 1024x768x24, linelength=3072, pages=55
vesafb: protected mode interface info at c000:56cb
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
mtrr: type mismatch for e0000000,8000000 old: write-back new: 
write-combining
mtrr: type mismatch for e0000000,4000000 old: write-back new: 
write-combining
mtrr: type mismatch for e0000000,2000000 old: write-back new: 
write-combining
mtrr: type mismatch for e0000000,1000000 old: write-back new: 
write-combining
mtrr: type mismatch for e0000000,800000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,400000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,200000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,100000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,80000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,40000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,20000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,10000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,8000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,4000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,2000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,1000 old: write-back new: write-combining
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x800  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x400  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x200  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x100  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x80  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x40  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x20  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x10  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x8  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x4  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x2  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x1  base: 0xe0000000
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: IC35L060AVV207-0, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG CD-R/RW DRIVE SW-252F, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, 
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 > hda4
hdb: max request size: 128KiB
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, 
UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 < hdb5 hdb6 >
hdc: ATAPI 1X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
libata version 1.11 loaded.
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 
EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xffaffc00
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000ef00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ef20
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ef40
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000ef80
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 
10:33:39 2005 UTC).
ALSA device list:
  No soundcards found.
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 7, 524288 bytes)
TCP bind hash table entries: 32768 (order: 6, 393216 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4089 buckets, 32712 max) - 220 bytes per conntrack
input: AT Translated Set 2 keyboard on isa0060/serio0
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
ACPI wakeup devices:
P0P4 MC97 USB1 USB2 USB3 USB4 EUSB PS2K PS2M ILAN
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 232k freed
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
Adding 530108k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.22 [Flags: R/W DEBUG MODULE].
NTFS volume version 3.1.
NTFS-fs error (device hdb1): ntfs_check_logfile(): The two restart pages 
in $LogFile do not match.
NTFS-fs warning (device hdb1): load_system_files(): Failed to load 
$LogFile.  Will not be able to remount read-write.  Mount in Windows.
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
eth0: RealTek RTL8139 at 0xd800, 00:0e:a6:b3:89:32, IRQ 22
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
intel8x0_measure_ac97_clock: measured 50202 usecs
intel8x0: clocking to 48000
hw_random: RNG not detected
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 128M @ 0xf0000000
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
hw_random: RNG not detected
Real Time Clock Driver v1.12
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
w83627hf 1-0290: Reading VID from GPIO5
i2c /dev entries driver
mtrr: type mismatch for e0000000,8000000 old: write-back new: 
write-combining
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
mtrr: type mismatch for f0000000,8000000 old: write-back new: 
write-combining
[drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies 
Inc RV280 [Radeon 9200 SE]
mtrr: type mismatch for e0000000,8000000 old: write-back new: 
write-combining
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: reserved bits set in mode 0x1f004a0f. Fixed.
agpgart: X tried to set rate=x12. Setting to AGP3 x8 mode.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
[drm] Loading R200 Microcode
scsi: unknown opcode 0x01

One of errors that I see in dmesg is "mtrr: type mismatch for 
e0000000,8000000 old: write-back new: write-combining", I have probably 
the same problem of the 2.6.12-rc5-mm1 that I found here: 
http://seclists.org/lists/linux-kernel/2005/Jun/0216.html but my system 
has only one soundcard (on board).

Of course I attached my .config , my /proc/cpuinfo (p4 3.0 ghz 
prescott), my /proc/modules etc...
I hope can you give me some help or release some patch.

Thanks,
Alessandro Arrichiello from Italy.

--------------040908080305090305090608
Content-Type: text/plain;
 name="cpuinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuinfo"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 3
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping	: 3
cpu MHz		: 2999.507
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor ds_cpl cid
bogomips	: 5914.62

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 3
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping	: 3
cpu MHz		: 2999.507
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor ds_cpl cid
bogomips	: 5980.16


--------------040908080305090305090608
Content-Type: text/plain;
 name="iomem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iomem"

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccfff : Video ROM
000f0000-000fffff : System ROM
00100000-1ff2ffff : System RAM
  00100000-003d9bd5 : Kernel code
  003d9bd6-004f21ff : Kernel data
1ff30000-1ff3ffff : ACPI Tables
1ff40000-1ffeffff : ACPI Non-volatile Storage
1fff0000-1fffffff : reserved
20000000-200003ff : 0000:00:1f.1
cff00000-efefffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.1
  e0000000-e7ffffff : 0000:01:00.0
    e0000000-e7ffffff : vesafb
f0000000-f7ffffff : 0000:00:00.0
ff800000-ff8fffff : PCI Bus #01
  ff8e0000-ff8effff : 0000:01:00.1
  ff8f0000-ff8fffff : 0000:01:00.0
ff9ffc00-ff9ffcff : 0000:02:05.0
  ff9ffc00-ff9ffcff : 8139too
ffaff400-ffaff4ff : 0000:00:1f.5
  ffaff400-ffaff4ff : Intel ICH5
ffaff800-ffaff9ff : 0000:00:1f.5
  ffaff800-ffaff9ff : Intel ICH5
ffaffc00-ffafffff : 0000:00:1d.7
  ffaffc00-ffafffff : ehci_hcd
ffba0000-ffffffff : reserved

--------------040908080305090305090608
Content-Type: text/plain;
 name="ioports"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioports"

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : pnp 00:09
  0290-0297 : w83627hf
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
  0400-040f : i801-smbus
0480-04bf : 0000:00:1f.0
0680-06ff : pnp 00:09
0800-087f : 0000:00:1f.0
  0800-0803 : PM1a_EVT_BLK
  0804-0805 : PM1a_CNT_BLK
  0808-080b : PM_TMR
  0828-082f : GPE0_BLK
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
d800-d8ff : 0000:02:05.0
  d800-d8ff : 8139too
e800-e8ff : 0000:00:1f.5
  e800-e8ff : Intel ICH5
ee80-eebf : 0000:00:1f.5
  ee80-eebf : Intel ICH5
ef00-ef1f : 0000:00:1d.0
  ef00-ef1f : uhci_hcd
ef20-ef3f : 0000:00:1d.1
  ef20-ef3f : uhci_hcd
ef40-ef5f : 0000:00:1d.2
  ef40-ef5f : uhci_hcd
ef80-ef9f : 0000:00:1d.3
  ef80-ef9f : uhci_hcd
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1

--------------040908080305090305090608
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 8110
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8

00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff800000-ff8fffff
	Prefetchable memory behind bridge: cff00000-efefffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at ef00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at ef20 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at ef40 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at ef80 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at ffaffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ff900000-ff9fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 0400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 810d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ee80 [size=64]
	Region 2: Memory at ffaff800 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at ffaff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
	Subsystem: C.P. Technology Co. Ltd CN-AG92E
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 04
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at ff8f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at ff8c0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
	Subsystem: C.P. Technology Co. Ltd: Unknown device 2072
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 04
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at ff8e0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 8109
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at ff9ffc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------040908080305090305090608
Content-Type: text/plain;
 name="modules"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modules"

radeon 77696 1 - Live 0xe0e39000
i2c_dev 8704 0 - Live 0xe0dbd000
i2c_algo_bit 9992 0 - Live 0xe0d97000
i2c_isa 2816 0 - Live 0xe0d8e000
w83627hf 30376 0 - Live 0xe0dea000
i2c_sensor 3968 1 w83627hf, Live 0xe0d8c000
ohci_hcd 20356 0 - Live 0xe0db7000
rtc 11596 0 - Live 0xe0d46000
intel_agp 21276 1 - Live 0xe0d90000
shpchp 99332 0 - Live 0xe0dd0000
pci_hotplug 12164 1 shpchp, Live 0xe0d3e000
i2c_i801 8716 0 - Live 0xe0d42000
i2c_core 19200 6 i2c_dev,i2c_algo_bit,i2c_isa,w83627hf,i2c_sensor,i2c_i801, Live 0xe0d81000
snd_intel8x0 30400 0 - Live 0xe085e000
snd_ac97_codec 81016 1 snd_intel8x0, Live 0xe0d9b000
8139too 22528 0 - Live 0xe0867000
ntfs 219316 1 - Live 0xe0d4a000
l2cap 24704 2 - Live 0xe0d01000
bluetooth 47108 3 l2cap, Live 0xe086e000

--------------040908080305090305090608
Content-Type: text/plain;
 name="mtrr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mtrr"

reg00: base=0x00000000 (   0MB), size=983552MB: write-back, count=1

--------------040908080305090305090608
Content-Type: text/plain;
 name="scsi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi"

Attached devices:

--------------040908080305090305090608
Content-Type: text/plain;
 name="version"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="version"

Linux version 2.6.12 (root@freedom) (gcc version 3.3.5) #1 SMP Sat Jun 18 15:16:59 CEST 2005

--------------040908080305090305090608--
