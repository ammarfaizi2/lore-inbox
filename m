Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269432AbRHCP6u>; Fri, 3 Aug 2001 11:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269433AbRHCP6b>; Fri, 3 Aug 2001 11:58:31 -0400
Received: from mercury.eng.emc.com ([168.159.40.77]:64272 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S269432AbRHCP60>; Fri, 3 Aug 2001 11:58:26 -0400
Message-ID: <276737EB1EC5D311AB950090273BEFDD043BC53F@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Todd'" <todd@unm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: RE: PCI bus speed
Date: Fri, 3 Aug 2001 11:52:52 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todd,

Then how I can tell the bus clock rate from "lspci -v"?
Say the print out from my current machine is like:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
        Flags: bus master, medium devsel, latency 64
        Memory at 44000000 (32-bit, prefetchable) [size=64M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
03) (prog-if 00 [N
ormal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: 40000000-40ffffff
        Prefetchable memory behind bridge: 42000000-43ffffff

00:0d.0 SCSI storage controller: Adaptec AIC-7881U (rev 01)
        Subsystem: Adaptec: Unknown device 7881
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at 1000 [size=256]
        Memory at 41100000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>

00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
05)
        Subsystem: Compaq Computer Corporation NC3121 with Wake on LAN
        Flags: bus master, medium devsel, latency 66, IRQ 9
        Memory at 48000000 (32-bit, prefetchable) [size=4K]
        I/O ports at 1440 [size=32]
        Memory at 41000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: <available only to root>
 
00:10.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
        Subsystem: Compaq Computer Corporation: Unknown device b1a7
        Flags: bus master, slow devsel, latency 64, IRQ 5
        I/O ports at 1400 [size=64]
        Capabilities: <available only to root>
 
00:14.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0
 
00:14.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if
80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1480 [size=16]
 
00:14.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at 1460 [disabled] [size=32]
 
00:14.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Flags: medium devsel
 
01:00.0 VGA compatible controller: nVidia Corporation Riva TNT2 (rev 11)
(prog-if 00 [VGA])
        Subsystem: Elsa AG: Unknown device 0c20
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
        Memory at 40000000 (32-bit, non-prefetchable) [size=16M]
        Memory at 42000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>    


-----Original Message-----
From: Todd [mailto:todd@unm.edu]
Sent: Friday, August 03, 2001 11:46 AM
To: chen, xiangping
Cc: linux-kernel@vger.kernel.org
Subject: RE: PCI bus speed


chen,

i think that if you look at the speed of the bridge, that is the speed the
bridge wants to run the bus at.  as another poster noted, this doesn't
really tell you the speed the bus is actually clocked at.

t.

On Fri, 3 Aug 2001, chen, xiangping wrote:

> Date: Fri, 3 Aug 2001 10:27:10 -0400
> From: "chen, xiangping" <chen_xiangping@emc.com>
> To: 'Todd' <todd@unm.edu>
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: PCI bus speed
>
> yes. I see some items with flags listed as:
> 	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
>
> Is it suppose to mean that the bus freq is 66Mhz?
>
> Thanks,
>
> Xiangping
>
> -----Original Message-----
> From: Todd [mailto:todd@unm.edu]
> Sent: Thursday, August 02, 2001 8:03 PM
> To: chen, xiangping
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: PCI bus speed
>
>
> xiangping,
>
> try
>
> lspci -v
>
> the info you want is there.
>
> todd
>
> On Thu, 2 Aug 2001, chen, xiangping wrote:
>
> > Date: Thu, 2 Aug 2001 18:47:49 -0400
> > From: "chen, xiangping" <chen_xiangping@emc.com>
> > To: linux-kernel@vger.kernel.org
> > Subject: PCI bus speed
> >
> > Hi,
> >
> > Is there any easy way to probe the PCI bus speed
> > of an Intel box?
> >
> > Thanks,
> >
> > Xiangping
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> =========================================================
> Todd Underwood, todd@unm.edu
>
> =========================================================
>

=========================================================
Todd Underwood, todd@unm.edu

=========================================================
