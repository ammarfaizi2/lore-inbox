Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbWG1N5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbWG1N5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbWG1N5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:57:22 -0400
Received: from [212.76.86.78] ([212.76.86.78]:4109 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1161154AbWG1N5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:57:21 -0400
From: Al Boldi <a1426z@gawab.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp hangs on headless resume-from-ram
Date: Fri, 28 Jul 2006 16:58:37 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607262206.48801.a1426z@gawab.com> <200607270034.47532.a1426z@gawab.com> <200607281055.47526.rjw@sisk.pl>
In-Reply-To: <200607281055.47526.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_NghyExpesIBf/nd"
Message-Id: <200607281658.37794.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_NghyExpesIBf/nd
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Rafael J. Wysocki wrote:
> On Wednesday 26 July 2006 23:34, Al Boldi wrote:
> > Rafael J. Wysocki wrote:
> > > On Wednesday 26 July 2006 21:06, Al Boldi wrote:
> > > > swsusp is really great, most of the time.  But sometimes it hangs
> > > > after coming out of STR.  I suspect it's got something to do with
> > > > display access, as this problem seems hw related.  So I removed the
> > > > display card, and it positively does not resume from ram on 2.6.16+.
> > > >
> > > > Any easy fix for this?
> > >
> > > I have one idea, but you'll need a patch to test.  I'll try to prepare
> > > it tomorrow.
> > >
> > > I guess your box is an i386?
> >
> > That should be assumed by default :)
>
> I had hoped I would be able to test it somewhere, but I couldn't.  I hope
> it will compile. :-)
>
> If it does, please send me the output of dmesg after a fresh boot.

See attached.  patched against 2.6.17.

Thanks!

--
Al



--Boundary-00=_NghyExpesIBf/nd
Content-Type: text/x-log;
  charset="windows-1256";
  name="s2r.disp.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="s2r.disp.log"

Linux version 2.6.17 (root@localhost) (gcc version 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)) #1 Fri Jul 28 15:05:07 AST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 61424 pages, LIFO batch:15
DMI 2.1 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f7090
ACPI: RSDT (v001 COMPAQ CPQB0B9  0x00000000  0x00000000) @ 0x0fff3000
ACPI: FADT (v001 COMPAQ CPQB0B9  0x00000000  0x00000000) @ 0x0fff3040
ACPI: DSDT (v001 COMPAQ AWRDACPI 0x00001000 MSFT 0x01000007) @ 0x00000000
Allocating PCI resources starting at 20000000 (gap: 10000000:efff0000)
Built 1 zonelists
Kernel command line: root=/dev/nfs ip=bootp nfsroot=rh52 lapic BOOT_IMAGE=grub/v617.s2r 
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Detected 432.363 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256600k/262080k available (1770k kernel code, 4988k reserved, 560k data, 212k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 865.63 BogoMIPS (lpj=432815)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps: 0183fbff 00000000 00000000 00000040 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 05
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 8c00)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb180, last bus=1
Setting up standard PCI resources
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Nosave address range: 000000000fff0000 - 000000000fff3000
Nosave address range: 000000000fff3000 - 0000000010000000
Nosave address range: 0000000010000000 - 00000000ffff0000
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 4000-403f claimed by PIIX4 ACPI
PCI quirk: region 5000-500f claimed by PIIX4 SMB
Boot video device is 0000:00:0a.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 *15)
ACPI: Power Resource [PFAN] (on)
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
io scheduler noop registered (default)
Limiting direct PCI/PCI transfers.
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (35 C)
Real Time Clock Driver v1.12ac
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #0 config 1000 status 782d advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0001e400, 00:80:C8:45:77:A9, IRQ 11.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PCI: Enabling device 0000:00:07.1 (0000 -> 0001)
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
PIIX4: neither IDE port enabled (BIOS)
Probing IDE interface ide0...
Probing IDE interface ide1...
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
USB0 
ACPI: (supports S0 S1 S3 S4 S5)
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 10.0.0.1, my address is 10.0.0.2
IP-Config: Complete:
      device=eth0, addr=10.0.0.2, mask=255.0.0.0, gw=10.0.0.1,
     host=10.0.0.2, domain=intranet, nis-domain=(none),
     bootserver=10.0.0.1, rootserver=10.0.0.1, rootpath=
Looking up port of RPC 100003/2 on 10.0.0.1
Looking up port of RPC 100005/1 on 10.0.0.1
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 212k freed
eth0: Setting full-duplex based on MII#0 link partner capability of 05e1.
Stopping tasks: =============|
ACPI: PCI interrupt for device 0000:00:08.0 disabled
Back to C!
PM: Writing back config space on device 0000:00:07.1 at offset 1 (was 2800000, writing 2800001)
PM: Writing back config space on device 0000:00:08.0 at offset 1 (was 2800000, writing 2800007)
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PM: Writing back config space on device 0000:00:0a.0 at offset 1 (was 2000000, writing 2000007)
Restarting tasks... done

--Boundary-00=_NghyExpesIBf/nd
Content-Type: text/x-log;
  charset="windows-1256";
  name="s2r.nodisp.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="s2r.nodisp.log"

Linux version 2.6.17 (root@localhost) (gcc version 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)) #1 Fri Jul 28 15:05:07 AST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 61424 pages, LIFO batch:15
DMI 2.1 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f7090
ACPI: RSDT (v001 COMPAQ CPQB0B9  0x00000000  0x00000000) @ 0x0fff3000
ACPI: FADT (v001 COMPAQ CPQB0B9  0x00000000  0x00000000) @ 0x0fff3040
ACPI: DSDT (v001 COMPAQ AWRDACPI 0x00001000 MSFT 0x01000007) @ 0x00000000
Allocating PCI resources starting at 20000000 (gap: 10000000:efff0000)
Built 1 zonelists
Kernel command line: root=/dev/nfs ip=bootp nfsroot=rh52 lapic BOOT_IMAGE=grub/v617.s2r 
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Detected 432.483 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256600k/262080k available (1770k kernel code, 4988k reserved, 560k data, 212k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 865.59 BogoMIPS (lpj=432797)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps: 0183fbff 00000000 00000000 00000040 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 05
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 8800)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb180, last bus=1
Setting up standard PCI resources
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Nosave address range: 000000000fff0000 - 000000000fff3000
Nosave address range: 000000000fff3000 - 0000000010000000
Nosave address range: 0000000010000000 - 00000000ffff0000
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 4000-403f claimed by PIIX4 ACPI
PCI quirk: region 5000-500f claimed by PIIX4 SMB
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 *15)
ACPI: Power Resource [PFAN] (on)
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
io scheduler noop registered (default)
Limiting direct PCI/PCI transfers.
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (38 C)
Real Time Clock Driver v1.12ac
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #0 config 1000 status 782d advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0001e400, 00:80:C8:45:77:A9, IRQ 11.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PCI: Enabling device 0000:00:07.1 (0000 -> 0001)
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
PIIX4: neither IDE port enabled (BIOS)
Probing IDE interface ide0...
Probing IDE interface ide1...
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
USB0 
ACPI: (supports S0 S1 S3 S4 S5)
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 10.0.0.1, my address is 10.0.0.2
IP-Config: Complete:
      device=eth0, addr=10.0.0.2, mask=255.0.0.0, gw=10.0.0.1,
     host=10.0.0.2, domain=intranet, nis-domain=(none),
     bootserver=10.0.0.1, rootserver=10.0.0.1, rootpath=
Looking up port of RPC 100003/2 on 10.0.0.1
Looking up port of RPC 100005/1 on 10.0.0.1
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 212k freed
eth0: Setting full-duplex based on MII#0 link partner capability of 05e1.

--Boundary-00=_NghyExpesIBf/nd--

