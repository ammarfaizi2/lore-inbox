Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUCRPUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbUCRPUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:20:49 -0500
Received: from ldgo.columbia.edu ([129.236.10.30]:42957 "EHLO
	lamont.ldeo.columbia.edu") by vger.kernel.org with ESMTP
	id S262398AbUCRPUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:20:07 -0500
Message-Id: <200403181519.i2IFJiFs028202@lamont.ldeo.columbia.edu>
Date: Thu, 18 Mar 2004 10:19:44 -0500 (EST)
From: yue-feng sun <sunyf@ldeo.columbia.edu>
Reply-To: yue-feng sun <sunyf@ldeo.columbia.edu>
Subject: Re: problems with the second hard drive on M60
To: ianh@iahastie.clara.net, leonardo.COMMIT_WORK@petrobras.com.br,
       mcarter@lanl.gov, msgclblix@cox.net
Cc: linux-precision@dell.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: UZqWTgcPrSF0Gb1KR+M2kg==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.5 SunOS 5.9 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian, Leonardo, Michael, and Corwin,

Many thanks for your help. 
It worked as you suggested by removing the hdc=ide-scsi from the kernel command 
line in the grub.conf file. 
Sun

> X-SBRSIP: 143.166.224.162
> X-SBRS: 9.0
> X-BrightmailFiltered: true
> Resent-Message-Id: <200403181355.i2IDtnRN014190@lists.us.dell.com>
> X-SBRSIP: 192.16.0.25
> X-SBRS: 1.4
> X-BrightmailFiltered: true
> Subject: Re: problems with the second hard drive on M60
> From: "Michael J. Carter" <mcarter@lanl.gov>
> To: yue-feng sun <sunyf@ldeo.columbia.edu>
> Cc: linux-precision@dell.com
> Mime-Version: 1.0
> Content-Transfer-Encoding: 7bit
> X-Scanned-By: MIMEDefang 2.39
> X-Scanned-By: MIMEDefang 2.35
> Resent-From: Matt Domsch <Matt_Domsch@dell.com>
> Resent-Date: Thu, 18 Mar 2004 07:55:49 -0600
> Resent-To: linux-precision@dell.com
> X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on lists.us.dell.com
> X-Spam-Level: 
> X-Spam-Status: No, hits=0.0 required=5.0 tests=none autolearn=no version=2.63
> X-BeenThere: linux-precision@dell.com
> X-Mailman-Version: 2.0.14
> List-Unsubscribe: <http://lists.us.dell.com/mailman/listinfo/linux-precision>, 
<mailto:linux-precision-request@dell.com?subject=unsubscribe>
> List-Id: Linux on Dell Precision Workstations discussion 
<linux-precision.dell.com>
> List-Post: <mailto:linux-precision@dell.com>
> List-Help: <mailto:linux-precision-request@dell.com?subject=help>
> List-Subscribe: <http://lists.us.dell.com/mailman/listinfo/linux-precision>, 
<mailto:linux-precision-request@dell.com?subject=subscribe>
> List-Archive: <http://lists.us.dell.com/pipermail/linux-precision/>
> X-Original-Date: Wed, 17 Mar 2004 16:19:07 -0700
> Date: Wed, 17 Mar 2004 16:19:07 -0700
> X-Spam-Score: -9.2 () Limit=9 BAYES_00,RCVD_IN_BSP_TRUSTED
> 
> You'll need to remove the 'hdc=ide-scsi' kernel argument from
> /etc/grub.conf to see the IDE hard drive.
> 
> mjc
> 
> On Wed, 2004-03-17 at 10:37, yue-feng sun wrote:
> > Hello,
> > 
> >    I need help to solve my following hard drive problem:
> >      
> >      The second hard drive in the modular bay of my DELL Precision 
> >      Mobil workstation M60 is not usable. It is recognized during the boot
> >      as  hdc: FUJITSU MHT2040AH, ATA DISK drive
> >      
> >      I am running RH9 with Linux Kernel 2.4.20-13.9
> > 
> > 
> > The dmesg shows:
> > -------------------------------------------------------------
> > Kernel command line: ro root=LABEL=/ hdc=ide-scsi
> > ide_setup: hdc=ide-scsi
> > 
> > hda: HTS726060M9AT00, ATA DISK drive
> > blk: queue c03cbfa0, I/O limit 4095Mb (mask 0xffffffff)
> > hdc: FUJITSU MHT2040AH, ATA DISK drive
> > blk: queue c03cc404, I/O limit 4095Mb (mask 0xffffffff)
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hda: attached ide-disk driver.
> > hda: host protected area => 1
> > hda: 117210240 sectors (60012 MB) w/7877KiB Cache, CHS=7296/255/63, 
UDMA(100)
> > ide-floppy driver 0.99.newide
> > Partition check:
> >  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
> >  hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
> > end_request: I/O error, dev 16:00 (hdc), sector 2
> > end_request: I/O error, dev 16:00 (hdc), sector 4
> > end_request: I/O error, dev 16:00 (hdc), sector 6
> > end_request: I/O error, dev 16:00 (hdc), sector 0
> > end_request: I/O error, dev 16:00 (hdc), sector 2
> > end_request: I/O error, dev 16:00 (hdc), sector 4
> > end_request: I/O error, dev 16:00 (hdc), sector 6
> >  unable to read partition table
> > ide-floppy driver 0.99.newide
> > -------------------------------------------------------------
> > 
> > 
> > I remember that during the boot, there was a message like
> >  hardwaremodprobe can not locate module ide-disk ...
> > 
> > 
> > 
> > After booting, I got the following errors:
> > 
> > #fdisk /dev/hdc
> > 
> > hdc: driver not present
> > unable to open /dev/hdc
> > 
> > 
> > After shutting down, there was a message like:
> > 
> > flusing devices hda, hdc
> > 
> > 
> > The detailed dmesg log is attached.
> > 
> > The drive was originally partitioned as Dynamic. I used Partition Magic to
> > convert it to Basic partition and it was formatted to two FAT32 partitions
> > under Windows 2000. Now I would like to use it as a linux file system
> > if I could use fdisk to repartition and format it.
> > 
> > 
> > 
> > Thanks,
> > 
> > Sun
> > 
> > ______________________________________________________________________
> > Linux version 2.4.20-13.9 (bhcompile@porky.devel.redhat.com) (gcc version 
3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Mon May 12 10:55:37 EDT 2003
> > BIOS-provided physical RAM map:
> >  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
> >  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
> >  BIOS-e820: 0000000000100000 - 000000003ffae000 (usable)
> >  BIOS-e820: 000000003ffae000 - 0000000040000000 (reserved)
> >  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
> >  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
> > 127MB HIGHMEM available.
> > 896MB LOWMEM available.
> > On node 0 totalpages: 262062
> > zone(0): 4096 pages.
> > zone(1): 225280 pages.
> > zone(2): 32686 pages.
> > Kernel command line: ro root=LABEL=/ hdc=ide-scsi
> > ide_setup: hdc=ide-scsi
> > Initializing CPU#0
> > Detected 1694.516 MHz processor.
> > Console: colour VGA+ 80x25
> > Calibrating delay loop... 3381.65 BogoMIPS
> > Memory: 1027148k/1048248k available (1355k kernel code, 17516k reserved, 
1004k data, 132k init, 130744k highmem)
> > Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> > Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
> > Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> > Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
> > Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
> > Intel machine check architecture supported.
> > Intel machine check reporting enabled on CPU#0.
> > CPU:     After generic, caps: a7e9f9bf 00000000 00000000 00000000
> > CPU:             Common caps: a7e9f9bf 00000000 00000000 00000000
> > CPU: Intel(R) Pentium(R) M processor 1700MHz stepping 05
> > Enabling fast FPU save and restore... done.
> > Enabling unmasked SIMD FPU exception support... done.
> > Checking 'hlt' instruction... OK.
> > POSIX conformance testing by UNIFIX
> > mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> > mtrr: detected mtrr type: Intel
> > PCI: PCI BIOS revision 2.10 entry at 0xfc97e, last bus=2
> > PCI: Using configuration type 1
> > PCI: Probing PCI hardware
> > PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
> > Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
> > PCI: Discovered primary peer bus 08 [IRQ]
> > PCI: Using IRQ router PIIX [8086/24cc] at 00:1f.0
> > PCI: Found IRQ 11 for device 00:1f.1
> > PCI: Sharing IRQ 11 with 00:1d.2
> > PCI: Sharing IRQ 11 with 02:00.0
> > isapnp: Scanning for PnP cards...
> > isapnp: No Plug & Play device found
> > Linux NET4.0 for Linux 2.4
> > Based upon Swansea University Computer Society NET3.039
> > Initializing RT netlink socket
> > apm: BIOS not found.
> > Starting kswapd
> > allocated 32 pages and 32 bhs reserved for the highmem bounces
> > VFS: Disk quotas vdquot_6.5.1
> > pty: 2048 Unix98 ptys configured
> > Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
> > ttyS0 at 0x03f8 (irq = 4) is a 16550A
> > PCI: Found IRQ 11 for device 00:1f.6
> > PCI: Sharing IRQ 11 with 00:1f.5
> > PCI: Sharing IRQ 11 with 02:03.0
> > Real Time Clock Driver v1.10e
> > floppy0: no floppy controllers found
> > NET4: Frame Diverter 0.46
> > RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> > Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > ICH4: IDE controller at PCI slot 00:1f.1
> > PCI: Enabling device 00:1f.1 (0005 -> 0007)
> > PCI: Found IRQ 11 for device 00:1f.1
> > PCI: Sharing IRQ 11 with 00:1d.2
> > PCI: Sharing IRQ 11 with 02:00.0
> > ICH4: chipset revision 1
> > ICH4: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
> > hda: HTS726060M9AT00, ATA DISK drive
> > blk: queue c03cbfa0, I/O limit 4095Mb (mask 0xffffffff)
> > hdc: FUJITSU MHT2040AH, ATA DISK drive
> > blk: queue c03cc404, I/O limit 4095Mb (mask 0xffffffff)
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hda: attached ide-disk driver.
> > hda: host protected area => 1
> > hda: 117210240 sectors (60012 MB) w/7877KiB Cache, CHS=7296/255/63, 
UDMA(100)
> > ide-floppy driver 0.99.newide
> > Partition check:
> >  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
> >  hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
> > end_request: I/O error, dev 16:00 (hdc), sector 2
> > end_request: I/O error, dev 16:00 (hdc), sector 4
> > end_request: I/O error, dev 16:00 (hdc), sector 6
> > end_request: I/O error, dev 16:00 (hdc), sector 0
> > end_request: I/O error, dev 16:00 (hdc), sector 2
> > end_request: I/O error, dev 16:00 (hdc), sector 4
> > end_request: I/O error, dev 16:00 (hdc), sector 6
> >  unable to read partition table
> > ide-floppy driver 0.99.newide
> > md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> > md: Autodetecting RAID arrays.
> > md: autorun ...
> > md: ... autorun DONE.
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > IP Protocols: ICMP, UDP, TCP, IGMP
> > IP: routing cache hash table of 8192 buckets, 64Kbytes
> > TCP: Hash tables configured (established 262144 bind 65536)
> > Linux IP multicast router 0.06 plus PIM-SM
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > RAMDISK: Compressed image found at block 0
> > Freeing initrd memory: 143k freed
> > VFS: Mounted root (ext2 filesystem).
> > Journalled Block Device driver loaded
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: mounted filesystem with ordered data mode.
> > Freeing unused kernel memory: 132k freed
> > usb.c: registered new driver usbdevfs
> > usb.c: registered new driver hub
> > PCI: Found IRQ 11 for device 00:1d.7
> > PCI: Setting latency timer of device 00:1d.7 to 64
> > ehci-hcd 00:1d.7: Intel Corp. 82801DB USB EHCI Controller
> > ehci-hcd 00:1d.7: irq 11, pci mem f8849c00
> > usb.c: new USB bus registered, assigned bus number 1
> > ehci-hcd 00:1d.7: enabled 64bit PCI DMA
> > PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
> > PCI: 00:1d.7 PCI cache line size corrected to 128.
> > ehci-hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
> > hub.c: USB hub found
> > hub.c: 6 ports detected
> > usb-uhci.c: $Revision: 1.275 $ time 11:00:49 May 12 2003
> > usb-uhci.c: High bandwidth mode enabled
> > PCI: Found IRQ 11 for device 00:1d.0
> > PCI: Sharing IRQ 11 with 01:00.0
> > PCI: Setting latency timer of device 00:1d.0 to 64
> > usb-uhci.c: USB UHCI at I/O 0xbf80, IRQ 11
> > usb-uhci.c: Detected 2 ports
> > usb.c: new USB bus registered, assigned bus number 2
> > hub.c: USB hub found
> > hub.c: 2 ports detected
> > PCI: Found IRQ 11 for device 00:1d.1
> > PCI: Sharing IRQ 11 with 02:01.0
> > PCI: Sharing IRQ 11 with 02:01.1
> > PCI: Sharing IRQ 11 with 02:01.2
> > PCI: Setting latency timer of device 00:1d.1 to 64
> > usb-uhci.c: USB UHCI at I/O 0xbf40, IRQ 11
> > usb-uhci.c: Detected 2 ports
> > usb.c: new USB bus registered, assigned bus number 3
> > hub.c: USB hub found
> > hub.c: 2 ports detected
> > PCI: Found IRQ 11 for device 00:1d.2
> > PCI: Sharing IRQ 11 with 00:1f.1
> > PCI: Sharing IRQ 11 with 02:00.0
> > PCI: Setting latency timer of device 00:1d.2 to 64
> > usb-uhci.c: USB UHCI at I/O 0xbf20, IRQ 11
> > usb-uhci.c: Detected 2 ports
> > usb.c: new USB bus registered, assigned bus number 4
> > hub.c: USB hub found
> > hub.c: 2 ports detected
> > usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> > usb.c: registered new driver hiddev
> > usb.c: registered new driver hid
> > hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
> > hid-core.c: USB HID support drivers
> > mice: PS/2 mouse device common for all mice
> > hub.c: new USB device 00:1d.7-6, assigned address 2
> > hub.c: USB hub found
> > hub.c: 4 ports detected
> > EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
> > Adding Swap: 2152668k swap-space (priority -1)
> > ide-floppy driver 0.99.newide
> > ide-floppy driver 0.99.newide
> > ide-floppy driver 0.99.newide
> > ide-floppy driver 0.99.newide
> > ide-floppy driver 0.99.newide
> > ide-floppy driver 0.99.newide
> > hub.c: new USB device 00:1d.7-6.1, assigned address 3
> > hub.c: USB hub found
> > hub.c: 3 ports detected
> > kjournald starting.  Commit interval 5 seconds
> > EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
> > EXT3-fs: mounted filesystem with ordered data mode.
> > kjournald starting.  Commit interval 5 seconds
> > EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
> > EXT3-fs: mounted filesystem with ordered data mode.
> > hub.c: new USB device 00:1d.7-6.2, assigned address 4
> > input0: USB HID v1.10 Mouse [GenesysLogic USB Mouse] on usb1:4.0
> > hub.c: new USB device 00:1d.7-6.1.1, assigned address 5
> > ohci1394: $Rev: 693 $ Ben Collins <bcollins@debian.org>
> > PCI: Found IRQ 11 for device 02:01.2
> > PCI: Sharing IRQ 11 with 00:1d.1
> > PCI: Sharing IRQ 11 with 02:01.0
> > PCI: Sharing IRQ 11 with 02:01.1
> > ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[fafef800-fafeffff]  Max 
Packet=[2048]
> > ieee1394: SelfID completion called outside of bus reset!
> > ieee1394: Host added: Node[00:1023]  GUID[314fc000226d0881]  [Linux 
OHCI-1394]
> > SCSI subsystem driver Revision: 1.00
> > scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> > input1: USB HID v1.10 Keyboard [Dell Dell USB Keyboard Hub] on usb1:5.0
> > input2: USB HID v1.10 Pointer [Dell Dell USB Keyboard Hub] on usb1:5.1
> > ide-floppy driver 0.99.newide
> > usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 9 ret -71
> > usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 34 ret -71
> > ide-floppy driver 0.99.newide
> > ide-floppy driver 0.99.newide
> > ide-floppy driver 0.99.newide
> > parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> > parport0: irq 7 detected
> > ip_tables: (C) 2000-2002 Netfilter core team
> > Broadcom Gigabit Ethernet Driver bcm5700 with Broadcom NIC Extension (NICE) 
ver. 5.0.16 (01/03/03)
> > divert: allocating divert_blk for eth0
> > PCI: Found IRQ 11 for device 02:00.0
> > PCI: Sharing IRQ 11 with 00:1d.2
> > PCI: Sharing IRQ 11 with 00:1f.1
> > eth0: Broadcom BCM5705M 1000Base-T found at mem faff0000, IRQ 11, node addr 
000d56acc83f
> > eth0: Broadcom BCM5705 Integrated Copper transceiver found
> > eth0: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON, 
802.1Q VLAN ON
> > ip_tables: (C) 2000-2002 Netfilter core team
> > bcm5700: eth0 NIC Link is DOWN
> > Linux Kernel Card Services 3.1.22
> >   options:  [pci] [cardbus] [pm]
> > PCI: Found IRQ 11 for device 02:01.0
> > PCI: Sharing IRQ 11 with 00:1d.1
> > PCI: Sharing IRQ 11 with 02:01.1
> > PCI: Sharing IRQ 11 with 02:01.2
> > PCI: Found IRQ 11 for device 02:01.1
> > PCI: Sharing IRQ 11 with 00:1d.1
> > PCI: Sharing IRQ 11 with 02:01.0
> > PCI: Sharing IRQ 11 with 02:01.2
> > Yenta IRQ list 06f8, PCI irq11
> > Socket status: 30000006
> > Yenta IRQ list 06f8, PCI irq11
> > Socket status: 30000047
> > cs: IO port probe 0x0c00-0x0cff: clean.
> > cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
> > cs: IO port probe 0x0a00-0x0aff: clean.
> > parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> > parport0: irq 7 detected
> > lp0: using parport0 (polling).
> > lp0: console ready
> > 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-5328  Wed 
Dec 17 13:54:51 PST 2003
> > Intel 810 + AC97 Audio, version 0.24, 11:00:30 May 12 2003
> > PCI: Found IRQ 11 for device 00:1f.5
> > PCI: Sharing IRQ 11 with 00:1f.6
> > PCI: Sharing IRQ 11 with 02:03.0
> > PCI: Setting latency timer of device 00:1f.5 to 64
> > i810: Intel ICH4 found at IO 0xbc40 and 0xb800, MEM 0xf4fff800 and 
0xf4fff400, IRQ 11
> > i810: Intel ICH4 mmio at 0xf9d31800 and 0xf9d33400
> > i810_audio: Primary codec has ID 0
> > i810_audio: Audio Controller supports 6 channels.
> > i810_audio: Defaulting to base 2 channel mode.
> > i810_audio: Resetting connection 0
> > i810_audio: Connection 0 with codec id 0
> > ac97_codec: AC97 Audio codec, id: 0x8384:0x7650 (Unknown)
> > i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
> > hub.c: new USB device 00:1d.1-2, assigned address 2
> > usb.c: USB device 2 (vend/prod 0xd7d/0x100) is not claimed by any active 
driver.
> > Initializing USB Mass Storage driver...
> > usb.c: registered new driver usb-storage
> > scsi1 : SCSI emulation for USB Mass Storage devices
> >   Vendor:           Model: USB DISK          Rev: 1.06
> >   Type:   Direct-Access                      ANSI SCSI revision: 02
> > WARNING: USB Mass Storage data integrity not assured
> > USB Mass Storage device found at 2
> > USB Mass Storage support registered.
> > ide-floppy driver 0.99.newide
> -- 
>          For ISR-3 IT Team system administration requests,
>          please see http://computing.isr.lanl.gov/support.
> 
> Michael J. Carter              | Experience is what you get when you were
> IT Team Leader                 | expecting something else.
> Space Data Systems (ISR-3)     |
> Los Alamos National Laboratory |
> 
> _______________________________________________
> Linux-Precision mailing list
> Linux-Precision@dell.com
> http://lists.us.dell.com/mailman/listinfo/linux-precision
> Please read the FAQ at http://lists.us.dell.com/faq or search the list 
archives at http://lists.us.dell.com/htdig/

