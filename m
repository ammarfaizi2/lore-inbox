Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbTFXIIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 04:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264869AbTFXIIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 04:08:23 -0400
Received: from mail.aex.nl ([212.153.234.107]:24073 "HELO mail.aex.nl")
	by vger.kernel.org with SMTP id S264453AbTFXIHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 04:07:08 -0400
Message-ID: <3EF809D4.1050100@euronext.nl>
Date: Tue, 24 Jun 2003 10:20:36 +0200
From: Jan Evert van Grootheest <j.grootheest@euronext.nl>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tobias Diedrich <ranma@gmx.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: WDC HD found, but ignored?
References: <20030623231436.GA5612@melchior.yamamaya.is-a-geek.org>
In-Reply-To: <20030623231436.GA5612@melchior.yamamaya.is-a-geek.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias,

This doesn't match:

> ide_setup: hdc=ide-scsi

with

> hda: MAXTOR 6L080J4, ATA DISK drive
> hdb: MAXTOR 6L080J4, ATA DISK drive
> hdc: WDC WD1800JB-00DUA0, ATA DISK drive
> hdd: RICOH CD-R/RW MP7200A, ATAPI CD/DVD-ROM drive

You may want to use ide-scsi on hdd.

No idea whether this fixes your problem, but this seems wrong.

-- Jan Evert

Tobias Diedrich wrote:
> This is a really weird case.
> The kernel (2.4.21-ac2) finds the hard disk (WDC WD1800JB-00DUA0), but
> does not attach the ide-disk driver (No error message). The following
> partition check fails with I/O error on sector 0. Attempts to access the
> disk (In this case hdc) on the booted system result in the kernel trying
> to load the ide-disk module, which fails because it is compiled in.
> The works fine in this configuration when booting the W2K partition.
> 
> I hope someone has an idea on what is going wrong here.
> Please CC me on replies as I am not subscribed to the list at the
> moment.
> Kernel boot log:
> 
> Linux version 2.4.21-ac2 (root@elektra) (gcc version 2.95.4 20011002
> (Debian prerelease)) #5 Sun Dec 1 18:56:36 CET 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
>  BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
>  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> Warning only 896MB will be used.
> Use a HIGHMEM enabled kernel.
> 896MB LOWMEM available.
> On node 0 totalpages: 229376
> zone(0): 4096 pages.
> zone(1): 225280 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/hda1 vga=ext parport=auto hdc=ide-scsi
> ide_setup: hdc=ide-scsi
> Initializing CPU#0
> Detected 1109.919 MHz processor.
> Console: colour VGA+ 80x50
> Calibrating delay loop... 2215.11 BogoMIPS
> Memory: 904068k/917504k available (2130k kernel code, 13052k reserved,
> 697k data, 80k init, 0k highmem)
> Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
> Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
> CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
> CPU: AMD Athlon(TM) XP 1700+ stepping 02
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> PCI: PCI BIOS revision 2.10 entry at 0xf1aa0, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Using IRQ router VIA [1106/3147] at 00:11.0
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f9c50
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9c80, dseg 0xf0000
> PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
> PnPBIOS: PNP0c02: ioport range 0x290-0x297 has been reserved
> PnPBIOS: PNP0c02: ioport range 0x3f0-0x3f1 has been reserved
> PnPBIOS: PNP0c02: ioport range 0xe400-0xe47f has been reserved
> PnPBIOS: PNP0c02: ioport range 0xec00-0xec3f has been reserved
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> Journalled Block Device driver loaded
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> NTFS driver v1.1.22 [Flags: R/O]
> udf: registering filesystem
> SGI XFS with no debug enabled
> parport0: PC-style at 0x378 (0x778), irq 7, using FIFO
> [PCSPP,TRISTATE,COMPAT,ECP]
> parport0: Printer, HEWLETT-PACKARD DESKJET 940C
> i2c-core.o: i2c core module
> i2c-dev.o: i2c /dev entries driver module
> i2c-core.o: driver i2c-dev dummy driver registered.
> i2c-algo-bit.o: i2c bit algorithm module
> i2c-proc.o version 2.6.1 (20010825)
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI ISAPNP enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> gameport0: Emu10k1 Gameport at 0xa000 size 8 speed 1169 kHz
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> loop: loaded (max 8 devices)
> eepro100.c:v1.09j-t 9/29/99 Donald Becker
> http://www.scyld.com/network/eepro100.html
> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
> <saw@saw.sw.com.sg> and others
> PCI: Found IRQ 12 for device 00:0f.0
> eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:02:B3:1C:8B:4F, IRQ
> 12.
>   Board assembly 721383-016, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>   General self-test: passed.
>   Serial sub-system self-test: passed.
>   Internal registers self-test: passed.
>   ROM checksum self-test: passed (0x04f4518b).
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 816M
> agpgart: Detected Via Apollo Pro KT266 chipset
> agpgart: AGP aperture is 128M @ 0xe0000000
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: IDE controller at PCI slot 00:11.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
>     ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:pio, hdd:pio
> hda: MAXTOR 6L080J4, ATA DISK drive
> hdb: MAXTOR 6L080J4, ATA DISK drive
> blk: queue c0405b40, I/O limit 4095Mb (mask 0xffffffff)
> blk: queue c0405c90, I/O limit 4095Mb (mask 0xffffffff)
> hdc: WDC WD1800JB-00DUA0, ATA DISK drive
> hdd: RICOH CD-R/RW MP7200A, ATAPI CD/DVD-ROM drive
> blk: queue c0405fbc, I/O limit 4095Mb (mask 0xffffffff)
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: attached ide-disk driver.
> hda: host protected area => 1
> hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=9732/255/63,
> UDMA(133)
> hdb: attached ide-disk driver.
> hdb: host protected area => 1
> hdb: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=9732/255/63,
> UDMA(133)
> hdd: attached ide-scsi driver.
> Partition check:
>  hda: hda1 hda2 < hda5 > hda3 hda4
>  hdb: hdb1
>  hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
> end_request: I/O error, dev 16:00 (hdc), sector 2
> end_request: I/O error, dev 16:00 (hdc), sector 4
> end_request: I/O error, dev 16:00 (hdc), sector 6
> end_request: I/O error, dev 16:00 (hdc), sector 0
> end_request: I/O error, dev 16:00 (hdc), sector 2
> end_request: I/O error, dev 16:00 (hdc), sector 4
> end_request: I/O error, dev 16:00 (hdc), sector 6
>  unable to read partition table
> SCSI subsystem driver Revision: 1.00
> aec671x_detect: 
> PCI: Found IRQ 5 for device 00:0c.0
> PCI: Sharing IRQ 5 with 00:09.0
> PCI: Sharing IRQ 5 with 00:10.0
>    ACARD AEC-671X PCI Ultra/W SCSI-3 Host Adapter: 0    IO:a800, IRQ:5.
>          ID:  7  Host Adapter
> scsi0 : ACARD AEC-6710/6712/67160 PCI Ultra/W/LVD SCSI-3 Adapter Driver
> V2.6+ac 
> scsi1 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: RICOH     Model: CD-R/RW MP7200A   Rev: 1.10
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.12
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> PCI: Found IRQ 10 for device 00:09.2
> PCI: Sharing IRQ 10 with 00:05.0
> PCI: Sharing IRQ 10 with 00:0e.0
> ehci_hcd 00:09.2: VIA Technologies, Inc. USB 2.0
> ehci_hcd 00:09.2: irq 10, pci mem f8828000
> usb.c: new USB bus registered, assigned bus number 1
> PCI: 00:09.2 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
> PCI: 00:09.2 PCI cache line size corrected to 64.
> ehci_hcd 00:09.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-12/2.4
> hub.c: USB hub found
> hub.c: 4 ports detected
> host/usb-uhci.c: $Revision: 1.275 $ time 18:56:39 Dec  1 2002
> host/usb-uhci.c: High bandwidth mode enabled
> PCI: Found IRQ 5 for device 00:09.0
> PCI: Sharing IRQ 5 with 00:0c.0
> PCI: Sharing IRQ 5 with 00:10.0
> host/usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 5
> host/usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Found IRQ 11 for device 00:09.1
> PCI: Sharing IRQ 11 with 00:0d.0
> PCI: Sharing IRQ 11 with 00:0d.1
> PCI: Sharing IRQ 11 with 01:00.0
> host/usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 11
> host/usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 3
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Found IRQ 3 for device 00:11.2
> IRQ routing conflict for 00:11.2, have irq 9, want irq 3
> IRQ routing conflict for 00:11.3, have irq 9, want irq 3
> host/usb-uhci.c: USB UHCI at I/O 0x9000, IRQ 9
> host/usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 4
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Found IRQ 3 for device 00:11.3
> IRQ routing conflict for 00:11.2, have irq 9, want irq 3
> IRQ routing conflict for 00:11.3, have irq 9, want irq 3
> host/usb-uhci.c: USB UHCI at I/O 0x8800, IRQ 9
> host/usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 5
> hub.c: USB hub found
> hub.c: 2 ports detected
> host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> usb.c: registered new driver hid
> hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
> hid-core.c: USB HID support drivers
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> Linux video capture interface: v1.00
> mice: PS/2 mouse device common for all mice
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 80k freed
> hub.c: new USB device 00:09.0-2, assigned address 2
> host/usb-uhci.c: interrupt, status 3, frame# 1206
> input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse? Explorer]
> on usb2:2.0
> hub.c: new USB device 00:11.2-1, assigned address 2
> usb.c: USB device 2 (vend/prod 0x5655/0x4149) is not claimed by any
> active driver.
> Adding Swap: 995988k swap-space (priority -1)
> EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
> Creative EMU10K1 PCI Audio Driver, version 0.20, 18:19:16 Dec  1 2002
> PCI: Found IRQ 10 for device 00:0e.0
> PCI: Sharing IRQ 10 with 00:05.0
> PCI: Sharing IRQ 10 with 00:09.2
> emu10k1: EMU10K1 rev 7 model 0x8064 found, IO at 0xa400-0xa41f, IRQ 10
> ac97_codec: AC97 Audio codec, id: EMC40 (Unknown)
> emu10k1: SBLive! 5.1 card detected
> FAT: Did not find valid FSINFO signature.
> Found signature1 0x66024a1e signature2 0xc88b6602 sector=4.
> VFS: Can't find a valid FAT filesystem on dev 03:41.
> ide-scsi: hdd: unsupported command in request queue (0)
> end_request: I/O error, dev 16:41 (hdd), sector 0
> NTFS: Reading super block failed
> blk: queue c0405b40, I/O limit 4095Mb (mask 0xffffffff)
> blk: queue c0405c90, I/O limit 4095Mb (mask 0xffffffff)
> hdd: drive_cmd: status=0x41 { DriveReady Error }
> hdd: drive_cmd: error=0x04
> 
> 
> Thanks in advance,
> 

