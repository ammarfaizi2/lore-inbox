Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSGVM46>; Mon, 22 Jul 2002 08:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSGVM46>; Mon, 22 Jul 2002 08:56:58 -0400
Received: from iris.mc.com ([192.233.16.119]:55282 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S315472AbSGVM44>;
	Mon, 22 Jul 2002 08:56:56 -0400
Message-Id: <200207221259.IAA03096@mc.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: mbs <mbs@mc.com>
To: Philippe =?iso-8859-1?q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc2-ac2
Date: Mon, 22 Jul 2002 09:03:02 -0400
X-Mailer: KMail [version 1.3.1]
References: <200207161713.g6GHDhw02197@devserv.devel.redhat.com> <9cfadonmp49.fsf@rogue.ncsl.nist.gov> <20020719230217.6b604622.philippe.gramoulle@mmania.com>
In-Reply-To: <20020719230217.6b604622.philippe.gramoulle@mmania.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mine does the same thing except earlier, it locks during floppy_init().  if I 
comment out floppy_init() it locks during scsi probe. (which immediately 
follows floppy_init())

It doesn't entirely die, it stops booting makes no further progress, but 
<shift> page-up/down still work...

supermicro p4dp8-g2, 2x 2.2xeon, wd 40g ide, 2xseagate u160 36g drives.



On Friday 19 July 2002 17:02, Philippe Gramoullé wrote:
> Hi,
>
> I also can't boot on a DELL Precision WorkStation 530 MT with
> 2.4.19-rc2-ac2. (SMP,scsi disk, ide cdrom)
>
> It gets stucked when probing the SCSI disk.
>
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
>         <Adaptec aic7892 Ultra160 SCSI adapter>
>         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> [stucked]
>
>
> Philippe
>
>
> lspci -v output below:
>
> 00:00.0 Host bridge: Intel Corp. 82850 860 (Wombat) Chipset Host Bridge
> (MCH) (rev 04) Subsystem: Dell Computer Corporation: Unknown device 00d8
>         Flags: bus master, fast devsel, latency 0
>         Memory at c0000000 (32-bit, prefetchable) [size=256M]
>         Capabilities: [a0] AGP version 2.0
>
> 00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev
> 04) (prog-if 00 [Normal decode]) Flags: bus master, 66Mhz, fast devsel,
> latency 64
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>         Memory behind bridge: fc000000-fdffffff
>         Prefetchable memory behind bridge: d8000000-dfffffff
>
> 00:02.0 PCI bridge: Intel Corp. 82860 860 (Wombat) Chipset AGP Bridge (rev
> 04) (prog-if 00 [Normal decode]) Flags: bus master, 66Mhz, fast devsel,
> latency 64
>         Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
>         I/O behind bridge: 0000e000-0000efff
>         Memory behind bridge: fe100000-fe4fffff
>
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 04) (prog-if 00
> [Normal decode]) Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: fa000000-fbffffff
>         Prefetchable memory behind bridge: d6000000-d7ffffff
>
> 00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
>         Flags: bus master, medium devsel, latency 0
>
> 00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04) (prog-if 80
> [Master]) Subsystem: Dell Computer Corporation: Unknown device 00d8
>         Flags: bus master, medium devsel, latency 0
>         I/O ports at ffa0 [size=16]
>
> 00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04)
> (prog-if 00 [UHCI]) Subsystem: Dell Computer Corporation: Unknown device
> 00d8
>         Flags: bus master, medium devsel, latency 0, IRQ 19
>         I/O ports at ff80 [size=32]
>
> 00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
>         Subsystem: Dell Computer Corporation: Unknown device 00d8
>         Flags: medium devsel, IRQ 17
>         I/O ports at ccd0 [size=16]
>
> 00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 04)
> (prog-if 00 [UHCI]) Subsystem: Dell Computer Corporation: Unknown device
> 00d8
>         Flags: bus master, medium devsel, latency 0, IRQ 23
>         I/O ports at ff60 [size=32]
>
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio
> (rev 04) Subsystem: Dell Computer Corporation: Unknown device 00d8
>         Flags: bus master, medium devsel, latency 0, IRQ 17
>         I/O ports at c800 [size=256]
>         I/O ports at cc40 [size=64]
>
> 01:00.0 VGA compatible controller: nVidia Corporation NV10 [GeForce 256
> DDR] (rev 10) (prog-if 00 [VGA]) Subsystem: nVidia Corporation: Unknown
> device 0014
>         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 16
>         Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at d8000000 (32-bit, prefetchable) [size=128M]
>         Expansion ROM at c1000000 [disabled] [size=64K]
>         Capabilities: [60] Power Management version 1
>         Capabilities: [44] AGP version 2.0
>
> 02:1f.0 PCI bridge: Intel Corp. 82806AA PCI64 Hub PCI Bridge (rev 03)
> (prog-if 00 [Normal decode]) Flags: bus master, 66Mhz, fast devsel, latency
> 0
>         Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
>         I/O behind bridge: 0000e000-0000efff
>         Memory behind bridge: fe200000-fe4fffff
>
> 03:00.0 PIC: Intel Corp. 82806AA PCI64 Hub Advanced Programmable Interrupt
> Controller (rev 01) (prog-if 20 [IO(X)-APIC]) Subsystem: Intel Corp.
> 82806AA PCI64 Hub APIC
>         Flags: fast devsel
>         Memory at fe3ff000 (32-bit, non-prefetchable) [disabled] [size=4K]
>
> 03:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
> 08) Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter Flags:
> bus master, medium devsel, latency 64, IRQ 20
>         Memory at fe3fe000 (32-bit, non-prefetchable) [size=4K]
>         I/O ports at ecc0 [size=64]
>         Memory at fe200000 (32-bit, non-prefetchable) [size=1M]
>         Expansion ROM at fe400000 [disabled] [size=1M]
>         Capabilities: [dc] Power Management version 2
>
> 03:0e.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
>         Subsystem: Dell Computer Corporation: Unknown device 00d8
>         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 22
>         BIST result: 00
>         I/O ports at e800 [disabled] [size=256]
>         Memory at fe3fd000 (64-bit, non-prefetchable) [size=4K]
>         Expansion ROM at fe400000 [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 2
>
> 04:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
> 07) Subsystem: Creative Labs CT4780 SBLive! Value
>         Flags: bus master, medium devsel, latency 64, IRQ 18
>         I/O ports at dce0 [size=32]
>         Capabilities: [dc] Power Management version 1
>
> 04:0e.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev
> 07) Subsystem: Creative Labs Gameport Joystick
>         Flags: bus master, medium devsel, latency 64
>         I/O ports at dcd8 [size=8]
>         Capabilities: [dc] Power Management version 1
>
> 04:0f.0 VGA compatible controller: nVidia Corporation NV6 [Vanta] (rev 15)
> (prog-if 00 [VGA]) Subsystem: Creative Labs: Unknown device 1039
>         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 19
>         Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at d6000000 (32-bit, prefetchable) [size=32M]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: [60] Power Management version 1
>
>
> On 19 Jul 2002 16:36:38 -0400
>
> Ian Soboroff <ian.soboroff@nist.gov> wrote:
>   |  I have a Fujitsu P-2110 which has an ALI15X3 controller.  RedHat's 7.2
>   |  kernel (2.4.9-mumble) boots OK when I specify 'ide0=ata66 ide1=ata66';
>   |  otherwise, PIO only.
>   |
>   |  Trying out 2.4.19-rc2-ac2, the machine hangs during boot when bringing
>   |  up the ALI15X3 driver, no matter what I give on the kernel command
>   |  line.
>   |
>   |  Any clues?
>   |
>   |  output of /sbin/lspci -v:
>   | [...]
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
** If you would like to sponsor me for the       **
** Mass Getaway, a 150 mile bicycle ride to for  **
** MS, contact me to donate by cash or check or  **
** click the link below to donate by credit card **
**************************************************/
https://www.nationalmssociety.org/pledge/pledge.asp?participantid=86736
