Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWBVXxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWBVXxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWBVXxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:53:32 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:36530 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1751456AbWBVXxc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:53:32 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <B7FF9C61-95ED-4495-971F-D55AAAA2F0F5@bootc.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Chris Boot <bootc@bootc.net>
Subject: PANIC: sata_sil on 2.6.16-rc4-ide1
Date: Wed, 22 Feb 2006 23:53:27 +0000
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I upgraded from 2.6.16-rc2-ide2 to 2.6.16-rc4-ide1 and suffered the  
panic pasted below. Needless to say this all worked fine with the  
previous kernel (and some). I have two Seagate 250GB drives connected  
to the controller (a PCI Adaptec 1205SA). I'm testing -ide so I don't  
have the whole IDE layer just for my rarely used DVD-RW on my VIA PATA.

*** dmesg ***
[4294667.296000] Linux version 2.6.16-rc4-ide1 (bootc@arcadia.lan)  
(gcc version 4.0.2 (Gentoo 4.0.2-r3, pie-8.7.8)) #1 PREEMPT Wed Feb  
22 22:06:39 GMT 2006
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009d800  
(usable)
[4294667.296000]  BIOS-e820: 000000000009d800 - 00000000000a0000  
(reserved)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000  
(reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000004fff0000  
(usable)
[4294667.296000]  BIOS-e820: 000000004fff0000 - 000000004fff3000  
(ACPI NVS)
[4294667.296000]  BIOS-e820: 000000004fff3000 - 0000000050000000  
(ACPI data)
[4294667.296000]  BIOS-e820: 00000000fec00000 - 00000000fec01000  
(reserved)
[4294667.296000]  BIOS-e820: 00000000fee00000 - 00000000fee01000  
(reserved)
[4294667.296000]  BIOS-e820: 00000000ffff0000 - 0000000100000000  
(reserved)
[4294667.296000] 383MB HIGHMEM available.
[4294667.296000] 896MB LOWMEM available.
[4294667.296000] found SMP MP-table at 000f5c80
[4294667.296000] DMI 2.2 present.
[4294667.296000] ACPI: PM-Timer IO Port: 0x4008
[4294667.296000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 6:10 APIC version 16
[4294667.296000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[4294667.296000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[4294667.296000] IOAPIC[0]: apic_id 2, version 3, address 0xfec00000,  
GSI 0-23
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl  
dfl)
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl  
dfl)
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Using ACPI (MADT) for SMP configuration information
[4294667.296000] Allocating PCI resources starting at 60000000 (gap:  
50000000:aec00000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/md0 vga=0x31B  
nmi_watchdog=1 libata.atapi_enabled=1 console=ttyS0,115200n1  
console=tty0
[4294667.296000] Enabling fast FPU save and restore... done.
[4294667.296000] Enabling unmasked SIMD FPU exception support... done.
[4294667.296000] Initializing CPU#0
[4294667.296000] CPU 0 irqstacks, hard=c037c000 soft=c037d000
[4294667.296000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[4294667.296000] Detected 1826.883 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour dummy device 80x25
[4294668.177000] Dentry cache hash table entries: 131072 (order: 7,  
524288 bytes)
[4294668.185000] Inode-cache hash table entries: 65536 (order: 6,  
262144 bytes)
[4294668.239000] Memory: 1295668k/1310656k available (1771k kernel  
code, 13860k reserved, 596k data, 152k init, 393152k highmem)
[4294668.250000] Checking if this processor honours the WP bit even  
in supervisor mode... Ok.
[4294668.319000] Calibrating delay using timer specific routine..  
3655.59 BogoMIPS (lpj=1827795)
[4294668.327000] Mount-cache hash table entries: 512
[4294668.332000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K  
(64 bytes/line)
[4294668.339000] CPU: L2 Cache: 512K (64 bytes/line)
[4294668.344000] Intel machine check architecture supported.
[4294668.349000] Intel machine check reporting enabled on CPU#0.
[4294668.355000] CPU: AMD Athlon(tm) XP 2500+ stepping 00
[4294668.360000] Checking 'hlt' instruction... OK.
[4294668.475000] ENABLING IO-APIC IRQs
[4294668.480000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[4294668.597000] NET: Registered protocol family 16
[4294668.603000] ACPI: bus type pci registered
[4294668.627000] PCI: PCI BIOS revision 2.10 entry at 0xfb350, last  
bus=1
[4294668.633000] PCI: Using configuration type 1
[4294668.638000] ACPI: Subsystem revision 20060127
[4294668.654000] ACPI: Interpreter enabled
[4294668.658000] ACPI: Using IOAPIC for interrupt routing
[4294668.663000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[4294668.668000] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[4294668.677000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
[4294668.727000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 11  
12) *5
[4294668.734000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11  
12)
[4294668.741000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 *10 11  
12)
[4294668.748000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 11  
*12)
[4294668.755000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11  
12) *0, disabled.
[4294668.763000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11  
12) *0, disabled.
[4294668.771000] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11  
12) *0, disabled.
[4294668.779000] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11  
12) *0, disabled.
[4294668.788000] ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *11
[4294668.794000] ACPI: PCI Interrupt Link [ALKB] (IRQs *21)
[4294668.800000] ACPI: PCI Interrupt Link [ALKC] (IRQs *22)
[4294668.805000] ACPI: PCI Interrupt Link [ALKD] (IRQs *23), disabled.
[4294668.814000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294668.820000] pnp: PnP ACPI init
[4294668.828000] pnp: PnP ACPI: found 11 devices
[4294668.832000] SCSI subsystem initialized
[4294668.836000] PCI: Using ACPI for IRQ routing
[4294668.841000] PCI: If a device doesn't work, try "pci=routeirq".   
If it helps, post a report
[4294668.877000] PCI: Bridge: 0000:00:01.0
[4294668.881000]   IO window: disabled.
[4294668.885000]   MEM window: e0000000-e2ffffff
[4294668.889000]   PREFETCH window: d0000000-dfffffff
[4294668.894000] Machine check exception polling timer started.
[4294668.899000] highmem bounce pool size: 64 pages
[4294668.905000] VFS: Disk quotas dquot_6.5.1
[4294668.909000] Dquot-cache hash table entries: 1024 (order 0, 4096  
bytes)
[4294668.916000] SGI XFS with ACLs, security attributes, no debug  
enabled
[4294668.922000] SGI XFS Quota Management subsystem
[4294668.927000] Initializing Cryptographic API
[4294668.931000] io scheduler noop registered
[4294668.936000] io scheduler anticipatory registered (default)
[4294668.941000] io scheduler deadline registered
[4294668.945000] io scheduler cfq registered
[4294668.950000] PCI: Bypassing VIA 8237 APIC De-Assert Message
[4294668.956000] vesafb: framebuffer at 0xd0000000, mapped to  
0xf8880000, using 10240k, total 262144k
[4294668.965000] vesafb: mode is 1280x1024x32, linelength=5120, pages=0
[4294668.971000] vesafb: protected mode interface info at c000:d5c0
[4294668.977000] vesafb: scrolling: redraw
[4294668.981000] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[4294669.235000] Console: switching to colour frame buffer device 160x64
[4294669.242000] fb0: VESA VGA frame buffer device
[4294669.249000] Real Time Clock Driver v1.12ac
[4294669.254000] Software Watchdog Timer: 0.07 initialized.  
soft_noboot=0 soft_margin=60 sec (nowayout= 0)
[4294669.265000] Hangcheck: starting hangcheck timer 0.9.0 (tick is  
180 seconds, margin is 60 seconds).
[4294669.275000] Hangcheck: Using monotonic_clock().
[4294669.281000] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[4294669.288000] PNP: PS/2 controller doesn't have AUX irq; using  
default 12
[4294669.296000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294669.302000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294669.308000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,  
IRQ sharing disabled
[4294669.317000] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294669.324000] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294669.332000] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294669.338000] 00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294669.345000] ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18  
(level, low) -> IRQ 169
[4294669.354000] ata1: SATA max UDMA/100 cmd 0xF8802080 ctl  
0xF880208A bmdma 0xF8802000 irq 169
[4294669.364000] ata2: SATA max UDMA/100 cmd 0xF88020C0 ctl  
0xF88020CA bmdma 0xF8802008 irq 169
[4294669.574000] ata1: SATA link up 1.5 Gbps (SStatus 113)
[4294669.731000] Unable to handle kernel NULL pointer dereference at  
virtual address 00000000
[4294669.740000]  printing eip:
[4294669.743000] 00000000
[4294669.746000] *pde = 00000000
[4294669.749000] Oops: 0000 [#1]
[4294669.749000] PREEMPT
[4294669.749000] Modules linked in:
[4294669.749000] CPU:    0
[4294669.749000] EIP:    0060:[<00000000>]    Not tainted VLI
[4294669.749000] EFLAGS: 00010282   (2.6.16-rc4-ide1 #1)
[4294669.749000] EIP is at _stext+0x3feffde0/0x29
[4294669.749000] eax: f7e33280   ebx: f7e33280   ecx: c02c6500   edx:  
f7e332fc
[4294669.749000] esi: f8802008   edi: f7e332fc   ebp: f7e33310   esp:  
c1b01ea8
[4294669.749000] ds: 007b   es: 007b   ss: 0068
[4294669.749000] Process swapper (pid: 1, threadinfo=c1b01000  
task=c1b00a30)
[4294669.749000] Stack: <0>c024421f f7e332fc f7d3e000 f88020ca  
f88020c0 00000002 f7cfc048 f7e3f2a8
[4294669.749000]        f7e33280 00000000 00001000 c013a6fc 00000000  
00000046 c0322304 c1b01000
[4294669.749000]        f7de1ce0 f7de1ce8 f7de1ce0 0000000d 00000001  
c1b01f10 c1b01f10 00000000
[4294669.749000] Call Trace:
[4294669.749000]  [<c024421f>] ata_device_add+0x366/0xa59
[4294669.749000]  [<c013a6fc>] __get_vm_area_node+0x7d/0x175
[4294669.749000]  [<c026f445>] pcibios_set_master+0x19/0x77
[4294669.749000]  [<c024712d>] sil_init_one+0x2da/0x30b
[4294669.749000]  [<c0235dee>] __driver_attach+0x0/0x59
[4294669.749000]  [<c01ea646>] pci_device_probe+0x36/0x55
[4294669.749000]  [<c0235d4b>] driver_probe_device+0x3f/0x8e
[4294669.749000]  [<c0235e24>] __driver_attach+0x36/0x59
[4294669.749000]  [<c0235569>] bus_for_each_dev+0x37/0x59
[4294669.749000]  [<c0235c4d>] driver_attach+0x11/0x13
[4294669.749000]  [<c0235dee>] __driver_attach+0x0/0x59
[4294669.749000]  [<c02357d7>] bus_add_driver+0x5a/0xd3
[4294669.749000]  [<c01ea298>] __pci_register_driver+0x59/0x75
[4294669.749000]  [<c01002f4>] init+0x7c/0x1b0
[4294669.749000]  [<c0100278>] init+0x0/0x1b0
[4294669.749000]  [<c0100a85>] kernel_thread_helper+0x5/0xb
[4294669.749000] Code:  Bad EIP value.
[4294669.749000]  <0>Kernel panic - not syncing: Attempted to kill init!
[4294670.660000]

*** relevant part of lspci ***
00:0a.0 Mass storage controller: Silicon Image, Inc. SiI 3112  
[SATALink/SATARaid] Serial ATA Controller (rev 02) (prog-if 01)
	Subsystem: Adaptec SATAConnect 1205SA Host Controller
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 169
	I/O ports at a400 [size=8]
	I/O ports at a800 [size=4]
	I/O ports at ac00 [size=8]
	I/O ports at b000 [size=4]
	I/O ports at b400 [size=16]
	Memory at e6001000 (32-bit, non-prefetchable) [size=512]
	[virtual] Expansion ROM at 60000000 [disabled] [size=512K]
	Capabilities: <access denied>
00: 95 10 12 31 07 00 b0 02 02 01 80 01 08 20 00 00
10: 01 a4 00 00 01 a8 00 00 01 ac 00 00 01 b0 00 00
20: 01 b4 00 00 00 10 00 e6 00 00 00 00 05 90 50 02
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 00 00

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


