Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVFQLbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVFQLbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 07:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVFQLbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 07:31:32 -0400
Received: from osten.wh.uni-dortmund.de ([129.217.129.130]:64424 "EHLO
	osten.wh.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261932AbVFQL3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 07:29:16 -0400
Message-ID: <42B2B409.9050405@web.de>
Date: Fri, 17 Jun 2005 13:29:13 +0200
From: Alexander Fieroch <fieroch@web.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Andrew Morton <akpm@osdl.org>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@suse.de,
       B.Zolnierkiewicz@elka.pw.edu.pl, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:  
 nobody cared!"
References: <d6gf8j$jnb$1@sea.gmane.org>	<20050527171613.5f949683.akpm@osdl.org>	<429A2397.6090609@web.de>	<58cb370e05061401041a67cfa7@mail.gmail.com>	<42B091EE.4020802@web.de> <20050615143039.24132251.akpm@osdl.org>
In-Reply-To: <20050615143039.24132251.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070401020200000404010700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070401020200000404010700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> I had a driver from ITE in the -mm tree for a while.  It still seems to
> apply and I think it fixes the compile warnings which you saw:
> 
> 
> 	http://www.zip.com.au/~akpm/linux/patches/stuff/iteraid.patch

Yes, it fixes the compile warnings but I still get the errors this
thread is about.

I've attached the complete /var/log/syslog with kernel 2.6.12rc6-mm1 as
syslog2612rc6-mm1 and the syslog tested with kernel 2.6.12rc6-git8 +
iteraid.patch cut to only relevant lines as file syslog2612rc6git8iteraid.
The kernel still hangs for a while with "kernel: hda: lost interrupt"
and throws the above error messages.

Regards,
Alexander


--------------070401020200000404010700
Content-Type: text/plain;
 name="syslog2612rc6-mm1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="syslog2612rc6-mm1"

Jun 17 09:53:02 orclex syslog-ng[4140]: syslog-ng version 1.6.7 starting
Jun 17 09:53:02 orclex syslog-ng[4140]: Changing permissions on special file /dev/xconsole
Jun 17 09:53:02 orclex syslog-ng[4140]: Cannot open file /dev/xconsole for writing (No such file or directory)
Jun 17 09:53:02 orclex kernel: Bootdata ok (command line is root=/dev/sda3 vga=792)
Jun 17 09:53:02 orclex kernel: Linux version 2.6.12-rc6-mm1 (root@orclex) (gcc version 3.3.6 (Debian 1:3.3.6-5)) #1 SMP Thu Jun 16 18:10:08 CEST 2005
Jun 17 09:53:02 orclex kernel: BIOS-provided physical RAM map:
Jun 17 09:53:02 orclex kernel: BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jun 17 09:53:02 orclex kernel: BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jun 17 09:53:02 orclex kernel: BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Jun 17 09:53:02 orclex kernel: BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
Jun 17 09:53:02 orclex kernel: BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
Jun 17 09:53:02 orclex kernel: BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
Jun 17 09:53:02 orclex kernel: BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
Jun 17 09:53:02 orclex kernel: BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Jun 17 09:53:02 orclex kernel: ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fb070
Jun 17 09:53:02 orclex kernel: ACPI: XSDT (v001 A M I  OEMXSDT  0x03000521 MSFT 0x00000097) @ 0x000000003ffb0100
Jun 17 09:53:02 orclex kernel: ACPI: FADT (v003 A M I  OEMFACP  0x03000521 MSFT 0x00000097) @ 0x000000003ffb0290
Jun 17 09:53:02 orclex kernel: ACPI: MADT (v001 A M I  OEMAPIC  0x03000521 MSFT 0x00000097) @ 0x000000003ffb0390
Jun 17 09:53:02 orclex kernel: ACPI: OEMB (v001 A M I  AMI_OEM  0x03000521 MSFT 0x00000097) @ 0x000000003ffbe040
Jun 17 09:53:02 orclex kernel: ACPI: MCFG (v001 A M I  OEMMCFG  0x03000521 MSFT 0x00000097) @ 0x000000003ffb6c60
Jun 17 09:53:02 orclex kernel: ACPI: DSDT (v001  A0086 A0086003 0x00000003 INTL 0x02002026) @ 0x0000000000000000
Jun 17 09:53:02 orclex kernel: On node 0 totalpages: 262064
Jun 17 09:53:02 orclex kernel: DMA zone: 4096 pages, LIFO batch:1
Jun 17 09:53:02 orclex kernel: Normal zone: 257968 pages, LIFO batch:31
Jun 17 09:53:02 orclex kernel: HighMem zone: 0 pages, LIFO batch:1
Jun 17 09:53:02 orclex kernel: ACPI: PM-Timer IO Port: 0x808
Jun 17 09:53:02 orclex kernel: ACPI: Local APIC address 0xfee00000
Jun 17 09:53:02 orclex kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Jun 17 09:53:02 orclex kernel: Processor #0 15:4 APIC version 16
Jun 17 09:53:02 orclex kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Jun 17 09:53:02 orclex kernel: Processor #1 15:4 APIC version 16
Jun 17 09:53:02 orclex kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jun 17 09:53:02 orclex kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Jun 17 09:53:02 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jun 17 09:53:02 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jun 17 09:53:02 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jun 17 09:53:02 orclex udev[4142]: removing device node '/dev/vcsa1'
Jun 17 09:53:02 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jun 17 09:53:02 orclex kernel: ACPI: IRQ0 used by override.
Jun 17 09:53:02 orclex kernel: ACPI: IRQ2 used by override.
Jun 17 09:53:02 orclex kernel: ACPI: IRQ9 used by override.
Jun 17 09:53:02 orclex kernel: Setting APIC routing to flat
Jun 17 09:53:02 orclex kernel: Using ACPI (MADT) for SMP configuration information
Jun 17 09:53:02 orclex kernel: Allocating PCI resources starting at 40000000 (gap: 40000000:bfb00000)
Jun 17 09:53:02 orclex kernel: Built 1 zonelists
Jun 17 09:53:02 orclex kernel: Initializing CPU#0
Jun 17 09:53:02 orclex kernel: Kernel command line: root=/dev/sda3 vga=792
Jun 17 09:53:02 orclex kernel: PID hash table entries: 4096 (order: 12, 131072 bytes)
Jun 17 09:53:02 orclex kernel: time.c: Using 3.579545 MHz PM timer.
Jun 17 09:53:02 orclex kernel: time.c: Detected 3010.829 MHz processor.
Jun 17 09:53:02 orclex kernel: Console: colour dummy device 80x25
Jun 17 09:53:02 orclex kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jun 17 09:53:02 orclex kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Jun 17 09:53:02 orclex kernel: Memory: 1023664k/1048256k available (3372k kernel code, 23900k reserved, 1806k data, 240k init)
Jun 17 09:53:02 orclex kernel: Calibrating delay using timer specific routine.. 6030.81 BogoMIPS (lpj=12061637)
Jun 17 09:53:02 orclex kernel: Security Framework v1.0.0 initialized
Jun 17 09:53:02 orclex kernel: Capability LSM initialized
Jun 17 09:53:02 orclex kernel: Mount-cache hash table entries: 256
Jun 17 09:53:02 orclex kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jun 17 09:53:02 orclex kernel: CPU: L2 cache: 2048K
Jun 17 09:53:02 orclex kernel: using mwait in idle threads.
Jun 17 09:53:02 orclex kernel: CPU: Physical Processor ID: 0
Jun 17 09:53:02 orclex kernel: CPU0: Thermal monitoring enabled (TM1)
Jun 17 09:53:02 orclex kernel: Using local APIC timer interrupts.
Jun 17 09:53:02 orclex kernel: Detected 12.545 MHz APIC timer.
Jun 17 09:53:02 orclex kernel: Booting processor 1/1 rip 6000 rsp ffff810002191f58
Jun 17 09:53:02 orclex kernel: Initializing CPU#1
Jun 17 09:53:02 orclex kernel: Calibrating delay using timer specific routine.. 6021.34 BogoMIPS (lpj=12042680)
Jun 17 09:53:02 orclex kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jun 17 09:53:02 orclex kernel: CPU: L2 cache: 2048K
Jun 17 09:53:02 orclex kernel: CPU: Physical Processor ID: 0
Jun 17 09:53:02 orclex kernel: CPU1: Thermal monitoring enabled (TM1)
Jun 17 09:53:02 orclex kernel: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Jun 17 09:53:02 orclex kernel: APIC error on CPU1: 00(40)
Jun 17 09:53:02 orclex kernel: CPU 1: Syncing TSC to CPU 0.
Jun 17 09:53:02 orclex kernel: Brought up 2 CPUs
Jun 17 09:53:02 orclex kernel: CPU 1: synchronized TSC with CPU 0 (last diff -134 cycles, maxerr 930 cycles)
Jun 17 09:53:02 orclex kernel: time.c: Using PIT/TSC based timekeeping.
Jun 17 09:53:02 orclex kernel: testing NMI watchdog ... CPU#1: NMI appears to be stuck (1->1)!
Jun 17 09:53:02 orclex kernel: NET: Registered protocol family 16
Jun 17 09:53:02 orclex kernel: PCI: Using configuration type 1
Jun 17 09:53:02 orclex kernel: PCI: Using MMCONFIG at e0000000
Jun 17 09:53:02 orclex udev[4150]: creating device node '/dev/vcsa1'
Jun 17 09:53:02 orclex kernel: mtrr: v2.0 (20020519)
Jun 17 09:53:02 orclex kernel: ACPI: Subsystem revision 20050309
Jun 17 09:53:02 orclex kernel: ACPI: Interpreter enabled
Jun 17 09:53:02 orclex kernel: ACPI: Using IOAPIC for interrupt routing
Jun 17 09:53:02 orclex kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jun 17 09:53:02 orclex kernel: PCI: Probing PCI hardware (bus 00)
Jun 17 09:53:02 orclex kernel: Boot video device is 0000:04:00.0
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 *15)
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 *14 15)
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jun 17 09:53:02 orclex kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jun 17 09:53:02 orclex kernel: pnp: PnP ACPI init
Jun 17 09:53:02 orclex kernel: pnp: PnP ACPI: found 19 devices
Jun 17 09:53:02 orclex kernel: SCSI subsystem initialized
Jun 17 09:53:02 orclex kernel: usbcore: registered new driver usbfs
Jun 17 09:53:02 orclex kernel: usbcore: registered new driver hub
Jun 17 09:53:02 orclex kernel: PCI: Using ACPI for IRQ routing
Jun 17 09:53:02 orclex kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jun 17 09:53:02 orclex kernel: TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
Jun 17 09:53:02 orclex kernel: pnp: 00:07: ioport range 0x290-0x297 has been reserved
Jun 17 09:53:02 orclex kernel: pnp: 00:09: ioport range 0x3f6-0x3f6 has been reserved
Jun 17 09:53:02 orclex kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Jun 17 09:53:02 orclex kernel: IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Jun 17 09:53:02 orclex kernel: inotify device minor=63
Jun 17 09:53:02 orclex kernel: NTFS driver 2.1.23-WIP [Flags: R/O].
Jun 17 09:53:02 orclex kernel: Initializing Cryptographic API
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 17 09:53:02 orclex kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Jun 17 09:53:02 orclex kernel: assign_interrupt_mode Found MSI capability
Jun 17 09:53:02 orclex kernel: Allocate Port Service[pcie00]
Jun 17 09:53:02 orclex kernel: Allocate Port Service[pcie03]
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 17 09:53:02 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Jun 17 09:53:02 orclex kernel: assign_interrupt_mode Found MSI capability
Jun 17 09:53:02 orclex kernel: Allocate Port Service[pcie00]
Jun 17 09:53:02 orclex kernel: Allocate Port Service[pcie02]
Jun 17 09:53:02 orclex kernel: Allocate Port Service[pcie03]
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 201
Jun 17 09:53:02 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.1 to 64
Jun 17 09:53:02 orclex kernel: assign_interrupt_mode Found MSI capability
Jun 17 09:53:02 orclex kernel: Allocate Port Service[pcie00]
Jun 17 09:53:02 orclex kernel: Allocate Port Service[pcie02]
Jun 17 09:53:02 orclex kernel: Allocate Port Service[pcie03]
Jun 17 09:53:02 orclex kernel: vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20010100000, using 6144k, total 131072k
Jun 17 09:53:02 orclex kernel: vesafb: mode is 1024x768x32, linelength=4096, pages=1
Jun 17 09:53:02 orclex kernel: vesafb: scrolling: redraw
Jun 17 09:53:02 orclex kernel: vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Jun 17 09:53:02 orclex kernel: Console: switching to colour frame buffer device 128x48
Jun 17 09:53:02 orclex kernel: fb0: VESA VGA frame buffer device
Jun 17 09:53:02 orclex kernel: vga16fb: initializing
Jun 17 09:53:02 orclex kernel: vga16fb: mapped to 0xffff8100000a0000
Jun 17 09:53:02 orclex kernel: fb1: VGA16 VGA frame buffer device
Jun 17 09:53:02 orclex kernel: ACPI: Power Button (FF) [PWRF]
Jun 17 09:53:02 orclex kernel: ACPI: Processor [CPU1] (supports 8 throttling states)
Jun 17 09:53:02 orclex kernel: Real Time Clock Driver v1.12
Jun 17 09:53:02 orclex kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jun 17 09:53:02 orclex kernel: [drm] Initialized drm 1.0.0 20040925
Jun 17 09:53:02 orclex kernel: Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Jun 17 09:53:02 orclex kernel: Hangcheck: Using monotonic_clock().
Jun 17 09:53:02 orclex kernel: cn_fork is registered
Jun 17 09:53:02 orclex kernel: PNP: PS/2 controller doesn't have AUX irq; using default 0xc
Jun 17 09:53:02 orclex kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1,12
Jun 17 09:53:02 orclex kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 17 09:53:02 orclex kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 17 09:53:02 orclex kernel: io scheduler noop registered
Jun 17 09:53:02 orclex kernel: io scheduler anticipatory registered
Jun 17 09:53:02 orclex kernel: io scheduler deadline registered
Jun 17 09:53:02 orclex kernel: io scheduler cfq registered
Jun 17 09:53:02 orclex kernel: Floppy drive(s): fd0 is 1.44M
Jun 17 09:53:02 orclex kernel: FDC 0 is a post-1991 82077
Jun 17 09:53:02 orclex kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Jun 17 09:53:02 orclex kernel: loop: loaded (max 8 devices)
Jun 17 09:53:02 orclex kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 17 09:53:02 orclex kernel: eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
Jun 17 09:53:02 orclex kernel: PrefPort:A  RlmtMode:Check Link State
Jun 17 09:53:02 orclex kernel: PPP generic driver version 2.4.2
Jun 17 09:53:02 orclex kernel: PPP Deflate Compression module registered
Jun 17 09:53:02 orclex kernel: NET: Registered protocol family 24
Jun 17 09:53:02 orclex kernel: dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
Jun 17 09:53:02 orclex kernel: Linux video capture interface: v1.00
Jun 17 09:53:02 orclex kernel: bttv: driver version 0.9.15 loaded
Jun 17 09:53:02 orclex kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Jun 17 09:53:02 orclex kernel: bttv: Bt8xx card found (0).
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:01:09.0[A] -> GSI 17 (level, low) -> IRQ 201
Jun 17 09:53:02 orclex kernel: bttv0: Bt878 (rev 2) at 0000:01:09.0, irq: 201, latency: 64, mmio: 0xd7ffe000
Jun 17 09:53:02 orclex kernel: bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
Jun 17 09:53:02 orclex kernel: bttv0: using: Hauppauge (bt878) [card=10,autodetected]
Jun 17 09:53:02 orclex kernel: bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
Jun 17 09:53:02 orclex kernel: bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
Jun 17 09:53:02 orclex kernel: tveeprom: Hauppauge: model = 61334, rev = B   , serial# = 3026517
Jun 17 09:53:02 orclex kernel: tveeprom: tuner = Philips FM1216 (idx = 21, type = 5)
Jun 17 09:53:02 orclex kernel: tveeprom: tuner fmt = PAL(B/G) (eeprom = 0x04, v4l2 = 0x00000007)
Jun 17 09:53:02 orclex kernel: tveeprom: audio_processor = MSP3415 (type = 6)
Jun 17 09:53:02 orclex kernel: bttv0: using tuner=5
Jun 17 09:53:02 orclex kernel: bttv0: registered device video0
Jun 17 09:53:02 orclex kernel: bttv0: registered device vbi0
Jun 17 09:53:02 orclex kernel: bttv0: registered device radio0
Jun 17 09:53:02 orclex kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Jun 17 09:53:02 orclex kernel: msp34xx: init: chip=MSP3410D-B4 +nicam +simple mode=simple
Jun 17 09:53:02 orclex kernel: msp3410: daemon started
Jun 17 09:53:02 orclex kernel: tvaudio: TV audio decoder + audio/video mux driver
Jun 17 09:53:02 orclex kernel: tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 (PV951),ta8874z
Jun 17 09:53:02 orclex kernel: SAA5246A (or compatible) Teletext decoder driver version 1.8
Jun 17 09:53:02 orclex kernel: SAA5249 driver (SAA5249 interface) for VideoText version 1.8
Jun 17 09:53:02 orclex kernel: tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
Jun 17 09:53:02 orclex kernel: tuner 0-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
Jun 17 09:53:02 orclex kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jun 17 09:53:02 orclex kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun 17 09:53:02 orclex kernel: ICH6: IDE controller at PCI slot 0000:00:1f.1
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 217
Jun 17 09:53:02 orclex kernel: ICH6: chipset revision 3
Jun 17 09:53:02 orclex kernel: ICH6: 100% native mode on irq 217
Jun 17 09:53:02 orclex kernel: ide0: BM-DMA at 0x5800-0x5807, BIOS settings: hda:DMA, hdb:DMA
Jun 17 09:53:02 orclex kernel: ide1: BM-DMA at 0x5808-0x580f, BIOS settings: hdc:pio, hdd:pio
Jun 17 09:53:02 orclex kernel: Probing IDE interface ide0...
Jun 17 09:53:02 orclex kernel: hda: IC35L060AVV207-0, ATA DISK drive
Jun 17 09:53:02 orclex kernel: hdb: SONY CD-RW CRX210E1, ATAPI CD/DVD-ROM drive
Jun 17 09:53:02 orclex kernel: ide0 at 0x7000-0x7007,0x6802 on irq 217
Jun 17 09:53:02 orclex kernel: Probing IDE interface ide1...
Jun 17 09:53:02 orclex kernel: Probing IDE interface ide1...
Jun 17 09:53:02 orclex kernel: Probing IDE interface ide2...
Jun 17 09:53:02 orclex kernel: Probing IDE interface ide3...
Jun 17 09:53:02 orclex kernel: Probing IDE interface ide4...
Jun 17 09:53:02 orclex kernel: Probing IDE interface ide5...
Jun 17 09:53:02 orclex kernel: hda: max request size: 1024KiB
Jun 17 09:53:02 orclex kernel: hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
Jun 17 09:53:02 orclex kernel: hda: cache flushes supported
Jun 17 09:53:02 orclex kernel: hda: hda1 hda2
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: Uniform CD-ROM driver Revision: 3.20
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 23 (level, low) -> IRQ 225
Jun 17 09:53:02 orclex kernel: Found Controller: IT8212 UDMA/ATA133 RAID Controller
Jun 17 09:53:02 orclex kernel: irq 217: nobody cared (try booting with the "irqpoll" option.
Jun 17 09:53:02 orclex kernel: 
Jun 17 09:53:02 orclex kernel: Call Trace: <IRQ> <ffffffff80154eef>{__report_bad_irq+48} <ffffffff80154fe8>{note_interrupt+144}
Jun 17 09:53:02 orclex kernel: <ffffffff801547ff>{__do_IRQ+237} <ffffffff80110591>{do_IRQ+67}
Jun 17 09:53:02 orclex kernel: <ffffffff8010df0d>{ret_from_intr+0}  <EOI> <ffffffff8023ee7d>{__delay+8}
Jun 17 09:53:02 orclex kernel: <ffffffff8032dccb>{iteraid_find_device+148} <ffffffff8032e0a9>{iteraid_init+457}
Jun 17 09:53:02 orclex kernel: <ffffffff8032e17f>{iteraid_detect+173} <ffffffff806c414a>{init_this_scsi_driver+94}
Jun 17 09:53:02 orclex kernel: <ffffffff806a88e1>{do_initcalls+102} <ffffffff8010b114>{init+190}
Jun 17 09:53:02 orclex kernel: <ffffffff8010e51f>{child_rip+8} <ffffffff8010b056>{init+0}
Jun 17 09:53:02 orclex kernel: <ffffffff8010e517>{child_rip+0} 
Jun 17 09:53:02 orclex kernel: handlers:
Jun 17 09:53:02 orclex kernel: [<ffffffff80311b75>] (ide_intr+0x0/0x17a)
Jun 17 09:53:02 orclex kernel: Disabling IRQ #217
Jun 17 09:53:02 orclex kernel: IssueIdentify: resetting channel.
Jun 17 09:53:02 orclex kernel: IssueIdentify(IDE): disk[0] not ready. status=0x20
Jun 17 09:53:02 orclex kernel: FindDevices: device 0 is not present
Jun 17 09:53:02 orclex kernel: iteraid_find_device: channel 0 device 1 is ATAPI.
Jun 17 09:53:02 orclex kernel: Channel[0] BM-DMA at 0x9800-0x9807
Jun 17 09:53:02 orclex kernel: IssueIdentify: resetting channel.
Jun 17 09:53:02 orclex kernel: IssueIdentify(IDE): disk[0] not ready. status=0x20
Jun 17 09:53:02 orclex kernel: FindDevices: device 2 is not present
Jun 17 09:53:02 orclex kernel: IssueIdentify: resetting channel.
Jun 17 09:53:02 orclex kernel: IssueIdentify(IDE): disk[1] not ready. status=0x30
Jun 17 09:53:02 orclex kernel: FindDevices: device 3 is not present
Jun 17 09:53:02 orclex kernel: Channel[1] BM-DMA at 0x9808-0x980F
Jun 17 09:53:02 orclex kernel: scsi0 : ITE RAIDExpress133
Jun 17 09:53:02 orclex kernel: AtapiInterrupt: 23 words requested; 24 words xferred
Jun 17 09:53:02 orclex kernel: AtapiInterrupt error
Jun 17 09:53:02 orclex kernel: MapError: error register is b0
Jun 17 09:53:02 orclex kernel: ATAPI: command Aborted
Jun 17 09:53:02 orclex kernel: AtapiInterrupt: 32 words requested; 9 words xferred
Jun 17 09:53:02 orclex kernel: AtapiResetController enter
Jun 17 09:53:02 orclex kernel: IT8212ResetAdapter: perform ATAPI soft reset (0, 1)
Jun 17 09:53:02 orclex kernel: IT8212ResetAdapter Success!
Jun 17 09:53:02 orclex kernel: AtapiResetController exit
Jun 17 09:53:02 orclex kernel: AtapiResetController enter
Jun 17 09:53:02 orclex kernel: IT8212ResetAdapter: perform ATAPI soft reset (0, 1)
Jun 17 09:53:02 orclex kernel: IT8212ResetAdapter Success!
Jun 17 09:53:02 orclex kernel: AtapiResetController exit
Jun 17 09:53:02 orclex kernel: AtapiInterrupt error
Jun 17 09:53:02 orclex kernel: MapError: error register is 60
Jun 17 09:53:02 orclex kernel: ATAPI: unit attention
Jun 17 09:53:02 orclex kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 1 lun 0
Jun 17 09:53:02 orclex kernel: scsi scan: 47 byte inquiry failed.  Consider BLIST_INQUIRY_36 for this device
Jun 17 09:53:02 orclex kernel: scsi0 (1:0): rejecting I/O to offline device
Jun 17 09:53:02 orclex kernel: GDT-HA: Storage RAID Controller Driver. Version: 3.04 
Jun 17 09:53:02 orclex kernel: GDT-HA: Found 0 PCI Storage RAID Controllers
Jun 17 09:53:02 orclex kernel: libata version 1.11 loaded.
Jun 17 09:53:02 orclex kernel: ahci version 1.00
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
Jun 17 09:53:02 orclex kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Jun 17 09:53:02 orclex kernel: ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
Jun 17 09:53:02 orclex kernel: ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part 
Jun 17 09:53:02 orclex kernel: ata1: SATA max UDMA/133 cmd 0xFFFFC20000026D00 ctl 0x0 bmdma 0x0 irq 233
Jun 17 09:53:02 orclex kernel: ata2: SATA max UDMA/133 cmd 0xFFFFC20000026D80 ctl 0x0 bmdma 0x0 irq 233
Jun 17 09:53:02 orclex kernel: ata3: SATA max UDMA/133 cmd 0xFFFFC20000026E00 ctl 0x0 bmdma 0x0 irq 233
Jun 17 09:53:02 orclex kernel: ata4: SATA max UDMA/133 cmd 0xFFFFC20000026E80 ctl 0x0 bmdma 0x0 irq 233
Jun 17 09:53:02 orclex kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
Jun 17 09:53:02 orclex kernel: ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
Jun 17 09:53:02 orclex kernel: ata1: dev 0 configured for UDMA/133
Jun 17 09:53:02 orclex kernel: scsi1 : ahci
Jun 17 09:53:02 orclex kernel: ata2: no device found (phy stat 00000000)
Jun 17 09:53:02 orclex kernel: scsi2 : ahci
Jun 17 09:53:02 orclex kernel: ata3: no device found (phy stat 00000000)
Jun 17 09:53:02 orclex kernel: scsi3 : ahci
Jun 17 09:53:02 orclex kernel: ata4: no device found (phy stat 00000000)
Jun 17 09:53:02 orclex kernel: scsi4 : ahci
Jun 17 09:53:02 orclex kernel: Vendor: ATA       Model: ST3250823AS       Rev: 3.02
Jun 17 09:53:02 orclex kernel: Type:   Direct-Access                      ANSI SCSI revision: 05
Jun 17 09:53:02 orclex kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Jun 17 09:53:02 orclex kernel: SCSI device sda: drive cache: write back
Jun 17 09:53:02 orclex kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Jun 17 09:53:02 orclex kernel: SCSI device sda: drive cache: write back
Jun 17 09:53:02 orclex kernel: sda: sda1 sda2 < sda5 > sda3
Jun 17 09:53:02 orclex kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Jun 17 09:53:02 orclex kernel: Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
Jun 17 09:53:02 orclex kernel: SCSI Media Changer driver v0.25 
Jun 17 09:53:02 orclex kernel: ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 50
Jun 17 09:53:02 orclex kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[50]  MMIO=[cfefb800-cfefbfff]  Max Packet=[4096]
Jun 17 09:53:02 orclex kernel: ieee1394: raw1394: /dev/raw1394 device initialized
Jun 17 09:53:02 orclex kernel: usbmon: debugs is not available
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 225
Jun 17 09:53:02 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Jun 17 09:53:02 orclex kernel: ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
Jun 17 09:53:02 orclex kernel: ehci_hcd 0000:00:1d.7: debug port 1
Jun 17 09:53:02 orclex kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Jun 17 09:53:02 orclex kernel: ehci_hcd 0000:00:1d.7: irq 225, io mem 0xcfdff800
Jun 17 09:53:02 orclex kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Jun 17 09:53:02 orclex kernel: ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Jun 17 09:53:02 orclex kernel: hub 1-0:1.0: USB hub found
Jun 17 09:53:02 orclex kernel: hub 1-0:1.0: 8 ports detected
Jun 17 09:53:02 orclex kernel: ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Jun 17 09:53:02 orclex kernel: USB Universal Host Controller Interface driver v2.3
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 225
Jun 17 09:53:02 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.0: irq 225, io base 0x00004400
Jun 17 09:53:02 orclex kernel: hub 2-0:1.0: USB hub found
Jun 17 09:53:02 orclex kernel: hub 2-0:1.0: 2 ports detected
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 233
Jun 17 09:53:02 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.1: irq 233, io base 0x00004800
Jun 17 09:53:02 orclex kernel: hub 3-0:1.0: USB hub found
Jun 17 09:53:02 orclex kernel: hub 3-0:1.0: 2 ports detected
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 217
Jun 17 09:53:02 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.2: irq 217, io base 0x00005000
Jun 17 09:53:02 orclex kernel: hub 4-0:1.0: USB hub found
Jun 17 09:53:02 orclex kernel: hub 4-0:1.0: 2 ports detected
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
Jun 17 09:53:02 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Jun 17 09:53:02 orclex kernel: uhci_hcd 0000:00:1d.3: irq 169, io base 0x00005400
Jun 17 09:53:02 orclex kernel: hub 5-0:1.0: USB hub found
Jun 17 09:53:02 orclex kernel: hub 5-0:1.0: 2 ports detected
Jun 17 09:53:02 orclex kernel: Initializing USB Mass Storage driver...
Jun 17 09:53:02 orclex kernel: usbcore: registered new driver usb-storage
Jun 17 09:53:02 orclex kernel: USB Mass Storage support registered.
Jun 17 09:53:02 orclex kernel: usb 2-1: new low speed USB device using uhci_hcd and address 2
Jun 17 09:53:02 orclex kernel: usbcore: registered new driver hiddev
Jun 17 09:53:02 orclex kernel: usb 3-1: new low speed USB device using uhci_hcd and address 2
Jun 17 09:53:02 orclex kernel: input: USB HID v1.00 Joystick [Microsoft Microsoft SideWinder game controller] on usb-0000:00:1d.0-1
Jun 17 09:53:02 orclex kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft Wheel Mouse Optical®] on usb-0000:00:1d.1-1
Jun 17 09:53:02 orclex kernel: usbcore: registered new driver usbhid
Jun 17 09:53:02 orclex kernel: drivers/usb/input/hid-core.c: v2.01:USB HID core driver
Jun 17 09:53:02 orclex kernel: mice: PS/2 mouse device common for all mice
Jun 17 09:53:02 orclex kernel: input: PC Speaker
Jun 17 09:53:02 orclex kernel: md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jun 17 09:53:02 orclex kernel: md: bitmap version 3.38
Jun 17 09:53:02 orclex kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Jun 17 09:53:02 orclex kernel: GACT probability on
Jun 17 09:53:02 orclex kernel: Mirror/redirect action on
Jun 17 09:53:02 orclex kernel: u32 classifier
Jun 17 09:53:02 orclex kernel: Perfomance counters on
Jun 17 09:53:02 orclex kernel: input device check on 
Jun 17 09:53:02 orclex kernel: Actions configured 
Jun 17 09:53:02 orclex kernel: NET: Registered protocol family 2
Jun 17 09:53:02 orclex kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jun 17 09:53:02 orclex kernel: IP: routing cache hash table of 4096 buckets, 64Kbytes
Jun 17 09:53:02 orclex kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jun 17 09:53:02 orclex kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jun 17 09:53:02 orclex kernel: TCP: Hash tables configured (established 262144 bind 65536)
Jun 17 09:53:02 orclex kernel: TCP reno registered
Jun 17 09:53:02 orclex kernel: IPv4 over IPv4 tunneling driver
Jun 17 09:53:02 orclex kernel: ip_conntrack version 2.1 (4094 buckets, 32752 max) - 296 bytes per conntrack
Jun 17 09:53:02 orclex kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800007ef52b]
Jun 17 09:53:02 orclex kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jun 17 09:53:02 orclex kernel: ipt_recent v0.3.2: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Jun 17 09:53:02 orclex kernel: TCP bic registered
Jun 17 09:53:02 orclex kernel: TCP westwood registered
Jun 17 09:53:02 orclex kernel: TCP htcp registered
Jun 17 09:53:02 orclex kernel: Initializing IPsec netlink socket
Jun 17 09:53:02 orclex kernel: NET: Registered protocol family 1
Jun 17 09:53:02 orclex kernel: NET: Registered protocol family 17
Jun 17 09:53:02 orclex kernel: NET: Registered protocol family 15
Jun 17 09:53:02 orclex kernel: Using IPI Shortcut mode
Jun 17 09:53:02 orclex kernel: swsusp: Suspend partition has wrong signature?
Jun 17 09:53:02 orclex kernel: md: Autodetecting RAID arrays.
Jun 17 09:53:02 orclex kernel: md: autorun ...
Jun 17 09:53:02 orclex kernel: md: ... autorun DONE.
Jun 17 09:53:02 orclex kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Jun 17 09:53:02 orclex kernel: EXT3-fs: write access will be enabled during recovery.
Jun 17 09:53:02 orclex kernel: kjournald starting.  Commit interval 5 seconds
Jun 17 09:53:02 orclex kernel: EXT3-fs: recovery complete.
Jun 17 09:53:02 orclex kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun 17 09:53:02 orclex kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jun 17 09:53:02 orclex kernel: Freeing unused kernel memory: 240k freed
Jun 17 09:53:02 orclex kernel: Adding 2658716k swap on /dev/sda5.  Priority:-1 extents:1
Jun 17 09:53:02 orclex kernel: EXT3 FS on sda3, internal journal
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 21 (level, low) -> IRQ 50
Jun 17 09:53:02 orclex kernel: hda: dma_timer_expiry: dma status == 0x64
Jun 17 09:53:02 orclex kernel: hda: DMA interrupt recovery
Jun 17 09:53:02 orclex kernel: hda: lost interrupt
Jun 17 09:53:02 orclex kernel: kjournald starting.  Commit interval 5 seconds
Jun 17 09:53:02 orclex kernel: EXT3 FS on sda1, internal journal
Jun 17 09:53:02 orclex kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 17 09:53:02 orclex kernel: PCI: Setting latency timer of device 0000:00:1b.0 to 64
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:01:09.1[A] -> GSI 17 (level, low) -> IRQ 201
Jun 17 09:53:02 orclex kernel: parport: PnPBIOS parport detected.
Jun 17 09:53:02 orclex kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
Jun 17 09:53:02 orclex kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Jun 17 09:53:02 orclex kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 17 09:53:02 orclex kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 17 09:53:02 orclex kernel: eth0: network connection up using port A
Jun 17 09:53:02 orclex kernel: speed:           100
Jun 17 09:53:02 orclex kernel: autonegotiation: yes
Jun 17 09:53:02 orclex kernel: duplex mode:     full
Jun 17 09:53:02 orclex kernel: flowctrl:        none
Jun 17 09:53:02 orclex kernel: irq moderation:  disabled
Jun 17 09:53:02 orclex kernel: scatter-gather:  enabled
Jun 17 09:53:03 orclex cpufreqd: libsys_init() - no batteries found, not a laptop?
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: lp0: using parport0 (interrupt-driven).
Jun 17 09:53:05 orclex udev[4242]: creating device node '/dev/lp0'
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:53:06 orclex kernel: irq 217: nobody cared (try booting with the "irqpoll" option.
Jun 17 09:53:06 orclex kernel: 
Jun 17 09:53:06 orclex kernel: Call Trace: <IRQ> <ffffffff80154eef>{__report_bad_irq+48} <ffffffff80154fe8>{note_interrupt+144}
Jun 17 09:53:06 orclex kernel: <ffffffff801547ff>{__do_IRQ+237} <ffffffff80110591>{do_IRQ+67}
Jun 17 09:53:06 orclex kernel: <ffffffff8010df0d>{ret_from_intr+0}  <EOI> <ffffffff8010bca7>{mwait_idle+94}
Jun 17 09:53:06 orclex kernel: <ffffffff8010bc2b>{cpu_idle+79} <ffffffff806a8866>{start_kernel+429}
Jun 17 09:53:06 orclex kernel: <ffffffff806a822c>{x86_64_start_kernel+320} 
Jun 17 09:53:06 orclex kernel: handlers:
Jun 17 09:53:06 orclex kernel: [<ffffffff80311b75>] (ide_intr+0x0/0x17a)
Jun 17 09:53:06 orclex kernel: [<ffffffff80364c92>] (usb_hcd_irq+0x0/0x68)
Jun 17 09:53:06 orclex kernel: Disabling IRQ #217
Jun 17 09:53:08 orclex /usr/sbin/gpm[4329]: Detected EXPS/2 protocol mouse.
Jun 17 09:54:07 orclex kernel: hdb: lost interrupt
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: scsi: unknown opcode 0x85
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:07 orclex lpd[4366]: restarted
Jun 17 09:54:08 orclex hddtemp[4357]: /dev/hda: IC35L060AVV207-0: 31 C
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:54:08 orclex nmbd[4376]: [2005/06/17 09:54:08, 0, pid=4376] nmbd/asyncdns.c:start_async_dns(149)
Jun 17 09:54:08 orclex nmbd[4376]:   started asyncdns process 4377
Jun 17 09:54:09 orclex kernel: irq 217: nobody cared (try booting with the "irqpoll" option.
Jun 17 09:54:09 orclex kernel: 
Jun 17 09:54:09 orclex kernel: Call Trace: <IRQ> <ffffffff80154eef>{__report_bad_irq+48} <ffffffff80154fe8>{note_interrupt+144}
Jun 17 09:54:09 orclex kernel: <ffffffff801547ff>{__do_IRQ+237} <ffffffff80110591>{do_IRQ+67}
Jun 17 09:54:09 orclex kernel: <ffffffff8010df0d>{ret_from_intr+0}  <EOI> <ffffffff8010bca7>{mwait_idle+94}
Jun 17 09:54:09 orclex kernel: <ffffffff8010bc2b>{cpu_idle+79} <ffffffff806a8866>{start_kernel+429}
Jun 17 09:54:09 orclex kernel: <ffffffff806a822c>{x86_64_start_kernel+320} 
Jun 17 09:54:09 orclex kernel: handlers:
Jun 17 09:54:09 orclex kernel: [<ffffffff80311b75>] (ide_intr+0x0/0x17a)
Jun 17 09:54:09 orclex kernel: [<ffffffff80364c92>] (usb_hcd_irq+0x0/0x68)
Jun 17 09:54:09 orclex kernel: Disabling IRQ #217
Jun 17 09:54:10 orclex Xprt_64: No matching visual for __GLcontextMode with visual class = 0 (32775), nplanes = 8
Jun 17 09:54:11 orclex rpc.statd[4503]: Version 1.0.7 Starting
Jun 17 09:54:11 orclex rpc.statd[4503]: statd running as root. chown /var/lib/nfs/sm to choose different user
Jun 17 09:54:12 orclex anacron[4509]: Anacron 2.3 started on 2005-06-17
Jun 17 09:54:12 orclex anacron[4509]: Normal exit (0 jobs run)
Jun 17 09:54:12 orclex /usr/sbin/cron[4514]: (CRON) INFO (pidfile fd = 3)
Jun 17 09:54:12 orclex /usr/sbin/cron[4515]: (CRON) STARTUP (fork ok)
Jun 17 09:54:12 orclex /usr/sbin/cron[4515]: (CRON) INFO (Running @reboot jobs)
Jun 17 09:54:14 orclex udev[4535]: creating device node '/dev/vcs2'
Jun 17 09:54:14 orclex udev[4539]: creating device node '/dev/vcs3'
Jun 17 09:54:14 orclex udev[4537]: creating device node '/dev/vcsa2'
Jun 17 09:54:14 orclex udev[4549]: creating device node '/dev/vcsa3'
Jun 17 09:54:14 orclex udev[4560]: creating device node '/dev/vcs4'
Jun 17 09:54:14 orclex udev[4575]: creating device node '/dev/vcsa4'
Jun 17 09:54:14 orclex udev[4580]: creating device node '/dev/vcs5'
Jun 17 09:54:14 orclex udev[4585]: creating device node '/dev/vcsa5'
Jun 17 09:54:14 orclex udev[4590]: creating device node '/dev/vcs6'
Jun 17 09:54:14 orclex udev[4594]: creating device node '/dev/vcsa6'
Jun 17 09:54:14 orclex udev[4598]: creating device node '/dev/vcsa7'
Jun 17 09:54:14 orclex udev[4596]: creating device node '/dev/vcs7'
Jun 17 09:54:14 orclex udev[4607]: removing device node '/dev/vcs4'
Jun 17 09:54:14 orclex udev[4619]: removing device node '/dev/vcs2'
Jun 17 09:54:14 orclex udev[4614]: removing device node '/dev/vcs3'
Jun 17 09:54:14 orclex udev[4618]: removing device node '/dev/vcsa3'
Jun 17 09:54:14 orclex udev[4622]: removing device node '/dev/vcsa2'
Jun 17 09:54:16 orclex gdm[4533]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Jun 17 09:54:20 orclex gdm[4654]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Jun 17 09:54:24 orclex gdm[4666]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Jun 17 09:54:24 orclex gdm[4532]: deal_with_x_crashes: Das Skript XKeepsCrashing wird gestartet
Jun 17 09:54:28 orclex gdm[4532]: X-Server konnte nicht in kurzen Zeitabständen gestartet werden; Anzeige :0 wird deaktiviert
Jun 17 09:55:09 orclex kernel: hdb: lost interrupt
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:09 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 09:55:10 orclex udev[4768]: removing device node '/dev/vcsa4'
Jun 17 09:55:10 orclex udev[4816]: removing device node '/dev/vcs6'
Jun 17 09:55:10 orclex udev[4823]: creating device node '/dev/vcsa3'
Jun 17 09:55:10 orclex udev[4817]: removing device node '/dev/vcsa6'
Jun 17 09:55:10 orclex udev[4818]: removing device node '/dev/vcs5'
Jun 17 09:55:10 orclex udev[4821]: creating device node '/dev/vcs2'
Jun 17 09:55:10 orclex udev[4850]: creating device node '/dev/vcsa2'
Jun 17 09:55:10 orclex udev[4852]: removing device node '/dev/vcsa5'
Jun 17 09:55:10 orclex udev[4857]: creating device node '/dev/vcs6'
Jun 17 09:55:10 orclex udev[4851]: creating device node '/dev/vcs4'
Jun 17 09:55:10 orclex udev[4853]: creating device node '/dev/vcs3'
Jun 17 09:55:10 orclex udev[4895]: creating device node '/dev/vcsa6'
Jun 17 09:55:10 orclex udev[4896]: creating device node '/dev/vcsa4'
Jun 17 09:55:10 orclex udev[4899]: removing device node '/dev/vcs7'
Jun 17 09:55:10 orclex udev[4915]: creating device node '/dev/vcsa5'
Jun 17 09:55:10 orclex udev[4916]: removing device node '/dev/vcsa7'
Jun 17 09:55:10 orclex udev[4940]: creating device node '/dev/vcs5'
Jun 17 09:55:10 orclex kernel: irq 217: nobody cared (try booting with the "irqpoll" option.
Jun 17 09:55:10 orclex kernel: 
Jun 17 09:55:10 orclex kernel: Call Trace: <IRQ> <ffffffff80154eef>{__report_bad_irq+48} <ffffffff80154fe8>{note_interrupt+144}
Jun 17 09:55:10 orclex kernel: <ffffffff801547ff>{__do_IRQ+237} <ffffffff80110591>{do_IRQ+67}
Jun 17 09:55:10 orclex kernel: <ffffffff8010df0d>{ret_from_intr+0}  <EOI> <ffffffff8010bca7>{mwait_idle+94}
Jun 17 09:55:10 orclex kernel: <ffffffff8010bc2b>{cpu_idle+79} <ffffffff806a8866>{start_kernel+429}
Jun 17 09:55:10 orclex kernel: <ffffffff806a822c>{x86_64_start_kernel+320} 
Jun 17 09:55:10 orclex kernel: handlers:
Jun 17 09:55:10 orclex kernel: [<ffffffff80311b75>] (ide_intr+0x0/0x17a)
Jun 17 09:55:10 orclex kernel: [<ffffffff80364c92>] (usb_hcd_irq+0x0/0x68)
Jun 17 09:55:10 orclex kernel: Disabling IRQ #217

--------------070401020200000404010700
Content-Type: text/plain;
 name="syslog2612rc6git8iteraid"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog2612rc6git8iteraid"

 kernel: ICH6: IDE controller at PCI slot 0000:00:1f.1
 kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 217
 kernel: ICH6: chipset revision 3
 kernel: ICH6: 100% native mode on irq 217
 kernel: ide0: BM-DMA at 0x5800-0x5807, BIOS settings: hda:DMA, hdb:DMA
 kernel: ide1: BM-DMA at 0x5808-0x580f, BIOS settings: hdc:pio, hdd:pio
 kernel: Probing IDE interface ide0...
 kernel: hda: IC35L060AVV207-0, ATA DISK drive
 kernel: hdb: SONY CD-RW CRX210E1, ATAPI CD/DVD-ROM drive
 kernel: ide0 at 0x7000-0x7007,0x6802 on irq 217
 kernel: Probing IDE interface ide1...
 kernel: Probing IDE interface ide1...
 kernel: Probing IDE interface ide2...
 kernel: Probing IDE interface ide3...
 kernel: Probing IDE interface ide4...
 kernel: Probing IDE interface ide5...
 kernel: hda: max request size: 1024KiB
 kernel: hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
 kernel: hda: cache flushes supported
 kernel: hda: hda1 hda2
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: Losing some ticks... checking if CPU frequency changed.
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: Uniform CD-ROM driver Revision: 3.20
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 23 (level, low) -> IRQ 225
 kernel: Found Controller: IT8212 UDMA/ATA133 RAID Controller
 kernel: irq 217: nobody cared!
 kernel: 
 kernel: Call Trace: <IRQ> <ffffffff801540ac>{__report_bad_irq+48} <ffffffff80154170>{note_interrupt+91}
 kernel: <ffffffff80153b28>{__do_IRQ+234} <ffffffff8011049d>{do_IRQ+67}
 kernel: <ffffffff8010dded>{ret_from_intr+0}  <EOI> <ffffffff8010df1d>{retint_kernel+38}
 kernel: <ffffffff8023a53c>{__delay+8} <ffffffff8032640a>{iteraid_find_device+148}
 kernel: <ffffffff803267e5>{iteraid_init+454} <ffffffff803268bb>{iteraid_detect+173}
 kernel: <ffffffff8069205d>{init_this_scsi_driver+94} <ffffffff806768f1>{do_initcalls+102}
 kernel: <ffffffff8010b11f>{init+190} <ffffffff8010e42f>{child_rip+8}
 kernel: <ffffffff8010b061>{init+0} <ffffffff8010e427>{child_rip+0}
 kernel: 
 kernel: handlers:
 kernel: [<ffffffff8030a369>] (ide_intr+0x0/0x17a)
 kernel: Disabling IRQ #217
 kernel: IssueIdentify: resetting channel.
 kernel: IssueIdentify(IDE): disk[0] not ready. status=0x20
 kernel: FindDevices: device 0 is not present
 kernel: iteraid_find_device: channel 0 device 1 is ATAPI.
 kernel: Channel[0] BM-DMA at 0x9800-0x9807
 kernel: IssueIdentify: resetting channel.
 kernel: IssueIdentify(IDE): disk[0] not ready. status=0x20
 kernel: FindDevices: device 2 is not present
 kernel: IssueIdentify: resetting channel.
 kernel: IssueIdentify(IDE): disk[1] not ready. status=0x30
 kernel: FindDevices: device 3 is not present
 kernel: Channel[1] BM-DMA at 0x9808-0x980F
 kernel: scsi0 : ITE RAIDExpress133
 kernel: AtapiInterrupt: 23 words requested; 24 words xferred
 kernel: AtapiInterrupt error
 kernel: MapError: error register is b0
 kernel: ATAPI: command Aborted
 kernel: AtapiInterrupt: 32 words requested; 9 words xferred
 kernel: AtapiResetController enter
 kernel: IT8212ResetAdapter: perform ATAPI soft reset (0, 1)
 kernel: IT8212ResetAdapter Success!
 kernel: AtapiResetController exit
 kernel: AtapiResetController enter
 kernel: IT8212ResetAdapter: perform ATAPI soft reset (0, 1)
 kernel: IT8212ResetAdapter Success!
 kernel: AtapiResetController exit
 kernel: AtapiInterrupt error
 kernel: MapError: error register is 60
 kernel: ATAPI: unit attention
 kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 1 lun 0
 kernel: scsi scan: 47 byte inquiry failed.  Consider BLIST_INQUIRY_36 for this device
 kernel: scsi0 (1:0): rejecting I/O to offline device
 kernel: libata version 1.11 loaded.
 kernel: ahci version 1.00
 kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
 kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
 kernel: ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
 kernel: ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part 
 kernel: ata1: SATA max UDMA/133 cmd 0xFFFFC20000026D00 ctl 0x0 bmdma 0x0 irq 233
 kernel: ata2: SATA max UDMA/133 cmd 0xFFFFC20000026D80 ctl 0x0 bmdma 0x0 irq 233
 kernel: ata3: SATA max UDMA/133 cmd 0xFFFFC20000026E00 ctl 0x0 bmdma 0x0 irq 233
 kernel: ata4: SATA max UDMA/133 cmd 0xFFFFC20000026E80 ctl 0x0 bmdma 0x0 irq 233
 kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
 kernel: ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
 kernel: ata1: dev 0 configured for UDMA/133
 kernel: scsi1 : ahci
 kernel: ata2: no device found (phy stat 00000000)
 kernel: scsi2 : ahci
 kernel: ata3: no device found (phy stat 00000000)
 kernel: scsi3 : ahci
 kernel: ata4: no device found (phy stat 00000000)
 kernel: scsi4 : ahci
 kernel: Vendor: ATA       Model: ST3250823AS       Rev: 3.02
 kernel: Type:   Direct-Access                      ANSI SCSI revision: 05
 kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
 kernel: SCSI device sda: drive cache: write back
 kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
 kernel: SCSI device sda: drive cache: write back
 kernel: sda: sda1 sda2 < sda5 > sda3
 kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
 kernel: Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0

[...]
 kernel: hda: dma_timer_expiry: dma status == 0x64
 kernel: hda: DMA interrupt recovery
 kernel: hda: lost interrupt

 // the kernel still hangs here for a while
[...]

 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
[...] // message is repeated 110 times

 kernel: cdrom: open failed.
 kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
 kernel: ide: failed opcode was: unknown
 kernel: hdb: drive not ready for command
 kernel: hdb: packet command error: status=0xd0 { Busy }
 kernel: ide: failed opcode was: unknown
 kernel: irq 217: nobody cared!
 kernel: 
 kernel: Call Trace: <IRQ> <ffffffff801540ac>{__report_bad_irq+48} <ffffffff80154170>{note_interrupt+91}
 kernel: <ffffffff80153b28>{__do_IRQ+234} <ffffffff8011049d>{do_IRQ+67}
 kernel: <ffffffff8010dded>{ret_from_intr+0}  <EOI> 
 kernel: handlers:
 kernel: [<ffffffff8030a369>] (ide_intr+0x0/0x17a)
 kernel: [<ffffffff803548a1>] (usb_hcd_irq+0x0/0x68)
 kernel: Disabling IRQ #217
 kernel: hdb: irq timeout: status=0xd0 { Busy }
 kernel: ide: failed opcode was: unknown
 kernel: hdb: DMA disabled
 kernel: hdb: ATAPI reset complete
 kernel: irq 217: nobody cared!
 kernel: 
 kernel: Call Trace: <IRQ> <ffffffff801540ac>{__report_bad_irq+48} <ffffffff80154170>{note_interrupt+91}
 kernel: <ffffffff80153b28>{__do_IRQ+234} <ffffffff8011049d>{do_IRQ+67}
 kernel: <ffffffff8010dded>{ret_from_intr+0}  <EOI> <ffffffff8010df1d>{retint_kernel+38}
 kernel: <ffffffff8010bb2c>{mwait_idle+94} <ffffffff8010bab0>{cpu_idle+71}
 kernel: <ffffffff80676876>{start_kernel+445} <ffffffff8067622c>{x86_64_start_kernel+320}
 kernel: 
 kernel: handlers:
 kernel: [<ffffffff8030a369>] (ide_intr+0x0/0x17a)
 kernel: [<ffffffff803548a1>] (usb_hcd_irq+0x0/0x68)
 kernel: Disabling IRQ #217
 kernel: hdb: irq timeout: status=0xc0 { Busy }
 kernel: ide: failed opcode was: unknown
 kernel: hdb: ATAPI reset complete
 kernel: irq 217: nobody cared!
 kernel: 
 kernel: Call Trace: <IRQ> <ffffffff801540ac>{__report_bad_irq+48} <ffffffff80154170>{note_interrupt+91}
 kernel: <ffffffff80153b28>{__do_IRQ+234} <ffffffff8011049d>{do_IRQ+67}
 kernel: <ffffffff8010dded>{ret_from_intr+0}  <EOI> <ffffffff8010df1d>{retint_kernel+38}
 kernel: <ffffffff8010bb2c>{mwait_idle+94} <ffffffff8010bab0>{cpu_idle+71}
 kernel: <ffffffff80676876>{start_kernel+445} <ffffffff8067622c>{x86_64_start_kernel+320}
 kernel: 
 kernel: handlers:
 kernel: [<ffffffff8030a369>] (ide_intr+0x0/0x17a)
 kernel: [<ffffffff803548a1>] (usb_hcd_irq+0x0/0x68)
 kernel: Disabling IRQ #217
 kernel: hdb: lost interrupt
 kernel: scsi: unknown opcode 0x85
 lpd[4373]: restarted
 hddtemp[4364]: /dev/hda: IC35L060AVV207-0: 36 C
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
 kernel: ide: failed opcode was: unknown
 kernel: hdb: drive not ready for command
 kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
 kernel: irq 217: nobody cared!
 kernel: 
 kernel: Call Trace: <IRQ> <ffffffff801540ac>{__report_bad_irq+48} <ffffffff80154170>{note_interrupt+91}
 kernel: <ffffffff80153b28>{__do_IRQ+234} <ffffffff8011049d>{do_IRQ+67}
 kernel: <ffffffff8010dded>{ret_from_intr+0}  <EOI> 
 kernel: handlers:
 kernel: [<ffffffff8030a369>] (ide_intr+0x0/0x17a)
 kernel: [<ffffffff803548a1>] (usb_hcd_irq+0x0/0x68)
 kernel: Disabling IRQ #217

--------------070401020200000404010700--
