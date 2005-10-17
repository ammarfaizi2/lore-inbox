Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVJQSix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVJQSix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVJQSix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:38:53 -0400
Received: from serv01.siteground.net ([70.85.91.68]:51148 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932218AbVJQSiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:38:51 -0400
Date: Mon, 17 Oct 2005 11:38:42 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, shai@scalex86.org, clameter@engr.sgi.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051017183842.GB4959@localhost.localdomain>
References: <20051017093654.GA7652@localhost.localdomain> <200510171740.57614.ak@suse.de> <20051017175231.GA4959@localhost.localdomain> <200510172008.24669.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <200510172008.24669.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2005 at 08:08:24PM +0200, Andi Kleen wrote:
> On Monday 17 October 2005 19:52, Ravikiran G Thirumalai wrote:
> 
> > No they are not.  IBM X460s are generally available machines and  the bug
> > affects those boxes. 
> 
> No reports from that front so far.

Attached is the dmesg on x460 which shows where swiotlb is allocated.

> 
> > How can there be a major kernel release which is known 
> > to have breakage??
> 
> Welcome to the painful real world of software engineering.
> 
> Every software has bugs and if you want to ever get a release out you
> have to make such decisions sometimes. 
> 
> As an alternative I can just backout the patch that enables the Intel
> SRAT code. That is probably better for a short term fix and will
> not regress anybody.

Intel SRAT code?  which patch are you referring to? How is that relevant here?  

Thanks,
Kiran

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

[    0.000000] Bootdata ok (command line is root=LABEL=/  console=ttyS1,115200 console=ttyS0,115200 console=tty1 console=tty0)
[    0.000000] Linux version 2.6.14-rc4 (root@x460) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #3 SMP Thu Oct 13 13:37:51 PDT 2005
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000098000 (usable)
[    0.000000]  BIOS-e820: 0000000000098000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000e7f94d40 (usable)
[    0.000000]  BIOS-e820: 00000000e7f94d40 - 00000000e7fa6a40 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e7fa6a40 - 00000000e8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 00000003f8000000 (usable)
[    0.000000] ACPI: RSDP (v000 IBM                                   ) @ 0x00000000000fdcf0
[    0.000000] ACPI: RSDT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa69c0
[    0.000000] ACPI: FADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa6940
[    0.000000] ACPI: MADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa6840
[    0.000000] ACPI: SRAT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa6700
[    0.000000] ACPI: HPET (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa66c0
[    0.000000] ACPI: SSDT (v001 IBM    VIGSSDT0 0x00001000 INTL 0x20030122) @ 0x00000000e7f9f0c0
[    0.000000] ACPI: SSDT (v001 IBM    VIGSSDT1 0x00001000 INTL 0x20030122) @ 0x00000000e7f97b00
[    0.000000] ACPI: DSDT (v001 IBM    EXA01ZEU 0x00001000 INTL 0x20030122) @ 0x0000000000000000
[    0.000000] SRAT: PXM 0 -> APIC 0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 6 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 16 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 22 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 32 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 38 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 48 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 54 -> Node 1
[    0.000000] SRAT: Node 0 PXM 0 0-e7ffffff
[    0.000000] SRAT: Node 0 PXM 0 0-207ffffff
[    0.000000] SRAT: Node 1 PXM 1 208000000-3f7ffffff
[    0.000000] Using 22 for the hash shift. Max adder is 3f7ffffff 
[    0.000000] Bootmem setup node 0 0000000000000000-0000000207ffffff
[    0.000000] Bootmem setup node 1 0000000208000000-00000003f7ffffff
[    0.000000] On node 0 totalpages: 2031403
[    0.000000]   DMA zone: 3992 pages, LIFO batch:1
[    0.000000]   Normal zone: 2027411 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages, LIFO batch:1
[    0.000000] On node 1 totalpages: 2031615
[    0.000000]   DMA zone: 0 pages, LIFO batch:1
[    0.000000]   Normal zone: 2031615 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages, LIFO batch:1
[    0.000000] ACPI: PM-Timer IO Port: 0x9c
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
[    0.000000] Processor #6 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x10] enabled)
[    0.000000] Processor #16 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x16] enabled)
[    0.000000] Processor #22 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x20] enabled)
[    0.000000] Processor #32 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x11] lapic_id[0x26] enabled)
[    0.000000] Processor #38 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x12] lapic_id[0x30] enabled)
[    0.000000] Processor #48 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x13] lapic_id[0x36] enabled)
[    0.000000] Processor #54 15:4 APIC version 20
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x0f] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 15, version 17, address 0xfec00000, GSI 0-35
[    0.000000] ACPI: IOAPIC (id[0x0e] address[0xfec01000] gsi_base[35])
[    0.000000] IOAPIC[1]: apic_id 14, version 17, address 0xfec01000, GSI 35-70
[    0.000000] ACPI: IOAPIC (id[0x0d] address[0xfec02000] gsi_base[70])
[    0.000000] IOAPIC[2]: apic_id 13, version 17, address 0xfec02000, GSI 70-105
[    0.000000] ACPI: IOAPIC (id[0x0c] address[0xfec03000] gsi_base[105])
[    0.000000] IOAPIC[3]: apic_id 12, version 17, address 0xfec03000, GSI 105-140
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 low edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ8 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] Setting APIC routing to clustered
[    0.000000] ACPI: HPET id: 0x10142201 base: 0xfde84000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at ea000000 (gap: e8000000:16c00000)
[    0.000000] Checking aperture...
[    0.000000] Built 2 zonelists
[    0.000000] Kernel command line: root=LABEL=/  console=ttyS1,115200 console=ttyS0,115200 console=tty1 console=tty0
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 3.579545 MHz PM timer.
[    0.000000] time.c: Detected 3336.330 MHz processor.
[  369.608912] Console: colour VGA+ 80x25
[  370.117124] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[  370.149658] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[  370.240852] Placing software IO TLB between 0x21051c000 - 0x21451c000
[  370.797462] Memory: 15927892k/16646144k available (2594k kernel code, 324188k reserved, 1356k data, 208k init)
[  370.951986] Calibrating delay using timer specific routine.. 6684.01 BogoMIPS (lpj=33420066)
[  370.962277] Mount-cache hash table entries: 256
[  370.967873] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  370.974137] CPU: L2 cache: 1024K
[  370.977990] CPU: L3 cache: 8192K
[  370.981864] CPU 0 -> Node 0
[  370.985220] using mwait in idle threads.
[  370.989926] CPU: Hyper-Threading is disabled
[  370.995063] CPU0: Thermal monitoring enabled (TM1)
[  371.000804] mtrr: v2.0 (20020519)
[  371.136909] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[  371.143884]  failed.
[  371.146519] timer doesn't work through the IO-APIC - disabling NMI Watchdog!
[  371.155928] Uhhuh. NMI received for unknown reason 35.
[  371.162067] Dazed and confused, but trying to continue
[  371.168210] Do you have a strange power saving mode enabled?
[  371.273826]  works.
[  371.276353] Using local APIC timer interrupts.
[  371.311561] Detected 10.425 MHz APIC timer.
[  371.316630] softlockup thread 0 started up.
[  371.321767] Booting processor 1/8 APIC 0x6
[  371.337804] Initializing CPU#1
[  371.480354] Calibrating delay using timer specific routine.. 6672.52 BogoMIPS (lpj=33362642)
[  371.480368] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  371.480370] CPU: L2 cache: 1024K
[  371.480372] CPU: L3 cache: 8192K
[  371.480375] CPU 1 -> Node 0
[  371.480377] CPU: Hyper-Threading is disabled
[  371.480389] CPU1: Thermal monitoring enabled (TM1)
[  371.481497]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  371.481508] APIC error on CPU1: 00(40)
[  371.481512] CPU 1: Syncing TSC to CPU 0.
[  371.481849] CPU 1: synchronized TSC with CPU 0 (last diff 10 cycles, maxerr 3060 cycles)
[  371.481873] softlockup thread 1 started up.
[  371.481968] Booting processor 2/8 APIC 0x10
[  371.493111] Initializing CPU#2
[  371.639864] Calibrating delay using timer specific routine.. 6672.50 BogoMIPS (lpj=33362516)
[  371.639880] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  371.639882] CPU: L2 cache: 1024K
[  371.639883] CPU: L3 cache: 8192K
[  371.639886] CPU 2 -> Node 0
[  371.639888] CPU: Hyper-Threading is disabled
[  371.639901] CPU2: Thermal monitoring enabled (TM1)
[  371.641006]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  371.641017] APIC error on CPU2: 00(40)
[  371.641021] CPU 2: Syncing TSC to CPU 0.
[  371.641460] CPU 2: synchronized TSC with CPU 0 (last diff -56 cycles, maxerr 3890 cycles)
[  371.641486] softlockup thread 2 started up.
[  371.641589] Booting processor 3/8 APIC 0x16
[  371.652751] Initializing CPU#3
[  371.799373] Calibrating delay using timer specific routine.. 6672.59 BogoMIPS (lpj=33362958)
[  371.799388] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  371.799390] CPU: L2 cache: 1024K
[  371.799392] CPU: L3 cache: 8192K
[  371.799394] CPU 3 -> Node 0
[  371.799397] CPU: Hyper-Threading is disabled
[  371.799409] CPU3: Thermal monitoring enabled (TM1)
[  371.800515]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  371.800526] APIC error on CPU3: 00(40)
[  371.800529] CPU 3: Syncing TSC to CPU 0.
[  371.800965] CPU 3: synchronized TSC with CPU 0 (last diff -45 cycles, maxerr 4040 cycles)
[  371.800992] softlockup thread 3 started up.
[  371.801087] Booting processor 4/8 APIC 0x20
[  242.970377] Initializing CPU#4
[  243.116990] Calibrating delay using timer specific routine.. 6672.69 BogoMIPS (lpj=33363488)
[  243.117013] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  243.117015] CPU: L2 cache: 1024K
[  243.117016] CPU: L3 cache: 8192K
[  243.117020] CPU 4 -> Node 1
[  243.117023] CPU: Hyper-Threading is disabled
[  243.117040] CPU4: Thermal monitoring enabled (TM1)
[  243.118176]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  243.118190] APIC error on CPU4: 00(40)
[  243.118195] CPU 4: Syncing TSC to CPU 0.
[  371.960880] CPU 4: synchronized TSC with CPU 0 (last diff -30 cycles, maxerr 6740 cycles)
[  371.960922] softlockup thread 4 started up.
[  371.961024] Booting processor 5/8 APIC 0x26
[  243.130286] Initializing CPU#5
[  243.276500] Calibrating delay using timer specific routine.. 6672.74 BogoMIPS (lpj=33363706)
[  243.276516] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  243.276518] CPU: L2 cache: 1024K
[  243.276519] CPU: L3 cache: 8192K
[  243.276522] CPU 5 -> Node 1
[  243.276525] CPU: Hyper-Threading is disabled
[  243.276537] CPU5: Thermal monitoring enabled (TM1)
[  243.277668]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  243.277679] APIC error on CPU5: 00(40)
[  243.277683] CPU 5: Syncing TSC to CPU 0.
[  372.120369] CPU 5: synchronized TSC with CPU 0 (last diff -73 cycles, maxerr 6700 cycles)
[  372.120407] softlockup thread 5 started up.
[  372.120504] Booting processor 6/8 APIC 0x30
[  243.289766] Initializing CPU#6
[  243.436010] Calibrating delay using timer specific routine.. 6672.98 BogoMIPS (lpj=33364932)
[  243.436026] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  243.436028] CPU: L2 cache: 1024K
[  243.436029] CPU: L3 cache: 8192K
[  243.436032] CPU 6 -> Node 1
[  243.436035] CPU: Hyper-Threading is disabled
[  243.436048] CPU6: Thermal monitoring enabled (TM1)
[  243.437176]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  243.437187] APIC error on CPU6: 00(40)
[  243.437191] CPU 6: Syncing TSC to CPU 0.
[  372.279874] CPU 6: synchronized TSC with CPU 0 (last diff -163 cycles, maxerr 6700 cycles)
[  372.279915] softlockup thread 6 started up.
[  372.280028] Booting processor 7/8 APIC 0x36
[  243.449291] Initializing CPU#7
[  243.595520] Calibrating delay using timer specific routine.. 6673.06 BogoMIPS (lpj=33365308)
[  243.595536] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  243.595538] CPU: L2 cache: 1024K
[  243.595539] CPU: L3 cache: 8192K
[  243.595543] CPU 7 -> Node 1
[  243.595545] CPU: Hyper-Threading is disabled
[  243.595558] CPU7: Thermal monitoring enabled (TM1)
[  243.596686]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  243.596697] APIC error on CPU7: 00(40)
[  243.596701] CPU 7: Syncing TSC to CPU 0.
[  372.439382] CPU 7: synchronized TSC with CPU 0 (last diff -25 cycles, maxerr 6700 cycles)
[  372.439406] Brought up 8 CPUs
[  372.439423] softlockup thread 7 started up.
[  372.508651] time.c: Using PIT/HPET based timekeeping.
[  372.514688] testing NMI watchdog ... CPU#0: NMI appears to be stuck (12->12)!
[  372.623502] checking if image is initramfs... it is
[  372.683597] NET: Registered protocol family 16
[  372.688970] ACPI: bus type pci registered
[  372.693789] PCI: Using configuration type 1
[  372.701977] ACPI: Subsystem revision 20050902
[  372.764709] ACPI: Interpreter enabled
[  372.769099] ACPI: Using IOAPIC for interrupt routing
[  372.777626] ACPI: PCI Root Bridge [VP00] (0000:00)
[  372.783347] PCI: Probing PCI hardware (bus 00)
[  372.791758] Boot video device is 0000:00:01.0
[  372.792283] PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
[  372.799534] ACPI: PCI Interrupt Routing Table [\_SB_.VP00._PRT]
[  372.805865] ACPI: PCI Root Bridge [VP01] (0000:01)
[  372.811612] PCI: Probing PCI hardware (bus 01)
[  372.820281] ACPI: PCI Interrupt Routing Table [\_SB_.VP01._PRT]
[  372.821600] ACPI: PCI Root Bridge [VP02] (0000:02)
[  372.827350] PCI: Probing PCI hardware (bus 02)
[  372.835635] ACPI: PCI Interrupt Routing Table [\_SB_.VP02._PRT]
[  372.838517] ACPI: PCI Root Bridge [VP03] (0000:04)
[  372.844260] PCI: Probing PCI hardware (bus 04)
[  372.852548] ACPI: PCI Interrupt Routing Table [\_SB_.VP03._PRT]
[  372.855032] ACPI: PCI Root Bridge [VP04] (0000:06)
[  372.860747] PCI: Probing PCI hardware (bus 06)
[  372.869001] ACPI: PCI Interrupt Routing Table [\_SB_.VP04._PRT]
[  372.871669] ACPI: PCI Root Bridge [VP05] (0000:08)
[  372.877417] PCI: Probing PCI hardware (bus 08)
[  372.885738] ACPI: PCI Interrupt Routing Table [\_SB_.VP05._PRT]
[  372.888439] ACPI: PCI Root Bridge [VP06] (0000:0a)
[  372.894163] PCI: Probing PCI hardware (bus 0a)
[  372.902467] ACPI: PCI Interrupt Routing Table [\_SB_.VP06._PRT]
[  372.905114] ACPI: PCI Root Bridge [VP07] (0000:0c)
[  372.910861] PCI: Probing PCI hardware (bus 0c)
[  372.919062] ACPI: PCI Interrupt Routing Table [\_SB_.VP07._PRT]
[  372.921803] ACPI: PCI Root Bridge [VP10] (0000:0e)
[  372.927544] PCI: Probing PCI hardware (bus 0e)
[  372.936358] ACPI: PCI Interrupt Routing Table [\_SB_.VP10._PRT]
[  372.937885] ACPI: PCI Root Bridge [VP11] (0000:0f)
[  372.943619] PCI: Probing PCI hardware (bus 0f)
[  372.952311] ACPI: PCI Interrupt Routing Table [\_SB_.VP11._PRT]
[  372.953723] ACPI: PCI Root Bridge [VP12] (0000:10)
[  372.959471] PCI: Probing PCI hardware (bus 10)
[  372.967770] ACPI: PCI Interrupt Routing Table [\_SB_.VP12._PRT]
[  372.970451] ACPI: PCI Root Bridge [VP13] (0000:12)
[  372.976209] PCI: Probing PCI hardware (bus 12)
[  372.984487] ACPI: PCI Interrupt Routing Table [\_SB_.VP13._PRT]
[  372.987187] ACPI: PCI Root Bridge [VP14] (0000:14)
[  372.992903] PCI: Probing PCI hardware (bus 14)
[  373.001171] ACPI: PCI Interrupt Routing Table [\_SB_.VP14._PRT]
[  373.003746] ACPI: PCI Root Bridge [VP15] (0000:16)
[  373.009481] PCI: Probing PCI hardware (bus 16)
[  373.017766] ACPI: PCI Interrupt Routing Table [\_SB_.VP15._PRT]
[  373.020441] ACPI: PCI Root Bridge [VP16] (0000:18)
[  373.026185] PCI: Probing PCI hardware (bus 18)
[  373.034475] ACPI: PCI Interrupt Routing Table [\_SB_.VP16._PRT]
[  373.037094] ACPI: PCI Root Bridge [VP17] (0000:1a)
[  373.042808] PCI: Probing PCI hardware (bus 1a)
[  373.052328] ACPI: PCI Interrupt Routing Table [\_SB_.VP17._PRT]
[  373.056903] SCSI subsystem initialized
[  373.061417] PCI: Using ACPI for IRQ routing
[  373.066423] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[  373.076690] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[  373.090986] PCI: Bridge: 0000:1a:01.0
[  373.095393]   IO window: f000-ffff
[  373.099472]   MEM window: f8600000-f86fffff
[  373.104475]   PREFETCH window: disabled.
[  373.114868] IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
[  373.134138] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
[  373.149954] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  373.157784] SGI XFS with large block/inode numbers, no debug enabled
[  373.167417] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[  373.347957] Real Time Clock Driver v1.12
[  373.352690] Linux agpgart interface v0.101 (c) Dave Jones
[  373.360764] serio: i8042 AUX port at 0x60,0x64 irq 12
[  373.366921] serio: i8042 KBD port at 0x60,0x64 irq 1
[  373.372911] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[  373.382632] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  373.388853] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[  373.396024] io scheduler noop registered
[  373.400804] io scheduler anticipatory registered
[  373.406410] io scheduler deadline registered
[  373.411662] io scheduler cfq registered
[  373.420116] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[  373.431148] loop: loaded (max 8 devices)
[  373.435886] Intel(R) PRO/1000 Network Driver - version 6.0.60-k2-NAPI
[  373.443638] Copyright (c) 1999-2005 Intel Corporation.
[  373.450091] ACPI: PCI Interrupt 0000:1b:04.0[A] -> GSI 124 (level, low) -> IRQ 169
[  373.798723] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[  373.806969] ACPI: PCI Interrupt 0000:1b:04.1[B] -> GSI 128 (level, low) -> IRQ 177
[  374.157872] e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
[  374.166146] ACPI: PCI Interrupt 0000:1b:06.0[A] -> GSI 132 (level, low) -> IRQ 185
[  374.516534] e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
[  374.526558] ACPI: PCI Interrupt 0000:1b:06.1[B] -> GSI 136 (level, low) -> IRQ 193
[  374.875427] e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
[  374.883807] tg3.c:v3.42 (Oct 3, 2005)
[  374.888214] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 24 (level, low) -> IRQ 201
[  374.926685] eth4: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:3d:7e
[  374.940607] eth4: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0] 
[  374.950619] eth4: dma_rwctrl[769f0000]
[  374.955132] ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 28 (level, low) -> IRQ 209
[  374.994160] eth5: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:3d:7f
[  375.008044] eth5: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[  375.018045] eth5: dma_rwctrl[769f0000]
[  375.022610] ACPI: PCI Interrupt 0000:0f:01.0[A] -> GSI 94 (level, low) -> IRQ 217
[  375.055039] eth6: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:3d:78
[  375.068919] eth6: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0] 
[  375.078946] eth6: dma_rwctrl[769f0000]
[  375.083512] ACPI: PCI Interrupt 0000:0f:01.1[B] -> GSI 98 (level, low) -> IRQ 225
[  375.122777] eth7: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:3d:79
[  375.136662] eth7: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[  375.146689] eth7: dma_rwctrl[769f0000]
[  375.151353] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  375.158957] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  375.169595] libata version 1.12 loaded.
[  375.170516] mice: PS/2 mouse device common for all mice
[  375.176946] oprofile: using NMI interrupt.
[  375.182071] NET: Registered protocol family 2
[  375.213704] input: AT Translated Set 2 keyboard on isa0060/serio0
[  375.294629] IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
[  375.307385] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[  375.320764] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[  375.329743] TCP: Hash tables configured (established 262144 bind 65536)
[  375.337662] TCP reno registered
[  375.341583] TCP bic registered
[  375.345286] NET: Registered protocol family 1
[  375.350522] NET: Registered protocol family 17
[  375.356473] Freeing unused kernel memory: 208k freed
[  375.447440] Loading AIC-94xx Linux SAS/SATA Family Driver, Rev: 1.0.7-3
[  375.447444] 
[  375.457323] Probing Adaptec AIC-94xx Controller(s)...
[  375.463402] ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 25 (level, low) -> IRQ 233
[  375.495851] input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
[  375.602789] Probing Adaptec AIC-94xx Controller(s)...
[  375.608884] ACPI: PCI Interrupt 0000:0f:02.0[A] -> GSI 95 (level, low) -> IRQ 50
[  375.763377] scsi0 : Adaptec AIC-9410 SAS/SATA Host Adapter
[  375.976623]   Vendor: IBM-ESXS  Model: ST973401SS    F   Rev: B515
[  375.984267]   Type:   Direct-Access                      ANSI SCSI revision: 04
[  375.993059] adp94xx:1:128:0: Tagged Queuing enabled.  Depth 32
[  376.000815] SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
[  376.010208] SCSI device sda: drive cache: write through
[  376.017262] SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
[  376.026625] SCSI device sda: drive cache: write through
[  376.032871]  sda: sda1 sda2 sda3
[  376.045017] Attached scsi disk sda at scsi0, channel 1, id 128, lun 0
[  376.052886] Attached scsi generic sg0 at scsi0, channel 1, id 128, lun 0,  type 0
[  376.119922] scsi1 : Adaptec AIC-9410 SAS/SATA Host Adapter
[  376.327989]   Vendor: IBM-ESXS  Model: ST973401SS    F   Rev: B515
[  376.335661]   Type:   Direct-Access                      ANSI SCSI revision: 04
[  376.344446] adp94xx:0:128:0: Tagged Queuing enabled.  Depth 32
[  376.352208] SCSI device sdb: 143374000 512-byte hdwr sectors (73407 MB)
[  376.361579] SCSI device sdb: drive cache: write through
[  376.368576] SCSI device sdb: 143374000 512-byte hdwr sectors (73407 MB)
[  376.377947] SCSI device sdb: drive cache: write through
[  376.384185]  sdb: sdb1 sdb2 sdb3 < sdb5 >
[  376.403469] Attached scsi disk sdb at scsi1, channel 0, id 128, lun 0
[  376.411349] Attached scsi generic sg1 at scsi1, channel 0, id 128, lun 0,  type 0
[  376.484646] AIC-94xx controller(s) attached = 2.
[  376.484648] 
[  376.612494] kjournald starting.  Commit interval 5 seconds
[  376.612476] EXT3-fs: mounted filesystem with ordered data mode.
[  428.249374] EXT3 FS on sda2, internal journal
[  428.501350] kjournald starting.  Commit interval 5 seconds
[  428.510383] EXT3 FS on sda1, internal journal
[  428.510392] EXT3-fs: mounted filesystem with ordered data mode.
[  428.538172] kjournald starting.  Commit interval 5 seconds
[  428.548850] EXT3 FS on sdb2, internal journal
[  428.548857] EXT3-fs: mounted filesystem with ordered data mode.
[  428.568441] XFS mounting filesystem sdb5
[  428.661737] Ending clean XFS mount for filesystem: sdb5

--uAKRQypu60I7Lcqm--
