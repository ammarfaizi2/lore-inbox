Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264120AbUKZUeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbUKZUeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUKZUba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:31:30 -0500
Received: from mail.aknet.ru ([217.67.122.194]:58382 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S264030AbUKZUMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:12:43 -0500
Message-ID: <41A621DD.8060102@aknet.ru>
Date: Thu, 25 Nov 2004 21:18:05 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Shaohua Li <shaohua.li@intel.com>
Subject: Re: Fw: ACPI bug causes cd-rom lock-ups (2.6.10-rc2)
References: <41990138.7080008@aknet.ru> <1101190148.19999.394.camel@d845pe>	 <41A4CF1C.6090503@aknet.ru> <1101336267.20008.5326.camel@d845pe>
In-Reply-To: <1101336267.20008.5326.camel@d845pe>
Content-Type: multipart/mixed;
 boundary="------------070609030207000609030208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070609030207000609030208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Len Brown wrote:
> CONFIG_PNP_ACPI=n should workaround it too then, I expect.
Yes. Log attached.

> Please apply this debug patch to the failing kernel
> and send along the dmesg.
Done. Attached are 2 logs: one of
the functional kernel due to disabled
PNP_ACPI, another one of a broken.
Both are the -rc2-mm2 with your patch.


--------------070609030207000609030208
Content-Type: text/plain;
 name="dmesg-rc2-mm2-noacpipnp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-rc2-mm2-noacpipnp"

Linux version 2.6.10-rc2-mm2 (root@stas) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #13 SMP Thu Nov 25 09:19:00 MSK 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f75d0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
Kernel command line: ro root=/dev/hda12 lapic nmi_watchdog=2
CPU 0 irqstacks, hard=c042b000 soft=c0429000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1133.747 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515160k/524224k available (2153k kernel code, 8576k reserved, 849k data, 208k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2244.60 BogoMIPS (lpj=1122304)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
CPU0: Intel(R) Pentium(R) III CPU             1133MHz stepping 01
per-CPU timeslice cutoff: 731.79 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
testing NMI watchdog ... OK.
Brought up 1 CPUs
CPU0:
 domain 0: span 1
  groups: 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfafc0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Disabled by ACPI
PCI: Using ACPI for IRQ routing
ACPI enter init: 1000000 1000000 1000000 10000 10000 10000 10000 10000 10000 0 0 0 100000 100000 100000 100000 
ACPI exit init: 1000000 1000000 1000000 100C8 100C8 100C8 100C8 100C8 10000 1000 C8 C8 1000C8 100000 1000C8 1000C8 
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
fscache: general fs caching registered
CacheFS: general fs caching v0.1 registered
pnp: the driver 'system' has been registered
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1101374504.890:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: Thermal Zone [THRM] (25 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI allocate: 1000000 1000000 1000000 100C8 100C8 100C8 100C8 100C8 10000 1000 C8 C8 1000C8 100000 1000C8 1000C8 
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI allocated: 1000000 1000000 1000000 100C8 100C8 100C8 100C8 100C8 10000 1000 C8 10C8 1000C8 100000 1000C8 1000C8 
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ttyS4: detected caps 00000700 should be 00000100
ttyS4 at I/O 0xa000 (irq = 11) is a 16C950/954
ttyS5: detected caps 00000700 should be 00000100
ttyS5 at I/O 0xa400 (irq = 11) is a 16C950/954
pnp: the driver 'serial' has been registered
pnp: the driver 'parport_pc' has been registered
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Floppy Controller [FDC0] at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma channel 2
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
nbd: registered device at major 43
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 17
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: MAXTOR 6L040J2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15 >
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Please email the following PERFCTR INIT lines to mikpe@csd.uu.se
To remove this message, rebuild the driver with CONFIG_PERFCTR_INIT_TESTS=n
PERFCTR INIT: vendor 0, family 6, model 11, stepping 1, clock 1133747 kHz
PERFCTR INIT: NITER == 64
PERFCTR INIT: loop overhead is 222 cycles
PERFCTR INIT: rdtsc cost is 36.0 cycles (2526 total)
PERFCTR INIT: rdpmc cost is 35.8 cycles (2516 total)
PERFCTR INIT: rdmsr (counter) cost is 90.4 cycles (6008 total)
PERFCTR INIT: rdmsr (evntsel) cost is 71.9 cycles (4825 total)
PERFCTR INIT: wrmsr (counter) cost is 100.7 cycles (6669 total)
PERFCTR INIT: wrmsr (evntsel) cost is 96.1 cycles (6375 total)
PERFCTR INIT: read cr4 cost is 1.9 cycles (346 total)
PERFCTR INIT: write cr4 cost is 42.2 cycles (2928 total)
PERFCTR INIT: write LVTPC cost is 50.5 cycles (3455 total)
PERFCTR INIT: sync_core cost is 129.3 cycles (8500 total)
perfctr: driver 2.7.6, cpu type Intel P6 at 1133747 kHz
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 312 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
SLPB PCI0 HUB0 USB0 USB1 UAR1 UAR2 
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
CacheFS: Wrong magic number on cache
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
kjournald starting.  Commit interval 5 seconds
ibm_acpi: ec object not found
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI allocate: 1000000 1000000 1000000 100C8 100C8 100C8 100C8 100C8 10000 1000 C8 10C8 1000C8 100000 1000C8 1000C8 
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI allocated: 1000000 1000000 1000000 100C8 100C8 100C8 100C8 100C8 10000 1000 C8 20C8 1000C8 100000 1000C8 1000C8 
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 11, io base 0xd000
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI allocate: 1000000 1000000 1000000 100C8 100C8 100C8 100C8 100C8 10000 1000 C8 20C8 1000C8 100000 1000C8 1000C8 
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI allocated: 1000000 1000000 1000000 100C8 100C8 100C8 100C8 100C8 10000 1000 10C8 20C8 1000C8 100000 1000C8 1000C8 
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 10, io base 0xd400
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using uhci_hcd and address 2
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
EXT3 FS on hda12, internal journal
Adding 530104k swap on /dev/hda5.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda13, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
NTFS driver 2.1.23-WIP [Flags: R/W MODULE].
NTFS volume version 3.1.
  Vendor: JetFlash  Model: TS256MJF2A        Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: device scan complete
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:04.0: 3Com PCI 3c905C Tornado at 0xc000. Vers LK1.1.19
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
SCSI device sda: 512000 512-byte hdwr sectors (262 MB)
sda: Write Protect is off
sda: Mode Sense: 0b 00 00 08
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03b4fe0(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

--------------070609030207000609030208
Content-Type: text/plain;
 name="dmesg-rc2-mm2-debug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-rc2-mm2-debug"

Linux version 2.6.10-rc2-mm2 (root@stas) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #15 SMP Thu Nov 25 09:32:02 MSK 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f75d0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
Kernel command line: ro root=/dev/hda12 lapic nmi_watchdog=2
CPU 0 irqstacks, hard=c042c000 soft=c042a000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1133.307 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514772k/524224k available (2157k kernel code, 8964k reserved, 849k data, 208k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2244.60 BogoMIPS (lpj=1122304)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
CPU0: Intel(R) Pentium(R) III CPU             1133MHz stepping 01
per-CPU timeslice cutoff: 731.13 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
testing NMI watchdog ... OK.
Brought up 1 CPUs
CPU0:
 domain 0: span 1
  groups: 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfafc0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI isa: 1000000 1000000 1000000 10000 10000 10000 10000 10000 110000 0 0 0 100000 100000 100000 100000 
ACPI isa: 1000000 1000000 1000000 10000 10000 10000 10000 10000 110000 0 0 0 100000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 10000 10000 10000 110000 10000 110000 0 0 0 100000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 10000 10000 10000 210000 10000 110000 0 0 0 100000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 10000 110000 10000 210000 10000 110000 0 0 0 100000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 110000 110000 10000 210000 10000 110000 0 0 0 100000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 110000 210000 10000 210000 10000 110000 0 0 0 100000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 110000 210000 110000 210000 10000 110000 0 0 0 100000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 110000 210000 110000 210000 110000 110000 0 0 0 100000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 110000 210000 110000 210000 110000 110000 100000 0 0 100000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 110000 210000 110000 210000 110000 110000 100000 100000 0 100000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 110000 210000 110000 210000 110000 110000 100000 100000 100000 100000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 110000 210000 110000 210000 110000 110000 100000 100000 100000 200000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 210000 210000 110000 210000 110000 110000 100000 100000 100000 200000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 210000 310000 110000 210000 110000 110000 100000 100000 100000 200000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 210000 310000 210000 210000 110000 110000 100000 100000 100000 200000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 210000 310000 210000 210000 210000 110000 100000 100000 100000 200000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 210000 310000 210000 210000 210000 110000 200000 100000 100000 200000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 210000 310000 210000 210000 210000 110000 200000 200000 100000 200000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 210000 310000 210000 210000 210000 110000 200000 200000 200000 200000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 210000 310000 210000 210000 210000 110000 200000 200000 200000 300000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 310000 310000 210000 210000 210000 110000 200000 200000 200000 300000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 310000 410000 210000 210000 210000 110000 200000 200000 200000 300000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 310000 410000 310000 210000 210000 110000 200000 200000 200000 300000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 310000 410000 310000 210000 310000 110000 200000 200000 200000 300000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 310000 410000 310000 210000 310000 110000 300000 200000 200000 300000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 310000 410000 310000 210000 310000 110000 300000 300000 200000 300000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 310000 410000 310000 210000 310000 110000 300000 300000 300000 300000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 310000 410000 310000 210000 310000 110000 300000 300000 300000 400000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 410000 410000 310000 210000 310000 110000 300000 300000 300000 400000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 410000 510000 310000 210000 310000 110000 300000 300000 300000 400000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 410000 510000 410000 210000 310000 110000 300000 300000 300000 400000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 410000 510000 410000 210000 410000 110000 300000 300000 300000 400000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 410000 510000 410000 210000 410000 110000 400000 300000 300000 400000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 410000 510000 410000 210000 410000 110000 400000 400000 300000 400000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 410000 510000 410000 210000 410000 110000 400000 400000 400000 400000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 410000 510000 410000 210000 410000 110000 400000 400000 400000 500000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 510000 510000 410000 210000 410000 110000 400000 400000 400000 500000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 610000 510000 410000 210000 410000 110000 400000 400000 400000 500000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 610000 610000 410000 210000 410000 110000 400000 400000 400000 500000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 610000 610000 510000 210000 410000 110000 400000 400000 400000 500000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 610000 610000 510000 210000 510000 110000 400000 400000 400000 500000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 610000 610000 510000 210000 510000 110000 500000 400000 400000 500000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 610000 610000 510000 210000 510000 110000 500000 500000 400000 500000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 610000 610000 510000 210000 510000 110000 500000 500000 500000 500000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 610000 610000 510000 210000 510000 110000 500000 500000 500000 600000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 710000 610000 510000 210000 510000 110000 500000 500000 500000 600000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 710000 710000 510000 210000 510000 110000 500000 500000 500000 600000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 710000 710000 610000 210000 510000 110000 500000 500000 500000 600000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 710000 710000 610000 210000 610000 110000 500000 500000 500000 600000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 710000 710000 610000 210000 610000 110000 600000 500000 500000 600000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 710000 710000 610000 210000 610000 110000 600000 600000 500000 600000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 710000 710000 610000 210000 610000 110000 600000 600000 600000 600000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 710000 710000 610000 210000 610000 110000 600000 600000 600000 700000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 810000 710000 610000 210000 610000 110000 600000 600000 600000 700000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 810000 810000 610000 210000 610000 110000 600000 600000 600000 700000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 810000 810000 710000 210000 610000 110000 600000 600000 600000 700000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 810000 810000 710000 210000 710000 110000 600000 600000 600000 700000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 810000 810000 710000 210000 710000 110000 700000 600000 600000 700000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 810000 810000 710000 210000 710000 110000 700000 700000 600000 700000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 810000 810000 710000 210000 710000 110000 700000 700000 700000 700000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 810000 810000 710000 210000 710000 110000 700000 700000 700000 800000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 910000 810000 710000 210000 710000 110000 700000 700000 700000 800000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 910000 910000 710000 210000 710000 110000 700000 700000 700000 800000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 910000 910000 810000 210000 710000 110000 700000 700000 700000 800000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 910000 910000 810000 210000 810000 110000 700000 700000 700000 800000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 910000 910000 810000 210000 810000 110000 800000 700000 700000 800000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 910000 910000 810000 210000 810000 110000 800000 800000 700000 800000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 910000 910000 810000 210000 810000 110000 800000 800000 800000 800000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 910000 910000 810000 210000 810000 110000 800000 800000 800000 900000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 910000 910000 810000 210000 910000 110000 800000 800000 800000 900000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 A10000 910000 810000 210000 910000 110000 800000 800000 800000 900000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 A10000 A10000 810000 210000 910000 110000 800000 800000 800000 900000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 A10000 A10000 910000 210000 910000 110000 800000 800000 800000 900000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 A10000 A10000 910000 210000 A10000 110000 800000 800000 800000 900000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 A10000 A10000 910000 210000 A10000 110000 900000 800000 800000 900000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 A10000 A10000 910000 210000 A10000 110000 900000 900000 800000 900000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 A10000 A10000 910000 210000 A10000 110000 900000 900000 900000 900000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 A10000 A10000 910000 210000 A10000 110000 900000 900000 900000 A00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 B10000 A10000 910000 210000 A10000 110000 900000 900000 900000 A00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 B10000 B10000 910000 210000 A10000 110000 900000 900000 900000 A00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 B10000 B10000 A10000 210000 A10000 110000 900000 900000 900000 A00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 B10000 B10000 A10000 210000 B10000 110000 900000 900000 900000 A00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 B10000 B10000 A10000 210000 B10000 110000 A00000 900000 900000 A00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 B10000 B10000 A10000 210000 B10000 110000 A00000 A00000 900000 A00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 B10000 B10000 A10000 210000 B10000 110000 A00000 A00000 A00000 A00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 B10000 B10000 A10000 210000 B10000 110000 A00000 A00000 A00000 B00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 C10000 B10000 A10000 210000 B10000 110000 A00000 A00000 A00000 B00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 C10000 C10000 A10000 210000 B10000 110000 A00000 A00000 A00000 B00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 C10000 C10000 B10000 210000 B10000 110000 A00000 A00000 A00000 B00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 C10000 C10000 B10000 210000 C10000 110000 A00000 A00000 A00000 B00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 C10000 C10000 B10000 210000 C10000 110000 B00000 A00000 A00000 B00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 C10000 C10000 B10000 210000 C10000 110000 B00000 B00000 A00000 B00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 C10000 C10000 B10000 210000 C10000 110000 B00000 B00000 B00000 B00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 C10000 C10000 B10000 210000 C10000 110000 B00000 B00000 B00000 C00000 200000 100000 100000 
ACPI isa: 1000000 1000000 1000000 C10000 C10000 B10000 210000 C10000 110000 B00000 B00000 B00000 D00000 200000 100000 100000 
ACPI isa: 1000000 1100000 1000000 C10000 C10000 B10000 210000 C10000 110000 B00000 B00000 B00000 D00000 200000 100000 100000 
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI
PCI: Using ACPI for IRQ routing
ACPI enter init: 1000000 1100000 1000000 C10000 C10000 B10000 210000 C10000 110000 B00000 B00000 B00000 D00000 200000 100000 100000 
ACPI exit init: 1000000 1100000 1000000 C100C8 C100C8 B100C8 2100C8 C100C8 110000 B01000 B000C8 B000C8 D000C8 200000 1000C8 1000C8 
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
fscache: general fs caching registered
CacheFS: general fs caching v0.1 registered
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: match found with the PnP device '00:01' and the driver 'system'
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1101375251.930:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: Thermal Zone [THRM] (27 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI allocate: 1000000 1100000 1000000 C100C8 C100C8 B100C8 2100C8 C100C8 110000 B01000 B000C8 B000C8 D000C8 200000 1000C8 1000C8 
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI allocated: 1000000 1100000 1000000 C100C8 C100C8 B100C8 2100C8 C100C8 110000 B01000 B000C8 B010C8 D000C8 200000 1000C8 1000C8 
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ttyS4: detected caps 00000700 should be 00000100
ttyS4 at I/O 0xa000 (irq = 11) is a 16C950/954
ttyS5: detected caps 00000700 should be 00000100
ttyS5 at I/O 0xa400 (irq = 11) is a 16C950/954
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:07' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:08' and the driver 'serial'
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:09' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Floppy Controller [FDC0] at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma channel 2
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
nbd: registered device at major 43
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 17
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: MAXTOR 6L040J2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15 >
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Please email the following PERFCTR INIT lines to mikpe@csd.uu.se
To remove this message, rebuild the driver with CONFIG_PERFCTR_INIT_TESTS=n
PERFCTR INIT: vendor 0, family 6, model 11, stepping 1, clock 1133307 kHz
PERFCTR INIT: NITER == 64
PERFCTR INIT: loop overhead is 222 cycles
PERFCTR INIT: rdtsc cost is 36.1 cycles (2536 total)
PERFCTR INIT: rdpmc cost is 35.8 cycles (2516 total)
PERFCTR INIT: rdmsr (counter) cost is 90.4 cycles (6008 total)
PERFCTR INIT: rdmsr (evntsel) cost is 71.9 cycles (4825 total)
PERFCTR INIT: wrmsr (counter) cost is 100.7 cycles (6669 total)
PERFCTR INIT: wrmsr (evntsel) cost is 96.1 cycles (6375 total)
PERFCTR INIT: read cr4 cost is 1.9 cycles (346 total)
PERFCTR INIT: write cr4 cost is 42.2 cycles (2928 total)
PERFCTR INIT: write LVTPC cost is 50.6 cycles (3463 total)
PERFCTR INIT: sync_core cost is 129.3 cycles (8500 total)
perfctr: driver 2.7.6, cpu type Intel P6 at 1133307 kHz
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 312 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
SLPB PCI0 HUB0 USB0 USB1 UAR1 UAR2 
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
CacheFS: Wrong magic number on cache
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
kjournald starting.  Commit interval 5 seconds
ibm_acpi: ec object not found
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI allocate: 1000000 1100000 1000000 C100C8 C100C8 B100C8 2100C8 C100C8 110000 B01000 B000C8 B010C8 D000C8 200000 1000C8 1000C8 
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI allocated: 1000000 1100000 1000000 C100C8 C100C8 B100C8 2100C8 C100C8 110000 B01000 B000C8 B020C8 D000C8 200000 1000C8 1000C8 
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 11, io base 0xd000
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI allocate: 1000000 1100000 1000000 C100C8 C100C8 B100C8 2100C8 C100C8 110000 B01000 B000C8 B020C8 D000C8 200000 1000C8 1000C8 
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 15
ACPI allocated: 1000000 1100000 1000000 C100C8 C100C8 B100C8 2100C8 C100C8 110000 B01000 B000C8 B020C8 D000C8 200000 1000C8 1010C8 
PCI: setting IRQ 15 as level-triggered
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 15 (level, low) -> IRQ 15
uhci_hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 15, io base 0xd400
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
usb 1-1: new full speed USB device using uhci_hcd and address 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
EXT3 FS on hda12, internal journal
Adding 530104k swap on /dev/hda5.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda13, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
NTFS driver 2.1.23-WIP [Flags: R/W MODULE].
NTFS volume version 3.1.
  Vendor: JetFlash  Model: TS256MJF2A        Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: device scan complete
SCSI device sda: 512000 512-byte hdwr sectors (262 MB)
sda: Write Protect is off
sda: Mode Sense: 0b 00 00 08
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:04.0: 3Com PCI 3c905C Tornado at 0xc000. Vers LK1.1.19
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03b60e0(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
hdc: lost interrupt

--------------070609030207000609030208--
