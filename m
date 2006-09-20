Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWITUui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWITUui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWITUui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:50:38 -0400
Received: from mail1.utc.com ([192.249.46.190]:25814 "EHLO mail1.utc.com")
	by vger.kernel.org with ESMTP id S1750775AbWITUuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:50:37 -0400
Message-ID: <4511A98A.4080908@cybsft.com>
Date: Wed, 20 Sep 2006 15:50:18 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
References: <20060920141907.GA30765@elte.hu> <45118EEC.2080700@cybsft.com>	 <20060920194958.GA24691@elte.hu>  <4511A57D.9070500@cybsft.com> <1158784863.5724.1027.camel@localhost.localdomain>
In-Reply-To: <1158784863.5724.1027.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Wed, 2006-09-20 at 15:33 -0500, K.R. Foley wrote:
>> DOH! The log had two different boots in it. :( Let's try this again. By
>> the way, you may notice from my screw up that this is pretty much the
>> same oops that I got with 2.6.17-rt*. I have been getting this on all of
>> my SMP systems since we went past 2.6.16.
> 
> Which module is modprobed ?
> 
> 	tglx
> 
> 
> 
How can I tell which particular module is being loaded? The last thing I
see on the console before the oops is that it is starting udev. I am
including the rest of the boot log below in hopes that will help.
Suggestions? Something else I can provide?

Linux version 2.6.18-rt2 (aaektkf@krfc3) (gcc version 3.4.4 20050721
(Red Hat 3.4.4-2)) #4 SMP PREEMPT Wed Sep 20 14:53:58 CDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff77000 (ACPI data)
 BIOS-e820: 000000001ff77000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f6b00
DMI present.
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x04] address[0xfec80100] gsi_base[48])
IOAPIC[2]: apic_id 4, version 32, address 0xfec80100, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 2591.683 MHz processor.
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists.  Total pages: 130928
Kernel command line: ro root=LABEL=/ console=ttyS0,38400 console=tty0
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
Event source pit configured with caps set: 03
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 509756k/523712k available (1753k kernel code, 13568k reserved,
1407k data, 196k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5185.26 BogoMIPS
(lpj=2592634)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5182.45 BogoMIPS
(lpj=2591226)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Booting processor 2/6 eip 2000
Initializing CPU#2
Calibrating delay using timer specific routine.. 5182.51 BogoMIPS
(lpj=2591258)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU2: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Booting processor 3/7 eip 2000
Initializing CPU#3
Calibrating delay using timer specific routine.. 5182.53 BogoMIPS
(lpj=2591268)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU3: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Total of 4 processors activated (20732.77 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
lapic max_delta_ns: 1346568721
Event source pit new caps set: 01
Event source lapic configured with caps set: 02
checking TSC synchronization across 4 CPUs: passed.
Event source pit new caps set: 01
Event source lapic configured with caps set: 02
Event source pit new caps set: 01
Event source lapic configured with caps set: 02
Event source pit new caps set: 01
Event source lapic configured with caps set: 02
Brought up 4 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 295k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd915, last bus=5
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
* The chipset may have PM-Timer Bug. Due to workarounds for a bug,
* this clock source is slow. If you are sure your timer does not have
* this bug, please use "acpi_pm_good" to disable the workaround
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 10 11 14 15) *5
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 10 *11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0401
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e1000000-e1ffffff
  PREFETCH window: ec000000-f7ffffff
PCI: Bridge: 0000:02:1d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:1f.0
  IO window: disabled.
  MEM window: e2100000-e21fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: e2000000-e21fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: e2200000-e22fffff
  PREFETCH window: 30000000-300fffff
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 7, 655360 bytes)
TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD800BB-75CAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY DVD RW DW-U18A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 156250000 sectors (80000 MB)
	native  capacity is 156301488 sectors (80026 MB)
hda: Host Protected Area disabled.
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 >
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 196k freed
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
BUG: unable to handle kernel paging request at virtual address f3010000
 printing eip:
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    1
EIP:    0060:[<c0131e02>]    Not tainted VLI
EFLAGS: 00010283   (2.6.18-rt2 #4)
EIP is at lookup_symbol+0x11/0x35
eax: 00000001   ebx: e0830e08   ecx: c036ff60   edx: c036dd94
esi: f3010000   edi: e0830e08   ebp: df657e74   esp: df657e68
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process modprobe (pid: 1366, ti=df656000 task=dfc68e90 task.ti=df656000)
Stack: e083c780 00000c00 e0830e08 df657e90 c0131e6f df657ea8 df657ea4
e083c780
       00000c00 e0830e08 df657eb8 c0132c21 00000001 00000012 e082d074
00000000
       df657ecc e083a434 00000c00 e082d074 df657edc c0133188 e083c780
00000000
Call Trace:
 [<c01037a1>] show_stack_log_lvl+0x87/0x8f
 [<c010391b>] show_registers+0x12f/0x198
 [<c0103b0c>] die+0x114/0x1c6
 [<c0111196>] do_page_fault+0x3f2/0x4c8
 [<c0103481>] error_code+0x39/0x40
 [<c0131e6f>] __find_symbol+0x25/0x2a5
 [<c0132c21>] resolve_symbol+0x27/0x5f
 [<c0133188>] simplify_symbols+0x83/0xf3
 [<c0133e65>] load_module+0x720/0xbb8
 [<c013435f>] sys_init_module+0x3f/0x1b5
 [<c0102969>] sysenter_past_esp+0x56/0x79
Code: eb 11 8b 75 f0 41 83 c2 28 0f b7 46 30 39 c1 72 c9 31 c0 5a 59 5b
5e 5f 5d c3 55 89 e5 57 56 53 89 c3 39 ca 73 22 8b 72 04 89 df <ac> ae
75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 04 89
EIP: [<c0131e02>] lookup_symbol+0x11/0x35 SS:ESP 0068:df657e68



-- 
   kr
