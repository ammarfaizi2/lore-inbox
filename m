Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWFLRfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWFLRfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWFLRfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:35:39 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:22960 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751038AbWFLRfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:35:37 -0400
Message-ID: <448DA5DD.203@fr.ibm.com>
Date: Mon, 12 Jun 2006 19:35:25 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
References: <20060609214024.2f7dd72c.akpm@osdl.org>
In-Reply-To: <20060609214024.2f7dd72c.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------070705010100090103090700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070705010100090103090700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/

I got a oops :

Unable to handle kernel NULL pointer dereference at 0000000000000007 RIP:
 [<ffffffff8025b017>] dec_zone_page_state+0x1/0x5b
PGD 13d6c7067 PUD 13de23067 PMD 0
Oops: 0000 [1] SMP
last sysfs file: /class/vc/vcsa4/dev
CPU 0
Modules linked in: autofs4 nfs lockd sunrpc joydev sony_acpi button battery
ac uhci_hcd ehci_hcd tg3 sg ext3 jbd ata_piix libataPid: 2409, comm:
rpciod/0 Not tainted 2.6.17-rc6-mm2 #1
RIP: 0010:[<ffffffff8025b017>]  [<ffffffff8025b017>]
dec_zone_page_state+0x1/0x5b
RSP: 0018:ffff81013f2c3da8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff81013d09d570 RCX: 0000000000000206
RDX: ffff810001029260 RSI: 0000000000000007 RDI: 0000000000000000
RBP: ffff81013f2c3dd8 R08: 0000000300000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff81013f57e338
R13: ffff81013f57e340 R14: 0000000000000287 R15: ffff81013f57e340
FS:  0000000000000000(0000) GS:ffffffff807f9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000007 CR3: 000000013d143000 CR4: 00000000000006e0
Process rpciod/0 (pid: 2409, threadinfo ffff81013f2c2000, task
ffff8101406e2080)
Stack:  ffff81013f2c3dd8 ffffffff880eab1b 0000000000000000 ffff81013f57e340
 ffff81013f57e410 0000000000000000 ffff81013f2c3df8 ffffffff880a5a51
 ffff81013f57e340 ffff81013f57e340
Call Trace:
 [<ffffffff880eab1b>] :nfs:nfs_commit_done+0x188/0x196
 [<ffffffff880a5a51>] :sunrpc:rpc_exit_task+0x2a/0x6c
 [<ffffffff880a5f98>] :sunrpc:__rpc_execute+0x99/0x1e0
 [<ffffffff880a60e8>] :sunrpc:rpc_async_schedule+0x9/0xb
 [<ffffffff8023c72e>] run_workqueue+0xa8/0xef
 [<ffffffff880a60df>] :sunrpc:rpc_async_schedule+0x0/0xb
 [<ffffffff8023c775>] worker_thread+0x0/0x12f
 [<ffffffff8023c871>] worker_thread+0xfc/0x12f
 [<ffffffff80225eca>] default_wake_function+0x0/0xf
 [<ffffffff80225eca>] default_wake_function+0x0/0xf
 [<ffffffff8023c775>] worker_thread+0x0/0x12f
 [<ffffffff8023f92c>] kthread+0xd0/0xfc
 [<ffffffff8020a33a>] child_rip+0x8/0x12
 [<ffffffff8023f85c>] kthread+0x0/0xfc
 [<ffffffff8020a332>] child_rip+0x0/0x12


Code: 48 0f b6 47 07 48 89 e5 4c 8b 0c c5 80 2b 80 80 9c 41 58 fa
RIP  [<ffffffff8025b017>] dec_zone_page_state+0x1/0x5b
 RSP <ffff81013f2c3da8>
CR2: 0000000000000007




dmesg and config follow.

thanks,

C.

--------------070705010100090103090700
Content-Type: text/plain;
 name="2.6.17-rc6-mm2.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.17-rc6-mm2.dmesg"

ogoMIPS (lpj=11201315)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
APIC error on CPU1: 00(40)
lockdep: not fixing up alternatives.
Booting processor 2/4 APIC 0x1
Initializing CPU#2
lockdep: disabled NMI watchdog.
Calibrating delay using timer specific routine.. 5600.60 BogoMIPS (lpj=11201218)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU2: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
APIC error on CPU2: 00(40)
lockdep: not fixing up alternatives.
Booting processor 3/4 APIC 0x7
Initializing CPU#3
lockdep: disabled NMI watchdog.
Calibrating delay using timer specific routine.. 5600.77 BogoMIPS (lpj=11201543)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU3: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
APIC error on CPU3: 00(40)
Brought up 4 CPUs
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 2800.169 MHz processor.
migration_cost=3,866
checking if image is initramfs... it is
Freeing initrd memory: 868k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Subsystem revision 20060310
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0580-05ff claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0400-043f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:01:01.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4.PCI3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIS._PRT]
ACPI: PCI Interrupt Link [LP00] (IRQs *11)
ACPI: PCI Interrupt Link [LP01] (IRQs *3)
ACPI Warning (pci_link-0117): Blank IRQ resource [20060310]
ACPI Error (pci_link-0162): Resource is not an IRQ entry
 [20060310]
ACPI: PCI Interrupt Link [LP02] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP03] (IRQs *3)
ACPI Warning (pci_link-0117): Blank IRQ resource [20060310]
ACPI Error (pci_link-0162): Resource is not an IRQ entry
 [20060310]
ACPI: PCI Interrupt Link [LP04] (IRQs) *0, disabled.
ACPI Warning (pci_link-0117): Blank IRQ resource [20060310]
ACPI Error (pci_link-0162): Resource is not an IRQ entry
 [20060310]
ACPI: PCI Interrupt Link [LP05] (IRQs) *0, disabled.
ACPI Warning (pci_link-0117): Blank IRQ resource [20060310]
ACPI Error (pci_link-0162): Resource is not an IRQ entry
 [20060310]
ACPI: PCI Interrupt Link [LP06] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP07] (IRQs *5)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 1 of device 0000:00:00.0
PCI-GART: No AMD northbridge found.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:03:00.0
  IO window: 4000-4fff
  MEM window: dd000000-deffffff
  PREFETCH window: df000000-df0fffff
PCI: Bridge: 0000:03:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: 4000-4fff
  MEM window: dd000000-deffffff
  PREFETCH window: df000000-df0fffff
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: db000000-dcffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: 5000-ffff
  MEM window: d9000000-daffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: f8000000-f8ffffff
  PREFETCH window: f0000000-f7ffffff
ACPI (acpi_bus-0192): Device [PCI1] is not power manageable [20060310]
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI (acpi_bus-0192): Device [PCI4] is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:04.0 to 64
ACPI (acpi_bus-0192): Device [PCI2] is not power manageable [20060310]
PCI: Setting latency timer of device 0000:03:00.0 to 64
ACPI (acpi_bus-0192): Device [PCI3] is not power manageable [20060310]
PCI: Setting latency timer of device 0000:03:00.2 to 64
ACPI (acpi_bus-0192): Device [PCI5] is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI (acpi_bus-0192): Device [PCI6] is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:07.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1150129903.284:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
ipmi message handler version 39.0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: HL-DT-STDVD-ROM GDR8083N, ATAPI CD/DVD-ROM drive
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.20
Fusion MPT base driver 3.03.09
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.09
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 28 (level, low) -> IRQ 177
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
scsi0 : ioc0: LSI53C1030, FwRev=01032821h, Ports=1, MaxQ=222, IRQ=177
  Vendor: IBM-ESXS  Model: MAT3073NC     FN  Rev: B414
  Type:   Direct-Access                      ANSI SCSI revision: 04
 target0:0:0: Beginning Domain Validation
 target0:0:0: Ending Domain Validation
 target0:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI WRFLOW PCOMP (6.25 ns, offset 127)
SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 00 08
SCSI device sda: drive cache: write through
SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 00 08
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
  Vendor: IBM       Model: 25P3495a S320  1  Rev: 1   
  Type:   Processor                          ANSI SCSI revision: 02
 target0:0:8: Beginning Domain Validation
 target0:0:8: Ending Domain Validation
 target0:0:8: asynchronous
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
/home/legoater/linux/2.6.17-rc6-mm2/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 232k freed
libata version 1.30 loaded.
ata_piix 0000:00:1f.2: version 1.10
ata_piix 0000:00:1f.2: MAP [ IDE IDE P0 P1 ]
ACPI Warning (pci_irq-0370): Unable to derive IRQ for device 0000:00:1f.2 [20060310]
ACPI: PCI Interrupt 0000:00:1f.2[A]: no GSI
ata: 0x1f0 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x488 irq 15
ata1: ENTER, pcs=0x3 base=2
ata1: LEAVE, pcs=0x0 present_mask=0x0
ata1: SATA port has no device.
scsi1 : ata_piix
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
sd 0:0:0:0: Attached scsi generic sg0 type 0
 0:0:8:0: Attached scsi generic sg1 type 3
tg3.c:v3.59 (May 26, 2006)
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:06:00.0 to 64
eth0: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:14:5e:0b:37:68
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:07:00.0 to 64
eth1: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:14:5e:0b:37:69
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[1] 
eth1: dma_rwctrl[76180000] dma_mask[64-bit]
ACPI (acpi_bus-0192): Device [USB4] is not power manageable [20060310]
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 185, io mem 0xf9000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-rc6-mm2 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 169, io base 0x00002200
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17-rc6-mm2 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 193, io base 0x00002600
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17-rc6-mm2 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: new device found, idVendor=04b3, idProduct=4001
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-1: Product: PPC I/F
usb 3-1: Manufacturer: IBM
usb 3-1: SerialNumber: 000d60479cf5
usb 3-1: configuration #1 chosen from 1 choice
input: IBM PPC I/F as /class/input/input0
input: USB HID v1.10 Keyboard [IBM PPC I/F] on usb-0000:00:1d.1-1
input: IBM PPC I/F as /class/input/input1
input: USB HID v1.10 Mouse [IBM PPC I/F] on usb-0000:00:1d.1-1
ACPI: Power Button (FF) [PWRF]
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1052248k swap on /dev/sda3.  Priority:-1 extents:1 across:1052248k
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
Unable to handle kernel NULL pointer dereference at 0000000000000007 RIP: 
 [<ffffffff8025b017>] dec_zone_page_state+0x1/0x5b
PGD 13d6c7067 PUD 13de23067 PMD 0 
Oops: 0000 [1] SMP 
last sysfs file: /class/vc/vcsa4/dev
CPU 0 
Modules linked in: autofs4 nfs lockd sunrpc joydev sony_acpi button battery ac uhci_hcd ehci_hcd tg3 sg ext3 jbd ata_piix libata
Pid: 2409, comm: rpciod/0 Not tainted 2.6.17-rc6-mm2 #1
RIP: 0010:[<ffffffff8025b017>]  [<ffffffff8025b017>] dec_zone_page_state+0x1/0x5b
RSP: 0018:ffff81013f2c3da8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff81013d09d570 RCX: 0000000000000206
RDX: ffff810001029260 RSI: 0000000000000007 RDI: 0000000000000000
RBP: ffff81013f2c3dd8 R08: 0000000300000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff81013f57e338
R13: ffff81013f57e340 R14: 0000000000000287 R15: ffff81013f57e340
FS:  0000000000000000(0000) GS:ffffffff807f9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000007 CR3: 000000013d143000 CR4: 00000000000006e0
Process rpciod/0 (pid: 2409, threadinfo ffff81013f2c2000, task ffff8101406e2080)
Stack:  ffff81013f2c3dd8 ffffffff880eab1b 0000000000000000 ffff81013f57e340
 ffff81013f57e410 0000000000000000 ffff81013f2c3df8 ffffffff880a5a51
 ffff81013f57e340 ffff81013f57e340
Call Trace:
 [<ffffffff880eab1b>] :nfs:nfs_commit_done+0x188/0x196
 [<ffffffff880a5a51>] :sunrpc:rpc_exit_task+0x2a/0x6c
 [<ffffffff880a5f98>] :sunrpc:__rpc_execute+0x99/0x1e0
 [<ffffffff880a60e8>] :sunrpc:rpc_async_schedule+0x9/0xb
 [<ffffffff8023c72e>] run_workqueue+0xa8/0xef
 [<ffffffff880a60df>] :sunrpc:rpc_async_schedule+0x0/0xb
 [<ffffffff8023c775>] worker_thread+0x0/0x12f
 [<ffffffff8023c871>] worker_thread+0xfc/0x12f
 [<ffffffff80225eca>] default_wake_function+0x0/0xf
 [<ffffffff80225eca>] default_wake_function+0x0/0xf
 [<ffffffff8023c775>] worker_thread+0x0/0x12f
 [<ffffffff8023f92c>] kthread+0xd0/0xfc
 [<ffffffff8020a33a>] child_rip+0x8/0x12
 [<ffffffff8023f85c>] kthread+0x0/0xfc
 [<ffffffff8020a332>] child_rip+0x0/0x12


Code: 48 0f b6 47 07 48 89 e5 4c 8b 0c c5 80 2b 80 80 9c 41 58 fa 
RIP  [<ffffffff8025b017>] dec_zone_page_state+0x1/0x5b
 RSP <ffff81013f2c3da8>
CR2: 0000000000000007
 

--------------070705010100090103090700
Content-Type: text/plain;
 name="2.6.17-rc6-mm2.config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.17-rc6-mm2.config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.17-rc6-mm2
# Mon Jun 12 17:10:05 2006
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SWAP_PREFETCH=y
CONFIG_SYSVIPC=y
CONFIG_IPC_NS=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_SYSCTL=y
CONFIG_UTS_NS=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
# CONFIG_IKCONFIG is not set
# CONFIG_CPUSETS is not set
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_KLIBC_ERRLIST=y
CONFIG_KLIBC_ZLIB=y
CONFIG_UID16=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_RT_MUTEXES=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set
CONFIG_VM_EVENT_COUNTERS=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
CONFIG_LBD=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VSMP is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_L1_CACHE_BYTES=128
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_INTERNODE_CACHE_BYTES=128
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_HT=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
CONFIG_NUMA=y
CONFIG_K8_NUMA=y
CONFIG_NODES_SHIFT=6
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_DISCONTIGMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MIGRATION=y
CONFIG_UNALIGNED_ZONE_BOUNDARIES=y
CONFIG_ADAPTIVE_READAHEAD=y
CONFIG_DEBUG_READAHEAD=y
# CONFIG_READAHEAD_SMOOTH_AGING is not set
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_OUT_OF_LINE_PFN_TO_PAGE=y
CONFIG_NR_CPUS=8
# CONFIG_HOTPLUG_CPU is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_IOMMU=y
CONFIG_CALGARY_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x200000
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_REORDER is not set
CONFIG_K8_NB=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_ATLAS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_SONY=m
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_FWMARK is not set
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_INITRD=y
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
# CONFIG_SCSI_TGT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_DOMAIN_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=m
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_PATA_ALI is not set
# CONFIG_SCSI_PATA_AMD is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_PATA_TRIFLEX is not set
# CONFIG_SCSI_PATA_MPIIX is not set
# CONFIG_SCSI_PATA_OLDPIIX is not set
CONFIG_SCSI_ATA_PIIX=m
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_PATA_NETCELL is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_PATA_OPTI is not set
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_PATA_PDC2027X is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_PATA_SIL680 is not set
# CONFIG_SCSI_PATA_SIS is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_PATA_VIA is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_SATA_INTEL_COMBINED=y
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_CTL is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
CONFIG_TIGON3=m
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=m
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
CONFIG_NETPOLL_TRAP=y
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_EFFECTS is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_SI is not set
# CONFIG_IPMI_WATCHDOG is not set
# CONFIG_IPMI_POWEROFF is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#
CONFIG_IBM_ASM=m

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
CONFIG_VIDEO_V4L2=y

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=y
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
# CONFIG_VIDEO_SELECT is not set
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE is not set

#
# Logo configuration
#
# CONFIG_LOGO is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=y

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_GOTEMP is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set
# CONFIG_IPATH_CORE is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISER4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Distributed Lock Manager
#

#
# Instrumentation Support
#
CONFIG_PROFILING=y
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_DEBUG_SPINLOCK_ALLOC is not set
# CONFIG_DEBUG_RWLOCK_ALLOC is not set
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_MUTEX_ALLOC=y
# CONFIG_PROVE_MUTEX_LOCKING is not set
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_NON_NESTED_UNLOCKS is not set
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_VM=y
CONFIG_FRAME_POINTER=y
# CONFIG_UNWIND_INFO is not set
CONFIG_FORCED_INLINING=y
# CONFIG_DEBUG_SYNCHRO_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_PROFILE_LIKELY is not set
# CONFIG_WANT_EXTRA_DEBUG_INFORMATION is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_IOMMU_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SECLVL is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_PLIST=y

--------------070705010100090103090700--
