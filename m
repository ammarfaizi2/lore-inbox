Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316492AbSFDHDA>; Tue, 4 Jun 2002 03:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316496AbSFDHC7>; Tue, 4 Jun 2002 03:02:59 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:55312 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S316492AbSFDHC5>; Tue, 4 Jun 2002 03:02:57 -0400
Subject: 2.5.20 -- Hanging (no oops and sysrq fails) after switching to
	rivafb
From: Miles Lane <miles@megapathdsl.net>
To: linux-kernel@vger.kernel.org, jsimmons@transvirtual.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 04 Jun 2002 00:23:37 -0700
Message-Id: <1023175418.7859.32.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried booting both with acpi enabled and with pci=noacpi set.
When the machine freezes, the VT display mode has just switched
to using rivafb (video=riva:1600x1200-16).  I have reported
with previous 2.5 builds that my rivafb has been working for
me with the exception that the colors have been wrong.
This time, the video mode is wrong and the display is messed
up.  After the freeze, no disk activity occurs and the Caps Lock,
Num Lock and so on don't work.  No oops message is shown.

I apologize for the size of this post.  I imagine that you'll
also need lspci -v and .config information, but I'll wait for
someone to ask for it.

Linux version 2.5.20 (root@turbulence.megapathdsl.net) (gcc version 3.0.4 (Red Hat Linux 7.2 3.0.4-1)) #22Video mode to be used for restore is f00                          
BIOS-provided physical RAM map:                                   
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)          
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffe0000 (usable)
 BIOS-e820: 000000000ffe0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65504
zone(0): 4096 pages.
zone(1): 61408 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                        ) @ 0x000fae70
ACPI: RSDT (v001 GATEWA 8DT-084  00529.06553) @ 0x0fff0000
ACPI: FADT (v001 GATEWA 8DT-084  00529.06553) @ 0x0fff1000
ACPI: MADT not present
Kernel command line: ro root=/dev/hda6 hdd=ide-scsi console=ttyS0,38400 console=tty0 video=riva:1600x1200-16
ide_setup: hdd=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 848.370 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 255648k/262016k available (2231k kernel code, 5980k reserved, 566k data, 256k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
WARNING: This combination of AMD processors is not suitable for SMP.
CPU0: AMD Athlon(tm) Processor stepping 01
per-CPU timeslice cutoff: 1462.63 usecs.
task migration cache decay timeout: 10 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 848.3522 MHz.
..... host bus clock speed is 199.6121 MHz.
cpu: 0, clocks: 1996121, slice: 998060
CPU0<T0:1996112,T1:998048,D:4,S:998060,C:1996121>
migration_task 0 on cpu=0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdad1, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20020517
 tbxface-0100 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:...................................................................................
Table [DSDT] - 271 Objects with 26 Devices 83 Methods 15 Regions
ACPI Namespace successfully loaded at root c0450d7c
evxfevnt-0076 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:............... exfldio-0098 [47] Ex_setup_region       : Field) exfldio-0108 [47] Ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond end of region [)  uteval-0430 [34] Ut_execute_STA        : No object was returned from _STA
...........
26 Devices found containing: 25 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:..........................................
Initialized 12/15 Regions 1/1 Fields 21/21 Buffers 8/9 Packages (271 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
 exfldio-0098 [76] Ex_setup_region       : Field [PS2E] access width (4 bytes) too large for region [PSRG) exfldio-0108 [76] Ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond end of region [)pci_link-0152 [114] acpi_pci_link_get_poss: Resource is not an IRQ entry
pci_link-0152 [116] acpi_pci_link_get_poss: Resource is not an IRQ entry
pci_link-0152 [118] acpi_pci_link_get_poss: Resource is not an IRQ entry
pci_link-0152 [120] acpi_pci_link_get_poss: Resource is not an IRQ entry
pci_link-0465 [116] acpi_pci_link_get_irq : Invalid link context
 pci_irq-0288 [115] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:07.4
pci_link-0465 [116] acpi_pci_link_get_irq : Invalid link context
 pci_irq-0288 [115] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:0f.0
pci_link-0465 [116] acpi_pci_link_get_irq : Invalid link context
 pci_irq-0288 [115] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:11.0
pci_link-0465 [116] acpi_pci_link_get_irq : Invalid link context
 pci_irq-0288 [115] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:11.1
pci_link-0465 [116] acpi_pci_link_get_irq : Invalid link context
 pci_irq-0288 [115] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:11.2
pci_link-0465 [116] acpi_pci_link_get_irq : Invalid link context
 pci_irq-0288 [115] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:12.0
pci_link-0465 [116] acpi_pci_link_get_irq : Invalid link context
 pci_irq-0288 [115] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:13.0
pci_link-0465 [116] acpi_pci_link_get_irq : Invalid link context
 pci_irq-0288 [115] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:14.0
PCI: No IRQ known for interrupt pin A of device 00:14.0
pci_link-0465 [116] acpi_pci_link_get_irq : Invalid link context
 pci_irq-0288 [115] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:14.1
PCI: No IRQ known for interrupt pin B of device 00:14.1
pci_link-0465 [116] acpi_pci_link_get_irq : Invalid link context
 pci_irq-0288 [115] acpi_pci_irq_derive   : Unable to derive IRQ for device 01:05.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi'
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
NTFS driver 2.0.7 [Flags: R/O DEBUG]. Copyright (c) 2001,2002 Anton Altaparmakov.
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1)
rivafb: RIVA MTRR set to ON

-----------------------------------------------------------

With "pci=noacpi" set:

Linux version 2.5.20 (root@turbulence.megapathdsl.net) (gcc version 3.0.4 (Red Hat Linux 7.2 3.0.4-1)) #22Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffe0000 (usable)
 BIOS-e820: 000000000ffe0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65504
zone(0): 4096 pages.
zone(1): 61408 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                        ) @ 0x000fae70
ACPI: RSDT (v001 GATEWA 8DT-084  00529.06553) @ 0x0fff0000
ACPI: FADT (v001 GATEWA 8DT-084  00529.06553) @ 0x0fff1000
ACPI: MADT not present
Kernel command line: ro root=/dev/hda6 hdd=ide-scsi console=ttyS0,38400 console=tty0 pci=noacpi video=riva:1600x1200-16
ide_setup: hdd=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 848.372 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 255648k/262016k available (2231k kernel code, 5980k reserved, 566k data, 256k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
WARNING: This combination of AMD processors is not suitable for SMP.
CPU0: AMD Athlon(tm) Processor stepping 01
per-CPU timeslice cutoff: 1462.63 usecs.
task migration cache decay timeout: 10 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 848.3206 MHz.
..... host bus clock speed is 199.6048 MHz.
cpu: 0, clocks: 1996048, slice: 998024
CPU0<T0:1996048,T1:998016,D:8,S:998024,C:1996048>
migration_task 0 on cpu=0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdad1, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20020517
 tbxface-0100 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:...................................................................................
Table [DSDT] - 271 Objects with 26 Devices 83 Methods 15 Regions
ACPI Namespace successfully loaded at root c0450d7c
evxfevnt-0076 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:............... exfldio-0098 [47] Ex_setup_region       : Field) exfldio-0108 [47] Ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond end of region [)  uteval-0430 [34] Ut_execute_STA        : No object was returned from _STA
...........
26 Devices found containing: 25 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:..........................................
Initialized 12/15 Regions 1/1 Fields 21/21 Buffers 8/9 Packages (271 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
 exfldio-0098 [76] Ex_setup_region       : Field [PS2E] access width (4 bytes) too large for region [PSRG) exfldio-0108 [76] Ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond end of region [)pci_link-0152 [114] acpi_pci_link_get_poss: Resource is not an IRQ entry
pci_link-0152 [116] acpi_pci_link_get_poss: Resource is not an IRQ entry
pci_link-0152 [118] acpi_pci_link_get_poss: Resource is not an IRQ entry
pci_link-0152 [120] acpi_pci_link_get_poss: Resource is not an IRQ entry
PCI: Probing PCI hardware
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
NTFS driver 2.0.7 [Flags: R/O DEBUG]. Copyright (c) 2001,2002 Anton Altaparmakov.
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1)
rivafb: RIVA MTRR set to ON


