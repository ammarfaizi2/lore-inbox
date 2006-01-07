Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbWAGPFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWAGPFp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 10:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWAGPFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 10:05:45 -0500
Received: from tornado.reub.net ([202.89.145.182]:39048 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030471AbWAGPFo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 10:05:44 -0500
Message-ID: <43BFD8C1.9030404@reub.net>
Date: Sun, 08 Jan 2006 04:05:37 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060106)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org>
In-Reply-To: <20060107052221.61d0b600.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/01/2006 2:22 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm2/
> 
> This should be somewhat less buggy than 2.6.15-mm1.
> 
> 
> Changes since 2.6.15-mm1:
> 
>  linus.patch
>  git-acpi.patch
>  git-agpgart.patch
>  git-arm.patch
>  git-blktrace.patch
>  git-block.patch
>  git-cfq.patch
>  git-cifs.patch
>  git-drm.patch
>  git-audit.patch
>  git-infiniband.patch
>  git-input.patch
>  git-libata-all.patch
>  git-mmc.patch
>  git-netdev-all.patch
>  git-ntfs.patch
>  git-ocfs2.patch
>  git-powerpc.patch
>  git-serial.patch
>  git-sym2.patch
>  git-sas-jg.patch
>  git-watchdog.patch
>  git-xfs.patch
>  git-cryptodev.patch

Seeing multiple problems with this release...

1.  Nasty oops when rebooting into -mm2.  Then I rebooted back into -mm1 and it 
happened again - so I cold booted this time and the problem went away.

Linux version 2.6.15-mm2 (root@tornado.reub.net) (gcc version 4.1.0 20051222 
(Red Hat 4.1.0-0.12)) #1 SMP Sun Jan 8 02:58:06 NZDT 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fe2f800 (usable)
  BIOS-e820: 000000003fe2f800 - 000000003fe3f8e3 (ACPI NVS)
  BIOS-e820: 000000003ff2f800 - 000000003ff30000 (ACPI NVS)
  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
  BIOS-e820: 00000000fed13000 - 00000000fed1a000 (reserved)
  BIOS-e820: 00000000fed1c000 - 00000000feda0000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Detected 2800.349 MHz processor.
Built 1 zonelists
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Kernel command line: ro root=/dev/md0 panic=60 console=ttyS0,57600
CPU 0 irqstacks, hard=c0423000 soft=c0421000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033452k/1046716k available (2238k kernel code, 12600k reserved, 739k 
data, 200k init, 129212k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5607.23 BogoMIPS (lpj=11214461)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c0424000 soft=c0422000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5600.64 BogoMIPS (lpj=11201280)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Total of 2 processors activated (11207.87 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=74
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
ACPI: Subsystem revision 20051216
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Power Resource [URP2] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: ffa00000-ffafffff
   PREFETCH window: fdf00000-fdffffff
PCI: Bridge: 0000:00:1c.0
   IO window: disabled.
   MEM window: ff600000-ff6fffff
   PREFETCH window: fdb00000-fdbfffff
PCI: Bridge: 0000:00:1c.1
   IO window: a000-afff
   MEM window: ff700000-ff7fffff
   PREFETCH window: fdc00000-fdcfffff
PCI: Bridge: 0000:00:1c.2
   IO window: disabled.
   MEM window: ff800000-ff8fffff
   PREFETCH window: fdd00000-fddfffff
PCI: Bridge: 0000:00:1c.3
   IO window: disabled.
   MEM window: ff900000-ff9fffff
   PREFETCH window: fde00000-fdefffff
PCI: Bridge: 0000:00:1e.0
   IO window: b000-bfff
   MEM window: ff500000-ff5fffff
   PREFETCH window: fe000000-fe7fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 177
PCI: Enabling device 0000:00:1c.1 (0106 -> 0107)
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered<6>Time: tsc clocksource has been installed.

io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 177
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
assign_interrupt_mode Found MSI capability
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ÿserial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 18 (level, low) -> IRQ 185
0000:06:02.0: ttyS1 at I/O 0xbc00 (irq = 185) is a 16550A
0000:06:02.0: ttyS2 at I/O 0xbc08 (irq = 185) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 177
sky2 Cannot find PowerManagement capability, aborting.
sky2: probe of 0000:04:00.0 failed with error -5
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
QLogic Fibre Channel HBA Driver
ahci: probe of 0000:00:1f.2 failed with error -12
ata1: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x0 irq 0
ata2: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x8 irq 0
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c0234702
*pde = 00000000
Oops: 0000 [#1]
SMP
last sysfs file:
Modules linked in:
CPU:    1
EIP:    0060:[<c0234702>]    Not tainted VLI
EFLAGS: 00010206   (2.6.15-mm2)
EIP is at make_class_name+0x28/0x8d
eax: 00000000   ebx: ffffffff   ecx: ffffffff   edx: c19d9224
esi: 00000009   edi: 00000000   ebp: 00000000   esp: c1921d9c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1921000 task=c1920a70)
Stack: <0>c19d9224 c03a9158 c19d9224 c03a9158 c03a9160 c0234925 c03a90e0 00000000
        <0>00000246 c19d9224 c19d9000 c19d9030 00000002 c02349db c19d90e4 c0253218
        <0>c19d92c0 00000000 00000000 c0276693 00000000 c0279391 c035749f c1961640
Call Trace:
  [<c0234925>] class_device_del+0x9f/0x14d
  [<c02349db>] class_device_unregister+0x8/0x10
  [<c0253218>] scsi_remove_host+0xb8/0xf8
  [<c0276693>] ata_host_remove+0xe/0x18
  [<c0279391>] ata_device_add+0x2d3/0xb99
  [<c02b6fb0>] pci_mmcfg_write+0xd3/0x103
  [<c01eb713>] pci_bus_write_config_byte+0x4e/0x58
  [<c02b67d3>] pcibios_set_master+0x74/0x8c
  [<c027a2e5>] ata_pci_init_one+0x32c/0x38e
  [<c01eb7ea>] pci_bus_read_config_word+0x62/0x6c
  [<c01ef8bd>] pci_get_subsys+0x6c/0xe0
  [<c027e334>] piix_init_one+0x18e/0x33a
  [<c01ef259>] pci_device_probe+0x40/0x5b
  [<c0233ed7>] driver_probe_device+0x35/0x98
  [<c0234038>] __driver_attach+0x8a/0x8c
  [<c02339a7>] bus_for_each_dev+0x39/0x57
  [<c0233e4c>] driver_attach+0x16/0x1a
  [<c0233fae>] __driver_attach+0x0/0x8c
  [<c023365b>] bus_add_driver+0x6f/0x126
  [<c01ef3f1>] __pci_register_driver+0x7d/0xac
  [<c04023e9>] piix_init+0xc/0x1e
  [<c01003c8>] init+0xff/0x324
  [<c01002c9>] init+0x0/0x324
  [<c0100d35>] kernel_thread_helper+0x5/0xb
Code: 89 c8 c3 55 57 56 53 83 ec 04 89 04 24 89 c2 8b 40 48 8b 38 31 ed bb ff ff 
ff ff 89 d9 89 e8 f2 ae f7 d1 49 89 ce 8b 7a 08 89 d9 <f2> ae f7 d1 49 89 ca 8d 
4e 02 8d 04 0a ba d0 00 00 00 e8 22 cf
  <0>Kernel panic - not syncing: Attempted to kill init!
  <0>Rebooting in 60 seconds..0


2. Notice above how the sky2 driver is being bailed out:

ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 177
sky2 Cannot find PowerManagement capability, aborting.
sky2: probe of 0000:04:00.0 failed with error -5

This has happened a number of times in the last few days, and I suspect is 
unrelated to the oops that followed above.

This driver worked fine in 2.6.15-rc5-mm3, and seems to work OK when built as a 
module.  But most of the time (not all the time) it doesn't like being 
statically built in and fails with the above error.  Changes to this driver have 
been fairly small lately so I'm not sure if it's the driver or something else 
like ACPI that is the root cause.

3.  The boot up process with -mm2 was pretty lengthy, I had two periods of time 
when the whole system just came to a crawl, first time was when starting cups, 
and it came back to life and continued booting about 30s later.  Next when 
starting hpijs it didn't come to life at all and I had to reboot.  No output to 
the console for either, unfortunately.

Back on -mm1 for now, box has only got an PCI graphics card and I'm not running 
X, DRM or AGP, so by all accounts -mm1 is OK for me ;-)

config up at the usual place http://www.reub.net/files/kernel/configs/

reuben



