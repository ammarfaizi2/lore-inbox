Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUBDS4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUBDS4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:56:35 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:54913 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263618AbUBDSzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:55:50 -0500
Date: Wed, 04 Feb 2004 10:55:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: diannibd@yahoo.com
Subject: [Bug 2013] New: Oops from create_dir (sysfs)
Message-ID: <31580000.1075920946@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2013

           Summary: Oops:  EIP is at create_dir+0x17/0x9c
    Kernel Version: 2.6.2
            Status: NEW
          Severity: normal
             Owner: other_modules@kernel-bugs.osdl.org
         Submitter: diannibd@yahoo.com


Distribution: Debian Unstable
Hardware Environment: IBM A31p 

Trace output..


Problem Description:
Feb  4 12:56:29 bdianni-lnx kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000008
Feb  4 12:56:29 bdianni-lnx kernel:  printing eip:
Feb  4 12:56:29 bdianni-lnx kernel: c017e6d8
Feb  4 12:56:29 bdianni-lnx kernel: *pde = 00000000
Feb  4 12:56:29 bdianni-lnx kernel: Oops: 0000 [#1]
Feb  4 12:56:29 bdianni-lnx kernel: CPU:    0
Feb  4 12:56:29 bdianni-lnx kernel: EIP:    0060:[create_dir+23/156]    Not tainted 
Feb  4 12:56:29 bdianni-lnx kernel: EFLAGS: 00010286
Feb  4 12:56:29 bdianni-lnx kernel: EIP is at create_dir+0x17/0x9c
Feb  4 12:56:29 bdianni-lnx kernel: eax: f7d5bf50   ebx: f884a530   ecx:
00000000   edx: f884a534
Feb  4 12:56:29 bdianni-lnx kernel: esi: 00000000   edi: f7d5bf50   ebp:
f7d5a000   esp: f7d5bf24
Feb  4 12:56:29 bdianni-lnx kernel: ds: 007b   es: 007b   ss: 0068
Feb  4 12:56:29 bdianni-lnx kernel: Process modprobe (pid: 49,
threadinfo=f7d5a000 task=c1b1e6a0)
Feb  4 12:56:29 bdianni-lnx kernel: Stack: f884a494 f884a494 c0335af0 f884a530
f884a530 f884a494 c017e7c7 f884a530
Feb  4 12:56:29 bdianni-lnx kernel:        00000000 f884a534 f7d5bf50 00000000
00000000 c01c1a55 f884a530 f884a530
Feb  4 12:56:29 bdianni-lnx kernel:        f884a484 c01c1f38 f884a530 f884a520
f884a480 f884a484 c02fdf38 c01ef464
Feb  4 12:56:29 bdianni-lnx kernel: Call Trace:
Feb  4 12:56:29 bdianni-lnx kernel:  [sysfs_create_dir+64/115]
sysfs_create_dir+0x40/0x73
Feb  4 12:56:29 bdianni-lnx kernel:  [create_dir+31/75] create_dir+0x1f/0x4b
Feb  4 12:56:29 bdianni-lnx kernel:  [kobject_add+147/221] kobject_add+0x93/0xdd
Feb  4 12:56:29 bdianni-lnx kernel:  [bus_register+92/146] bus_register+0x5c/0x92
Feb  4 12:56:29 bdianni-lnx kernel:  [_end+944270554/1070058664]
usb_init+0x32/0x54 [usbcore]
Feb  4 12:56:29 bdianni-lnx kernel:  [sys_init_module+302/587]
sys_init_module+0x12e/0x24b
Feb  4 12:56:29 bdianni-lnx kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb  4 12:56:29 bdianni-lnx kernel: 
Feb  4 12:56:29 bdianni-lnx kernel: Code: 8b 46 08 8d 48 68 ff 48 68 0f 88 4d 03
00 00 8b 44 24 24 89


Boot log..

Feb  4 12:56:28 bdianni-lnx kernel: klogd 1.4.1#13, log source = /proc/kmsg started.
Feb  4 12:56:28 bdianni-lnx kernel: Inspecting /boot/System.map-2.6.2
Feb  4 12:56:29 bdianni-lnx kernel: Loaded 21590 symbols from
/boot/System.map-2.6.2.
Feb  4 12:56:29 bdianni-lnx kernel: Symbols match kernel version 2.6.2.
Feb  4 12:56:29 bdianni-lnx kernel: No module symbols loaded - kernel modules
not enabled.
Feb  4 12:56:29 bdianni-lnx kernel: Linux version 2.6.2 (root@bdianni-lnx) (gcc
version 3.2.3 (Debian)) #2 Wed Feb 4 11:54:25 EST 2004
Feb  4 12:56:29 bdianni-lnx kernel: BIOS-provided physical RAM map:
Feb  4 12:56:29 bdianni-lnx kernel:  BIOS-e820: 0000000000000000 -
000000000009f000 (usable)
Feb  4 12:56:29 bdianni-lnx kernel:  BIOS-e820: 000000000009f000 -
00000000000a0000 (reserved)
Feb  4 12:56:29 bdianni-lnx kernel:  BIOS-e820: 00000000000d2000 -
00000000000d4000 (reserved)
Feb  4 12:56:29 bdianni-lnx kernel:  BIOS-e820: 00000000000dc000 -
0000000000100000 (reserved)
Feb  4 12:56:29 bdianni-lnx kernel:  BIOS-e820: 0000000000100000 -
000000003ff70000 (usable)
Feb  4 12:56:29 bdianni-lnx kernel:  BIOS-e820: 000000003ff70000 -
000000003ff7e000 (ACPI data)
Feb  4 12:56:29 bdianni-lnx kernel:  BIOS-e820: 000000003ff7e000 -
000000003ff80000 (ACPI NVS)
Feb  4 12:56:29 bdianni-lnx kernel:  BIOS-e820: 000000003ff80000 -
0000000040000000 (reserved)
Feb  4 12:56:29 bdianni-lnx kernel:  BIOS-e820: 00000000ff800000 -
0000000100000000 (reserved)
Feb  4 12:56:29 bdianni-lnx kernel: user-defined physical RAM map:
Feb  4 12:56:29 bdianni-lnx kernel:  user: 0000000000000000 - 000000000009f000
(usable)
Feb  4 12:56:29 bdianni-lnx kernel:  user: 000000000009f000 - 00000000000a0000
(reserved)
Feb  4 12:56:29 bdianni-lnx kernel:  user: 00000000000d2000 - 00000000000d4000
(reserved)
Feb  4 12:56:29 bdianni-lnx kernel:  user: 00000000000dc000 - 0000000000100000
(reserved)
Feb  4 12:56:29 bdianni-lnx kernel:  user: 0000000000100000 - 000000003ff70000
(usable)
Feb  4 12:56:29 bdianni-lnx kernel: 127MB HIGHMEM available.
Feb  4 12:56:29 bdianni-lnx kernel: 896MB LOWMEM available.
Feb  4 12:56:29 bdianni-lnx kernel: On node 0 totalpages: 262000
Feb  4 12:56:29 bdianni-lnx kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb  4 12:56:29 bdianni-lnx kernel:   Normal zone: 225280 pages, LIFO batch:16
Feb  4 12:56:29 bdianni-lnx kernel:   HighMem zone: 32624 pages, LIFO batch:7
Feb  4 12:56:29 bdianni-lnx kernel: DMI present.
Feb  4 12:56:29 bdianni-lnx kernel: IBM machine detected. Enabling interrupts
during APM calls.
Feb  4 12:56:29 bdianni-lnx kernel: IBM machine detected. Disabling SMBus accesses.
Feb  4 12:56:29 bdianni-lnx kernel: Building zonelist for node : 0
Feb  4 12:56:29 bdianni-lnx kernel: Kernel command line: acpi=off root=/dev/hda1
ro mem=1048000K
Feb  4 12:56:29 bdianni-lnx kernel: Initializing CPU#0
Feb  4 12:56:29 bdianni-lnx kernel: PID hash table entries: 4096 (order 12:
32768 bytes)
Feb  4 12:56:29 bdianni-lnx kernel: Detected 1998.623 MHz processor.
Feb  4 12:56:29 bdianni-lnx kernel: Using tsc for high-res timesource
Feb  4 12:56:29 bdianni-lnx kernel: Console: colour VGA+ 80x25
Feb  4 12:56:29 bdianni-lnx kernel: Memory: 1033888k/1048000k available (1742k
kernel code, 13176k reserved, 714k data, 108k init, 130496k highmem)
Feb  4 12:56:29 bdianni-lnx kernel: Checking if this processor honours the WP
bit even in supervisor mode... Ok.
Feb  4 12:56:29 bdianni-lnx kernel: Calibrating delay loop... 3948.54 BogoMIPS
Feb  4 12:56:29 bdianni-lnx kernel: Dentry cache hash table entries: 131072
(order: 7, 524288 bytes)
Feb  4 12:56:29 bdianni-lnx kernel: Inode-cache hash table entries: 65536
(order: 6, 262144 bytes)
Feb  4 12:56:29 bdianni-lnx kernel: Mount-cache hash table entries: 512 (order:
0, 4096 bytes)
Feb  4 12:56:29 bdianni-lnx kernel: CPU:     After generic identify, caps:
bfebf9ff 00000000 00000000 00000000
Feb  4 12:56:29 bdianni-lnx kernel: CPU:     After vendor identify, caps:
bfebf9ff 00000000 00000000 00000000
Feb  4 12:56:29 bdianni-lnx kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Feb  4 12:56:29 bdianni-lnx kernel: CPU: L2 cache: 512K
Feb  4 12:56:29 bdianni-lnx kernel: CPU:     After all inits, caps: bfebf9ff
00000000 00000000 00000080
Feb  4 12:56:29 bdianni-lnx kernel: Intel machine check architecture supported.
Feb  4 12:56:29 bdianni-lnx kernel: Intel machine check reporting enabled on CPU#0.
Feb  4 12:56:29 bdianni-lnx kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs (12)
available
Feb  4 12:56:29 bdianni-lnx kernel: CPU: Intel Mobile Intel(R) Pentium(R) 4 - M
CPU 2.00GHz stepping 07
Feb  4 12:56:29 bdianni-lnx kernel: Enabling fast FPU save and restore... done.
Feb  4 12:56:29 bdianni-lnx kernel: Enabling unmasked SIMD FPU exception
support... done.
Feb  4 12:56:29 bdianni-lnx kernel: Checking 'hlt' instruction... OK.
Feb  4 12:56:29 bdianni-lnx kernel: POSIX conformance testing by UNIFIX
Feb  4 12:56:29 bdianni-lnx kernel: NET: Registered protocol family 16
Feb  4 12:56:29 bdianni-lnx kernel: PCI: PCI BIOS revision 2.10 entry at
0xfd8fe, last bus=8
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Using configuration type 1
Feb  4 12:56:29 bdianni-lnx kernel: mtrr: v2.0 (20020519)
Feb  4 12:56:29 bdianni-lnx kernel: Linux Kernel Card Services
Feb  4 12:56:29 bdianni-lnx kernel:   options:  [pci] [cardbus] [pm]
Feb  4 12:56:29 bdianni-lnx kernel: drivers/usb/core/usb.c: registered new
driver usbfs
Feb  4 12:56:29 bdianni-lnx kernel: drivers/usb/core/usb.c: registered new
driver hub
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Probing PCI hardware
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Probing PCI hardware (bus 00)
Feb  4 12:56:29 bdianni-lnx kernel: Transparent bridge - 0000:00:1e.0
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Discovered primary peer bus 09 [IRQ]
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Using IRQ router PIIX/ICH [8086/248c]
at 0000:00:1f.0
Feb  4 12:56:29 bdianni-lnx kernel: PCI: IRQ 0 for device 0000:00:1f.1 doesn't
match PIRQ mask - try pci=usepirqmask
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Found IRQ 11 for device 0000:00:1f.1
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:00:1d.2
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:02:00.2
Feb  4 12:56:29 bdianni-lnx kernel: SBF: Simple Boot Flag extension found and
enabled.
Feb  4 12:56:29 bdianni-lnx kernel: SBF: Setting boot flags 0x1
Feb  4 12:56:29 bdianni-lnx kernel: ikconfig 0.7 with /proc/config*
Feb  4 12:56:29 bdianni-lnx kernel: highmem bounce pool size: 64 pages
Feb  4 12:56:29 bdianni-lnx kernel: udf: registering filesystem
Feb  4 12:56:29 bdianni-lnx kernel: pty: 256 Unix98 ptys configured
Feb  4 12:56:29 bdianni-lnx kernel: Real Time Clock Driver v1.12
Feb  4 12:56:29 bdianni-lnx kernel: Non-volatile memory driver v1.2
Feb  4 12:56:29 bdianni-lnx kernel: hw_random hardware driver 1.0.0 loaded
Feb  4 12:56:29 bdianni-lnx kernel: Linux agpgart interface v0.100 (c) Dave Jones
Feb  4 12:56:29 bdianni-lnx kernel: Serial: 8250/16550 driver $Revision: 1.90 $
8 ports, IRQ sharing disabled
Feb  4 12:56:29 bdianni-lnx kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Found IRQ 11 for device 0000:00:1f.6
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:00:1f.3
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:00:1f.5
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:02:00.1
Feb  4 12:56:29 bdianni-lnx kernel: Using anticipatory io scheduler
Feb  4 12:56:29 bdianni-lnx kernel: Floppy drive(s): fd0 is 1.44M
Feb  4 12:56:29 bdianni-lnx kernel: FDC 0 is a National Semiconductor PC87306
Feb  4 12:56:29 bdianni-lnx kernel: Intel(R) PRO/100 Network Driver - version
2.3.30-k1
Feb  4 12:56:29 bdianni-lnx kernel: Copyright (c) 2003 Intel Corporation
Feb  4 12:56:29 bdianni-lnx kernel:
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Found IRQ 11 for device 0000:02:08.0
Feb  4 12:56:29 bdianni-lnx kernel: e100: selftest OK.
Feb  4 12:56:29 bdianni-lnx kernel: e100: eth0: Intel(R) PRO/100 Network Connection
Feb  4 12:56:29 bdianni-lnx kernel:   Hardware receive checksums enabled
Feb  4 12:56:29 bdianni-lnx kernel:
Feb  4 12:56:29 bdianni-lnx kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Feb  4 12:56:29 bdianni-lnx kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Feb  4 12:56:29 bdianni-lnx kernel: ICH3M: IDE controller at PCI slot 0000:00:1f.1
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Found IRQ 11 for device 0000:00:1f.1
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:00:1d.2
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:02:00.2
Feb  4 12:56:29 bdianni-lnx kernel: ICH3M: chipset revision 2
Feb  4 12:56:29 bdianni-lnx kernel: ICH3M: not 100%% native mode: will probe
irqs later
Feb  4 12:56:29 bdianni-lnx kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS
settings: hda:DMA, hdb:pio
Feb  4 12:56:29 bdianni-lnx kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS
settings: hdc:DMA, hdd:pio
Feb  4 12:56:29 bdianni-lnx kernel: hda: IC25N040ATCS04-0, ATA DISK drive
Feb  4 12:56:29 bdianni-lnx kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  4 12:56:29 bdianni-lnx kernel: hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N,
ATAPI CD/DVD-ROM drive
Feb  4 12:56:29 bdianni-lnx kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb  4 12:56:29 bdianni-lnx kernel: hda: max request size: 128KiB
Feb  4 12:56:29 bdianni-lnx kernel: hda: 78140160 sectors (40007 MB) w/1768KiB
Cache, CHS=65535/16/63, UDMA(100)
Feb  4 12:56:29 bdianni-lnx kernel:  hda: hda1 hda2
Feb  4 12:56:29 bdianni-lnx kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB
Cache, UDMA(33)
Feb  4 12:56:29 bdianni-lnx kernel: Uniform CD-ROM driver Revision: 3.20
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Found IRQ 11 for device 0000:02:00.0
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:00:1d.0
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:01:00.0
Feb  4 12:56:29 bdianni-lnx kernel: Yenta: CardBus bridge found at 0000:02:00.0
[1014:0185]
Feb  4 12:56:29 bdianni-lnx kernel: Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Feb  4 12:56:29 bdianni-lnx kernel: Socket status: 30000006
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Found IRQ 11 for device 0000:02:00.1
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:00:1f.3
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:00:1f.5
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:00:1f.6
Feb  4 12:56:29 bdianni-lnx kernel: Yenta: CardBus bridge found at 0000:02:00.1
[1014:0185]
Feb  4 12:56:29 bdianni-lnx kernel: Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Feb  4 12:56:29 bdianni-lnx kernel: Socket status: 30000006
Feb  4 12:56:29 bdianni-lnx kernel: drivers/usb/host/uhci-hcd.c: USB Universal
Host Controller Interface driver v2.1
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Found IRQ 11 for device 0000:00:1d.0
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:01:00.0
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:02:00.0
Feb  4 12:56:29 bdianni-lnx kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Feb  4 12:56:29 bdianni-lnx kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
Feb  4 12:56:29 bdianni-lnx kernel: uhci_hcd 0000:00:1d.0: new USB bus
registered, assigned bus number 1
Feb  4 12:56:29 bdianni-lnx kernel: hub 1-0:1.0: USB hub found
Feb  4 12:56:29 bdianni-lnx kernel: hub 1-0:1.0: 2 ports detected
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Found IRQ 11 for device 0000:00:1d.1
Feb  4 12:56:29 bdianni-lnx kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Feb  4 12:56:29 bdianni-lnx kernel: uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
Feb  4 12:56:29 bdianni-lnx kernel: uhci_hcd 0000:00:1d.1: new USB bus
registered, assigned bus number 2
Feb  4 12:56:29 bdianni-lnx kernel: hub 2-0:1.0: USB hub found
Feb  4 12:56:29 bdianni-lnx kernel: hub 2-0:1.0: 2 ports detected
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Found IRQ 11 for device 0000:00:1d.2
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:00:1f.1
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:02:00.2
Feb  4 12:56:29 bdianni-lnx kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Feb  4 12:56:29 bdianni-lnx kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
Feb  4 12:56:29 bdianni-lnx kernel: uhci_hcd 0000:00:1d.2: new USB bus
registered, assigned bus number 3
Feb  4 12:56:29 bdianni-lnx kernel: hub 3-0:1.0: USB hub found
Feb  4 12:56:29 bdianni-lnx kernel: hub 3-0:1.0: 2 ports detected
Feb  4 12:56:29 bdianni-lnx kernel: drivers/usb/core/usb.c: registered new
driver hid
Feb  4 12:56:29 bdianni-lnx kernel: drivers/usb/input/hid-core.c: v2.0:USB HID
core driver
Feb  4 12:56:29 bdianni-lnx kernel: mice: PS/2 mouse device common for all mice
Feb  4 12:56:29 bdianni-lnx kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  4 12:56:29 bdianni-lnx kernel: input: PS/2 Generic Mouse on isa0060/serio1
Feb  4 12:56:29 bdianni-lnx kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  4 12:56:29 bdianni-lnx kernel: input: AT Translated Set 2 keyboard on
isa0060/serio0
Feb  4 12:56:29 bdianni-lnx kernel: NET: Registered protocol family 2
Feb  4 12:56:29 bdianni-lnx kernel: IP: routing cache hash table of 8192
buckets, 64Kbytes
Feb  4 12:56:29 bdianni-lnx kernel: TCP: Hash tables configured (established
262144 bind 65536)
Feb  4 12:56:29 bdianni-lnx kernel: kjournald starting.  Commit interval 5 seconds
Feb  4 12:56:29 bdianni-lnx kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Feb  4 12:56:29 bdianni-lnx kernel: VFS: Mounted root (ext3 filesystem) readonly.
Feb  4 12:56:29 bdianni-lnx kernel: Freeing unused kernel memory: 108k freed
Feb  4 12:56:29 bdianni-lnx kernel: hub 1-0:1.0: new USB device on port 1,
assigned address 2
Feb  4 12:56:29 bdianni-lnx kernel: input: USB HID v1.10 Mouse [Logitech USB
Mouse] on usb-0000:00:1d.0-1
Feb  4 12:56:29 bdianni-lnx kernel: NET: Registered protocol family 1
Feb  4 12:56:29 bdianni-lnx kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000008
Feb  4 12:56:29 bdianni-lnx kernel:  printing eip:
Feb  4 12:56:29 bdianni-lnx kernel: c017e6d8
Feb  4 12:56:29 bdianni-lnx kernel: *pde = 00000000
Feb  4 12:56:29 bdianni-lnx kernel: Oops: 0000 [#1]
Feb  4 12:56:29 bdianni-lnx kernel: CPU:    0
Feb  4 12:56:29 bdianni-lnx kernel: EIP:    0060:[create_dir+23/156]    Not tainted
Feb  4 12:56:29 bdianni-lnx kernel: EFLAGS: 00010286
Feb  4 12:56:29 bdianni-lnx kernel: EIP is at create_dir+0x17/0x9c
Feb  4 12:56:29 bdianni-lnx kernel: eax: f7d5bf50   ebx: f884a530   ecx:
00000000   edx: f884a534
Feb  4 12:56:29 bdianni-lnx kernel: esi: 00000000   edi: f7d5bf50   ebp:
f7d5a000   esp: f7d5bf24
Feb  4 12:56:29 bdianni-lnx kernel: ds: 007b   es: 007b   ss: 0068
Feb  4 12:56:29 bdianni-lnx kernel: Process modprobe (pid: 49,
threadinfo=f7d5a000 task=c1b1e6a0)
Feb  4 12:56:29 bdianni-lnx kernel: Stack: f884a494 f884a494 c0335af0 f884a530
f884a530 f884a494 c017e7c7 f884a530
Feb  4 12:56:29 bdianni-lnx kernel:        00000000 f884a534 f7d5bf50 00000000
00000000 c01c1a55 f884a530 f884a530
Feb  4 12:56:29 bdianni-lnx kernel:        f884a484 c01c1f38 f884a530 f884a520
f884a480 f884a484 c02fdf38 c01ef464
Feb  4 12:56:29 bdianni-lnx kernel: Call Trace:
Feb  4 12:56:29 bdianni-lnx kernel:  [sysfs_create_dir+64/115]
sysfs_create_dir+0x40/0x73
Feb  4 12:56:29 bdianni-lnx kernel:  [create_dir+31/75] create_dir+0x1f/0x4b
Feb  4 12:56:29 bdianni-lnx kernel:  [kobject_add+147/221] kobject_add+0x93/0xdd
Feb  4 12:56:29 bdianni-lnx kernel:  [bus_register+92/146] bus_register+0x5c/0x92
Feb  4 12:56:29 bdianni-lnx kernel:  [_end+944270554/1070058664]
usb_init+0x32/0x54 [usbcore]
Feb  4 12:56:29 bdianni-lnx kernel:  [sys_init_module+302/587]
sys_init_module+0x12e/0x24b
Feb  4 12:56:29 bdianni-lnx kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb  4 12:56:29 bdianni-lnx kernel:
Feb  4 12:56:29 bdianni-lnx kernel: Code: 8b 46 08 8d 48 68 ff 48 68 0f 88 4d 03
00 00 8b 44 24 24 89
Feb  4 12:56:29 bdianni-lnx kernel:  <6>Adding 249472k swap on /dev/hda2. 
Priority:-1 extents:1
Feb  4 12:56:29 bdianni-lnx kernel: EXT3 FS on hda1, internal journal
Feb  4 12:56:29 bdianni-lnx kernel: Intel 810 + AC97 Audio, version 0.24,
00:28:00 Feb  4 2004
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Found IRQ 11 for device 0000:00:1f.5
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:00:1f.3
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:00:1f.6
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Sharing IRQ 11 with 0000:02:00.1
Feb  4 12:56:29 bdianni-lnx kernel: PCI: Setting latency timer of device
0000:00:1f.5 to 64
Feb  4 12:56:29 bdianni-lnx kernel: i810: Intel ICH3 found at IO 0x18c0 and
0x1c00, MEM 0x0000 and 0x0000, IRQ 11
Feb  4 12:56:29 bdianni-lnx kernel: i810_audio: Audio Controller supports 6
channels.
Feb  4 12:56:29 bdianni-lnx kernel: i810_audio: Defaulting to base 2 channel mode.
Feb  4 12:56:29 bdianni-lnx kernel: i810_audio: Resetting connection 0
Feb  4 12:56:29 bdianni-lnx kernel: ac97_codec: AC97 Audio codec, id: ADS72
(Analog Devices AD1881A)
Feb  4 12:56:29 bdianni-lnx kernel: i810_audio: AC'97 codec 0 Unable to map
surround DAC's (or DAC's not present), total channels = 2
Feb  4 12:56:29 bdianni-lnx kernel: i810_audio: setting clocking to 48607
Feb  4 12:56:30 bdianni-lnx kernel: apm: BIOS version 1.2 Flags 0x03 (Driver
version 1.16ac)
Feb  4 12:56:38 bdianni-lnx kernel: kobject_register failed for hid (-17)
Feb  4 12:56:38 bdianni-lnx kernel: Call Trace:
Feb  4 12:56:38 bdianni-lnx kernel:  [kobject_register+82/91]
kobject_register+0x52/0x5b
Feb  4 12:56:38 bdianni-lnx kernel:  [bus_add_driver+74/157]
bus_add_driver+0x4a/0x9d
Feb  4 12:56:38 bdianni-lnx kernel:  [driver_register+47/51]
driver_register+0x2f/0x33
Feb  4 12:56:38 bdianni-lnx kernel:  [input_event+321/1016] usb_register+0x50/0x9b
Feb  4 12:56:38 bdianni-lnx kernel:  [_end+944430263/1070058664]
hid_init+0xf/0x2f [hid]
Feb  4 12:56:38 bdianni-lnx kernel:  [sys_init_module+302/587]
sys_init_module+0x12e/0x24b
Feb  4 12:56:38 bdianni-lnx kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb  4 12:56:38 bdianni-lnx kernel:
Feb  4 12:56:38 bdianni-lnx kernel: drivers/usb/core/usb.c: problem -17 when
registering driver hid
Feb  4 12:56:38 bdianni-lnx kernel: vmmon: module license 'unspecified' taints
kernel.
Feb  4 12:56:38 bdianni-lnx kernel: /dev/vmmon: Module vmmon: registered with
major=10 minor=165
Feb  4 12:56:38 bdianni-lnx kernel: /dev/vmmon: Module vmmon: initialized
Feb  4 12:56:38 bdianni-lnx kernel: vmnet: module license 'unspecified' taints
kernel.
Feb  4 12:56:38 bdianni-lnx kernel: /dev/vmnet: open called by PID 569
(vmnet-bridge)
Feb  4 12:56:38 bdianni-lnx kernel: /dev/vmnet: hub 0 does not exist, allocating
memory.
Feb  4 12:56:38 bdianni-lnx kernel: /dev/vmnet: port on hub 0 successfully opened
Feb  4 12:56:38 bdianni-lnx kernel: bridge-eth1: peer interface eth1 not found,
will wait for it to come up
Feb  4 12:56:38 bdianni-lnx kernel: bridge-eth1: attached
Feb  4 12:56:38 bdianni-lnx kernel: /dev/vmnet: open called by PID 590
(vmnet-netifup)
Feb  4 12:56:38 bdianni-lnx kernel: /dev/vmnet: hub 1 does not exist, allocating
memory.
Feb  4 12:56:38 bdianni-lnx kernel: /dev/vmnet: port on hub 1 successfully opened
Feb  4 12:56:39 bdianni-lnx kernel: /dev/vmnet: open called by PID 702 (vmnet-dhcpd)
Feb  4 12:56:39 bdianni-lnx kernel: /dev/vmnet: port on hub 1 successfully opened
~                                                                              
                                                                               
                                                                               
                                                                               
                                                                               
 
