Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265989AbTFWKQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 06:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265991AbTFWKQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 06:16:20 -0400
Received: from routeree.utt.ro ([193.226.8.102]:141 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id S265989AbTFWKPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 06:15:30 -0400
Message-ID: <35119.194.138.39.55.1056364461.squirrel@webmail.etc.utt.ro>
Date: Mon, 23 Jun 2003 13:34:21 +0300 (EEST)
Subject: Jfs problems
From: "Szonyi Calin" <sony@etc.utt.ro>
To: <jfs-discussion@www-124.southbury.usf.ibm.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20030623133421_74004"
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20030623133421_74004
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit

Hi

Accidentally  I filled up my jfs root partition.
After that I had some crashes with jfs
Below is the dmesg and the crash.
I had to reboot in kernel 2.4 to be able to delete the files.
Also I found in logs a line with
_mark_inode_dirty: this cannot happen

config and program versions are atached.

Jun 22 00:18:41 grinch syslogd 1.4.1: restart (remote reception).
Jun 22 00:18:42 grinch kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jun 22 00:18:42 grinch kernel: Inspecting /boot/System.map
Jun 22 00:18:42 grinch kernel: Symbol table has incorrect version number.
Jun 22 00:18:42 grinch kernel: Cannot find map file.
Jun 22 00:18:42 grinch kernel: No module symbols loaded - kernel modules
not enabled.
Jun 22 00:18:42 grinch kernel: Linux version 2.5.72-mm2 (root@grinch) (gcc
version 3.3) #3 Sat Jun 21 21:31:14 EEST 2003
Jun 22 00:18:42 grinch kernel: Video mode to be used for restore is 309
Jun 22 00:18:42 grinch kernel: BIOS-provided physical RAM map:
Jun 22 00:18:42 grinch kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Jun 22 00:18:42 grinch kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Jun 22 00:18:42 grinch kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Jun 22 00:18:42 grinch kernel:  BIOS-e820: 0000000000100000 -
000000000fff0000 (usable)
Jun 22 00:18:42 grinch kernel:  BIOS-e820: 000000000fff0000 -
000000000fff3000 (ACPI NVS)
Jun 22 00:18:42 grinch kernel:  BIOS-e820: 000000000fff3000 -
0000000010000000 (ACPI data)
Jun 22 00:18:42 grinch kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
Jun 22 00:18:42 grinch kernel: 255MB LOWMEM available.
Jun 22 00:18:42 grinch kernel: On node 0 totalpages: 65520
Jun 22 00:18:42 grinch kernel:   DMA zone: 4096 pages, LIFO batch:1
Jun 22 00:18:42 grinch kernel:   Normal zone: 61424 pages, LIFO batch:14
Jun 22 00:18:42 grinch kernel:   HighMem zone: 0 pages, LIFO batch:1
Jun 22 00:18:42 grinch kernel: Building zonelist for node : 0
Jun 22 00:18:42 grinch kernel: Kernel command line: BOOT_IMAGE=k2572mm2 ro
root=306 3
Jun 22 00:18:42 grinch kernel: Local APIC disabled by BIOS -- reenabling.
Jun 22 00:18:42 grinch kernel: Found and enabled local APIC!
Jun 22 00:18:42 grinch kernel: Initializing CPU#0
Jun 22 00:18:42 grinch kernel: PID hash table entries: 1024 (order 10:
8192 bytes)
Jun 22 00:18:43 grinch kernel: Detected 700.083 MHz processor.
Jun 22 00:18:43 grinch kernel: Console: colour VGA+ 132x25
Jun 22 00:18:43 grinch sshd[87]: Server listening on 0.0.0.0 port 22.
Jun 22 00:18:43 grinch kernel: Calibrating delay loop... 1395.91 BogoMIPS
Jun 22 00:18:43 grinch kernel: Memory: 253576k/262080k available (3272k
kernel code, 7776k reserved, 919k data, 364k init, 0k highmem)
Jun 22 00:18:43 grinch kernel: Checking if this processor honours the WP
bit even in supervisor mode... Ok.
Jun 22 00:18:43 grinch kernel: Dentry cache hash table entries: 32768
(order: 5, 131072 bytes)
Jun 22 00:18:43 grinch kernel: Inode-cache hash table entries: 16384
(order: 4, 65536 bytes)
Jun 22 00:18:43 grinch kernel: Mount-cache hash table entries: 512 (order:
0, 4096 bytes)
Jun 22 00:18:43 grinch kernel: -> /dev
Jun 22 00:18:43 grinch kernel: -> /dev/console
Jun 22 00:18:43 grinch kernel: -> /root
Jun 22 00:18:43 grinch kernel: CPU: L1 I Cache: 64K (64 bytes/line), D
cache 64K (64 bytes/line)
Jun 22 00:18:43 grinch kernel: CPU: L2 Cache: 64K (64 bytes/line)
Jun 22 00:18:43 grinch kernel: CPU:     After generic, caps: 0183fbf7
c1c7fbff 00000000 00000020
Jun 22 00:18:43 grinch kernel: Intel machine check architecture supported.
Jun 22 00:18:43 grinch kernel: Intel machine check reporting enabled on
CPU#0.
Jun 22 00:18:43 grinch kernel: CPU: AMD Duron(tm) Processor stepping 01
Jun 22 00:18:43 grinch kernel: Enabling fast FPU save and restore... done.
Jun 22 00:18:43 grinch kernel: Checking 'hlt' instruction... OK.
Jun 22 00:18:43 grinch kernel: POSIX conformance testing by UNIFIX
Jun 22 00:18:43 grinch kernel: enabled ExtINT on CPU#0
Jun 22 00:18:43 grinch kernel: ESR value before enabling vector: 00000000
Jun 22 00:18:43 grinch kernel: ESR value after enabling vector: 00000000
Jun 22 00:18:43 grinch kernel: Using local APIC timer interrupts.
Jun 22 00:18:43 grinch kernel: calibrating APIC timer ...
Jun 22 00:18:43 grinch kernel: ..... CPU clock speed is 700.0358 MHz.
Jun 22 00:18:43 grinch kernel: ..... host bus clock speed is 200.0102 MHz.
Jun 22 00:18:43 grinch kernel: Initializing RT netlink socket
Jun 22 00:18:43 grinch kernel: PCI: Using configuration type 1
Jun 22 00:18:43 grinch kernel: mtrr: v2.0 (20020519)
Jun 22 00:18:43 grinch kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Jun 22 00:18:43 grinch kernel: biovec pool[0]:   1 bvecs: 256 entries (12
bytes)
Jun 22 00:18:43 grinch kernel: biovec pool[1]:   4 bvecs: 256 entries (48
bytes)
Jun 22 00:18:43 grinch kernel: biovec pool[2]:  16 bvecs: 256 entries (192
bytes)
Jun 22 00:18:43 grinch kernel: biovec pool[3]:  64 bvecs: 256 entries (768
bytes)
Jun 22 00:18:43 grinch kernel: biovec pool[4]: 128 bvecs: 256 entries
(1536 bytes)
Jun 22 00:18:43 grinch kernel: biovec pool[5]: 256 bvecs: 256 entries
(3072 bytes)
Jun 22 00:18:43 grinch kernel: Linux Plug and Play Support v0.96 (c) Adam
Belay
Jun 22 00:18:43 grinch kernel: pnp: the driver 'system' has been registered
Jun 22 00:18:43 grinch kernel: PnPBIOS: Scanning system for PnP BIOS
support...
Jun 22 00:18:43 grinch kernel: PnPBIOS: Found PnP BIOS installation
structure at 0xc00fbdf0
Jun 22 00:18:43 grinch kernel: PnPBIOS: PnP BIOS version 1.0, entry
0xf0000:0xbe20, dseg 0xf0000
Jun 22 00:18:43 grinch kernel: pnp: match found with the PnP device
'00:07' and the driver 'system'
Jun 22 00:18:43 grinch kernel: pnp: match found with the PnP device
'00:08' and the driver 'system'
Jun 22 00:18:43 grinch kernel: pnp: match found with the PnP device
'00:0b' and the driver 'system'
Jun 22 00:18:43 grinch kernel: PnPBIOS: 16 nodes reported by PnP BIOS; 16
recorded by driver
Jun 22 00:18:43 grinch kernel: PCI: Probing PCI hardware
Jun 22 00:18:43 grinch kernel: PCI: Probing PCI hardware (bus 00)
Jun 22 00:18:43 grinch kernel: Disabling VIA memory write queue (PCI ID
0305, rev 02): [55] 81 & 1f -> 01
Jun 22 00:18:43 grinch kernel: PCI: Using IRQ router VIA [1106/0686] at
00:07.0
Jun 22 00:18:43 grinch kernel: irda_init()
Jun 22 00:18:43 grinch kernel: pty: 512 Unix98 ptys configured
Jun 22 00:18:43 grinch kernel: Machine check exception polling timer started.
Jun 22 00:18:43 grinch kernel: apm: BIOS version 1.2 Flags 0x07 (Driver
version 1.16ac)
Jun 22 00:18:43 grinch kernel: Enabling SEP on CPU 0
Jun 22 00:18:43 grinch kernel: Journalled Block Device driver loaded
Jun 22 00:18:43 grinch kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Jun 22 00:18:43 grinch kernel: udf: registering filesystem
Jun 22 00:18:43 grinch kernel: SGI XFS for Linux 2.5.72-mm2 with no debug
enabled
Jun 22 00:18:43 grinch kernel: PCI: Disabling Via external APIC routing
Jun 22 00:18:43 grinch kernel: isapnp: Scanning for PnP cards...
Jun 22 00:18:43 grinch kernel: isapnp: Card 'Crystal Codec'
Jun 22 00:18:43 grinch kernel: isapnp: 1 Plug & Play card detected total
Jun 22 00:18:43 grinch kernel: request_module: failed /sbin/modprobe --
parport_lowlevel. error = -16
Jun 22 00:18:43 grinch kernel: lp: driver loaded but no devices found
Jun 22 00:18:43 grinch kernel: Real Time Clock Driver v1.11
Jun 22 00:18:43 grinch kernel: Non-volatile memory driver v1.2
Jun 22 00:18:43 grinch kernel: Linux agpgart interface v0.100 (c) Dave Jones
Jun 22 00:18:43 grinch kernel: agpgart: Detected VIA Apollo Pro
KT133/KM133/TwisterK chipset
Jun 22 00:18:43 grinch kernel: agpgart: Maximum main memory to use for agp
memory: 203M
Jun 22 00:18:43 grinch kernel: agpgart: AGP aperture is 128M @ 0xd0000000
Jun 22 00:18:43 grinch kernel: [drm] Initialized radeon 1.8.0 20020828 on
minor 0
Jun 22 00:18:43 grinch kernel: Serial: 8250/16550 driver $Revision: 1.90 $
IRQ sharing disabled
Jun 22 00:18:43 grinch kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 22 00:18:43 grinch kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jun 22 00:18:43 grinch kernel: pnp: the driver 'serial' has been registered
Jun 22 00:18:43 grinch kernel: pnp: match found with the PnP device
'00:0d' and the driver 'serial'
Jun 22 00:18:43 grinch kernel: pnp: match found with the PnP device
'00:0e' and the driver 'serial'
Jun 22 00:18:43 grinch kernel: pnp: the driver 'parport_pc' has been
registered
Jun 22 00:18:43 grinch kernel: pnp: match found with the PnP device
'00:10' and the driver 'parport_pc'
Jun 22 00:18:43 grinch kernel: parport0: PC-style at 0x3bc (0x7bc)
[PCSPP,TRISTATE]
Jun 22 00:18:43 grinch kernel: parport0: cpp_daisy: aa5500ff(38)
Jun 22 00:18:43 grinch kernel: parport0: assign_addrs: aa5500ff(38)
Jun 22 00:18:43 grinch kernel: parport0: cpp_daisy: aa5500ff(38)
Jun 22 00:18:43 grinch kernel: parport0: assign_addrs: aa5500ff(38)
Jun 22 00:18:43 grinch kernel: lp0: using parport0 (polling).
Jun 22 00:18:43 grinch kernel: lp0: console ready
Jun 22 00:18:43 grinch kernel: parport_pc: Via 686A parallel port: io=0x3BC
Jun 22 00:18:43 grinch kernel: anticipatory scheduling elevator
Jun 22 00:18:43 grinch kernel: Floppy drive(s): fd0 is 1.44M
Jun 22 00:18:43 grinch kernel: FDC 0 is a post-1991 82077
Jun 22 00:18:43 grinch kernel: loop: loaded (max 8 devices)
Jun 22 00:18:43 grinch kernel: 8139too Fast Ethernet driver 0.9.26
Jun 22 00:18:43 grinch kernel: PCI: Found IRQ 10 for device 00:08.0
Jun 22 00:18:43 grinch kernel: eth0: RealTek RTL8139 Fast Ethernet at
0xd0883000, 00:40:f4:72:99:b3, IRQ 10
Jun 22 00:18:43 grinch kernel: eth0:  Identified 8139 chip type 'RTL-8139C'
Jun 22 00:18:43 grinch kernel: PCI: Found IRQ 11 for device 00:0a.0
Jun 22 00:18:43 grinch kernel: eth1: RealTek RTL8139 Fast Ethernet at
0xd0885000, 00:40:f4:74:6d:fb, IRQ 11
Jun 22 00:18:43 grinch kernel: eth1:  Identified 8139 chip type 'RTL-8139C'
Jun 22 00:18:43 grinch kernel: Linux video capture interface: v1.00
Jun 22 00:18:43 grinch kernel: bttv: driver version 0.9.4 loaded
Jun 22 00:18:43 grinch kernel: bttv: using 8 buffers with 2080k (520
pages) each for capture
Jun 22 00:18:43 grinch kernel: bttv: Host bridge is VIA Technologies, In
VT8363/8365 [KT133/K
Jun 22 00:18:43 grinch kernel: bttv: Host bridge is VIA Technologies, In
VT82C686 [Apollo Sup
Jun 22 00:18:43 grinch kernel: bttv: Bt8xx card found (0).
Jun 22 00:18:43 grinch kernel: PCI: Found IRQ 9 for device 00:09.0
Jun 22 00:18:43 grinch kernel: PCI: Sharing IRQ 9 with 00:09.1
Jun 22 00:18:43 grinch kernel: bttv0: Bt878 (rev 2) at 00:09.0, irq: 9,
latency: 32, mmio: 0xe2001000
Jun 22 00:18:43 grinch kernel: bttv0: detected: AVermedia TVCapture 98
[card=13], PCI subsystem ID is 1461:0002
Jun 22 00:18:43 grinch kernel: bttv0: using: BT878(AVerMedia TVCapture 98)
[card=13,autodetected]
Jun 22 00:18:43 grinch kernel: bttv0: Avermedia eeprom[0x4011]: tuner=5
radio:no remote control:yes
Jun 22 00:18:43 grinch kernel: bttv0: using tuner=5
Jun 22 00:18:43 grinch kernel: bttv0: i2c: checking for MSP34xx @ 0x80...
not found
Jun 22 00:18:43 grinch kernel: bttv0: i2c: checking for TDA9875 @ 0xb0...
not found
Jun 22 00:18:43 grinch kernel: bttv0: i2c: checking for TDA7432 @ 0x8a...
not found
Jun 22 00:18:43 grinch kernel: bttv0: registered device video0
Jun 22 00:18:43 grinch kernel: bttv0: registered device vbi0
Jun 22 00:18:43 grinch kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Jun 22 00:18:43 grinch kernel: tvaudio: TV audio decoder + audio/video mux
driver
Jun 22 00:18:43 grinch kernel: tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54
(PV951),ta8874z
Jun 22 00:18:43 grinch kernel: tuner: chip found @ 0xc2
Jun 22 00:18:43 grinch kernel: tuner: type set to 5 (Philips PAL_BG
(FI1216 and compatibles))
Jun 22 00:18:43 grinch kernel: registering 0-0061
Jun 22 00:18:43 grinch kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Jun 22 00:18:43 grinch kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Jun 22 00:18:43 grinch kernel: VP_IDE: IDE controller at PCI slot 00:07.1
Jun 22 00:18:43 grinch kernel: VP_IDE: chipset revision 16
Jun 22 00:18:43 grinch kernel: VP_IDE: not 100%% native mode: will probe
irqs later
Jun 22 00:18:43 grinch kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Jun 22 00:18:43 grinch kernel: VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66
controller on pci00:07.1
Jun 22 00:18:43 grinch kernel:     ide0: BM-DMA at 0xd000-0xd007, BIOS
settings: hda:DMA, hdb:pio
Jun 22 00:18:43 grinch kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS
settings: hdc:DMA, hdd:pio
Jun 22 00:18:43 grinch kernel: hda: Maxtor 2F040J0, ATA DISK drive
Jun 22 00:18:43 grinch kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 22 00:18:43 grinch kernel: hdc: SONY CDU4811, ATAPI CD/DVD-ROM drive
Jun 22 00:18:43 grinch kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 22 00:18:43 grinch rpc.statd[112]: Version 1.0.3 Starting
Jun 22 00:18:43 grinch kernel: hda: max request size: 128KiB
Jun 22 00:18:43 grinch kernel: hda: host protected area => 1
Jun 22 00:18:44 grinch kernel: hda: 80293248 sectors (41110 MB) w/2048KiB
Cache, CHS=79656/16/63, UDMA(66)
Jun 22 00:18:44 grinch kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7
hda8 hda9 >
Jun 22 00:18:44 grinch kernel: hdc: ATAPI 48X CD-ROM drive, 120kB Cache,
UDMA(33)
Jun 22 00:18:44 grinch kernel: Uniform CD-ROM driver Revision: 3.12
Jun 22 00:18:44 grinch crond[141]: /usr/sbin/crond 2.3.2 dillon, started,
log level 8
Jun 22 00:18:44 grinch atd[136]: Cannot change to /var/spool/atjobs:
Permission denied
Jun 22 00:18:45 grinch kernel: mice: PS/2 mouse device common for all mice
Jun 22 00:18:45 grinch kernel: input: PC Speaker
Jun 22 00:18:45 grinch kernel: input: PS/2 Generic Mouse on isa0060/serio1
Jun 22 00:18:45 grinch kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 22 00:18:45 grinch kernel: input: AT Set 2 keyboard on isa0060/serio0
Jun 22 00:18:45 grinch kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 22 00:18:45 grinch kernel: i2c /dev entries driver module version
2.7.0 (20021208)
Jun 22 00:18:45 grinch kernel: pnp: the driver 'cs4232' has been registered
Jun 22 00:18:45 grinch kernel: pnp: match found with the PnP device
'01:01.00' and the driver 'cs4232'
Jun 22 00:18:45 grinch kernel: pnp: res: the device '01:01.00' has been
activated.
Jun 22 00:18:45 grinch kernel: <Crystal audio controller (CS4239)> at
0x534 irq 5 dma 1,1
Jun 22 00:18:45 grinch kernel: ad1848: Interrupt test failed (IRQ5)
Jun 22 00:18:45 grinch kernel: ad1848/cs4248 codec driver Copyright (C) by
Hannu Savolainen 1993-1996
Jun 22 00:18:45 grinch kernel: ad1848: No ISAPnP cards found, trying
standard ones...
Jun 22 00:18:45 grinch kernel: btaudio: driver version 0.7 loaded
[digital+analog]
Jun 22 00:18:45 grinch kernel: PCI: Found IRQ 9 for device 00:09.1
Jun 22 00:18:45 grinch kernel: PCI: Sharing IRQ 9 with 00:09.0
Jun 22 00:18:45 grinch kernel: btaudio: Bt878 (rev 2) at 00:09.1, irq: 9,
latency: 32, mmio: 0xe2002000
Jun 22 00:18:45 grinch kernel: btaudio: using card config "default"
Jun 22 00:18:45 grinch kernel: btaudio: registered device dsp1 [digital]
Jun 22 00:18:45 grinch kernel: btaudio: registered device dsp2 [analog]
Jun 22 00:18:45 grinch kernel: btaudio: registered device mixer1
Jun 22 00:18:45 grinch kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jun 22 00:18:45 grinch kernel: IP: routing cache hash table of 2048
buckets, 16Kbytes
Jun 22 00:18:45 grinch kernel: TCP: Hash tables configured (established
16384 bind 32768)
Jun 22 00:18:45 grinch kernel: ip_conntrack version 2.1 (2047 buckets,
16376 max) - 300 bytes per conntrack
Jun 22 00:18:45 grinch kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jun 22 00:18:45 grinch kernel: arp_tables: (C) 2002 David S. Miller
Jun 22 00:18:45 grinch kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Jun 22 00:18:45 grinch kernel: irlan_init()
Jun 22 00:18:45 grinch kernel: irlan_register_netdev()
Jun 22 00:18:45 grinch kernel: IrCOMM protocol (Dag Brattli)
Jun 22 00:18:45 grinch kernel: You didn't specify the type of your ufs
filesystem
Jun 22 00:18:45 grinch kernel:
Jun 22 00:18:45 grinch kernel: mount -t ufs -o
ufstype=sun|sunx86|44bsd|old|hp|nextstep|netxstep-cd|openstep ...
Jun 22 00:18:45 grinch kernel:
Jun 22 00:18:45 grinch kernel: >>>WARNING<<< Wrong ufstype may corrupt
your filesystem, default is ufstype=old
Jun 22 00:18:45 grinch kernel: ufs_read_super: bad magic number
Jun 22 00:18:45 grinch kernel: UDF-fs DEBUG
fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not
supported: rc=-22
Jun 22 00:18:45 grinch kernel: UDF-fs DEBUG
fs/udf/super.c:1472:udf_fill_super: Multi-session=0
Jun 22 00:18:45 grinch kernel: UDF-fs DEBUG fs/udf/super.c:460:udf_vrs:
Starting at sector 16 (2048 byte sectors)
Jun 22 00:18:45 grinch kernel: UDF-fs: No VRS found
Jun 22 00:18:45 grinch kernel: sh-2021: reiserfs_fill_super: can not find
reiserfs on hda6
Jun 22 00:18:45 grinch kernel: VFS: Mounted root (jfs filesystem) readonly.
Jun 22 00:18:45 grinch kernel: Freeing unused kernel memory: 364k freed
Jun 22 00:18:46 grinch kernel: spurious 8259A interrupt: IRQ7.
Jun 22 00:18:46 grinch kernel: Adding 530108k swap on /dev/hda7. 
Priority:-1 extents:1
Jun 22 00:18:46 grinch kernel: eth0: Setting half-duplex based on
auto-negotiated partner ability 0000.
Jun 22 00:18:46 grinch kernel: process `syslogd' is using obsolete
setsockopt SO_BSDCOMPAT
Jun 22 00:18:49 grinch sendmail[147]: starting daemon (8.11.4):
SMTP+queueing@00:15:00
Jun 22 00:18:50 grinch kernel: eth1: Setting half-duplex based on
auto-negotiated partner ability 0000.
Jun 22 00:19:37 grinch login[160]: ROOT LOGIN on `tty1'
Jun 22 00:20:05 grinch kernel: Unable to handle kernel paging request at
virtual address ce379000
Jun 22 00:20:05 grinch kernel:  printing eip:
Jun 22 00:20:05 grinch kernel: c02cd3a7
Jun 22 00:20:05 grinch kernel: *pde = 00037067
Jun 22 00:20:05 grinch kernel: *pte = 0e379000
Jun 22 00:20:05 grinch kernel: Oops: 0000 [#1]
Jun 22 00:20:05 grinch kernel: PREEMPT DEBUG_PAGEALLOC
Jun 22 00:20:05 grinch kernel: CPU:    0
Jun 22 00:20:05 grinch kernel: EIP:    0060:[<c02cd3a7>]    Not tainted VLI
Jun 22 00:20:05 grinch kernel: EFLAGS: 00010206
Jun 22 00:20:05 grinch kernel: EIP is at _mmx_memcpy+0x67/0x170
Jun 22 00:20:05 grinch kernel: eax: c1f08de0   ebx: 0000002d   ecx:
d08210d8   edx: c91bc000
Jun 22 00:20:05 grinch kernel: esi: ce378fec   edi: c1f07f20   ebp:
00001a00   esp: cddb5d10
Jun 22 00:20:05 grinch kernel: ds: 007b   es: 007b   ss: 0068
Jun 22 00:20:05 grinch kernel: Process rm (pid: 182, threadinfo=cddb4000
task=c91bc000)
Jun 22 00:20:05 grinch kernel: Stack: c1f07f20 d08210e2 ce37812c c1f07f20
cccb24cc c023efff c1f08de0 ce37812c
Jun 22 00:20:05 grinch kernel:        00001a00 00008001 00000000 00000000
000179b6 00000000 c1f06ee0 ce3770ec
Jun 22 00:20:05 grinch kernel:        c024778c ce37720c 00000000 00000000
00000001 d08210d8 d0821094 cf20920c
Jun 22 00:20:05 grinch kernel: Call Trace:
Jun 22 00:20:05 grinch kernel:  [<c023efff>] diWrite+0x50f/0x6a0
Jun 22 00:20:05 grinch kernel:  [<c024778c>] add_index+0x2dc/0x480
Jun 22 00:20:05 grinch kernel:  [<c0252c63>] txCommit+0x193/0x300
Jun 22 00:20:05 grinch kernel:  [<c0168d5b>] d_splice_alias+0x4b/0x100
Jun 22 00:20:05 grinch kernel:  [<c0119418>] kernel_map_pages+0x28/0x90
Jun 22 00:20:05 grinch kernel:  [<c0170e9e>] __mark_inode_dirty+0xde/0xf0
Jun 22 00:20:05 grinch kernel:  [<c024b602>] add_missing_indices+0x1c2/0x290
Jun 22 00:20:05 grinch kernel:  [<c024bd17>] jfs_readdir+0x647/0xb60
Jun 22 00:20:05 grinch kernel:  [<c025770f>] jfs_permission+0x1f/0x30
Jun 22 00:20:05 grinch kernel:  [<c0150000>] chown_common+0x60/0xf0
Jun 22 00:20:05 grinch kernel:  [<c01634bc>] vfs_readdir+0x7c/0x80
Jun 22 00:20:05 grinch kernel:  [<c01637e0>] filldir64+0x0/0x110
Jun 22 00:20:05 grinch kernel:  [<c0163971>] sys_getdents64+0x81/0xcf
Jun 22 00:20:05 grinch kernel:  [<c01637e0>] filldir64+0x0/0x110
Jun 22 00:20:05 grinch kernel:  [<c0109107>] syscall_call+0x7/0xb
Jun 22 00:20:05 grinch kernel:
Jun 22 00:20:05 grinch kernel: Code: 0d 86 80 00 00 00 0f 0d 86 c0 00 00
00 0f 0d 86 00 01 00 00 83 fb 05 7e 59 8b 44 24 18 0f 0d 86 40 01 00 00 0f
6f 06 0f 6f 4e 08 <0f> 6f 56 10 0f 6f 5e 18 0f 7f 00 0f 7f 48 08 0f 7f 50
10 0f 7f
Jun 22 00:20:05 grinch kernel:  <6>note: rm[182] exited with preempt_count 1


Bye

Calin


-- 
# fortune
fortune: write error on /dev/null --- please empty the bit bucket


-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/


------=_20030623133421_74004
Content-Type: application/octet-stream; name="config"
Content-Disposition: attachment; filename="config"
Content-Transfer-Encoding: base64

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMKQ09O
RklHX1g4Nj15CkNPTkZJR19NTVU9eQpDT05GSUdfVUlEMTY9eQpDT05GSUdfR0VORVJJQ19JU0Ff
RE1BPXkKCiMKIyBDb2RlIG1hdHVyaXR5IGxldmVsIG9wdGlvbnMKIwpDT05GSUdfRVhQRVJJTUVO
VEFMPXkKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklHX1NXQVA9eQpDT05GSUdfU1lTVklQQz15
CiMgQ09ORklHX0JTRF9QUk9DRVNTX0FDQ1QgaXMgbm90IHNldApDT05GSUdfU1lTQ1RMPXkKQ09O
RklHX0xPR19CVUZfU0hJRlQ9MTQKIyBDT05GSUdfRU1CRURERUQgaXMgbm90IHNldApDT05GSUdf
RlVURVg9eQpDT05GSUdfRVBPTEw9eQoKIwojIExvYWRhYmxlIG1vZHVsZSBzdXBwb3J0CiMKQ09O
RklHX01PRFVMRVM9eQpDT05GSUdfTU9EVUxFX1VOTE9BRD15CkNPTkZJR19NT0RVTEVfRk9SQ0Vf
VU5MT0FEPXkKQ09ORklHX09CU09MRVRFX01PRFBBUk09eQojIENPTkZJR19NT0RWRVJTSU9OUyBp
cyBub3Qgc2V0CkNPTkZJR19LTU9EPXkKCiMKIyBQcm9jZXNzb3IgdHlwZSBhbmQgZmVhdHVyZXMK
IwpDT05GSUdfWDg2X1BDPXkKIyBDT05GSUdfWDg2X1ZPWUFHRVIgaXMgbm90IHNldAojIENPTkZJ
R19YODZfTlVNQVEgaXMgbm90IHNldAojIENPTkZJR19YODZfU1VNTUlUIGlzIG5vdCBzZXQKIyBD
T05GSUdfWDg2X0JJR1NNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9WSVNXUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1g4Nl9HRU5FUklDQVJDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9FUzcwMDAg
aXMgbm90IHNldAojIENPTkZJR19NMzg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTTQ4NiBpcyBub3Qg
c2V0CiMgQ09ORklHX001ODYgaXMgbm90IHNldAojIENPTkZJR19NNTg2VFNDIGlzIG5vdCBzZXQK
IyBDT05GSUdfTTU4Nk1NWCBpcyBub3Qgc2V0CiMgQ09ORklHX002ODYgaXMgbm90IHNldAojIENP
TkZJR19NUEVOVElVTUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBFTlRJVU1JSUkgaXMgbm90IHNl
dAojIENPTkZJR19NUEVOVElVTTQgaXMgbm90IHNldAojIENPTkZJR19NSzYgaXMgbm90IHNldApD
T05GSUdfTUs3PXkKIyBDT05GSUdfTUs4IGlzIG5vdCBzZXQKIyBDT05GSUdfTUVMQU4gaXMgbm90
IHNldAojIENPTkZJR19NQ1JVU09FIGlzIG5vdCBzZXQKIyBDT05GSUdfTVdJTkNISVBDNiBpcyBu
b3Qgc2V0CiMgQ09ORklHX01XSU5DSElQMiBpcyBub3Qgc2V0CiMgQ09ORklHX01XSU5DSElQM0Qg
aXMgbm90IHNldAojIENPTkZJR19NQ1lSSVhJSUkgaXMgbm90IHNldAojIENPTkZJR19NVklBQzNf
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9HRU5FUklDIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9D
TVBYQ0hHPXkKQ09ORklHX1g4Nl9YQUREPXkKQ09ORklHX1g4Nl9MMV9DQUNIRV9TSElGVD02CkNP
TkZJR19SV1NFTV9YQ0hHQUREX0FMR09SSVRITT15CkNPTkZJR19YODZfV1BfV09SS1NfT0s9eQpD
T05GSUdfWDg2X0lOVkxQRz15CkNPTkZJR19YODZfQlNXQVA9eQpDT05GSUdfWDg2X1BPUEFEX09L
PXkKQ09ORklHX1g4Nl9HT09EX0FQSUM9eQpDT05GSUdfWDg2X0lOVEVMX1VTRVJDT1BZPXkKQ09O
RklHX1g4Nl9VU0VfUFBST19DSEVDS1NVTT15CkNPTkZJR19YODZfVVNFXzNETk9XPXkKIyBDT05G
SUdfSFVHRVRMQl9QQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfU01QIGlzIG5vdCBzZXQKQ09ORklH
X1BSRUVNUFQ9eQpDT05GSUdfWDg2X1VQX0FQSUM9eQpDT05GSUdfWDg2X1VQX0lPQVBJQz15CkNP
TkZJR19YODZfTE9DQUxfQVBJQz15CkNPTkZJR19YODZfSU9fQVBJQz15CkNPTkZJR19YODZfVFND
PXkKQ09ORklHX1g4Nl9NQ0U9eQpDT05GSUdfWDg2X01DRV9OT05GQVRBTD15CiMgQ09ORklHX1g4
Nl9NQ0VfUDRUSEVSTUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9TSElCQSBpcyBub3Qgc2V0CiMg
Q09ORklHX0k4SyBpcyBub3Qgc2V0CiMgQ09ORklHX01JQ1JPQ09ERSBpcyBub3Qgc2V0CiMgQ09O
RklHX1g4Nl9NU1IgaXMgbm90IHNldApDT05GSUdfWDg2X0NQVUlEPXkKIyBDT05GSUdfRUREIGlz
IG5vdCBzZXQKQ09ORklHX05PSElHSE1FTT15CiMgQ09ORklHX0hJR0hNRU00RyBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJR0hNRU02NEcgaXMgbm90IHNldAojIENPTkZJR18wMjVHQiBpcyBub3Qgc2V0
CiMgQ09ORklHXzA1R0IgaXMgbm90IHNldApDT05GSUdfMUdCPXkKIyBDT05GSUdfMkdCIGlzIG5v
dCBzZXQKIyBDT05GSUdfM0dCIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFUSF9FTVVMQVRJT04gaXMg
bm90IHNldApDT05GSUdfTVRSUj15CkNPTkZJR19IQVZFX0RFQ19MT0NLPXkKCiMKIyBQb3dlciBt
YW5hZ2VtZW50IG9wdGlvbnMgKEFDUEksIEFQTSkKIwpDT05GSUdfUE09eQojIENPTkZJR19TT0ZU
V0FSRV9TVVNQRU5EIGlzIG5vdCBzZXQKCiMKIyBBQ1BJIFN1cHBvcnQKIwojIENPTkZJR19BQ1BJ
IGlzIG5vdCBzZXQKQ09ORklHX0FQTT15CiMgQ09ORklHX0FQTV9JR05PUkVfVVNFUl9TVVNQRU5E
IGlzIG5vdCBzZXQKQ09ORklHX0FQTV9ET19FTkFCTEU9eQojIENPTkZJR19BUE1fQ1BVX0lETEUg
aXMgbm90IHNldAojIENPTkZJR19BUE1fRElTUExBWV9CTEFOSyBpcyBub3Qgc2V0CkNPTkZJR19B
UE1fUlRDX0lTX0dNVD15CiMgQ09ORklHX0FQTV9BTExPV19JTlRTIGlzIG5vdCBzZXQKIyBDT05G
SUdfQVBNX1JFQUxfTU9ERV9QT1dFUl9PRkYgaXMgbm90IHNldAoKIwojIENQVSBGcmVxdWVuY3kg
c2NhbGluZwojCiMgQ09ORklHX0NQVV9GUkVRIGlzIG5vdCBzZXQKCiMKIyBCdXMgb3B0aW9ucyAo
UENJLCBQQ01DSUEsIEVJU0EsIE1DQSwgSVNBKQojCkNPTkZJR19QQ0k9eQojIENPTkZJR19QQ0lf
R09CSU9TIGlzIG5vdCBzZXQKQ09ORklHX1BDSV9HT0RJUkVDVD15CiMgQ09ORklHX1BDSV9HT0FO
WSBpcyBub3Qgc2V0CkNPTkZJR19QQ0lfRElSRUNUPXkKQ09ORklHX1BDSV9MRUdBQ1lfUFJPQz15
CkNPTkZJR19QQ0lfTkFNRVM9eQpDT05GSUdfSVNBPXkKIyBDT05GSUdfRUlTQSBpcyBub3Qgc2V0
CiMgQ09ORklHX01DQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDeDIwMCBpcyBub3Qgc2V0CiMgQ09O
RklHX0hPVFBMVUcgaXMgbm90IHNldAoKIwojIEV4ZWN1dGFibGUgZmlsZSBmb3JtYXRzCiMKQ09O
RklHX0tDT1JFX0VMRj15CiMgQ09ORklHX0tDT1JFX0FPVVQgaXMgbm90IHNldApDT05GSUdfQklO
Rk1UX0VMRj15CiMgQ09ORklHX0JJTkZNVF9BT1VUIGlzIG5vdCBzZXQKIyBDT05GSUdfQklORk1U
X01JU0MgaXMgbm90IHNldAoKIwojIE1lbW9yeSBUZWNobm9sb2d5IERldmljZXMgKE1URCkKIwoj
IENPTkZJR19NVEQgaXMgbm90IHNldAoKIwojIFBhcmFsbGVsIHBvcnQgc3VwcG9ydAojCkNPTkZJ
R19QQVJQT1JUPXkKQ09ORklHX1BBUlBPUlRfUEM9eQpDT05GSUdfUEFSUE9SVF9QQ19DTUwxPXkK
IyBDT05GSUdfUEFSUE9SVF9TRVJJQUwgaXMgbm90IHNldApDT05GSUdfUEFSUE9SVF9QQ19GSUZP
PXkKQ09ORklHX1BBUlBPUlRfUENfU1VQRVJJTz15CiMgQ09ORklHX1BBUlBPUlRfT1RIRVIgaXMg
bm90IHNldApDT05GSUdfUEFSUE9SVF8xMjg0PXkKCiMKIyBQbHVnIGFuZCBQbGF5IHN1cHBvcnQK
IwpDT05GSUdfUE5QPXkKQ09ORklHX1BOUF9OQU1FUz15CkNPTkZJR19QTlBfREVCVUc9eQoKIwoj
IFByb3RvY29scwojCkNPTkZJR19JU0FQTlA9eQpDT05GSUdfUE5QQklPUz15CgojCiMgQmxvY2sg
ZGV2aWNlcwojCkNPTkZJR19CTEtfREVWX0ZEPXkKIyBDT05GSUdfQkxLX0RFVl9YRCBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBUklERSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19DUFFfREEgaXMgbm90
IHNldAojIENPTkZJR19CTEtfQ1BRX0NJU1NfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVW
X0RBQzk2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVU1FTSBpcyBub3Qgc2V0CkNPTkZJ
R19CTEtfREVWX0xPT1A9eQojIENPTkZJR19CTEtfREVWX05CRCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfUkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JTklUUkQgaXMgbm90IHNl
dAojIENPTkZJR19MQkQgaXMgbm90IHNldAoKIwojIEFUQS9BVEFQSS9NRk0vUkxMIHN1cHBvcnQK
IwpDT05GSUdfSURFPXkKCiMKIyBJREUsIEFUQSBhbmQgQVRBUEkgQmxvY2sgZGV2aWNlcwojCkNP
TkZJR19CTEtfREVWX0lERT15CgojCiMgUGxlYXNlIHNlZSBEb2N1bWVudGF0aW9uL2lkZS50eHQg
Zm9yIGhlbHAvaW5mbyBvbiBJREUgZHJpdmVzCiMKIyBDT05GSUdfQkxLX0RFVl9IRF9JREUgaXMg
bm90IHNldAojIENPTkZJR19CTEtfREVWX0hEIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURF
RElTSz15CkNPTkZJR19JREVESVNLX01VTFRJX01PREU9eQojIENPTkZJR19JREVESVNLX1NUUk9L
RSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lERUNEPXkKIyBDT05GSUdfQkxLX0RFVl9JREVG
TE9QUFkgaXMgbm90IHNldAojIENPTkZJR19JREVfVEFTS19JT0NUTCBpcyBub3Qgc2V0CkNPTkZJ
R19JREVfVEFTS0ZJTEVfSU89eQoKIwojIElERSBjaGlwc2V0IHN1cHBvcnQvYnVnZml4ZXMKIwoj
IENPTkZJR19CTEtfREVWX0NNRDY0MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSURFUE5Q
IGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFUENJPXkKQ09ORklHX0JMS19ERVZfR0VORVJJ
Qz15CiMgQ09ORklHX0lERVBDSV9TSEFSRV9JUlEgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9J
REVETUFfUENJPXkKIyBDT05GSUdfQkxLX0RFVl9JREVfVENRIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkxLX0RFVl9PRkZCT0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSURFRE1BX0ZPUkNF
RCBpcyBub3Qgc2V0CkNPTkZJR19JREVETUFfUENJX0FVVE89eQojIENPTkZJR19JREVETUFfT05M
WURJU0sgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVETUE9eQojIENPTkZJR19JREVETUFf
UENJX1dJUCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0FETUE9eQojIENPTkZJR19CTEtfREVW
X0FFQzYyWFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0FMSTE1WDMgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX0FNRDc0WFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0NNRDY0
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVFJJRkxFWCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfQ1k4MkM2OTMgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0NTNTUyMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSFBUMzRYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RF
Vl9IUFQzNjYgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NDMTIwMCBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERVZfUElJWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTlM4NzQxNSBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfT1BUSTYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX0JM
S19ERVZfUERDMjAyWFhfT0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9QREMyMDJYWF9O
RVcgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1JaMTAwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfU1ZXS1MgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NJSU1BR0UgaXMgbm90
IHNldAojIENPTkZJR19CTEtfREVWX1NJUzU1MTMgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVW
X1NMQzkwRTY2IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9UUk0yOTAgaXMgbm90IHNldApD
T05GSUdfQkxLX0RFVl9WSUE4MkNYWFg9eQojIENPTkZJR19JREVfQ0hJUFNFVFMgaXMgbm90IHNl
dApDT05GSUdfSURFRE1BX0FVVE89eQpDT05GSUdfSURFRE1BX0lWQj15CkNPTkZJR19CTEtfREVW
X0lERV9NT0RFUz15CgojCiMgU0NTSSBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklHX1NDU0kgaXMg
bm90IHNldAoKIwojIE9sZCBDRC1ST00gZHJpdmVycyAobm90IFNDU0ksIG5vdCBJREUpCiMKIyBD
T05GSUdfQ0RfTk9fSURFU0NTSSBpcyBub3Qgc2V0CgojCiMgTXVsdGktZGV2aWNlIHN1cHBvcnQg
KFJBSUQgYW5kIExWTSkKIwojIENPTkZJR19NRCBpcyBub3Qgc2V0CgojCiMgRnVzaW9uIE1QVCBk
ZXZpY2Ugc3VwcG9ydAojCgojCiMgSUVFRSAxMzk0IChGaXJlV2lyZSkgc3VwcG9ydCAoRVhQRVJJ
TUVOVEFMKQojCiMgQ09ORklHX0lFRUUxMzk0IGlzIG5vdCBzZXQKCiMKIyBJMk8gZGV2aWNlIHN1
cHBvcnQKIwojIENPTkZJR19JMk8gaXMgbm90IHNldAoKIwojIE5ldHdvcmtpbmcgc3VwcG9ydAoj
CkNPTkZJR19ORVQ9eQoKIwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCkNPTkZJR19QQUNLRVQ9eQpD
T05GSUdfUEFDS0VUX01NQVA9eQpDT05GSUdfTkVUTElOS19ERVY9eQpDT05GSUdfTkVURklMVEVS
PXkKIyBDT05GSUdfTkVURklMVEVSX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1VOSVg9eQojIENP
TkZJR19ORVRfS0VZIGlzIG5vdCBzZXQKQ09ORklHX0lORVQ9eQojIENPTkZJR19JUF9NVUxUSUNB
U1QgaXMgbm90IHNldApDT05GSUdfSVBfQURWQU5DRURfUk9VVEVSPXkKIyBDT05GSUdfSVBfTVVM
VElQTEVfVEFCTEVTIGlzIG5vdCBzZXQKQ09ORklHX0lQX1JPVVRFX01VTFRJUEFUSD15CiMgQ09O
RklHX0lQX1JPVVRFX1RPUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX1JPVVRFX1ZFUkJPU0UgaXMg
bm90IHNldAojIENPTkZJR19JUF9QTlAgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVBJUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9JUEdSRSBpcyBub3Qgc2V0CkNPTkZJR19BUlBEPXkKIyBDT05G
SUdfSU5FVF9FQ04gaXMgbm90IHNldAojIENPTkZJR19TWU5fQ09PS0lFUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0lORVRfQUggaXMgbm90IHNldAojIENPTkZJR19JTkVUX0VTUCBpcyBub3Qgc2V0CiMg
Q09ORklHX0lORVRfSVBDT01QIGlzIG5vdCBzZXQKCiMKIyBJUDogTmV0ZmlsdGVyIENvbmZpZ3Vy
YXRpb24KIwpDT05GSUdfSVBfTkZfQ09OTlRSQUNLPXkKQ09ORklHX0lQX05GX0ZUUD15CkNPTkZJ
R19JUF9ORl9JUkM9eQpDT05GSUdfSVBfTkZfVEZUUD15CiMgQ09ORklHX0lQX05GX0FNQU5EQSBp
cyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX1FVRVVFIGlzIG5vdCBzZXQKQ09ORklHX0lQX05GX0lQ
VEFCTEVTPXkKQ09ORklHX0lQX05GX01BVENIX0xJTUlUPXkKQ09ORklHX0lQX05GX01BVENIX01B
Qz15CkNPTkZJR19JUF9ORl9NQVRDSF9QS1RUWVBFPXkKQ09ORklHX0lQX05GX01BVENIX01BUks9
eQpDT05GSUdfSVBfTkZfTUFUQ0hfTVVMVElQT1JUPXkKQ09ORklHX0lQX05GX01BVENIX1RPUz15
CkNPTkZJR19JUF9ORl9NQVRDSF9FQ049eQpDT05GSUdfSVBfTkZfTUFUQ0hfRFNDUD15CkNPTkZJ
R19JUF9ORl9NQVRDSF9BSF9FU1A9eQpDT05GSUdfSVBfTkZfTUFUQ0hfTEVOR1RIPXkKQ09ORklH
X0lQX05GX01BVENIX1RUTD15CkNPTkZJR19JUF9ORl9NQVRDSF9UQ1BNU1M9eQpDT05GSUdfSVBf
TkZfTUFUQ0hfSEVMUEVSPXkKQ09ORklHX0lQX05GX01BVENIX1NUQVRFPXkKQ09ORklHX0lQX05G
X01BVENIX0NPTk5UUkFDSz15CkNPTkZJR19JUF9ORl9NQVRDSF9VTkNMRUFOPXkKQ09ORklHX0lQ
X05GX01BVENIX09XTkVSPXkKQ09ORklHX0lQX05GX0ZJTFRFUj15CkNPTkZJR19JUF9ORl9UQVJH
RVRfUkVKRUNUPXkKQ09ORklHX0lQX05GX1RBUkdFVF9NSVJST1I9eQpDT05GSUdfSVBfTkZfTkFU
PXkKQ09ORklHX0lQX05GX05BVF9ORUVERUQ9eQpDT05GSUdfSVBfTkZfVEFSR0VUX01BU1FVRVJB
REU9eQpDT05GSUdfSVBfTkZfVEFSR0VUX1JFRElSRUNUPXkKQ09ORklHX0lQX05GX05BVF9MT0NB
TD15CkNPTkZJR19JUF9ORl9OQVRfU05NUF9CQVNJQz15CkNPTkZJR19JUF9ORl9OQVRfSVJDPXkK
Q09ORklHX0lQX05GX05BVF9GVFA9eQpDT05GSUdfSVBfTkZfTkFUX1RGVFA9eQpDT05GSUdfSVBf
TkZfTUFOR0xFPXkKQ09ORklHX0lQX05GX1RBUkdFVF9UT1M9eQpDT05GSUdfSVBfTkZfVEFSR0VU
X0VDTj15CkNPTkZJR19JUF9ORl9UQVJHRVRfRFNDUD15CkNPTkZJR19JUF9ORl9UQVJHRVRfTUFS
Sz15CkNPTkZJR19JUF9ORl9UQVJHRVRfTE9HPXkKQ09ORklHX0lQX05GX1RBUkdFVF9VTE9HPXkK
Q09ORklHX0lQX05GX1RBUkdFVF9UQ1BNU1M9eQpDT05GSUdfSVBfTkZfQVJQVEFCTEVTPXkKQ09O
RklHX0lQX05GX0FSUEZJTFRFUj15CiMgQ09ORklHX0lQVjYgaXMgbm90IHNldAojIENPTkZJR19Y
RlJNX1VTRVIgaXMgbm90IHNldAoKIwojIFNDVFAgQ29uZmlndXJhdGlvbiAoRVhQRVJJTUVOVEFM
KQojCkNPTkZJR19JUFY2X1NDVFBfXz15CiMgQ09ORklHX0lQX1NDVFAgaXMgbm90IHNldAojIENP
TkZJR19BVE0gaXMgbm90IHNldAojIENPTkZJR19WTEFOXzgwMjFRIGlzIG5vdCBzZXQKIyBDT05G
SUdfTExDIGlzIG5vdCBzZXQKIyBDT05GSUdfREVDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfQlJJ
REdFIGlzIG5vdCBzZXQKIyBDT05GSUdfWDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQQiBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9ESVZFUlQgaXMgbm90IHNldAojIENPTkZJR19FQ09ORVQgaXMg
bm90IHNldAojIENPTkZJR19XQU5fUk9VVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0ZBU1RS
T1VURSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9IV19GTE9XQ09OVFJPTCBpcyBub3Qgc2V0Cgoj
CiMgUW9TIGFuZC9vciBmYWlyIHF1ZXVlaW5nCiMKIyBDT05GSUdfTkVUX1NDSEVEIGlzIG5vdCBz
ZXQKCiMKIyBOZXR3b3JrIHRlc3RpbmcKIwojIENPTkZJR19ORVRfUEtUR0VOIGlzIG5vdCBzZXQK
Q09ORklHX05FVERFVklDRVM9eQoKIwojIEFSQ25ldCBkZXZpY2VzCiMKIyBDT05GSUdfQVJDTkVU
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFVNTVkgaXMgbm90IHNldAojIENPTkZJR19CT05ESU5HIGlz
IG5vdCBzZXQKIyBDT05GSUdfRVFVQUxJWkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfVFVOIGlzIG5v
dCBzZXQKIyBDT05GSUdfRVRIRVJUQVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0IxMDAwIGlz
IG5vdCBzZXQKCiMKIyBFdGhlcm5ldCAoMTAgb3IgMTAwTWJpdCkKIwpDT05GSUdfTkVUX0VUSEVS
TkVUPXkKQ09ORklHX01JST15CiMgQ09ORklHX0hBUFBZTUVBTCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NVTkdFTSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfM0NPTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0xBTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TTUMgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfVkVORE9SX1JBQ0FMIGlzIG5vdCBzZXQKCiMKIyBUdWxpcCBmYW1pbHkg
bmV0d29yayBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklHX05FVF9UVUxJUCBpcyBub3Qgc2V0CiMg
Q09ORklHX0FUMTcwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFUENBIGlzIG5vdCBzZXQKIyBDT05G
SUdfSFAxMDAgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVNBIGlzIG5vdCBzZXQKQ09ORklHX05F
VF9QQ0k9eQojIENPTkZJR19QQ05FVDMyIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EODExMV9FVEgg
aXMgbm90IHNldAojIENPTkZJR19BREFQVEVDX1NUQVJGSVJFIGlzIG5vdCBzZXQKIyBDT05GSUdf
QUMzMjAwIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBSSUNPVCBpcyBub3Qgc2V0CiMgQ09ORklHX0I0
NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NTODl4MCBpcyBub3Qgc2V0CiMgQ09ORklHX0RHUlMgaXMg
bm90IHNldAojIENPTkZJR19FRVBSTzEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0UxMDAgaXMgbm90
IHNldAojIENPTkZJR19GRUFMTlggaXMgbm90IHNldAojIENPTkZJR19OQVRTRU1JIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkUyS19QQ0kgaXMgbm90IHNldAojIENPTkZJR184MTM5Q1AgaXMgbm90IHNl
dApDT05GSUdfODEzOVRPTz15CiMgQ09ORklHXzgxMzlUT09fUElPIGlzIG5vdCBzZXQKIyBDT05G
SUdfODEzOVRPT19UVU5FX1RXSVNURVIgaXMgbm90IHNldAojIENPTkZJR184MTM5VE9PXzgxMjkg
aXMgbm90IHNldAojIENPTkZJR184MTM5X09MRF9SWF9SRVNFVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NJUzkwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0VQSUMxMDAgaXMgbm90IHNldAojIENPTkZJR19T
VU5EQU5DRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RMQU4gaXMgbm90IHNldAojIENPTkZJR19WSUFf
UkhJTkUgaXMgbm90IHNldAojIENPTkZJR19ORVRfUE9DS0VUIGlzIG5vdCBzZXQKCiMKIyBFdGhl
cm5ldCAoMTAwMCBNYml0KQojCiMgQ09ORklHX0FDRU5JQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RM
MksgaXMgbm90IHNldAojIENPTkZJR19FMTAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX05TODM4MjAg
aXMgbm90IHNldAojIENPTkZJR19IQU1BQ0hJIGlzIG5vdCBzZXQKIyBDT05GSUdfWUVMTE9XRklO
IGlzIG5vdCBzZXQKIyBDT05GSUdfUjgxNjkgaXMgbm90IHNldAojIENPTkZJR19TSzk4TElOIGlz
IG5vdCBzZXQKIyBDT05GSUdfVElHT04zIGlzIG5vdCBzZXQKCiMKIyBFdGhlcm5ldCAoMTAwMDAg
TWJpdCkKIwojIENPTkZJR19JWEdCIGlzIG5vdCBzZXQKIyBDT05GSUdfRkRESSBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJUFBJIGlzIG5vdCBzZXQKIyBDT05GSUdfUExJUCBpcyBub3Qgc2V0CiMgQ09O
RklHX1BQUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NMSVAgaXMgbm90IHNldAoKIwojIFdpcmVsZXNz
IExBTiAobm9uLWhhbXJhZGlvKQojCiMgQ09ORklHX05FVF9SQURJTyBpcyBub3Qgc2V0CgojCiMg
VG9rZW4gUmluZyBkZXZpY2VzIChkZXBlbmRzIG9uIExMQz15KQojCiMgQ09ORklHX1JDUENJIGlz
IG5vdCBzZXQKQ09ORklHX1NIQVBFUj15CgojCiMgV2FuIGludGVyZmFjZXMKIwojIENPTkZJR19X
QU4gaXMgbm90IHNldAoKIwojIEFtYXRldXIgUmFkaW8gc3VwcG9ydAojCiMgQ09ORklHX0hBTVJB
RElPIGlzIG5vdCBzZXQKCiMKIyBJckRBIChpbmZyYXJlZCkgc3VwcG9ydAojCkNPTkZJR19JUkRB
PXkKCiMKIyBJckRBIHByb3RvY29scwojCkNPTkZJR19JUkxBTj15CkNPTkZJR19JUkNPTU09eQpD
T05GSUdfSVJEQV9VTFRSQT15CgojCiMgSXJEQSBvcHRpb25zCiMKQ09ORklHX0lSREFfQ0FDSEVf
TEFTVF9MU0FQPXkKQ09ORklHX0lSREFfRkFTVF9SUj15CkNPTkZJR19JUkRBX0RFQlVHPXkKCiMK
IyBJbmZyYXJlZC1wb3J0IGRldmljZSBkcml2ZXJzCiMKCiMKIyBTSVIgZGV2aWNlIGRyaXZlcnMK
IwojIENPTkZJR19JUlRUWV9TSVIgaXMgbm90IHNldAoKIwojIERvbmdsZSBzdXBwb3J0CiMKIyBD
T05GSUdfRE9OR0xFIGlzIG5vdCBzZXQKCiMKIyBPbGQgU0lSIGRldmljZSBkcml2ZXJzCiMKIyBD
T05GSUdfSVJUVFlfT0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfSVJQT1JUX1NJUiBpcyBub3Qgc2V0
CgojCiMgT2xkIFNlcmlhbCBkb25nbGUgc3VwcG9ydAojCiMgQ09ORklHX0RPTkdMRV9PTEQgaXMg
bm90IHNldAoKIwojIEZJUiBkZXZpY2UgZHJpdmVycwojCiMgQ09ORklHX05TQ19GSVIgaXMgbm90
IHNldAojIENPTkZJR19XSU5CT05EX0ZJUiBpcyBub3Qgc2V0CiMgQ09ORklHX1RPU0hJQkFfT0xE
IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9TSElCQV9GSVIgaXMgbm90IHNldAojIENPTkZJR19TTUNf
SVJDQ19PTEQgaXMgbm90IHNldAojIENPTkZJR19TTUNfSVJDQ19GSVIgaXMgbm90IHNldAojIENP
TkZJR19BTElfRklSIGlzIG5vdCBzZXQKIyBDT05GSUdfVkxTSV9GSVIgaXMgbm90IHNldAoKIwoj
IElTRE4gc3Vic3lzdGVtCiMKIyBDT05GSUdfSVNETl9CT09MIGlzIG5vdCBzZXQKCiMKIyBUZWxl
cGhvbnkgU3VwcG9ydAojCiMgQ09ORklHX1BIT05FIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBkZXZp
Y2Ugc3VwcG9ydAojCkNPTkZJR19JTlBVVD15CgojCiMgVXNlcmxhbmQgaW50ZXJmYWNlcwojCkNP
TkZJR19JTlBVVF9NT1VTRURFVj15CkNPTkZJR19JTlBVVF9NT1VTRURFVl9QU0FVWD15CkNPTkZJ
R19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWD0xMDI0CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JF
RU5fWT03NjgKIyBDT05GSUdfSU5QVVRfSk9ZREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRf
VFNERVYgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9FVkRFViBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOUFVUX0VWQlVHIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBJL08gZHJpdmVycwojCiMgQ09ORklH
X0dBTUVQT1JUIGlzIG5vdCBzZXQKQ09ORklHX1NPVU5EX0dBTUVQT1JUPXkKQ09ORklHX1NFUklP
PXkKQ09ORklHX1NFUklPX0k4MDQyPXkKQ09ORklHX1NFUklPX1NFUlBPUlQ9eQojIENPTkZJR19T
RVJJT19DVDgyQzcxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX1BBUktCRCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFUklPX1BDSVBTMiBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNlIERyaXZl
cnMKIwpDT05GSUdfSU5QVVRfS0VZQk9BUkQ9eQpDT05GSUdfS0VZQk9BUkRfQVRLQkQ9eQojIENP
TkZJR19LRVlCT0FSRF9TVU5LQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9YVEtCRCBp
cyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX05FV1RPTiBpcyBub3Qgc2V0CkNPTkZJR19JTlBV
VF9NT1VTRT15CkNPTkZJR19NT1VTRV9QUzI9eQojIENPTkZJR19NT1VTRV9QUzJfU1lOQVBUSUNT
IGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9V
U0VfSU5QT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfTE9HSUJNIGlzIG5vdCBzZXQKIyBD
T05GSUdfTU9VU0VfUEMxMTBQQUQgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9KT1lTVElDSyBp
cyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQKQ09ORklHX0lO
UFVUX01JU0M9eQpDT05GSUdfSU5QVVRfUENTUEtSPXkKIyBDT05GSUdfSU5QVVRfVUlOUFVUIGlz
IG5vdCBzZXQKCiMKIyBDaGFyYWN0ZXIgZGV2aWNlcwojCkNPTkZJR19WVD15CkNPTkZJR19WVF9D
T05TT0xFPXkKQ09ORklHX0hXX0NPTlNPTEU9eQojIENPTkZJR19TRVJJQUxfTk9OU1RBTkRBUkQg
aXMgbm90IHNldAoKIwojIFNlcmlhbCBkcml2ZXJzCiMKQ09ORklHX1NFUklBTF84MjUwPXkKIyBD
T05GSUdfU0VSSUFMXzgyNTBfQ09OU09MRSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfODI1MF9F
WFRFTkRFRD15CiMgQ09ORklHX1NFUklBTF84MjUwX01BTllfUE9SVFMgaXMgbm90IHNldAojIENP
TkZJR19TRVJJQUxfODI1MF9TSEFSRV9JUlEgaXMgbm90IHNldApDT05GSUdfU0VSSUFMXzgyNTBf
REVURUNUX0lSUT15CiMgQ09ORklHX1NFUklBTF84MjUwX01VTFRJUE9SVCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFUklBTF84MjUwX1JTQSBpcyBub3Qgc2V0CgojCiMgTm9uLTgyNTAgc2VyaWFsIHBv
cnQgc3VwcG9ydAojCkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19VTklYOThfUFRZUz15CkNP
TkZJR19VTklYOThfUFRZX0NPVU5UPTUxMgpDT05GSUdfUFJJTlRFUj15CkNPTkZJR19MUF9DT05T
T0xFPXkKIyBDT05GSUdfUFBERVYgaXMgbm90IHNldAojIENPTkZJR19USVBBUiBpcyBub3Qgc2V0
CgojCiMgSTJDIHN1cHBvcnQKIwpDT05GSUdfSTJDPXkKQ09ORklHX0kyQ19BTEdPQklUPXkKIyBD
T05GSUdfSTJDX1BISUxJUFNQQVIgaXMgbm90IHNldAojIENPTkZJR19JMkNfRUxWIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX1ZFTExFTUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfU0N4MjAwX0FDQiBp
cyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEdPUENGIGlzIG5vdCBzZXQKQ09ORklHX0kyQ19DSEFS
REVWPXkKCiMKIyBJMkMgSGFyZHdhcmUgU2Vuc29ycyBNYWluYm9hcmQgc3VwcG9ydAojCiMgQ09O
RklHX0kyQ19BTEkxNVgzIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FNRDc1NiBpcyBub3Qgc2V0
CiMgQ09ORklHX0kyQ19BTUQ4MTExIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0k4MDEgaXMgbm90
IHNldAojIENPTkZJR19JMkNfSVNBIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1BJSVg0IGlzIG5v
dCBzZXQKIyBDT05GSUdfSTJDX1NJUzk2WCBpcyBub3Qgc2V0CkNPTkZJR19JMkNfVklBUFJPPXkK
CiMKIyBJMkMgSGFyZHdhcmUgU2Vuc29ycyBDaGlwIHN1cHBvcnQKIwojIENPTkZJR19TRU5TT1JT
X0FETTEwMjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0lUODcgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0xNNzUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNODUgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0xNNzggaXMgbm90IHNldApDT05GSUdfU0VOU09SU19WSUE2
ODZBPXkKIyBDT05GSUdfU0VOU09SU19XODM3ODFEIGlzIG5vdCBzZXQKQ09ORklHX0kyQ19TRU5T
T1I9eQoKIwojIE1pY2UKIwojIENPTkZJR19CVVNNT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1FJ
QzAyX1RBUEUgaXMgbm90IHNldAoKIwojIElQTUkKIwojIENPTkZJR19JUE1JX0hBTkRMRVIgaXMg
bm90IHNldAoKIwojIFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfV0FUQ0hET0cgaXMgbm90IHNl
dAojIENPTkZJR19IV19SQU5ET00gaXMgbm90IHNldApDT05GSUdfTlZSQU09eQpDT05GSUdfUlRD
PXkKIyBDT05GSUdfRFRMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1IzOTY0IGlzIG5vdCBzZXQKIyBD
T05GSUdfQVBQTElDT00gaXMgbm90IHNldAojIENPTkZJR19TT05ZUEkgaXMgbm90IHNldAoKIwoj
IEZ0YXBlLCB0aGUgZmxvcHB5IHRhcGUgZGV2aWNlIGRyaXZlcgojCiMgQ09ORklHX0ZUQVBFIGlz
IG5vdCBzZXQKQ09ORklHX0FHUD15CiMgQ09ORklHX0FHUF9BTEkgaXMgbm90IHNldAojIENPTkZJ
R19BR1BfQU1EIGlzIG5vdCBzZXQKIyBDT05GSUdfQUdQX0FNRF84MTUxIGlzIG5vdCBzZXQKIyBD
T05GSUdfQUdQX0lOVEVMIGlzIG5vdCBzZXQKIyBDT05GSUdfQUdQX05WSURJQSBpcyBub3Qgc2V0
CiMgQ09ORklHX0FHUF9TSVMgaXMgbm90IHNldAojIENPTkZJR19BR1BfU1dPUktTIGlzIG5vdCBz
ZXQKQ09ORklHX0FHUF9WSUE9eQpDT05GSUdfRFJNPXkKIyBDT05GSUdfRFJNX1RERlggaXMgbm90
IHNldAojIENPTkZJR19EUk1fR0FNTUEgaXMgbm90IHNldAojIENPTkZJR19EUk1fUjEyOCBpcyBu
b3Qgc2V0CkNPTkZJR19EUk1fUkFERU9OPXkKIyBDT05GSUdfRFJNX01HQSBpcyBub3Qgc2V0CiMg
Q09ORklHX01XQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFXX0RSSVZFUiBpcyBub3Qgc2V0CiMg
Q09ORklHX0hBTkdDSEVDS19USU1FUiBpcyBub3Qgc2V0CgojCiMgTXVsdGltZWRpYSBkZXZpY2Vz
CiMKQ09ORklHX1ZJREVPX0RFVj15CgojCiMgVmlkZW8gRm9yIExpbnV4CiMKQ09ORklHX1ZJREVP
X1BST0NfRlM9eQoKIwojIFZpZGVvIEFkYXB0ZXJzCiMKQ09ORklHX1ZJREVPX0JUODQ4PXkKIyBD
T05GSUdfVklERU9fUE1TIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fQldRQ0FNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVklERU9fQ1FDQU0gaXMgbm90IHNldAojIENPTkZJR19WSURFT19XOTk2NiBp
cyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX0NQSUEgaXMgbm90IHNldAojIENPTkZJR19WSURFT19T
QUE1MjQ5IGlzIG5vdCBzZXQKIyBDT05GSUdfVFVORVJfMzAzNiBpcyBub3Qgc2V0CiMgQ09ORklH
X1ZJREVPX1NUUkFESVMgaXMgbm90IHNldAojIENPTkZJR19WSURFT19aT1JBTiBpcyBub3Qgc2V0
CiMgQ09ORklHX1ZJREVPX1pSMzYxMjAgaXMgbm90IHNldAojIENPTkZJR19WSURFT19TQUE3MTM0
IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fTVhCIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9f
RFBDIGlzIG5vdCBzZXQKCiMKIyBSYWRpbyBBZGFwdGVycwojCiMgQ09ORklHX1JBRElPX0NBREVU
IGlzIG5vdCBzZXQKIyBDT05GSUdfUkFESU9fUlRSQUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFE
SU9fUlRSQUNLMiBpcyBub3Qgc2V0CiMgQ09ORklHX1JBRElPX0FaVEVDSCBpcyBub3Qgc2V0CiMg
Q09ORklHX1JBRElPX0dFTVRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1JBRElPX0dFTVRFS19QQ0kg
aXMgbm90IHNldAojIENPTkZJR19SQURJT19NQVhJUkFESU8gaXMgbm90IHNldAojIENPTkZJR19S
QURJT19NQUVTVFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFESU9fU0YxNkZNSSBpcyBub3Qgc2V0
CiMgQ09ORklHX1JBRElPX1RFUlJBVEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFESU9fVFJVU1Qg
aXMgbm90IHNldAojIENPTkZJR19SQURJT19UWVBIT09OIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFE
SU9fWk9MVFJJWCBpcyBub3Qgc2V0CgojCiMgRGlnaXRhbCBWaWRlbyBCcm9hZGNhc3RpbmcgRGV2
aWNlcwojCiMgQ09ORklHX0RWQiBpcyBub3Qgc2V0CkNPTkZJR19WSURFT19WSURFT0JVRj15CkNP
TkZJR19WSURFT19UVU5FUj15CkNPTkZJR19WSURFT19CVUY9eQpDT05GSUdfVklERU9fQlRDWD15
CgojCiMgRmlsZSBzeXN0ZW1zCiMKQ09ORklHX0VYVDJfRlM9eQpDT05GSUdfRVhUMl9GU19YQVRU
Uj15CkNPTkZJR19FWFQyX0ZTX1BPU0lYX0FDTD15CiMgQ09ORklHX0VYVDJfRlNfU0VDVVJJVFkg
aXMgbm90IHNldApDT05GSUdfRVhUM19GUz15CkNPTkZJR19FWFQzX0ZTX1hBVFRSPXkKQ09ORklH
X0VYVDNfRlNfUE9TSVhfQUNMPXkKIyBDT05GSUdfRVhUM19GU19TRUNVUklUWSBpcyBub3Qgc2V0
CkNPTkZJR19KQkQ9eQojIENPTkZJR19KQkRfREVCVUcgaXMgbm90IHNldApDT05GSUdfRlNfTUJD
QUNIRT15CkNPTkZJR19SRUlTRVJGU19GUz15CiMgQ09ORklHX1JFSVNFUkZTX0NIRUNLIGlzIG5v
dCBzZXQKIyBDT05GSUdfUkVJU0VSRlNfUFJPQ19JTkZPIGlzIG5vdCBzZXQKQ09ORklHX0pGU19G
Uz15CkNPTkZJR19KRlNfUE9TSVhfQUNMPXkKIyBDT05GSUdfSkZTX0RFQlVHIGlzIG5vdCBzZXQK
IyBDT05GSUdfSkZTX1NUQVRJU1RJQ1MgaXMgbm90IHNldApDT05GSUdfRlNfUE9TSVhfQUNMPXkK
Q09ORklHX1hGU19GUz15CiMgQ09ORklHX1hGU19SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1hGU19R
VU9UQSBpcyBub3Qgc2V0CiMgQ09ORklHX1hGU19QT1NJWF9BQ0wgaXMgbm90IHNldAojIENPTkZJ
R19NSU5JWF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JPTUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfUVVPVEEgaXMgbm90IHNldAojIENPTkZJR19BVVRPRlNfRlMgaXMgbm90IHNldAojIENPTkZJ
R19BVVRPRlM0X0ZTIGlzIG5vdCBzZXQKCiMKIyBDRC1ST00vRFZEIEZpbGVzeXN0ZW1zCiMKQ09O
RklHX0lTTzk2NjBfRlM9eQpDT05GSUdfSk9MSUVUPXkKQ09ORklHX1pJU09GUz15CkNPTkZJR19a
SVNPRlNfRlM9eQpDT05GSUdfVURGX0ZTPXkKCiMKIyBET1MvRkFUL05UIEZpbGVzeXN0ZW1zCiMK
Q09ORklHX0ZBVF9GUz15CkNPTkZJR19NU0RPU19GUz15CkNPTkZJR19WRkFUX0ZTPXkKIyBDT05G
SUdfTlRGU19GUyBpcyBub3Qgc2V0CgojCiMgUHNldWRvIGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BS
T0NfRlM9eQojIENPTkZJR19ERVZGU19GUyBpcyBub3Qgc2V0CkNPTkZJR19ERVZQVFNfRlM9eQoj
IENPTkZJR19ERVZQVFNfRlNfWEFUVFIgaXMgbm90IHNldApDT05GSUdfVE1QRlM9eQpDT05GSUdf
UkFNRlM9eQoKIwojIE1pc2NlbGxhbmVvdXMgZmlsZXN5c3RlbXMKIwojIENPTkZJR19BREZTX0ZT
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUZGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU19GUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0JFRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRlNfRlMgaXMg
bm90IHNldAojIENPTkZJR19FRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19DUkFNRlMgaXMgbm90
IHNldAojIENPTkZJR19WWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBGU19GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1FOWDRGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU1ZfRlMgaXMgbm90
IHNldApDT05GSUdfVUZTX0ZTPXkKIyBDT05GSUdfVUZTX0ZTX1dSSVRFIGlzIG5vdCBzZXQKCiMK
IyBOZXR3b3JrIEZpbGUgU3lzdGVtcwojCkNPTkZJR19ORlNfRlM9eQpDT05GSUdfTkZTX1YzPXkK
IyBDT05GSUdfTkZTX1Y0IGlzIG5vdCBzZXQKQ09ORklHX05GU19ESVJFQ1RJTz15CkNPTkZJR19O
RlNEPXkKQ09ORklHX05GU0RfVjM9eQojIENPTkZJR19ORlNEX1Y0IGlzIG5vdCBzZXQKQ09ORklH
X05GU0RfVENQPXkKQ09ORklHX0xPQ0tEPXkKQ09ORklHX0xPQ0tEX1Y0PXkKQ09ORklHX0VYUE9S
VEZTPXkKQ09ORklHX1NVTlJQQz15CiMgQ09ORklHX1NVTlJQQ19HU1MgaXMgbm90IHNldApDT05G
SUdfU01CX0ZTPXkKIyBDT05GSUdfU01CX05MU19ERUZBVUxUIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q0lGUyBpcyBub3Qgc2V0CiMgQ09ORklHX05DUF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPREFf
RlMgaXMgbm90IHNldAojIENPTkZJR19JTlRFUk1FWlpPX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
QUZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBQYXJ0aXRpb24gVHlwZXMKIwpDT05GSUdfUEFSVElUSU9O
X0FEVkFOQ0VEPXkKIyBDT05GSUdfQUNPUk5fUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdf
T1NGX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FNSUdBX1BBUlRJVElPTiBpcyBub3Qg
c2V0CiMgQ09ORklHX0FUQVJJX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ19QQVJU
SVRJT04gaXMgbm90IHNldApDT05GSUdfTVNET1NfUEFSVElUSU9OPXkKQ09ORklHX0JTRF9ESVNL
TEFCRUw9eQojIENPTkZJR19NSU5JWF9TVUJQQVJUSVRJT04gaXMgbm90IHNldApDT05GSUdfU09M
QVJJU19YODZfUEFSVElUSU9OPXkKIyBDT05GSUdfVU5JWFdBUkVfRElTS0xBQkVMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTERNX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX05FQzk4X1BBUlRJ
VElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NHSV9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJ
R19VTFRSSVhfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VOX1BBUlRJVElPTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0VGSV9QQVJUSVRJT04gaXMgbm90IHNldApDT05GSUdfU01CX05MUz15
CkNPTkZJR19OTFM9eQoKIwojIE5hdGl2ZSBMYW5ndWFnZSBTdXBwb3J0CiMKQ09ORklHX05MU19E
RUZBVUxUPSJpc284ODU5LTIiCkNPTkZJR19OTFNfQ09ERVBBR0VfNDM3PXkKIyBDT05GSUdfTkxT
X0NPREVQQUdFXzczNyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV83NzUgaXMgbm90
IHNldApDT05GSUdfTkxTX0NPREVQQUdFXzg1MD15CkNPTkZJR19OTFNfQ09ERVBBR0VfODUyPXkK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzg1NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV84NTcgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYwIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg2MSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NjIgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYzIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzg2NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjUg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY2IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzg2OSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzYgaXMg
bm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0NPREVQQUdFXzkzMiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85NDkgaXMgbm90
IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODc0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lT
Tzg4NTlfOCBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQ09ERVBBR0VfMTI1MD15CiMgQ09ORklHX05M
U19DT0RFUEFHRV8xMjUxIGlzIG5vdCBzZXQKQ09ORklHX05MU19JU084ODU5XzE9eQpDT05GSUdf
TkxTX0lTTzg4NTlfMj15CiMgQ09ORklHX05MU19JU084ODU5XzMgaXMgbm90IHNldAojIENPTkZJ
R19OTFNfSVNPODg1OV80IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNSBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19JU084ODU5XzYgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1
OV83IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfOSBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19JU084ODU5XzEzIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTQgaXMgbm90
IHNldApDT05GSUdfTkxTX0lTTzg4NTlfMTU9eQojIENPTkZJR19OTFNfS09JOF9SIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0tPSThfVSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfVVRGOD15CgojCiMg
R3JhcGhpY3Mgc3VwcG9ydAojCiMgQ09ORklHX0ZCIGlzIG5vdCBzZXQKQ09ORklHX1ZJREVPX1NF
TEVDVD15CgojCiMgQ29uc29sZSBkaXNwbGF5IGRyaXZlciBzdXBwb3J0CiMKQ09ORklHX1ZHQV9D
T05TT0xFPXkKIyBDT05GSUdfTURBX0NPTlNPTEUgaXMgbm90IHNldApDT05GSUdfRFVNTVlfQ09O
U09MRT15CgojCiMgU291bmQKIwpDT05GSUdfU09VTkQ9eQoKIwojIEFkdmFuY2VkIExpbnV4IFNv
dW5kIEFyY2hpdGVjdHVyZQojCiMgQ09ORklHX1NORCBpcyBub3Qgc2V0CgojCiMgT3BlbiBTb3Vu
ZCBTeXN0ZW0KIwpDT05GSUdfU09VTkRfUFJJTUU9eQpDT05GSUdfU09VTkRfQlQ4Nzg9eQojIENP
TkZJR19TT1VORF9DTVBDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX0VNVTEwSzEgaXMgbm90
IHNldAojIENPTkZJR19TT1VORF9GVVNJT04gaXMgbm90IHNldAojIENPTkZJR19TT1VORF9DUzQy
ODEgaXMgbm90IHNldAojIENPTkZJR19TT1VORF9FUzEzNzAgaXMgbm90IHNldAojIENPTkZJR19T
T1VORF9FUzEzNzEgaXMgbm90IHNldAojIENPTkZJR19TT1VORF9FU1NTT0xPMSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NPVU5EX01BRVNUUk8gaXMgbm90IHNldAojIENPTkZJR19TT1VORF9NQUVTVFJP
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX0lDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5E
X1JNRTk2WFggaXMgbm90IHNldAojIENPTkZJR19TT1VORF9TT05JQ1ZJQkVTIGlzIG5vdCBzZXQK
IyBDT05GSUdfU09VTkRfVFJJREVOVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX01TTkRDTEFT
IGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfTVNORFBJTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NP
VU5EX1ZJQTgyQ1hYWCBpcyBub3Qgc2V0CkNPTkZJR19TT1VORF9PU1M9eQpDT05GSUdfU09VTkRf
VFJBQ0VJTklUPXkKQ09ORklHX1NPVU5EX0RNQVA9eQojIENPTkZJR19TT1VORF9BRDE4MTYgaXMg
bm90IHNldAojIENPTkZJR19TT1VORF9TR0FMQVhZIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRf
QURMSUIgaXMgbm90IHNldAojIENPTkZJR19TT1VORF9BQ0lfTUlYRVIgaXMgbm90IHNldApDT05G
SUdfU09VTkRfQ1M0MjMyPXkKIyBDT05GSUdfU09VTkRfU1NDQVBFIGlzIG5vdCBzZXQKIyBDT05G
SUdfU09VTkRfR1VTIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfVk1JREkgaXMgbm90IHNldAoj
IENPTkZJR19TT1VORF9UUklYIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfTVNTIGlzIG5vdCBz
ZXQKQ09ORklHX1NPVU5EX01QVTQwMT15CiMgQ09ORklHX1NPVU5EX05NMjU2IGlzIG5vdCBzZXQK
IyBDT05GSUdfU09VTkRfTUFEMTYgaXMgbm90IHNldAojIENPTkZJR19TT1VORF9QQVMgaXMgbm90
IHNldAojIENPTkZJR19TT1VORF9QU1MgaXMgbm90IHNldAojIENPTkZJR19TT1VORF9TQiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NPVU5EX0FXRTMyX1NZTlRIIGlzIG5vdCBzZXQKIyBDT05GSUdfU09V
TkRfV0FWRUZST05UIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfTUFVSSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NPVU5EX1lNMzgxMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX09QTDNTQTEgaXMg
bm90IHNldAojIENPTkZJR19TT1VORF9PUEwzU0EyIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRf
WU1GUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfVUFSVDY4NTAgaXMgbm90IHNldAojIENP
TkZJR19TT1VORF9BRURTUDE2IGlzIG5vdCBzZXQKQ09ORklHX1NPVU5EX1RWTUlYRVI9eQoKIwoj
IFVTQiBzdXBwb3J0CiMKIyBDT05GSUdfVVNCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dBREdF
VCBpcyBub3Qgc2V0CgojCiMgQmx1ZXRvb3RoIHN1cHBvcnQKIwojIENPTkZJR19CVCBpcyBub3Qg
c2V0CgojCiMgUHJvZmlsaW5nIHN1cHBvcnQKIwojIENPTkZJR19QUk9GSUxJTkcgaXMgbm90IHNl
dAoKIwojIEtlcm5lbCBoYWNraW5nCiMKQ09ORklHX0RFQlVHX0tFUk5FTD15CkNPTkZJR19ERUJV
R19TVEFDS09WRVJGTE9XPXkKQ09ORklHX0RFQlVHX1NMQUI9eQpDT05GSUdfREVCVUdfSU9WSVJU
PXkKQ09ORklHX01BR0lDX1NZU1JRPXkKIyBDT05GSUdfREVCVUdfU1BJTkxPQ0sgaXMgbm90IHNl
dAojIENPTkZJR19TUElOTElORSBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19QQUdFQUxMT0M9eQpD
T05GSUdfS0FMTFNZTVM9eQojIENPTkZJR19ERUJVR19TUElOTE9DS19TTEVFUCBpcyBub3Qgc2V0
CiMgQ09ORklHX0tHREIgaXMgbm90IHNldApDT05GSUdfREVCVUdfSU5GTz15CiMgQ09ORklHX0ZS
QU1FX1BPSU5URVIgaXMgbm90IHNldApDT05GSUdfWDg2X0VYVFJBX0lSUVM9eQpDT05GSUdfWDg2
X0ZJTkRfU01QX0NPTkZJRz15CkNPTkZJR19YODZfTVBQQVJTRT15CiMgQ09ORklHX1NMRUVQT01F
VEVSIGlzIG5vdCBzZXQKCiMKIyBTZWN1cml0eSBvcHRpb25zCiMKIyBDT05GSUdfU0VDVVJJVFkg
aXMgbm90IHNldAoKIwojIENyeXB0b2dyYXBoaWMgb3B0aW9ucwojCiMgQ09ORklHX0NSWVBUTyBp
cyBub3Qgc2V0CgojCiMgTGlicmFyeSByb3V0aW5lcwojCiMgQ09ORklHX0NSQzMyIGlzIG5vdCBz
ZXQKQ09ORklHX1pMSUJfSU5GTEFURT15CkNPTkZJR19YODZfQklPU19SRUJPT1Q9eQo=
------=_20030623133421_74004
Content-Type: application/octet-stream; name="versions"
Content-Disposition: attachment; filename="versions"
Content-Transfer-Encoding: base64

SWYgc29tZSBmaWVsZHMgYXJlIGVtcHR5IG9yIGxvb2sgdW51c3VhbCB5b3UgbWF5IGhhdmUgYW4g
b2xkIHZlcnNpb24uCkNvbXBhcmUgdG8gdGhlIGN1cnJlbnQgbWluaW1hbCByZXF1aXJlbWVudHMg
aW4gRG9jdW1lbnRhdGlvbi9DaGFuZ2VzLgogCkxpbnV4IGdyaW5jaCAyLjUuNzItbW0yICMzIFNh
dCBKdW4gMjEgMjE6MzE6MTQgRUVTVCAyMDAzIGk2ODYgdW5rbm93bgogCkdudSBDICAgICAgICAg
ICAgICAgICAgMy4zCkdudSBtYWtlICAgICAgICAgICAgICAgMy44MAp1dGlsLWxpbnV4ICAgICAg
ICAgICAgIDIuMTF1Cm1vdW50ICAgICAgICAgICAgICAgICAgMi4xMXUKbW9kdWxlLWluaXQtdG9v
bHMgICAgICAyLjQuMjEKZTJmc3Byb2dzICAgICAgICAgICAgICAxLjMyCmpmc3V0aWxzICAgICAg
ICAgICAgICAgMS4xLjIKcmVpc2VyZnNwcm9ncyAgICAgICAgICAzLnguMWIKeGZzcHJvZ3MgICAg
ICAgICAgICAgICAyLjAuMwpEeW5hbWljIGxpbmtlciAobGRkKSAgIDIuMi40ClByb2NwcyAgICAg
ICAgICAgICAgICAgMy4xLjgKTmV0LXRvb2xzICAgICAgICAgICAgICAxLjYwCktiZCAgICAgICAg
ICAgICAgICAgICAgMS4wOApTaC11dGlscyAgICAgICAgICAgICAgIDIuMApNb2R1bGVzIExvYWRl
ZCAgICAgICAgIAo=

------=_20030623133421_74004--

