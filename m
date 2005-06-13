Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVFMVco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVFMVco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVFMVcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:32:43 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:41374 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261411AbVFMV2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:28:05 -0400
Subject: RE: [discuss] [OOPS] powernow on smp dual core amd64
From: Tom Duffy <tduffy@sun.com>
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <84EA05E2CA77634C82730353CBE3A84301CFC14B@SAUSEXMB1.amd.com>
References: <84EA05E2CA77634C82730353CBE3A84301CFC14B@SAUSEXMB1.amd.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-o2di9ecFoxzA1nZreRcg"
Date: Mon, 13 Jun 2005 14:27:02 -0700
Message-Id: <1118698022.9114.8.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o2di9ecFoxzA1nZreRcg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

OK, here is the whole dmesg on stock rc6 (with the added printout of cpu
number in powernowk8_get()):

Bootdata ok (command line is ro root=3D/dev/VolGroup00/LogVol00 console=3Dt=
tyS0 console=3Dtty1 3)
Linux version 2.6.12-rc6andro (root@androdemolin1.sfbay.sun.com) (gcc versi=
on 4.0.0 20050606 (Red Hat 4.0.0-11)) #840 SMP Mon Jun 13 11:32:51 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fffe000 (ACPI data)
 BIOS-e820: 000000007fffe000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 1 -> APIC 2 -> Node 1
SRAT: PXM 1 -> APIC 3 -> Node 1
SRAT: PXM 2 -> APIC 4 -> Node 2
SRAT: PXM 2 -> APIC 5 -> Node 2
SRAT: PXM 3 -> APIC 6 -> Node 3
SRAT: PXM 3 -> APIC 7 -> Node 3
SRAT: Node 0 PXM 0 100000-3fffffff
SRAT: Node 1 PXM 1 40000000-7fffffff
SRAT: Node 0 PXM 0 0-3fffffff
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007ffeffff
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] enabled)
Processor #4 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] enabled)
Processor #5 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x06] enabled)
Processor #6 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
Processor #7 15:1 APIC version 16
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfeaff000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 17, address 0xfeaff000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:7ec00000)
Checking aperture...
CPU 0: aperture @ ef54000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 2 zonelists
Kernel command line: ro root=3D/dev/VolGroup00/LogVol00 console=3DttyS0 con=
sole=3Dtty1 3
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2200.028 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 2054588k/2097088k available (2403k kernel code, 0k reserved, 885k d=
ata, 228k init)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff81003ffa9f58
Initializing CPU#1
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
Dual Core AMD Opteron(tm) Processor 875 stepping 00
CPU 1: Syncing TSC to CPU 0.
Booting processor 2/2 rip 6000 rsp ffff81007ff31f58
Initializing CPU#2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(2) -> Node 1 -> Core 0
Dual Core AMD Opteron(tm) Processor 875 stepping 00
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -121 cycles, maxerr 889 cycle=
s)
Booting processor 3/3 rip 6000 rsp ffff810041491f58
Initializing CPU#3
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(2) -> Node 1 -> Core 1
Dual Core AMD Opteron(tm) Processor 875 stepping 00
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -121 cycles, maxerr 887 cycle=
s)
Booting processor 4/4 rip 6000 rsp ffff8100414f5f58
Initializing CPU#4
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 4(2) -> Node 1 -> Core 0
Dual Core AMD Opteron(tm) Processor 875 stepping 00
CPU 4: Syncing TSC to CPU 0.
CPU 4: synchronized TSC with CPU 0 (last diff -119 cycles, maxerr 886 cycle=
s)
Booting processor 5/5 rip 6000 rsp ffff810001efff58
Initializing CPU#5
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 5(2) -> Node 0 -> Core 1
Dual Core AMD Opteron(tm) Processor 875 stepping 00
CPU 5: Syncing TSC to CPU 0.
CPU 5: synchronized TSC with CPU 0 (last diff -124 cycles, maxerr 889 cycle=
s)
Booting processor 6/6 rip 6000 rsp ffff81007fe9ff58
Initializing CPU#6
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 6(2) -> Node 0 -> Core 0
Dual Core AMD Opteron(tm) Processor 875 stepping 00
CPU 6: Syncing TSC to CPU 0.
CPU 6: synchronized TSC with CPU 0 (last diff -161 cycles, maxerr 1549 cycl=
es)
Booting processor 7/7 rip 6000 rsp ffff810041501f58
Initializing CPU#7
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 7(2) -> Node 0 -> Core 1
Dual Core AMD Opteron(tm) Processor 875 stepping 00
CPU 7: Syncing TSC to CPU 0.
CPU 7: synchronized TSC with CPU 0 (last diff -162 cycles, maxerr 1549 cycl=
es)
Brought up 8 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
CPU 1: synchronized TSC with CPU 0 (last diff 4 cycles, maxerr 869 cycles)
checking if image is initramfs... it is
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
ACPI: PCI Root Bridge [PCIB] (0000:80)
PCI: Probing PCI hardware (bus 80)
ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *10
ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *5
ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *9
ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *11
ACPI: PCI Interrupt Link [LKLN] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LAUI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LKMO] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LKSM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LTIE] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22) *14
ACPI: PCI Interrupt Link [LN2A] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2B] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2C] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2D] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LK2N] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [LT3D] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [LT2E] (IRQs 44 45 46 47) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI-DMA: Disabling IOMMU.
pnp: 00:08: ioport range 0x680-0x6ff has been reserved
k8-bus.c: some busses have empty cpu mask
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1118697207.709:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: add_host_bridge: status 5
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 controller doesn't have KBD irq; using default 0x1
PNP: PS/2 Controller [PNP0f12:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 162
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0x6000-0x6007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x6008-0x600f, BIOS settings: hdc:DMA, hdd:DMA
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 8 AMD Athlon 64 / Opteron processors (version 1.40.2)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8 (1350 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
cpu_init done, current fid 0xe, vid 0x8
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8 (1350 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
cpu_init done, current fid 0xe, vid 0x8
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8 (1350 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
cpu_init done, current fid 0xe, vid 0x8
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8 (1350 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
cpu_init done, current fid 0xe, vid 0x8
ACPI wakeup devices:
PS2M USB0 USB1  MAC P0P1 P0P2 P0P3 P0P4 P0P5 IO4B  MA4 BR5B BR5C BR5D BR5E =
PWRB
ACPI: (supports S0 S1 S5)
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
Freeing unused kernel memory: 228k freed
SCSI subsystem initialized
Fusion MPT base driver 3.02.18
Copyright (c) 1999-2005 LSI Logic Corporation
PCI: Enabling device 0000:04:01.0 (0116 -> 0117)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 19
ACPI: PCI Interrupt 0000:04:01.0[A] -> Link [LNKB] -> GSI 19 (level, low) -=
> IRQ 233
mptbase: Initiating ioc0 bringup
ioc0: SAS1064: Capabilities=3D{Initiator}
Fusion MPT SCSI Host driver 3.02.18
scsi0 : ioc0: LSISAS1064, FwRev=3D00031400h, Ports=3D1, MaxQ=3D203, IRQ=3D2=
33
  Vendor: SEAGATE   Model: ST973401LSUN72G   Rev: 0356
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 143374738 512-byte hdwr sectors (73408 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 143374738 512-byte hdwr sectors (73408 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: ATA       Model: FUJITSU MHT2080B  Rev: 0043
  Type:   Direct-Access                      ANSI SCSI revision: 05
powernowk8_get() cpu is 0
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdb: drive cache: write back
 sdb:<3>powernowk8_get() cpu is 1
Unable to handle kernel NULL pointer dereference at 0000000000000024 RIP:
<ffffffff8011d94c>{query_current_values_with_pending_wait+60} sdb1 sdb2

PGD 3fe74067 PUD 3fd28067 PMD 0
Oops: 0002 [1] SMP
CPU 1
Modules linked in: mptscsih mptbase sd_mod scsi_mod
Pid: 25, comm: events/7 Not tainted 2.6.12-rc6andro
RIP: 0010:[<ffffffff8011d94c>] <ffffffff8011d94c>{query_current_values_with=
_pending_wait+60}
RSP: 0000:ffff81007fddbdc8  EFLAGS: 00010202
RAX: 000000000000000e RBX: 0000000000000000 RCX: 00000000c0010042
RDX: 0000000000000008 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000080 R08: ffff81007fdda000 R09: ffff81003fd421f0
R10: 000000000000001c R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000283 R15: ffffffff80112630
FS:  000000000057d850(0000) GS:ffffffff80498180(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000024 CR3: 000000003f415000 CR4: 00000000000006e0
Process events/7 (pid: 25, threadinfo ffff81007fdda000, task ffff81003fd421=
f0)
Stack: 0000000000000080 ffffffff8011dea1 0000000000000001 ffff81003fd91430
       ffff81003fd91400 ffffffff802e2b90 0000000000000000 0000000000000003
       ffff81007fddbe48 0000000000000001
Call Trace:<ffffffff8011dea1>{powernowk8_get+145} <ffffffff802e2b90>{cpufre=
q_get+96}
       <ffffffff8011266a>{handle_cpufreq_delayed_get+58} <ffffffff80148eec>=
{worker_thread+476}
       <ffffffff801326d0>{default_wake_function+0} <ffffffff80130733>{__wak=
e_up_common+67}
       <ffffffff80148d10>{worker_thread+0} <ffffffff8014d7a9>{kthread+217}
       <ffffffff80133be0>{schedule_tail+64} <ffffffff8010f5b7>{child_rip+8}
       <ffffffff8011d4f0>{flat_send_IPI_mask+0} <ffffffff8014d6d0>{kthread+=
0}
       <ffffffff8010f5af>{child_rip+0}

Code: 89 47 24 89 57 20 31 c0 48 83 c4 08 c3 66 66 66 90 66 66 90
RIP <ffffffff8011d94c>{query_current_values_with_pending_wait+60} RSP <ffff=
81007fddbdc8>
CR2: 0000000000000024
 <5>Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
libata version 1.11 loaded.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks

--=-o2di9ecFoxzA1nZreRcg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCrfomdY502zjzwbwRAltdAJ4+eUIg1/2N8Xocnm3TGdhp17M4CwCdE8dX
pex0N//VVxac5kgvrIn2kWo=
=Hfnm
-----END PGP SIGNATURE-----

--=-o2di9ecFoxzA1nZreRcg--
