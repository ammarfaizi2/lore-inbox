Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUFKCY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUFKCY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 22:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUFKCY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 22:24:27 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:10203 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S263713AbUFKCYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 22:24:10 -0400
Message-ID: <40C917D7.8060503@blue-labs.org>
Date: Thu, 10 Jun 2004 22:24:23 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040609
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.7-rc2, machine stalls oddly
Content-Type: multipart/mixed;
 boundary="------------000407040204070800070104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000407040204070800070104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Every now and then, about 15-20 minutes in between, this computer will 
stall.  For about 5-7 seconds, the HD LED will come on solid, I'll hear 
the HD click once like a full stroke, the monitor will blank, all 
keyboard and mouse activity stalls, and any sound stream will do a 
~.75second buffer repeat for the length of the stall.

After the stall is done with, -some- keys pressed may be sent to the 
application, not all will.  No mouse movements or button presses will be 
reported, the HD LED turns off and the monitor comes back to life.

This happens regardless of computer usage patters and nothing is 
reported in dmesg.

It's an SK8V motherboard, Opteron 148, 1G dual DDR400.

Scott root # lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3188 
(rev 01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b188
0000:00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
0000:00:08.0 RAID bus controller: Promise Technology, Inc.: Unknown 
device 3373 (rev 02)
0000:00:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875J 
(rev 04)
0000:00:0a.0 Ethernet controller: 3Com Corporation: Unknown device 1700 
(rev 12)
0000:00:0c.0 Communication controller: Conexant HCF 56k Data/Fax Modem 
(rev 08)
0000:00:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX 
(rev 20)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 
3149 (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B 
PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 
AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown 
device 0322 (rev a1)

Scott root # cat /proc/interrupts
           CPU0
  0:  176550676    IO-APIC-edge  timer
  1:     109155    IO-APIC-edge  i8042
  8:          0    IO-APIC-edge  rtc
  9:         47   IO-APIC-level  acpi
 12:       9272    IO-APIC-edge  i8042
 14:     822159    IO-APIC-edge  ide0
 15:         80    IO-APIC-edge  ide1
 16:         42   IO-APIC-level  sym53c8xx, ohci1394
 17:    2586129   IO-APIC-level  SysKonnect SK-98xx
 18:       6737   IO-APIC-level  intranet
 21:   30678864   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd, 
uhci_hcd
 22:    1460310   IO-APIC-level  VIA8233
NMI:      25073
LOC:  176534397
ERR:          0
MIS:          0

Scott root # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 148
stepping        : 8
cpu MHz         : 2211.088
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 
3dnowext 3dnow
bogomips        : 4341.76
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

David


--------------000407040204070800070104
Content-Type: text/plain;
 name="dmesg.lastboot"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.lastboot"

nabled)
Processor #0 15:5 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/ram0 real_root=/dev/hda3 init=/linuxrc console=ttyS0,115200n8 console=tty0 serial=0,115200n8 rw
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2211.088 MHz processor.
Console: colour VGA+ 80x25
Memory: 1024532k/1047744k available (3907k kernel code, 22440k reserved, 2500k data, 184k init)
Calibrating delay loop... 4341.76 BogoMIPS
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Opteron(tm) Processor 148 stepping 08
Using local APIC NMI watchdog using perfctr0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.562 MHz APIC timer.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
IOAPIC[0]: Set PCI routing entry (1-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:01[A] -> 1-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (1-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:01[B] -> 1-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (1-22 -> 0xb9 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 1-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (1-20 -> 0xc1 -> IRQ 20 Mode:1 Active:1)
00:00:0f[A] -> 1-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (1-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 1-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (1-18 -> 0xd1 -> IRQ 18 Mode:1 Active:1)
00:00:0b[C] -> 1-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (1-19 -> 0xd9 -> IRQ 19 Mode:1 Active:1)
00:00:0b[D] -> 1-19 -> IRQ 19
number of MP IRQ sources: 15.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
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
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    A9
 11 001 01  1    1    0   1   0    1    1    B1
 12 001 01  1    1    0   1   0    1    1    D1
 13 001 01  1    1    0   1   0    1    1    D9
 14 001 01  1    1    0   1   0    1    1    C1
 15 001 01  1    1    0   1   0    1    1    C9
 16 001 01  1    1    0   1   0    1    1    B9
 17 0D2 02  1    0    0   0   0    0    2    03
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
.................................... done.
PCI: Using ACPI for IRQ routing
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xf0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.2, from 11 to 5
PCI: Via IRQ fixup for 0000:00:10.3, from 11 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
ipmi message handler version v31
ipmi device interface version v31
IPMI System Interface driver version v31, KCS version v31, SMIC version v31, BT version v31
ipmi_si: Trying "kcs" at I/O port 0xca2
ipmi_si: Trying "smic" at I/O port 0xca9
ipmi_si: Trying "bt" at I/O port 0xe4
ipmi_si: Unable to find any System Interface(s)
IPMI watchdog driver version v31
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
sk98lin: Network Device Driver v6.23
(C)Copyright 1999-2004 Marvell(R).
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_plx.c 0.13e (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)
orinoco_pci.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)
Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
tulip0:  MII transceiver #1 config 3000 status 7809 advertising 01e1.
eth1: Lite-On 82c168 PNIC rev 32 at 0xffffff00000bd000, 00:A0:CC:56:CB:FB, IRQ 18.
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 20
    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:DMA
hda: SAMSUNG SP1614N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: 4X4X32, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
PCI: Enabling device 0000:00:09.0 (0000 -> 0003)
PCI: Setting latency timer of device 0000:00:09.0 to 64
sym0: <875> rev 0x4 at pci 0000:00:09.0 irq 16
sym0: Symbios NVRAM, ID 15, Fast-20, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCAN FOR LUNS disabled for targets 1.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
  Vendor: UMAX      Model: Astra 2400S       Rev: V1.1
  Type:   Scanner                            ANSI SCSI revision: 02
scsi(0:0:1:0): Beginning Domain Validation
scsi(0:0:1:0): Ending Domain Validation
Attached scsi generic sg0 at scsi0, channel 0, id 1, lun 0,  type 6
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1203 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[fd200000-fd2007ff]  Max Packet=[2048]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1205 $ Ben Collins <bcollins@debian.org>
ip1394: $Rev: 1198 $ Ben Collins <bcollins@debian.org>
ip1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 21, pci mem ffffff00000e0000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 21, io base 000000000000b400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 000000000000b800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 000000000000c000
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.3: irq 21, io base 000000000000c400
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB modems and ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usbcore: registered new driver ov511
drivers/usb/media/ov511.c: v1.64 for Linux 2.5 : ov511 USB Camera Driver
pwc Philips PCA645/646 + PCVC675/680/690 + PCVC730/740/750 webcam module version 8.12 loaded.
pwc Also supports the Askey VC010, various Logitech QuickCams, Samsung MPC-C10 and MPC-C30,
pwc the Creative WebCam 5, SOTEC Afina Eye and Visionite VCS-UC300 and VCS-UM100.
usbcore: registered new driver Philips webcam
drivers/usb/net/pegasus.c: v0.5.12 (2003/06/06):Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new driver pegasus
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS2T++ Logitech TouchPad 3 on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
usb 1-2: new high speed USB device using address 2
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usb 2-1: new full speed USB device using address 2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800005eb58e]
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
usb 2-1.1: new low speed USB device using address 3
Linux telephony interface: v1.00
$Id: ixj.c,v 4.7 2001/08/13 06:19:33 craigs Exp $
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 2004 UTC).
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
PCI: Setting latency timer of device 0000:00:11.5 to 64
hiddev96: USB HID v1.10 Device [APC Back-UPS ES 350 FW:1.e2.D USB FW:e2] on usb-0000:00:10.0-1.1
usb 2-1.2: new low speed USB device using address 4
ALSA sound/pci/via82xx.c:598: codec_read: codec 0 is not valid [0xfe0000]
ALSA sound/pci/via82xx.c:598: codec_read: codec 0 is not valid [0xfe0000]
ALSA sound/pci/via82xx.c:598: codec_read: codec 0 is not valid [0xfe0000]
ALSA sound/pci/via82xx.c:598: codec_read: codec 0 is not valid [0xfe0000]
ALSA device list:
  #0: VIA 823x rev60 at 0xc800, irq 22
NET: Registered protocol family 2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.0-1.2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
NET: Registered protocol family 4
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
SCTP: Hash tables configured (established 65536 bind 65536)
powernow-k8: Power state transitions not supported
ACPI: (supports S0 S1 S3 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 184k freed
usb 2-1.3: new full speed USB device using address 5
drivers/usb/media/ov511.c: USB OV511 video device found
drivers/usb/media/ov511.c: model: AverMedia InterCam Elite
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
drivers/usb/media/ov511.c: Sensor is an OV7610
drivers/usb/media/ov511.c: Device at usb-0000:00:10.0-1.3 registered to minor 0
usb 2-1.4: new full speed USB device using address 6
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: replayed 1 transactions in 0 seconds
ReiserFS: hda3: Using r5 hash to sort names
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
Disabled Privacy Extensions on device ffffffff80692a80(lo)
cable: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    scatter-gather:  enabled

--------------000407040204070800070104
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------000407040204070800070104--
