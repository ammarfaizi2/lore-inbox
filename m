Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVGPPB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVGPPB7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 11:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVGPPB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 11:01:59 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:28756 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261553AbVGPPB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 11:01:57 -0400
Date: Sat, 16 Jul 2005 10:40:24 -0400 (EDT)
From: vcjones@networkingunlimited.com (Vincent C Jones)
Subject: Re: [2.6.13-rc3][PCMCIA] - iounmap: bad address f1d62000
In-reply-to: <4qGHl-3Hm-11@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
Cc: vcjones@networkingunlimited.com
Message-id: <20050716144024.14C8E1F3DC@X31.networkingunlimited.com>
Organization: 
Content-transfer-encoding: 7BIT
Newsgroups: linux.kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testing 2.6.13-rc3 and getting nasty output during bootup from yenta
socket initialization. dmesg output follows:

Linux version 2.6.13-rc3-APM (root@X31) (gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)) #13 Fri Jul 15 23:55:12 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ff60000 (usable)
 BIOS-e820: 000000002ff60000 - 000000002ff77000 (ACPI data)
 BIOS-e820: 000000002ff77000 - 000000002ff79000 (ACPI NVS)
 BIOS-e820: 000000002ff80000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
767MB LOWMEM available.
On node 0 totalpages: 196448
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192352 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
Allocating PCI resources starting at 30000000 (gap: 30000000:cf800000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Test_9.3 ro root=307 selinux=0 desktop video=1024x768 i8042.nomux PROFILE=NUI
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01601000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1398.858 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 774732k/785792k available (2439k kernel code, 10604k reserved, 665k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2800.29 BogoMIPS (lpj=14001494)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/24cc] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:00.2
PCI: Sharing IRQ 11 with 0000:02:02.0
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: c0100000-c01fffff
  PREFETCH window: e0000000-e7ffffff
PCI: Bus 3, cardbus bridge: 0000:02:00.0
  IO window: 00004000-00004fff
  IO window: 00005000-00005fff
  PREFETCH window: e8000000-e9ffffff
  MEM window: c2000000-c3ffffff
PCI: Bus 7, cardbus bridge: 0000:02:00.1
  IO window: 00006000-00006fff
  IO window: 00007000-00007fff
  PREFETCH window: ea000000-ebffffff
  MEM window: c4000000-c5ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-8fff
  MEM window: c0200000-cfffffff
  PREFETCH window: e8000000-efffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Found IRQ 11 for device 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:01.0
PCI: Found IRQ 11 for device 0000:02:00.1
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:00:1f.6
audit: initializing netlink socket (disabled)
audit(1121522265.240:1): initialized
Total HugeTLB memory allocated, 0
inotify syscall
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
PCI: Found IRQ 11 for device 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:02:01.0
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=144.00 Mhz, System=144.00 MHz
radeonfb: PLL min 12000 max 35000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1024x768                
radeonfb: detected LVDS panel size from BIOS: 1024x768
radeondb: BIOS provided dividers will be used
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 85x34
radeonfb (0000:01:00.0): ATI Radeon LY 
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
PCI: Found IRQ 11 for device 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:02:00.1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
floppy0: no floppy controllers found
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:00.2
PCI: Sharing IRQ 11 with 0000:02:02.0
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HTS726060M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
mice: PS/2 mouse device common for all mice
input: PC Speaker
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
ip_conntrack version 2.1 (6139 buckets, 49112 max) - 212 bytes per conntrack
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03cc9a0(lo)
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
Using IPI Shortcut mode
swsusp: Suspend partition has wrong signature?
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: replayed 19 transactions in 5 seconds
ReiserFS: hda7: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 156k freed
ReiserFS: hda7: Removing [49860 128388 0x0 SD]..done
ReiserFS: hda7: Removing [60973 125123 0x0 SD]..done
ReiserFS: hda7: Removing [60973 125113 0x0 SD]..done
ReiserFS: hda7: There were 3 uncompleted unlinks/truncates. Completed
SCSI subsystem initialized
ReiserFS: hda9: found reiserfs format "3.6" with standard journal
ReiserFS: hda9: using ordered data mode
ReiserFS: hda9: journal params: device hda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda9: checking transaction log (hda9)
ReiserFS: hda9: Using r5 hash to sort names
ReiserFS: hda9: Removing [613607 1005845 0x0 SD]..done
ReiserFS: hda9: Removing [246427 360427 0x0 SD]..done
ReiserFS: hda9: Removing [246427 360425 0x0 SD]..done
ReiserFS: hda9: Removing [246427 360424 0x0 SD]..done
ReiserFS: hda9: Removing [246427 360419 0x0 SD]..done
ReiserFS: hda9: Removing [246427 299669 0x0 SD]..done
ReiserFS: hda9: Removing [246427 230757 0x0 SD]..done
ReiserFS: hda9: Removing [34257 34441 0x0 SD]..done
ReiserFS: hda9: Removing [246427 34257 0x0 SD]..done
ReiserFS: hda9: There were 9 uncompleted unlinks/truncates. Completed
ReiserFS: hda11: found reiserfs format "3.6" with standard journal
ReiserFS: hda11: using ordered data mode
ReiserFS: hda11: journal params: device hda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda11: checking transaction log (hda11)
ReiserFS: hda11: Using r5 hash to sort names
ReiserFS: hda10: found reiserfs format "3.6" with standard journal
ReiserFS: hda10: using ordered data mode
ReiserFS: hda10: journal params: device hda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda10: checking transaction log (hda10)
ReiserFS: hda10: Using r5 hash to sort names
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
lp0: using parport0 (polling).
ip_tables: (C) 2000-2002 Netfilter core team
ieee1394: Initialized config rom entry `ip1394'
ieee1394: raw1394: /dev/raw1394 device initialized
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 11 for device 0000:02:00.2
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:02:02.0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[c0240000-c02407ff]  Max Packet=[2048]
video1394: Installed video1394 module
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:02:01.0
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x00001800
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.1
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001820
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:02:00.2
PCI: Sharing IRQ 11 with 0000:02:02.0
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001840
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.7
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xc0000000
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
loop: loaded (max 8 devices)
input.c: calling hotplug without a hotplug agent defined
input: PS/2 Generic Mouse on isa0060/serio1
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.8
usbcore: registered new driver hci_usb
usb 3-1: new full speed USB device using uhci_hcd and address 2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00061b031001139f]
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.14.9 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413)
wlan: 0.8.4.5 (EXPERIMENTAL)
ath_rate_onoe: 1.0
ath_pci: 0.9.4.12 (EXPERIMENTAL)
PCI: Found IRQ 11 for device 0000:02:02.0
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:02:00.2
ath0: 11a rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: mac 5.6 phy 4.1 5ghz radio 1.7 2ghz radio 2.3
ath0: 802.11 address: 00:05:4e:49:d7:21
ath0: Use hw queue 0 for WME_AC_BE traffic
ath0: Use hw queue 1 for WME_AC_BK traffic
ath0: Use hw queue 2 for WME_AC_VI traffic
ath0: Use hw queue 3 for WME_AC_VO traffic
ath0: Atheros 5212: mem=0xc0210000, irq=11
Adding 982756k swap on /dev/loop6.  Priority:42 extents:1
st: Version 20050501, fixed bufsize 32768, s/g segs 256
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
PCI: Found IRQ 11 for device 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:01.0
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0532]
Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
cs: IO port probe 0x4000-0x8fff: clean.
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
PCI: Found IRQ 11 for device 0000:02:00.1
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:00:1f.6
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0532]
Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Socket status: 30000810
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
cs: IO port probe 0x4000-0x8fff: clean.
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
cs: memory probe 0xe8000000-0xefffffff: excluding 0xe8000000-0xefffffff
cs: memory probe 0xc0200000-0xcfffffff:<4>iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1dc3845>] set_cis_map+0xd5/0xf0 [pcmcia_core]
 [<f1dc3970>] pcmcia_read_cis_mem+0x110/0x180 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc40f2>] follow_link+0x92/0x1f0 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc445b>] pccard_get_next_tuple+0x20b/0x290 [pcmcia_core]
 [<f1dc3fbb>] pccard_get_first_tuple+0x8b/0x130 [pcmcia_core]
 [<f1dc5a01>] pccard_validate_cis+0x81/0x210 [pcmcia_core]
 [<f1d7350f>] readable+0x3f/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1d73519>] readable+0x49/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
 excluding 0xc0200000-0xc11fffff 0xc1a00000-0xc61fffff<4>iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1dc3845>] set_cis_map+0xd5/0xf0 [pcmcia_core]
 [<f1dc3970>] pcmcia_read_cis_mem+0x110/0x180 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc40f2>] follow_link+0x92/0x1f0 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc445b>] pccard_get_next_tuple+0x20b/0x290 [pcmcia_core]
 [<f1dc3fbb>] pccard_get_first_tuple+0x8b/0x130 [pcmcia_core]
 [<f1dc5a01>] pccard_validate_cis+0x81/0x210 [pcmcia_core]
 [<f1d7350f>] readable+0x3f/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1d73519>] readable+0x49/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
 0xc6a00000-0xc71fffff<4>iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1dc3845>] set_cis_map+0xd5/0xf0 [pcmcia_core]
 [<f1dc3970>] pcmcia_read_cis_mem+0x110/0x180 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc40f2>] follow_link+0x92/0x1f0 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc445b>] pccard_get_next_tuple+0x20b/0x290 [pcmcia_core]
 [<f1dc3fbb>] pccard_get_first_tuple+0x8b/0x130 [pcmcia_core]
 [<f1dc5a01>] pccard_validate_cis+0x81/0x210 [pcmcia_core]
 [<f1d7350f>] readable+0x3f/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1d73519>] readable+0x49/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
 0xc7a00000-0xc81fffff<4>iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1dc3845>] set_cis_map+0xd5/0xf0 [pcmcia_core]
 [<f1dc3970>] pcmcia_read_cis_mem+0x110/0x180 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc40f2>] follow_link+0x92/0x1f0 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc445b>] pccard_get_next_tuple+0x20b/0x290 [pcmcia_core]
 [<f1dc3fbb>] pccard_get_first_tuple+0x8b/0x130 [pcmcia_core]
 [<f1dc5a01>] pccard_validate_cis+0x81/0x210 [pcmcia_core]
 [<f1d7350f>] readable+0x3f/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1d73519>] readable+0x49/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
 0xc8a00000-0xc91fffff<4>iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1dc3845>] set_cis_map+0xd5/0xf0 [pcmcia_core]
 [<f1dc3970>] pcmcia_read_cis_mem+0x110/0x180 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc40f2>] follow_link+0x92/0x1f0 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc445b>] pccard_get_next_tuple+0x20b/0x290 [pcmcia_core]
 [<f1dc3fbb>] pccard_get_first_tuple+0x8b/0x130 [pcmcia_core]
 [<f1dc5a01>] pccard_validate_cis+0x81/0x210 [pcmcia_core]
 [<f1d7350f>] readable+0x3f/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1d73519>] readable+0x49/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
 0xc9a00000-0xca1fffff<4>iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1dc3845>] set_cis_map+0xd5/0xf0 [pcmcia_core]
 [<f1dc3970>] pcmcia_read_cis_mem+0x110/0x180 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc40f2>] follow_link+0x92/0x1f0 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc445b>] pccard_get_next_tuple+0x20b/0x290 [pcmcia_core]
 [<f1dc3fbb>] pccard_get_first_tuple+0x8b/0x130 [pcmcia_core]
 [<f1dc5a01>] pccard_validate_cis+0x81/0x210 [pcmcia_core]
 [<f1d7350f>] readable+0x3f/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1d73519>] readable+0x49/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
 0xcaa00000-0xcb1fffff<4>iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1dc3845>] set_cis_map+0xd5/0xf0 [pcmcia_core]
 [<f1dc3970>] pcmcia_read_cis_mem+0x110/0x180 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc40f2>] follow_link+0x92/0x1f0 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc445b>] pccard_get_next_tuple+0x20b/0x290 [pcmcia_core]
 [<f1dc3fbb>] pccard_get_first_tuple+0x8b/0x130 [pcmcia_core]
 [<f1dc5a01>] pccard_validate_cis+0x81/0x210 [pcmcia_core]
 [<f1d7350f>] readable+0x3f/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1d73519>] readable+0x49/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
 0xcba00000-0xcc1fffff<4>iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1dc3845>] set_cis_map+0xd5/0xf0 [pcmcia_core]
 [<f1dc3970>] pcmcia_read_cis_mem+0x110/0x180 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc40f2>] follow_link+0x92/0x1f0 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc445b>] pccard_get_next_tuple+0x20b/0x290 [pcmcia_core]
 [<f1dc3fbb>] pccard_get_first_tuple+0x8b/0x130 [pcmcia_core]
 [<f1dc5a01>] pccard_validate_cis+0x81/0x210 [pcmcia_core]
 [<f1d7350f>] readable+0x3f/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1d73519>] readable+0x49/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
 0xcca00000-0xcd1fffff<4>iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1dc3845>] set_cis_map+0xd5/0xf0 [pcmcia_core]
 [<f1dc3970>] pcmcia_read_cis_mem+0x110/0x180 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc40f2>] follow_link+0x92/0x1f0 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc445b>] pccard_get_next_tuple+0x20b/0x290 [pcmcia_core]
 [<f1dc3fbb>] pccard_get_first_tuple+0x8b/0x130 [pcmcia_core]
 [<f1dc5a01>] pccard_validate_cis+0x81/0x210 [pcmcia_core]
 [<f1d7350f>] readable+0x3f/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1d73519>] readable+0x49/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
 0xcda00000-0xce1fffff<4>iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1dc3845>] set_cis_map+0xd5/0xf0 [pcmcia_core]
 [<f1dc3970>] pcmcia_read_cis_mem+0x110/0x180 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc40f2>] follow_link+0x92/0x1f0 [pcmcia_core]
 [<f1dc3ca9>] read_cis_cache+0x179/0x180 [pcmcia_core]
 [<f1dc445b>] pccard_get_next_tuple+0x20b/0x290 [pcmcia_core]
 [<f1dc3fbb>] pccard_get_first_tuple+0x8b/0x130 [pcmcia_core]
 [<f1dc5a01>] pccard_validate_cis+0x81/0x210 [pcmcia_core]
 [<f1d7350f>] readable+0x3f/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
iounmap: bad address f1d62000
 [<c0113f1c>] iounmap+0xdc/0xe0
 [<f1d73519>] readable+0x49/0x80 [rsrc_nonstatic]
 [<f1d736af>] cis_readable+0x7f/0xe0 [rsrc_nonstatic]
 [<f1d738dd>] do_mem_probe+0x10d/0x1d0 [rsrc_nonstatic]
 [<c0200000>] decode_recall_args+0x60/0x80
 [<f1d73b28>] validate_mem+0xf8/0x120 [rsrc_nonstatic]
 [<c017784a>] __d_lookup+0x11a/0x190
 [<f1d73bbf>] pcmcia_nonstatic_validate_mem+0x6f/0x80 [rsrc_nonstatic]
 [<f1dc5d44>] pcmcia_validate_mem+0x14/0x20 [pcmcia_core]
 [<f1d5791a>] pcmcia_card_add+0x2a/0xc0 [pcmcia]
 [<c035ff04>] schedule+0x3c4/0x680
 [<c035fe97>] schedule+0x357/0x680
 [<c035ff04>] schedule+0x3c4/0x680
 [<c01157cd>] __wake_up_locked+0x1d/0x20
 [<c022c6bf>] kobject_get+0xf/0x20
 [<f1d58343>] ds_event+0xc3/0xd0 [pcmcia]
 [<f1dc2820>] send_event+0xa0/0x140 [pcmcia_core]
 [<f1dc3288>] pccard_register_pcmcia+0x78/0x80 [pcmcia_core]
 [<f1d579b0>] pcmcia_delayed_add_pseudo_device+0x0/0x20 [pcmcia]
 [<f1d587b4>] pcmcia_bus_add_socket+0x94/0xe0 [pcmcia]
 [<c022c6bf>] kobject_get+0xf/0x20
 [<c027ffa7>] class_interface_register+0x87/0xc0
 [<f1c1d014>] init_pcmcia_bus+0x14/0x20 [pcmcia]
 [<c01353c6>] sys_init_module+0x136/0x210
 [<c0102dab>] sysenter_past_esp+0x54/0x75
 0xcea00000-0xcf1fffff 0xcfa00000-0xd01fffff
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x800-0x80f: clean.
cs: IO port probe 0x800-0x80f: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x370-0x377
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x370-0x377
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xa00-0xaff: clean.
Probing IDE interface ide2...
hde: KCF001G-KT3, CFA DISK drive
ide2 at 0x8040-0x8047,0x804e on irq 5
hde: max request size: 128KiB
hde: 2031120 sectors (1039 MB) w/0KiB Cache, CHS=2015/16/63
hde: cache flushes not supported
 hde: hde1
ide-cs: hde: Vcc = 3.3, Vpp = 0.0
 hde: hde1
 hde: hde1
 hde: hde1
PCI: Found IRQ 11 for device 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:02:00.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49546 usecs
intel8x0: clocking to 48000
Non-volatile memory driver v1.2
NET: Registered protocol family 23
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
IrDA: Registered device irda0
nsc-ircc, Using dongle: IBM31T1100 or Temic TFDS6000/TFDS6500
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
PCI: Found IRQ 11 for device 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:02:00.1
PCI: Setting latency timer of device 0000:00:1f.6 to 64
subfs 0.9
/dev/vmmon[4638]: Module vmmon: registered with major=10 minor=165
/dev/vmmon[4638]: Module vmmon: initialized
hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hde: drive_cmd: error=0x04 { DriveStatusError }
ide: failed opcode was: 0xa1
/dev/vmnet: open called by PID 4718 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: peer interface eth0 not found, will wait for it to come up
bridge-eth0: attached
/dev/vmnet: open called by PID 4918 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 4920 (vmnet-netifup)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: AGP aperture is 256M @ 0xd0000000
/dev/vmnet: open called by PID 4896 (vmnet-natd)
/dev/vmnet: port on hub 8 successfully opened
[drm] Initialized drm 1.0.0 20040925
PCI: Found IRQ 11 for device 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:02:01.0
[drm] Initialized radeon 1.16.0 20050311 on minor 0: 
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
/dev/vmnet: open called by PID 4985 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 4984 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
vmnet1: no IPv6 routers present
vmnet8: no IPv6 routers present
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
ath0: no IPv6 routers present
ReiserFS: loop3: found reiserfs format "3.6" with standard journal
ReiserFS: loop3: using ordered data mode
ReiserFS: loop3: journal params: device loop3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: loop3: checking transaction log (loop3)
ReiserFS: loop3: Using r5 hash to sort names
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode

-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
Phone: +1 201 568-7810
14 Dogwood Lane, Tenafly, NJ 07670
VCJones@NetworkingUnlimited.com     http://www.networkingunlimited.com
