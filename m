Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbVIPIeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbVIPIeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbVIPIeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:34:10 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:18413 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161129AbVIPIeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:34:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:content-type;
        b=JGtLUXfsJSBrYjYT0Tbn6b/b2QvwBk2+C+wBgcl196dAQDka7JBXCyhUG7fKjHFTWl6kmyXguCQsHVsxL5UcxeX6LyA96TFAryBs/thy6KjA3F0yYPoy78lmllRGvMDYOux+G+5DQvXCTZTblSUFw5+6/I/uSab7dWNAd5kPbQQ=
Message-ID: <432A8377.4050209@gmail.com>
Date: Fri, 16 Sep 2005 10:33:59 +0200
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050810)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: (BUG?) ACPI fails to suspend
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------070401030508060407070007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070401030508060407070007
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

after:

echo shutdown > /sys/power/disk
echo disk > /sys/power/state

i get:

Could not suspend device 0000:00:0a.2: error -22

0000:00:0a.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 50)
0000:00:0a.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 50)
0000:00:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)

it's a pci usb 2.0 card. no active device plugged there.

the bad thing is that i can't suspend.
the good thing is that kernel is safe, i can still work with it, without 
panic or other troubles.

i attach part of log.

--------------070401030508060407070007
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kern.log"

Sep 15 08:24:04 blight kernel: klogd 1.4.1, log source = /proc/kmsg started.
Sep 15 08:24:04 blight kernel: Inspecting /boot/System.map-2.6.14-rc1
Sep 15 08:24:05 blight kernel: Loaded 26324 symbols from /boot/System.map-2.6.14-rc1.
Sep 15 08:24:05 blight kernel: Symbols match kernel version 2.6.14.
Sep 15 08:24:05 blight kernel: Error querying loaded modules - Function not implemented 
Sep 15 08:24:05 blight kernel: Linux version 2.6.14-rc1 (root@blight) (gcc version 3.4.4 (Gentoo 3.4.4-r1)) #77 Tue Sep 13 15:42:09 CEST 2005
Sep 15 08:24:05 blight kernel: BIOS-provided physical RAM map:
Sep 15 08:24:05 blight kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Sep 15 08:24:05 blight kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Sep 15 08:24:05 blight kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Sep 15 08:24:05 blight kernel:  BIOS-e820: 0000000000100000 - 000000001fffd000 (usable)
Sep 15 08:24:05 blight kernel:  BIOS-e820: 000000001fffd000 - 000000001ffff000 (ACPI data)
Sep 15 08:24:05 blight kernel:  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
Sep 15 08:24:05 blight kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Sep 15 08:24:05 blight kernel: 511MB LOWMEM available.
Sep 15 08:24:05 blight kernel: On node 0 totalpages: 131069
Sep 15 08:24:05 blight kernel:   DMA zone: 4096 pages, LIFO batch:1
Sep 15 08:24:05 blight kernel:   Normal zone: 126973 pages, LIFO batch:31
Sep 15 08:24:05 blight kernel:   HighMem zone: 0 pages, LIFO batch:1
Sep 15 08:24:05 blight kernel: DMI 2.0 present.
Sep 15 08:24:05 blight kernel: ACPI: RSDP (v000 ASUS                                  ) @ 0x000f8030
Sep 15 08:24:05 blight kernel: ACPI: RSDT (v001 ASUS   P2B-F    0x58582e32 MSFT 0x31313031) @ 0x1fffd000
Sep 15 08:24:05 blight kernel: ACPI: FADT (v001 ASUS   P2B-F    0x58582e32 MSFT 0x31313031) @ 0x1fffd080
Sep 15 08:24:05 blight kernel: ACPI: BOOT (v001 ASUS   P2B-F    0x58582e32 MSFT 0x31313031) @ 0x1fffd040
Sep 15 08:24:05 blight kernel: ACPI: DSDT (v001   ASUS P2B-F    0x00001000 MSFT 0x01000001) @ 0x00000000
Sep 15 08:24:05 blight kernel: Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
Sep 15 08:24:05 blight kernel: Built 1 zonelists
Sep 15 08:24:05 blight kernel: Kernel command line: auto BOOT_IMAGE=Gentoo ro root=306 quiet snd_ens1370.joystick=1 video=aty128fb:mtrr,ywrap,pmipal,accel,1024x768-16@85 splash=verbose,theme:livecd-2005.1,tty:11
Sep 15 08:24:05 blight kernel: Local APIC disabled by BIOS -- you can enable it with "lapic"
Sep 15 08:24:05 blight kernel: mapped APIC to ffffd000 (01402000)
Sep 15 08:24:05 blight kernel: Initializing CPU#0
Sep 15 08:24:05 blight kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
Sep 15 08:24:05 blight kernel: Detected 501.259 MHz processor.
Sep 15 08:24:05 blight kernel: Using tsc for high-res timesource
Sep 15 08:24:05 blight kernel: Console: colour VGA+ 80x25
Sep 15 08:24:05 blight kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Sep 15 08:24:05 blight kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Sep 15 08:24:05 blight kernel: Memory: 513756k/524276k available (2585k kernel code, 9920k reserved, 726k data, 212k init, 0k highmem)
Sep 15 08:24:05 blight kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Sep 15 08:24:05 blight kernel: Calibrating delay using timer specific routine.. 1003.21 BogoMIPS (lpj=501607)
Sep 15 08:24:05 blight kernel: Mount-cache hash table entries: 512
Sep 15 08:24:05 blight kernel: CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 00000000 00000000
Sep 15 08:24:05 blight kernel: CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 00000000 00000000
Sep 15 08:24:05 blight kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Sep 15 08:24:05 blight kernel: CPU: L2 cache: 512K
Sep 15 08:24:05 blight kernel: CPU serial number disabled.
Sep 15 08:24:05 blight kernel: CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Sep 15 08:24:05 blight kernel: mtrr: v2.0 (20020519)
Sep 15 08:24:05 blight kernel: CPU: Intel Pentium III (Katmai) stepping 02
Sep 15 08:24:05 blight kernel: Enabling fast FPU save and restore... done.
Sep 15 08:24:05 blight kernel: Enabling unmasked SIMD FPU exception support... done.
Sep 15 08:24:05 blight kernel: Checking 'hlt' instruction... OK.
Sep 15 08:24:05 blight kernel: ACPI: setting ELCR to 0200 (from 0e20)
Sep 15 08:24:05 blight kernel: checking if image is initramfs... it is
Sep 15 08:24:05 blight kernel: Freeing initrd memory: 1234k freed
Sep 15 08:24:05 blight kernel: NET: Registered protocol family 16
Sep 15 08:24:05 blight kernel: ACPI: bus type pci registered
Sep 15 08:24:05 blight kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
Sep 15 08:24:05 blight kernel: PCI: Using configuration type 1
Sep 15 08:24:05 blight kernel: ACPI: Subsystem revision 20050902
Sep 15 08:24:05 blight kernel: ACPI: Interpreter enabled
Sep 15 08:24:05 blight kernel: ACPI: Using PIC for interrupt routing
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Sep 15 08:24:05 blight kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Sep 15 08:24:05 blight kernel: PCI: Probing PCI hardware (bus 00)
Sep 15 08:24:05 blight kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Sep 15 08:24:05 blight kernel: Boot video device is 0000:01:00.0
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep 15 08:24:05 blight kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Sep 15 08:24:05 blight kernel: pnp: PnP ACPI init
Sep 15 08:24:05 blight kernel: pnp: PnP ACPI: found 12 devices
Sep 15 08:24:05 blight kernel: usbcore: registered new driver usbfs
Sep 15 08:24:05 blight kernel: usbcore: registered new driver hub
Sep 15 08:24:05 blight kernel: PCI: Using ACPI for IRQ routing
Sep 15 08:24:05 blight kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Sep 15 08:24:05 blight kernel: PCI: BIOS reporting unknown device 00:50
Sep 15 08:24:05 blight kernel: PCI: Device 0000:00:0a.1 not found by BIOS
Sep 15 08:24:05 blight kernel: pnp: 00:01: ioport range 0xe400-0xe43f could not be reserved
Sep 15 08:24:05 blight kernel: pnp: 00:01: ioport range 0xe800-0xe80f has been reserved
Sep 15 08:24:05 blight kernel: pnp: 00:01: ioport range 0x294-0x297 has been reserved
Sep 15 08:24:05 blight kernel: PCI: Bridge: 0000:00:01.0
Sep 15 08:24:05 blight kernel:   IO window: d000-dfff
Sep 15 08:24:05 blight kernel:   MEM window: db000000-dbdfffff
Sep 15 08:24:05 blight kernel:   PREFETCH window: dbf00000-dfffffff
Sep 15 08:24:05 blight kernel: Simple Boot Flag at 0x46 set to 0x1
Sep 15 08:24:05 blight kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Sep 15 08:24:05 blight kernel: Limiting direct PCI/PCI transfers.
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Sep 15 08:24:05 blight kernel: PCI: setting IRQ 11 as level-triggered
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Sep 15 08:24:05 blight kernel: aty128fb: Found Intel x86 BIOS ROM Image
Sep 15 08:24:05 blight kernel: aty128fb: Rage128 BIOS located
Sep 15 08:24:05 blight kernel: aty128fb: Rage128 RF AGP [chip rev 0x2] 32M 128-bit SDR SGRAM (1:1)
Sep 15 08:24:05 blight kernel: Console: switching to colour frame buffer device 128x48
Sep 15 08:24:05 blight kernel: fb0: ATY Rage128 frame buffer device on Rage128 RF AGP
Sep 15 08:24:05 blight kernel: aty128fb: Rage128 MTRR set to ON
Sep 15 08:24:05 blight kernel: ACPI: Power Button (FF) [PWRF]
Sep 15 08:24:05 blight kernel: ACPI: Power Button (CM) [PWRB]
Sep 15 08:24:05 blight kernel: HDLC line discipline: version $Revision: 4.8 $, maxframe=4096
Sep 15 08:24:05 blight kernel: N_HDLC line discipline registered.
Sep 15 08:24:05 blight kernel: lp: driver loaded but no devices found
Sep 15 08:24:05 blight kernel: Generic RTC Driver v1.07
Sep 15 08:24:05 blight kernel: Linux agpgart interface v0.101 (c) Dave Jones
Sep 15 08:24:05 blight kernel: agpgart: Detected an Intel 440BX Chipset.
Sep 15 08:24:05 blight kernel: agpgart: AGP aperture is 128M @ 0xe0000000
Sep 15 08:24:05 blight kernel: [drm] Initialized drm 1.0.0 20040925
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Sep 15 08:24:05 blight kernel: [drm] Initialized r128 2.5.0 20030725 on minor 0: 
Sep 15 08:24:05 blight kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Sep 15 08:24:05 blight kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 15 08:24:05 blight kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 15 08:24:05 blight kernel: parport: PnPBIOS parport detected.
Sep 15 08:24:05 blight kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
Sep 15 08:24:05 blight kernel: lp0: using parport0 (interrupt-driven).
Sep 15 08:24:05 blight kernel: lp0: console ready
Sep 15 08:24:05 blight kernel: io scheduler noop registered
Sep 15 08:24:05 blight kernel: io scheduler anticipatory registered
Sep 15 08:24:05 blight kernel: io scheduler deadline registered
Sep 15 08:24:05 blight kernel: io scheduler cfq registered
Sep 15 08:24:05 blight kernel: Floppy drive(s): fd0 is 1.44M
Sep 15 08:24:05 blight kernel: FDC 0 is a post-1991 82077
Sep 15 08:24:05 blight kernel: RAMDISK driver initialized: 1 RAM disks of 4096K size 1024 blocksize
Sep 15 08:24:05 blight kernel: loop: loaded (max 8 devices)
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
Sep 15 08:24:05 blight kernel: PCI: setting IRQ 9 as level-triggered
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 08:24:05 blight kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Sep 15 08:24:05 blight kernel: 0000:00:09.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xb000. Vers LK1.1.19
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 08:24:05 blight kernel: 0000:00:0d.0: 3Com PCI 3c905C Tornado at 0x9800. Vers LK1.1.19
Sep 15 08:24:05 blight kernel: PPP generic driver version 2.4.2
Sep 15 08:24:05 blight kernel: PPP Deflate Compression module registered
Sep 15 08:24:05 blight kernel: PPP BSD Compression module registered
Sep 15 08:24:05 blight kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep 15 08:24:05 blight kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 15 08:24:05 blight kernel: PIIX4: IDE controller at PCI slot 0000:00:04.1
Sep 15 08:24:05 blight kernel: PIIX4: chipset revision 1
Sep 15 08:24:05 blight kernel: PIIX4: not 100%% native mode: will probe irqs later
Sep 15 08:24:05 blight kernel:     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
Sep 15 08:24:05 blight kernel:     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
Sep 15 08:24:05 blight kernel: Probing IDE interface ide0...
Sep 15 08:24:05 blight kernel: hda: IBM-DTLA-307030, ATA DISK drive
Sep 15 08:24:05 blight kernel: hdb: STORM52/1, ATAPI CD/DVD-ROM drive
Sep 15 08:24:05 blight kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 15 08:24:05 blight kernel: Probing IDE interface ide1...
Sep 15 08:24:05 blight kernel: hdc: IC35L060AVV207-0, ATA DISK drive
Sep 15 08:24:05 blight kernel: hdd: ATAPI CDROM, ATAPI CD/DVD-ROM drive
Sep 15 08:24:05 blight kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 15 08:24:05 blight kernel: hda: max request size: 128KiB
Sep 15 08:24:05 blight kernel: hda: 60036480 sectors (30738 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(33)
Sep 15 08:24:05 blight kernel: hda: cache flushes not supported
Sep 15 08:24:05 blight kernel:  hda: hda1 hda2 < hda5 hda6 >
Sep 15 08:24:05 blight kernel: hdc: max request size: 1024KiB
Sep 15 08:24:05 blight kernel: hdc: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(33)
Sep 15 08:24:05 blight kernel: hdc: cache flushes supported
Sep 15 08:24:05 blight kernel:  hdc: hdc1 hdc2 < hdc5 hdc6 >
Sep 15 08:24:05 blight kernel: hdb: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Sep 15 08:24:05 blight kernel: Uniform CD-ROM driver Revision: 3.20
Sep 15 08:24:05 blight kernel: hdd: ATAPI 35X CD-ROM drive, 128kB Cache, UDMA(33)
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt 0000:00:0a.2[C] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Sep 15 08:24:05 blight kernel: ehci_hcd 0000:00:0a.2: EHCI Host Controller
Sep 15 08:24:05 blight kernel: ehci_hcd 0000:00:0a.2: new USB bus registered, assigned bus number 1
Sep 15 08:24:05 blight kernel: ehci_hcd 0000:00:0a.2: irq 11, io mem 0xda000000
Sep 15 08:24:05 blight kernel: ehci_hcd 0000:00:0a.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
Sep 15 08:24:05 blight kernel: hub 1-0:1.0: USB hub found
Sep 15 08:24:05 blight kernel: hub 1-0:1.0: 4 ports detected
Sep 15 08:24:05 blight kernel: USB Universal Host Controller Interface driver v2.3
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 08:24:05 blight kernel: uhci_hcd 0000:00:04.2: UHCI Host Controller
Sep 15 08:24:05 blight kernel: uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 2
Sep 15 08:24:05 blight kernel: uhci_hcd 0000:00:04.2: irq 9, io base 0x0000b400
Sep 15 08:24:05 blight kernel: hub 2-0:1.0: USB hub found
Sep 15 08:24:05 blight kernel: hub 2-0:1.0: 2 ports detected
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Sep 15 08:24:05 blight kernel: PCI: setting IRQ 5 as level-triggered
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Sep 15 08:24:05 blight kernel: uhci_hcd 0000:00:0a.0: UHCI Host Controller
Sep 15 08:24:05 blight kernel: uhci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 3
Sep 15 08:24:05 blight kernel: uhci_hcd 0000:00:0a.0: irq 5, io base 0x0000a800
Sep 15 08:24:05 blight kernel: hub 3-0:1.0: USB hub found
Sep 15 08:24:05 blight kernel: hub 3-0:1.0: 2 ports detected
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 08:24:05 blight kernel: uhci_hcd 0000:00:0a.1: UHCI Host Controller
Sep 15 08:24:05 blight kernel: uhci_hcd 0000:00:0a.1: new USB bus registered, assigned bus number 4
Sep 15 08:24:05 blight kernel: uhci_hcd 0000:00:0a.1: irq 9, io base 0x0000a400
Sep 15 08:24:05 blight kernel: hub 4-0:1.0: USB hub found
Sep 15 08:24:05 blight kernel: hub 4-0:1.0: 2 ports detected
Sep 15 08:24:05 blight kernel: mice: PS/2 mouse device common for all mice
Sep 15 08:24:05 blight kernel: input: PC Speaker
Sep 15 08:24:05 blight kernel: Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Tue Aug 30 05:31:08 2005 UTC).
Sep 15 08:24:05 blight kernel: usb 2-2: new full speed USB device using uhci_hcd and address 2
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Sep 15 08:24:05 blight kernel: PCI: setting IRQ 10 as level-triggered
Sep 15 08:24:05 blight kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Sep 15 08:24:05 blight kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Sep 15 08:24:05 blight kernel: gameport: ES137x is pci0000:00:0b.0/gameport0, io 0x200, speed 877kHz
Sep 15 08:24:05 blight kernel: ALSA device list:
Sep 15 08:24:05 blight kernel:   #0: Ensoniq AudioPCI ENS1370 at 0xa000, irq 10
Sep 15 08:24:05 blight kernel: NET: Registered protocol family 2
Sep 15 08:24:05 blight kernel: IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
Sep 15 08:24:05 blight kernel: TCP established hash table entries: 32768 (order: 6, 262144 bytes)
Sep 15 08:24:05 blight kernel: TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
Sep 15 08:24:05 blight kernel: TCP: Hash tables configured (established 32768 bind 32768)
Sep 15 08:24:05 blight kernel: TCP reno registered
Sep 15 08:24:05 blight kernel: ip_conntrack version 2.3 (4095 buckets, 32760 max) - 252 bytes per conntrack
Sep 15 08:24:05 blight kernel: ip_tables: (C) 2000-2002 Netfilter core team
Sep 15 08:24:05 blight kernel: ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Sep 15 08:24:05 blight kernel: arp_tables: (C) 2002 David S. Miller
Sep 15 08:24:05 blight kernel: TCP bic registered
Sep 15 08:24:05 blight kernel: NET: Registered protocol family 1
Sep 15 08:24:05 blight kernel: NET: Registered protocol family 17
Sep 15 08:24:05 blight kernel: NET: Registered protocol family 15
Sep 15 08:24:05 blight kernel: Using IPI Shortcut mode
Sep 15 08:24:05 blight kernel: ReiserFS: hda6: found reiserfs format "3.6" with standard journal
Sep 15 08:24:05 blight kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Sep 15 08:24:05 blight kernel: ReiserFS: hda6: using ordered data mode
Sep 15 08:24:05 blight kernel: ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Sep 15 08:24:05 blight kernel: ReiserFS: hda6: checking transaction log (hda6)
Sep 15 08:24:05 blight kernel: ReiserFS: hda6: Using r5 hash to sort names
Sep 15 08:24:05 blight kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Sep 15 08:24:05 blight kernel: Freeing unused kernel memory: 212k freed
Sep 15 08:24:05 blight kernel: Adding 441748k swap on /dev/hdc6.  Priority:-1 extents:1 across:441748k
Sep 15 08:24:05 blight kernel: ReiserFS: hdc5: found reiserfs format "3.6" with standard journal
Sep 15 08:24:05 blight kernel: ReiserFS: hdc5: using ordered data mode
Sep 15 08:24:05 blight kernel: ReiserFS: hdc5: journal params: device hdc5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Sep 15 08:24:05 blight kernel: ReiserFS: hdc5: checking transaction log (hdc5)
Sep 15 08:24:05 blight kernel: ReiserFS: hdc5: Using r5 hash to sort names
Sep 15 08:24:05 blight kernel: usb 2-2: usbfs: process 3720 (eciadsl-firmwar) did not claim interface 0 before use
Sep 15 08:24:05 blight kernel: usb 2-2: USB disconnect, address 2
Sep 15 08:24:05 blight kernel: usb 2-2: new full speed USB device using uhci_hcd and address 3
Sep 15 08:24:05 blight kernel: usb 2-2: can't set config #1, error -75
Sep 15 08:24:05 blight kernel: usb 2-2: new full speed USB device using uhci_hcd and address 4
Sep 15 08:24:12 blight kernel: ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 08:24:15 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 08:24:17 blight kernel: eth0: Setting promiscuous mode.
Sep 15 08:24:17 blight kernel: device eth0 entered promiscuous mode
Sep 15 08:24:17 blight kernel: eth1: Setting promiscuous mode.
Sep 15 08:24:17 blight kernel: device eth1 entered promiscuous mode
Sep 15 08:24:29 blight kernel: agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
Sep 15 08:24:29 blight kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
Sep 15 08:24:29 blight kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
Sep 15 08:24:56 blight kernel: device ppp0 entered promiscuous mode
Sep 15 08:25:18 blight kernel: eth1: Setting full-duplex based on MII #24 link partner capability of 05e1.
Sep 15 08:25:18 blight kernel: blight: port 2(eth1) entering learning state
Sep 15 08:25:33 blight kernel: blight: topology change detected, propagating
Sep 15 08:25:33 blight kernel: blight: port 2(eth1) entering forwarding state
Sep 15 13:31:14 blight kernel: eth0: Setting full-duplex based on MII #24 link partner capability of 01e1.
Sep 15 13:31:14 blight kernel: blight: port 1(eth0) entering learning state
Sep 15 13:31:29 blight kernel: blight: topology change detected, propagating
Sep 15 13:31:29 blight kernel: blight: port 1(eth0) entering forwarding state
Sep 15 14:21:17 blight kernel: blight: port 2(eth1) entering disabled state
Sep 15 14:26:14 blight kernel: blight: port 1(eth0) entering disabled state
Sep 15 14:28:36 blight kernel: Stopping tasks: =======================================|
Sep 15 14:28:36 blight kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^Hdone (77270 pages freed)
Sep 15 14:28:36 blight kernel: usbfs 2-2:1.0: resume is unsafe!
Sep 15 14:28:36 blight kernel: ACPI: PCI interrupt for device 0000:00:0d.0 disabled
Sep 15 14:28:36 blight kernel: ACPI: PCI interrupt for device 0000:00:0a.2 disabled
Sep 15 14:28:36 blight kernel: Could not suspend device 0000:00:0a.2: error -22
Sep 15 14:28:36 blight kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Sep 15 14:28:36 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:28:37 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:28:37 blight kernel: eth1: Setting promiscuous mode.
Sep 15 14:28:37 blight kernel: Some devices failed to suspend
Sep 15 14:28:37 blight kernel: Restarting tasks... done
Sep 15 14:28:37 blight kernel: device ppp0 left promiscuous mode
Sep 15 14:28:52 blight kernel: usb 2-2: USB disconnect, address 4
Sep 15 14:28:59 blight kernel: Stopping tasks: =======================================|
Sep 15 14:28:59 blight kernel: Freeing memory...  ^H-^Hdone (16103 pages freed)
Sep 15 14:28:59 blight kernel: ACPI: PCI interrupt for device 0000:00:0d.0 disabled
Sep 15 14:28:59 blight kernel: Could not suspend device 0000:00:0a.2: error -22
Sep 15 14:28:59 blight kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Sep 15 14:28:59 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:28:59 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:28:59 blight kernel: eth1: Setting promiscuous mode.
Sep 15 14:28:59 blight kernel: Some devices failed to suspend
Sep 15 14:28:59 blight kernel: Restarting tasks... done
Sep 15 14:29:38 blight kernel: mtrr: no MTRR for dc000000,2000000 found
Sep 15 14:29:39 blight kernel: agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
Sep 15 14:29:39 blight kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
Sep 15 14:29:39 blight kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
Sep 15 14:30:01 blight kernel: mtrr: no MTRR for dc000000,2000000 found
Sep 15 14:30:18 blight kernel: Stopping tasks: ===============|
Sep 15 14:30:18 blight kernel: Freeing memory...  ^H-^H\^Hdone (14408 pages freed)
Sep 15 14:30:18 blight kernel: ACPI: PCI interrupt for device 0000:00:0d.0 disabled
Sep 15 14:30:18 blight kernel: Could not suspend device 0000:00:0a.2: error -22
Sep 15 14:30:18 blight kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Sep 15 14:30:18 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:30:18 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:30:18 blight kernel: eth1: Setting promiscuous mode.
Sep 15 14:30:18 blight kernel: Some devices failed to suspend
Sep 15 14:30:18 blight kernel: Restarting tasks... done
Sep 15 14:31:01 blight kernel: agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
Sep 15 14:31:01 blight kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
Sep 15 14:31:01 blight kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
Sep 15 14:31:55 blight kernel: mtrr: no MTRR for dc000000,2000000 found
Sep 15 14:31:55 blight kernel: agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
Sep 15 14:31:55 blight kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
Sep 15 14:31:55 blight kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
Sep 15 14:32:19 blight kernel: agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
Sep 15 14:32:19 blight kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
Sep 15 14:32:19 blight kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
Sep 15 14:32:23 blight kernel: mtrr: no MTRR for dc000000,2000000 found
Sep 15 14:32:34 blight kernel: eth0: Setting promiscuous mode.
Sep 15 14:32:34 blight kernel: device eth0 left promiscuous mode
Sep 15 14:32:34 blight kernel: blight: port 1(eth0) entering disabled state
Sep 15 14:32:34 blight kernel: eth1: Setting promiscuous mode.
Sep 15 14:32:34 blight kernel: device eth1 left promiscuous mode
Sep 15 14:32:34 blight kernel: blight: port 2(eth1) entering disabled state
Sep 15 14:32:50 blight kernel: Kernel logging (proc) stopped.
Sep 15 14:32:50 blight kernel: Kernel log daemon terminating.

--------------070401030508060407070007--
