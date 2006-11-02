Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752041AbWKBK0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbWKBK0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWKBK0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:26:16 -0500
Received: from pm-mx5.mgn.net ([195.46.220.209]:44232 "EHLO pm-mx5.mgn.net")
	by vger.kernel.org with ESMTP id S1752041AbWKBK0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:26:13 -0500
Date: Thu, 2 Nov 2006 11:26:07 +0100
From: Damien Wyart <damien.wyart@free.fr>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       James@superbug.demon.co.uk, Takashi Iwai <tiwai@suse.de>
Subject: ALSA message with 2.6.19-rc4-mm2 (not -mm1)
Message-ID: <20061102102607.GA2176@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I notice these messages when 2.6.19-rc4-mm2 boots (also with rc3-mm1)
but 2.6.19-rc4-mm1 did NOT display them. Related to the driver tree ?
Full dmesg and lspci attached. Can provide more details if needed.

Nov  2 11:06:49 brouette kernel: Advanced Linux Sound Architecture Driver Version 1.0.13 (Sun Oct 22 08:56:16 2006 UTC).
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 21
Nov  2 11:06:49 brouette kernel: kobject_add failed for card0 with -EEXIST, don't try to register things with the same name in the same directory.
Nov  2 11:06:49 brouette kernel:  [<c02b810e>] kobject_add+0x114/0x192
Nov  2 11:06:49 brouette kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Nov  2 11:06:49 brouette kernel:  [<c02bb516>] vsnprintf+0x2ef/0x5f8
Nov  2 11:06:49 brouette kernel:  [<c03131a8>] device_add+0x99/0x446
Nov  2 11:06:49 brouette kernel:  [<c03135e0>] device_create+0x7b/0x9c
Nov  2 11:06:49 brouette kernel:  [<c037bc6d>] snd_card_register+0x36/0x2f6
Nov  2 11:06:49 brouette kernel:  [<c03807f7>] snd_hwdep_new+0x8d/0xc3
Nov  2 11:06:49 brouette kernel: usb 2-1: new device found, idVendor=056d, idProduct=0002
Nov  2 11:06:49 brouette kernel: usb 2-1: new device strings: Mfr=4, Product=14, SerialNumber=0
Nov  2 11:06:49 brouette kernel: usb 2-1: Product: EIZO USB HID Monitor
Nov  2 11:06:49 brouette kernel: usb 2-1: Manufacturer: EIZO
Nov  2 11:06:49 brouette kernel: usb 2-1: configuration #1 chosen from 1 choice
Nov  2 11:06:49 brouette kernel:  [<c03c0c0f>] snd_emux_init_hwdep+0x8f/0x9f
Nov  2 11:06:49 brouette kernel:  [<c03be44d>] snd_emu10k1_sample_new+0x0/0x1a3
Nov  2 11:06:49 brouette kernel:  [<c03be990>] snd_emux_register+0xda/0x11e
Nov  2 11:06:49 brouette kernel:  [<c03be800>] sf_sample_new+0x0/0x1f
Nov  2 11:06:49 brouette kernel:  [<c03be81f>] sf_sample_free+0x0/0x8
Nov  2 11:06:49 brouette kernel:  [<c03bda90>] snd_emu10k1_synth_new_device+0xdc/0x14c
Nov  2 11:06:49 brouette kernel:  [<c03a098d>] init_device+0x28/0x8e
Nov  2 11:06:49 brouette kernel:  [<c03a0ad7>] find_driver+0x6f/0x115
Nov  2 11:06:49 brouette kernel:  [<c0418040>] mutex_lock+0xb/0x1c
Nov  2 11:06:49 brouette kernel:  [<c03a1050>] snd_seq_device_register_driver+0x9b/0x11b
Nov  2 11:06:49 brouette kernel:  [<c01004b1>] init+0x10d/0x306
Nov  2 11:06:49 brouette kernel:  [<c0102b96>] ret_from_fork+0x6/0x1c
Nov  2 11:06:49 brouette kernel:  [<c01003a4>] init+0x0/0x306
Nov  2 11:06:49 brouette kernel:  [<c01003a4>] init+0x0/0x306
Nov  2 11:06:49 brouette kernel:  [<c010389b>] kernel_thread_helper+0x7/0x1c
Nov  2 11:06:49 brouette kernel:  =======================
Nov  2 11:06:49 brouette kernel: ALSA device list:
Nov  2 11:06:49 brouette kernel:   #0: SB Live [Unknown] (rev.10, serial:0x80671102) at 0xdf20, irq 21

-- 
Damien Wyart

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kern.log"

Nov  2 11:04:36 brouette kernel: Kernel logging (proc) stopped.
Nov  2 11:04:36 brouette kernel: Kernel log daemon terminating.
Nov  2 11:06:49 brouette kernel: klogd 1.4.1#20, log source = /proc/kmsg started.
Nov  2 11:06:49 brouette kernel: Linux version 2.6.19-rc4-mm2-02112006dw (root@brouette) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #1 SMP Thu Nov 2 10:21:34 CET 2006
Nov  2 11:06:49 brouette kernel: BIOS-provided physical RAM map:
Nov  2 11:06:49 brouette kernel: sanitize start
Nov  2 11:06:49 brouette kernel: sanitize end
Nov  2 11:06:49 brouette kernel: copy_e820_map() start: 0000000000000000 size: 00000000000a0000 end: 00000000000a0000 type: 1
Nov  2 11:06:49 brouette kernel: copy_e820_map() type is E820_RAM
Nov  2 11:06:49 brouette kernel: copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
Nov  2 11:06:49 brouette kernel: copy_e820_map() start: 0000000000100000 size: 000000007fe74000 end: 000000007ff74000 type: 1
Nov  2 11:06:49 brouette kernel: copy_e820_map() type is E820_RAM
Nov  2 11:06:49 brouette kernel: copy_e820_map() start: 000000007ff74000 size: 0000000000002000 end: 000000007ff76000 type: 4
Nov  2 11:06:49 brouette kernel: copy_e820_map() start: 000000007ff76000 size: 0000000000021000 end: 000000007ff97000 type: 3
Nov  2 11:06:49 brouette kernel: copy_e820_map() start: 000000007ff97000 size: 0000000000069000 end: 0000000080000000 type: 2
Nov  2 11:06:49 brouette kernel: copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end: 00000000fec10000 type: 2
Nov  2 11:06:49 brouette kernel: copy_e820_map() start: 00000000fecf0000 size: 0000000000001000 end: 00000000fecf1000 type: 2
Nov  2 11:06:49 brouette kernel: copy_e820_map() start: 00000000fed20000 size: 0000000000070000 end: 00000000fed90000 type: 2
Nov  2 11:06:49 brouette kernel: copy_e820_map() start: 00000000fee00000 size: 0000000000010000 end: 00000000fee10000 type: 2
Nov  2 11:06:49 brouette kernel: copy_e820_map() start: 00000000ffb00000 size: 0000000000500000 end: 0000000100000000 type: 2
Nov  2 11:06:49 brouette kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Nov  2 11:06:49 brouette kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Nov  2 11:06:49 brouette kernel:  BIOS-e820: 0000000000100000 - 000000007ff74000 (usable)
Nov  2 11:06:49 brouette kernel:  BIOS-e820: 000000007ff74000 - 000000007ff76000 (ACPI NVS)
Nov  2 11:06:49 brouette kernel:  BIOS-e820: 000000007ff76000 - 000000007ff97000 (ACPI data)
Nov  2 11:06:49 brouette kernel:  BIOS-e820: 000000007ff97000 - 0000000080000000 (reserved)
Nov  2 11:06:49 brouette kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Nov  2 11:06:49 brouette kernel:  BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
Nov  2 11:06:49 brouette kernel:  BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
Nov  2 11:06:49 brouette kernel:  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
Nov  2 11:06:49 brouette kernel:  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Nov  2 11:06:49 brouette kernel: 1151MB HIGHMEM available.
Nov  2 11:06:49 brouette kernel: 896MB LOWMEM available.
Nov  2 11:06:49 brouette kernel: found SMP MP-table at 000fe710
Nov  2 11:06:49 brouette kernel: Entering add_active_range(0, 0, 524148) 0 entries of 256 used
Nov  2 11:06:49 brouette kernel: Zone PFN ranges:
Nov  2 11:06:49 brouette kernel:   DMA             0 ->     4096
Nov  2 11:06:49 brouette kernel:   Normal       4096 ->   229376
Nov  2 11:06:49 brouette kernel:   HighMem    229376 ->   524148
Nov  2 11:06:49 brouette kernel: early_node_map[1] active PFN ranges
Nov  2 11:06:49 brouette kernel:     0:        0 ->   524148
Nov  2 11:06:49 brouette kernel: On node 0 totalpages: 524148
Nov  2 11:06:49 brouette kernel:   DMA zone: 32 pages used for memmap
Nov  2 11:06:49 brouette kernel:   DMA zone: 0 pages reserved
Nov  2 11:06:49 brouette kernel:   DMA zone: 4064 pages, LIFO batch:0
Nov  2 11:06:49 brouette kernel:   Normal zone: 1760 pages used for memmap
Nov  2 11:06:49 brouette kernel:   Normal zone: 223520 pages, LIFO batch:31
Nov  2 11:06:49 brouette kernel:   HighMem zone: 2302 pages used for memmap
Nov  2 11:06:49 brouette kernel:   HighMem zone: 292470 pages, LIFO batch:31
Nov  2 11:06:49 brouette kernel: DMI 2.3 present.
Nov  2 11:06:49 brouette kernel: ACPI: RSDP (v000 DELL                                  ) @ 0x000feb90
Nov  2 11:06:49 brouette kernel: ACPI: RSDT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1ca
Nov  2 11:06:49 brouette kernel: ACPI: FADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1fe
Nov  2 11:06:49 brouette kernel: ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffc929b
Nov  2 11:06:49 brouette kernel: ACPI: MADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd272
Nov  2 11:06:49 brouette kernel: ACPI: BOOT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd2de
Nov  2 11:06:49 brouette kernel: ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
Nov  2 11:06:49 brouette kernel: ACPI: PM-Timer IO Port: 0x808
Nov  2 11:06:49 brouette kernel: ACPI: Local APIC address 0xfee00000
Nov  2 11:06:49 brouette kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Nov  2 11:06:49 brouette kernel: Processor #0 15:3 APIC version 20
Nov  2 11:06:49 brouette kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Nov  2 11:06:49 brouette kernel: Processor #1 15:3 APIC version 20
Nov  2 11:06:49 brouette kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
Nov  2 11:06:49 brouette kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
Nov  2 11:06:49 brouette kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Nov  2 11:06:49 brouette kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Nov  2 11:06:49 brouette kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Nov  2 11:06:49 brouette kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Nov  2 11:06:49 brouette kernel: ACPI: IRQ0 used by override.
Nov  2 11:06:49 brouette kernel: ACPI: IRQ2 used by override.
Nov  2 11:06:49 brouette kernel: ACPI: IRQ9 used by override.
Nov  2 11:06:49 brouette kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Nov  2 11:06:49 brouette kernel: Using ACPI (MADT) for SMP configuration information
Nov  2 11:06:49 brouette kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Nov  2 11:06:49 brouette kernel: Detected 2992.645 MHz processor.
Nov  2 11:06:49 brouette kernel: Built 1 zonelists.  Total pages: 520054
Nov  2 11:06:49 brouette kernel: Kernel command line: root=/dev/sdb2 ro vga=0x31B selinux=0 elevator=cfq video=vesafb:mtrr:3 
Nov  2 11:06:49 brouette kernel: mapped APIC to ffffd000 (fee00000)
Nov  2 11:06:49 brouette kernel: mapped IOAPIC to ffffc000 (fec00000)
Nov  2 11:06:49 brouette kernel: Enabling fast FPU save and restore... done.
Nov  2 11:06:49 brouette kernel: Enabling unmasked SIMD FPU exception support... done.
Nov  2 11:06:49 brouette kernel: Initializing CPU#0
Nov  2 11:06:49 brouette kernel: Clock event device pit configured with caps set: 07
Nov  2 11:06:49 brouette kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
Nov  2 11:06:49 brouette kernel: Console: colour dummy device 80x25
Nov  2 11:06:49 brouette kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Nov  2 11:06:49 brouette kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Nov  2 11:06:49 brouette kernel: Memory: 2073436k/2096592k available (3175k kernel code, 21932k reserved, 978k data, 212k init, 1179088k highmem)
Nov  2 11:06:49 brouette kernel: virtual kernel memory layout:
Nov  2 11:06:49 brouette kernel:     fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
Nov  2 11:06:49 brouette kernel:     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
Nov  2 11:06:49 brouette kernel:     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
Nov  2 11:06:49 brouette kernel:     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
Nov  2 11:06:49 brouette kernel:       .init : 0xc0517000 - 0xc054c000   ( 212 kB)
Nov  2 11:06:49 brouette kernel:       .data : 0xc0419dc3 - 0xc050e7ec   ( 978 kB)
Nov  2 11:06:49 brouette kernel:       .text : 0xc0100000 - 0xc0419dc3   (3175 kB)
Nov  2 11:06:49 brouette kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Nov  2 11:06:49 brouette kernel: Calibrating delay using timer specific routine.. 5987.44 BogoMIPS (lpj=2993720)
Nov  2 11:06:49 brouette kernel: Mount-cache hash table entries: 512
Nov  2 11:06:49 brouette kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Nov  2 11:06:49 brouette kernel: monitor/mwait feature present.
Nov  2 11:06:49 brouette kernel: using mwait in idle threads.
Nov  2 11:06:49 brouette kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Nov  2 11:06:49 brouette kernel: CPU: L2 cache: 1024K
Nov  2 11:06:49 brouette kernel: CPU: Physical Processor ID: 0
Nov  2 11:06:49 brouette kernel: CPU: After all inits, caps: bfebfbff 00000000 00000000 00001180 0000041d 00000000 00000000
Nov  2 11:06:49 brouette kernel: Intel machine check architecture supported.
Nov  2 11:06:49 brouette kernel: Intel machine check reporting enabled on CPU#0.
Nov  2 11:06:49 brouette kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Nov  2 11:06:49 brouette kernel: CPU0: Thermal monitoring enabled
Nov  2 11:06:49 brouette kernel: Checking 'hlt' instruction... OK.
Nov  2 11:06:49 brouette kernel: Freeing SMP alternatives: 20k freed
Nov  2 11:06:49 brouette kernel: ACPI: Core revision 20060707
Nov  2 11:06:49 brouette kernel: CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Nov  2 11:06:49 brouette kernel: Booting processor 1/1 eip 2000
Nov  2 11:06:49 brouette kernel: Initializing CPU#1
Nov  2 11:06:49 brouette kernel: Calibrating delay using timer specific routine.. 5984.21 BogoMIPS (lpj=2992108)
Nov  2 11:06:49 brouette kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Nov  2 11:06:49 brouette kernel: monitor/mwait feature present.
Nov  2 11:06:49 brouette kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Nov  2 11:06:49 brouette kernel: CPU: L2 cache: 1024K
Nov  2 11:06:49 brouette kernel: CPU: Physical Processor ID: 0
Nov  2 11:06:49 brouette kernel: CPU: After all inits, caps: bfebfbff 00000000 00000000 00001180 0000041d 00000000 00000000
Nov  2 11:06:49 brouette kernel: Intel machine check architecture supported.
Nov  2 11:06:49 brouette kernel: Intel machine check reporting enabled on CPU#1.
Nov  2 11:06:49 brouette kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
Nov  2 11:06:49 brouette kernel: CPU1: Thermal monitoring enabled
Nov  2 11:06:49 brouette kernel: CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Nov  2 11:06:49 brouette kernel: Total of 2 processors activated (11971.65 BogoMIPS).
Nov  2 11:06:49 brouette kernel: ENABLING IO-APIC IRQs
Nov  2 11:06:49 brouette kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Nov  2 11:06:49 brouette kernel: Clock event device pit new caps set: 01
Nov  2 11:06:49 brouette kernel: Clock event device lapic configured with caps set: 06
Nov  2 11:06:49 brouette kernel: checking TSC synchronization across 2 CPUs: passed.
Nov  2 11:06:49 brouette kernel: Clock event device pit new caps set: 01
Nov  2 11:06:49 brouette kernel: Clock event device lapic configured with caps set: 06
Nov  2 11:06:49 brouette kernel: Brought up 2 CPUs
Nov  2 11:06:49 brouette kernel: migration_cost=17
Nov  2 11:06:49 brouette kernel: NET: Registered protocol family 16
Nov  2 11:06:49 brouette kernel: ACPI: bus type pci registered
Nov  2 11:06:49 brouette kernel: PCI: PCI BIOS revision 2.10 entry at 0xfbb30, last bus=2
Nov  2 11:06:49 brouette kernel: PCI: Using configuration type 1
Nov  2 11:06:49 brouette kernel: Setting up standard PCI resources
Nov  2 11:06:49 brouette kernel: ACPI: Interpreter enabled
Nov  2 11:06:49 brouette kernel: ACPI: Using IOAPIC for interrupt routing
Nov  2 11:06:49 brouette kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Nov  2 11:06:49 brouette kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Nov  2 11:06:49 brouette kernel: PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
Nov  2 11:06:49 brouette kernel: PCI quirk: region 0880-08bf claimed by ICH4 GPIO
Nov  2 11:06:49 brouette kernel: Boot video device is 0000:01:00.0
Nov  2 11:06:49 brouette kernel: PCI: Firmware left 0000:02:08.0 e100 interrupts enabled, disabling
Nov  2 11:06:49 brouette kernel: PCI: Transparent bridge - 0000:00:1e.0
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 15)
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Nov  2 11:06:49 brouette kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Nov  2 11:06:49 brouette kernel: pnp: PnP ACPI init
Nov  2 11:06:49 brouette kernel: pnp: PnP ACPI: found 12 devices
Nov  2 11:06:49 brouette kernel: SCSI subsystem initialized
Nov  2 11:06:49 brouette kernel: usbcore: registered new interface driver usbfs
Nov  2 11:06:49 brouette kernel: usbcore: registered new interface driver hub
Nov  2 11:06:49 brouette kernel: usbcore: registered new device driver usb
Nov  2 11:06:49 brouette kernel: PCI: Using ACPI for IRQ routing
Nov  2 11:06:49 brouette kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Nov  2 11:06:49 brouette kernel: pnp: 00:0b: ioport range 0x800-0x85f could not be reserved
Nov  2 11:06:49 brouette kernel: pnp: 00:0b: ioport range 0xc00-0xc7f has been reserved
Nov  2 11:06:49 brouette kernel: pnp: 00:0b: ioport range 0x860-0x8ff could not be reserved
Nov  2 11:06:49 brouette kernel: PCI: Bridge: 0000:00:01.0
Nov  2 11:06:49 brouette kernel:   IO window: disabled.
Nov  2 11:06:49 brouette kernel:   MEM window: fd000000-feafffff
Nov  2 11:06:49 brouette kernel:   PREFETCH window: f0000000-f7ffffff
Nov  2 11:06:49 brouette kernel: PCI: Bridge: 0000:00:1e.0
Nov  2 11:06:49 brouette kernel:   IO window: d000-dfff
Nov  2 11:06:49 brouette kernel:   MEM window: fcf00000-fcffffff
Nov  2 11:06:49 brouette kernel:   PREFETCH window: disabled.
Nov  2 11:06:49 brouette kernel: PCI: Setting latency timer of device 0000:00:1e.0 to 64
Nov  2 11:06:49 brouette kernel: NET: Registered protocol family 2
Nov  2 11:06:49 brouette kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Nov  2 11:06:49 brouette kernel: TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
Nov  2 11:06:49 brouette kernel: TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
Nov  2 11:06:49 brouette kernel: TCP: Hash tables configured (established 262144 bind 65536)
Nov  2 11:06:49 brouette kernel: TCP reno registered
Nov  2 11:06:49 brouette kernel: Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Nov  2 11:06:49 brouette kernel: Simple Boot Flag at 0x7a set to 0x1
Nov  2 11:06:49 brouette kernel: Machine check exception polling timer started.
Nov  2 11:06:49 brouette kernel: highmem bounce pool size: 64 pages
Nov  2 11:06:49 brouette kernel: Loading Reiser4. See www.namesys.com for a description of Reiser4.
Nov  2 11:06:49 brouette kernel: JFS: nTxBlock = 8192, nTxLock = 65536
Nov  2 11:06:49 brouette kernel: SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
Nov  2 11:06:49 brouette kernel: io scheduler noop registered
Nov  2 11:06:49 brouette kernel: io scheduler cfq registered (default)
Nov  2 11:06:49 brouette kernel: vesafb: framebuffer at 0xf0000000, mapped to 0xf8d00000, using 10240k, total 131072k
Nov  2 11:06:49 brouette kernel: vesafb: mode is 1280x1024x32, linelength=5120, pages=0
Nov  2 11:06:49 brouette kernel: vesafb: protected mode interface info at c000:f080
Nov  2 11:06:49 brouette kernel: vesafb: pmi: set display start = c00cf0b6, set palette = c00cf120
Nov  2 11:06:49 brouette kernel: vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
Nov  2 11:06:49 brouette kernel: vesafb: scrolling: redraw
Nov  2 11:06:49 brouette kernel: vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Nov  2 11:06:49 brouette kernel: Console: switching to colour frame buffer device 160x64
Nov  2 11:06:49 brouette kernel: fb0: VESA VGA frame buffer device
Nov  2 11:06:49 brouette kernel: ACPI: Power Button (FF) [PWRF]
Nov  2 11:06:49 brouette kernel: ACPI: Power Button (CM) [VBTN]
Nov  2 11:06:49 brouette kernel: Real Time Clock Driver v1.12ac
Nov  2 11:06:49 brouette kernel: e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
Nov  2 11:06:49 brouette kernel: e100: Copyright(c) 1999-2006 Intel Corporation
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 16
Nov  2 11:06:49 brouette kernel: e100: eth0: e100_probe: addr 0xfcfff000, irq 16, MAC addr 00:0C:F1:B6:BA:54
Nov  2 11:06:49 brouette kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Nov  2 11:06:49 brouette kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov  2 11:06:49 brouette kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
Nov  2 11:06:49 brouette kernel: ICH5: chipset revision 2
Nov  2 11:06:49 brouette kernel: ICH5: not 100%% native mode: will probe irqs later
Nov  2 11:06:49 brouette kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Nov  2 11:06:49 brouette kernel: Probing IDE interface ide1...
Nov  2 11:06:49 brouette kernel: hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
Nov  2 11:06:49 brouette kernel: hdd: SAMSUNG CD-R/RW SW-252S, ATAPI CD/DVD-ROM drive
Nov  2 11:06:49 brouette kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov  2 11:06:49 brouette kernel: hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Nov  2 11:06:49 brouette kernel: Uniform CD-ROM driver Revision: 3.20
Nov  2 11:06:49 brouette kernel: hdd: ATAPI 16X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Nov  2 11:06:49 brouette kernel: libata version 2.00 loaded.
Nov  2 11:06:49 brouette kernel: ata_piix 0000:00:1f.2: version 2.00ac7
Nov  2 11:06:49 brouette kernel: ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
Nov  2 11:06:49 brouette kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Nov  2 11:06:49 brouette kernel: ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 17
Nov  2 11:06:49 brouette kernel: ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 17
Nov  2 11:06:49 brouette kernel: scsi0 : ata_piix
Nov  2 11:06:49 brouette kernel: ata1.00: ATA-6, max UDMA/133, 144531250 sectors: LBA48 
Nov  2 11:06:49 brouette kernel: ata1.00: ata1: dev 0 multi count 8
Nov  2 11:06:49 brouette kernel: ata1.00: applying bridge limits
Nov  2 11:06:49 brouette kernel: ata1.00: configured for UDMA/100
Nov  2 11:06:49 brouette kernel: scsi1 : ata_piix
Nov  2 11:06:49 brouette kernel: ata2.00: ATA-6, max UDMA/133, 144531250 sectors: LBA48 
Nov  2 11:06:49 brouette kernel: ata2.00: ata2: dev 0 multi count 8
Nov  2 11:06:49 brouette kernel: ata2.00: applying bridge limits
Nov  2 11:06:49 brouette kernel: ata2.00: configured for UDMA/100
Nov  2 11:06:49 brouette kernel: scsi 0:0:0:0: Direct-Access     ATA      WDC WD740GD-75FL 21.0 PQ: 0 ANSI: 5
Nov  2 11:06:49 brouette kernel: SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
Nov  2 11:06:49 brouette kernel: sda: Write Protect is off
Nov  2 11:06:49 brouette kernel: sda: Mode Sense: 00 3a 00 00
Nov  2 11:06:49 brouette kernel: SCSI device sda: drive cache: write back
Nov  2 11:06:49 brouette kernel: SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
Nov  2 11:06:49 brouette kernel: sda: Write Protect is off
Nov  2 11:06:49 brouette kernel: sda: Mode Sense: 00 3a 00 00
Nov  2 11:06:49 brouette kernel: SCSI device sda: drive cache: write back
Nov  2 11:06:49 brouette kernel:  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Nov  2 11:06:49 brouette kernel: sd 0:0:0:0: Attached scsi disk sda
Nov  2 11:06:49 brouette kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Nov  2 11:06:49 brouette kernel: scsi 1:0:0:0: Direct-Access     ATA      WDC WD740GD-75FL 21.0 PQ: 0 ANSI: 5
Nov  2 11:06:49 brouette kernel: SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
Nov  2 11:06:49 brouette kernel: sdb: Write Protect is off
Nov  2 11:06:49 brouette kernel: sdb: Mode Sense: 00 3a 00 00
Nov  2 11:06:49 brouette kernel: SCSI device sdb: drive cache: write back
Nov  2 11:06:49 brouette kernel: SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
Nov  2 11:06:49 brouette kernel: sdb: Write Protect is off
Nov  2 11:06:49 brouette kernel: sdb: Mode Sense: 00 3a 00 00
Nov  2 11:06:49 brouette kernel: SCSI device sdb: drive cache: write back
Nov  2 11:06:49 brouette kernel:  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 >
Nov  2 11:06:49 brouette kernel: sd 1:0:0:0: Attached scsi disk sdb
Nov  2 11:06:49 brouette kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 18
Nov  2 11:06:49 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Nov  2 11:06:49 brouette kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Nov  2 11:06:49 brouette kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Nov  2 11:06:49 brouette kernel: ehci_hcd 0000:00:1d.7: debug port 1
Nov  2 11:06:49 brouette kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Nov  2 11:06:49 brouette kernel: ehci_hcd 0000:00:1d.7: irq 18, io mem 0xffa80800
Nov  2 11:06:49 brouette kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Nov  2 11:06:49 brouette kernel: usb usb1: new device found, idVendor=0000, idProduct=0000
Nov  2 11:06:49 brouette kernel: usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
Nov  2 11:06:49 brouette kernel: usb usb1: Product: EHCI Host Controller
Nov  2 11:06:49 brouette kernel: usb usb1: Manufacturer: Linux 2.6.19-rc4-mm2-02112006dw ehci_hcd
Nov  2 11:06:49 brouette kernel: usb usb1: SerialNumber: 0000:00:1d.7
Nov  2 11:06:49 brouette kernel: usb usb1: configuration #1 chosen from 1 choice
Nov  2 11:06:49 brouette kernel: hub 1-0:1.0: USB hub found
Nov  2 11:06:49 brouette kernel: hub 1-0:1.0: 8 ports detected
Nov  2 11:06:49 brouette kernel: USB Universal Host Controller Interface driver v3.0
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 19
Nov  2 11:06:49 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.0: irq 19, io base 0x0000ff80
Nov  2 11:06:49 brouette kernel: usb usb2: new device found, idVendor=0000, idProduct=0000
Nov  2 11:06:49 brouette kernel: usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
Nov  2 11:06:49 brouette kernel: usb usb2: Product: UHCI Host Controller
Nov  2 11:06:49 brouette kernel: usb usb2: Manufacturer: Linux 2.6.19-rc4-mm2-02112006dw uhci_hcd
Nov  2 11:06:49 brouette kernel: usb usb2: SerialNumber: 0000:00:1d.0
Nov  2 11:06:49 brouette kernel: usb usb2: configuration #1 chosen from 1 choice
Nov  2 11:06:49 brouette kernel: hub 2-0:1.0: USB hub found
Nov  2 11:06:49 brouette kernel: hub 2-0:1.0: 2 ports detected
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
Nov  2 11:06:49 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.1: irq 20, io base 0x0000ff60
Nov  2 11:06:49 brouette kernel: usb usb3: new device found, idVendor=0000, idProduct=0000
Nov  2 11:06:49 brouette kernel: usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
Nov  2 11:06:49 brouette kernel: usb usb3: Product: UHCI Host Controller
Nov  2 11:06:49 brouette kernel: usb usb3: Manufacturer: Linux 2.6.19-rc4-mm2-02112006dw uhci_hcd
Nov  2 11:06:49 brouette kernel: usb usb3: SerialNumber: 0000:00:1d.1
Nov  2 11:06:49 brouette kernel: usb usb3: configuration #1 chosen from 1 choice
Nov  2 11:06:49 brouette kernel: hub 3-0:1.0: USB hub found
Nov  2 11:06:49 brouette kernel: hub 3-0:1.0: 2 ports detected
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
Nov  2 11:06:49 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.2: irq 17, io base 0x0000ff40
Nov  2 11:06:49 brouette kernel: usb usb4: new device found, idVendor=0000, idProduct=0000
Nov  2 11:06:49 brouette kernel: usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
Nov  2 11:06:49 brouette kernel: usb usb4: Product: UHCI Host Controller
Nov  2 11:06:49 brouette kernel: usb usb4: Manufacturer: Linux 2.6.19-rc4-mm2-02112006dw uhci_hcd
Nov  2 11:06:49 brouette kernel: usb usb4: SerialNumber: 0000:00:1d.2
Nov  2 11:06:49 brouette kernel: usb usb4: configuration #1 chosen from 1 choice
Nov  2 11:06:49 brouette kernel: hub 4-0:1.0: USB hub found
Nov  2 11:06:49 brouette kernel: hub 4-0:1.0: 2 ports detected
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 19
Nov  2 11:06:49 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Nov  2 11:06:49 brouette kernel: uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ff20
Nov  2 11:06:49 brouette kernel: usb usb5: new device found, idVendor=0000, idProduct=0000
Nov  2 11:06:49 brouette kernel: usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
Nov  2 11:06:49 brouette kernel: usb usb5: Product: UHCI Host Controller
Nov  2 11:06:49 brouette kernel: usb usb5: Manufacturer: Linux 2.6.19-rc4-mm2-02112006dw uhci_hcd
Nov  2 11:06:49 brouette kernel: usb usb5: SerialNumber: 0000:00:1d.3
Nov  2 11:06:49 brouette kernel: usb usb5: configuration #1 chosen from 1 choice
Nov  2 11:06:49 brouette kernel: hub 5-0:1.0: USB hub found
Nov  2 11:06:49 brouette kernel: hub 5-0:1.0: 2 ports detected
Nov  2 11:06:49 brouette kernel: usb 2-1: new full speed USB device using uhci_hcd and address 2
Nov  2 11:06:49 brouette kernel: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Nov  2 11:06:49 brouette kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov  2 11:06:49 brouette kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov  2 11:06:49 brouette kernel: mice: PS/2 mouse device common for all mice
Nov  2 11:06:49 brouette kernel: EDAC MC: Ver: 2.0.1 Nov  2 2006
Nov  2 11:06:49 brouette kernel: Advanced Linux Sound Architecture Driver Version 1.0.13 (Sun Oct 22 08:56:16 2006 UTC).
Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 21
Nov  2 11:06:49 brouette kernel: kobject_add failed for card0 with -EEXIST, don't try to register things with the same name in the same directory.
Nov  2 11:06:49 brouette kernel:  [<c02b810e>] kobject_add+0x114/0x192
Nov  2 11:06:49 brouette kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Nov  2 11:06:49 brouette kernel:  [<c02bb516>] vsnprintf+0x2ef/0x5f8
Nov  2 11:06:49 brouette kernel:  [<c03131a8>] device_add+0x99/0x446
Nov  2 11:06:49 brouette kernel:  [<c03135e0>] device_create+0x7b/0x9c
Nov  2 11:06:49 brouette kernel:  [<c037bc6d>] snd_card_register+0x36/0x2f6
Nov  2 11:06:49 brouette kernel:  [<c03807f7>] snd_hwdep_new+0x8d/0xc3
Nov  2 11:06:49 brouette kernel: usb 2-1: new device found, idVendor=056d, idProduct=0002
Nov  2 11:06:49 brouette kernel: usb 2-1: new device strings: Mfr=4, Product=14, SerialNumber=0
Nov  2 11:06:49 brouette kernel: usb 2-1: Product: EIZO USB HID Monitor
Nov  2 11:06:49 brouette kernel: usb 2-1: Manufacturer: EIZO
Nov  2 11:06:49 brouette kernel: usb 2-1: configuration #1 chosen from 1 choice
Nov  2 11:06:49 brouette kernel:  [<c03c0c0f>] snd_emux_init_hwdep+0x8f/0x9f
Nov  2 11:06:49 brouette kernel:  [<c03be44d>] snd_emu10k1_sample_new+0x0/0x1a3
Nov  2 11:06:49 brouette kernel:  [<c03be990>] snd_emux_register+0xda/0x11e
Nov  2 11:06:49 brouette kernel:  [<c03be800>] sf_sample_new+0x0/0x1f
Nov  2 11:06:49 brouette kernel:  [<c03be81f>] sf_sample_free+0x0/0x8
Nov  2 11:06:49 brouette kernel:  [<c03bda90>] snd_emu10k1_synth_new_device+0xdc/0x14c
Nov  2 11:06:49 brouette kernel:  [<c03a098d>] init_device+0x28/0x8e
Nov  2 11:06:49 brouette kernel:  [<c03a0ad7>] find_driver+0x6f/0x115
Nov  2 11:06:49 brouette kernel:  [<c0418040>] mutex_lock+0xb/0x1c
Nov  2 11:06:49 brouette kernel:  [<c03a1050>] snd_seq_device_register_driver+0x9b/0x11b
Nov  2 11:06:49 brouette kernel:  [<c01004b1>] init+0x10d/0x306
Nov  2 11:06:49 brouette kernel:  [<c0102b96>] ret_from_fork+0x6/0x1c
Nov  2 11:06:49 brouette kernel:  [<c01003a4>] init+0x0/0x306
Nov  2 11:06:49 brouette kernel:  [<c01003a4>] init+0x0/0x306
Nov  2 11:06:49 brouette kernel:  [<c010389b>] kernel_thread_helper+0x7/0x1c
Nov  2 11:06:49 brouette kernel:  =======================
Nov  2 11:06:49 brouette kernel: ALSA device list:
Nov  2 11:06:49 brouette kernel:   #0: SB Live [Unknown] (rev.10, serial:0x80671102) at 0xdf20, irq 21
Nov  2 11:06:49 brouette kernel: TCP cubic registered
Nov  2 11:06:49 brouette kernel: NET: Registered protocol family 1
Nov  2 11:06:49 brouette kernel: NET: Registered protocol family 17
Nov  2 11:06:49 brouette kernel: Using IPI Shortcut mode
Nov  2 11:06:49 brouette kernel: logips2pp: Detected unknown logitech mouse model 63
Nov  2 11:06:49 brouette kernel: Time: tsc clocksource has been installed.
Nov  2 11:06:49 brouette kernel: input: ImExPS/2 Logitech Explorer Mouse as /class/input/input1
Nov  2 11:06:49 brouette kernel: kjournald starting.  Commit interval 5 seconds
Nov  2 11:06:49 brouette kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov  2 11:06:49 brouette kernel: VFS: Mounted root (ext3 filesystem) readonly.
Nov  2 11:06:49 brouette kernel: Freeing unused kernel memory: 212k freed
Nov  2 11:06:49 brouette kernel: parport: PnPBIOS parport detected.
Nov  2 11:06:49 brouette kernel: parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Nov  2 11:06:49 brouette kernel: Adding 2048248k swap on /dev/sdb10.  Priority:-1 extents:1 across:2048248k
Nov  2 11:06:49 brouette kernel: EXT3 FS on sdb2, internal journal
Nov  2 11:06:49 brouette kernel: ReiserFS: sdb5: found reiserfs format "3.6" with standard journal
Nov  2 11:06:49 brouette kernel: ReiserFS: sdb5: using ordered data mode
Nov  2 11:06:49 brouette kernel: ReiserFS: sdb5: journal params: device sdb5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Nov  2 11:06:49 brouette kernel: ReiserFS: sdb5: checking transaction log (sdb5)
Nov  2 11:06:49 brouette kernel: ReiserFS: sdb5: Using r5 hash to sort names
Nov  2 11:06:49 brouette kernel: ReiserFS: sdb6: found reiserfs format "3.6" with standard journal
Nov  2 11:06:49 brouette kernel: ReiserFS: sdb6: using ordered data mode
Nov  2 11:06:49 brouette kernel: ReiserFS: sdb6: journal params: device sdb6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Nov  2 11:06:49 brouette kernel: ReiserFS: sdb6: checking transaction log (sdb6)
Nov  2 11:06:49 brouette kernel: ReiserFS: sdb6: Using r5 hash to sort names
Nov  2 11:06:49 brouette kernel: XFS mounting filesystem sdb9
Nov  2 11:06:49 brouette kernel: Ending clean XFS mount for filesystem: sdb9
Nov  2 11:06:49 brouette kernel: reiser4: sdb11: found disk format 4.0.0.
Nov  2 11:06:49 brouette kernel: reiser4: sdb7: found disk format 4.0.0.
Nov  2 11:06:49 brouette kernel: XFS mounting filesystem sda5
Nov  2 11:06:49 brouette kernel: Ending clean XFS mount for filesystem: sda5
Nov  2 11:06:49 brouette kernel: reiser4: sda7: found disk format 4.0.0.
Nov  2 11:06:49 brouette kernel: e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Nov  2 11:06:49 brouette kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Nov  2 11:06:49 brouette kernel: ip_conntrack version 2.4 (8192 buckets, 65536 max) - 228 bytes per conntrack
Nov  2 11:06:52 brouette kernel: lp0: using parport0 (interrupt-driven).

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller Hub (rev 02)
	Subsystem: Dell Unknown device 0157
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] Vendor Specific Information
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP+ GART64- 64bit- FW- Rate=x8

00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fd000000-feafffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 0157
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 19
	Region 4: I/O ports at ff80 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 0157
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 20
	Region 4: I/O ports at ff60 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 0157
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 17
	Region 4: I/O ports at ff40 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 0157
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 19
	Region 4: I/O ports at ff20 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Dell Unknown device 0157
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 18
	Region 0: Memory at ffa80800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fcf00000-fcffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Dell Unknown device 0157
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374 [size=1]
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Dell Unknown device 0157
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at fe00 [size=8]
	Region 1: I/O ports at fe10 [size=4]
	Region 2: I/O ports at fe20 [size=8]
	Region 3: I/O ports at fe30 [size=4]
	Region 4: I/O ports at fea0 [size=16]

00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
	Subsystem: Dell Unknown device 0157
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 3
	Region 4: I/O ports at efe0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation Unknown device 01b9
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	[virtual] Expansion ROM at fea00000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8

02:00.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
	Subsystem: Creative Labs SBLive! 5.1 eMicro 28028
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at df20 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.1 Input device controller: Creative Labs SB Live! Game Port (rev 0a)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at df18 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: Intel Corporation 82562EZ 10/100 Ethernet Controller (rev 02)
	Subsystem: Dell Unknown device 0157
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at df40 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


--oyUTqETQ0mS9luUI--
