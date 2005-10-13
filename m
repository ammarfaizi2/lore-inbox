Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbVJMLCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVJMLCC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 07:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVJMLCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 07:02:02 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:54436 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750872AbVJMLCA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 07:02:00 -0400
Date: Thu, 13 Oct 2005 13:01:58 +0200
Message-ID: <434A520A000065D4@ms004msg.mail.fw>
From: bergen@fastwebnet.it
Subject: PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I'm using an HP nc8230 Laptop with integrated TPM. Everything works with
2.6.12 kernel. If you need it I can provide the lspci report.

Below you can find the dmesg report.

Linux version 2.6.14-rc4 (root@dhcp56.verkstad.net) (gcc version 4.0.0 20050519
(Red Hat 4.0.0-8)) #2 Thu Oct 13 12:40:01 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffd0000 (usable)
 BIOS-e820: 000000003ffd0000 - 000000003ffefc00 (reserved)
 BIOS-e820: 000000003ffefc00 - 000000003fffb000 (ACPI NVS)
 BIOS-e820: 000000003fffb000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed9b000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262096
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32720 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 HP                                    ) @ 0x000fe270
ACPI: RSDT (v001 HP     0934     0x22070520 HP   0x00000001) @ 0x3ffefc84
ACPI: FADT (v002 HP     0934     0x00000002 HP   0x00000001) @ 0x3ffefc00
ACPI: MADT (v001 HP     0934     0x00000001 HP   0x00000001) @ 0x3ffefcb8
ACPI: MCFG (v001 HP     0934     0x00000001 HP   0x00000001) @ 0x3ffefd14
ACPI: SSDT (v001 HP       HPQPpc 0x00001001 MSFT 0x0100000e) @ 0x3fff8120
ACPI: DSDT (v001 HP       nc8200 0x00010000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: ro root=/dev/hda7 rhgb nofb
Initializing CPU#0
CPU 0 irqstacks, hard=c052c000 soft=c052b000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1862.258 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032804k/1048384k available (3236k kernel code, 14656k reserved,
821k data, 184k init, 130880k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 3729.66 BogoMIPS (lpj=7459329)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180
00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180
00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c00)
checking if image is initramfs... it is
Freeing initrd memory: 983k freed
softlockup thread 0 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0322, last bus=32
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C003] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C003] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.C003._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C003.C054._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C003.C069._PRT]
ACPI: Power Resource [C1CC] (on)
ACPI: Embedded Controller [C005] (gpe 16)
ACPI: Power Resource [C1A6] (on)
ACPI: Power Resource [C1AE] (on)
ACPI: Power Resource [C1B5] (on)
ACPI: Power Resource [C1C5] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.C003.C0CE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C003.C0DE._PRT]
ACPI: PCI Interrupt Link [C0DA] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0DB] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0DC] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0DD] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0F0] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0F1] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0F2] (IRQs *10 11)
ACPI: Power Resource [C268] (off)
ACPI: Power Resource [C269] (off)
ACPI: Power Resource [C26A] (off)
ACPI: Power Resource [C26B] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 16 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0d: ioport range 0x1000-0x107f could not be reserved
pnp: 00:0d: ioport range 0x1100-0x113f has been reserved
pnp: 00:0d: ioport range 0x1200-0x121f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: c8800000-c8bfffff
  PREFETCH window: c0000000-c7ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: c8000000-c83fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 3, cardbus bridge: 0000:02:06.0
  IO window: 00004000-00004fff
  IO window: 00005000-00005fff
  PREFETCH window: 50000000-51ffffff
  MEM window: 52000000-53ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-5fff
  MEM window: c8400000-c87fffff
  PREFETCH window: 50000000-51ffffff
ACPI: PCI Interrupt Link [C0DA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [C0DA] -> GSI 10 (level, low)
-> IRQ 10
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> Link [C0DA] -> GSI 10 (level, low)
-> IRQ 10
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Device 0000:00:1c.1 not available because of resource collisions
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [C0DC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [C0DC] -> GSI 11 (level, low)
-> IRQ 11
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1129208089.096:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFS: nTxBlock = 8080, nTxLock = 64645
SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [C0DA] -> GSI 10 (level, low)
-> IRQ 10
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> Link [C0DA] -> GSI 10 (level, low)
-> IRQ 10
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
PCI: Device 0000:00:1c.1 not available because of resource collisions
ACPI: Fan [C26C] (off)
ACPI: Fan [C26D] (off)
ACPI: Fan [C26E] (off)
ACPI: Fan [C26F] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [C001] (supports 8 throttling states)
ACPI: Thermal Zone [TZ1] (53 C)
ACPI: Thermal Zone [TZ2] (53 C)
ACPI: Thermal Zone [TZ3] (33 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: AGP aperture is 256M @ 0x0
tpm_inf 0000:00:1f.0: LPC-bus found at 0x2641
tpm_inf_pnp 00:05: Found C1B7 with ID IFX0101
tpm_inf 0000:00:1f.0: No Infineon TPM found!
pnp: Device 00:05 does not supported disabling.
PNP: PS/2 Controller [PNP0303:C1C2,PNP0f13:C1C3] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [C0F2] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1e.3[B] -> Link [C0F2] -> GSI 10 (level, low)
-> IRQ 10
ACPI: PCI interrupt for device 0000:00:1e.3 disabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0DA] -> GSI 10 (level, low)
-> IRQ 10
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x3580-0x3587, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: FUJITSU MHV2060AH, ATA DISK drive
hdb: UJDA765aDVD/CDRW, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
C069 C0CE C1CD C0DE C1D0 
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 184k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa44793/0x300000
serio: Synaptics pass-through port at isa0060/serio4/input0
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
security:  3 users, 6 roles, 764 types, 87 bools
security:  55 classes, 182383 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda7, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), not configured for labeling
SELinux: initialized (dev hugetlbfs, type hugetlbfs), not configured for
labeling
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
SELinux: initialized (dev inotifyfs, type inotifyfs), not configured for
labeling
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
Floppy drive(s): fd0 is 1.44M
input: PS/2 Generic Mouse on synaptics-pt/serio0
floppy0: no floppy controllers found
tg3.c:v3.42 (Oct 3, 2005)
ACPI: PCI Interrupt 0000:10:00.0[A] -> Link [C0DA] -> GSI 10 (level, low)
-> IRQ 10
PCI: Setting latency timer of device 0000:10:00.0 to 64
eth0: Tigon3 [partno(BCM95751M) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT
Ethernet 00:14:38:16:2b:59
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]

eth0: dma_rwctrl[76180000]
ieee80211_crypt: registered algorithm 'NULL'
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.0
ipw2200: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI Interrupt Link [C0F1] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0F1] -> GSI 11 (level, low)
-> IRQ 11
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Radio Frequency Kill Switch is On:
Kill switch must be turned off for wireless networking to work.
ACPI: PCI Interrupt 0000:00:1e.2[A] -> Link [C0F1] -> GSI 11 (level, low)
-> IRQ 11
PCI: Setting latency timer of device 0000:00:1e.2 to 64
intel8x0_measure_ac97_clock: measured 55502 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1e.3[B] -> Link [C0F2] -> GSI 10 (level, low)
-> IRQ 10
PCI: Setting latency timer of device 0000:00:1e.3 to 64
hw_random: RNG not detected
shpchp: acpi_shpchprm:\_SB_.C003 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.C003 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.C003 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
ACPI: PCI Interrupt Link [C0F0] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.7[A] -> Link [C0F0] -> GSI 10 (level, low)
-> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 10, io mem 0xc8c00000
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0F0] -> GSI 10 (level, low)
-> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 10, io base 0x00003000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [C0DB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0DB] -> GSI 11 (level, low)
-> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00003020
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0DC] -> GSI 11 (level, low)
-> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 11, io base 0x00003040
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [C0DC] -> GSI 11 (level, low)
-> IRQ 11
Yenta: CardBus bridge found at 0000:02:06.0 [103c:0934]
Yenta: Enabling burst memory read transactions
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:06.0, mfunc 0x01111b22, devctl 0x64
Yenta: ISA IRQ mask 0x00f8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x5fff
cs: IO port probe 0x4000-0x5fff: clean.
pcmcia: parent PCI bridge Memory window: 0xc8400000 - 0xc87fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:02:06.2[C] -> Link [C0F2] -> GSI 10 (level, low)
-> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[c8402000-c84027ff]
 Max Packet=[2048]
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[a55a574700508b71]
NET: Registered protocol family 10
Disabled Privacy Extensions on device c04add00(lo)
IPv6 over IPv4 tunneling driver
ACPI: AC Adapter [C173] (on-line)
ACPI: Battery Slot [C175] (battery present)
ACPI: Battery Slot [C174] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C1EE]
ACPI: Lid Switch [C1EF]
ibm_acpi: ec object not found
ACPI: Video Device [C0FA] (multi-head: yes  rom: no  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
hdb: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdb: packet command error: error=0x50 { LastFailedSense=0x05 }
ide: failed opcode was: unknown
cdrom: open failed.
hdb: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdb: packet command error: error=0x50 { LastFailedSense=0x05 }
ide: failed opcode was: unknown
cdrom: open failed.
audit(1129200913.115:2): avc:  denied  { write } for  pid=1667 comm="fsck"
name="rhgb-console" dev=ramfs ino=5419 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:ramfs_t tclass=fifo_file
audit(1129200913.403:3): avc:  denied  { getattr } for  pid=1670 comm="fsck.reiserfs"
name="usbdev2.1" dev=tmpfs ino=5229 scontext=system_u:system_r:fsadm_t tcontext=system_u:object_r:device_t
tclass=chr_file
EXT3 FS on hda7, internal journal
SELinux: initialized (dev hda3, type ext2), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
SELinux: initialized (dev hda5, type reiserfs), uses xattr
Adding 2010952k swap on /dev/hda2.  Priority:-1 extents:1 across:2010952k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.3 (8190 buckets, 65520 max) - 256 bytes per conntrack
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect
breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html
for details.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x378-0x37f
cs: IO port probe 0xa00-0xaff: clean.
tg3: eth0: Link is up at 10 Mbps, half duplex.
tg3: eth0: Flow control is off for TX and off for RX.
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
i2c /dev entries driver
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
eth0: no IPv6 routers present
eth1 (WE) : Driver using old /proc/net/wireless support, please fix driver
!
eth1 (WE) : Driver using old /proc/net/wireless support, please fix driver
!


