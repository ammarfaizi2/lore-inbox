Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWIXTcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWIXTcs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 15:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWIXTcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 15:32:47 -0400
Received: from mail.rucls.net ([65.126.99.146]:51367 "EHLO mail.rucls.net")
	by vger.kernel.org with ESMTP id S1751169AbWIXTcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 15:32:46 -0400
Date: Sun, 24 Sep 2006 14:32:40 -0500
From: Mark Felder <felderado@gmail.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug: Asus CUR-DLS and 2.6
Message-Id: <20060924143240.48bf330e.felderado@gmail.com>
In-Reply-To: <4516D8DF.4060402@shaw.ca>
References: <fa.oxv6SpXdmGM3attVfc3DVbNIcEk@ifi.uio.no>
	<4516D8DF.4060402@shaw.ca>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 13:13:35 -0600
Robert Hancock <hancockr@shaw.ca> wrote:

> Mark Felder wrote:
> > With a 2.6.15 and 2.6.16 kernel on Gentoo I would receive 3 beeps and it would 
> > hardlock as I expained. The CPU fans shut off -- there's no hope of bringing 
> > it out of this. Rarely it's happened at GRUB or before GRUB, but only when 
> > I've been working on this for a long period of time. 
> 
> It seems really unlikely that the kernel is causing this. Especially if 
> the CPU fans shut off, how would the kernel cause this to happen?
> 
> > 
> > I've tried many live CDs -- most use recent 2.6 kernels, and I could repeat 
> > nearly the same problem on them. It often occurs when starting networking. 
> > I've tried onboard e100, tulip, and others that I have access to and I get 
> > nearly the same results. Depending on the livecd I can either get a hardlock 
> > + 3 beeps, or I can receive an address via DHCP, but I can't speak to the 
> > network at all. The e100 reports "system timing errors" in this occasion. On 
> > some setups I can reproduce it instantly by having the network cable 
> > unplugged and plugging it in after it's brought up the e100 interface.
> 
> Might be unrelated, or caused by the same root cause.
> 
> > 
> > Now I was under the inital impression that I had bad hardware. I've 
> > thouroughly tested my RAM and even replaced the motherboard with an identical 
> > ASUS CUR-DLS, so right now I have two of them on my hands, and the one I just 
> > got has the most recent BIOS, the other did not. The only hardware bug that I 
> > can see is that one processor incorrectly reports its temperature -- stays 
> > around 50 celcius all the time, but I figure that's just a bad sensor.
> 
> Are you certain? Seems suspicious.
> 
> > 
> > I came to the conclusion it must be a 2.6 bug when I dropped in a Slackware CD 
> > I just picked up recently. It uses a 2.4 kernel. To my surprise it worked 
> > fine -- no hardlocks, network works great on all adapters, including onboard. 
> > Very strange stuff indeed.
> 
> It may some kind of hardware issue that 2.6 is triggering and 2.4 did not.
> 
> > 
> > Things I've tried with the 2.6 include apic/noapic, nosmp and swapped 
> > processors to each other's slots, nolapic (dont think it actually works for 
> > SMP though, I'm not sure on that one), and nearly every combination of them. 
> > The only other thing I've noticed is that some livecds report an apic but 
> > when initializing the kernel -- right at the very beginning, and it says to 
> > report them to the hardware manufacturer and it claims to work around it.
> 
> Can you post the full dmesg please?
> 
> > 
> > This motherboard uses the Serverworks chipset. I'm not using SCSI.
> > 
> > I would really like to get this bug squashed -- I have a use for this system 
> > and I'd really really prefer to use a 2.6 kernel. Now since I have an 
> > identical motherboard on hand, if anyone is interested in figuring out what 
> > is going on and would like hands on access to the hardware, I could get you 
> > one of these motherboards. If you really don't have access to PIII's/RAM to 
> > put in it, I could the whole setup off too, but I'd really like to get it 
> > back if possible.
> > 
> > I'm open to any suggestions you might have. As of this moment, I'm not on the 
> > kernel mailing list, but I will be looking to sign up after I send this off. 
> > 
> > Thank you for your time, and keep up the great work everyone :)
> > 
> > 
> > Mark Felder
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -- 
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
> 


I somehow got lucky late last night after messing with the Slackware CD and got it to boot a 2.6 kernel off the Gentoo 2006.0 LiveCD successfully with networking. I dont know why it hasn't freaked out yet, but something is not triggering it at the moment.

Anyway, here's the dmesg output that you requested:

Linux version 2.6.15-gentoo-r5 (root@gravity) (gcc version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 SMP Thu Feb 16 15:28:08 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffb000 (usable)
 BIOS-e820: 000000001fffb000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000f5270
On node 0 totalpages: 131067
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126971 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ASUS CUR-DLS detected: force use of acpi=ht
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6250
ACPI: RSDT (v001 ASUS   CUR-DLS  0x30303031 MSFT 0x31313031) @ 0x1fffb000
ACPI: FADT (v001 ASUS   CUR-DLS  0x30303031 MSFT 0x31313031) @ 0x1fffb100
ACPI: BOOT (v001 ASUS   CUR-DLS  0x30303031 MSFT 0x31313031) @ 0x1fffb040
ACPI: MADT (v001 ASUS   CUR-DLS  0x30303031 MSFT 0x31313031) @ 0x1fffb080
ACPI: DSDT (v001   ASUS CUR-DLS  0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFEC01000.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 2
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: root=/dev/ram0 init=/linuxrc dokeymap looptype=squashfs loop=/image.squashfs cdroot initrd=gentoo.igz vga=791 splash=silent,theme:livecd-2006.0 CONSOLE=/dev/tty1 quiet BOOT_IMAGE=gentoo
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec01000)
Initializing CPU#0
CPU 0 irqstacks, hard=c041f000 soft=c0417000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 866.722 MHz processor.
Using tsc for high-res timesource
Speakup v-2.00 CVS: Wed Dec 21 14:36:03 EST 2005 : initialized
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 511072k/524268k available (2336k kernel code, 12564k reserved, 581k data, 220k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1735.57 BogoMIPS (lpj=8677861)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
Booting processor 1/0 eip 2000
CPU 1 irqstacks, hard=c0420000 soft=c0418000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1733.43 BogoMIPS (lpj=8667163)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3469.00 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
BIOS bug, IO-APIC#1 ID 3 is already used!...
... fixing up to 1. (tell your hw vendor)
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 3907k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0a80, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:07.0
PCI: Discovered peer bus 01
PCI: Using IRQ router ServerWorks [1166/0200] at 0000:00:0f.0
PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 20
PCI->APIC IRQ transform: 0000:00:04.0[A] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:06.0[A] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:0f.2[A] -> IRQ 30
PCI->APIC IRQ transform: 0000:01:05.0[A] -> IRQ 24
PCI->APIC IRQ transform: 0000:01:05.1[B] -> IRQ 25
Simple Boot Flag at 0x3a set to 0x1
Squashfs 2.2 (released 2005/07/03) (C) 2002-2005 Phillip Lougher
SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered
io scheduler deadline registered
initialized device: /dev/synth, node ( MAJOR 10, MINOR 25 )
vesafb: framebuffer at 0xfb000000, mapped to 0xe0880000, using 3072k, total 4096k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:4d24
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
mice: PS/2 mouse device common for all mice
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 0000:00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input0
hda: LITE-ON DVDRW SOHW-1693S, ATAPI CD/DVD-ROM drive
hdb: WDC WD800AB-22CBA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hdb: max request size: 128KiB
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, (U)DMA
hdb: cache flushes not supported
 hdb: hdb1 hdb2 hdb3 hdb4
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.20
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
EISA: Probing bus 0 at eisa.0
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 220k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
USB Universal Host Controller Interface driver v2.3
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:0f.2: OHCI Host Controller
ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0f.2: irq 30, io mem 0xfa000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
sl811: driver sl811-hcd, 19 May 2005
ieee1394: Initialized config rom entry `ip1394'
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
libata version 1.20 loaded.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
ReiserFS: hda: warning: sh-2021: reiserfs_fill_super: can not find reiserfs on hda
VFS: Can't find ext3 filesystem on dev hda.
VFS: Can't find an ext2 filesystem on dev hda.
SQUASHFS error: Can't find a SQUASHFS superblock on hda
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev hda.
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
eth0: Davicom DM9102 at pci0000:00:06.0, 00:80:ad:c1:50:16, irq 19.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:04.0: 3Com PCI 3c905B Cyclone 100baseTx at e0be0000. Vers LK1.1.19
dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
eth0: Davicom DM9102 at pci0000:00:06.0, 00:80:ad:c1:50:16, irq 19.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:04.0: 3Com PCI 3c905B Cyclone 100baseTx at e0be0000. Vers LK1.1.19
sym0: <896> rev 0x7 at pci 0000:01:05.0 irq 24
sym0: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.1
Uhhuh. NMI received. Dazed and confused, but trying to continue
You probably have a hardware problem with your RAM chips
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
sym1: <896> rev 0x7 at pci 0000:01:05.1 irq 25
sym1: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.1
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
e100: eth2: e100_probe: addr 0xfe000000, irq 20, MAC addr 00:E0:18:47:03:EE
eth0: Tx timeout - resetting
e100: eth2: e100_watchdog: link up, 100Mbps, full-duplex
e100: eth2: e100_watchdog: link up, 100Mbps, full-duplex
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
fbsplash: console 0 using theme 'default'
fbsplash: switched splash state to 'on' on console 0
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
eth0: Tx timeout - resetting
ReiserFS: hdb3: found reiserfs format "3.6" with standard journal
ReiserFS: hdb3: using ordered data mode
ReiserFS: hdb3: journal params: device hdb3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb3: checking transaction log (hdb3)
ReiserFS: hdb3: replayed 8 transactions in 0 seconds
ReiserFS: hdb3: Using r5 hash to sort names
ReiserFS: md_d0: warning: sh-2006: read_super_block: bread failed (dev md_d0, block 2, size 4096)
ReiserFS: md_d0: warning: sh-2006: read_super_block: bread failed (dev md_d0, block 16, size 4096)
ReiserFS: md_d0: warning: sh-2021: reiserfs_fill_super: can not find reiserfs on md_d0
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: replayed 1 transactions in 1 seconds
ReiserFS: dm-0: Using r5 hash to sort names
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: replayed 1 transactions in 0 seconds
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-3: found reiserfs format "3.6" with standard journal
ReiserFS: dm-3: using ordered data mode
ReiserFS: dm-3: journal params: device dm-3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-3: checking transaction log (dm-3)
ReiserFS: dm-3: replayed 2 transactions in 0 seconds
ReiserFS: dm-3: Using r5 hash to sort names
XFS mounting filesystem dm-2
Starting XFS recovery on filesystem: dm-2 (logdev: internal)
Ending XFS recovery on filesystem: dm-2 (logdev: internal)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth2: no IPv6 routers present

Thank you for your interest in this matter.

Mark
