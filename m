Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317144AbSFFSz3>; Thu, 6 Jun 2002 14:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSFFSyX>; Thu, 6 Jun 2002 14:54:23 -0400
Received: from iafilius.xs4all.nl ([213.84.160.212]:18059 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S317137AbSFFSxg>;
	Thu, 6 Jun 2002 14:53:36 -0400
Date: Thu, 6 Jun 2002 20:53:11 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: arjan@sjoerd.sjoerdnet
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: "Brian J. Conway" <bconway@WPI.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: Promise Ultra100 hang
In-Reply-To: <Pine.OSF.4.43.0206061239390.14804-100000@cpu.WPI.EDU>
Message-ID: <Pine.LNX.4.44.0206062043470.6451-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Brian,

Same issue here, 2.4.18 running fine with my new 160GB maxtor drive on a
promise udma100 ide controller, 2.4.19-pre9 hangs on partition check at
boot time.

I saw in the incremental patches many promise related changes in
pre8->pre9, but i havn't tested pre8 yet.


I've inlcluded my /var/log/boot.msg (2.4.18) in case this may help to
solve the problem.



Inspecting /boot/System.map-2.4.18
Loaded 16744 symbols from /boot/System.map-2.4.18.
Symbols match kernel version 2.4.18.
Loaded 155 symbols from 7 modules.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.18 (root@sjoerd) (gcc version 2.95.3 20010315 (SuSE)) #7 Sun Mar 10 11:42:29 CET 2002
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
<4> BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000005ffec000 (usable)
<4> BIOS-e820: 000000005ffec000 - 000000005ffef000 (ACPI data)
<4> BIOS-e820: 000000005ffef000 - 000000005ffff000 (reserved)
<4> BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>639MB HIGHMEM available.
<4>On node 0 totalpages: 393196
<4>zone(0): 4096 pages.
<4>zone(1): 225280 pages.
<4>zone(2): 163820 pages.
<4>Kernel command line: auto BOOT_IMAGE=2.4.18-sda1 ro root=801 hdc=scsi
<4>ide_setup: hdc=scsi
<6>Initializing CPU#0
<4>Detected 1109.907 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 2215.11 BogoMIPS
<4>Memory: 1544596k/1572784k available (1447k kernel code, 27796k reserved, 492k data, 220k init, 655280k highmem)
<4>Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
<4>Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
<4>Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
<4>Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
<7>CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 256K (64 bytes/line)
<7>CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
<7>CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
<4>CPU: AMD Athlon(tm) Processor stepping 02
<6>Enabling fast FPU save and restore... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<4>PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=2
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<4>Disabling VIA memory write queue: [55] 89->09
<3>Unknown bridge resource 0: assuming transparent
<6>PCI: Using IRQ router VIA [1106/0686] at 00:04.0
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd
<4>allocated 32 pages and 32 bhs reserved for the highmem bounces
<5>VFS: Diskquotas version dquot_6.4.0 initialized
<6>Coda Kernel/Venus communications, v5.3.18, coda@cs.cmu.edu
<5>NTFS driver v1.1.22 [Flags: R/W]
<4>pty: 2048 Unix98 ptys configured
<4>block: 128 slots per queue, batch=32
<4>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>VP_IDE: IDE controller on PCI bus 00 dev 21
<4>VP_IDE: chipset revision 16
<4>VP_IDE: not 100%% native mode: will probe irqs later
<6>VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
<4>    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
<4>PDC20265: IDE controller on PCI bus 00 dev 88
<6>PCI: Found IRQ 10 for device 00:11.0
<6>PCI: Sharing IRQ 10 with 00:0b.0
<4>PDC20265: chipset revision 2
<4>PDC20265: not 100%% native mode: will probe irqs later
<4>PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
<4>    ide2: BM-DMA at 0x6400-0x6407, BIOS settings: hde:pio, hdf:pio
<4>    ide3: BM-DMA at 0x6408-0x640f, BIOS settings: hdg:DMA, hdh:DMA
<4>hda: IBM-DTTA-371440, ATA DISK drive
<4>hdc: AOpen 12xDVD-ROM/AMH 04202001, ATAPI CD/DVD-ROM drive
<4>hde: IC35L060AVER07-0, ATA DISK drive
<4>hdf: Maxtor 4G160J8, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide2 at 0x7800-0x7807,0x7402 on irq 10
<6>hda: 28229040 sectors (14453 MB) w/462KiB Cache, CHS=1757/255/63, UDMA(33)
<6>hde: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(100)
<6>hdf: 268435455 sectors (137439 MB) w/2048KiB Cache, CHS=266305/16/63, UDMA(100)
<4>ide-cd: passing drive hdc to ide-scsi emulation.
<6>Partition check:
<6> hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
<6> hde: hde1 hde2 hde3 hde4
<6> hdf: hdf1 hdf2 hdf3 hdf4


: Here after "hdf:" 2.4.19-pre9 just waits forever.



<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>NET4: Frame Diverter 0.46
<6>loop: loaded (max 8 devices)
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 816M
<6>agpgart: Detected Via Apollo Pro KT133 chipset
<6>agpgart: AGP aperture is 64M @ 0xe4000000
<6>SCSI subsystem driver Revision: 1.00
<6>PCI: Found IRQ 10 for device 00:0b.0
<6>PCI: Sharing IRQ 10 with 00:11.0
<6>sym53c8xx: at PCI bus 0, device 11, function 0
<4>sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
<6>sym53c8xx: 53c875J detected with Symbios NVRAM
<6>sym53c875J-0: rev 0x4 on pci bus 0 device 11 function 0 irq 10
<6>sym53c875J-0: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
<6>sym53c875J-0: on-chip RAM at 0xdd800000
<6>sym53c875J-0: restart (scsi reset).
<4>sym53c875J-0: Downloading SCSI SCRIPTS.
<6>scsi0 : sym53c8xx-1.7.3c-20010512
<4>  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.04
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>  Vendor: QUANTUM   Model: ATLAS IV 18 WLS   Rev: 0A0A
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<6>sym53c875J-0-<6,0>: tagged command queue depth set to 8
<6>scsi1 : SCSI host adapter emulation for IDE ATAPI devices
<4>  Vendor: AOpen     Model: 12xDVD-ROM/AMH    Rev: R07
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
<6>sym53c875J-0-<6,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 16)
<4>SCSI device sda: 35885168 512-byte hdwr sectors (18373 MB)
<6> sda: sda1 sda2 sda3 sda4
<4>Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
<4>Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
<6>sym53c875J-0-<4,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 16)
<4>sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
<6>Uniform CD-ROM driver Revision: 3.12
<4>sr1: scsi3-mmc drive: 0x/40x cd/rw xa/form2 cdda tray
<6>md: linear personality registered as nr 1
<6>md: raid0 personality registered as nr 2
<6>md: raid1 personality registered as nr 3
<6>md: raid5 personality registered as nr 4
<6>raid5: measuring checksumming speed
<4>   8regs     :  1696.000 MB/sec
<4>   32regs    :  1500.400 MB/sec
<4>   pII_mmx   :  2599.200 MB/sec
<4>   p5_mmx    :  3326.000 MB/sec
<4>raid5: using function: p5_mmx (3326.000 MB/sec)
<6>md: multipath personality registered as nr 7
<6>md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>LVM version 1.0.1-rc4(ish)(03/10/2001)
<5>IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>IP: routing cache hash table of 16384 buckets, 128Kbytes
<4>TCP: Hash tables configured (established 262144 bind 65536)
<6>Linux IP multicast router 0.06 plus PIM-SM
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<5>RAMDISK: Compressed image found at block 0
<4>Freeing initrd memory: 660k freed
<4>VFS: Mounted root (ext2 filesystem).
<4>FAT: bogus logical sector size 0
<6>UMSDOS: msdos_read_super failed, mount aborted.
<4>FAT: bogus logical sector size 0
<4>FAT: bogus logical sector size 0
<3>kmod: failed to exec /sbin/modprobe -s -k nls_iso8859-1, errno = 2
<4>reiserfs: checking transaction log (device 08:01) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<4>change_root: old root has d_count=2
<4>Freeing unused kernel memory: 220k freed
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>Journalled Block Device driver loaded
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<4>reiserfs: checking transaction log (device 3a:13) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:12) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<4>reiserfs: checking transaction log (device 3a:14) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:15) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:00) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,5), internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<4>reiserfs: checking transaction log (device 3a:04) ...
<4>Using tea hash to sort names
<4>ReiserFS version 3.6.25
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,3), internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<4>reiserfs: checking transaction log (device 3a:06) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:1f) ...
<4>Using tea hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:20) ...
<4>Using tea hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:01) ...
<4>Using tea hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:0d) ...
<4>Using tea hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:02) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 08:02) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:0f) ...
<4>Using tea hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:0e) ...
<4>Using tea hash to sort names
<4>ReiserFS version 3.6.25
<6>usb.c: registered new driver usbdevfs
<6>usb.c: registered new driver hub
<6>uhci.c: USB Universal Host Controller Interface driver v1.1
<6>PCI: Found IRQ 9 for device 00:04.2
<6>PCI: Sharing IRQ 9 with 00:04.3
<6>PCI: Sharing IRQ 9 with 00:09.0
<6>PCI: Sharing IRQ 9 with 00:0d.0
<6>uhci.c: USB UHCI at I/O 0xd400, IRQ 9
<6>usb.c: new USB bus registered, assigned bus number 1
<6>uhci.c: detected 2 ports
<7>usb.c: kmalloc IF f40b5240, numif 1
<7>usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
<7>usb.c: USB device number 1 default language ID 0x0
<6>Product: USB UHCI-alt Root Hub
<6>SerialNumber: d400
<6>hub.c: USB hub found
<6>hub.c: 2 ports detected
<7>hub.c: standalone hub
<7>hub.c: ganged power switching
<7>hub.c: global over-current protection
<7>hub.c: Port indicators are not supported
<7>hub.c: power on to power good time: 2ms
<7>hub.c: hub controller current requirement: 0mA
<7>hub.c: port removable status: RR
<7>hub.c: local power source is good
<7>hub.c: no over-current condition exists
<7>hub.c: enabling power on all ports
<7>usb.c: hub driver claimed interface f40b5240
<7>usb.c: kusbd: /sbin/hotplug add 1
<6>PCI: Found IRQ 9 for device 00:04.3
<6>PCI: Sharing IRQ 9 with 00:04.2
<6>PCI: Sharing IRQ 9 with 00:09.0
<6>PCI: Sharing IRQ 9 with 00:0d.0
<6>uhci.c: USB UHCI at I/O 0xd000, IRQ 9
<6>usb.c: new USB bus registered, assigned bus number 2
<6>uhci.c: detected 2 ports
<7>usb.c: kmalloc IF f40b5580, numif 1
<7>usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
<7>usb.c: USB device number 1 default language ID 0x0
<6>Product: USB UHCI-alt Root Hub
<6>SerialNumber: d000
<6>hub.c: USB hub found
<6>hub.c: 2 ports detected
<7>hub.c: standalone hub
<7>hub.c: ganged power switching
<7>hub.c: global over-current protection
<7>hub.c: Port indicators are not supported
<7>hub.c: power on to power good time: 2ms
<7>hub.c: hub controller current requirement: 0mA
<7>hub.c: port removable status: RR
<7>hub.c: local power source is good
<7>hub.c: no over-current condition exists
<7>hub.c: enabling power on all ports
<7>usb.c: hub driver claimed interface f40b5580
<7>usb.c: kusbd: /sbin/hotplug add 1
<6>usb-uhci.c: $Revision: 1.275 $ time 11:49:28 Mar 10 2002
<6>usb-uhci.c: High bandwidth mode enabled
<6>usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
<7>uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
<7>hub.c: port 1 connection change
<7>hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
<7>hub.c: port 2 connection change
<7>hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
<7>uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
<7>hub.c: port 1 connection change
<7>hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
<7>hub.c: port 2 connection change
<7>hub.c: port 2, portstatus 101, change 3, 12 Mb/s
<7>hub.c: port 2, portstatus 103, change 0, 12 Mb/s
<6>hub.c: USB new device connect on bus2/2, assigned device number 2
<7>usb.c: kmalloc IF f40b56c0, numif 1
<7>usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
<7>usb.c: USB device number 2 default language ID 0x409
<6>Manufacturer: ALCOR
<6>Product: Generic USB Hub
<6>hub.c: USB hub found
<7>uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
<6>hub.c: 4 ports detected
<7>hub.c: standalone hub
<7>hub.c: ganged power switching
<7>hub.c: global over-current protection
<7>hub.c: Port indicators are not supported
<7>hub.c: power on to power good time: 44ms
<7>hub.c: hub controller current requirement: 100mA
<7>hub.c: port removable status: RRRR
<7>hub.c: local power source is good
<7>hub.c: no over-current condition exists
<7>hub.c: enabling power on all ports
<7>usb.c: hub driver claimed interface f40b56c0
<7>usb.c: kusbd: /sbin/hotplug add 2
<7>hub.c: port 1 enable change, status 300
<7>hub.c: port 2 enable change, status 300
<7>uhci.c: root-hub INT complete: port1: 588 port2: 495 data: 2
<7>hub.c: port 1 enable change, status 300
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.


 On Thu, 6 Jun 2002, Brian J. Conway wrote:

> I'm running into trouble with an Ultra100 card (no raid or other features,
> I think it's a PDC20267) with BIOS 2.01b27 when moving from two Maxtor
> 20GB 5400 RPM ATA66 drives to a Maxtor 80GB 5400 RPM ATA100 drive.  The
> previous drives worked fine, but when trying to install Mandrake 8.2 on
> only the new 80GB drive, it detects the controller correctly and goes to
> check partitions and hangs at "hde" with the drive light going constant
> and nothing happening.  I'm pretty sure the drive is fine as it works fine
> on the controller card at ATA100 (recognized by the BIOS correctly as
> Ultra DMA Mode 5) in Win2k, and I can plug it onto the motherboard PIIX4
> controller and install Mandrake 8.2 that way without an issue.  Moving it
> to the controller card after install with the generic 2.4.18 kernel or
> compiling 2.4.19-pre8 (the last kernel version I used on the previous
> drives which worked fine) all produces the hang at detecting partitions on
> hde.  I don't have the machine in front of me, but can provide more info
> as necessary.  Please CC me as I'm not on the list, any ideas would be
> appreciated as to why the older drives work perfectly but the new one
> hangs on detection.
>
> Brian J. Conway
> bconway@wpi.edu
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Arjan Filius
mailto:iafilius@xs4all.nl

