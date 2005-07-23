Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVGWC2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVGWC2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 22:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVGWC2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 22:28:21 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:37622 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262296AbVGWC2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 22:28:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=gQDxQF6UzgkAQTtoimtRsqsKYva8AjcQJJvVCHRs2aU+i4+OOF7AoxLgFvKUL+XJMsT8zDfT33sV+SanNn1dDAiGaYfLxlw0JAtUYciFSM+liR31v3RP5n9IWc23kK12+Aoln71Eb9ZAhGavoDoNnn/UJtI0KE/FuQKaFxxj4Kk=
Message-ID: <1c1c863605072219283716a131@mail.gmail.com>
Date: Sat, 23 Jul 2005 14:28:14 +1200
From: mdew <some.nzguy@gmail.com>
Reply-To: mdew <some.nzguy@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: HPT370 errors under 2.6.13-rc3-mm1
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3025_20485640.1122085694907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3025_20485640.1122085694907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm unable to mount an ext2 drive using the hpt370A raid card.

upon mounting the drive, dmesg will spew these errors..I've tried
different cables and drive is fine.

Jul 23 01:30:11 localhost kernel: hdf: dma_timer_expiry: dma status =3D=3D =
0x41
Jul 23 01:30:21 localhost kernel: hdf: DMA timeout error
Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: status=3D0x25
{ DeviceFault CorrectedError Error }
Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: error=3D0x25 {
DriveStatusError AddrMarkNotFound }, LBAsect=3D8830589412645,
high=3D526344, low=3D2434341, sector=3D390715711
Jul 23 01:30:21 localhost kernel: ide: failed opcode was: unknown
Jul 23 01:30:21 localhost kernel: hdf: DMA disabled
Jul 23 01:30:21 localhost kernel: ide2: reset: master: error (0x0a?)
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf,
sector 390715711
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf,
sector 390715712
[...]

------=_Part_3025_20485640.1122085694907
Content-Type: text/plain; name=dmesg.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.txt"

Jul 23 01:27:53 localhost kernel: Linux version 2.6.13-rc3-mm1 (root@mediabawx2) (gcc version 4.0.1 (Debian 4.0.1-2)) #6 PREEMPT Fri Jul 22 07:02:18 NZST 2005
Jul 23 01:27:53 localhost kernel: BIOS-provided physical RAM map:
Jul 23 01:27:53 localhost kernel:  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
Jul 23 01:27:53 localhost kernel:  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
Jul 23 01:27:53 localhost kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul 23 01:27:53 localhost kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Jul 23 01:27:53 localhost kernel:  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
Jul 23 01:27:53 localhost kernel:  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
Jul 23 01:27:53 localhost kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jul 23 01:27:53 localhost kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jul 23 01:27:53 localhost kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jul 23 01:27:53 localhost kernel: 255MB LOWMEM available.
Jul 23 01:27:53 localhost kernel: DMI 2.3 present.
Jul 23 01:27:53 localhost kernel: Allocating PCI resources starting at 10000000 (gap: 10000000:eec00000)
Jul 23 01:27:53 localhost kernel: Built 1 zonelists
Jul 23 01:27:53 localhost kernel: Initializing CPU#0
Jul 23 01:27:53 localhost kernel: Kernel command line: BOOT_IMAGE=linux-2.6 ro root=341
Jul 23 01:27:53 localhost kernel: PID hash table entries: 1024 (order: 10, 16384 bytes)
Jul 23 01:27:53 localhost kernel: Detected 1665.601 MHz processor.
Jul 23 01:27:53 localhost kernel: Using tsc for high-res timesource
Jul 23 01:27:53 localhost kernel: Console: colour VGA+ 80x25
Jul 23 01:27:53 localhost kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul 23 01:27:53 localhost kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Jul 23 01:27:53 localhost kernel: Memory: 254432k/262080k available (3173k kernel code, 7072k reserved, 1071k data, 164k init, 0k highmem)
Jul 23 01:27:53 localhost kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jul 23 01:27:53 localhost kernel: Calibrating delay using timer specific routine.. 3336.50 BogoMIPS (lpj=6673003)
Jul 23 01:27:53 localhost kernel: Mount-cache hash table entries: 512
Jul 23 01:27:53 localhost kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 23 01:27:53 localhost kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jul 23 01:27:53 localhost kernel: Intel machine check architecture supported.
Jul 23 01:27:53 localhost kernel: Intel machine check reporting enabled on CPU#0.
Jul 23 01:27:53 localhost kernel: mtrr: v2.0 (20020519)
Jul 23 01:27:53 localhost kernel: CPU: AMD Athlon(tm) XP 2000+ stepping 00
Jul 23 01:27:53 localhost kernel: Enabling fast FPU save and restore... done.
Jul 23 01:27:53 localhost kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 23 01:27:53 localhost kernel: Checking 'hlt' instruction... OK.
Jul 23 01:27:53 localhost kernel: ACPI: setting ELCR to 0200 (from 0e28)
Jul 23 01:27:53 localhost kernel: NET: Registered protocol family 16
Jul 23 01:27:53 localhost kernel: ACPI: bus type pci registered
Jul 23 01:27:53 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xfba00, last bus=1
Jul 23 01:27:53 localhost kernel: PCI: Using configuration type 1
Jul 23 01:27:53 localhost kernel: ACPI: Subsystem revision 20050408
Jul 23 01:27:53 localhost kernel: ACPI: Interpreter enabled
Jul 23 01:27:53 localhost kernel: ACPI: Using PIC for interrupt routing
Jul 23 01:27:53 localhost kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jul 23 01:27:53 localhost kernel: PCI: Probing PCI hardware (bus 00)
Jul 23 01:27:53 localhost kernel: ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Jul 23 01:27:53 localhost kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12)
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 11 12) *5
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 *10 11 12)
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 6 7 10 11 12)
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0, disabled.
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0, disabled.
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0, disabled.
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0, disabled.
Jul 23 01:27:53 localhost kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jul 23 01:27:53 localhost kernel: pnp: PnP ACPI init
Jul 23 01:27:53 localhost kernel: pnp: PnP ACPI: found 12 devices
Jul 23 01:27:53 localhost kernel: SCSI subsystem initialized
Jul 23 01:27:53 localhost kernel: usbcore: registered new driver usbfs
Jul 23 01:27:53 localhost kernel: usbcore: registered new driver hub
Jul 23 01:27:53 localhost kernel: PCI: Using ACPI for IRQ routing
Jul 23 01:27:53 localhost kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jul 23 01:27:53 localhost kernel: fscache: general fs caching registered
Jul 23 01:27:53 localhost kernel: pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
Jul 23 01:27:53 localhost kernel: pnp: 00:01: ioport range 0x5000-0x500f has been reserved
Jul 23 01:27:53 localhost kernel: Machine check exception polling timer started.Jul 23 01:27:53 localhost kernel: NTFS driver 2.1.23 [Flags: R/O].
Jul 23 01:27:53 localhost kernel: Initializing Cryptographic API
Jul 23 01:27:53 localhost kernel: ACPI: Power Button (FF) [PWRF]
Jul 23 01:27:53 localhost kernel: ACPI: Power Button (CM) [PWRB]
Jul 23 01:27:53 localhost kernel: ACPI: Fan [FAN] (on)
Jul 23 01:27:53 localhost kernel: Disabling BM access before entering C3
Jul 23 01:27:53 localhost kernel: ACPI: CPU0 (power states: C1[C1] C2[C2])
Jul 23 01:27:53 localhost kernel: ACPI: Thermal Zone [THRM] (40 C)
Jul 23 01:27:53 localhost kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jul 23 01:27:53 localhost kernel: [drm] Initialized drm 1.0.0 20040925
Jul 23 01:27:53 localhost kernel: cn_fork is registered
Jul 23 01:27:53 localhost kernel: cn_exit is registered
Jul 23 01:27:53 localhost kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Jul 23 01:27:53 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 23 01:27:53 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 23 01:27:53 localhost kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Jul 23 01:27:53 localhost kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul 23 01:27:53 localhost kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul 23 01:27:53 localhost kernel: mice: PS/2 mouse device common for all mice
Jul 23 01:27:53 localhost kernel: io scheduler noop registered
Jul 23 01:27:53 localhost kernel: io scheduler anticipatory registered
Jul 23 01:27:53 localhost kernel: io scheduler deadline registered
Jul 23 01:27:53 localhost kernel: io scheduler cfq registered
Jul 23 01:27:53 localhost kernel: Floppy drive(s): fd0 is 1.44M
Jul 23 01:27:53 localhost kernel: FDC 0 is a post-1991 82077
Jul 23 01:27:53 localhost kernel: 8139too Fast Ethernet driver 0.9.27
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Jul 23 01:27:53 localhost kernel: PCI: setting IRQ 10 as level-triggered
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Jul 23 01:27:53 localhost kernel: eth0: RealTek RTL8139 at 0xd800, 00:40:ca:4a:4e:71, IRQ 10
Jul 23 01:27:53 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul 23 01:27:53 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul 23 01:27:53 localhost kernel: HPT370A: IDE controller at PCI slot 0000:00:08.0
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Jul 23 01:27:53 localhost kernel: PCI: setting IRQ 11 as level-triggered
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jul 23 01:27:53 localhost kernel: HPT370A: chipset revision 4
Jul 23 01:27:53 localhost kernel: HPT370A: 100%% native mode on irq 11
Jul 23 01:27:53 localhost kernel:     ide2: BM-DMA at 0xd000-0xd007, BIOS settings: hde:pio, hdf:DMA
Jul 23 01:27:53 localhost kernel:     ide3: BM-DMA at 0xd008-0xd00f, BIOS settings: hdg:pio, hdh:pio
Jul 23 01:27:53 localhost kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul 23 01:27:53 localhost kernel: input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
Jul 23 01:27:53 localhost kernel: hdf: ST3200822A, ATA DISK drive
Jul 23 01:27:53 localhost kernel: ide2 at 0xc000-0xc007,0xc402 on irq 11
Jul 23 01:27:53 localhost kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jul 23 01:27:53 localhost kernel: PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 11
Jul 23 01:27:53 localhost kernel: VP_IDE: chipset revision 6
Jul 23 01:27:53 localhost kernel: VP_IDE: not 100%% native mode: will probe irqs later
Jul 23 01:27:53 localhost kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Jul 23 01:27:53 localhost kernel:     ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:pio, hdb:DMA
Jul 23 01:27:53 localhost kernel:     ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:pio, hdd:pio
Jul 23 01:27:53 localhost kernel: hdb: Maxtor 2F040J0, ATA DISK drive
Jul 23 01:27:53 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 23 01:27:53 localhost kernel: hdf: max request size: 1024KiB
Jul 23 01:27:53 localhost kernel: hdf: Host Protected Area detected.
Jul 23 01:27:53 localhost kernel: ^Icurrent capacity is 390720512 sectors (200048 MB)
Jul 23 01:27:53 localhost kernel: ^Inative  capacity is 390721968 sectors (200049 MB)
Jul 23 01:27:53 localhost kernel: hdf: Host Protected Area disabled.
Jul 23 01:27:53 localhost kernel: hdf: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(33)
Jul 23 01:27:53 localhost kernel: hdf: cache flushes supported
Jul 23 01:27:53 localhost kernel:  hdf:<4>hdf: dma_timer_expiry: dma status == 0x41
Jul 23 01:27:53 localhost kernel: hdf: DMA timeout error
Jul 23 01:27:53 localhost kernel: hdf: dma timeout error: status=0x25 { DeviceFault CorrectedError Error }
Jul 23 01:27:53 localhost kernel: hdf: dma timeout error: error=0x25 { DriveStatusError AddrMarkNotFound }, LBAsect=8830589412645, high=526344, low=2434341, sector=0
Jul 23 01:27:53 localhost kernel: ide: failed opcode was: unknown
Jul 23 01:27:53 localhost kernel: hdf: DMA disabled
Jul 23 01:27:53 localhost kernel: ide2: reset: master: error (0x0a?)
Jul 23 01:27:53 localhost kernel:  hdf1
Jul 23 01:27:53 localhost kernel: hdb: max request size: 128KiB
Jul 23 01:27:53 localhost kernel: hdb: Host Protected Area detected.
Jul 23 01:27:53 localhost kernel: ^Icurrent capacity is 80291840 sectors (41109 MB)
Jul 23 01:27:53 localhost kernel: ^Inative  capacity is 80293248 sectors (41110 MB)
Jul 23 01:27:53 localhost kernel: hdb: Host Protected Area disabled.
Jul 23 01:27:53 localhost kernel: hdb: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
Jul 23 01:27:53 localhost kernel: hdb: cache flushes supported
Jul 23 01:27:53 localhost kernel:  hdb: hdb1 hdb2 < hdb5 >
Jul 23 01:27:53 localhost kernel: usbmon: debugs is not available
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
Jul 23 01:27:53 localhost kernel: PCI: setting IRQ 3 as level-triggered
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
Jul 23 01:27:53 localhost kernel: PCI: Via IRQ fixup for 0000:00:10.3, from 255 to 3
Jul 23 01:27:53 localhost kernel: ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
Jul 23 01:27:53 localhost kernel: ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
Jul 23 01:27:53 localhost kernel: ehci_hcd 0000:00:10.3: irq 3, io mem 0xe7001000
Jul 23 01:27:53 localhost kernel: ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Jul 23 01:27:53 localhost kernel: hub 1-0:1.0: USB hub found
Jul 23 01:27:53 localhost kernel: hub 1-0:1.0: 6 ports detected
Jul 23 01:27:53 localhost kernel: USB Universal Host Controller Interface driver v2.3
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jul 23 01:27:53 localhost kernel: PCI: Via IRQ fixup for 0000:00:10.0, from 255 to 11
Jul 23 01:27:53 localhost kernel: uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
Jul 23 01:27:53 localhost kernel: uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
Jul 23 01:27:53 localhost kernel: uhci_hcd 0000:00:10.0: irq 11, io base 0x0000dc00
Jul 23 01:27:53 localhost kernel: hub 2-0:1.0: USB hub found
Jul 23 01:27:53 localhost kernel: hub 2-0:1.0: 2 ports detected
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Jul 23 01:27:53 localhost kernel: PCI: Via IRQ fixup for 0000:00:10.1, from 255 to 11
Jul 23 01:27:53 localhost kernel: uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
Jul 23 01:27:53 localhost kernel: uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
Jul 23 01:27:53 localhost kernel: uhci_hcd 0000:00:10.1: irq 11, io base 0x0000e000
Jul 23 01:27:53 localhost kernel: hub 3-0:1.0: USB hub found
Jul 23 01:27:53 localhost kernel: hub 3-0:1.0: 2 ports detected
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Jul 23 01:27:53 localhost kernel: PCI: Via IRQ fixup for 0000:00:10.2, from 255 to 10
Jul 23 01:27:53 localhost kernel: uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
Jul 23 01:27:53 localhost kernel: uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
Jul 23 01:27:53 localhost kernel: uhci_hcd 0000:00:10.2: irq 10, io base 0x0000e400
Jul 23 01:27:53 localhost kernel: hub 4-0:1.0: USB hub found
Jul 23 01:27:53 localhost kernel: hub 4-0:1.0: 2 ports detected
Jul 23 01:27:53 localhost kernel: Initializing USB Mass Storage driver...
Jul 23 01:27:53 localhost kernel: usbcore: registered new driver usb-storage
Jul 23 01:27:53 localhost kernel: USB Mass Storage support registered.
Jul 23 01:27:53 localhost kernel: usbcore: registered new driver usbhid
Jul 23 01:27:53 localhost kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Jul 23 01:27:53 localhost kernel: Advanced Linux Sound Architecture Driver Version 1.0.9 (Sun May 29 07:31:02 2005 UTC).
Jul 23 01:27:53 localhost kernel: ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Jul 23 01:27:53 localhost kernel: ALSA device list:
Jul 23 01:27:53 localhost kernel:   #0: C-Media PCI CMI8738-MC6 (model 55) at 0xd400, irq 11
Jul 23 01:27:53 localhost kernel: oprofile: using timer interrupt.
Jul 23 01:27:53 localhost kernel: NET: Registered protocol family 2
Jul 23 01:27:53 localhost kernel: IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
Jul 23 01:27:53 localhost kernel: TCP established hash table entries: 16384 (order: 5, 131072 bytes)
Jul 23 01:27:53 localhost kernel: TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
Jul 23 01:27:53 localhost kernel: TCP: Hash tables configured (established 16384 bind 16384)
Jul 23 01:27:53 localhost kernel: TCP reno registered
Jul 23 01:27:53 localhost kernel: ip_conntrack version 2.1 (2047 buckets, 16376 max) - 248 bytes per conntrack
Jul 23 01:27:53 localhost kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul 23 01:27:53 localhost kernel: usb 3-1: new low speed USB device using uhci_hcd and address 2
Jul 23 01:27:53 localhost kernel: ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Jul 23 01:27:53 localhost kernel: arp_tables: (C) 2002 David S. Miller
Jul 23 01:27:53 localhost kernel: TCP bic registered
Jul 23 01:27:53 localhost kernel: NET: Registered protocol family 1
Jul 23 01:27:53 localhost kernel: NET: Registered protocol family 17
Jul 23 01:27:53 localhost kernel: Using IPI Shortcut mode
Jul 23 01:27:53 localhost kernel: ACPI wakeup devices:
Jul 23 01:27:53 localhost kernel: PCI0 USB0 USB1 USB2 USB6 USB7 USB8 USB9 UAR1 ECP1
Jul 23 01:27:53 localhost kernel: ACPI: (supports S0 S1 S3 S4 S5)
Jul 23 01:27:53 localhost kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Jul 23 01:27:53 localhost kernel: EXT3-fs: write access will be enabled during recovery.
Jul 23 01:27:53 localhost kernel: EXT3-fs: hdb1: orphan cleanup on readonly fs
Jul 23 01:27:53 localhost kernel: EXT3-fs: hdb1: 3 orphan inodes deleted
Jul 23 01:27:53 localhost kernel: EXT3-fs: recovery complete.
Jul 23 01:27:53 localhost kernel: kjournald starting.  Commit interval 5 secondsJul 23 01:27:53 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 23 01:27:53 localhost kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jul 23 01:27:53 localhost kernel: Freeing unused kernel memory: 164k freed
Jul 23 01:27:53 localhost kernel: Adding 666656k swap on /dev/hdb5.  Priority:-1 extents:1 across:666656k
Jul 23 01:27:53 localhost kernel: EXT3 FS on hdb1, internal journal
Jul 23 01:27:53 localhost kernel: ati_remote 3-1:1.0: Input registered: X10 Wireless Technology Inc USB Receiver on usb-0000:00:10.1-1
Jul 23 01:27:53 localhost kernel: usbcore: registered new driver ati_remote
Jul 23 01:27:53 localhost kernel: drivers/usb/input/ati_remote.c: Registered USB driver ATI/X10 RF USB Remote Control v. 2.2.1
Jul 23 01:27:53 localhost kernel: drivers/usb/input/ati_remote.c: Weird data, len=1 ff 00 00 00 00 00 ...
Jul 23 01:27:53 localhost kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Jul 23 01:30:11 localhost kernel: hdf: dma_timer_expiry: dma status == 0x41
Jul 23 01:30:21 localhost kernel: hdf: DMA timeout error
Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: status=0x25 { DeviceFault CorrectedError Error }
Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: error=0x25 { DriveStatusError AddrMarkNotFound }, LBAsect=8830589412645, high=526344, low=2434341, sector=390715711
Jul 23 01:30:21 localhost kernel: ide: failed opcode was: unknown
Jul 23 01:30:21 localhost kernel: hdf: DMA disabled
Jul 23 01:30:21 localhost kernel: ide2: reset: master: error (0x0a?)
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715711
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715712
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715713
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715714
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715715
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715716
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715717
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715718
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715711
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715712
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715713
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715714
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715715
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715716
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715717
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 390715718
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 79
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 80
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 81
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 82
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 83
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 84
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 85
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 86
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 79
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 80
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 81
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 82
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 83
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 84
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 85
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 86
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 191
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 192
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 193
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 194
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 195
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 196
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 197
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 198
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 191
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 192
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 193
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 194
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 195
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 196
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 197
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 198
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 191
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 192
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 193
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 194
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 195
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 196
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 197
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 198
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 191
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 192
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 193
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 194
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 195
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 196
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 197
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 198
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 79
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 80
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 81
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 82
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 83
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 84
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 85
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 86
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 63
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 64
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 65
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 66
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 67
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 68
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 69
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 70
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 127
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 128
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 129
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 130
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 131
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 132
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 133
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 134
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 127
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 128
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 129
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 130
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 131
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 132
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 133
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 134
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 127
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 128
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 129
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 130
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 131
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 132
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 133
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 134
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 127
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 128
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 129
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 130
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 131
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 132
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 133
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 134
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 127
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 128
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 129
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 130
Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf, sector 131


------=_Part_3025_20485640.1122085694907
Content-Type: application/octet-stream; name=config.2.6.13-rc3-mm1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config.2.6.13-rc3-mm1"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.13-rc3-mm1
# Fri Jul 22 06:51:32 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set

#
# Class Based Kernel Resource Management
#
# CONFIG_CKRM is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
# CONFIG_IKCONFIG_PROC is not set
# CONFIG_EMBEDDED is not set
# CONFIG_DELAY_ACCT is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_IBM=m
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=2001
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
CONFIG_ACPI_CONTAINER=m

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=m
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_CT_PROTO_SCTP=m
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_SCTP=m
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_MATCH_CONNMARK=m
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
# CONFIG_IP_NF_TARGET_CONNMARK is not set
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
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
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
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
CONFIG_FW_LOADER=m

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=y
CONFIG_EXIT_CONNECTOR=y
CONFIG_FORK_CONNECTOR=y

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
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
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
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
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
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=m

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_3W_9XXX=m
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_ITERAID is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
CONFIG_SCSI_DPT_I2O=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_ATA_ADMA is not set
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
CONFIG_SCSI_SATA_NV=m
# CONFIG_SCSI_SATA_PROMISE is not set
CONFIG_SCSI_SATA_QSTOR=m
CONFIG_SCSI_SATA_SX4=m
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set

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
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

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
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
CONFIG_VIA_VELOCITY=m
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

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
# CONFIG_NETCONSOLE is not set

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

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
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
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_I830=m
CONFIG_DRM_I915=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
# CONFIG_I2C is not set
# CONFIG_I2C_SENSOR is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
CONFIG_SPEAKUP_DEFAULT="none"

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_CMIPCI=y
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
CONFIG_SND_USB_USX2Y=m

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
CONFIG_USB_ATI_REMOTE=m
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

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
CONFIG_USB_PHIDGETSERVO=m
# CONFIG_USB_IDMOUSE is not set
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
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISER4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_CACHEFS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set
# CONFIG_RELAYFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ASFS_FS is not set
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
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=y
CONFIG_CIFS_STATS=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_EXPERIMENTAL=y
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
CONFIG_NLS_DEFAULT="iso8859-1"
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
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
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
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=y

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_EARLY_PRINTK=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=y

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

------=_Part_3025_20485640.1122085694907
Content-Type: text/plain; name="pci.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pci.txt"

UENJIGRldmljZXMgZm91bmQ6DQogIEJ1cyAgMCwgZGV2aWNlICAgMCwgZnVuY3Rpb24gIDA6DQog
ICAgSG9zdCBicmlkZ2U6IFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVlQ4Mzc1IFtLTTI2Ni9LTDI2
Nl0gSG9zdCBCcmlkZ2UgKHJldiAwKS4NCiAgICAgIE1hc3RlciBDYXBhYmxlLiAgTGF0ZW5jeT04
LiAgDQogICAgICBQcmVmZXRjaGFibGUgMzIgYml0IG1lbW9yeSBhdCAweGUwMDAwMDAwIFsweGUz
ZmZmZmZmXS4NCiAgQnVzICAwLCBkZXZpY2UgICAxLCBmdW5jdGlvbiAgMDoNCiAgICBQQ0kgYnJp
ZGdlOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIFZUODYzMyBbQXBvbGxvIFBybzI2NiBBR1BdIChy
ZXYgMCkuDQogICAgICBNYXN0ZXIgQ2FwYWJsZS4gIE5vIGJ1cnN0cy4gIE1pbiBHbnQ9MTIuDQog
IEJ1cyAgMCwgZGV2aWNlICAgOCwgZnVuY3Rpb24gIDA6DQogICAgVW5rbm93biBtYXNzIHN0b3Jh
Z2UgY29udHJvbGxlcjogVHJpb25lcyBUZWNobm9sb2dpZXMsIEluYy4gSFBUMzY2LzM2OC8zNzAv
MzcwQS8zNzIvMzcyTiAocmV2IDQpLg0KICAgICAgSVJRIDExLg0KICAgICAgTWFzdGVyIENhcGFi
bGUuICBMYXRlbmN5PTEyMC4gIE1pbiBHbnQ9OC5NYXggTGF0PTguDQogICAgICBJL08gYXQgMHhj
MDAwIFsweGMwMDddLg0KICAgICAgSS9PIGF0IDB4YzQwMCBbMHhjNDAzXS4NCiAgICAgIEkvTyBh
dCAweGM4MDAgWzB4YzgwN10uDQogICAgICBJL08gYXQgMHhjYzAwIFsweGNjMDNdLg0KICAgICAg
SS9PIGF0IDB4ZDAwMCBbMHhkMGZmXS4NCiAgQnVzICAwLCBkZXZpY2UgICA5LCBmdW5jdGlvbiAg
MDoNCiAgICBNdWx0aW1lZGlhIGF1ZGlvIGNvbnRyb2xsZXI6IEMtTWVkaWEgRWxlY3Ryb25pY3Mg
SW5jIENNODczOCAocmV2IDE2KS4NCiAgICAgIElSUSAxMS4NCiAgICAgIE1hc3RlciBDYXBhYmxl
LiAgTGF0ZW5jeT0zMi4gIE1pbiBHbnQ9Mi5NYXggTGF0PTI0Lg0KICAgICAgSS9PIGF0IDB4ZDQw
MCBbMHhkNGZmXS4NCiAgQnVzICAwLCBkZXZpY2UgIDExLCBmdW5jdGlvbiAgMDoNCiAgICBFdGhl
cm5ldCBjb250cm9sbGVyOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBMdGQuIFJUTC04MTM5
LzgxMzlDLzgxMzlDKyAocmV2IDE2KS4NCiAgICAgIElSUSAxMC4NCiAgICAgIE1hc3RlciBDYXBh
YmxlLiAgTGF0ZW5jeT0zMi4gIE1pbiBHbnQ9MzIuTWF4IExhdD02NC4NCiAgICAgIEkvTyBhdCAw
eGQ4MDAgWzB4ZDhmZl0uDQogICAgICBOb24tcHJlZmV0Y2hhYmxlIDMyIGJpdCBtZW1vcnkgYXQg
MHhlNzAwMDAwMCBbMHhlNzAwMDBmZl0uDQogIEJ1cyAgMCwgZGV2aWNlICAxNiwgZnVuY3Rpb24g
IDA6DQogICAgVVNCIENvbnRyb2xsZXI6IFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVlQ4Mnh4eHh4
IFVIQ0kgVVNCIDEuMSBDb250cm9sbGVyIChyZXYgMTI4KS4NCiAgICAgIElSUSAxMS4NCiAgICAg
IE1hc3RlciBDYXBhYmxlLiAgTGF0ZW5jeT0zMi4gIA0KICAgICAgSS9PIGF0IDB4ZGMwMCBbMHhk
YzFmXS4NCiAgQnVzICAwLCBkZXZpY2UgIDE2LCBmdW5jdGlvbiAgMToNCiAgICBVU0IgQ29udHJv
bGxlcjogVklBIFRlY2hub2xvZ2llcywgSW5jLiBWVDgyeHh4eHggVUhDSSBVU0IgMS4xIENvbnRy
b2xsZXIgKCMyKSAocmV2IDEyOCkuDQogICAgICBJUlEgMTEuDQogICAgICBNYXN0ZXIgQ2FwYWJs
ZS4gIExhdGVuY3k9MzIuICANCiAgICAgIEkvTyBhdCAweGUwMDAgWzB4ZTAxZl0uDQogIEJ1cyAg
MCwgZGV2aWNlICAxNiwgZnVuY3Rpb24gIDI6DQogICAgVVNCIENvbnRyb2xsZXI6IFZJQSBUZWNo
bm9sb2dpZXMsIEluYy4gVlQ4Mnh4eHh4IFVIQ0kgVVNCIDEuMSBDb250cm9sbGVyICgjMykgKHJl
diAxMjgpLg0KICAgICAgSVJRIDEwLg0KICAgICAgTWFzdGVyIENhcGFibGUuICBMYXRlbmN5PTMy
LiAgDQogICAgICBJL08gYXQgMHhlNDAwIFsweGU0MWZdLg0KICBCdXMgIDAsIGRldmljZSAgMTYs
IGZ1bmN0aW9uICAzOg0KICAgIFVTQiBDb250cm9sbGVyOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMu
IFVTQiAyLjAgKHJldiAxMzApLg0KICAgICAgSVJRIDMuDQogICAgICBNYXN0ZXIgQ2FwYWJsZS4g
IExhdGVuY3k9MzIuICANCiAgICAgIE5vbi1wcmVmZXRjaGFibGUgMzIgYml0IG1lbW9yeSBhdCAw
eGU3MDAxMDAwIFsweGU3MDAxMGZmXS4NCiAgQnVzICAwLCBkZXZpY2UgIDE3LCBmdW5jdGlvbiAg
MDoNCiAgICBJU0EgYnJpZGdlOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIFZUODIzNSBJU0EgQnJp
ZGdlIChyZXYgMCkuDQogIEJ1cyAgMCwgZGV2aWNlICAxNywgZnVuY3Rpb24gIDE6DQogICAgSURF
IGludGVyZmFjZTogVklBIFRlY2hub2xvZ2llcywgSW5jLiBWVDgyQzU4NkEvQi9WVDgyQzY4Ni9B
L0IvVlQ4MjN4L0EvQyBQSVBDIEJ1cyBNYXN0ZXIgSURFIChyZXYgNikuDQogICAgICBJUlEgMTEu
DQogICAgICBNYXN0ZXIgQ2FwYWJsZS4gIExhdGVuY3k9MzIuICANCiAgICAgIEkvTyBhdCAweGU4
MDAgWzB4ZTgwZl0uDQogIEJ1cyAgMSwgZGV2aWNlICAgMCwgZnVuY3Rpb24gIDA6DQogICAgVkdB
IGNvbXBhdGlibGUgY29udHJvbGxlcjogblZpZGlhIENvcnBvcmF0aW9uIE5WMTcgW0dlRm9yY2U0
IE1YIDQ0MF0gKHJldiAxNjMpLg0KICAgICAgSVJRIDExLg0KICAgICAgTWFzdGVyIENhcGFibGUu
ICBMYXRlbmN5PTMyLiAgTWluIEdudD01Lk1heCBMYXQ9MS4NCiAgICAgIE5vbi1wcmVmZXRjaGFi
bGUgMzIgYml0IG1lbW9yeSBhdCAweGU0MDAwMDAwIFsweGU0ZmZmZmZmXS4NCiAgICAgIFByZWZl
dGNoYWJsZSAzMiBiaXQgbWVtb3J5IGF0IDB4ZDAwMDAwMDAgWzB4ZDdmZmZmZmZdLg0KICAgICAg
UHJlZmV0Y2hhYmxlIDMyIGJpdCBtZW1vcnkgYXQgMHhkODAwMDAwMCBbMHhkODA3ZmZmZl0uDQo=

------=_Part_3025_20485640.1122085694907
Content-Type: text/plain; name="interrupts.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="interrupts.txt"

ICAgICAgICAgICBDUFUwICAgICAgIA0KICAwOiAgICAgNjk2NzI4ICAgICAgICAgIFhULVBJQyAg
dGltZXINCiAgMTogICAgICAgMjk3OSAgICAgICAgICBYVC1QSUMgIGk4MDQyDQogIDI6ICAgICAg
ICAgIDAgICAgICAgICAgWFQtUElDICBjYXNjYWRlDQogIDM6ICAgICAgICAgIDIgICAgICAgICAg
WFQtUElDICBlaGNpX2hjZDp1c2IxDQogIDk6ICAgICAgICAgIDAgICAgICAgICAgWFQtUElDICBh
Y3BpDQogMTA6ICAgICAgICA3MDcgICAgICAgICAgWFQtUElDICB1aGNpX2hjZDp1c2I0LCBldGgw
DQogMTE6ICAgICAgICAgNDggICAgICAgICAgWFQtUElDICBpZGUyLCB1aGNpX2hjZDp1c2IyLCB1
aGNpX2hjZDp1c2IzLCBDTUk4NzM4LU1DNg0KIDEyOiAgICAgIDM0NDU0ICAgICAgICAgIFhULVBJ
QyAgaTgwNDINCiAxNDogICAgICAxMjExOSAgICAgICAgICBYVC1QSUMgIGlkZTANCk5NSTogICAg
ICAgICAgMCANCkVSUjogICAgICAgICAgMA0K
------=_Part_3025_20485640.1122085694907--
