Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbUJ0KwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbUJ0KwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbUJ0KwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:52:09 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:1801 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S262373AbUJ0KvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 06:51:18 -0400
Message-ID: <417F7D7D.5090205@stud.feec.vutbr.cz>
Date: Wed, 27 Oct 2004 12:50:37 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.3
References: <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
In-Reply-To: <20041027001542.GA29295@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------050902020206010505090700"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050902020206010505090700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the -V0.3 Real-Time Preemption patch, which can be
> downloaded from:
> 
> 	http://redhat.com/~mingo/realtime-preempt/
> 
> [...]
> some of the networking lockups might be related to this issue too, but i
> think PREEMPT_REALTIME still has separate lock odering issues within the
> networking code. Please re-report any deadlock-tracer asserts that you
> might encounter.
> 

OK, re-reporting a network deadlock. It happens a few seconds after 
starting Firefox. This is with -V0.3.2:

Linux version 2.6.9-mm1-RT-V0.3.2 (michich@k4-912b) (gcc version 3.3.4 
(Debian 1:3.3.4-6sarge1)) #5 Wed Oct 27 12:26:13 CEST 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
  BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
  BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 229376
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fa840
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000417 MSFT 0x00000097) @ 0x3ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x06000417 MSFT 0x00000097) @ 0x3ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x06000417 MSFT 0x00000097) @ 0x3ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000417 MSFT 0x00000097) @ 0x3ffc0040
ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:7 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=Deb-32-RT ro root=308 
netconsole=4444@147.229.222.29/eth0,4444@147.229.222.28/00:0C:6E:2F:30:75
netconsole: local port 4444
netconsole: local IP 147.229.222.29
netconsole: interface eth0
netconsole: remote port 4444
netconsole: remote IP 147.229.222.28
netconsole: remote ethernet address 00:0c:6e:2f:30:75
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2403.782 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x30
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 905628k/917504k available (1843k kernel code, 11488k reserved, 
786k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4702.20 BogoMIPS (lpj=2351104)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
CPU: After vendor identify, caps:  078bfbff e1d3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: After all inits, caps:        078bfbff e1d3fbff 00000000 00000010
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) 64 FX-53 Processor stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
desched thread 0 started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Initializing Cryptographic API
Real Time Clock Driver v1.12
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
       PrefPort:A  RlmtMode:Check Link State
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears flaky, waiting 10 seconds
IRQ#17 thread RT prio: 49.
eth0: network connection up using port A
     speed:           100
     autonegotiation: yes
     duplex mode:     full
     flowctrl:        none
     irq moderation:  disabled
     scatter-gather:  enabled
netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
hda: ST3120026A, ATA DISK drive
hdb: ST320011A, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdd: TEAC CD-W552E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
IRQ#14 thread RT prio: 48.
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, 
UDMA(100)
hda: cache flushes supported
  hda: hda1 hda2 < hda5 hda6 hda7 hda8 > hda3
hdb: max request size: 128KiB
hdb: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
hdb: cache flushes not supported
  hdb: hdb1
mice: PS/2 mouse device common for all mice
IRQ#12 thread RT prio: 47.
IRQ#1 thread RT prio: 46.
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 256 buckets, 40Kbytes
TCP: Hash tables configured (established 8192 bind 13107)
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices:
PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
Adding 995988k swap on /dev/hda6.  Priority:2 extents:1
EXT3 FS on hda8, internal journal
IRQ#8 thread RT prio: 45.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 456 bytes per conntrack
Capability LSM initialized
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M @ 0xe4000000
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
SCSI subsystem initialized
libata version 1.02 loaded.
sata_via version 0.20
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB000 irq 20
ata2: SATA max UDMA/133 cmd 0xB800 ctl 0xB402 bmdma 0xB008 irq 20
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0xc800
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 5
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 0xd000
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 0xd400
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 5
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#4)
uhci_hcd 0000:00:10.3: irq 21, io base 0xd800
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 21, pci mem 0xfbc00000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
NET: Registered protocol family 17
IRQ#4 thread RT prio: 44.
IRQ#3 thread RT prio: 43.
ACPI: Processor [CPU1] (supports C1)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
BUG: semaphore recursion deadlock detected!
.. current task firefox-bin/4761 [f21a3020] is already holding c04306c0 
[w:f21a3020, d:1].
  [<c01c7408>] __rwsem_deadlock+0x188/0x1a0 (12)
  [<c01c72ec>] __rwsem_deadlock+0x6c/0x1a0 (52)
  [<c0271c51>] dev_queue_xmit_nit+0x41/0x130 (24)
  [<c02cb9ee>] down_write_mutex+0x5e/0x210 (4)
  [<c02cba8e>] down_write_mutex+0xfe/0x210 (24)
  [<c02cbba8>] down_read_mutex+0x8/0x30 (12)
  [<c0271c51>] dev_queue_xmit_nit+0x41/0x130 (40)
  [<c01c7abe>] up_write_mutex+0x2e/0x60 (12)
  [<c0281403>] qdisc_restart+0x223/0x250 (24)
  [<c02721dd>] dev_queue_xmit+0x1ad/0x260 (12)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c02721ef>] dev_queue_xmit+0x1bf/0x260 (36)
  [<c027852e>] neigh_resolve_output+0xfe/0x240 (32)
  [<c029323e>] ip_finish_output2+0xbe/0x240 (56)
  [<c027dc05>] nf_hook_slow+0xd5/0x130 (36)
  [<c0293180>] ip_finish_output2+0x0/0x240 (28)
  [<c0290a4b>] ip_finish_output+0x26b/0x270 (32)
  [<c0293180>] ip_finish_output2+0x0/0x240 (24)
  [<c029316a>] dst_output+0x1a/0x30 (32)
  [<c027dc05>] nf_hook_slow+0xd5/0x130 (12)
  [<c0293150>] dst_output+0x0/0x30 (28)
  [<c029110a>] ip_queue_xmit+0x45a/0x570 (32)
  [<c0293150>] dst_output+0x0/0x30 (24)
  [<c0135cb5>] sub_preempt_count+0x65/0xd0 (36)
  [<c01c791e>] __up_write+0x10e/0x220 (8)
  [<c0135748>] check_preempt_timing+0x58/0x2e0 (8)
  [<c0135cb5>] sub_preempt_count+0x65/0xd0 (4)
  [<c01c791e>] __up_write+0x10e/0x220 (4)
  [<c0134fdd>] __mcount+0x1d/0x20 (28)
  [<c01c715e>] rwsem_owner_del+0xe/0xf0 (4)
  [<c0134fdd>] __mcount+0x1d/0x20 (40)
  [<c02a871e>] tcp_v4_send_check+0xe/0xf0 (4)
  [<c02a2219>] tcp_transmit_skb+0x439/0x880 (4)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c02a875f>] tcp_v4_send_check+0x4f/0xf0 (20)
  [<c02a22c2>] tcp_transmit_skb+0x4e2/0x880 (32)
  [<c0114310>] mcount+0x14/0x18 (28)
  [<c02a4f56>] tcp_send_ack+0xa6/0xf0 (52)
  [<c029feb4>] __tcp_ack_snd_check+0x14/0xa0 (12)
  [<c02a0965>] tcp_rcv_established+0x6e5/0x920 (24)
  [<c02a9c0e>] tcp_v4_do_rcv+0x13e/0x150 (56)
  [<c026b065>] __release_sock+0x55/0x80 (32)
  [<c026b98e>] release_sock+0x7e/0x80 (32)
  [<c0297c94>] tcp_recvmsg+0x2f4/0x750 (24)
  [<c0114310>] mcount+0x14/0x18 (64)
  [<c026bb19>] sock_common_recvmsg+0x59/0x70 (20)
  [<c0267da1>] sock_recvmsg+0xd1/0xf0 (48)
  [<c01c791e>] __up_write+0x10e/0x220 (24)
  [<c0134fdd>] __mcount+0x1d/0x20 (44)
  [<c01c715e>] rwsem_owner_del+0xe/0xf0 (4)
  [<c015f959>] fget+0x59/0x70 (72)
  [<c01c7abe>] up_write_mutex+0x2e/0x60 (28)
  [<c01344e0>] autoremove_wake_function+0x0/0x60 (24)
  [<c026798f>] sockfd_lookup+0x1f/0x80 (28)
  [<c0114310>] mcount+0x14/0x18 (4)
  [<c0269409>] sys_recvfrom+0x99/0x100 (20)
  [<c01426f2>] free_pages_bulk+0x1d2/0x2e0 (48)
  [<c01c7abe>] up_write_mutex+0x2e/0x60 (28)
  [<c0114310>] mcount+0x14/0x18 (112)
  [<c02694ab>] sys_recv+0x3b/0x40 (20)
  [<c0269be2>] sys_socketcall+0x152/0x240 (32)
  [<c010527b>] syscall_call+0x7/0xb (68)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: down_write_mutex+0x201/0x210 [<c02cbb91>] / 
(dev_queue_xmit_nit+0x41/0x130 [<c0271c51>])
.. entry 2: print_traces+0x1d/0x90 [<c013600d>] / (dump_stack+0x23/0x30 
[<c01060b3>])

BUG: circular semaphore deadlock: ksoftirqd/0/2 is blocked on c04306c0, 
deadlocking firefox-bin/4761
f7c2be24 00000046 f7c24020 c03bfca0 00000202 00001dd8 f7c2a000 f7c24020
        00000000 f7c2be10 000002c5 03c4f81b 00000029 f7c24020 f7c242b4 
f7c2a000
        f7c24020 00000000 f7c2be48 c02ca7af f7c2be48 00000082 c03e3a40 
c02cbb1e
Call Trace:
  [<c02ca7af>] schedule+0x2f/0xe0 (80)
  [<c02cbb1e>] down_write_mutex+0x18e/0x210 (16)
  [<c02cbadd>] down_write_mutex+0x14d/0x210 (20)
  [<c02cbba8>] down_read_mutex+0x8/0x30 (12)
  [<c027db57>] nf_hook_slow+0x27/0x130 (40)
  [<c0134fdd>] __mcount+0x1d/0x20 (24)
  [<c028d4ae>] ip_rcv+0xe/0x540 (4)
  [<c027270d>] netif_receive_skb+0x12d/0x240 (4)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c028d900>] ip_rcv+0x460/0x540 (20)
  [<c028db80>] ip_rcv_finish+0x0/0x300 (24)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c027270d>] netif_receive_skb+0x12d/0x240 (28)
  [<c0270008>] gnet_stats_copy_basic+0x18/0x80 (20)
  [<c0272a3f>] net_rx_action+0x7f/0x1a0 (4)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c02728a8>] process_backlog+0x88/0x1a0 (20)
  [<c0272a3f>] net_rx_action+0x7f/0x1a0 (40)
  [<c0123807>] ___do_softirq+0x87/0xd0 (36)
  [<c01238d8>] _do_softirq+0x8/0x30 (8)
  [<c0123cc4>] ksoftirqd+0xb4/0x100 (4)
  [<c01238f0>] _do_softirq+0x20/0x30 (28)
  [<c0123cc4>] ksoftirqd+0xb4/0x100 (8)
  [<c0133f2a>] kthread+0xaa/0xb0 (24)
  [<c0123c10>] ksoftirqd+0x0/0x100 (20)
  [<c0133e80>] kthread+0x0/0xb0 (12)
  [<c0103319>] kernel_thread_helper+0x5/0xc (16)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __schedule+0x4e/0x640 [<c02ca18e>] / (schedule+0x2f/0xe0 
[<c02ca7af>])
.. entry 2: __schedule+0xdd/0x640 [<c02ca21d>] / (schedule+0x2f/0xe0 
[<c02ca7af>])


Michal

--------------050902020206010505090700
Content-Type: text/plain;
 name="V0.3.2-deadlock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="V0.3.2-deadlock"

Linux version 2.6.9-mm1-RT-V0.3.2 (michich@k4-912b) (gcc version 3.3.4 (Debian 1:3.3.4-6sarge1)) #5 Wed Oct 27 12:26:13 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fa840
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000417 MSFT 0x00000097) @ 0x3ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x06000417 MSFT 0x00000097) @ 0x3ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x06000417 MSFT 0x00000097) @ 0x3ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000417 MSFT 0x00000097) @ 0x3ffc0040
ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:7 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=Deb-32-RT ro root=308 netconsole=4444@147.229.222.29/eth0,4444@147.229.222.28/00:0C:6E:2F:30:75
netconsole: local port 4444
netconsole: local IP 147.229.222.29
netconsole: interface eth0
netconsole: remote port 4444
netconsole: remote IP 147.229.222.28
netconsole: remote ethernet address 00:0c:6e:2f:30:75
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2403.782 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x30
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 905628k/917504k available (1843k kernel code, 11488k reserved, 786k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4702.20 BogoMIPS (lpj=2351104)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
CPU: After vendor identify, caps:  078bfbff e1d3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: After all inits, caps:        078bfbff e1d3fbff 00000000 00000010
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) 64 FX-53 Processor stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
desched thread 0 started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Initializing Cryptographic API
Real Time Clock Driver v1.12
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears flaky, waiting 10 seconds
IRQ#17 thread RT prio: 49.
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    scatter-gather:  enabled
netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
hda: ST3120026A, ATA DISK drive
hdb: ST320011A, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdd: TEAC CD-W552E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
IRQ#14 thread RT prio: 48.
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 > hda3
hdb: max request size: 128KiB
hdb: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
hdb: cache flushes not supported
 hdb: hdb1
mice: PS/2 mouse device common for all mice
IRQ#12 thread RT prio: 47.
IRQ#1 thread RT prio: 46.
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 256 buckets, 40Kbytes
TCP: Hash tables configured (established 8192 bind 13107)
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB 
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
Adding 995988k swap on /dev/hda6.  Priority:2 extents:1
EXT3 FS on hda8, internal journal
IRQ#8 thread RT prio: 45.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 456 bytes per conntrack
Capability LSM initialized
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M @ 0xe4000000
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
SCSI subsystem initialized
libata version 1.02 loaded.
sata_via version 0.20
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB000 irq 20
ata2: SATA max UDMA/133 cmd 0xB800 ctl 0xB402 bmdma 0xB008 irq 20
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0xc800
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 5
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 0xd000
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 0xd400
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 5
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.3: irq 21, io base 0xd800
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 21, pci mem 0xfbc00000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
NET: Registered protocol family 17
IRQ#4 thread RT prio: 44.
IRQ#3 thread RT prio: 43.
ACPI: Processor [CPU1] (supports C1)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
BUG: semaphore recursion deadlock detected!
.. current task firefox-bin/4761 [f21a3020] is already holding c04306c0 [w:f21a3020, d:1].
 [<c01c7408>] __rwsem_deadlock+0x188/0x1a0 (12)
 [<c01c72ec>] __rwsem_deadlock+0x6c/0x1a0 (52)
 [<c0271c51>] dev_queue_xmit_nit+0x41/0x130 (24)
 [<c02cb9ee>] down_write_mutex+0x5e/0x210 (4)
 [<c02cba8e>] down_write_mutex+0xfe/0x210 (24)
 [<c02cbba8>] down_read_mutex+0x8/0x30 (12)
 [<c0271c51>] dev_queue_xmit_nit+0x41/0x130 (40)
 [<c01c7abe>] up_write_mutex+0x2e/0x60 (12)
 [<c0281403>] qdisc_restart+0x223/0x250 (24)
 [<c02721dd>] dev_queue_xmit+0x1ad/0x260 (12)
 [<c0114310>] mcount+0x14/0x18 (8)
 [<c02721ef>] dev_queue_xmit+0x1bf/0x260 (36)
 [<c027852e>] neigh_resolve_output+0xfe/0x240 (32)
 [<c029323e>] ip_finish_output2+0xbe/0x240 (56)
 [<c027dc05>] nf_hook_slow+0xd5/0x130 (36)
 [<c0293180>] ip_finish_output2+0x0/0x240 (28)
 [<c0290a4b>] ip_finish_output+0x26b/0x270 (32)
 [<c0293180>] ip_finish_output2+0x0/0x240 (24)
 [<c029316a>] dst_output+0x1a/0x30 (32)
 [<c027dc05>] nf_hook_slow+0xd5/0x130 (12)
 [<c0293150>] dst_output+0x0/0x30 (28)
 [<c029110a>] ip_queue_xmit+0x45a/0x570 (32)
 [<c0293150>] dst_output+0x0/0x30 (24)
 [<c0135cb5>] sub_preempt_count+0x65/0xd0 (36)
 [<c01c791e>] __up_write+0x10e/0x220 (8)
 [<c0135748>] check_preempt_timing+0x58/0x2e0 (8)
 [<c0135cb5>] sub_preempt_count+0x65/0xd0 (4)
 [<c01c791e>] __up_write+0x10e/0x220 (4)
 [<c0134fdd>] __mcount+0x1d/0x20 (28)
 [<c01c715e>] rwsem_owner_del+0xe/0xf0 (4)
 [<c0134fdd>] __mcount+0x1d/0x20 (40)
 [<c02a871e>] tcp_v4_send_check+0xe/0xf0 (4)
 [<c02a2219>] tcp_transmit_skb+0x439/0x880 (4)
 [<c0114310>] mcount+0x14/0x18 (8)
 [<c02a875f>] tcp_v4_send_check+0x4f/0xf0 (20)
 [<c02a22c2>] tcp_transmit_skb+0x4e2/0x880 (32)
 [<c0114310>] mcount+0x14/0x18 (28)
 [<c02a4f56>] tcp_send_ack+0xa6/0xf0 (52)
 [<c029feb4>] __tcp_ack_snd_check+0x14/0xa0 (12)
 [<c02a0965>] tcp_rcv_established+0x6e5/0x920 (24)
 [<c02a9c0e>] tcp_v4_do_rcv+0x13e/0x150 (56)
 [<c026b065>] __release_sock+0x55/0x80 (32)
 [<c026b98e>] release_sock+0x7e/0x80 (32)
 [<c0297c94>] tcp_recvmsg+0x2f4/0x750 (24)
 [<c0114310>] mcount+0x14/0x18 (64)
 [<c026bb19>] sock_common_recvmsg+0x59/0x70 (20)
 [<c0267da1>] sock_recvmsg+0xd1/0xf0 (48)
 [<c01c791e>] __up_write+0x10e/0x220 (24)
 [<c0134fdd>] __mcount+0x1d/0x20 (44)
 [<c01c715e>] rwsem_owner_del+0xe/0xf0 (4)
 [<c015f959>] fget+0x59/0x70 (72)
 [<c01c7abe>] up_write_mutex+0x2e/0x60 (28)
 [<c01344e0>] autoremove_wake_function+0x0/0x60 (24)
 [<c026798f>] sockfd_lookup+0x1f/0x80 (28)
 [<c0114310>] mcount+0x14/0x18 (4)
 [<c0269409>] sys_recvfrom+0x99/0x100 (20)
 [<c01426f2>] free_pages_bulk+0x1d2/0x2e0 (48)
 [<c01c7abe>] up_write_mutex+0x2e/0x60 (28)
 [<c0114310>] mcount+0x14/0x18 (112)
 [<c02694ab>] sys_recv+0x3b/0x40 (20)
 [<c0269be2>] sys_socketcall+0x152/0x240 (32)
 [<c010527b>] syscall_call+0x7/0xb (68)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: down_write_mutex+0x201/0x210 [<c02cbb91>] / (dev_queue_xmit_nit+0x41/0x130 [<c0271c51>])
.. entry 2: print_traces+0x1d/0x90 [<c013600d>] / (dump_stack+0x23/0x30 [<c01060b3>])

BUG: circular semaphore deadlock: ksoftirqd/0/2 is blocked on c04306c0, deadlocking firefox-bin/4761
f7c2be24 00000046 f7c24020 c03bfca0 00000202 00001dd8 f7c2a000 f7c24020 
       00000000 f7c2be10 000002c5 03c4f81b 00000029 f7c24020 f7c242b4 f7c2a000 
       f7c24020 00000000 f7c2be48 c02ca7af f7c2be48 00000082 c03e3a40 c02cbb1e 
Call Trace:
 [<c02ca7af>] schedule+0x2f/0xe0 (80)
 [<c02cbb1e>] down_write_mutex+0x18e/0x210 (16)
 [<c02cbadd>] down_write_mutex+0x14d/0x210 (20)
 [<c02cbba8>] down_read_mutex+0x8/0x30 (12)
 [<c027db57>] nf_hook_slow+0x27/0x130 (40)
 [<c0134fdd>] __mcount+0x1d/0x20 (24)
 [<c028d4ae>] ip_rcv+0xe/0x540 (4)
 [<c027270d>] netif_receive_skb+0x12d/0x240 (4)
 [<c0114310>] mcount+0x14/0x18 (8)
 [<c028d900>] ip_rcv+0x460/0x540 (20)
 [<c028db80>] ip_rcv_finish+0x0/0x300 (24)
 [<c0114310>] mcount+0x14/0x18 (8)
 [<c027270d>] netif_receive_skb+0x12d/0x240 (28)
 [<c0270008>] gnet_stats_copy_basic+0x18/0x80 (20)
 [<c0272a3f>] net_rx_action+0x7f/0x1a0 (4)
 [<c0114310>] mcount+0x14/0x18 (8)
 [<c02728a8>] process_backlog+0x88/0x1a0 (20)
 [<c0272a3f>] net_rx_action+0x7f/0x1a0 (40)
 [<c0123807>] ___do_softirq+0x87/0xd0 (36)
 [<c01238d8>] _do_softirq+0x8/0x30 (8)
 [<c0123cc4>] ksoftirqd+0xb4/0x100 (4)
 [<c01238f0>] _do_softirq+0x20/0x30 (28)
 [<c0123cc4>] ksoftirqd+0xb4/0x100 (8)
 [<c0133f2a>] kthread+0xaa/0xb0 (24)
 [<c0123c10>] ksoftirqd+0x0/0x100 (20)
 [<c0133e80>] kthread+0x0/0xb0 (12)
 [<c0103319>] kernel_thread_helper+0x5/0xc (16)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __schedule+0x4e/0x640 [<c02ca18e>] / (schedule+0x2f/0xe0 [<c02ca7af>])
.. entry 2: __schedule+0xdd/0x640 [<c02ca21d>] / (schedule+0x2f/0xe0 [<c02ca7af>])


--------------050902020206010505090700--
