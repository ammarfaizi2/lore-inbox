Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269906AbUJSTAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269906AbUJSTAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUJSS0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:26:47 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:11170
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270142AbUJSSGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:06:55 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <1098204276.12223.992.camel@thomas>
References: <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019144642.GA6512@elte.hu>
	 <28172.195.245.190.93.1098199429.squirrel@195.245.190.93>
	 <1098200660.12223.923.camel@thomas>  <20041019155722.GA9711@elte.hu>
	 <1098204276.12223.992.camel@thomas>
Content-Type: multipart/mixed; boundary="=-CXjd9pnqOO5KZJYrXsBN"
Organization: linutronix
Message-Id: <1098208730.12223.1002.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 19:58:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CXjd9pnqOO5KZJYrXsBN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-10-19 at 18:44, Thomas Gleixner wrote:
> On Tue, 2004-10-19 at 17:57, Ingo Molnar wrote:

The laptop boots now. The culprits, which break the boot are:
pci-hotplug and firewire drivers. 

agp loads correct.

No deeper insight yet.

The IPV6 code triggers the irqs_disabled() check in schedule. dmesg
output attached.

tglx


--=-CXjd9pnqOO5KZJYrXsBN
Content-Disposition: attachment; filename=dmesg-lap.txt
Content-Type: text/plain; name=dmesg-lap.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

0000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131023
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126927 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fdea0
ACPI: RSDT (v001 DELL    CPi R   0x27d40113 ASL  0x00000061) @ 0x1fff0000
ACPI: FADT (v001 DELL    CPi R   0x27d40113 ASL  0x00000061) @ 0x1fff0400
ACPI: MADT (v001 DELL    CPi R   0x27d40113 ASL  0x00000047) @ 0x1fff0c00
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hdc6 ro 
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 3056.985 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515412k/524092k available (1776k kernel code, 8124k reserved, 811k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6062.08 BogoMIPS (lpj=3031040)
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
ksoftirqd started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfcf1e, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: 00:01: ioport range 0x1000-0x105f could not be reserved
pnp: 00:01: ioport range 0x1060-0x107f has been reserved
pnp: 00:01: ioport range 0x1080-0x10bf has been reserved
pnp: 00:01: ioport range 0x10c0-0x10ff could not be reserved
pnp: 00:01: ioport range 0xf400-0xf4fe has been reserved
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x66, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
i8042.c: Can't read CTR while initializing i8042.
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 17
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-STCD-RW/DVD-ROM GCC-4241N, ATAPI CD/DVD-ROM drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IC25N040ATMR04-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hdc: max request size: 1024KiB
hdc: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 /dev/ide/host0/bus1/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
NET: Registered protocol family 2
IP: routing cache hash table of 64 buckets, 18Kbytes
TCP: Hash tables configured (established 512 bind 923)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S1 S3 S4 S4bios S5)
ACPI wakeup devices: 
 LID PBTN PCI0 USB0 USB1 USB2 USB3 MODM PCIE 
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
NET: Registered protocol family 1
EXT3 FS on hdc6, internal journal
Real Time Clock Driver v1.12
hda: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
b44.c:v0.95 (Aug 3, 2004)
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 17
eth0: Broadcom 4400 10/100BaseT Ethernet 00:0d:56:39:10:9e
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49346 usecs
intel8x0: clocking to 48000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xf4fffc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:02:04.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 16 (level, low) -> IRQ 16
Yenta: CardBus bridge found at 0000:02:04.0 [1028:015f]
Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
Socket status: 30000006
input: PC Speaker
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0xbf80
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0xbf40
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0xbf20
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
usb 2-1: new low speed USB device using address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver hiddev
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:1d.0-1
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.0-1
usbcore: registered new driver usbhid
/home/thomas/work/LibeRTOS/work/2.6.9-rc4-mm1-VP-U4-LRT1/drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
hw_random: RNG not detected
Intel 810 + AC97 Audio, version 1.01, 18:13:38 Oct 19 2004
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.6 to 64
MC'97 1 converters and GPIO not ready (0xff00)
b44: eth0: Link is down.
NET: Registered protocol family 17
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.
Capability LSM initialized
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0353400(lo)
BUG: sleeping function called from invalid context modprobe(3296) at /home/thomas/work/LibeRTOS/work/2.6.9-rc4-mm1-VP-U4-LRT1/lib/rwsem-generic.c:313
in_atomic():1 [00000001], irqs_disabled():0
 [<c0119e85>] __might_sleep+0xba/0xc9
 [<c02bac00>] down_read+0x1b/0x1d1
 [<c0130cd8>] _rw_mutex_read_lock+0x13/0x22
 [<e09b6d36>] ndisc_constructor+0x3d/0x21a [ipv6]
 [<c025bf7f>] neigh_create+0x1dd/0x1e9
 [<c025bc38>] neigh_lookup+0x9e/0x103
 [<e09b3303>] addrconf_dst_alloc+0x164/0x17a [ipv6]
 [<e09aa7ee>] ipv6_add_addr+0xbf/0x26a [ipv6]
 [<e09acd8b>] init_loopback+0x59/0x10f [ipv6]
 [<e09ad220>] addrconf_notify+0xfa/0x190 [ipv6]
 [<c0129358>] notifier_chain_register+0x44/0x4c
 [<c0257160>] register_netdevice_notifier+0x6c/0x6e
 [<e08a830c>] addrconf_init+0xf/0x81 [ipv6]
 [<e08a81c6>] inet6_init+0x13c/0x203 [ipv6]
 [<c0134ee1>] sys_init_module+0x17a/0x227
 [<c01060df>] syscall_call+0x7/0xb
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: ndisc_constructor+0x31/0x21a [ipv6] / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: modprobe/0x04000001/3296
caller is cond_resched+0x58/0x73
 [<c02ba15e>] __sched_text_start+0x56e/0x5be
 [<c02ba833>] cond_resched+0x58/0x73
 [<c0106ee5>] dump_stack+0x1c/0x20
 [<c0119e85>] __might_sleep+0xba/0xc9
 [<c02ba833>] cond_resched+0x58/0x73
 [<c02bac05>] down_read+0x20/0x1d1
 [<c0130cd8>] _rw_mutex_read_lock+0x13/0x22
 [<e09b6d36>] ndisc_constructor+0x3d/0x21a [ipv6]
 [<c025bf7f>] neigh_create+0x1dd/0x1e9
 [<c025bc38>] neigh_lookup+0x9e/0x103
 [<e09b3303>] addrconf_dst_alloc+0x164/0x17a [ipv6]
 [<e09aa7ee>] ipv6_add_addr+0xbf/0x26a [ipv6]
 [<e09acd8b>] init_loopback+0x59/0x10f [ipv6]
 [<e09ad220>] addrconf_notify+0xfa/0x190 [ipv6]
 [<c0129358>] notifier_chain_register+0x44/0x4c
 [<c0257160>] register_netdevice_notifier+0x6c/0x6e
 [<e08a830c>] addrconf_init+0xf/0x81 [ipv6]
 [<e08a81c6>] inet6_init+0x13c/0x203 [ipv6]
 [<c0134ee1>] sys_init_module+0x17a/0x227
 [<c01060df>] syscall_call+0x7/0xb
preempt count: 04000002
. 2-level deep critical section nesting:
.. entry 1: ndisc_constructor+0x31/0x21a [ipv6] / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

IPv6 over IPv4 tunneling driver
apm: BIOS not found.
lp: driver loaded but no devices found
BUG: sleeping function called from invalid context ksoftirqd/0(2) at /home/thomas/work/LibeRTOS/work/2.6.9-rc4-mm1-VP-U4-LRT1/lib/rwsem-generic.c:313
in_atomic():1 [00000001], irqs_disabled():0
 [<c0119e85>] __might_sleep+0xba/0xc9
 [<c02bac00>] down_read+0x1b/0x1d1
 [<c0130cd8>] _rw_mutex_read_lock+0x13/0x22
 [<e09b6d36>] ndisc_constructor+0x3d/0x21a [ipv6]
 [<c025bf7f>] neigh_create+0x1dd/0x1e9
 [<c025bc38>] neigh_lookup+0x9e/0x103
 [<e09b1eb7>] ndisc_dst_alloc+0x130/0x13a [ipv6]
 [<e09b7b5d>] ndisc_send_rs+0x95/0x4bf [ipv6]
 [<e09a6d7f>] ip6_output+0x0/0x44 [ipv6]
 [<e09b56f4>] fib6_prune_clones+0x27/0x2b [ipv6]
 [<e09ada6b>] addrconf_dad_completed+0xa0/0xe9 [ipv6]
 [<e09ad90f>] addrconf_dad_timer+0x37/0xf3 [ipv6]
 [<c0118e4b>] __wake_up+0x59/0x85
 [<e09ad8d8>] addrconf_dad_timer+0x0/0xf3 [ipv6]
 [<c0125414>] run_timer_softirq+0x11f/0x2db
 [<c01216a9>] ___do_softirq+0x79/0xbc
 [<c01219be>] ksoftirqd+0x0/0xc8
 [<c0121774>] _do_softirq+0x17/0x19
 [<c0121a49>] ksoftirqd+0x8b/0xc8
 [<c0130129>] kthread+0xa5/0xab
 [<c0130084>] kthread+0x0/0xab
 [<c0104285>] kernel_thread_helper+0x5/0xb
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: ndisc_constructor+0x31/0x21a [ipv6] / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x807
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
apm: BIOS not found.
eth0: no IPv6 routers present
apm: BIOS not found.
/home/thomas/work/LibeRTOS/work/2.6.9-rc4-mm1-VP-U4-LRT1/drivers/usb/input/hid-input.c: event field not found
/home/thomas/work/LibeRTOS/work/2.6.9-rc4-mm1-VP-U4-LRT1/drivers/usb/input/hid-input.c: event field not found

--=-CXjd9pnqOO5KZJYrXsBN--

