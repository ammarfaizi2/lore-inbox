Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268537AbUHRBIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268537AbUHRBIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 21:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268538AbUHRBIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 21:08:19 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:20838 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S268537AbUHRBHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 21:07:20 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.8.1-mm1 broke USB driver with ACPI pci irq routing... info follows
Date: Tue, 17 Aug 2004 21:04:30 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408170257.26712.shawn.starr@rogers.com> <200408170848.42173.bjorn.helgaas@hp.com>
In-Reply-To: <200408170848.42173.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408172104.30280.shawn.starr@rogers.com>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_NtqIBlKTAibsiJC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_NtqIBlKTAibsiJC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On August 17, 2004 10:48, Bjorn Helgaas wrote:
> On Tuesday 17 August 2004 12:57 am, Shawn Starr wrote:
> > here is the lspci info. If I enable pci=routeirq the driver loads fine.
>
> Thanks!  Could I trouble you to also send the full dmesg logs?  If
> you can get one from the failing case as well, that'd be great (but
> it might require a serial console; not sure exactly where the failure
> you're seeing is).


Here is the info including the oops 

Shawn.



--Boundary-00=_NtqIBlKTAibsiJC
Content-Type: text/plain;
  charset="iso-8859-1";
  name="usb-oops.dump"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usb-oops.dump"

 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 USB Universal Host Controller Interface driver v2.2
 ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
 uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
 uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
 uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
 uhci_hcd 0000:00:1d.0: detected 2 ports
 usb usb1: Product: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
 usb usb1: Manufacturer: Linux 2.6.8.1-mm1 uhci_hcd
 usb usb1: SerialNumber: 0000:00:1d.0
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 2 ports detected
 c0284d59
 PREEMPT DEBUG_PAGEALLOC
 Modules linked in: uhci_hcd usbcore
 CPU:    0
 EIP:    0060:[pnp_register_protocol+265/560]    Not tainted VLI
 EFLAGS: 00010246   (2.6.8.1-mm1) 
 EIP is at acpi_pci_link_allocate+0x106/0x14a
 eax: 0000000b   ebx: f5018d48   ecx: c18f9de0   edx: 00000000
 esi: c18f9de0   edi: 00000000   ebp: f5018d60   esp: f5018d48
 ds: 007b   es: 007b   ss: 0068
 Process modprobe (pid: 1175, threadinfo=f5018000 task=f512c9f0)
 Stack: 00400000 c0475c77 c0475a28 f5018d8c c18f9de0 f5018d70 f5018d8c c0284e5c 
        c18f9de0 c1bcfbf8 00400000 c0475d2d c0475a28 00000010 00000000 00000001 
        f5018da4 f5018dc0 c0285722 c1a0afa0 00000000 f5018ddc f5018de0 00400000 
 Call Trace:
  [show_registers+255/448] show_stack+0x7f/0xa0
  [die+22/624] show_registers+0x156/0x1d0
  [do_divide_error+66/256] die+0x162/0x2f0
  [global_flush_tlb+434/512] do_page_fault+0x312/0x630
  [nmi+17/35] error_code+0x2d/0x38
  [pnp_register_protocol+524/560] acpi_pci_link_get_irq+0xbf/0x138
  [card_probe+210/224] acpi_pci_irq_lookup+0x9e/0x111
  [pnp_add_card+329/720] acpi_pci_irq_enable+0xf8/0x203
  [get_power_status+247/288] pci_enable_device_bars+0x27/0x40
  [get_adapter_present+18/304] pci_enable_device+0x22/0x50
  [pg0+944534108/1067859968] usb_hcd_pci_probe+0x3c/0x610 [usbcore]
  [enable_slot+3453/4288] pci_device_probe_static+0x4d/0x70
  [enable_slot+3548/4288] __pci_device_probe+0x3c/0x50
  [enable_slot+3612/4288] pci_device_probe+0x2c/0x60
  [as_update_seekdist+141/320] bus_match+0x3d/0x80
  [as_update_iohist+146/528] driver_attach+0x52/0xa0
  [as_completed_request+724/896] bus_add_driver+0xa4/0xe0
  [as_move_to_dispatch+456/528] driver_register+0x88/0x90
  [ibmphp_do_disable_slot+8/1440] pci_register_driver+0x98/0xc0
  [pg0+942276776/1067859968] uhci_hcd_init+0xa8/0x155 [uhci_hcd]
  [free_some_memory+19/64] sys_init_module+0x1e3/0x400
  [syscall_trace_entry+31/36] syscall_call+0x7/0xb
 Code: 50 30 83 c0 55 52 50 68 b2 5c 47 c0 e8 e1 87 ea ff 6a ff 6a ed 53 68 37 02 00 00 e8 15 52 ff ff b8 ed ff ff ff eb 41 0f b6 46 10 <81> 04 85 e0 92 57 c0 00 10 00 00 0f b6 46 10 50 8b 46 08 8d 50 
  <7>ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96

--Boundary-00=_NtqIBlKTAibsiJC
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.dump"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.dump"

 Linux version 2.6.8.1-mm1 (root@segfault) (gcc version 3.4.1 (Debian 3.4.1-5)) #7 Tue Aug 17 20:47:56 EDT 2004
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003ff60000 (usable)
  BIOS-e820: 000000003ff60000 - 000000003ff77000 (ACPI data)
  BIOS-e820: 000000003ff77000 - 000000003ff79000 (ACPI NVS)
  BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
 127MB HIGHMEM available.
 896MB LOWMEM available.
 DMI present.
 ACPI: RSDP (v002 IBM                                       ) @ 0x000f6e00
 ACPI: XSDT (v001 IBM    TP-1R    0x00003051  LTP 0x00000000) @ 0x3ff6af83
 ACPI: FADT (v003 IBM    TP-1R    0x00003051 IBM  0x00000001) @ 0x3ff6b000
 ACPI: SSDT (v001 IBM    TP-1R    0x00003051 MSFT 0x0100000e) @ 0x3ff6b1b4
 ACPI: ECDT (v001 IBM    TP-1R    0x00003051 IBM  0x00000001) @ 0x3ff76e06
 ACPI: TCPA (v001 IBM    TP-1R    0x00003051 PTL  0x00000001) @ 0x3ff76e58
 ACPI: BOOT (v001 IBM    TP-1R    0x00003051  LTP 0x00000001) @ 0x3ff76fd8
 ACPI: DSDT (v001 IBM    TP-1R    0x00003051 MSFT 0x0100000e) @ 0x00000000
 ACPI: PM-Timer IO Port: 0x1008
 Built 1 zonelists
 Initializing CPU#0
 Kernel command line: auto BOOT_IMAGE=test ro root=301 pci=routeirq
 CPU 0 irqstacks, hard=c0589000 soft=c0588000
 PID hash table entries: 4096 (order 12: 32768 bytes)
 Detected 1798.991 MHz processor.
 Using pmtmr for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
 Memory: 1032380k/1047936k available (3320k kernel code, 14944k reserved, 1065k data, 228k init, 130432k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
 CPU: L1 I cache: 32K, L1 D cache: 32K
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 CPU: Intel(R) Pentium(R) M processor 1.80GHz stepping 06
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
  tbxface-0117 [02] acpi_load_tables      : ACPI Tables successfully acquired
 Parsing all Control Methods:.........................................................................................................................................................................................................................................................................................................................................................................................................
 Table [DSDT](id F005) - 1328 Objects with 63 Devices 393 Methods 20 Regions
 Parsing all Control Methods:.
 Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
 ACPI Namespace successfully loaded at root c05acd5c
 ACPI: IRQ9 SCI: Edge set to Level Trigger.
 evxfevnt-0093 [03] acpi_enable           : Transition to ACPI mode successful
 NET: Registered protocol family 16
 PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
 PCI: Using configuration type 1
 mtrr: v2.0 (20020519)
 ACPI: Subsystem revision 20040715
 evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs at 0000000000001028 on int 0x9
 evgpeblk-0989 [07] ev_create_gpe_block   : Found 8 Wake, Enabled 0 Runtime GPEs in this block
 ACPI: Found ECDT
 Completing Region/Field/Buffer/Package initialization:........................................................................................................................................................................................................................................................
 Initialized 19/20 Regions 123/123 Fields 67/67 Buffers 39/47 Packages (1338 nodes)
 Executing all Device _STA and_INI methods:....................................................... exfldio-0158 [23] ex_setup_region       : Field [PWKI] access width (4 bytes) too large for region [U7CS] (length 2)
  exfldio-0170 [23] ex_setup_region       : Field [PWKI] Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
  exfldio-0194: *** Warning: The ACPI AML in your computer contains errors, please nag the manufacturer to correct it.
  exfldio-0197: *** Warning: Allowing relaxed access to fields; turn on CONFIG_ACPI_DEBUG for details.
  exfldio-0158 [23] ex_setup_region       : Field [PWKI] access width (4 bytes) too large for region [U7CS] (length 2)
  exfldio-0170 [23] ex_setup_region       : Field [PWKI] Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
  exfldio-0158 [23] ex_setup_region       : Field [PWUC] access width (4 bytes) too large for region [U7CS] (length 2)
  exfldio-0170 [23] ex_setup_region       : Field [PWUC] Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
  exfldio-0158 [23] ex_setup_region       : Field [PWUC] access width (4 bytes) too large for region [U7CS] (length 2)
  exfldio-0170 [23] ex_setup_region       : Field [PWUC] Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
 ......
 61 Devices found containing: 61 _STA, 8 _INI methods
 ACPI: Interpreter enabled
 ACPI: Using PIC for interrupt routing
 ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
 ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
 ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
 ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
 ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
 ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
 ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
 ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
 ACPI: PCI Root Bridge [PCI0] (00:00)
 PCI: Probing PCI hardware (bus 00)
 PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
 PCI: Transparent bridge - 0000:00:1e.0
 ACPI: Embedded Controller [EC] (gpe 28)
 ACPI: Power Resource [PUBS] (on)
 Linux Plug and Play Support v0.97 (c) Adam Belay
 PnPBIOS: Scanning system for PnP BIOS support...
 PnPBIOS: Found PnP BIOS installation structure at 0xc00f6e30
 PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb699, dseg 0x400
 pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
 pnp: 00:0b: ioport range 0x1000-0x105f could not be reserved
 pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
 pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
 PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
 Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
 PCI: Using ACPI for IRQ routing
 ** Routing PCI interrupts for all devices because "pci=routeirq"
 ** was specified.  If this was required to make a driver work,
 ** please email the output of "lspci" to bjorn.helgaas@hp.com
 ** so I can fix the driver.
 ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
 ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
 ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
 ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
 ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
 ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
 ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
 ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
 ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
 ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
 ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 5 (level, low) -> IRQ 5
 ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
 ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
 ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
 ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
 ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 5 (level, low) -> IRQ 5
 ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
 ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
 NET: Registered protocol family 23
 Bluetooth: Core ver 2.6
 NET: Registered protocol family 31
 Bluetooth: HCI device and connection manager initialized
 Bluetooth: HCI socket layer initialized
 Simple Boot Flag at 0x35 set to 0x1
 Machine check exception polling timer started.
 IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
 highmem bounce pool size: 64 pages
 Initializing Cryptographic API
 pci_hotplug: PCI Hot Plug PCI Core version: 0.5
 ibmphpd: IBM Hot Plug PCI Controller Driver version: 0.6
 acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
 acpiphp: Slot [4294967295] registered
 ACPI: AC Adapter [AC] (on-line)
 ACPI: Battery Slot [BAT0] (battery present)
 ACPI: Power Button (FF) [PWRF]
 ACPI: Lid Switch [LID]
 ACPI: Sleep Button (CM) [SLPB]
 ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
 ACPI: Thermal Zone [THM0] (52 C)
 Real Time Clock Driver v1.12
 Linux agpgart interface v0.100 (c) Dave Jones
 agpgart: Detected an Intel 855PM Chipset.
 agpgart: Maximum main memory to use for agp memory: 941M
 agpgart: AGP aperture is 256M @ 0xd0000000
 Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
 Using anticipatory io scheduler
 floppy0: no floppy controllers found
 pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
 Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
 Copyright (c) 1999-2004 Intel Corporation.
 ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
 e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
 netconsole: not configured, aborting
 Linux video capture interface: v1.00
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 ICH4: IDE controller at PCI slot 0000:00:1f.1
 PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
 ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
 ICH4: chipset revision 1
 ICH4: not 100%% native mode: will probe irqs later
     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
 Probing IDE interface ide0...
 hda: HTS548080M9AT00, ATA DISK drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 Probing IDE interface ide1...
 hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4242N, ATAPI CD/DVD-ROM drive
 ide1 at 0x170-0x177,0x376 on irq 15
 hda: max request size: 128KiB
 hda: 156301488 sectors (80026 MB) w/7877KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: cache flushes supported
  hda: hda1 hda2
 hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
 Uniform CD-ROM driver Revision: 3.20
 ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
 Yenta: CardBus bridge found at 0000:02:00.0 [1014:0552]
 Yenta: ISA IRQ mask 0x04d8, PCI irq 11
 Socket status: 30000086
 ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 5 (level, low) -> IRQ 5
 Yenta: CardBus bridge found at 0000:02:00.1 [1014:0552]
 Yenta: ISA IRQ mask 0x04d8, PCI irq 5
 Socket status: 30000086
 mice: PS/2 mouse device common for all mice
 input: AT Translated Set 2 keyboard on isa0060/serio0
 Synaptics Touchpad, model: 1
  Firmware: 5.9
  Sensor: 44
  new absolute packet format
  Touchpad has extended capability bits
  -> multifinger detection
  -> palm detection
  -> pass-through port
 input: SynPS/2 Synaptics TouchPad on isa0060/serio1
 serio: Synaptics pass-through port at isa0060/serio1/input0
 input: PS/2 Generic Mouse on synaptics-pt/serio0
 input: PC Speaker
 Please email the following PERFCTR INIT lines to mikpe@csd.uu.se
 To remove this message, rebuild the driver with CONFIG_PERFCTR_INIT_TESTS=n
 PERFCTR INIT: vendor 0, family 6, model 13, stepping 6, clock 1798991 kHz
 PERFCTR INIT: NITER == 64
 PERFCTR INIT: loop overhead is 278 cycles
 PERFCTR INIT: rdtsc cost is 45.9 cycles (3217 total)
 PERFCTR INIT: rdpmc cost is 44.6 cycles (3133 total)
 PERFCTR INIT: rdmsr (counter) cost is 104.1 cycles (6945 total)
 PERFCTR INIT: rdmsr (evntsel) cost is 87.8 cycles (5903 total)
 PERFCTR INIT: wrmsr (counter) cost is 154.4 cycles (10160 total)
 PERFCTR INIT: wrmsr (evntsel) cost is 143.0 cycles (9436 total)
 PERFCTR INIT: read cr4 cost is 3.3 cycles (490 total)
 PERFCTR INIT: write cr4 cost is 52.5 cycles (3640 total)
 PERFCTR INIT: write LVTPC cost is 8.9 cycles (848 total)
 PERFCTR INIT: sync_core cost is 150.1 cycles (9889 total)
 perfctr: driver 2.7.5, cpu type Intel P6 at 1798991 kHz
 Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
 ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
 intel8x0_measure_ac97_clock: measured 49629 usecs
 intel8x0: clocking to 48000
 ALSA device list:
   #0: Intel 82801DB-ICH4 at 0xc0000c00, irq 5
 NET: Registered protocol family 2
 IP: routing cache hash table of 2048 buckets, 64Kbytes
 TCP: Hash tables configured (established 262144 bind 37449)
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
 ACPI: (supports S0 S3 S4 S5)
 ACPI wakeup devices: 
  LID SLPB PCI0 UART PCI1 USB0 USB1 USB2 AC9M 
 BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 228k freed
 kjournald starting.  Commit interval 5 seconds
 Adding 997912k swap on /dev/hda2.  Priority:-1 extents:1
 EXT3 FS on hda1, internal journal
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 USB Universal Host Controller Interface driver v2.2
 ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
 uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
 uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
 uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
 uhci_hcd 0000:00:1d.0: detected 2 ports
 usb usb1: Product: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
 usb usb1: Manufacturer: Linux 2.6.8.1-mm1 uhci_hcd
 usb usb1: SerialNumber: 0000:00:1d.0
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 2 ports detected
 ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
 uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
 uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
 uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
 uhci_hcd 0000:00:1d.1: detected 2 ports
 usb usb2: Product: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
 usb usb2: Manufacturer: Linux 2.6.8.1-mm1 uhci_hcd
 usb usb2: SerialNumber: 0000:00:1d.1
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
 ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
 uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
 uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
 uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
 uhci_hcd 0000:00:1d.2: detected 2 ports
 usb usb3: Product: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
 usb usb3: Manufacturer: Linux 2.6.8.1-mm1 uhci_hcd
 usb usb3: SerialNumber: 0000:00:1d.2
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 2 ports detected
 ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
 ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
 ehci_hcd 0000:00:1d.7: irq 11, pci mem f883c000
 ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
 ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
 usb usb4: Product: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
 usb usb4: Manufacturer: Linux 2.6.8.1-mm1 ehci_hcd
 usb usb4: SerialNumber: 0000:00:1d.7
 hub 4-0:1.0: USB hub found
 hub 4-0:1.0: 6 ports detected
 cs: IO port probe 0x0100-0x04ff: clean.
 cs: IO port probe 0x0800-0x08ff: clean.
 cs: IO port probe 0x0c00-0x0cff: clean.
 cs: IO port probe 0x0a00-0x0aff: clean.

--Boundary-00=_NtqIBlKTAibsiJC--
