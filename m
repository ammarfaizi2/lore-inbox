Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266160AbRF2TRG>; Fri, 29 Jun 2001 15:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbRF2TQ4>; Fri, 29 Jun 2001 15:16:56 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:7405 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S266160AbRF2TQl>;
	Fri, 29 Jun 2001 15:16:41 -0400
From: thunder7@xs4all.nl
Date: Fri, 29 Jun 2001 21:16:30 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: PCI bridge setup error in linux-2.4.x (anyone of them)
Message-ID: <20010629211630.A15218@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <3B3CD031.8935F64A@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B3CD031.8935F64A@evision.ag>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2001 at 09:00:01PM +0200, Martin Dalecki wrote:
> I ahve a PC box at hand, which ist containing 8 PCI slots.
> Four of them are sitting behind a PCI bridge.
> The error in the new kernel series is that during the
> PCI bus setup if a card is sitting behind the bridge, it
> will be miracelously detected TWICE. Once in front of the
> bridge and once behind the bridge. The initialisation of
> the card will then be entierly hossed.
> 
> This00:02.0 PCI bridge: Intel Corporation 80960RP [i960 RP
> Microprocessor/Bridge] (rev 03)
> 00:02.1 I2O: Intel Corporation 80960RP [i960RP Microprocessor] (rev 03)
> 00:03.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 02)
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 00:06.0 System peripheral: Hewlett-Packard Company NetServer Smart IRQ
> Router (rev a0)
> 00:08.0 VGA compatible controller: Cirrus Logic GD 5446 (rev 45)
> 00:0f.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
> 00:0f.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> 00:0f.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
> 00:0f.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
> 00:10.0 Host bridge: Intel Corporation 450NX - 82451NX Memory & I/O
> Controller (rev 03)
> 00:12.0 Host bridge: Intel Corporation 450NX - 82454NX PCI Expander
> Bridge (rev 02)
> 02:04.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
> (rev 74)
> oops:~ # 
>  doesn't happen under linux-2.2.x kernel series.
> 
I have an ITI-4280UE multifunction card (two Symbios Logic 875's and a
DEC21140 fast ethernet) which also has such a bridge (rev 02, even) and
have noticed nothing wrong until 2.4.5-ac19 (haven't tested further).

Jurriaan
-- 
... thy successors will not thank thee for it, but rather shall revile thy works
and curse thy name, and word of this might get to thy next employer.
	Henry Spencer - The Ten Commandments for C programmers (Annotated Ed.)
GNU/Linux 2.4.5-ac19 SMP/ReiserFS 2x1402 bogomips load av: 0.00 0.01 0.05
