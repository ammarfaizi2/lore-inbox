Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUJNVAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUJNVAO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267612AbUJNU7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:59:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:33246 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266912AbUJNUz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:55:59 -0400
Subject: Re: 2.6.9-rc4-mm1 OOPs on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041014190108.GE7973@wotan.suse.de>
References: <1097527401.12861.383.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011214304.GD31731@wotan.suse.de>
	 <1097532118.12861.395.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011221519.GA11702@wotan.suse.de>
	 <20041011153830.495b7c2d.akpm@osdl.org>
	 <1097779232.2861.9.camel@dyn318077bld.beaverton.ibm.com>
	 <20041014190108.GE7973@wotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1097786768.2861.16.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Oct 2004 13:46:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 12:01, Andi Kleen wrote:
> > I will leave it capable hands of Andi to figure out whats wrong
> > with it. Andi, if you want me to test the fix, send it my way.
> 
> Oops. Weird, it worked on my machines.
> 
> Sorry for the problems and thanks for tracking it down
> I will look at it.  Andrew, probably just back it out for now.
> 
> Badari, Can you send me the beginning of your boot.msg again so that
> I can see your node layout?  (you probably did already, but I cannot
> find the mail anymore) 
> 
> -Andi

No problem. Here is the boot.msg with the patch backed out. (when its
boots fine).

Thanks,
Badari
klogd 1.4.1, log source = ksyslog started.
<4>Bootdata ok (command line is root=/dev/hda2 vga=0 splash=silent
console=tty0 console=ttyS0,38400 desktop resume=/dev/hda1 showopts)
<4>Linux version 2.6.9-rc4-mm1n (root@elm3b29) (gcc version 3.3.3 (SuSE
Linux)) #1 SMP Thu Oct 14 12:12:09 PDT 2004
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
<4> BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000ca000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 00000000dfef0000 (usable)
<4> BIOS-e820: 00000000dfef0000 - 00000000dfeff000 (ACPI data)
<4> BIOS-e820: 00000000dfeff000 - 00000000dff00000 (ACPI NVS)
<4> BIOS-e820: 00000000dff00000 - 00000000e0000000 (usable)
<4> BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
<4> BIOS-e820: 0000000100000000 - 00000001e0000000 (usable)
<6>Scanning NUMA topology in Northbridge 24
<6>Number of nodes 4 (30030)
<6>Node 0 MemBase 0000000000000000 Limit 000000017fffffff
<6>Node 1 MemBase 0000000180000000 Limit 000000019fffffff
<6>Node 2 MemBase 00000001a0000000 Limit 00000001bfffffff
<6>Node 3 MemBase 00000001c0000000 Limit 00000001dfffffff
<6>node 1 shift 24 addr 180000000 conflict 0
<6>Using node hash shift of 25
<4>Bootmem setup node 0 0000000000000000-000000017fffffff
<4>Bootmem setup node 1 0000000180000000-000000019fffffff
<4>Bootmem setup node 2 00000001a0000000-00000001bfffffff
<4>Bootmem setup node 3 00000001c0000000-00000001dfffffff
<6>No mptable found.
<7>On node 0 totalpages: 1572863
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 1568767 pages, LIFO batch:16
<7>  HighMem zone: 0 pages, LIFO batch:1
<7>On node 1 totalpages: 131071
<7>  DMA zone: 0 pages, LIFO batch:1
<7>  Normal zone: 131071 pages, LIFO batch:16
<7>  HighMem zone: 0 pages, LIFO batch:1
<7>On node 2 totalpages: 131071
<7>  DMA zone: 0 pages, LIFO batch:1
<7>  Normal zone: 131071 pages, LIFO batch:16
<7>  HighMem zone: 0 pages, LIFO batch:1
<7>On node 3 totalpages: 131071
<7>  DMA zone: 0 pages, LIFO batch:1
<7>  Normal zone: 131071 pages, LIFO batch:16
<7>  HighMem zone: 0 pages, LIFO batch:1
<7>ACPI: RSDP (v002 PTLTD                                 ) @
0x00000000000f6970
<7>ACPI: XSDT (v001 PTLTD        XSDT   0x06040000  LTP 0x00000000) @
0x00000000dfefc625
<7>ACPI: FADT (v003 AMD    HAMMER   0x06040000 PTEC 0x000f4240) @
0x00000000dfefed02
<7>ACPI: SRAT (v001 AMD    HAMMER   0x06040000 AMD  0x00000001) @
0x00000000dfefedf6
<7>ACPI: MADT (v001 PTLTD        APIC   0x06040000  LTP 0x00000000) @
0x00000000dfefef56
<7>ACPI: DSDT (v001 AMD-K8  AMDACPI 0x06040000 MSFT 0x0100000d) @
0x0000000000000000
<7>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
<6>Processor #0 15:5 APIC version 16
<6>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
<6>Processor #1 15:5 APIC version 16
<6>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
<6>Processor #2 15:5 APIC version 16
<6>ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
<6>Processor #3 15:5 APIC version 16
<6>ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
<6>ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
<6>IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
<6>ACPI: IOAPIC (id[0x05] address[0xfa400000] gsi_base[24])
<6>IOAPIC[1]: apic_id 5, version 17, address 0xfa400000, GSI 24-27
<6>ACPI: IOAPIC (id[0x06] address[0xfa401000] gsi_base[28])
<6>IOAPIC[2]: apic_id 6, version 17, address 0xfa401000, GSI 28-31
<6>ACPI: IOAPIC (id[0x07] address[0xfa402000] gsi_base[32])
<6>IOAPIC[3]: apic_id 7, version 17, address 0xfa402000, GSI 32-35
<6>ACPI: IOAPIC (id[0x08] address[0xfa404000] gsi_base[36])
<6>IOAPIC[4]: apic_id 8, version 17, address 0xfa404000, GSI 36-39
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
<7>ACPI: IRQ0 used by override.
<7>ACPI: IRQ2 used by override.
<7>ACPI: IRQ9 used by override.
<6>Setting APIC routing to flat
<6>Using ACPI (MADT) for SMP configuration information
<4>Checking aperture...
<4>CPU 0: aperture @ 0 size 32 MB
<4>No AGP bridge found
<4>Your BIOS doesn't leave a aperture memory hole
<4>Please enable the IOMMU option in the BIOS setup
<4>This costs you 64 MB of RAM
<4>Mapping aperture over 65536 KB of RAM @ 8000000
<4>Built 4 zonelists
<4>Initializing CPU#0
<4>Kernel command line: root=/dev/hda2 vga=0 splash=silent console=tty0
console=ttyS0,38400 desktop resume=/dev/hda1 showopts
<4>PID hash table entries: 4096 (order: 12, 131072 bytes)
<6>time.c: Using 1.193182 MHz PIT timer.
<6>time.c: Detected 1398.189 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
<4>Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
<4>Memory: 7146624k/7864320k available (3058k kernel code, 0k reserved,
1853k data, 220k init)
<7>Calibrating delay loop... 2752.51 BogoMIPS (lpj=1376256)
<6>Security Scaffold v1.0.0 initialized
<6>Capability LSM initialized
<4>Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 1024K (64 bytes/line)
<6>Using local APIC NMI watchdog using perfctr0
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 1024K (64 bytes/line)
<6>CPU0: Opteron MP w/ 1MB stepping 00
<6>per-CPU timeslice cutoff: 1023.82 usecs.
<6>task migration cache decay timeout: 2 msecs.
<6>Booting processor 1/1 rip 6000 rsp 1018071df58
<4>Initializing CPU#1
<7>Calibrating delay loop... 2793.47 BogoMIPS (lpj=1396736)
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 1024K (64 bytes/line)
<4>Opteron MP w/ 1MB stepping 00
<6>Booting processor 2/2 rip 6000 rsp 1019ff85f58
<4>Initializing CPU#2
<7>Calibrating delay loop... 2793.47 BogoMIPS (lpj=1396736)
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 1024K (64 bytes/line)
<4>Opteron MP w/ 1MB stepping 00
<6>Booting processor 3/3 rip 6000 rsp 101bffb1f58
<4>Initializing CPU#3
<7>Calibrating delay loop... 2793.47 BogoMIPS (lpj=1396736)
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 1024K (64 bytes/line)
<4>Opteron MP w/ 1MB stepping 00
<6>Total of 4 processors activated (11132.92 BogoMIPS).
<6>Using local APIC timer interrupts.
<6>Detected 12.483 MHz APIC timer.
<6>checking TSC synchronization across 4 CPUs: passed.
<6>time.c: Using PIT/TSC based timekeeping.
<4>Brought up 4 CPUs
<7>CPU0:
<7> domain 0: span 01
<7>  groups: 01
<7>  domain 1: span 0f
<7>   groups: 01 02 04 08
<7>CPU1:
<7> domain 0: span 02
<7>  groups: 02
<7>  domain 1: span 0f
<7>   groups: 02 04 08 01
<7>CPU2:
<7> domain 0: span 04
<7>  groups: 04
<7>  domain 1: span 0f
<7>   groups: 04 08 01 02
<7>CPU3:
<7> domain 0: span 08
<7>  groups: 08
<7>  domain 1: span 0f
<7>   groups: 08 01 02 04
<6>NET: Registered protocol family 16
<6>PCI: Using configuration type 1
<6>mtrr: v2.0 (20020519)
<6>ACPI: Subsystem revision 20040816
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *5 10 11)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 *10 11)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 10 *11)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.TP2P._PRT]
<6>ACPI: PCI Root Bridge [PCI1] (00:08)
<4>PCI: Probing PCI hardware (bus 08)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G0PA._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G0PB._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G1PB._PRT]
<5>SCSI subsystem initialized
<6>PCI: Using ACPI for IRQ routing
<6>** PCI interrupts are no longer routed automatically.  If this
<6>** causes a device to stop working, it is probably because the
<6>** driver failed to call pci_enable_device().  As a temporary
<6>** workaround, the "pci=routeirq" argument restores the old
<6>** behavior.  If this argument makes the device work again,
<6>** please email the output of "lspci" to bjorn.helgaas@hp.com
<6>** so I can fix the driver.
<6>PCI-DMA: Disabling AGP.
<4>PCI-DMA: aperture base @ 8000000 size 65536 KB
<6>PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
<4>IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
<6>audit: initializing netlink socket (disabled)
<3>audit(1097781300.230:0): initialized
<4>Total HugeTLB memory allocated, 0
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
<6>Initializing Cryptographic API
<4>vesafb: probe of vesafb0 failed with error -6
<6>ACPI: Power Button (FF) [PWRF]
<6>ACPI: Sleep Button (FF) [SLPF]
<6>ACPI: Processor [CPU0] (supports C1)
<6>ACPI: Processor [CPU1] (supports C1)
<6>ACPI: Processor [CPU2] (supports C1)
<6>ACPI: Processor [CPU3] (supports C1)
<6>Real Time Clock Driver v1.12
<6>Non-volatile memory driver v1.2
<6>Linux agpgart interface v0.100 (c) Dave Jones
<4>ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
<4>ACPI: PS/2 Mouse Controller [PS2M] at irq 12
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
<4>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<4>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<4>io scheduler noop registered
<4>io scheduler anticipatory registered
<4>io scheduler deadline registered
<4>io scheduler cfq registered
<4>RAMDISK driver initialized: 16 RAM disks of 128000K size 1024
blocksize
<6>loop: loaded (max 8 devices)
<6>tg3.c:v3.10 (September 14, 2004)
<6>ACPI: PCI interrupt 0000:19:02.0[A] -> GSI 38 (level, low) -> IRQ 38
<6>eth0: Tigon3 [partno(3C996B-T) rev 0105 PHY(5701)] (PCI:66MHz:64-bit)
10/100/1000BaseT Ethernet 00:04:76:f0:f9:aa
<6>eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]
TSOcap[0]
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
<6>AMD8111: IDE controller at PCI slot 0000:00:07.1
<6>AMD8111: chipset revision 3
<6>AMD8111: not 100%% native mode: will probe irqs later


