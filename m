Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbUANKD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 05:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbUANKDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 05:03:55 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:2477 "EHLO
	mail-4.tiscali.it") by vger.kernel.org with ESMTP id S265439AbUANKDm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 05:03:42 -0500
Date: Wed, 14 Jan 2004 11:03:38 +0100
Message-ID: <3FE5F1110002B70F@mail-4.tiscali.it>
In-Reply-To: <20040113131806.GA343@elf.ucw.cz>
From: m.andreolini@tiscali.it
Subject: Re: problems with suspend-to-disk (ACPI), 2.6.1-rc2
To: "Pavel Machek" <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SiS900 driver needs to be fixed. Or perhaps... try following patch.


Hi Pavel,

thanks for your prompt response. I applied your patch to my 2.6.1-rc2 and
the bash
still gets killed during the resume. Here is the output of dmesg:

Linux version 2.6.1-rc2 (andreoli@enea) (gcc version 3.2.3 20030422 (Gentoo
Linux 1.4 3.2.3-r3, propolice)) #1 Tue Jan 13 21:38:14 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002bfea000 (usable)
 BIOS-e820: 000000002bfea000 - 000000002bfef000 (ACPI data)
 BIOS-e820: 000000002bfef000 - 000000002bfff000 (reserved)
 BIOS-e820: 000000002bfff000 - 000000002c000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
703MB LOWMEM available.
On node 0 totalpages: 180202
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 176106 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6e10
ACPI: RSDT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x2bfea000
ACPI: FADT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x2bfea080
ACPI: BOOT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x2bfea040
ACPI: DSDT (v001   ASUS L3000D   0x00001000 MSFT 0x0100000e) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hda7
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1674.442 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 710120k/720808k available (1759k kernel code, 9916k reserved, 657k
data, 120k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 3309.56 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP-M 2000+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1050, last bus=1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS962 that hid as a SIS503 (compatible=0)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FN0] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
udf: registering filesystem
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R2312, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda7, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda7) for (hda7)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 120k freed
Adding 987956k swap on /dev/hda6.  Priority:-1 extents:1
sis900.c: v1.08.07 11/02/2003
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xa000, IRQ 11, 00:0c:6e:35:69:ed.
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (61 C)
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Real Time Clock Driver v1.12
eth0: Media Link On 100mbps full-duplex 
intel8x0: clocking to 48000
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Stopping tasks: =====================|
Freeing memory: ..................................|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: completing PM request, suspend
resume= option should be used to set suspend device/critical section: Counting
pages to copy[nosave c035a000] (pages needed: 5318+512=5830 free: 174883)
Alloc pagedir
[nosave c035a000]<4>Freeing prev allocated pagedir
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000000 03008000 
bad: scheduling while atomic!
Call Trace:
 [<c0119cf6>] schedule+0x586/0x590
 [<c0124f3c>] __mod_timer+0xfc/0x170
 [<c0125a93>] schedule_timeout+0x63/0xc0
 [<c0125a20>] process_timeout+0x0/0x10
 [<c01da0bb>] pci_set_power_state+0xeb/0x190
 [<ec947823>] sis900_resume+0x63/0x130 [sis900]
 [<c01dc616>] pci_device_resume+0x26/0x30
 [<c021e6d9>] resume_device+0x29/0x30
 [<c021e714>] dpm_resume+0x34/0x60
 [<c021e759>] device_resume+0x19/0x30
 [<c0136524>] do_magic_resume_2+0x74/0xf0
 [<c0264cbf>] do_magic+0x11f/0x130
 [<c01367a6>] software_suspend+0xa6/0xc0
 [<c01f5fe3>] acpi_system_write_sleep+0xab/0xc9
 [<c015437e>] vfs_write+0xbe/0x130
 [<c01544a2>] sys_write+0x42/0x70
 [<c010949b>] syscall_call+0x7/0xb

hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue ebd77a00, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Fixing swap signatures... <3>bad: scheduling while atomic!
Call Trace:
 [<c0119cf6>] schedule+0x586/0x590
 [<c023418d>] do_ide_request+0x1d/0x30
 [<c0220917>] generic_unplug_device+0x77/0x80
 [<c0220abb>] blk_run_queues+0xab/0xc0
 [<c011ac3e>] io_schedule+0xe/0x20
 [<c0138391>] wait_on_page_bit+0xb1/0xe0
 [<c011b470>] autoremove_wake_function+0x0/0x50
 [<c011b470>] autoremove_wake_function+0x0/0x50
 [<c014f08b>] swap_readpage+0x5b/0x90
 [<c014f181>] rw_swap_page_sync+0xc1/0x100
 [<c013594c>] mark_swapfiles+0x7c/0x1b0
 [<c0136559>] do_magic_resume_2+0xa9/0xf0
 [<c0264cbf>] do_magic+0x11f/0x130
 [<c01367a6>] software_suspend+0xa6/0xc0
 [<c01f5fe3>] acpi_system_write_sleep+0xab/0xc9
 [<c015437e>] vfs_write+0xbe/0x130
 [<c01544a2>] sys_write+0x42/0x70
 [<c010949b>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0119cf6>] schedule+0x586/0x590
 [<c0221f9e>] generic_make_request+0x16e/0x1f0
 [<c011ac3e>] io_schedule+0xe/0x20
 [<c0138391>] wait_on_page_bit+0xb1/0xe0
 [<c011b470>] autoremove_wake_function+0x0/0x50
 [<c011b470>] autoremove_wake_function+0x0/0x50
 [<c014eff9>] swap_writepage+0x99/0xd0
 [<c014f181>] rw_swap_page_sync+0xc1/0x100
 [<c01359bf>] mark_swapfiles+0xef/0x1b0
 [<c0136559>] do_magic_resume_2+0xa9/0xf0
 [<c0264cbf>] do_magic+0x11f/0x130
 [<c01367a6>] software_suspend+0xa6/0xc0
 [<c01f5fe3>] acpi_system_write_sleep+0xab/0xc9
 [<c015437e>] vfs_write+0xbe/0x130
 [<c01544a2>] sys_write+0x42/0x70
 [<c010949b>] syscall_call+0x7/0xb

ok
Restarting tasks...<3>bad: scheduling while atomic!
Call Trace:
 [<c0119cf6>] schedule+0x586/0x590
 [<c0118ede>] try_to_wake_up+0x9e/0x160
 [<c0118fbe>] wake_up_process+0x1e/0x20
 [<c01353c8>] thaw_processes+0xb8/0x100
 [<c0136798>] software_suspend+0x98/0xc0
 [<c01f5fe3>] acpi_system_write_sleep+0xab/0xc9
 [<c015437e>] vfs_write+0xbe/0x130
 [<c01544a2>] sys_write+0x42/0x70
 [<c010949b>] syscall_call+0x7/0xb

 done
bad: scheduling while atomic!
Call Trace:
 [<c0119cf6>] schedule+0x586/0x590
 [<c01544a2>] sys_write+0x42/0x70
 [<c01094c2>] work_resched+0x5/0x16

bad: scheduling while atomic!
Call Trace:
 [<c0119cf6>] schedule+0x586/0x590
 [<c01187b6>] fixup_exception+0x16/0x40
 [<c0117b6e>] __is_prefetch+0x6e/0x220
 [<c0117e30>] do_page_fault+0x110/0x512
 [<c011dcfd>] printk+0x11d/0x180
 [<c011aba7>] sys_sched_yield+0x87/0xd0
 [<c01608b8>] coredump_wait+0x38/0xa0
 [<c0160a0b>] do_coredump+0xeb/0x1ec
 [<c0118fda>] wake_up_state+0x1a/0x20
 [<c0126de4>] specific_send_sig_info+0xc4/0x130
 [<c01267f8>] __dequeue_signal+0xe8/0x190
 [<c01268d5>] dequeue_signal+0x35/0xa0
 [<c0128daa>] get_signal_to_deliver+0x20a/0x380
 [<c0109272>] do_signal+0xe2/0x120
 [<c0118d30>] recalc_task_prio+0x90/0x1a0
 [<c0119aa4>] schedule+0x334/0x590
 [<c0117d20>] do_page_fault+0x0/0x512
 [<c0109309>] do_notify_resume+0x59/0x5c
 [<c01094e6>] work_notifysig+0x13/0x15

note: bash[3649] exited with preempt_count 1
eth0: Media Link On 100mbps full-duplex 
 
Bye
Mauro Andreolini

__________________________________________________________________
Tiscali ADSL SENZA CANONE:
Attivazione GRATIS, contributo adesione GRATIS, modem GRATIS,
50 ore di navigazione GRATIS.  ABBONARTI TI COSTA SOLO UN CLICK!
http://point.tiscali.it/adsl/index.shtml



