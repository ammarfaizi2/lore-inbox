Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVBAAxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVBAAxU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVBAAvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:51:17 -0500
Received: from mail.aei.ca ([206.123.6.14]:60365 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261499AbVBAAnp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:43:45 -0500
From: Ed Tomlinson <tomlins@cam.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc1-mm2
Date: Mon, 31 Jan 2005 19:34:15 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, mikpe@csd.uu.se
References: <20050119213818.55b14bb0.akpm@osdl.org>
In-Reply-To: <20050119213818.55b14bb0.akpm@osdl.org>
Organization: me
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501311934.16057.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 January 2005 00:38, Andrew Morton wrote:
> - This kernel isn't particularly well-tested, sorry.  I've been a bit tied
>   up with other stuff.

I recently switched my main box to a x86_64 box and installed the unofficial
debian 'true64' port on it.  I have been running 11-rc2 (with the aa oom patches)
with no real problems.  I decided to try 11-rc2-mm2. 

The first time (with a serial console active) it ended with a panic.  When I enabled
a serial console it stalled.  I used alt+sysrq+T and then rebooted.  Here is the 
log.  There are no extra patches on top of mm2.  I compiled using gcc 3.4, with
a .config based on 11-rc2 using oldconfig.

Ed Tomlinson

Bootdata ok (command line is root=/dev/hda3 ro console=tty0 console=ttyS0,38400)
Linux version 2.6.11-rc2-mm2 (ed@grover) (gcc version 3.4.4 20041218 (prerelease) (Debian 3.4.3-7)) #1 Sun Jan 30 09:18:40 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000fefffc00 - 00000000ff000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Nvidia board detected. Ignoring ACPI timer override.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ e0000000 size 128 MB
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda3 ro console=tty0 console=ttyS0,38400
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1808.838 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 510272k/524224k available (2163k kernel code, 13180k reserved, 1393k data, 140k init)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 2800+ stepping 0a
Using local APIC NMI watchdog using perfctr0
Using local APIC timer interrupts.
Detected 12.561 MHz APIC timer.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050125
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Link [LNK1] (IRQs<7>Losing some ticks... checking if CPU frequency changed.
 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 128M @ 0xe0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
inotify device minor=63
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
input: AT Translated Set 2 keyboard on isa0060/serio0
Linux telephony interface: v1.00
$Id: ixj.c,v 4.7 2001/08/13 06:19:33 craigs Exp $
Please email the following PERFCTR INIT lines to mikpe@csd.uu.se
To remove this message, rebuild the driver with CONFIG_PERFCTR_INIT_TESTS=n
PERFCTR INIT: vendor 2, family 15, model 4, stepping 10, clock 1808838 kHz
PERFCTR INIT: NITER == 64
PERFCTR INIT: loop overhead is 242 cycles
PERFCTR INIT: rdtsc cost is 9.3 cycles (839 total)
PERFCTR INIT: rdpmc cost is 10.0 cycles (882 total)
PERFCTR INIT: rdmsr (counter) cost is 51.0 cycles (3506 total)
PERFCTR INIT: rdmsr (evntsel) cost is 57.1 cycles (3902 total)
PERFCTR INIT: wrmsr (counter) cost is 71.9 cycles (4849 total)
PERFCTR INIT: wrmsr (evntsel) cost is 328.7 cycles (21285 total)
PERFCTR INIT: read cr4 cost is 6.0 cycles (626 total)
PERFCTR INIT: write cr4 cost is 67.0 cycles (4535 total)
PERFCTR INIT: write LVTPC cost is 22.5 cycles (1686 total)
PERFCTR INIT: sync_core cost is 164.5 cycles (10775 total)
perfctr: driver 2.7.9, cpu type AMD K7/K8 at 1808838 kHz
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices: 
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1 
ACPI: (supports S0 S1 S4 S5)
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 140k freed
INIT: version 2.86 booting
NET: Registered protocol family 1
kobject_register failed for unix (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8015811d>{blockable_page_cache_readahead+109} 
       <ffffffff80151de0>{file_read_actor+0} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8017c127>{do_lookup+55} <ffffffff8017cfc9>{link_path_walk+2953} 
       <ffffffff801fdb46>{prio_tree_insert+406} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
kobject_register failed for unix (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8015811d>{blockable_page_cache_readahead+109} 
       <ffffffff80151de0>{file_read_actor+0} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8017c127>{do_lookup+55} <ffffffff8017cfc9>{link_path_walk+2953} 
       <ffffffff801fdb46>{prio_tree_insert+406} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
kobject_register failed for unix (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8015811d>{blockable_page_cache_readahead+109} 
       <ffffffff80151de0>{file_read_actor+0} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8017c127>{do_lookup+55} <ffffffff8017cfc9>{link_path_walk+2953} 
       <ffffffff801fdb46>{prio_tree_insert+406} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
kobject_register failed for unix (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8015811d>{blockable_page_cache_readahead+109} 
       <ffffffff80151de0>{file_read_actor+0} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fdb46>{prio_tree_insert+406} 
       <ffffffff8015cf18>{vma_prio_tree_insert+40} <ffffffff8016259c>{vma_link+172} 
       <ffffffff80163d28>{do_mmap_pgoff+1720} <ffffffff80113f5f>{sys_mmap+191} 
       <ffffffff8010e22a>{system_call+126} 
kobject_register failed for unix (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8015811d>{blockable_page_cache_readahead+109} 
       <ffffffff80151de0>{file_read_actor+0} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8017c127>{do_lookup+55} <ffffffff8017cfc9>{link_path_walk+2953} 
       <ffffffff801fdb46>{prio_tree_insert+406} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
Setting disc parameters: done.
Activating swap.
Adding 979956k swap on /dev/hda2.  Priority:-1 extents:1
Checking root file system...
fsck 1.36-rc5 (27-Jan-2005)
Reiserfs super block in block 16 on 0x303 of format 3.6 with standard journal
Blocks (total/free): 2196880/1332899 by 4096 bytes
Filesystem is clean
Filesystem seems mounted read-only. Skipping journal replay.
Checking internal tree..finished
Real Time Clock Driver v1.12
System time was Mon Jan 31 23:28:44 UTC 2005.
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Mon Jan 31 18:28:46 EST 2005.
Cleaning up ifupdown...done.
Calculating module dependencies... done.
Loading modules...
    ide-cd
FATAL: Module ide_cd not found.
    ide-generic
FATAL: Module ide_generic not found.
    sbp2
SCSI subsystem initialized
sbp2: Unknown symbol scsi_remove_host
sbp2: Unknown symbol hpsb_get_hostinfo
sbp2: Unknown symbol hpsb_node_write
sbp2: Unknown symbol hpsb_register_addrspace
sbp2: Unknown symbol hpsb_node_fill_packet
sbp2: Unknown symbol hpsb_register_protocol
sbp2: Unknown symbol _csr1212_read_keyval
sbp2: Unknown symbol hpsb_make_writepacket
sbp2: Unknown symbol hpsb_speedto_str
sbp2: Unknown symbol scsi_host_put
sbp2: Unknown symbol hpsb_send_packet
sbp2: Unknown symbol hpsb_unregister_protocol
sbp2: Unknown symbol hpsb_free_packet
sbp2: Unknown symbol scsi_add_host
sbp2: Unknown symbol ieee1394_bus_type
sbp2: Unknown symbol hpsb_create_hostinfo
sbp2: Unknown symbol hpsb_register_highlevel
sbp2: Unknown symbol hpsb_free_tlabel
sbp2: Unknown symbol hpsb_unregister_highlevel
sbp2: Unknown symbol scsi_unblock_requests
sbp2: Unknown symbol __scsi_print_command
sbp2: Unknown symbol scsi_block_requests
sbp2: Unknown symbol scsi_host_alloc
sbp2: Unknown symbol __scsi_add_device
sbp2: Unknown symbol hpsb_set_packet_complete_task
FATAL: Error inserting sbp2 (/likobject_register failed for scsi_mod (-17)
b/modules/2.6.11
Call Trace:-rc2-mm2/kernel/<ffffffff801fcac6>{kobject_register+70}drivers/ieee1394 /sbp2.ko): Unkno<ffffffff8014adc7>{sys_init_module+5559}wn symbol in mod ule, or unknown 
       parameter (see d<ffffffff801bfa09>{reiserfs_dirty_inode+105}mesg)
    sr_mo d
<ffffffff80145430>{autoremove_wake_function+0} 
       <ffffffff80145430>{autoremove_wake_function+0} <ffffffff801d0c98>{do_journal_end+936} 
       <ffffffff801bfa09>{reiserfs_dirty_inode+105} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff8015cf18>{vma_prio_tree_insert+40} <ffffffff8016259c>{vma_link+172} 
       <ffffffff80163d28>{do_mmap_pgoff+1720} <ffffffff80113f5f>{sys_mmap+191} 
       <ffffffff8010e22a>{system_call+126} 
sr_mod: Unknown symbol scsi_mode_sense
sr_mod: Unknown symbol scsi_device_get
sr_mod: Unknown symbol scsi_wait_req
sr_mod: Unknown symbol scsi_test_unit_ready
sr_mod: Unknown symbol scsi_block_when_processing_errors
sr_mod: Unknown symbol scsi_register_driver
sr_mod: Unknown symbol scsi_ioctl
sr_mod: Unknown symbol scsi_nonblockable_ioctl
sr_mod: Unknown symbol scsi_device_put
sr_mod: Unknown symbol scsi_logging_level
sr_mod: Unknown symbol scsi_print_req_sense
sr_mod: Unknown symbol scsi_release_request
sr_mod: Unknown symbol scsi_print_sense
sr_mod: Unknown symbol scsi_allocate_request
sr_mod: Unknown symbol scsi_io_completion
sr_mod: Unknown symbol __scsi_print_command
sr_mod: Unknown symbol scsi_set_medium_removal
FATAL: Error inserting sr_mod (/lib/modules/2.6.11-rc2-mm2/kernel/drivers/scsi/sr_mod.ko): Unknown symbol in module, or unknown parameter (see dmesg)
All modules loaded.
Checking all file systems...
fsck 1.36-rc5 (27-Jan-2005)
/boot: clean, 39/52208 files, 25450/104391 blocks
Reiserfs super block in block 16 on 0x305 of format 3.6 with standard journal
Blocks (total/free): 37551920/24104839 by 4096 bytes
Filesystem is clean
Replaying journal..
Reiserfs journal '/dev/hda5' in blocks [18..8211]: 0 transactions replayed
Checking internal tree..finished
Setting kernel variables ...
... done.
Mounting local filesystems...
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
/dev/hda1 on /boot type ext3 (rw)
/dev/hda5 on /poola type reiserfs (rw)
Cleaning /tmp /var/run /var/lock.
Detecting hardware: ohci1394 ide_scsi
Loading ohci1394 module.
kobject_register failed for ieee1394 (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8019ffa0>{proc_alloc_inode+64} <ffffffff80187660>{alloc_inode+288} 
       <ffffffff80188752>{iget_locked+210} <ffffffff80145588>{wake_up_bit+24} 
       <ffffffff801a0089>{proc_get_inode+121} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
ohci1394: Unknown symbol hpsb_iso_wake
ohci1394: Unknown symbol hpsb_packet_received
ohci1394: Unknown symbol dma_prog_region_free
ohci1394: Unknown symbol hpsb_add_host
ohci1394: Unknown symbol dma_region_sync_for_device
ohci1394: Unknown symbol dma_prog_region_init
ohci1394: Unknown symbol dma_prog_region_alloc
ohci1394: Unknown symbol dma_region_offset_to_bus
ohci1394: Unknown symbol hpsb_alloc_host
ohci1394: Unknown symbol hpsb_selfid_complete
ohci1394: Unknown symbol hpsb_remove_host
ohci1394: Unknown symbol hpsb_iso_packet_received
ohci1394: Unknown symbol hpsb_iso_packet_sent
ohci1394: Unknown symbol hpsb_packet_sent
ohci1394: Unknown symbol dma_region_sync_for_cpu
ohci1394: Unknown symbol hpsb_selfid_received
ohci1394: Unknown symbol hpsb_bus_reset
FATAL: Error inserting ohci1394 (/lib/modules/2.6.11-rc2-mm2/kernel/drivers/ieee1394/ohci1394.ko): Unknown symbol in module, or unknown parametekobject_register failed for scsi_mod (-17)
r (see dmesg)
L
Call Trace:oading ide_scsi <ffffffff801fcac6>{kobject_register+70}module.
 <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8019ffa0>{proc_alloc_inode+64} <ffffffff80187660>{alloc_inode+288} 
       <ffffffff80188752>{iget_locked+210} <ffffffff80145588>{wake_up_bit+24} 
       <ffffffff801a0089>{proc_get_inode+121} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
ide_scsi: Unknown symbol scsi_remove_host
ide_scsi: Unknown symbol scsi_host_put
ide_scsi: Unknown symbol scsi_scan_host
ide_scsi: Unknown symbol scsi_add_host
ide_scsi: Unknown symbol scsi_adjust_queue_depth
ide_scsi: Unknown symbol scsi_host_alloc
FATAL: Error inserting ide_scsi (/lib/modules/2.6.11-rc2-mm2/kernel/drivers/scsi/ide-scsi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
Setting sensors limits:Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and done
'modprobe i2c_sensor'!
For older kernels, make sure you have done 'modprobe i2c-proc'!
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and done
'modprobe i2c_sensor'!
For older kernels, make sure you have done 'modprobe i2c-proc'!
 done.
Running 0dns-down to make sure resolv.conf is ok...done.
/dev/shm/network/...Initializing: /etc/network/ifstate.
Starting hotplug subsystem:
   input   
     evbug: blacklisted
     evdev: loaded successfully
     evbug: blacklisted
kobject_register failed for evdev (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff801869ef>{__d_lookup+127} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
     evdev: loaded successfully
   input    [success]
   isapnp  
   isapnp   [success]
   net     
input.agent[1265]: segfault at 00007fffffffeb00 rip 00007fffffffeb00 rsp 00007fffffffe970 error 15
   net      [success]
   pci     
kobject_register failed for evdev (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff80188d78>{unlock_new_inode+8} <ffffffff80145588>{wake_up_bit+24} 
       <ffffffff801a0089>{proc_get_inode+121} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
i2c_nforce2: Unknown symbol i2c_del_adapter
i2c_nforce2: Unknown symbol i2c_add_adapter
modprobe: FATAL: Error inserting i2c_nforce2 (/lib/modules/2.6.11-rc2-mm2/kernel/drivers/i2c/busses/i2c-nforce2.ko): Unknown symbol in module, or unknown parameter (see dmesg)

     i2c-nforce2: can't be loaded
missing kernel or user mode driver i2c-nforce2 
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 23 (level, high) -> IRQ 23
ohci_hcd 0000:00:02.0: PCI device 10de:00e7 (nVidia Corporation)
ohci_hcd 0000:00:02.0: irq 23, pci mem 0xeb003000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 22 (level, high) -> IRQ 22
ohci_hcd 0000:00:02.1: PCI device 10de:00e7 (nVidia Corporation)
ohci_hcd 0000:00:02.1: irq 22, pci mem 0xeb004000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
     ohci-hcd: loaded successfully
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.0: wakeup
kobject_register failed for ohci_hcd (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8019ffa0>{proc_alloc_inode+64} <ffffffff80187660>{alloc_inode+288} 
       <ffffffff80188752>{iget_locked+210} <ffffffff80145588>{wake_up_bit+24} 
       <ffffffff801a0089>{proc_get_inode+121} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
     ohci-hcd: loaded successfully
ohci_hcd 0000:00:02.0: wakeup
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 21 (level, high) -> IRQ 21
ehci_hcd 0000:00:02.2: PCI device 10de:00e8 (nVidia Corporation)
ehci_hcd 0000:00:02.2: irq 21, pci mem 0xeb005000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
     ehci-hcd: loaded successfully
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.31.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 20 (level, high) -> IRQ 20
hub 3-0:1.0: over-current change on port 1
hub 3-0:1.0: over-current change on port 2
hub 3-0:1.0: over-current change on port 5
hub 3-0:1.0: over-current change on port 6
eth0: forcedeth.c: subsystem: 01462:0300 bound to 0000:00:05.0
     forcedeth: loaded successfully
ohci_hcd 0000:00:02.1: wakeup
snd: Unknown symbol unregister_sound_special
snd: Unknown symbol register_sound_special
snd: Unknown symbol sound_class
modprobe: WARNING: Error inserting snd (snd_timer: Unknown symbol snd_info_register
/lib/modules/2.6snd_timer: Unknown symbol snd_info_create_module_entry
.11-rc2-mm2/kernsnd_timer: Unknown symbol snd_info_free_entry
el/sound/core/snsnd_timer: Unknown symbol snd_iprintf
d.ko): Unknown ssnd_timer: Unknown symbol snd_ecards_limit
ymbol in module,snd_timer: Unknown symbol snd_oss_info_register
 or unknown parasnd_timer: Unknown symbol snd_unregister_device
meter (see dmesgsnd_timer: Unknown symbol snd_device_new
)

snd_timer: Unknown symbol snd_kmalloc_strdup
snd_timer: Unknown symbol snd_info_unregister
snd_timer: Unknown symbol snd_register_device
modprobe: WARNING: Error insertikobject_register failed for snd_page_alloc (-17)
ng snd_timer (/l
Call Trace:ib/modules/2.6.1<ffffffff801fcac6>{kobject_register+70}1-rc2-mm2/kernel /sound/core/snd-<ffffffff8014adc7>{sys_init_module+5559}timer.ko): Unkno wn symbol in mod
       ule, or unknown <ffffffff8019ffa0>{proc_alloc_inode+64}parameter (see d mesg)

<ffffffff80187660>{alloc_inode+288} 
       <ffffffff80188752>{iget_locked+210} <ffffffff80145588>{wake_up_bit+24} 
       <ffffffff801a0089>{proc_get_inode+121} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
kobject_register failed for soundcore (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8019ffa0>{proc_alloc_inode+64} <ffffffff80187660>{alloc_inode+288} 
       <ffffffff80188752>{iget_locked+210} <ffffffff80145588>{wake_up_bit+24} 
       <ffffffff801a0089>{proc_get_inode+121} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
snd: Unknown symbol unregister_sound_special
snd: Unknown symbol register_sound_special
snd: Unknown symbol sound_class
modprobe: WARNINsnd_timer: Unknown symbol snd_info_register
G: Error insertisnd_timer: Unknown symbol snd_info_create_module_entry
ng snd (/lib/modsnd_timer: Unknown symbol snd_info_free_entry
ules/2.6.11-rc2-snd_timer: Unknown symbol snd_iprintf
mm2/kernel/soundsnd_timer: Unknown symbol snd_ecards_limit
/core/snd.ko): Usnd_timer: Unknown symbol snd_oss_info_register
nknown symbol insnd_timer: Unknown symbol snd_unregister_device
 module, or unknsnd_timer: Unknown symbol snd_device_new
own parameter (ssnd_timer: Unknown symbol snd_kmalloc_strdup
ee dmesg)

snd_timer: Unknown symbol snd_info_unregister
snd_timer: Unknown symbol snd_register_device
usb 2-4: new low speed USB device using ohci_hcd and address 3
modprobe: WARNING: Error inserting snd_timer (/lib/modules/2.6.11-rc2-mm2/kernelsnd_pcm: Unknown symbol snd_info_register
/sound/core/snd-snd_pcm: Unknown symbol snd_info_create_module_entry
timer.ko): Unknosnd_pcm: Unknown symbol snd_ctl_unregister_ioctl_compat
wn symbol in modsnd_pcm: Unknown symbol snd_timer_notify
ule, or unknown snd_pcm: Unknown symbol snd_timer_interrupt
parameter (see dsnd_pcm: Unknown symbol snd_info_free_entry
mesg)

snd_pcm: Unknown symbol snd_info_get_str
snd_pcm: Unknown symbol snd_dma_reserve_buf
snd_pcm: Unknown symbol snd_dma_free_pages
snd_pcm: Unknown symbol snd_ctl_register_ioctl
snd_pcm: Unknown symbol snd_card_file_add
snd_pcm: Unknown symbol snd_iprintf
snd_pcm: Unknown symbol snd_major
snd_pcm: Unknown symbol snd_malloc_pages
snd_pcm: Unknown symbol snd_unregister_device
snd_pcm: Unknown symbol snd_timer_new
snd_pcm: Unknown symbol snd_device_new
snd_pcm: Unknown symbol snd_dma_get_reserved_buf
snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
snd_pcm: Unknown symbol snd_ctl_register_ioctl_compat
snd_pcm: Unknown symbol snd_info_create_card_entry
snd_pcm: Unknown symbol snd_power_wait
snd_pcm: Unknown symbol snd_device_free
snd_pcm: Unknown symbol snd_dma_alloc_pages
snd_pcm: Unknown symbol snd_card_file_remove
snd_pcm: Unknown symbol snd_free_pages
snd_pcm: Unknown symbol snd_info_unregister
snd_pcm: Unknown symbol snd_device_register
snd_pcm: Unknown symbol snd_register_device
snd_pcm: Unknown symbol snd_info_get_line
modprobe: FATAL: Error inserting snd_pcm (/lib/modules/2.6.11-rc2-mm2/kernel/sound/core/snd-pcm.snd_ac97_codec: Unknown symbol snd_info_register
ko): Unknown symsnd_ac97_codec: Unknown symbol snd_ctl_add
bol in module, osnd_ac97_codec: Unknown symbol snd_info_free_entry
r unknown paramesnd_ac97_codec: Unknown symbol snd_interval_refine
ter (see dmesg)snd_ac97_codec: Unknown symbol snd_ctl_find_id


modprobe: WAsnd_ac97_codec: Unknown symbol snd_ctl_new1
RNING: Error runsnd_ac97_codec: Unknown symbol snd_ctl_remove_id
ning install comsnd_ac97_codec: Unknown symbol snd_component_add
mand for snd_pcmsnd_ac97_codec: Unknown symbol snd_pcm_hw_rule_add


snd_ac97_codec: Unknown symbol snd_iprintf
snd_ac97_codec: Unknown symbol snd_device_new
snd_ac97_codec: Unknown symbol snd_info_create_card_entry
snd_ac97_codec: Unknown symbol snd_info_unregister
modprobe: WARNING: Error insertikobject_register failed for snd_page_alloc (-17)
ng snd_ac97_code
Call Trace:c (/lib/modules/<ffffffff801fcac6>{kobject_register+70}2.6.11-rc2-mm2/k ernel/sound/pci/<ffffffff8014adc7>{sys_init_module+5559}ac97/snd-ac97-co dec.ko): Unknown
        symbol in modul<ffffffff801bfa09>{reiserfs_dirty_inode+105}e, or unknown pa rameter (see dme<ffffffff80145430>{autoremove_wake_function+0}sg)

 
       <ffffffff80145430>{autoremove_wake_function+0} <ffffffff801d0c98>{do_journal_end+936} 
       <ffffffff801bfa09>{reiserfs_dirty_inode+105} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff8015cf18>{vma_prio_tree_insert+40} <ffffffff8016259c>{vma_link+172} 
       <ffffffff80163d28>{do_mmap_pgoff+1720} <ffffffff80113f5f>{sys_mmap+191} 
       <ffffffff8010e22a>{system_call+126} 
kobject_register failed for soundcore (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff801bfa09>{reiserfs_dirty_inode+105} <ffffffff80145430>{autoremove_wake_function+0} 
       <ffffffff80145430>{autoremove_wake_function+0} <ffffffff801d0c98>{do_journal_end+936} 
       <ffffffff801bfa09>{reiserfs_dirty_inode+105} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff8015cf18>{vma_prio_tree_insert+40} <ffffffff8016259c>{vma_link+172} 
       <ffffffff80163d28>{do_mmap_pgoff+1720} <ffffffff80113f5f>{sys_mmap+191} 
       <ffffffff8010e22a>{system_call+126} 
snd: Unknown symbol unregister_sound_special
snd: Unknown symbol register_sound_special
snd: Unknown symbol sound_class
modprobe: WARNINsnd_timer: Unknown symbol snd_info_register
G: Error insertisnd_timer: Unknown symbol snd_info_create_module_entry
ng snd (/lib/modsnd_timer: Unknown symbol snd_info_free_entry
ules/2.6.11-rc2-snd_timer: Unknown symbol snd_iprintf
mm2/kernel/soundsnd_timer: Unknown symbol snd_ecards_limit
/core/snd.ko): Usnd_timer: Unknown symbol snd_oss_info_register
nknown symbol insnd_timer: Unknown symbol snd_unregister_device
 module, or unknsnd_timer: Unknown symbol snd_device_new
own parameter (ssnd_timer: Unknown symbol snd_kmalloc_strdup
ee dmesg)

snd_timer: Unknown symbol snd_info_unregister
snd_timer: Unknown symbol snd_register_device
modprobe: WARNING: Error inserting snd_timer (/lib/modules/2.6.11-rc2-mm2/kernel/sound/core/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)

usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-0000:00:02.1-4
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
kobject_register failed for evdev (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff80151de0>{file_read_actor+0} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
kobject_register failed for evdev (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8019ffa0>{proc_alloc_inode+64} <ffffffff80187660>{alloc_inode+288} 
       <ffffffff80188752>{iget_locked+210} <ffffffff80145588>{wake_up_bit+24} 
       <ffffffff801a0089>{proc_get_inode+121} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
ts: Compaq touchscreen protocol output
kobject_register failed for evdev (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8019ffa0>{proc_alloc_inode+64} <ffffffff80187660>{alloc_inode+288} 
       <ffffffff80188752>{iget_locked+210} <ffffffff80145588>{wake_up_bit+24} 
       <ffffffff801a0089>{proc_get_inode+121} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
kobject_register failed for evdev (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8019ffa0>{proc_alloc_inode+64} <ffffffff80187660>{alloc_inode+288} 
       <ffffffff80188752>{iget_locked+210} <ffffffff80145588>{wake_up_bit+24} 
       <ffffffff801a0089>{proc_get_inode+121} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
mice: PS/2 mouse device common for all mice
kobject_register failed for evdev (-17)

Call Trace:<ffffffff801fcac6>{kobject_register+70} <ffffffff8014adc7>{sys_init_module+5559} 
       <ffffffff8019ffa0>{proc_alloc_inode+64} <ffffffff80187660>{alloc_inode+288} 
       <ffffffff80188752>{iget_locked+210} <ffffffff80145588>{wake_up_bit+24} 
       <ffffffff801a0089>{proc_get_inode+121} <ffffffff8017c127>{do_lookup+55} 
       <ffffffff8017cfc9>{link_path_walk+2953} <ffffffff801fd9e0>{prio_tree_insert+48} 
       <ffffffff80135c3f>{current_fs_time+79} <ffffffff8015cf18>{vma_prio_tree_insert+40} 
       <ffffffff8016259c>{vma_link+172} <ffffffff80163d28>{do_mmap_pgoff+1720} 
       <ffffffff80113f5f>{sys_mmap+191} <ffffffff8010e22a>{system_call+126} 
       
SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 00000000fffccdd9     0     1      0     2               (NOTLB)
ffff81001ff93d88 0000000000000046 0000000000000000 ffffffff803e0440 
       ffff81001ff914a0 0000000000000218 ffffffff803d0400 ffff81001ff916b0 
       ffff81001ff914a0 000000101ffe0ec0 
Call Trace:<ffffffff803193fe>{schedule_timeout+158} <ffffffff8013a1e0>{process_timeout+0} 
       <ffffffff8017b211>{pipe_poll+65} <ffffffff80182117>{do_select+967} 
       <ffffffff80181c60>{__pollwait+0} <ffffffff801824e9>{sys_select+889} 
       <ffffffff8010e22a>{system_call+126} 
ksoftirqd/0   S 0000000000000000     0     2      1             3       (L-TLB)
ffff81001ff97f08 0000000000000046 ffffffff804915e0 ffffffff80141f30 
       ffff81001ff90dd0 00000000000004bb ffffffff803d0400 ffff81001ff90fe0 
       0000000000000005 ffffffff80136024 
Call Trace:<ffffffff80141f30>{__rcu_process_callbacks+272} <ffffffff80136024>{tasklet_action+68} 
       <ffffffff80136140>{ksoftirqd+0} <ffffffff80136185>{ksoftirqd+69} 
       <ffffffff80136140>{ksoftirqd+0} <ffffffff80144f4d>{kthread+205} 
       <ffffffff8010edef>{child_rip+8} <ffffffff80144e80>{kthread+0} 
       <ffffffff8010ede7>{child_rip+0} 
events/0      R  running task       0     3      1             4     2 (L-TLB)
khelper       S ffff81001ffd31b0     0     4      1             9     3 (L-TLB)
ffff81001ffbde78 0000000000000046 0000000000000001 0000006f00000000 
       ffff81001ff90030 00000000000000a1 ffff81001bf8f720 ffff81001ff90240 
       ffff81001ffd31b0 ffff81001ffd31a0 
Call Trace:<ffffffff80140ec6>{worker_thread+278} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff80140db0>{worker_thread+0} 
       <ffffffff80144f4d>{kthread+205} <ffffffff8010edef>{child_rip+8} 
       <ffffffff80144e80>{kthread+0} <ffffffff8010ede7>{child_rip+0} 
       
kthread       S ffff81001ff810f0     0     9      1    18     141     4 (L-TLB)
ffff8100018d3e78 0000000000000046 0000000000000001 0000007300000000 
       ffff81001ffbf4e0 0000000000000075 ffff81001ff914a0 ffff81001ffbf6f0 
       ffff81001ff810f0 ffff81001ff810e0 
Call Trace:<ffffffff80140ec6>{worker_thread+278} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff80140db0>{worker_thread+0} 
       <ffffffff80144f4d>{kthread+205} <ffffffff8010edef>{child_rip+8} 
       <ffffffff801f7830>{dummy_d_instantiate+0} <ffffffff80144e80>{kthread+0} 
       <ffffffff8010ede7>{child_rip+0} 
kacpid        S ffff81001ff83cb0     0    18      9           133       (L-TLB)
ffff810001945e78 0000000000000046 ffff81001ffbeeb0 0000007d8051ffb0 
       ffff81001ffbee10 00000000000005e1 ffff81001ff914a0 ffff81001ffbf020 
       ffff81001ffbeeb0 0000000000010000 
Call Trace:<ffffffff80140ec6>{worker_thread+278} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff80140db0>{worker_thread+0} 
       <ffffffff80144f4d>{kthread+205} <ffffffff8010edef>{child_rip+8} 
       <ffffffff80144f90>{keventd_create_kthread+0} <ffffffff80144e80>{kthread+0} 
       <ffffffff8010ede7>{child_rip+0} 
kblockd/0     S ffff81001ff83230     0   133      9           186    18 (L-TLB)
ffff8100019a7e78 0000000000000046 0000000000000000 0000007600000000 
       ffff81001ffbe740 000000000000063b ffff81001f5df6a0 ffff81001ffbe950 
       ffff81001ff83230 ffff81001ff83220 
Call Trace:<ffffffff80140ec6>{worker_thread+278} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff80140db0>{worker_thread+0} 
       <ffffffff80144f4d>{kthread+205} <ffffffff8010edef>{child_rip+8} 
       <ffffffff80144f90>{keventd_create_kthread+0} <ffffffff80144e80>{kthread+0} 
       <ffffffff8010ede7>{child_rip+0} 
khubd         S 0000000000000000     0   141      1           188     9 (L-TLB)
ffff8100019a9e38 0000000000000046 ffff81001fdd5a40 000000791ca54200 
       ffff81001ffbe070 00000000000012a2 ffff81001fb46840 ffff81001ffbe280 
       ffff8100000003e8 0000000000333030 
Call Trace:<ffffffff80290028>{hub_thread+2584} <ffffffff80145430>{autoremove_wake_function+0} 
       <ffffffff801339f7>{do_exit+2711} <ffffffff80145430>{autoremove_wake_function+0} 
       <ffffffff8010edef>{child_rip+8} <ffffffff8020c390>{vgacon_cursor+0} 
       <ffffffff8028f610>{hub_thread+0} <ffffffff8010ede7>{child_rip+0} 
       
pdflush       S ffff81001ff93df8     0   186      9           187   133 (L-TLB)
ffff81001fc0fec8 0000000000000046 0000000000000000 0000006f1fc0fe78 
       ffff8100019ad520 0000000000000057 ffff8100019ace50 ffff8100019ad730 
       0000000000000297 ffff81001fc0fec8 
Call Trace:<ffffffff80157995>{pdflush+165} <ffffffff801578f0>{pdflush+0} 
       <ffffffff80144f4d>{kthread+205} <ffffffff8010edef>{child_rip+8} 
       <ffffffff80144f90>{keventd_create_kthread+0} <ffffffff80144e80>{kthread+0} 
       <ffffffff8010ede7>{child_rip+0} 
pdflush       S ffff81001fc11ef0     0   187      9           189   186 (L-TLB)
ffff81001fc11ec8 0000000000000046 0000000000000000 0000000000000000 
       ffff8100019ace50 000000000000004f ffffffff803d0400 ffff8100019ad060 
       0000000000000000 0000000000000005 
Call Trace:<ffffffff80157995>{pdflush+165} <ffffffff801578f0>{pdflush+0} 
       <ffffffff80144f4d>{kthread+205} <ffffffff8010edef>{child_rip+8} 
       <ffffffff80144f90>{keventd_create_kthread+0} <ffffffff80144e80>{kthread+0} 
       <ffffffff8010ede7>{child_rip+0} 
aio/0         S ffffffff80488370     0   189      9           605   187 (L-TLB)
ffff81001fc15e78 0000000000000046 0000000000000000 0000007500000000 
       ffff8100019ac0b0 00000000000000de ffff81001ff90030 ffff8100019ac2c0 
       0000000000000000 0000000000010000 
Call Trace:<ffffffff80140ec6>{worker_thread+278} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff80140db0>{worker_thread+0} 
       <ffffffff80144f4d>{kthread+205} <ffffffff8010edef>{child_rip+8} 
       <ffffffff80144f90>{keventd_create_kthread+0} <ffffffff80144e80>{kthread+0} 
       <ffffffff8010ede7>{child_rip+0} 
kswapd0       S ffffffff803e04e0     0   188      1           523   141 (L-TLB)
ffff81001fc13ea8 0000000000000046 0000000000000000 0000007d00000000 
       ffff8100019ac780 0000000000000fc1 ffff81001ff914a0 ffff8100019ac990 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8015ccc5>{kswapd+261} <ffffffff80145430>{autoremove_wake_function+0} 
       <ffffffff80145430>{autoremove_wake_function+0} <ffffffff8010edef>{child_rip+8} 
       <ffffffff8015cbc0>{kswapd+0} <ffffffff8010ede7>{child_rip+0} 
       
kseriod       S ffffffff801001b0     0   523      1           610   188 (L-TLB)
ffff81001fc9dea8 0000000000000046 ffff81001fc29600 0000007d1fc9de58 
       ffff81001fc29560 0000000000000f08 ffff81001ff914a0 ffff81001fc29770 
       000000000000020a 0000007700000086 
Call Trace:<ffffffff80257552>{serio_thread+434} <ffffffff80145430>{autoremove_wake_function+0} 
       <ffffffff80145430>{autoremove_wake_function+0} <ffffffff8010edef>{child_rip+8} 
       <ffffffff8020c390>{vgacon_cursor+0} <ffffffff802573a0>{serio_thread+0} 
       <ffffffff8010ede7>{child_rip+0} 
reiserfs/0    S ffff81001fca8a40     0   605      9                 189 (L-TLB)
ffff810001b2fe78 0000000000000046 0000000000000000 0000000000000000 
       ffff81001fc28e90 00000000000035cb ffffffff803d0400 ffff81001fc290a0 
       ffff81001fca8a70 ffff81001fca8a60 
Call Trace:<ffffffff80140ec6>{worker_thread+278} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff80140db0>{worker_thread+0} 
       <ffffffff80144f4d>{kthread+205} <ffffffff8010edef>{child_rip+8} 
       <ffffffff80144f90>{keventd_create_kthread+0} <ffffffff80144e80>{kthread+0} 
       <ffffffff8010ede7>{child_rip+0} 
init          S 0000000000000263     0   610      1   611     631   523 (NOTLB)
ffff81001f97fe68 0000000000000046 ffffffff8014186f 000000741f8e8130 
       ffff81001f8e8800 0000000000000a9f ffff81001ff914a0 ffff81001f8e8a10 
       0000000000000014 00002aaaaac6bd10 
Call Trace:<ffffffff8014186f>{attach_pid+47} <ffffffff80134a69>{do_wait+3193} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8013da61>{sys_rt_sigaction+113} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8010e22a>{system_call+126} 
       
rcS           S ffff81001f8e8248     0   611    610  1150               (NOTLB)
ffff81001f993e68 0000000000000046 ffffffff8014186f ffff81001fb46f10 
       ffff81001f8e8130 00000000000019bb ffffffff803d0400 ffff81001f8e8340 
       0000000000000007 00000000005d0000 
Call Trace:<ffffffff8014186f>{attach_pid+47} <ffffffff80134a69>{do_wait+3193} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8013da84>{sys_rt_sigaction+148} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8010e22a>{system_call+126} 
       
udevd         S 7fffffffffffffff     0   631      1           850   610 (NOTLB)
ffff81001f63bd88 0000000000000046 0000000000000000 00000070803e0440 
       ffff81001fb62880 0000000000001775 ffff81001e7196e0 ffff81001fb62a90 
       ffff81001fb62880 0000001000000000 
Call Trace:<ffffffff8031937e>{schedule_timeout+30} <ffffffff80181caa>{__pollwait+74} 
       <ffffffff80182117>{do_select+967} <ffffffff80181c60>{__pollwait+0} 
       <ffffffff801824e9>{sys_select+889} <ffffffff8010e22a>{system_call+126} 
       
khpsbpkt      S ffffffff8804e670     0   850      1           970   631 (L-TLB)
ffff81001ec01e78 0000000000000046 ffff81001fb46170 0000000000000001 
       ffff81001fb46170 0000000000000706 ffffffff803d0400 ffff81001fb46380 
       ffffffff8806b400 ffffffff80132846 
Call Trace:<ffffffff80132846>{reparent_to_init+486} <ffffffff80318386>{__down_interruptible+198} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff80319961>{__down_failed_interruptible+53} 
       <ffffffff8010edef>{child_rip+8} <ffffffff8010ede7>{child_rip+0} 
       
kjournald     S 0000000000000001     0   970      1                 850 (L-TLB)
ffff81001c29be58 0000000000000046 ffff81001c29be38 0000007780145439 
       ffff81001fb82f90 00000000002a08a8 ffff81001f8e95a0 ffff81001fb831a0 
       ffff81001cb23200 ffff81001f0bf400 
Call Trace:<ffffffff801ec0ba>{kjournald+474} <ffffffff80145430>{autoremove_wake_function+0} 
       <ffffffff80145430>{autoremove_wake_function+0} <ffffffff801ebec0>{commit_timeout+0} 
       <ffffffff8010edef>{child_rip+8} <ffffffff801ebee0>{kjournald+0} 
       <ffffffff8010ede7>{child_rip+0} 
S40hotplug    S 00000000ffffffff     0  1150    611  1269               (NOTLB)
ffff81001f673e68 0000000000000046 ffffffff8014186f 000000781f5de230 
       ffff81001fb46f10 0000000000002e37 ffff81001fc280f0 ffff81001fb47120 
       0000000000000007 00000000005cb088 
Call Trace:<ffffffff8014186f>{attach_pid+47} <ffffffff80134a69>{do_wait+3193} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8013da84>{sys_rt_sigaction+148} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8010e22a>{system_call+126} 
       
pci.rc        S 00000000ffffffff     0  1269   1150  1710               (NOTLB)
ffff81001d4f1e68 0000000000000046 ffffffff8014186f 000000731fb828c0 
       ffff81001f5de230 000000000000b348 ffff81001ffbe070 ffff81001f5de440 
       0000000000000007 00000000005ce208 
Call Trace:<ffffffff8014186f>{attach_pid+47} <ffffffff80134a69>{do_wait+3193} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8013da84>{sys_rt_sigaction+148} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8010e22a>{system_call+126} 
       
pci.agent     S ffff81001fb829d8     0  1710   1269  1738               (NOTLB)
ffff81001d37fe68 0000000000000046 ffffffff8014186f ffff81001fc280f0 
       ffff81001fb828c0 0000000000012b21 ffffffff803d0400 ffff81001fb82ad0 
       0000000000000007 00000000005c5fe4 
Call Trace:<ffffffff8014186f>{attach_pid+47} <ffffffff80134a69>{do_wait+3193} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8013da84>{sys_rt_sigaction+148} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8010e22a>{system_call+126} 
       
modprobe      S 00000000000006e3     0  1738   1710  1763               (NOTLB)
ffff81001ea1de68 0000000000000046 ffffffff8014186f 000000791fb63620 
       ffff81001fc280f0 00000000000008ce ffff81001f5df6a0 ffff81001fc28300 
       0000000000000007 00002aaaaadfdbf0 
Call Trace:<ffffffff8014186f>{attach_pid+47} <ffffffff80134a69>{do_wait+3193} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8010e22a>{system_call+126} 
sh            S 00000000ffffffff     0  1763   1738  1764               (NOTLB)
ffff81001e6fbe68 0000000000000046 ffffffff8014186f 000000751f5df6a0 
       ffff81001fb63620 0000000000003d22 ffff81001fc280f0 ffff81001fb63830 
       0000000000000007 00002aaaaabbf0f0 
Call Trace:<ffffffff8014186f>{attach_pid+47} <ffffffff80134a69>{do_wait+3193} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8013da84>{sys_rt_sigaction+148} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8010e22a>{system_call+126} 
       
modprobe      S 00000000000006ef     0  1764   1763  1775               (NOTLB)
ffff81001e4f3e68 0000000000000046 ffffffff8014186f 000000781fb46840 
       ffff81001f5df6a0 0000000000001e3e ffff81001fb621b0 ffff81001f5df8b0 
       0000000000000007 00002aaaaadfdbf0 
Call Trace:<ffffffff8014186f>{attach_pid+47} <ffffffff80134a69>{do_wait+3193} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8012dc80>{default_wake_function+0} 
       <ffffffff8010e22a>{system_call+126} 
sh            S 00000000ffffffff     0  1775   1764  1794               (NOTLB)
ffff81001c4fbe68 0000000000000046 ffffffff8014186f 000000791f8e8ed0 
       ffff81001fb46840 00000000000122d5 ffff81001f5df6a0 ffff81001fb46a50 
       0000000000000007 00002aaaaabbf0f0 
Call Trace:<ffffffff8014186f>{attach_pid+47} <ffffffff80134a69>{do_wait+3193} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8013da84>{sys_rt_sigaction+148} 
       <ffffffff8012dc80>{default_wake_function+0} <ffffffff8010e22a>{system_call+126} 
       
modprobe      S ffff81001e231ec8     0  1794   1775                     (NOTLB)
ffff81001e231e88 0000000000000046 ffff81001f189b10 0000007900000296 
       ffff81001f8e8ed0 000000000040b490 ffff81001fb46840 ffff81001f8e90e0 
       fffffff500000000 0000000000000000 
Call Trace:<ffffffff80185127>{fcntl_setlk+583} <ffffffff80145430>{autoremove_wake_function+0} 
       <ffffffff80145430>{autoremove_wake_function+0} <ffffffff80180c99>{sys_fcntl+697} 
       <ffffffff8010e22a>{system_call+126} 
SysRq : Emergency Sync
Emergency Sync complete
SysRq : Emergency Remount R/O
Emergency Remount complete
SysRq : Resetting
machine restart

