Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbSLNAIn>; Fri, 13 Dec 2002 19:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbSLNAIn>; Fri, 13 Dec 2002 19:08:43 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:16409
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265895AbSLNAIm>; Fri, 13 Dec 2002 19:08:42 -0500
Date: Fri, 13 Dec 2002 19:18:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Valdis.Kletnieks@vt.edu
cc: Dave Jones <davej@codemonkey.org.uk>,
       Petr Konecny <pekon@informatics.muni.cz>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions) 
In-Reply-To: <200212131846.gBDIk527008838@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.50.0212131903180.16106-100000@montezuma.mastecende.com>
References: <200212131345.gBDDjw27002677@turing-police.cc.vt.edu>
 <200212131633.gBDGX0617899@anxur.fi.muni.cz> <200212131718.gBDHIw27008173@turing-police.cc.vt.edu>
            <20021213173656.GC1633@suse.de> <200212131846.gBDIk527008838@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2002 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 13 Dec 2002 17:36:56 GMT, Dave Jones said:
>
> > It's my understanding that pci_enable_device() *must* be called
> > before we fiddle with dev->resource, dev->irq and the like.
>
> OK.. it looks like the problem only hits if it's a PCMCIA card *with an
> onboard ROM*.

Hmm i just saw this thread, which card is the non working one?;

The computer is still running 2.5.50

02:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
        Subsystem: CNet Technology Inc: Unknown device 401a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 1c00 [size=128]
        Region 1: Memory at 10800000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at 10400000 [size=256K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
# PCMCIA/CardBus support
CONFIG_PCMCIA=y
CONFIG_PCMCIA_XIRCOM=y
# CONFIG_PCMCIA_XIRTULIP is not set
# PCMCIA network device support
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_XIRC2PS is not set

--
function.linuxpower.ca

