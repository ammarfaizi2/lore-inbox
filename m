Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269619AbTGaVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbTGaVDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:03:16 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:11233 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S269619AbTGaVC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:02:58 -0400
Date: Thu, 31 Jul 2003 17:02:57 -0400 (EDT)
From: Matthew Galgoci <mgalgoci@redhat.com>
X-X-Sender: mgalgoci@lacrosse.corp.redhat.com
To: linux-kernel@vger.kernel.org
Subject: weird acpi errors and an Oops
Message-ID: <Pine.LNX.4.44.0307311656400.12933-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I installed Arjan Van de Ven's 2.6.0-0.test2.1.28.i686 kernel on my thinkpad x30, and
I recieved some weird ACPI errors and a subsequent ACPI related Oops.

Arjan asked me to send this to lkml, so here it is:

Jul 30 07:00:38 tp-x30 syslogd 1.4.1: restart.
Jul 30 07:00:38 tp-x30 syslog: syslogd startup succeeded
Jul 30 07:00:38 tp-x30 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul 30 07:00:38 tp-x30 kernel: Linux version 2.6.0-0.test2.1.28 (bhcompile@porky.devel.redhat.com) (gcc version 3.3 20030728 (Red Hat Linux 3.3-16)) #1 Wed Jul 30 06:18:28 EDT 2003
Jul 30 07:00:38 tp-x30 kernel: Video mode to be used for restore is f00
Jul 30 07:00:38 tp-x30 kernel: BIOS-provided physical RAM map:
Jul 30 07:00:38 tp-x30 kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Jul 30 07:00:38 tp-x30 kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Jul 30 07:00:38 tp-x30 kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Jul 30 07:00:38 tp-x30 kernel:  BIOS-e820: 0000000000100000 - 000000000f770000 (usable)
Jul 30 07:00:38 tp-x30 kernel:  BIOS-e820: 000000000f770000 - 000000000f77e000 (ACPI data)
Jul 30 07:00:38 tp-x30 kernel:  BIOS-e820: 000000000f77e000 - 000000000f780000 (ACPI NVS)
Jul 30 07:00:38 tp-x30 kernel:  BIOS-e820: 000000000f780000 - 0000000010000000 (reserved)
Jul 30 07:00:38 tp-x30 kernel:  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
Jul 30 07:00:38 tp-x30 syslog: klogd startup succeeded
Jul 30 07:00:38 tp-x30 kernel: 0MB HIGHMEM available.
Jul 30 07:00:38 tp-x30 kernel: 247MB LOWMEM available.
Jul 30 07:00:39 tp-x30 portmap: portmap startup succeeded
Jul 30 07:00:39 tp-x30 kernel: On node 0 totalpages: 63344
Jul 30 07:00:39 tp-x30 kernel:   DMA zone: 4096 pages, LIFO batch:1
Jul 30 07:00:39 tp-x30 kernel:   Normal zone: 59248 pages, LIFO batch:14
Jul 30 07:00:39 tp-x30 rpc.statd[905]: Version 1.0.3 Starting
Jul 30 07:00:39 tp-x30 kernel:   HighMem zone: 0 pages, LIFO batch:1
Jul 30 07:00:39 tp-x30 nfslock: rpc.statd startup succeeded
Jul 30 07:00:39 tp-x30 kernel: IBM machine detected. Enabling interrupts during APM calls.
Jul 30 07:00:39 tp-x30 kernel: IBM machine detected. Disabling SMBus accesses.
Jul 30 07:00:39 tp-x30 kernel: ACPI: RSDP (v002 IBM                        ) @ 0x000f7090
Jul 30 07:00:39 tp-x30 keytable: Loading keymap: 
Jul 30 07:00:39 tp-x30 kernel: ACPI: XSDT (v001 IBM    TP-1K    00000.04160) @ 0x0f772c62
Jul 30 07:00:39 tp-x30 kernel: ACPI: FADT (v001 IBM    TP-1K    00000.04160) @ 0x0f772cae
Jul 30 07:00:39 tp-x30 keytable: ^[[60G
Jul 30 07:00:39 tp-x30 kernel: ACPI: SSDT (v001 IBM    TP-1K    00000.04160) @ 0x0f772d62
Jul 30 07:00:39 tp-x30 keytable: 
Jul 30 07:00:39 tp-x30 kernel: ACPI: ECDT (v001 IBM    TP-1K    00000.04160) @ 0x0f77df54
Jul 30 07:00:39 tp-x30 keytable: Loading system font: 
Jul 30 07:00:39 tp-x30 kernel: ACPI: TCPA (v001 IBM    TP-1K    00000.04160) @ 0x0f77dfa6
Jul 30 07:00:39 tp-x30 keytable: 
Jul 30 07:00:39 tp-x30 kernel: ACPI: BOOT (v001 IBM    TP-1K    00000.04160) @ 0x0f77dfd8
Jul 30 07:00:39 tp-x30 rc: Starting keytable:  succeeded
Jul 30 07:00:39 tp-x30 kernel: ACPI: DSDT (v001 IBM    TP-1K    00000.04160) @ 0x00000000
Jul 30 07:00:39 tp-x30 kernel: ACPI: BIOS passes blacklist
Jul 30 07:00:39 tp-x30 random: Initializing random number generator:  succeeded
Jul 30 07:00:39 tp-x30 kernel: Building zonelist for node : 0
Jul 30 07:00:40 tp-x30 kernel: Kernel command line: ro root=LABEL=/
Jul 30 07:00:40 tp-x30 kernel: Initializing CPU#0
Jul 30 07:00:40 tp-x30 kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Jul 30 07:00:40 tp-x30 kernel: Detected 1196.166 MHz processor.
Jul 30 07:00:40 tp-x30 kernel: Console: colour VGA+ 80x25
Jul 30 07:00:40 tp-x30 kernel: Calibrating delay loop... 2367.48 BogoMIPS
Jul 30 07:00:40 tp-x30 /sbin/hotplug: no runnable /etc/hotplug/pcmcia_socket.agent is installed
Jul 30 07:00:40 tp-x30 pcmcia: Starting PCMCIA services:
Jul 30 07:00:40 tp-x30 /sbin/hotplug: no runnable /etc/hotplug/pcmcia_socket.agent is installed
Jul 30 07:00:40 tp-x30 kernel: Memory: 247232k/253376k available (1671k kernel code, 5416k reserved, 694k data, 160k init, 0k highmem)
Jul 30 07:00:40 tp-x30 kernel: Security Scaffold v1.0.0 initialized
Jul 30 07:00:40 tp-x30 kernel: Capability LSM initialized
Jul 30 07:00:40 tp-x30 kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Jul 30 07:00:40 tp-x30 kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Jul 30 07:00:40 tp-x30 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jul 30 07:00:40 tp-x30 kernel: -> /dev
Jul 30 07:00:40 tp-x30 kernel: -> /dev/console
Jul 30 07:00:40 tp-x30 kernel: -> /root
Jul 30 07:00:40 tp-x30 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 30 07:00:40 tp-x30 kernel: CPU: L2 cache: 512K
Jul 30 07:00:40 tp-x30 kernel: Intel machine check architecture supported.
Jul 30 07:00:40 tp-x30 kernel: Intel machine check reporting enabled on CPU#0.
Jul 30 07:00:40 tp-x30 kernel: CPU: Intel Mobile Intel(R) Pentium(R) III CPU - M  1200MHz stepping 04
Jul 30 07:00:40 tp-x30 kernel: Enabling fast FPU save and restore... done.
Jul 30 07:00:40 tp-x30 kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 30 07:00:40 tp-x30 kernel: Checking 'hlt' instruction... OK.
Jul 30 07:00:40 tp-x30 kernel: POSIX conformance testing by UNIFIX
Jul 30 07:00:40 tp-x30 kernel: Initializing RT netlink socket
Jul 30 07:00:40 tp-x30 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd90e, last bus=7
Jul 30 07:00:40 tp-x30 kernel: PCI: Using configuration type 1
Jul 30 07:00:40 tp-x30 kernel: mtrr: v2.0 (20020519)
Jul 30 07:00:40 tp-x30 kernel: BIO: pool of 256 setup, 15Kb (60 bytes/bio)
Jul 30 07:00:40 tp-x30 kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Jul 30 07:00:40 tp-x30 kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Jul 30 07:00:40 tp-x30 kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Jul 30 07:00:40 tp-x30 kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Jul 30 07:00:40 tp-x30 kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Jul 30 07:00:40 tp-x30 kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Jul 30 07:00:40 tp-x30 kernel: ACPI: Subsystem revision 20030714
Jul 30 07:00:40 tp-x30 kernel: ACPI: Found ECDT
Jul 30 07:00:40 tp-x30 kernel: ACPI: Interpreter enabled
Jul 30 07:00:40 tp-x30 kernel: ACPI: Using PIC for interrupt routing
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11, disabled)
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11, disabled)
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11, disabled)
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul 30 07:00:40 tp-x30 kernel: PCI: Probing PCI hardware (bus 00)
Jul 30 07:00:40 tp-x30 kernel: Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
Jul 30 07:00:40 tp-x30 kernel: ACPI: Embedded Controller [EC] (gpe 28)
Jul 30 07:00:40 tp-x30 kernel:     ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Jul 30 07:00:38 tp-x30 ifup: save_previous /etc/resolv.conf 
Jul 30 07:00:40 tp-x30 kernel:     ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.PUBS._STA] (Node cf68a7e0), AE_TIME
Jul 30 07:00:38 tp-x30 dhclient: bound to 172.31.1.11 -- renewal in 1663 seconds. 
Jul 30 07:00:40 tp-x30 kernel:     ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Jul 30 07:00:38 tp-x30 ifup:  done. 
Jul 30 07:00:40 tp-x30 kernel:     ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._STA] (Node cf6891b0), AE_TIME
Jul 30 07:00:38 tp-x30 logger: punching nameserver 172.31.1.126 through the firewall 
Jul 30 07:00:40 tp-x30 kernel:     ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Jul 30 07:00:38 tp-x30 network: Bringing up interface eth0:  succeeded 
Jul 30 07:00:40 tp-x30 kernel:     ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._STA] (Node cf689520), AE_AML_NO_RETURN_VALUE
Jul 30 07:00:40 tp-x30 kernel:     ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Jul 30 07:00:40 tp-x30 kernel:     ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT2._STA] (Node cf689864), AE_AML_NO_RETURN_VALUE
Jul 30 07:00:40 tp-x30 kernel: Linux Plug and Play Support v0.96 (c) Adam Belay
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
Jul 30 07:00:40 tp-x30 kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
Jul 30 07:00:40 tp-x30 kernel: PCI: Using ACPI for IRQ routing
Jul 30 07:00:40 tp-x30 pcmcia:  cardmgr.
Jul 30 07:00:41 tp-x30 cardmgr[973]: starting, version is 3.1.31
Jul 30 07:00:41 tp-x30 kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Jul 30 07:00:41 tp-x30 rc: Starting pcmcia:  succeeded
Jul 30 07:00:41 tp-x30 cardmgr[973]: watching 2 sockets
Jul 30 07:00:41 tp-x30 kernel: pty: 2048 Unix98 ptys configured
Jul 30 07:00:41 tp-x30 kernel: SBF: Simple Boot Flag extension found and enabled.
Jul 30 07:00:41 tp-x30 kernel: SBF: Setting boot flags 0x1
Jul 30 07:00:41 tp-x30 kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Jul 30 07:00:41 tp-x30 kernel: apm: overridden by ACPI.
Jul 30 07:00:41 tp-x30 kernel: Enabling SEP on CPU 0
Jul 30 07:00:41 tp-x30 kernel: Total HugeTLB memory allocated, 0
Jul 30 07:00:41 tp-x30 kernel: VFS: Disk quotas dquot_6.5.1
Jul 30 07:00:41 tp-x30 cardmgr[973]: Card Services release does not match
Jul 30 07:00:41 tp-x30 netfs: Mounting other filesystems:  succeeded
Jul 30 07:00:41 tp-x30 kernel: Initializing Cryptographic API
Jul 30 07:00:41 tp-x30 kernel: isapnp: Scanning for PnP cards...
Jul 30 07:00:41 tp-x30 kernel: isapnp: No Plug & Play device found
Jul 30 07:00:41 tp-x30 kernel: Real Time Clock Driver v1.11
Jul 30 07:00:41 tp-x30 kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
Jul 30 07:00:41 tp-x30 kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Jul 30 07:00:41 tp-x30 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul 30 07:00:41 tp-x30 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul 30 07:00:41 tp-x30 kernel: ICH3M: IDE controller at PCI slot 0000:00:1f.1
Jul 30 07:00:41 tp-x30 irattach: tcgetattr: Input/output error
Jul 30 07:00:41 tp-x30 irda: irattach startup succeeded
Jul 30 07:00:41 tp-x30 kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Jul 30 07:00:41 tp-x30 irattach: Stopping device /dev/ttyS2
Jul 30 07:00:41 tp-x30 kernel: ICH3M: chipset revision 2
Jul 30 07:00:41 tp-x30 modprobe: FATAL: Module net_pf_23 not found. 
Jul 30 07:00:42 tp-x30 kernel: ICH3M: not 100%% native mode: will probe irqs later
Jul 30 07:00:42 tp-x30 irattach: ioctl: set_inidisc: Bad file descriptor
Jul 30 07:00:42 tp-x30 kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
Jul 30 07:00:42 tp-x30 irattach: tcsetattr: Input/output error
Jul 30 07:00:42 tp-x30 irattach: exiting ... 
Jul 30 07:00:42 tp-x30 kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Jul 30 07:00:42 tp-x30 kernel: hda: IC25N040ATCS04-0, ATA DISK drive
Jul 30 07:00:42 tp-x30 kernel: Using anticipatory scheduling elevator
Jul 30 07:00:42 tp-x30 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 30 07:00:42 tp-x30 kernel: hda: max request size: 128KiB
Jul 30 07:00:42 tp-x30 kernel: hda: host protected area => 1
Jul 30 07:00:42 tp-x30 kernel: hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=77520/16/63, UDMA(100)
Jul 30 07:00:42 tp-x30 sshd:  succeeded
Jul 30 07:00:42 tp-x30 kernel:  hda: hda1 hda2 hda3
Jul 30 07:00:42 tp-x30 kernel: ide-floppy driver 0.99.newide
Jul 30 07:00:42 tp-x30 kernel: input: PS/2 Generic Mouse on isa0060/serio1
Jul 30 07:00:42 tp-x30 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 30 07:00:43 tp-x30 kernel: input: AT Set 2 keyboard on isa0060/serio0
Jul 30 07:00:43 tp-x30 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 30 07:00:43 tp-x30 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jul 30 07:00:43 tp-x30 kernel: NET4: Frame Diverter 0.46
Jul 30 07:00:43 tp-x30 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jul 30 07:00:43 tp-x30 kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Jul 30 07:00:43 tp-x30 kernel: TCP: Hash tables configured (established 16384 bind 32768)
Jul 30 07:00:43 tp-x30 kernel: Linux IP multicast router 0.06 plus PIM-SM
Jul 30 07:00:43 tp-x30 kernel: Initializing IPsec netlink socket
Jul 30 07:00:43 tp-x30 kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Jul 30 07:00:43 tp-x30 kernel: md: Autodetecting RAID arrays.
Jul 30 07:00:43 tp-x30 kernel: md: autorun ...
Jul 30 07:00:43 tp-x30 kernel: md: ... autorun DONE.
Jul 30 07:00:43 tp-x30 kernel: RAMDISK: Compressed image found at block 0
Jul 30 07:00:43 tp-x30 kernel: Freeing initrd memory: 170k freed
Jul 30 07:00:43 tp-x30 kernel: VFS: Mounted root (ext2 filesystem).
Jul 30 07:00:43 tp-x30 kernel: Journalled Block Device driver loaded
Jul 30 07:00:43 tp-x30 kernel: kjournald starting.  Commit interval 5 seconds
Jul 30 07:00:43 tp-x30 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 30 07:00:43 tp-x30 kernel: Freeing unused kernel memory: 160k freed
Jul 30 07:00:43 tp-x30 kernel: drivers/usb/core/usb.c: registered new driver usbfs
Jul 30 07:00:43 tp-x30 kernel: drivers/usb/core/usb.c: registered new driver hub
Jul 30 07:00:43 tp-x30 kernel: drivers/usb/core/usb.c: registered new driver hiddev
Jul 30 07:00:43 tp-x30 kernel: drivers/usb/core/usb.c: registered new driver hid
Jul 30 07:00:44 tp-x30 kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Jul 30 07:00:44 tp-x30 kernel: mice: PS/2 mouse device common for all mice
Jul 30 07:00:44 tp-x30 kernel: EXT3 FS on hda3, internal journal
Jul 30 07:00:44 tp-x30 kernel: Adding 1050832k swap on /dev/hda2.  Priority:-1 extents:1
Jul 30 07:00:44 tp-x30 kernel: kjournald starting.  Commit interval 5 seconds
Jul 30 07:00:44 tp-x30 kernel: EXT3 FS on hda1, internal journal
Jul 30 07:00:44 tp-x30 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 30 07:00:44 tp-x30 kernel: ohci1394: $Rev: 1011 $ Ben Collins <bcollins@debian.org>
Jul 30 07:00:44 tp-x30 kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[d0205000-d02057ff]  Max Packet=[2048]
Jul 30 07:00:44 tp-x30 kernel: kudzu: numerical sysctl 1 23 is obsolete.
Jul 30 07:00:44 tp-x30 kernel: inserting floppy driver for 2.6.0-0.test2.1.28
Jul 30 07:00:44 tp-x30 kernel: Floppy drive(s): fd0 is 1.44M
Jul 30 07:00:44 tp-x30 kernel: FDC 0 is a National Semiconductor PC87306
Jul 30 07:00:44 tp-x30 kernel: kudzu: numerical sysctl 1 49 is obsolete.
Jul 30 07:00:44 tp-x30 kernel: Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Jul 30 07:00:44 tp-x30 kernel: Copyright (c) 2003 Intel Corporation
Jul 30 07:00:44 tp-x30 kernel: 
Jul 30 07:00:44 tp-x30 kernel: e100: eth0: Intel(R) PRO/100 Network Connection
Jul 30 07:00:44 tp-x30 kernel:   Hardware receive checksums enabled
Jul 30 07:00:44 tp-x30 kernel: 
Jul 30 07:00:44 tp-x30 kernel: kudzu: numerical sysctl 1 49 is obsolete.
Jul 30 07:00:44 tp-x30 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul 30 07:00:44 tp-x30 kernel: Linux Kernel Card Services 3.1.22
Jul 30 07:00:44 tp-x30 kernel:   options:  [pci] [cardbus] [pm]
Jul 30 07:00:44 tp-x30 kernel: Yenta IRQ list 0098, PCI irq11
Jul 30 07:00:44 tp-x30 kernel: Socket status: 30000006
Jul 30 07:00:44 tp-x30 kernel: Yenta IRQ list 0098, PCI irq5
Jul 30 07:00:44 tp-x30 kernel: Socket status: 30000006
Jul 30 07:00:51 tp-x30 modprobe: FATAL: Module parport_pc already in kernel. 
Jul 30 07:00:51 tp-x30 kernel: lp: driver loaded but no devices found
Jul 30 07:00:51 tp-x30 modprobe: FATAL: Module serial not found. 
Jul 30 07:00:52 tp-x30 last message repeated 27 times
Jul 30 07:00:52 tp-x30 modprobe: FATAL: Module char_major_188 not found. 
Jul 30 07:00:52 tp-x30 last message repeated 15 times
Jul 30 07:03:02 tp-x30 modprobe: FATAL: Module char_major_10_134 not found. 
Jul 30 07:03:04 tp-x30 kernel: Linux agpgart interface v0.100 (c) Dave Jones
Jul 30 07:03:30 tp-x30 kernel: Intel 810 + AC97 Audio, version 0.24, 06:20:24 Jul 30 2003
Jul 30 07:03:30 tp-x30 kernel: i810: Intel ICH3 found at IO 0x18c0 and 0x1c00, MEM 0x0000 and 0x0000, IRQ 5
Jul 30 07:03:31 tp-x30 kernel: i810_audio: Audio Controller supports 6 channels.
Jul 30 07:03:31 tp-x30 kernel: i810_audio: Defaulting to base 2 channel mode.
Jul 30 07:03:31 tp-x30 kernel: i810_audio: Resetting connection 0
Jul 30 07:03:31 tp-x30 kernel: ac97_codec: AC97 Audio codec, id: ADS114 (Unknown)
Jul 30 07:03:31 tp-x30 kernel: i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
Jul 30 07:03:31 tp-x30 kernel: i810_audio: setting clocking to 48525
Jul 30 07:03:31 tp-x30 modprobe: FATAL: Module sound_service_0_0 not found. 
Jul 30 07:04:01 tp-x30 gconfd (mgalgoci-1370): Received signal 1, shutting down cleanly
Jul 30 07:04:01 tp-x30 gconfd (mgalgoci-1370): Exiting
Jul 30 07:04:12 tp-x30 kernel: agpgart: Detected an Intel 830M Chipset.
Jul 30 07:04:12 tp-x30 kernel: agpgart: Maximum main memory to use for agp memory: 196M
Jul 30 07:04:12 tp-x30 kernel: agpgart: Detected 8060K stolen memory.
Jul 30 07:04:12 tp-x30 kernel: agpgart: AGP aperture is 128M @ 0xe0000000
Jul 30 07:04:18 tp-x30 modprobe: FATAL: Module char_major_10_134 not found. 
Jul 30 07:04:18 tp-x30 modprobe: FATAL: Module char_major_226 not found. 
Jul 30 07:04:18 tp-x30 last message repeated 3 times
Jul 30 07:04:18 tp-x30 kernel: [drm] Initialized i830 1.3.2 20021108 on minor 0
Jul 30 07:04:18 tp-x30 kernel: mtrr: base(0xe0000000) is not aligned on a size(0x300000) boundary
Jul 30 07:06:16 tp-x30 kernel: Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
Jul 30 07:06:16 tp-x30 kernel: Call Trace:
Jul 30 07:06:16 tp-x30 kernel:  [<c011a91d>] __might_sleep+0x5d/0x70
Jul 30 07:06:16 tp-x30 kernel:  [<c01173e7>] do_page_fault+0x77/0x455
Jul 30 07:06:16 tp-x30 kernel:  [<c01a5150>] __copy_to_user_ll+0x70/0x80
Jul 30 07:06:16 tp-x30 kernel:  [<c0138da2>] buffered_rmqueue+0xb2/0x150
Jul 30 07:06:16 tp-x30 kernel:  [<c0117370>] do_page_fault+0x0/0x455
Jul 30 07:06:16 tp-x30 kernel:  [<c010ad79>] error_code+0x2d/0x38
Jul 30 07:06:16 tp-x30 kernel:  [<c02a007b>] clip_neigh_solicit+0x1b/0x30
Jul 30 07:06:16 tp-x30 kernel:  [<c01af93b>] acpi_os_write_memory+0x25/0x4a
Jul 30 07:06:16 tp-x30 kernel:  [<c01ba945>] acpi_hw_low_level_write+0x48/0x9f
Jul 30 07:06:16 tp-x30 kernel:  [<c01c5301>] acpi_ec_read+0x8f/0xcc
Jul 30 07:06:16 tp-x30 kernel:  [<c01c5684>] acpi_ec_space_handler+0x57/0xa9
Jul 30 07:06:16 tp-x30 kernel:  [<c01c562d>] acpi_ec_space_handler+0x0/0xa9
Jul 30 07:06:16 tp-x30 kernel:  [<c01b334d>] acpi_ev_address_space_dispatch+0xd2/0x128
Jul 30 07:06:16 tp-x30 kernel:  [<c01b6907>] acpi_ex_access_region+0x45/0x4d
Jul 30 07:06:16 tp-x30 kernel:  [<c01b6a50>] acpi_ex_field_datum_io+0x107/0x177
Jul 30 07:06:16 tp-x30 kernel:  [<c01b6ce1>] acpi_ex_extract_from_field+0x84/0x24d
Jul 30 07:06:16 tp-x30 kernel:  [<c01b5768>] acpi_ex_read_data_from_field+0x110/0x142
Jul 30 07:06:16 tp-x30 kernel:  [<c01b9d98>] acpi_ex_resolve_node_to_value+0xa8/0xd0
Jul 30 07:06:16 tp-x30 kernel:  [<c01b5edb>] acpi_ex_resolve_to_value+0x3b/0x46
Jul 30 07:06:16 tp-x30 kernel:  [<c01b7f12>] acpi_ex_resolve_operands+0x194/0x2de
Jul 30 07:06:16 tp-x30 kernel:  [<c01b140d>] acpi_ds_exec_end_op+0x91/0x228
Jul 30 07:06:16 tp-x30 kernel:  [<c01be121>] acpi_ps_parse_loop+0x518/0x823
Jul 30 07:06:16 tp-x30 kernel:  [<c01afd4a>] acpi_os_wait_semaphore+0x71/0xd3
Jul 30 07:06:16 tp-x30 kernel:  [<c01c356e>] acpi_ut_acquire_mutex+0x5c/0x72
Jul 30 07:06:16 tp-x30 kernel:  [<c01afd4a>] acpi_os_wait_semaphore+0x71/0xd3
Jul 30 07:06:16 tp-x30 kernel:  [<c01c356e>] acpi_ut_acquire_mutex+0x5c/0x72
Jul 30 07:06:16 tp-x30 kernel:  [<c01c35eb>] acpi_ut_release_mutex+0x67/0x6c
Jul 30 07:06:16 tp-x30 kernel:  [<c01c2722>] acpi_ut_acquire_from_cache+0x48/0xa2
Jul 30 07:06:16 tp-x30 kernel:  [<c01be47a>] acpi_ps_parse_aml+0x4e/0x17c
Jul 30 07:06:16 tp-x30 kernel:  [<c01bed29>] acpi_psx_execute+0x155/0x1a0
Jul 30 07:06:16 tp-x30 kernel:  [<c01bc0c9>] acpi_ns_execute_control_method+0x43/0x52
Jul 30 07:06:16 tp-x30 kernel:  [<c01bc062>] acpi_ns_evaluate_by_handle+0x6f/0x93
Jul 30 07:06:16 tp-x30 kernel:  [<c01bbf55>] acpi_ns_evaluate_relative+0x9d/0xb4
Jul 30 07:06:16 tp-x30 kernel:  [<c01afd4a>] acpi_os_wait_semaphore+0x71/0xd3
Jul 30 07:06:16 tp-x30 kernel:  [<c01c356e>] acpi_ut_acquire_mutex+0x5c/0x72
Jul 30 07:06:16 tp-x30 kernel:  [<c01bb854>] acpi_evaluate_object+0x10f/0x1be
Jul 30 07:06:16 tp-x30 kernel:  [<c01c371d>] acpi_ut_delete_generic_state+0xb/0xe
Jul 30 07:06:16 tp-x30 kernel:  [<c01b0118>] acpi_evaluate_integer+0x34/0x56
Jul 30 07:06:16 tp-x30 kernel:  [<c01bb8e9>] acpi_evaluate_object+0x1a4/0x1be
Jul 30 07:06:16 tp-x30 kernel:  [<d083c510>] acpi_processor_get_platform_limit+0x27/0x4c [processor]
Jul 30 07:06:16 tp-x30 kernel:  [<d083d274>] acpi_processor_get_info+0xe9/0x102 [processor]
Jul 30 07:06:16 tp-x30 kernel:  [<d083d37b>] acpi_processor_add+0x83/0x16f [processor]
Jul 30 07:06:16 tp-x30 kernel:  [<c01c785c>] acpi_bus_driver_init+0x2c/0x8a
Jul 30 07:06:16 tp-x30 kernel:  [<c01c78f5>] acpi_driver_attach+0x3b/0x58
Jul 30 07:06:16 tp-x30 kernel:  [<c01c7995>] acpi_bus_register_driver+0x27/0x33
Jul 30 07:06:16 tp-x30 kernel:  [<d082e043>] acpi_processor_init+0x43/0x65 [processor]
Jul 30 07:06:16 tp-x30 kernel:  [<c01312fb>] sys_init_module+0x10b/0x200
Jul 30 07:06:16 tp-x30 kernel:  [<c010ab7d>] sysenter_past_esp+0x52/0x71
Jul 30 07:06:16 tp-x30 kernel: 
Jul 30 07:06:17 tp-x30 kernel: Unable to handle kernel paging request at virtual address 1a5a5a5a
Jul 30 07:06:17 tp-x30 kernel:  printing eip:
Jul 30 07:06:17 tp-x30 kernel: c01af93b
Jul 30 07:06:17 tp-x30 kernel: *pde = 00000000
Jul 30 07:06:17 tp-x30 kernel: Oops: 0002 [#1]
Jul 30 07:06:17 tp-x30 kernel: CPU:    0
Jul 30 07:06:17 tp-x30 kernel: EIP:    0060:[<c01af93b>]    Not tainted
Jul 30 07:06:17 tp-x30 kernel: EFLAGS: 00010046
Jul 30 07:06:17 tp-x30 kernel: EIP is at acpi_os_write_memory+0x25/0x4a
Jul 30 07:06:17 tp-x30 kernel: eax: 5a5a5a5a   ebx: 00000034   ecx: 00000008   edx: 5a5a5a5a
Jul 30 07:06:17 tp-x30 kernel: esi: 00000008   edi: 00000034   ebp: 00000246   esp: c39e1b40
Jul 30 07:06:17 tp-x30 kernel: ds: 007b   es: 007b   ss: 0068
Jul 30 07:06:17 tp-x30 kernel: Process modprobe (pid: 1723, threadinfo=c39e0000 task=c4050780)
Jul 30 07:06:17 tp-x30 kernel: Stack: c13a5b8c c01ba945 5a5a5a5a 5a5a5a5a 00000034 00000008 00000034 00000034 
Jul 30 07:06:17 tp-x30 kernel:        00000000 c13a5b68 c13a5b8c c01c5301 00000008 00000034 c13a5b8c 34000034 
Jul 30 07:06:17 tp-x30 kernel:        00000018 c39e1c80 c13a5b68 cf68d234 cf690908 c01c5684 c13a5b68 00000034 
Jul 30 07:06:17 tp-x30 kernel: Call Trace:
Jul 30 07:06:17 tp-x30 kernel:  [<c01ba945>] acpi_hw_low_level_write+0x48/0x9f
Jul 30 07:06:17 tp-x30 kernel:  [<c01c5301>] acpi_ec_read+0x8f/0xcc
Jul 30 07:06:17 tp-x30 kernel:  [<c01c5684>] acpi_ec_space_handler+0x57/0xa9
Jul 30 07:06:17 tp-x30 kernel:  [<c01c562d>] acpi_ec_space_handler+0x0/0xa9
Jul 30 07:06:17 tp-x30 kernel:  [<c01b334d>] acpi_ev_address_space_dispatch+0xd2/0x128
Jul 30 07:06:17 tp-x30 kernel:  [<c01b6907>] acpi_ex_access_region+0x45/0x4d
Jul 30 07:06:17 tp-x30 kernel:  [<c01b6a50>] acpi_ex_field_datum_io+0x107/0x177
Jul 30 07:06:17 tp-x30 kernel:  [<c01b6ce1>] acpi_ex_extract_from_field+0x84/0x24d
Jul 30 07:06:17 tp-x30 kernel:  [<c01b5768>] acpi_ex_read_data_from_field+0x110/0x142
Jul 30 07:06:17 tp-x30 kernel:  [<c01b9d98>] acpi_ex_resolve_node_to_value+0xa8/0xd0
Jul 30 07:06:17 tp-x30 kernel:  [<c01b5edb>] acpi_ex_resolve_to_value+0x3b/0x46
Jul 30 07:06:17 tp-x30 kernel:  [<c01b7f12>] acpi_ex_resolve_operands+0x194/0x2de
Jul 30 07:06:17 tp-x30 kernel:  [<c01b140d>] acpi_ds_exec_end_op+0x91/0x228
Jul 30 07:06:17 tp-x30 kernel:  [<c01be121>] acpi_ps_parse_loop+0x518/0x823
Jul 30 07:06:17 tp-x30 kernel:  [<c01afd4a>] acpi_os_wait_semaphore+0x71/0xd3
Jul 30 07:06:17 tp-x30 kernel:  [<c01c356e>] acpi_ut_acquire_mutex+0x5c/0x72
Jul 30 07:06:17 tp-x30 kernel:  [<c01afd4a>] acpi_os_wait_semaphore+0x71/0xd3
Jul 30 07:06:17 tp-x30 kernel:  [<c01c356e>] acpi_ut_acquire_mutex+0x5c/0x72
Jul 30 07:06:17 tp-x30 kernel:  [<c01c35eb>] acpi_ut_release_mutex+0x67/0x6c
Jul 30 07:06:17 tp-x30 kernel:  [<c01c2722>] acpi_ut_acquire_from_cache+0x48/0xa2
Jul 30 07:06:17 tp-x30 kernel:  [<c01be47a>] acpi_ps_parse_aml+0x4e/0x17c
Jul 30 07:06:17 tp-x30 kernel:  [<c01bed29>] acpi_psx_execute+0x155/0x1a0
Jul 30 07:06:17 tp-x30 kernel:  [<c01bc0c9>] acpi_ns_execute_control_method+0x43/0x52
Jul 30 07:06:17 tp-x30 kernel:  [<c01bc062>] acpi_ns_evaluate_by_handle+0x6f/0x93
Jul 30 07:06:17 tp-x30 kernel:  [<c01bbf55>] acpi_ns_evaluate_relative+0x9d/0xb4
Jul 30 07:06:17 tp-x30 kernel:  [<c01afd4a>] acpi_os_wait_semaphore+0x71/0xd3
Jul 30 07:06:17 tp-x30 kernel:  [<c01c356e>] acpi_ut_acquire_mutex+0x5c/0x72
Jul 30 07:06:17 tp-x30 kernel:  [<c01bb854>] acpi_evaluate_object+0x10f/0x1be
Jul 30 07:06:17 tp-x30 kernel:  [<c01c371d>] acpi_ut_delete_generic_state+0xb/0xe
Jul 30 07:06:17 tp-x30 kernel:  [<c01b0118>] acpi_evaluate_integer+0x34/0x56
Jul 30 07:06:17 tp-x30 kernel:  [<c01bb8e9>] acpi_evaluate_object+0x1a4/0x1be
Jul 30 07:06:17 tp-x30 kernel:  [<d083c510>] acpi_processor_get_platform_limit+0x27/0x4c [processor]
Jul 30 07:06:17 tp-x30 kernel:  [<d083d274>] acpi_processor_get_info+0xe9/0x102 [processor]
Jul 30 07:06:17 tp-x30 kernel:  [<d083d37b>] acpi_processor_add+0x83/0x16f [processor]
Jul 30 07:06:17 tp-x30 kernel:  [<c01c785c>] acpi_bus_driver_init+0x2c/0x8a
Jul 30 07:06:17 tp-x30 kernel:  [<c01c78f5>] acpi_driver_attach+0x3b/0x58
Jul 30 07:06:17 tp-x30 kernel:  [<c01c7995>] acpi_bus_register_driver+0x27/0x33
Jul 30 07:06:17 tp-x30 kernel:  [<d082e043>] acpi_processor_init+0x43/0x65 [processor]
Jul 30 07:06:17 tp-x30 kernel:  [<c01312fb>] sys_init_module+0x10b/0x200
Jul 30 07:06:17 tp-x30 kernel:  [<c010ab7d>] sysenter_past_esp+0x52/0x71
Jul 30 07:06:17 tp-x30 kernel: 
Jul 30 07:06:17 tp-x30 kernel: Code: 88 98 00 00 00 c0 eb 19 66 89 98 00 00 00 c0 eb 10 89 98 00 

Regards,

Matthew Galgoci



