Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbUC2WcA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbUC2Wbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:31:49 -0500
Received: from mid-2.inet.it ([213.92.5.19]:18873 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S263166AbUC2WaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:30:14 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.5-rc2-mm4 (and 3) IRQ problem
Date: Tue, 30 Mar 2004 00:29:29 +0200
User-Agent: KMail/1.6.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <A6974D8E5F98D511BB910002A50A6647615F68B9@hdsmsx402.hd.intel.com> <1080536373.16220.196.camel@dhcppc4>
In-Reply-To: <1080536373.16220.196.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Message-Id: <200403300029.29809.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 06:59, lunedì 29 marzo 2004, Len Brown ha scritto:
> Need full dmesg (eg. dmesg -s40000) to see if it is related to recent
> ACPI changes. like this:

here; the earlier part of file is extracted from syslog, the usblp and network 
errors made dmesg to scroll too fast..

SYSLOG:

Linux version 2.6.5-rc2-mm4 (cova@kefk.homelinux.org) (gcc version 3.3.2 
(Mandrake Linux 10.0 3.3.2-6mdk)) #1 SMP Sat Mar 27 18

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5cd0
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.2 present.
ACPI: RSDP (v000 IntelR                                    ) @ 0x000f7b00
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff7a40
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=265rc2mm4 ro root=305 devfs=nomount 
resume=/dev/hda6
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2806.898 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 132x60
Memory: 1035404k/1048512k available (2349k kernel code, 12152k reserved, 898k 
data, 184k init, 131008k highmem)
Calibrating delay loop... 5537.79 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
per-CPU timeslice cutoff: 1463.26 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5603.32 BogoMIPS
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11141.12 BogoMIPS).

DMESG:

ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not 
connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2806.0044 MHz.
..... host bus clock speed is 200.0431 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
zapping low mappings.
CPU0:  online
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1:  online
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfbb20, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040311
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:1f[C] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:1f[A] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
00:00:1f[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:1d[B] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23 Mode:1 Active:1)
00:00:1d[D] -> 2-23 -> IRQ 23
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:03:08[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd9 -> IRQ 21 Mode:1 Active:1)
00:03:08[B] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xe1 -> IRQ 22 Mode:1 Active:1)
00:03:08[C] -> 2-22 -> IRQ 22
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    1    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B9
 12 003 03  1    1    0   1   0    1    1    B1
 13 003 03  1    1    0   1   0    1    1    C1
 14 003 03  1    1    0   1   0    1    1    D1
 15 003 03  1    1    0   1   0    1    1    D9
 16 003 03  1    1    0   1   0    1    1    E1
 17 003 03  1    1    0   1   0    1    1    C9
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
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Machine check exception polling timer started.
Starting balanced_irq
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
udf: registering filesystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ACPI: Thermal Zone [THRM] (45 C)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: MAXTOR 6L060J3, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TEAC DV-W58G, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117266688 sectors (60040 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 > hda3 hda4
ahc_pci:3:6:0: Host Adapter Bios disabled.  Using default SCSI device 
parameters
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

  Vendor: Nikon     Model: COOLSCANIII       Rev: 1.31
  Type:   Scanner                            ANSI SCSI revision: 02
(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 02
libata version 1.02 loaded.
ata_piix version 1.01
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 18
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 320173056 sectors (lba48)
ata1: dev 0 configured for UDMA/133
scsi1 : ata_piix
ata2: SATA port disabled. ignoring.
ata2: thread exiting
scsi2 : ata_piix
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
sr1: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 5, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 2, lun 0,  type 6
Attached scsi generic sg1 at scsi0, channel 0, id 3, lun 0,  type 5
Attached scsi generic sg2 at scsi0, channel 0, id 5, lun 0,  type 5
Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not 
supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1546:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:534:udf_vrs: Starting at sector 16 (2048 byte 
sectors)
UDF-fs: No VRS found
VFS: Mounted root (jfs filesystem) readonly.
Freeing unused kernel memory: 184k freed
Generic RTC Driver v1.07
Adding 983768k swap on /dev/hda6.  Priority:-1 extents:1
Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k2
Copyright (c) 1999-2004 Intel Corporation.
PCI: Setting latency timer of device 0000:02:01.0 to 64
eth0: Intel(R) PRO/1000 Network Connection
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB USB2
ehci_hcd 0000:00:1d.7: reset hcs_params 0x104208 dbg=1 cc=4 pcc=2 ordered !ppc 
ports=8
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: capability 0001 at 68
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f888e000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 
Reset HALT
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
ehci_hcd 0000:00:1d.7: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Intel Corp. 82801EB USB2
usb usb1: Manufacturer: Linux 2.6.5-rc2-mm4 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB USB
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000bc00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: detected 2 ports
uhci_hcd 0000:00:1d.0: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: Intel Corp. 82801EB USB
usb usb2: Manufacturer: Linux 2.6.5-rc2-mm4 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: hotplug
usb usb2: registering 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: unknown reserved power switching mode
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB USB
ehci_hcd 0000:00:1d.7: GetStatus port 1 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 1, status 501, change 1, 480 Mb/s
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000b000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: detected 2 ports
uhci_hcd 0000:00:1d.1: root hub device address 1
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: Intel Corp. 82801EB USB
usb usb3: Manufacturer: Linux 2.6.5-rc2-mm4 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: hotplug
usb usb3: registering 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: unknown reserved power switching mode
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: Port indicators are not supported
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: hub controller current requirement: 0mA
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
hub 3-0:1.0: enabling power on all ports
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB USB
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000b400
hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x501
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: detected 2 ports
uhci_hcd 0000:00:1d.2: root hub device address 1
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: default language 0x0409
usb usb4: Product: Intel Corp. 82801EB USB
usb usb4: Manufacturer: Linux 2.6.5-rc2-mm4 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
usb usb4: hotplug
usb usb4: registering 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
ehci_hcd 0000:00:1d.7: port 1 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 1 status 003801 POWER OWNER sig=j  
CONNECT
ehci_hcd 0000:00:1d.7: GetStatus port 2 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 2, status 501, change 1, 480 Mb/s
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: unknown reserved power switching mode
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: Port indicators are not supported
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: hub controller current requirement: 0mA
hub 4-0:1.0: local power source is good
hub 4-0:1.0: no over-current condition exists
hub 4-0:1.0: enabling power on all ports
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB USB
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0000b800
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: detected 2 ports
uhci_hcd 0000:00:1d.3: root hub device address 1
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: default language 0x0409
usb usb5: Product: Intel Corp. 82801EB USB
usb usb5: Manufacturer: Linux 2.6.5-rc2-mm4 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.3
usb usb5: hotplug
usb usb5: registering 5-0:1.0 (config #1, interface 0)
usb 5-0:1.0: hotplug
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
hub 5-0:1.0: standalone hub
hub 5-0:1.0: unknown reserved power switching mode
hub 5-0:1.0: individual port over-current protection
hub 5-0:1.0: Port indicators are not supported
hub 5-0:1.0: power on to power good time: 2ms
hub 5-0:1.0: hub controller current requirement: 0mA
hub 5-0:1.0: local power source is good
hub 5-0:1.0: no over-current condition exists
hub 5-0:1.0: enabling power on all ports
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
hub 1-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:1d.7: port 2 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 2 status 003801 POWER OWNER sig=j  
CONNECT
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 3, status 501, change 1, 480 Mb/s
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hub 1-0:1.0: debounce: port 3: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:1d.7: port 3 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003801 POWER OWNER sig=j  
CONNECT
uhci_hcd 0000:00:1d.0: port 1 portsc 0093
hub 2-0:1.0: port 1, status 101, change 1, 12 Mb/s
hub 2-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
usb 2-1: new full speed USB device using address 2
intel8x0_measure_ac97_clock: measured 49321 usecs
intel8x0: clocking to 48000
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-1: default language 0x0409
usb 2-1: Product: hp LaserJet 1300
usb 2-1: Manufacturer: Hewlett-Packard
usb 2-1: SerialNumber: 00CNCD481547
usb 2-1: hotplug
usb 2-1: registering 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: hotplug
usblp 2-1:1.0: usb_probe_interface
usblp 2-1:1.0: usb_probe_interface - got id
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 1 
proto 2 vid 0x03F0 pid 0x1017
drivers/usb/core/file.c: looking for a minor, starting at 0
uhci_hcd 0000:00:1d.0: port 2 portsc 0093
hub 2-0:1.0: port 2, status 101, change 1, 12 Mb/s
hub 2-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x101
usb 2-2: new full speed USB device using address 3
i2c /dev entries driver
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
ppa: Version 2.07 (for Linux 2.4.x)
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
usb 2-2: skipped 1 class/vendor specific interface descriptors
usb 2-2: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-2: hotplug
usb 2-2: registering 2-2:1.0 (config #1, interface 0)
usb 2-2:1.0: hotplug
usb 2-2: registering 2-2:1.1 (config #1, interface 1)
usb 2-2:1.1: hotplug
usb 2-2: registering 2-2:1.2 (config #1, interface 2)
usb 2-2:1.2: hotplug
uhci_hcd 0000:00:1d.1: port 1 portsc 0093
hub 3-0:1.0: port 1, status 101, change 1, 12 Mb/s
hub 3-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.5
hci_usb 2-2:1.0: usb_probe_interface
hci_usb 2-2:1.0: usb_probe_interface - got id
hci_usb 2-2:1.1: usb_probe_interface
hci_usb 2-2:1.2: usb_probe_interface
hci_usb 2-2:1.2: usb_probe_interface - got id
usbcore: registered new driver hci_usb
usb 3-1: new full speed USB device using address 2
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1: default language 0x0409
usb 3-1: Product: Perfection1240
usb 3-1: Manufacturer: EPSON
usb 3-1: hotplug
usb 3-1: registering 3-1:1.0 (config #1, interface 0)
usb 3-1:1.0: hotplug
ehci_hcd 0000:00:1d.7: GetStatus port 1 status 003002 POWER OWNER sig=se0  CSC
hub 1-0:1.0: port 1, status 0, change 1, 12 Mb/s
ehci_hcd 0000:00:1d.7: GetStatus port 2 status 003002 POWER OWNER sig=se0  CSC
hub 1-0:1.0: port 2, status 0, change 1, 12 Mb/s
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003002 POWER OWNER sig=se0  CSC
hub 1-0:1.0: port 3, status 0, change 1, 12 Mb/s
uhci_hcd 0000:00:1d.2: suspend_hc
uhci_hcd 0000:00:1d.3: suspend_hc
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 300 bytes per conntrack
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
irq 18: nobody cared!
Call Trace:
 [<c010882b>] __report_bad_irq+0x2a/0x8b
 [<c0108937>] note_interrupt+0x91/0xaf
 [<c0108c4a>] do_IRQ+0x151/0x19a
 [<c034b4c8>] common_interrupt+0x18/0x20
 [<c0104c2e>] default_idle+0x0/0x2c
 [<c0104c57>] default_idle+0x29/0x2c
 [<c0104cbb>] cpu_idle+0x2e/0x3c
 [<c0430a02>] start_kernel+0x196/0x1c5
 [<c0430436>] unknown_bootoption+0x0/0x126

handlers:
[<c02a7b0b>] (ata_interrupt+0x0/0x173)
[<c02d2f9c>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #18
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
NETDEV WATCHDOG: eth0: transmit timed out
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
NETDEV WATCHDOG: eth0: transmit timed out
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
NETDEV WATCHDOG: eth0: transmit timed out

[...and so on, repeating..]

e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03e7c40(lo)
IPv6 over IPv4 tunneling driver
lp0: using parport0 (polling).
NETDEV WATCHDOG: eth0: transmit timed out
drivers/usb/class/usblp.c: usblp0: nonzero read/write bulk status received: -2
drivers/usb/class/usblp.c: usblp0: error -2 reading from printer
drivers/usb/class/usblp.c: usblp0: error -115 reading from printer
[...]



>
> http://bugzilla.kernel.org/show_bug.cgi?id=2366
>
> thanks,
> -Len
>
> On Sat, 2004-03-27 at 13:13, Fabio Coatti wrote:
> > I'm seeing a problem with ethernet driver (e1000) on 2.6.5-rc2-mm4,
> > here the
> > syslog excerpt:
> >
> > ========================
> > Mar 27 18:39:23 kefk kernel: e1000: eth0 NIC Link is Up 100 Mbps Full
> > Duplex
> > Mar 27 18:39:23 kefk kernel: irq 18: nobody cared!
> > Mar 27 18:39:23 kefk kernel: Call Trace:
> > Mar 27 18:39:23 kefk kernel:  [<c010882b>] __report_bad_irq+0x2a/0x8b
> > Mar 27 18:39:23 kefk kernel:  [<c0108937>] note_interrupt+0x91/0xaf
> > Mar 27 18:39:23 kefk kernel:  [<c0108c4a>] do_IRQ+0x151/0x19a
> > Mar 27 18:39:23 kefk kernel:  [<c034b4c8>] common_interrupt+0x18/0x20
> > Mar 27 18:39:23 kefk kernel:  [<c0104c2e>] default_idle+0x0/0x2c
> > Mar 27 18:39:23 kefk kernel:  [<c0104c57>] default_idle+0x29/0x2c
> > Mar 27 18:39:23 kefk kernel:  [<c0104cbb>] cpu_idle+0x2e/0x3c
> > Mar 27 18:39:23 kefk kernel:  [<c0430a02>] start_kernel+0x196/0x1c5
> > Mar 27 18:39:23 kefk kernel:  [<c0430436>]
> > unknown_bootoption+0x0/0x126
> > Mar 27 18:39:23 kefk kernel:
> > Mar 27 18:39:23 kefk kernel: handlers:
> > Mar 27 18:39:23 kefk kernel: [<c02a7b0b>] (ata_interrupt+0x0/0x173)
> > Mar 27 18:39:23 kefk kernel: [<c02d2f9c>] (usb_hcd_irq+0x0/0x67)
> > Mar 27 18:39:23 kefk kernel: Disabling IRQ #18
> > ===========================
> >
> > I've seen the same problem on -mm3, but that version has other
> > problems that
> > prevents me to do more tests.
> >
> > A similar issue was present in earlier kernel when I've tried to use
> > SATA
> > driver compiled as modules, same behaviour, solved by compiling SATA
> > driver
> > as built-in, not as module. (I've both normal ATA and SATA controllers
> > active
> > on my mb)
> >
> > under 2.6.5-rc2-mm1, this is the output of cat /proc/interrupts; as
> > you can
> > see there is also a nvidia module, but the problem arises event
> > without that
> > module. irq 18 is shared between eth0,libata and uhci_hcd.
> >
> > [root@kefk root]# cat /proc/interrupts
> >            CPU0       CPU1
> >   0:    1002506          0    IO-APIC-edge  timer
> >   1:       4722          0    IO-APIC-edge  i8042
> >   2:          0          0          XT-PIC  cascade
> >   9:          0          0   IO-APIC-level  acpi
> >  12:       8826          0    IO-APIC-edge  i8042
> >  14:      11920          0    IO-APIC-edge  ide0
> >  15:         23          0    IO-APIC-edge  ide1
> >  16:     278123          0   IO-APIC-level  uhci_hcd, uhci_hcd, nvidia
> >  17:       2337          0   IO-APIC-level  Intel ICH5
> >  18:      56240          0   IO-APIC-level  libata, uhci_hcd, eth0
> >  19:         55          0   IO-APIC-level  uhci_hcd
> >  22:        279          0   IO-APIC-level  aic7xxx
> >  23:          0          0   IO-APIC-level  ehci_hcd
> > NMI:          0          0
> > LOC:    1002427    1002439
> > ERR:          0
> > MIS:          0
> >
> > The MB is a ABIT IC7-G (i875p) ICH5, the kernel is compiled with
> > SMP/SMT
> > support active.
> >
> > Please let me know if more details are needed.
> >
> > A small question, not related to the above issue:
> > reverting 4k-stacks-always-on.patch can lead to problems or it's safe?
> > I've to
> > run nvidia binary driver so I've to use 8k instead of 4k; it would be
> > better
> > (for my standpoint) to have the possibility to disable 4k from config,
> > but to
> > do so I've to revert this patch. Apart from losing time to do a patch
> > -R :),
> > using 8k can be a problem?
> >
> > Many thanks for any answer.
> >
> > --
> > Fabio Coatti       http://www.ferrara.linux.it/members/cova
> > Ferrara Linux Users Group           http://ferrara.linux.it
> > GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
> > Old SysOps never die... they simply forget their password.
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
