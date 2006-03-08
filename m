Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWCHWlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWCHWlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWCHWlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:41:49 -0500
Received: from web52607.mail.yahoo.com ([206.190.48.210]:56656 "HELO
	web52607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932101AbWCHWlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:41:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZpBMt7f/inKAdXAgciYb2v4NJDmDvIBDXFt4VavUif4SZs4SpwnwJbOeJuoGgg7kNRse6PlCmvCRS5oiP8GXccWHNgGOOBM8VeC+oo3vHQy/QxJiJGoYermYjcqNPZNVVPQQYAr+vZ/jC4MrFxPyQCTSVF9kiBS5/DPhXmfaksQ=  ;
Message-ID: <20060308224145.47332.qmail@web52607.mail.yahoo.com>
Date: Thu, 9 Mar 2006 09:41:45 +1100 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Oops on ibmasm
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When ibmasm kernel module is loaded on a slab debug
enabled kernel, it oopses. Yes, it's fine when there's
no slab debug.

On Dave Jones' advice
(https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=184161),
I've loaded ibmasm with ibmasm_debug=1, & here's the
complete dmesg:
Linux version 2.6.16-rc5 (admin@localhost.localdomain)
(gcc version 4.1.0 20060214 (Red Hat 4.1.0-0.27)) #4
SMP Wed Mar 8 22:58:25 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c400
(usable)
 BIOS-e820: 000000000009c400 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 00000000df0ea400
(usable)
 BIOS-e820: 00000000df0ea400 - 00000000df0f0000 (ACPI
data)
 BIOS-e820: 00000000df0f0000 - 00000000e0000000
(reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000
(reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000
(reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000
(usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 0009c9d0
On node 0 totalpages: 1048576
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 819200 pages, LIFO batch:31
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP (v000 IBM                                  
) @ 0x000fdfe0
ACPI: RSDT (v001 IBM    SERCRSDR 0x00001002 IBM 
0x45444f43) @ 0xdf0eff80
ACPI: FADT (v001 IBM    SERCRSDR 0x00001002 IBM 
0x45444f43) @ 0xdf0eff00
ACPI: MADT (v001 IBM    SERCRSDR 0x00001002 IBM 
0x45444f43) @ 0xdf0efe80
ACPI: DSDT (v001 IBM    SERCRSDR 0x00001002 MSFT
0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x488
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x04] enabled)
Processor #4 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] enabled)
Processor #5 15:1 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
Overriding APIC driver with bigsmp
ACPI: IOAPIC (id[0x0e] address[0xfec00000]
gsi_base[0])
IOAPIC[0]: apic_id 14, version 17, address 0xfec00000,
GSI 0-50
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl
dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low
edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 36 low
level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ8 used by override.
Enabling APIC mode:  Physflat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at e2000000 (gap:
e0000000:1ec00000)
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00
rhgb init=/bin/bash
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c031f000 soft=c031b000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1600.642 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7,
524288 bytes)
Inode-cache hash table entries: 65536 (order: 6,
262144 bytes)
Memory: 3615052k/4194304k available (1424k kernel
code, 38180k reserved, 532k data, 172k init, 2737064k
highmem)
Checking if this processor honours the WP bit even in
supervisor mode... Ok.
Calibrating delay using timer specific routine..
3209.99 BogoMIPS (lpj=6419983)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary
module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 3febfbff 00000000
00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 3febfbff 00000000
00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: 3febfbff 00000000 00000000
00000080 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 1.60GHz stepping 01
Leaving ESR disabled.
Booting processor 1/4 eip 3000
CPU 1 irqstacks, hard=c0320000 soft=c031c000
Initializing CPU#1
Leaving ESR disabled.
Calibrating delay using timer specific routine..
3200.86 BogoMIPS (lpj=6401734)
CPU: After generic identify, caps: 3febfbff 00000000
00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 3febfbff 00000000
00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 1024K
CPU: Physical Processor ID: 2
CPU: After all inits, caps: 3febfbff 00000000 00000000
00000080 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 1.60GHz stepping 01
Booting processor 2/1 eip 3000
CPU 2 irqstacks, hard=c0321000 soft=c031d000
Initializing CPU#2
Leaving ESR disabled.
Calibrating delay using timer specific routine..
3200.88 BogoMIPS (lpj=6401761)
CPU: After generic identify, caps: 3febfbff 00000000
00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 3febfbff 00000000
00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: 3febfbff 00000000 00000000
00000080 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 1.60GHz stepping 01
Booting processor 3/5 eip 3000
CPU 3 irqstacks, hard=c0322000 soft=c031e000
Initializing CPU#3
Leaving ESR disabled.
Calibrating delay using timer specific routine..
3200.74 BogoMIPS (lpj=6401495)
CPU: After generic identify, caps: 3febfbff 00000000
00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 3febfbff 00000000
00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 1024K
CPU: Physical Processor ID: 2
CPU: After all inits, caps: 3febfbff 00000000 00000000
00000080 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 1.60GHz stepping 01
Total of 4 processors activated (12812.48 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
migration_cost=4000,4000
checking if image is initramfs... it is
Freeing initrd memory: 1857k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd31c, last
bus=14
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:01.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Root Bridge [PCI1] (0000:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Root Bridge [PCI2] (0000:0a)
PCI: Probing PCI hardware (bus 0a)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1141819426.968:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096
bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12ac
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K
size 1024 blocksize
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0
Mar  8 2006
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as
/class/input/input0
IP route cache hash table entries: 262144 (order: 8,
1048576 bytes)
TCP established hash table entries: 524288 (order: 10,
4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288
bytes)
TCP: Hash tables configured (established 524288 bind
65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
Using IPI No-Shortcut mode
ACPI wakeup devices: 
LAN0 
ACPI: (supports S0 S4 S5)
Freeing unused kernel memory: 172k freed
SCSI subsystem initialized
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 41 (level,
low) -> IRQ 16
input: PS/2 Generic Mouse as /class/input/input1
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER,
Rev 7.0
        <Adaptec aic7892 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7,
32/253 SCBs

  Vendor: IBM       Model: YGHv3 S2          Rev: 0   
  Type:   Processor                          ANSI SCSI
revision: 02
 target0:0:9: Beginning Domain Validation
 target0:0:9: Ending Domain Validation
  Vendor: IBM-ESXS  Model: ST373405LC    !#  Rev: B245
  Type:   Direct-Access                      ANSI SCSI
revision: 03
scsi0:A:12:0: Tagged Queuing enabled.  Depth 4
 target0:0:12: Beginning Domain Validation
 target0:0:12: wide asynchronous
 target0:0:12: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5
ns, offset 63)
 target0:0:12: Ending Domain Validation
SCSI device sda: 143374000 512-byte hdwr sectors
(73407 MB)
sda: Write Protect is off
sda: Mode Sense: ab 00 10 08
SCSI device sda: drive cache: write through w/ FUA
SCSI device sda: 143374000 512-byte hdwr sectors
(73407 MB)
sda: Write Protect is off
sda: Mode Sense: ab 00 10 08
SCSI device sda: drive cache: write through w/ FUA
 sda: sda1 sda2
sd 0:0:12:0: Attached scsi disk sda
  Vendor: IBM-ESXS  Model: ST373405LC    !#  Rev: B245
  Type:   Direct-Access                      ANSI SCSI
revision: 03
scsi0:A:13:0: Tagged Queuing enabled.  Depth 4
 target0:0:13: Beginning Domain Validation
 target0:0:13: wide asynchronous
 target0:0:13: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5
ns, offset 63)
 target0:0:13: Ending Domain Validation
SCSI device sdb: 143374000 512-byte hdwr sectors
(73407 MB)
sdb: Write Protect is off
sdb: Mode Sense: ab 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
SCSI device sdb: 143374000 512-byte hdwr sectors
(73407 MB)
sdb: Write Protect is off
sdb: Mode Sense: ab 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
 sdb: sdb1
sd 0:0:13:0: Attached scsi disk sdb
ACPI: PCI Interrupt 0000:0a:01.0[A] -> GSI 29 (level,
low) -> IRQ 17
scsi1 : IBM PCI ServeRAID 7.12.05  Build 761
<ServeRAID 4Lx>
  Vendor: IBM       Model: SERVERAID         Rev: 1.00
  Type:   Processor                          ANSI SCSI
revision: 02
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
md: raid0 personality registered for level 0
device-mapper: 4.5.0-ioctl (2005-10-04) initialised:
dm-devel@redhat.com
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2>
md: bind<sdb1>
md: running: <sdb1><sda2>
md0: setting max_sectors to 512, segment boundary to
131071
raid0: looking at sdb1
raid0:   comparing sdb1(71680768) with sdb1(71680768)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda2
raid0:   comparing sda2(71576832) with sdb1(71680768)
raid0:   NOT EQUAL
raid0:   comparing sda2(71576832) with sda2(71576832)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 1
raid0: checking sda2 ... nope.
raid0: checking sdb1 ... contained as device 0
  (71680768) is smallest!.
raid0: zone->nb_dev: 1, size: 103936
raid0: current zone offset: 71680768
raid0: done.
raid0 : md_size is 143257600 blocks.
raid0 : conf->hash_spacing is 143153664 blocks.
raid0 : nb_zone is 2.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 17 (level,
low) -> IRQ 18
command count: 1
input: ibmasm RSA I remote mouse as
/class/input/input2
input: ibmasm RSA I remote keyboard as
/class/input/input3
ibmasm remote responding to events on RSA card 0
command count: 2
ibmasm_exec_command:130 at 1141819512.780778
do_exec_command:107 at 1141819512.780787
respond to interrupt at 1141819512.782055
exec_next_command:150 at 1141819512.782094
finished interrupt at   1141819512.782103
command count: 1
Unable to handle kernel paging request at virtual
address 6b6b6b6b
 printing eip:
c0261af6
*pde = 00000000
Oops: 0002 [#1]
SMP 
Modules linked in: ibmasm dm_snapshot dm_zero
dm_mirror dm_mod raid0 ext3 mbcache jbd ide_disk
ide_core ips aic7xxx scsi_transport_spi sd_mod
scsi_mod
CPU:    1
EIP:    0060:[<c0261af6>]    Not tainted VLI
EFLAGS: 00010046   (2.6.16-rc5 #4) 
EIP is at _spin_unlock_irqrestore+0x2/0x7
eax: 6b6b6b6b   ebx: 00000246   ecx: 00000001   edx:
00000246
esi: 00000000   edi: f7c56bdb   ebp: f7cc2ad0   esp:
f746cda8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 429, threadinfo=f746c000
task=f7f82570)
Stack: <0>f88dee8c c339f0b0 00000000 c339f0b0 00000000
c339f0e8 f7c14ee0 f88dd3aa 
       00000001 f88e24ec f88e24c0 f7c14ee0 c01f4439
c01b9410 f7c14f28 f7c14f28 
       f88e24ec c01f4389 f7c14f28 c316092c f88e24ec
c01f4491 00000000 c02af580 
Call Trace:
 [<f88dee8c>] ibmasm_send_driver_vpd+0xb7/0xc3
[ibmasm]
 [<f88dd3aa>] ibmasm_init_one+0x2a6/0x37c [ibmasm]
 [<c01f4439>] __driver_attach+0x0/0x7f
 [<c01b9410>] pci_device_probe+0x36/0x57
 [<c01f4389>] driver_probe_device+0x42/0x8b
 [<c01f4491>] __driver_attach+0x58/0x7f
 [<c01f3ead>] bus_for_each_dev+0x37/0x59
 [<c01f42f3>] driver_attach+0x11/0x13
 [<c01f4439>] __driver_attach+0x0/0x7f
 [<c01f3bc3>] bus_add_driver+0x64/0xfd
 [<c01b9571>] __pci_register_driver+0x6c/0x8a
 [<f886a027>] ibmasm_init+0x27/0x4e [ibmasm]
 [<c0133a2d>] sys_init_module+0x166a/0x1801
 [<c0157dab>] do_sync_read+0xb8/0xf3
 [<c012d30f>] autoremove_wake_function+0x0/0x2d
 [<c0157cf3>] do_sync_read+0x0/0xf3
 [<c0158678>] vfs_read+0x9f/0x13e
 [<c0158ac1>] sys_read+0x3c/0x63
 [<c0103b5f>] sysenter_past_esp+0x54/0x75
Code: 21 e2 81 42 14 00 01 00 00 f0 fe 08 79 09 f3 90
80 38 00 7e f9 eb f2 c3 31 d2 86 10 31 c0 84 d2 0f 9f
c0 c3 b2 01 86 10 c3 b1 01 <86> 08 52 9d c3 b2 01 86
10 fb c3 f0 83 28 01 79 05 e8 3c e2 ff 
 <3>Debug: sleeping function called from invalid
context at include/linux/rwsem.h:43
in_atomic():0, irqs_disabled():1
 [<c011e260>] profile_task_exit+0x18/0x43
 [<c011fb15>] do_exit+0x1b/0x6ca
 [<c011d5ca>] printk+0x14/0x18
 [<c0104e84>] show_stack+0x0/0xa
 [<c0262aca>] do_page_fault+0x374/0x51a
 [<c0261af6>] _spin_unlock_irqrestore+0x2/0x7
 [<c0262756>] do_page_fault+0x0/0x51a
 [<c01046df>] error_code+0x4f/0x54
 [<c01b007b>] cfq_init_queue+0xa9/0x21b
 [<c0261af6>] _spin_unlock_irqrestore+0x2/0x7
 [<f88dee8c>] ibmasm_send_driver_vpd+0xb7/0xc3
[ibmasm]
 [<f88dd3aa>] ibmasm_init_one+0x2a6/0x37c [ibmasm]
 [<c01f4439>] __driver_attach+0x0/0x7f
 [<c01b9410>] pci_device_probe+0x36/0x57
 [<c01f4389>] driver_probe_device+0x42/0x8b
 [<c01f4491>] __driver_attach+0x58/0x7f
 [<c01f3ead>] bus_for_each_dev+0x37/0x59
 [<c01f42f3>] driver_attach+0x11/0x13
 [<c01f4439>] __driver_attach+0x0/0x7f
 [<c01f3bc3>] bus_add_driver+0x64/0xfd
 [<c01b9571>] __pci_register_driver+0x6c/0x8a
 [<f886a027>] ibmasm_init+0x27/0x4e [ibmasm]
 [<c0133a2d>] sys_init_module+0x166a/0x1801
 [<c0157dab>] do_sync_read+0xb8/0xf3
 [<c012d30f>] autoremove_wake_function+0x0/0x2d
 [<c0157cf3>] do_sync_read+0x0/0xf3
 [<c0158678>] vfs_read+0x9f/0x13e
 [<c0158ac1>] sys_read+0x3c/0x63
 [<c0103b5f>] sysenter_past_esp+0x54/0x75
EXT3 FS on dm-0, internal journal

Here's the lspci -vvv for that:
00:02.0 Bridge: IBM Remote Supervisor Adapter (RSA)
	Subsystem: IBM Unknown device 0113
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 103 (1000ns min, 2000ns max), Cache Line
Size 10
	Interrupt: pin A routed to IRQ 3
	BIST result: 00
	Region 0: Memory at fbc00000 (64-bit,
non-prefetchable) [size=2M]
	Region 2: I/O ports at 1800 [size=128]
	[virtual] Expansion ROM at e2000000 [disabled]
[size=2M]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Thanks

Hari



		
____________________________________________________ 
Do you Yahoo!? 
Take your Mail with you - get Yahoo! Mail on your mobile 
http://au.mobile.yahoo.com/mweb/index.html
