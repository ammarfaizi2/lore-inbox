Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVBQTET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVBQTET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVBQTET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:04:19 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:8062 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261177AbVBQTDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:03:20 -0500
Message-ID: <4214EA6C.8040101@triplehelix.org>
Date: Thu, 17 Feb 2005 11:03:08 -0800
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, hostap@shmoo.com
Subject: Re: 2.6.10: irq 12 nobody cared!
References: <4214450B.6090006@triplehelix.org> <Pine.LNX.4.61.0502170713110.26742@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0502170713110.26742@montezuma.fsmlabs.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB36EBDA13885EC357E301927"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB36EBDA13885EC357E301927
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Zwane Mwaikambo wrote:
> Check that the hostap interrupt handler is 2.6 aware (IRQ_HANDLED etc)

It shows up even before the hostap module is loaded (and in fact appears
to stop showing up when that happens.) Here's the full output of dmesg.

Linux version 2.6.10-influx (joshk@darjeeling) (gcc version 3.3.5
(Debian 1:3.3.5-8)) #1 Wed Feb 16 22:45:19 PST 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000014000000 (usable)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
320MB LOWMEM available.
On node 0 totalpages: 81920
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 77824 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Built 1 zonelists
Kernel command line: root=/dev/hda5 ro notsc
notsc: Kernel compiled with CONFIG_X86_TSC, cannot disable TSC.
Initializing CPU#0
CPU 0 irqstacks, hard=c03c3000 soft=c03c2000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 451.282 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 321228k/327680k available (1857k kernel code, 5972k reserved,
809k data, 132k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 882.68 BogoMIPS (lpj=441344)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 008021bf 808029bf 00000000 00000000
00000000 00000000
CPU: After vendor identify, caps: 008021bf 808029bf 00000000 00000000
00000000 00000000
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After all inits, caps: 008021bf 808029bf 00000000 00000002 00000000
00000000
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc0a0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc0c8, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo MVP3 chipset
agpgart: Maximum main memory to use for agp memory: 263M
agpgart: AGP aperture is 64M @ 0xe0000000
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin
is 60 seconds).
irq 12: nobody cared!
  [<c012bb42>] __report_bad_irq+0x22/0x80
  [<c012bc0c>] note_interrupt+0x4c/0x80
  [<c012b6f8>] __do_IRQ+0x118/0x140
  [<c0103d76>] do_IRQ+0x36/0x60
  =======================
  [<c010271a>] common_interrupt+0x1a/0x20
  [<c0117730>] __do_softirq+0x30/0xa0
  [<c0103e79>] do_softirq+0x39/0x40
  =======================
  [<c012b574>] irq_exit+0x34/0x40
  [<c0103d7d>] do_IRQ+0x3d/0x60
  [<c010271a>] common_interrupt+0x1a/0x20
  [<c012b914>] setup_irq+0x94/0x120
  [<c01f20a0>] i8042_interrupt+0x0/0x180
  [<c012baf2>] request_irq+0x72/0xa0
  [<c03ab9a1>] i8042_check_aux+0x21/0x140
  [<c01f20a0>] i8042_interrupt+0x0/0x180
  [<c03abe78>] i8042_init+0xf8/0x180
  [<c039c80b>] do_initcalls+0x2b/0xc0
  [<c0100440>] init+0x0/0xe0
  [<c0100467>] init+0x27/0xe0
  [<c010084d>] kernel_thread_helper+0x5/0x18
handlers:
[<c01f20a0>] (i8042_interrupt+0x0/0x180)
Disabling IRQ #12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
parport_pc: VIA parallel port: io=0x378, irq=7
io scheduler noop registered
io scheduler anticipatory registered
elevator: using anticipatory as default io scheduler
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 14) IDE UDMA66 controller on pci0000:00:07.1
     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST340016A, ATA DISK drive
hdb: WDC WD1200JB-00DUA3, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Hewlett-Packard CD-Writer Plus 8200, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20269: IDE controller at PCI slot 0000:00:0c.0
PCI: Found IRQ 11 for device 0000:00:0c.0
PDC20269: chipset revision 2
PDC20269: ROM enabled at 0xe8000000
PDC20269: 100% native mode on irq 11
     ide2: BM-DMA at 0xc400-0xc407, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xc408-0xc40f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: WDC WD2500JB-00GVA0, ATA DISK drive
ide2 at 0xb400-0xb407,0xb802 on irq 11
Probing IDE interface ide3...
hdg: WDC WD2500JB-00GVA0, ATA DISK drive
ide3 at 0xbc00-0xbc07,0xc002 on irq 11
hda: max request size: 128KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
hda: cache flushes not supported
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdb: max request size: 1024KiB
hdb: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(66)
hdb: cache flushes supported
  hdb: hdb1
hde: max request size: 1024KiB
hde: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63,
UDMA(100)
hde: cache flushes supported
  hde: unknown partition table
hdg: max request size: 1024KiB
hdg: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63,
UDMA(100)
hdg: cache flushes supported
  hdg: unknown partition table
hdc: ATAPI 24X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 10 for device 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:07.3
PCI: Sharing IRQ 10 with 0000:00:0b.0
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0xa400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:07.3
PCI: Sharing IRQ 10 with 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:0b.0
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (#2)
uhci_hcd 0000:00:07.3: irq 10, io base 0xa800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
irq 12: nobody cared!
  [<c012bb42>] __report_bad_irq+0x22/0x80
  [<c012bc0c>] note_interrupt+0x4c/0x80
  [<c012b6f8>] __do_IRQ+0x118/0x140
  [<c0103d76>] do_IRQ+0x36/0x60
  =======================
  [<c010271a>] common_interrupt+0x1a/0x20
  [<c0117730>] __do_softirq+0x30/0xa0
  [<c0103e79>] do_softirq+0x39/0x40
  =======================
  [<c012b574>] irq_exit+0x34/0x40
  [<c0103d7d>] do_IRQ+0x3d/0x60
  [<c010271a>] common_interrupt+0x1a/0x20
  [<c012b914>] setup_irq+0x94/0x120
  [<c01f20a0>] i8042_interrupt+0x0/0x180
  [<c012baf2>] request_irq+0x72/0xa0
  [<c01f1fa3>] i8042_open+0x43/0xc0
  [<c01f20a0>] i8042_interrupt+0x0/0x180
  [<c01f1a55>] serio_open+0x35/0x80
  [<c01f1ea0>] i8042_aux_write+0x0/0x60
  [<c02531f8>] atkbd_connect+0x1b8/0x480
  [<c01f0d79>] serio_bind_driver+0x19/0x80
  [<c01f14ef>] serio_connect_port+0x2f/0x140
  [<c01f1967>] serio_register_driver+0xa7/0xc0
  [<c03af42a>] atkbd_init+0xa/0x20
  [<c039c80b>] do_initcalls+0x2b/0xc0
  [<c0100440>] init+0x0/0xe0
  [<c0100467>] init+0x27/0xe0
  [<c010084d>] kernel_thread_helper+0x5/0x18
handlers:
[<c01f20a0>] (i8042_interrupt+0x0/0x180)
Disabling IRQ #12
irq 12: nobody cared!
  [<c012bb42>] __report_bad_irq+0x22/0x80
  [<c012bc0c>] note_interrupt+0x4c/0x80
  [<c012b6f8>] __do_IRQ+0x118/0x140
  [<c0103d76>] do_IRQ+0x36/0x60
  =======================
  [<c010271a>] common_interrupt+0x1a/0x20
  [<c0117730>] __do_softirq+0x30/0xa0
  [<c0103e79>] do_softirq+0x39/0x40
  =======================
  [<c012b574>] irq_exit+0x34/0x40
  [<c0103d7d>] do_IRQ+0x3d/0x60
  [<c010271a>] common_interrupt+0x1a/0x20
  [<c012b914>] setup_irq+0x94/0x120
  [<c01f20a0>] i8042_interrupt+0x0/0x180
  [<c012baf2>] request_irq+0x72/0xa0
  [<c01f1fa3>] i8042_open+0x43/0xc0
  [<c01f20a0>] i8042_interrupt+0x0/0x180
  [<c01f1a55>] serio_open+0x35/0x80
  [<c0254763>] psmouse_connect+0xe3/0x2a0
  [<c01f0d79>] serio_bind_driver+0x19/0x80
  [<c01f14ef>] serio_connect_port+0x2f/0x140
  [<c01f1967>] serio_register_driver+0xa7/0xc0
  [<c03af47b>] psmouse_init+0x3b/0xc0
  [<c039c80b>] do_initcalls+0x2b/0xc0
  [<c0100440>] init+0x0/0xe0
  [<c0100467>] init+0x27/0xe0
  [<c010084d>] kernel_thread_helper+0x5/0x18
handlers:
[<c01f20a0>] (i8042_interrupt+0x0/0x180)
Disabling IRQ #12
md: raid1 personality registered as nr 3
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (2560 buckets, 20480 max) - 300 bytes per conntrack
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 132k freed
kjournald starting.  Commit interval 5 seconds
Adding 295304k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
hostap_crypt: registered algorithm 'NULL'
hostap_pci: 0.2.6 - 2004-12-25 (Jouni Malinen <jkmaline@cc.hut.fi>)
PCI: Found IRQ 12 for device 0000:00:09.0
hostap_pci: Registered netdevice wifi0
wifi0: Original COR value: 0x0
prism2_hw_init: initialized in 197 ms
wifi0: NIC: id=0x8013 v1.0.0
wifi0: PRI: id=0x15 v1.0.5
wifi0: STA: id=0x1f v1.3.4
wifi0: defaulting to host-based encryption as a workaround for firmware
bug in Host AP mode WEP
wifi0: defaulting to bogus WDS frame as a workaround for firmware bug in
Host AP mode WDS
wifi0: Intersil Prism2.5 PCI: mem=0xe9044000, irq=12
wifi0: registered netdevice wlan0
i2c /dev entries driver
md: md0 stopped.
md: bind<hdg>
md: bind<hde>
raid1: raid set md0 active with 2 out of 2 mirrors
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_conntrack_ftp: Unknown parameter `ip_conntrack_irc'
ip_tables: (C) 2000-2002 Netfilter core team
wlan0: dropped received packet from non-associated STA 00:90:d1:07:e7:bc
(type=0x02, subtype=0x04)
handle_ap_item - data frame
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
wifi0: 00:01:24:f1:44:63 auth_cb - alg=0 trans#=2 status=0 - STA
authenticated
wifi0: 00:01:24:f1:44:63 assoc_cb - STA associated
wifi0: 00:90:d1:07:e7:bc auth_cb - alg=0 trans#=2 status=0 - STA
authenticated
wifi0: 00:90:d1:07:e7:bc assoc_cb - STA associated
wifi0: 00:02:2d:31:ce:8f auth_cb - alg=0 trans#=2 status=0 - STA
authenticated
wifi0: 00:02:2d:31:ce:8f assoc_cb - STA associated
input: AT Translated Set 2 keyboard on isa0060/serio0
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2
Copyright (c) 1999-2004 Intel Corporation.
PCI: Found IRQ 10 for device 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:07.3
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 5 for device 0000:00:0a.0
tulip0:  MII transceiver #1 config 1000 status 786d advertising 01e1.
eth0: ADMtek Comet rev 17 at 0001ac00, 00:20:78:08:71:C0, IRQ 5.
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2
Copyright (c) 1999-2004 Intel Corporation.
PCI: Found IRQ 10 for device 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:07.3
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth1: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
IN=eth1 OUT= MAC=ff:ff:ff:ff:ff:ff:00:10:5a:78:c2:17:08:00 SRC=0.0.0.0
DST=255.255.255.255 LEN=328 TOS=0x00 PREC=0x00 TTL=128 ID=18034
PROTO=UDP SPT=68 DPT=67 LEN=308
0000:00:0a.0: tulip_stop_rxtx() failed
eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
PPP BSD Compression module registered
PPP Deflate Compression module registered
IN= OUT=ppp0 SRC=68.126.186.117 DST=192.58.128.30 LEN=69 TOS=0x00
PREC=0x00 TTL=64 ID=1 DF PROTO=UDP SPT=32768 DPT=53 LEN=49
nfsd: last server has exited
nfsd: unexporting all filesystems
wifi0: deauthentication: 00:90:d1:07:e7:bc len=2, reason_code=3
handle_ap_item - addr3(BSSID)=28:a6:b8:cf:17:50 not own MAC
wifi0: STA 00:90:d1:07:e7:bc did not ACK activity poll frame
wifi0: sending disassociation info to STA
00:90:d1:07:e7:bc(last=14547600, jiffies=14848600)
wifi0: sending deauthentication info to STA
00:90:d1:07:e7:bc(last=14547600, jiffies=14849600)
wifi0: Could not find STA 00:90:d1:07:e7:bc for this TX error (@14849618)
wifi0: STA 00:02:2d:31:ce:8f TX rate lowered to 55
wifi0: STA 00:02:2d:31:ce:8f TX rate raised to 110


--
Joshua Kwan

--------------enigB36EBDA13885EC357E301927
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQhTqb6OILr94RG8mAQLJ/A/+IsxR0KBKFX6P+NlWiHs6VzQjC7euYt81
6AvCWOzUzRGUTcRT3oHjwoSB7qkv2Jugrj9GkX8SV13b4ZmPublORoTJsiaduOwo
N9F9qHYFQenABTC9ORq89GUCexGbzIm7nYbtKx4d+0gSZfiDJhiIPWhrGJIE/EnQ
tBVck1R474cJQYfl0EWmlWWf1oP775l3QNpzdcm47wH6wrli6wkuAYbWukTvHBhj
e0wIS9XMoW6JvaJWjK4rcZFZ+zIhcF/Jd6+sTx7MZ/GK+jVuNV6yoXAys4MK6C03
4z5lETC6xaHAJfjqKv18h2/M9+RkpSbjUPIaeRpJ03GClLcT1DLz2mJg87nRv4HN
KGwrMEDhrhkXr9ivaBzciz8isyasfwD5bkGdtbi61zptpKFqws9fYXwZucnwu9Eg
g7auMv8afJYK/Unn/JtLB0uUtri2ZMbgNjZP/mS8OgM3BFm4ctIogtqmw8bJ+/bD
6AR/fwne2COSFgXES2L0EqTopj6sjZ9E7nN4uM67eG8w4f2t2LLku4MEtK0f0WUJ
NzEc5UsBXW4j+hjun+Hsnzk2wWa9WBkvKv5BPqu7n0LD7DxfkIFZr1seNnEP+4iL
iXU7NcPk01jtVtSHVa5zBIVPy4Y2LQGfYzeIHfJQN9mEwyT0JtHno1dRfmntm9ut
/HkHz7s9lms=
=Tfuk
-----END PGP SIGNATURE-----

--------------enigB36EBDA13885EC357E301927--
