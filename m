Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266767AbTGKUqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266774AbTGKUqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:46:43 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:11460 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266767AbTGKUqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:46:19 -0400
Date: Fri, 11 Jul 2003 13:49:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 905] New: __report_bad_irq -- irq 9: nobody cared!
Message-ID: <835680000.1057956559@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=905

           Summary: __report_bad_irq -- irq 9: nobody cared!
    Kernel Version: 2.5.75
            Status: NEW
          Severity: low
             Owner: andrew.grover@intel.com
         Submitter: malte.d@gmx.net


Distribution: Slackware 9.0
Hardware Environment: IBM Thinkpad R31
Software Environment: stock acpi from 2.5.75
Problem Description: __report_bad_irq
dmesg:
Linux version 2.5.75 (root@snoopy) (gcc version 3.2.2) #1 Fri Jul 11 20:18:55
CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7d0000 (usable)
 BIOS-e820: 000000000f7d0000 - 000000000f7e0000 (reserved)
 BIOS-e820: 000000000f7e0000 - 000000000f7e8000 (ACPI data)
 BIOS-e820: 000000000f7e8000 - 000000000f800000 (ACPI NVS)
 BIOS-e820: 000000000f800000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
247MB LOWMEM available.
On node 0 totalpages: 63440
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 59344 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v000 IBM                        ) @ 0x000fe030
ACPI: RSDT (v001 IBM    Cnote2   00000.12416) @ 0x0f7e0000
ACPI: FADT (v001 IBM    Cnote2   00000.12416) @ 0x0f7e0054
ACPI: BOOT (v001 IBM    Cnote2   00000.12416) @ 0x0f7e002c
ACPI: DSDT (v001   IBM    CNOTE2 00000.12416) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=unstable ro root=304
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1129.769 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2236.41 BogoMIPS
Memory: 248464k/253760k available (1232k kernel code, 4576k reserved, 410k data,
268k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Celeron(TM) CPU                1133MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NoNET1.0 for Linux 2.6
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030619
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control
Methods:..........................................................................................................................................................................
..................
Table [DSDT](id F004) - 560 Objects with 51 Devices 188 Methods 36 Regions
ACPI Namespace successfully loaded at root c02ee53c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at
000000000000F128 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at
000000000000F12C on int 9
Completing Region/Field/Buffer/Package
initialization:......................................................................................
Initialized 36/36 Regions 5/5 Fields 25/25 Buffers 20/20 Packages (568 nodes)
Executing all Device _STA and_INI
methods:....................................................
52 Devices found containing: 52 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [PILA] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILB] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILC] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILD] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILE] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILF] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILG] (IRQs 3 4 5 6 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PILH] (IRQs 3 4 5 6 7 9 11 12 14 15, disabled)
ACPI: Embedded Controller [EC0] (gpe 29)
irq 9: nobody cared!
Call Trace:
 [<c010bb1b>] __report_bad_irq+0x2b/0x90
 [<c01b34cd>] acpi_irq+0xf/0x1a
 [<c010bc06>] note_interrupt+0x66/0xa0
 [<c010be10>] do_IRQ+0xf0/0x100
 [<c010a33c>] common_interrupt+0x18/0x20
 [<c01b007b>] pci_release_region+0x6b/0xd0
 [<c0120b0d>] do_softirq+0x4d/0xc0
 [<c01b34be>] acpi_irq+0x0/0x1a
 [<c010bdf7>] do_IRQ+0xd7/0x100
 [<c010a33c>] common_interrupt+0x18/0x20
 [<c0232393>] pci_conf1_write+0x83/0xc0
 [<c01b37d1>] acpi_os_write_pci_configuration+0x55/0x75
 [<c01c4248>] acpi_ex_pci_config_space_handler+0xa4/0xcd
 [<c01c41a4>] acpi_ex_pci_config_space_handler+0x0/0xcd
 [<c01ba67a>] acpi_ev_address_space_dispatch+0x13c/0x2b1
 [<c01c02c1>] acpi_ex_access_region+0xc8/0x175
 [<c01c02e1>] acpi_ex_access_region+0xe8/0x175
 [<c01c05ed>] acpi_ex_field_datum_io+0x244/0x273
 [<c01c071d>] acpi_ex_write_with_update_rule+0x101/0x1b8
 [<c01c0ce3>] acpi_ex_insert_into_field+0x162/0x30b
 [<c01be7b7>] acpi_ex_write_data_to_field+0x157/0x348
 [<c01be7c7>] acpi_ex_write_data_to_field+0x167/0x348
 [<c01c62f6>] acpi_ex_resolve_object+0x96/0xd2
 [<c01c486b>] acpi_ex_store_object_to_node+0xb8/0x199
 [<c01c4631>] acpi_ex_store+0x2b9/0x2c5
 [<c01c395b>] acpi_ex_opcode_2A_1T_1R+0x118/0x476
 [<c01b6e2b>] acpi_ds_exec_end_op+0x3a5/0x412
 [<c01cd981>] acpi_ps_parse_loop+0x475/0xb76
 [<c01d56c2>] acpi_ut_acquire_from_cache+0x8c/0xf0
 [<c01d6240>] acpi_ut_exit+0x1e/0x26
 [<c01b9a4e>] acpi_ds_push_walk_state+0x4a/0x52
 [<c01ce111>] acpi_ps_parse_aml+0x8f/0x286
 [<c01ce2e5>] acpi_ps_parse_aml+0x263/0x286
 [<c01cee6e>] acpi_psx_execute+0x1b2/0x2b8
 [<c01ca13e>] acpi_ns_execute_control_method+0xb8/0xf5
 [<c01ca03a>] acpi_ns_evaluate_by_handle+0xce/0x11a
 [<c01c9de8>] acpi_ns_evaluate_relative+0x134/0x17d
 [<c01d9a75>] acpi_ut_create_internal_object_dbg+0x71/0xba
 [<c01d6196>] acpi_ut_trace+0x29/0x2b
 [<c01d2a70>] acpi_rs_set_srs_method_data+0xcf/0xe7
 [<c01d0d19>] acpi_set_current_resources+0x6f/0x81
 [<c01df567>] acpi_pci_link_set+0x146/0x306
 [<c01df7e5>] acpi_pci_link_check+0xbe/0x176
 [<c02acb2a>] acpi_pci_irq_init+0x63/0x95
 [<c02b15db>] pci_acpi_init+0x2b/0x70
 [<c029e7bb>] do_initcalls+0x2b/0xa0
 [<c012b3b2>] init_workqueues+0x12/0x30
 [<c0105068>] init+0x28/0x150
 [<c0105040>] init+0x0/0x150
 [<c0108279>] kernel_thread_helper+0x5/0xc

handlers:
[<c01b34be>] (acpi_irq+0x0/0x1a)
Disabling IRQ #9
ACPI: PCI Interrupt Link [PILG] enabled at IRQ 9
ACPI: PCI Interrupt Link [PILH] enabled at IRQ 5
 pci_irq-0294 [26] acpi_pci_irq_derive   : Unable to derive IRQ for device
0000:00:1f.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:1f.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Enabling SEP on CPU 0
Journalled Block Device driver loaded
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THR1] (66 C)
ACPI: Thermal Zone [THR2] (42 C)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 196M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0x98000000
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
 pci_irq-0294 [25] acpi_pci_irq_derive   : Unable to derive IRQ for device
0000:00:1f.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:1f.1 - using IRQ 255
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa890-0xa897, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa898-0xa89f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LG CD-ROM CRN-8245B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=41344/15/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 268k freed
Adding 309952k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda4, internal journal

Steps to reproduce:
Just boot 2.5.75 with the following .config:
grep -v "^\(#\|$\)" dotconfig
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_BIOS_REBOOT=y


