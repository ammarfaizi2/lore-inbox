Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132075AbQLaBPO>; Sat, 30 Dec 2000 20:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132103AbQLaBPE>; Sat, 30 Dec 2000 20:15:04 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:10000 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S132075AbQLaBOx>; Sat, 30 Dec 2000 20:14:53 -0500
Date: Sun, 31 Dec 2000 01:44:16 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: davej@suse.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: Problems with ov511/USB on test13-pre7
Message-ID: <20001231014414.A940@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.21.0012302312580.13297-100000@neo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012302312580.13297-100000@neo.local>; from davej@suse.de on Sat, Dec 30, 2000 at 11:24:40PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2000 at 11:24:40PM +0000, davej@suse.de wrote:
>  Problems with Creative Webcam III. This worked fine
> in test13-pre4, haven't tried pre5 & 6.

[snip]

> USB controller is:
> 
> 00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if
> 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, cache line size 08
>         Interrupt: pin D routed to IRQ 5
>         Region 4: I/O ports at d400 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

This looks like some kind of UHCI problem. I have the same camera
(well, it is a Creative Webcam plus, but same chipset) with an Intel
UHCI controller and I haven't seen any errors. Here is my USB
controller:

00:07.2 USB Controller: Intel Corporation 82440MX USB Universal Host
Controller (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at fcc0 [size=32]


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
