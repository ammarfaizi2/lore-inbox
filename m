Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVHKRYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVHKRYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVHKRYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:24:53 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:15446 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751138AbVHKRYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:24:51 -0400
Message-ID: <42FB89D1.1060007@masoud.ir>
Date: Thu, 11 Aug 2005 13:24:33 -0400
From: Masoud Sharbiani <masouds@masoud.ir>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System shutdown with during reboot with 2.6.13-pre6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Whenever I reboot my Linux machine it turns itself off in the end, 
unless I add the 'acpi=off' to the end of kernel command line on boot.
Apparently, it happens after unmounting filesystems as it doesn't do 
fsck after next power-up.

The Kernel is 2.6.13-pre6

The machine itself is a dual CPU P3 system with MSI-694D motherboard 
(VIA chipset) with onboard promise controller, via-rhine network card 
and Symbios Logic 53c875 SCSI card.
Here is a dmesg of 2.6.13-rc6 booted with acpi=off
----Linux version 2.6.13-rc6 (masouds@dual) (gcc version 3.3.5 (Debian 
1:3.3.5-8ubu5
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
767MB LOWMEM available.
found SMP MP-table at 000f5fd0
On node 0 totalpages: 196592
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192496 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
Processor #1 6:8 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 30000000 (gap: 30000000:cec00000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro console=ttyS0,9600n8 console=tty0 
CONSOLf
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 868.996 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 773796k/786368k available (3035k kernel code, 12064k reserved, 
1240k da)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1739.69 BogoMIPS 
(lpj=869848)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 
000000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 
00000000 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 
0000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 0a
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1737.01 BogoMIPS 
(lpj=868508)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 
000000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 
00000000 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 
0000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3476.71 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20050408
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI->APIC IRQ transform: 0000:00:07.2[D] -> IRQ 7
PCI->APIC IRQ transform: 0000:00:07.3[D] -> IRQ 7
PCI->APIC IRQ transform: 0000:00:0e.0[A] -> IRQ 11
PCI->APIC IRQ transform: 0000:00:12.0[A] -> IRQ 5
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: d0000000-d3ffffff
  PREFETCH window: d4000000-d5ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
audit: initializing netlink socket (disabled)
audit(1123779736.430:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 
sec (no)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] Initialized drm 1.0.0 20040925
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin 
is 60 se.
Hangcheck: Using monotonic_clock().
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x0
parport_pc: VIA parallel port disabled in BIOS
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
eth0: VIA Rhine II at 0x1e400, 00:05:5d:f3:76:65, IRQ 5.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD1600BB-22GUA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface 
ide1...                                                  
hdd: IRQ probe failed 
(0xffffbefa)                                             
hdd: CD-ROM CDU611-F, ATAPI CD/DVD-ROM 
drive                                   
ide1 at 0x170-0x177,0x376 on irq 
15                                            
hda: max request size: 
1024KiB                                                 
hda: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, 
UDMA(100)
hda: cache flushes 
supported                                                   
 hda: hda1 hda2 hda3 
hda4                                                      
 hda4: <openbsd: hda5 hda6 
 >                                                   
hdd: ATAPI 10X CD-ROM drive, 256kB 
Cache                                       
Uniform CD-ROM driver Revision: 
3.20                                           
sym0: <875> rev 0x26 at pci 0000:00:0e.0 irq 
11                                
sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity 
checking                        
sym0: SCSI BUS has been 
reset.                                                 
scsi0 : 
sym-2.2.1                                                              
usbmon: debugs is not 
available                                                
USB Universal Host Controller Interface driver 
v2.3                            
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 
1           
uhci_hcd 0000:00:07.2: irq 7, io base 
0x0000b400                               
hub 1-0:1.0: USB hub 
found                                                     
hub 1-0:1.0: 2 ports 
detected                                                  
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller)
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 
2           
uhci_hcd 0000:00:07.3: irq 7, io base 
0x0000b800                               
hub 2-0:1.0: USB hub 
found                                                     
hub 2-0:1.0: 2 ports 
detected                                                  
usbcore: registered new driver 
usblp                                           
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class 
driver              
Initializing USB Mass Storage 
driver...                                        
usb 2-2: new full speed USB device using uhci_hcd and address 
2                
usbcore: registered new driver 
usb-storage                                     
USB Mass Storage support 
registered.                                           
usbcore: registered new driver 
usbhid                                          
drivers/usb/input/hid-core.c: v2.01:USB HID core 
driver                        
usbcore: registered new driver 
usbserial                                       
drivers/usb/serial/usb-serial.c: USB Serial support registered for 
Generic     
usbcore: registered new driver 
usbserial_generic                               
drivers/usb/serial/usb-serial.c: USB Serial Driver core 
v2.0                   
mice: PS/2 mouse device common for all 
mice                                    
oprofile: using NMI 
interrupt.                                                 
input: AT Translated Set 2 keyboard on 
isa0060/serio0                          
NET: Registered protocol family 
2                                              
IP route cache hash table entries: 32768 (order: 5, 131072 
bytes)              
TCP established hash table entries: 131072 (order: 9, 2097152 
bytes)           
input: ImExPS/2 Generic Explorer Mouse on 
isa0060/serio1                       
TCP bind hash table entries: 65536 (order: 7, 786432 
bytes)                    
TCP: Hash tables configured (established 131072 bind 
65536)                    
TCP reno 
registered                                                            
ip_conntrack version 2.1 (6143 buckets, 49144 max) - 212 bytes per 
conntrack   
ip_tables: (C) 2000-2002 Netfilter core 
team                                   
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/proj/
arp_tables: (C) 2002 David S. 
Miller                                           
TCP bic 
registered                                                             
NET: Registered protocol family 
1                                              
NET: Registered protocol family 
17                                             
Starting 
balanced_irq                                                          
Using IPI Shortcut 
mode                                                        
EXT3-fs: INFO: recovery required on readonly 
filesystem.                       
EXT3-fs: write access will be enabled during 
recovery.                         
EXT3-fs: recovery 
complete.                                                    
kjournald starting.  Commit interval 5 
seconds                                 
EXT3-fs: mounted filesystem with ordered data 
mode.                            
VFS: Mounted root (ext3 filesystem) 
readonly.                                  
Freeing unused kernel memory: 248k 
freed                                       
Adding 996020k swap on /dev/hda2.  Priority:-1 
extents:1                       
EXT3 FS on hda1, internal 
journal                                              
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: 
dm-devel@redhat.com       
md: md driver 0.90.2 MAX_MD_DEVS=256, 
MD_SB_DISKS=27                           
md: bitmap version 3.38device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
---
Without acpi=off, I get:
----
Linux version 2.6.13-rc6 (masouds@dual) (gcc version 3.3.5 (Debian 
1:3.3.5-8ubu5
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
767MB LOWMEM available.
found SMP MP-table at 000f5fd0
On node 0 totalpages: 196592
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192496 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 VIA694                                ) @ 0x000f78c0
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x2fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x2fff3040
ACPI: MADT (v001 VIA694          0x00000000  0x00000000) @ 0x2fff5740
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 30000000:cec00000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro console=ttyS0,9600n8 console=tty0 
CONSOL0
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 868.784 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 773796k/786368k available (3035k kernel code, 12064k reserved, 
1240k da)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1739.65 BogoMIPS 
(lpj=869828)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 
000000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 
00000000 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 
0000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 0a
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1737.10 BogoMIPS 
(lpj=868551)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 
000000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 
00000000 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 
0000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3476.75 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: d0000000-d3ffffff
  PREFETCH window: d4000000-d5ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
audit: initializing netlink socket (disabled)
audit(1123780637.933:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 
sec (no)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] Initialized drm 1.0.0 20040925
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin 
is 60 se.
Hangcheck: Using monotonic_clock().
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x0
parport_pc: VIA parallel port disabled in BIOS
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:12.0, from 5 to 0
eth0: VIA Rhine II at 0x1e400, 00:05:5d:f3:76:65, IRQ 16.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD1600BB-22GUA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdd: CD-ROM CDU611-F, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, 
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
 hda4: <openbsd: hda5 hda6 >
hdd: ATAPI 10X CD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 16 (level, low) -> IRQ 17
sym0: <875> rev 0x26 at pci 0000:00:0e.0 irq 17
sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.1
usbmon: debugs is not available
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 11 (level, 
low) -> IR1
PCI: Via IRQ fixup for 0000:00:07.2, from 7 to 11
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x0000b400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:07.3[D] -> Link [LNKD] -> GSI 11 (level, 
low) -> IR1
PCI: Via IRQ fixup for 0000:00:07.3, from 7 to 
11                              
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller)
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 
2           
uhci_hcd 0000:00:07.3: irq 11, io base 
0x0000b800                              
hub 2-0:1.0: USB hub 
found                                                     
hub 2-0:1.0: 2 ports 
detected                                                  
usb 2-2: new full speed USB device using uhci_hcd and address 
2                
usbcore: registered new driver 
usblp                                           
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class 
driver              
Initializing USB Mass Storage 
driver...                                        
usbcore: registered new driver 
usb-storage                                     
USB Mass Storage support 
registered.                                           
usbcore: registered new driver 
usbhid                                          
drivers/usb/input/hid-core.c: v2.01:USB HID core 
driver                        
usbcore: registered new driver 
usbserial                                       
drivers/usb/serial/usb-serial.c: USB Serial support registered for 
Generic     
usbcore: registered new driver 
usbserial_generic                               
drivers/usb/serial/usb-serial.c: USB Serial Driver core 
v2.0                   
mice: PS/2 mouse device common for all 
mice                                    
oprofile: using NMI 
interrupt.                                                 
input: AT Translated Set 2 keyboard on 
isa0060/serio0                          
NET: Registered protocol family 
2                                              
IP route cache hash table entries: 32768 (order: 5, 131072 
bytes)              
TCP established hash table entries: 131072 (order: 9, 2097152 
bytes)           
input: ImExPS/2 Generic Explorer Mouse on 
isa0060/serio1                       
TCP bind hash table entries: 65536 (order: 7, 786432 
bytes)                    
TCP: Hash tables configured (established 131072 bind 
65536)                    
TCP reno 
registered                                                            
ip_conntrack version 2.1 (6143 buckets, 49144 max) - 212 bytes per 
conntrack   
ip_tables: (C) 2000-2002 Netfilter core 
team                                   
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/proj/
arp_tables: (C) 2002 David S. 
Miller                                           
TCP bic 
registered                                                             
NET: Registered protocol family 
1                                              
NET: Registered protocol family 
17                                             
Starting 
balanced_irq                                                          
Using IPI Shortcut 
mode                                                        
EXT3-fs: mounted filesystem with ordered data 
mode.                            
VFS: Mounted root (ext3 filesystem) 
readonly.                                  
kjournald starting.  Commit interval 5 
seconds                                 
Freeing unused kernel memory: 248k 
freed                                       
Adding 996020k swap on /dev/hda2.  Priority:-1 
extents:1                       
EXT3 FS on hda1, internal 
journal                                              
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: 
dm-devel@redhat.com       
md: md driver 0.90.2 MAX_MD_DEVS=256, 
MD_SB_DISKS=27                           
md: bitmap version 
3.38                                                        
cdrom: open 
failed.                                                            
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
device-mapper: dm-linear: Device lookup 
failed                                 
device-mapper: error adding target to 
table                                    
eth0: link up, 100Mbps, full-duplex, lpa 
0x45E1                                
ibm_acpi: acpi_evalf(DHKC, d, ...) failed: 
4097                                
ibm_acpi: `enable,0xffff' invalid for parameter `hotkey'
----
My config is available at http://masoud.ir/config-2.6.txt for those 
interested.
Any ideas?
cheers,
Masoud



