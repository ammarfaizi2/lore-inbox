Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWDFMPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWDFMPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 08:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWDFMPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 08:15:51 -0400
Received: from odin2.bull.net ([129.184.85.11]:32714 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1751098AbWDFMPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 08:15:49 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>,
       "" linux-kernel "" <linux-kernel@vger.kernel.org>
Subject: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
Date: Thu, 6 Apr 2006 14:16:00 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AaQNEE+/n1ctjY7"
Message-Id: <200604061416.00741.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_AaQNEE+/n1ctjY7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

	I always have the same problem since 2.6.16.
A 2.6.16 kernel boot correctly.
The 2.6.16+RT patch doesn't. ( I tried all versions rt1-rt12 without success )
The LSM module is also added ( patch ).

I get symbol resolution error when I try to load my scsi modules in the initrd.

The diff file between the two configs and the console log file are provided.
May somebody help me ? 
I tried a dozen of configs changing some config values without success.

Is it a BUG ?
What CONFIG directive(s) could generate these errors ?

-- 
Serge Noiraud

--Boundary-00=_AaQNEE+/n1ctjY7
Content-Type: text/plain;
  charset="iso-8859-15";
  name="HPworkstationXW8200.DAV07-rt12.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="HPworkstationXW8200.DAV07-rt12.txt"

LILO 22.5.9 boot: 2.6.16rt12
Loading 2.6.16rt12........................................
BIOS data check successful
Linux version 2.6.16-rt12 (root@ibiza.XXXXXXXXXXXXXX.fr) (gcc version 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1 SMP PREEMPT Thu Apr 6 09:11:30 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff5000 (usable)
 BIOS-e820: 000000007fff5000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f9bf0
On node 0 totalpages: 524277
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294901 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v002 COMPAQ                                ) @ 0x000e8a10
ACPI: XSDT (v001 COMPAQ CPQ0063  0x20050602  0x00000000) @ 0x7fff50ec
ACPI: FADT (v003 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0x7fff52ac
ACPI: SSDT (v001 COMPAQ  PROJECT 0x00000001 MSFT 0x0100000e) @ 0x7fff6592
ACPI: MADT (v001 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0x7fff53b8
ACPI: ASF! (v016 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0x7fff5454
ACPI: MCFG (v001 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0x7fff54be
ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0xf808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfec81000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 32, address 0xfec81000, GSI 24-47
ACPI: IOAPIC (id[0x03] address[0xfec81400] gsi_base[48])
IOAPIC[2]: apic_id 3, version 32, address 0xfec81400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Detected 3600.519 MHz processor.
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2.6.16rt12 ro root=806 nousb nofirewire nmi_watchdog=1 console=ttyS0 console=tty1 resume=/dev/sda5
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec81000)
mapped IOAPIC to ffffa000 (fec81400)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 65536 bytes)
Event source pit installed with caps set: 01
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2070672k/2097108k available (2774k kernel code, 26044k reserved, 945k data, 476k init, 1179604k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 7203.37 BogoMIPS (lpj=3601686)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000659d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000659d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000180 0000659d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
Booting processor 1/6 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 7199.35 BogoMIPS (lpj=3599679)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000659d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000659d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000180 0000659d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
Total of 2 processors activated (14402.73 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Event source lapic installed with caps set: 06
checking TSC synchronization across 2 CPUs: passed.
Event source lapic installed with caps set: 06
Brought up 2 CPUs
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 159k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.20 entry at 0xeb11a, last bus=64
PCI: Using MMCONFIG
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 10 11 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region f800-f87f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region fa00-fa3f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:40:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XPA_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XPB_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XPA1.PXA_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XPA1.PXB_._PRT]
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:02.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.0
  IO window: 4000-4fff
  MEM window: fa000000-fa4fffff
  PREFETCH window: 88000000-882fffff
PCI: Bridge: 0000:01:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: 4000-4fff
  MEM window: fa000000-fa5fffff
  PREFETCH window: 88000000-882fffff
PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:40:00.0
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: f8000000-f9ffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: fa600000-fa6fffff
  PREFETCH window: 88300000-883fffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
PCI: Setting latency timer of device 0000:01:00.2 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
apm: BIOS not found.
Initializing RT-Tester: OK
No per-cpu room for modules.
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie01]
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:03.0 to 64
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie01]
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:04.0 to 64
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie01]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x54e0-0x54e7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x54e8-0x54ef, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: PHILIPS DVD8631, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(44)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 32768 (order: 9, 2490368 bytes)
TCP bind hash table entries: 32768 (order: 9, 2359296 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
Testing NMI watchdog ... OK.
Using IPI Shortcut mode
RAMDISK: Compressed image found at block 0
Time: tsc clocksource has been installed.
hrtimers: Switched to high resolution mode CPU 1
hrtimers: Switched to high resolution mode CPU 0
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
VFS: Mounted root (ext2 filesystem).
Fusion MPT base driver 3.03.07
Copyright (c) 1999-2005 LSI Logic Corporation
Could not allocate 8 bytes percpu data
mptscsih: Unknown symbol scsi_remove_host
mptscsih: Unknown symbol scsi_host_put
mptscsih: Unknown symbol scsi_print_command
mptscsih: Unknown symbol scsi_adjust_queue_depth
mptspi: Unknown symbol mptscsih_qcmd
mptspi: Unknown symbol mptscsih_bios_param
mptspi: Unknown symbol mptscsih_io_done
mptspi: Unknown symbol mptscsih_slave_configure
mptspi: Unknown symbol mptscsih_taskmgmt_complete
mptspi: Unknown symbol mptscsih_ioc_reset
mptspi: Unknown symbol mptscsih_remove
mptspi: Unknown symbol mptscsih_bus_reset
mptspi: Unknown symbol mptscsih_proc_info
mptspi: Unknown symbol mptscsih_host_reset
mptspi: Unknown symbol mptscsih_TMHandler
mptspi: Unknown symbol mptscsih_timer_expired
mptspi: Unknown symbol mptscsih_scandv_complete
mptspi: Unknown symbol scsi_scan_host
mptspi: Unknown symbol mptscsih_resume
mptspi: Unknown symbol mptscsih_event_process
mptspi: Unknown symbol scsi_add_host
mptspi: Unknown symbol mptscsih_suspend
mptspi: Unknown symbol mptscsih_slave_alloc
mptspi: Unknown symbol mptscsih_slave_destroy
mptspi: Unknown symbol mptscsih_change_queue_depth
mptspi: Unknown symbol mptscsih_target_alloc
mptspi: Unknown symbol mptscsih_shutdown
mptspi: Unknown symbol mptscsih_target_destroy
mptspi: Unknown symbol mptscsih_dev_reset
mptspi: Unknown symbol mptscsih_info
mptspi: Unknown symbol mptscsih_abort
mptspi: Unknown symbol scsi_host_alloc
sd_mod: Unknown symbol scsi_print_sense_hdr
sd_mod: Unknown symbol scsi_mode_sense
sd_mod: Unknown symbol scsi_device_get
sd_mod: Unknown symbol scsi_get_sense_info_fld
sd_mod: Unknown symbol scsicam_bios_param
sd_mod: Unknown symbol scsi_command_normalize_sense
sd_mod: Unknown symbol scsi_test_unit_ready
sd_mod: Unknown symbol scsi_block_when_processing_errors
sd_mod: Unknown symbol scsi_register_driver
sd_mod: Unknown symbol scsi_ioctl
sd_mod: Unknown symbol scsi_nonblockable_ioctl
sd_mod: Unknown symbol scsi_device_put
sd_mod: Unknown symbol scsi_execute_req
sd_mod: Unknown symbol scsi_print_sense
sd_mod: Unknown symbol scsi_io_completion
sd_mod: Unknown symbol scsi_set_medium_removal
*****************************************************************************
*                                                                           *
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_DEBUG_RT_MUTEXES                                             *
*        CONFIG_DEBUG_PREEMPT                                               *
*        CONFIG_CRITICAL_PREEMPT_TIMING                                     *
*        CONFIG_CRITICAL_IRQSOFF_TIMING                                     *
*        CONFIG_LATENCY_TRACE                                               *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 476k freed
Kernel panic - not syncing: No init found.  Try passing init= option to kernel.
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c01045e3>] dump_stack+0x23/0x30 (20)
 [<c01249c6>] panic+0x66/0x130 (28)
 [<c0100591>] init+0x231/0x350 (24)
 [<c0101545>] kernel_thread_helper+0x5/0x10 (1038262300)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0124978>] .... panic+0x18/0x130
.....[<c0100591>] ..   ( <= init+0x231/0x350)

------------------------------
| showing all locks held by: |  (swapper/1 [c21d3780, 118]):
------------------------------

 

--Boundary-00=_AaQNEE+/n1ctjY7
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="diff-mainline-RT"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff-mainline-RT"

--- config-2.6.16	2006-04-05 10:14:33.000000000 +0200
+++ config-2.6.16-rt12	2006-04-06 09:14:00.000000000 +0200
@@ -1,9 +1,10 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16
-# Wed Apr  5 09:32:05 2006
+# Linux kernel version: 2.6.16-rt12
+# Thu Apr  6 08:45:42 2006
 #
 CONFIG_X86_32=y
+CONFIG_GENERIC_TIME=y
 CONFIG_SEMAPHORE_SLEEPERS=y
 CONFIG_X86=y
 CONFIG_MMU=y
@@ -40,13 +41,14 @@
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_ALL is not set
+CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
+CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
@@ -127,7 +129,7 @@
 CONFIG_X86_CMPXCHG=y
 CONFIG_X86_XADD=y
 CONFIG_X86_L1_CACHE_SHIFT=5
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_X86_PPRO_FENCE=y
 CONFIG_X86_WP_WORKS_OK=y
@@ -140,13 +142,23 @@
 CONFIG_X86_TSC=y
 CONFIG_HPET_TIMER=y
 CONFIG_HPET_EMULATE_RTC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_HIGH_RES_RESOLUTION=1000
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 # CONFIG_SCHED_SMT is not set
 # CONFIG_PREEMPT_NONE is not set
 # CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT_DESKTOP is not set
+CONFIG_PREEMPT_RT=y
 CONFIG_PREEMPT=y
+CONFIG_PREEMPT_SOFTIRQS=y
+CONFIG_PREEMPT_HARDIRQS=y
 CONFIG_PREEMPT_BKL=y
+# CONFIG_CLASSIC_RCU is not set
+CONFIG_PREEMPT_RCU=y
+CONFIG_RCU_STATS=y
+CONFIG_ASM_SEMAPHORES=y
 CONFIG_X86_LOCAL_APIC=y
 CONFIG_X86_IO_APIC=y
 CONFIG_X86_MCE=y
@@ -190,7 +202,6 @@
 CONFIG_MTRR=y
 # CONFIG_EFI is not set
 # CONFIG_IRQBALANCE is not set
-# CONFIG_REGPARM is not set
 CONFIG_SECCOMP=y
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_250 is not set
@@ -989,6 +944,9 @@
 # CONFIG_HW_RANDOM is not set
 CONFIG_NVRAM=m
 CONFIG_RTC=y
+CONFIG_RTC_HISTOGRAM=y
+CONFIG_BLOCKER=m
+# CONFIG_LPPTEST is not set
 CONFIG_DTLK=m
 CONFIG_R3964=m
 CONFIG_APPLICOM=m
@@ -1373,22 +1331,39 @@
 # Instrumentation Support
 #
 # CONFIG_PROFILING is not set
+CONFIG_PROFILE_NMI=y
 # CONFIG_KPROBES is not set
 
 #
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_PRINTK_IGNORE_LOGLEVEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=17
+# CONFIG_PARANOID_GENERIC_TIME is not set
 CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHEDSTATS=y
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_DEBUG_PREEMPT=y
-# CONFIG_DEBUG_MUTEXES is not set
-# CONFIG_DEBUG_SPINLOCK is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_PI_LIST=y
+CONFIG_RT_MUTEX_TESTER=y
+CONFIG_WAKEUP_TIMING=y
+CONFIG_WAKEUP_LATENCY_HIST=y
+CONFIG_PREEMPT_TRACE=y
+CONFIG_CRITICAL_PREEMPT_TIMING=y
+CONFIG_PREEMPT_OFF_HIST=y
+CONFIG_CRITICAL_IRQSOFF_TIMING=y
+CONFIG_INTERRUPT_OFF_HIST=y
+CONFIG_CRITICAL_TIMING=y
+CONFIG_DEBUG_TRACE_IRQFLAGS=y
+CONFIG_LATENCY_TIMING=y
+CONFIG_CRITICAL_LATENCY_HIST=y
+CONFIG_LATENCY_HIST=y
+CONFIG_LATENCY_TRACE=y
+CONFIG_MCOUNT=y
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_HIGHMEM is not set
 CONFIG_DEBUG_BUGVERBOSE=y
@@ -1415,6 +1392,7 @@
 # CONFIG_SECURITY_NETWORK is not set
 # CONFIG_SECURITY_CAPABILITIES is not set
 # CONFIG_SECURITY_SECLVL is not set
+CONFIG_SECURITY_REALTIME=m
 
 #
 # Cryptographic options
@@ -1460,6 +1438,7 @@
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
+CONFIG_PLIST=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_GENERIC_PENDING_IRQ=y

--Boundary-00=_AaQNEE+/n1ctjY7--
