Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318877AbSH1PWl>; Wed, 28 Aug 2002 11:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318875AbSH1PWl>; Wed, 28 Aug 2002 11:22:41 -0400
Received: from mail.xiotech.com ([209.46.118.18]:13577 "EHLO
	packer.xiotech.com") by vger.kernel.org with ESMTP
	id <S318876AbSH1PWg>; Wed, 28 Aug 2002 11:22:36 -0400
Message-ID: <ED8EDD517E0AA84FA2C36C8D6D205C1303F1C328@alfred.xiotech.com>
From: "Brueggeman, Steve" <steve_brueggeman@xiotech.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Grover, Andrew'" <andrew.grover@intel.com>
Cc: "'esg@mailbox.cps.intel.com'" <esg@mailbox.cps.intel.com>,
       "Alan Woldt (E-mail)" <awoldt@equuscs.com>,
       "Goh, Christopher" <christopher_goh@xiotech.com>
Subject: RE: Anyone know how to get soft-power-down to work on an Intel SC
	 B2??
Date: Wed, 28 Aug 2002 10:26:46 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I recompiled the kernel with the latest acpi patches
from sourceforge.net, and the dmesg output
seems to be recognizing the various ACPI, and
appears to be finding 

Initialized 13/14 Regions 2/2 Fields 35/35 Buffers 12/12 Packages (559
nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)

So it appears that at least the ACPI is recognizing the power-off
command S5

What I don't understand is, how does the /sbin/halt -p, and/or 
/sbin/poweroff commands know to use ACPI and not APM???
(This particular kernel did not have ANY APM support compiled in.

Would it be possible for you to send me a tarball of your kernel-source
that DOES do the soft-power-off.  I don't have a site for you to upload
to right now, but if you have a site that I could download from,
I'd really appreciate it!!!


Steve Brueggeman




==============dmesg output========================
(ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 INTEL                      ) @ 0x000ff9d0
ACPI: RSDT (v001 INTEL  SCB20    00000.00001) @ 0x1fff0000
ACPI: FADT (v001 INTEL  SCB20    00000.00001) @ 0x1fff0030
ACPI: MADT (v001 INTEL  SCB20    00000.00001) @ 0x1fff00b0
Kernel command line: ro root=/dev/sda3 ide=nodma
ide_setup: ide=nodmaIDE: Prevented DMA
Initializing CPU#0
Detected 997.497 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 515644k/524224k available (1362k kernel code, 8176k reserved, 418k
data, 236k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20020815
PCI: PCI BIOS revision 2.10 entry at 0xfdb65, last bus=2
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
 dsfield-0419: *** Error: Field name [INDX] already exists in current scope
 dsfield-0419: *** Error: Field name [DATA] already exists in current scope
 dsfield-0419: *** Error: Field name [INDX] already exists in current scope
 dsfield-0419: *** Error: Field name [DATA] already exists in current scope
 dsfield-0419: *** Error: Field name [C000] already exists in current scope
 dsfield-0419: *** Error: Field name [C010] already exists in current scope
 dsfield-0419: *** Error: Field name [C020] already exists in current scope
nsaccess-0556: *** Warning: Ns_lookup: INDX, type 1, checking for type 11
nsaccess-0556: *** Warning: Ns_lookup: DATA, type 2, checking for type 11
nsaccess-0556: *** Warning: Ns_lookup: INDX, type 1, checking for type 11
nsaccess-0556: *** Warning: Ns_lookup: DATA, type 2, checking for type 11
nsaccess-0556: *** Warning: Ns_lookup: C000, type 8, checking for type 13
nsaccess-0556: *** Warning: Ns_lookup: C010, type 8, checking for type 13
nsaccess-0556: *** Warning: Ns_lookup: C020, type 8, checking for type 13
Parsing
Methods:....................................................................
............................................................................
.......
Table [DSDT] - 559 Objects with 41 Devices 151 Methods 14 Regions
ACPI Namespace successfully loaded at root c03092bc
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode
successful
evxfevnt-0182 [07] Acpi_enable_event     : Could not enable Global_lock
event
 evxface-0089 [06] Acpi_install_fixed_eve: Could not enable fixed event.
Executing all Device _STA and_INI methods:................. psparse-1155:
*** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.GSTA (Node dff85308)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.FDC0._STA (Node dff85708)
. psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.GSTA (Node dff85308)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.UAR1._STA (Node dff85c08)
. psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.GSTA (Node dff85308)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.UAR2._STA (Node dff840c8)
......exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN00 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN01 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN02 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN03 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN04 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN05 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN06 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN07 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN08 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN09 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN10 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN11 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN12 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN13 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN14 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LN15 failed
AE_AML_NO_OPERAND
.exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
  uteval-0423 [07] Ut_execute_STA        : _STA on LNUS failed
AE_AML_NO_OPERAND

41 Devices found containing: 24 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package initialization:...............
  nsinit-0272 [06] Ns_init_one_object    : Could not execute arguments for
[SIO_] (Region), AE_NOT_FOUND
...............................
  nsinit-0272 [06] Ns_init_one_object    : Could not execute arguments for
[ICNT] (Region), AE_NOT_FOUND
.........
  nsinit-0272 [06] Ns_init_one_object    : Could not execute arguments for
[R000] (Region), AE_NOT_FOUND
.......
Initialized 13/14 Regions 2/2 Fields 35/35 Buffers 12/12 Packages (559
nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 pci_irq-0194 [08] acpi_pci_irq_add_prt  : Error evaluating _PRT
[AE_NOT_FOUND]
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.GSTA (Node dff85308)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.FDC0._STA (Node dff85708)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.GSTA (Node dff85308)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.UAR1._STA (Node dff85c08)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.GSTA (Node dff85308)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.SOTH.UAR2._STA (Node dff840c8)
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
 pci_irq-0194 [08] acpi_pci_irq_add_prt  : Error evaluating _PRT
[AE_NOT_FOUND]
ACPI: PCI Root Bridge [PCI2] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
 pci_irq-0194 [08] acpi_pci_irq_add_prt  : Error evaluating _PRT
[AE_NOT_FOUND]
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
exresolv-0065 [16] Ex_resolve_to_value   : Internal - null pointer
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
PCI: Found IRQ 10 for device 00:0f.3
PCI: Sharing IRQ 10 with 00:0f.2
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks CSB5: IDE controller on PCI bus 00 dev 79
PCI: Device 00:0f.1 not available because of resource collisions
ServerWorks CSB5: (ide_setup_pci_device:) Could not enable device.
hda: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 9 for device 01:07.1
PCI: Found IRQ 7 for device 01:07.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: ST318406LC        Rev: 0109
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: SEAGATE   Model: ST318406LC        Rev: 0109
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: SEAGATE   Model: ST336704LC        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: ESG-SHV   Model: SCA HSBP M16      Rev: 0.05
  Type:   Processor                          ANSI SCSI revision: 02
scsi1:A:0:0: Tagged Queuing enabled.  Depth 253
scsi1:A:4:0: Tagged Queuing enabled.  Depth 253
scsi1:A:5:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 4, lun 0
Attached scsi disk sdc at scsi1, channel 0, id 5, lun 0
(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 sda3
(scsi1:A:4): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 >
(scsi1:A:5): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdc: 71687369 512-byte hdwr sectors (36704 MB)
 sdc: sdc1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 259k freed
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 236k freed
Adding Swap: 2097136k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 10 for device 00:0f.2
PCI: Sharing IRQ 10 with 00:0f.3
usb-ohci.c: USB OHCI at membase 0xe0923000, IRQ 10
usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 USB Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,3), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 10 for device 00:03.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:03:47:D5:6E:90, IRQ 10.
  Board assembly fab600-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
PCI: Found IRQ 5 for device 00:04.0
eth1: OEM i82557/i82558 10/100 Ethernet, 00:03:47:D5:6E:91, IRQ 5.
  Board assembly fab600-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
