Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132982AbRDJQyh>; Tue, 10 Apr 2001 12:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132972AbRDJQyV>; Tue, 10 Apr 2001 12:54:21 -0400
Received: from [204.163.170.2] ([204.163.170.2]:64740 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S132710AbRDJQv1>;
	Tue, 10 Apr 2001 12:51:27 -0400
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C1A0@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'Axel Thimm'" <Axel.Thimm+linux-kernel@physik.fu-berlin.de>,
        linux-kernel@vger.kernel.org
Subject: RE: Still IRQ routing problems with VIA (was: VIA KT133 chipset P
	CI crazyness...)
Date: Tue, 10 Apr 2001 09:51:18 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Thimm said...
> Several weeks ago there had been a thread on the pirq 
> assignments of newer VIA
> and SiS chipsets ending with everybody happy.
> 
> Everybody? Not everybody - there is a small village of 
> chipsets resisting the
> advent of 2.4.x :(
> 
> The system is a KT133A (MSI's K7T Turbo MS-6330 board)/Duron 700
> system. Kernel 2.4.x have IRQ routing problems and USB 
> failures (the latter
> will most probably be due to IRQ mismatches, I believe).
> 
> 2.2 kernel = 2.2.17 RH-kernel
> 2.4 kernel = 2.4.3 kernel with 'yes ""|make config' (I also 
> tried configuring
>              and -ac3 patches to no avail.)
> 
> I attached dmesg, lspci -vvvxxx (under both 2.2 and 2.4), and 
> dump_irq (which
> is the same for both kernels)
> 
> As far as I could follow the discussion back in January a 
> problem seem to be
> that different chipset vendors may arbitrary map pirq to 
> links ('A' vs 1
> etc.). On my board I see that there is a rather strange 
> mapping. Maybe this
> confuses 2.4.3?
> 
> Most prominent difference in the lspci -vvvxxx output (to me) 
> is the interrupt
> with the unknown pin:
> 
> > @@ -162,6 +162,7 @@
> >  00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 
> [Apollo Super ACPI] (rev 40)
> >         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- 
> VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > +       Interrupt: pin ? routed to IRQ 11
> >         Capabilities: [68] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> Maybe it is a KT133A != KT133 issue. Note that the analysis 
> above is the best
> I can provide, which has nothing to do with a good analysis.
> 
> Any help mostly appreciated! My board wants to run 2.4.x!!!
> 
> BTW kernel 2.2.x does not give any irq related messages in 
> its logs. Does this
> mean that 2.2.x works well, or that the errors are just not displayed?
> 
> Thanks, Axel.
> -- 
> Axel.Thimm@physik.fu-berlin.de
> 

I have the same motherboard with the same lspci output (i.e. I get the "pin
?" part), but I don't see any problems running 2.4.3 or 2.4.3-ac[23]. I am
only using a trackball on my USB port - what problems are you seeing?

--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Space Ghost: "Hey, what happened to the-?" Moltar: "It's out." SG: "What
about-?" M: "It's fixed." SG: "Eh, good. Good."
