Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbSJNIAY>; Mon, 14 Oct 2002 04:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSJNIAY>; Mon, 14 Oct 2002 04:00:24 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:24971 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S261856AbSJNIAT> convert rfc822-to-8bit;
	Mon, 14 Oct 2002 04:00:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: "Feldman, Scott" <scott.feldman@intel.com>
Subject: Re: Hang in 2.4.20-pre10 with e100 (forget it)
Date: Mon, 14 Oct 2002 10:09:33 +0200
User-Agent: KMail/1.4.1
References: <288F9BF66CD9D5118DF400508B68C44604758B62@orsmsx113.jf.intel.com>
In-Reply-To: <288F9BF66CD9D5118DF400508B68C44604758B62@orsmsx113.jf.intel.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210141009.33660.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

this was caused by a mix of several pieces of hardware that weren't 100% 
compatible. The same error was reproduced on Micksoft Windoze, so please 
forget this.

regards

roy

On Monday 14 October 2002 08:36, Feldman, Scott wrote:
> Roy, did you get this figured out?  I've been away from lkml for awhile,
> and I just saw this.
> -scott
>
> > -----Original Message-----
> > From: Roy Sigurd Karlsbakk [mailto:roy@karlsbakk.net]
> > Sent: Wednesday, October 09, 2002 10:02 AM
> > To: Kernel mailing list
> > Subject: Re: Hang in 2.4.20-pre10 with e100 (more info)
> >
> >
> > This is with the original Becker driver ...
> > Trying the Intel driver now ...
> > Strange ...
> > REALLY strange ...
> >
> > the error seems reproducable with both drivers ;-P
> > and on both motherboards
> >
> > anyone?
> >
> > On Wednesday 09 October 2002 16:01, Roy Sigurd Karlsbakk wrote:
> > > hi
> > >
> > > When downloading/streaming high amounts of data (over HTTP), Linux
> > > 2.4.20-pre10 hangs. And it really hangs. alt+sysrq (from
> >
> > usb keyboard)
> >
> > > doesn't work... The problem is easily reproducable by just doing a
> > > wget http://something/largefile (interface used is PCI ID 01:02.0)
> > >
> > > the problem does not occur when streaming over the Intel gigE
> > > interface.
> > >
> > > roy
> > >
> > >
> > > bash-2.05# lspci -vvvvvvvvvvv
> > > 00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 01)
> > >         Subsystem: Intel Corp.: Unknown device 2560
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr-
> > > Stepping- SERR+ FastB2B-
> > >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=fast >TAbort-
> >
> > > <TAbort- <MAbort+ >SERR- <PERR-
> > >         Latency: 0
> > >         Region 0: Memory at f8000000 (32-bit, prefetchable)
> >
> > [size=64M]
> >
> > >         Capabilities: [e4] #09 [1105]
> > >
> > > 00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2562
> > > (rev
> > > 01) (prog-if 00 [VGA])
> > >         Subsystem: Intel Corp.: Unknown device 4c59
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> >
> > VGASnoop- ParErr-
> >
> > > Stepping- SERR- FastB2B-
> > >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=fast >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 0
> > >         Interrupt: pin A routed to IRQ 11
> > >         Region 0: Memory at f0000000 (32-bit, prefetchable)
> >
> > [size=128M]
> >
> > >         Region 1: Memory at ffa80000 (32-bit,
> >
> > non-prefetchable) [size=512K]
> >
> > >         Capabilities: [d0] Power Management version 1
> > >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> > > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >
> > > 00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01)
> > > (prog-if 00 [UHCI])
> > >         Subsystem: Intel Corp.: Unknown device 4c59
> > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr-
> > > Stepping- SERR- FastB2B-
> > >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=medium >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 0
> > >         Interrupt: pin A routed to IRQ 11
> > >         Region 4: I/O ports at e800 [size=32]
> > >
> > > 00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01)
> > > (prog-if 00 [UHCI])
> > >         Subsystem: Intel Corp.: Unknown device 4c59
> > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr-
> > > Stepping- SERR- FastB2B-
> > >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=medium >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 0
> > >         Interrupt: pin B routed to IRQ 11
> > >         Region 4: I/O ports at e880 [size=32]
> > >
> > > 00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01)
> > > (prog-if 00 [UHCI])
> > >         Subsystem: Intel Corp.: Unknown device 4c59
> > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr-
> > > Stepping- SERR- FastB2B-
> > >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=medium >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 0
> > >         Interrupt: pin C routed to IRQ 5
> > >         Region 4: I/O ports at ec00 [size=32]
> > >
> > > 00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01)
> > > (prog-if 20 [EHCI])
> > >         Subsystem: Intel Corp.: Unknown device 4c59
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr-
> > > Stepping- SERR+ FastB2B-
> > >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=medium >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 0
> > >         Interrupt: pin D routed to IRQ 9
> > >         Region 0: Memory at ffa7fc00 (32-bit,
> >
> > non-prefetchable) [size=1K]
> >
> > >         Capabilities: [50] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >         Capabilities: [58] #0a [2080]
> > >
> > > 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81)
> > > (prog-if 00 [Normal decode])
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr-
> > > Stepping- SERR+ FastB2B-
> > >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=fast >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR+
> > >         Latency: 0
> > >         Bus: primary=00, secondary=01, subordinate=01,
> >
> > sec-latency=32
> >
> > >         I/O behind bridge: 0000d000-0000dfff
> > >         Memory behind bridge: ff800000-ff8fffff
> > >         Prefetchable memory behind bridge: e6a00000-e6afffff
> > >         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort-
> > >Reset- FastB2B-
> > >
> > > 00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> > > ParErr-
> > > Stepping- SERR+ FastB2B-
> > >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=medium >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 0
> > >
> > > 00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01)
> > > (prog-if 8a [Master SecP PriP])
> > >         Subsystem: Intel Corp.: Unknown device 4c59
> > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr-
> > > Stepping- SERR- FastB2B-
> > >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=medium >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 0
> > >         Interrupt: pin A routed to IRQ 5
> > >         Region 0: I/O ports at <unassigned> [size=8]
> > >         Region 1: I/O ports at <unassigned> [size=4]
> > >         Region 2: I/O ports at <unassigned> [size=8]
> > >         Region 3: I/O ports at <unassigned> [size=4]
> > >         Region 4: I/O ports at ffa0 [size=16]
> > >         Region 5: Memory at 1ff00000 (32-bit,
> >
> > non-prefetchable) [disabled]
> >
> > > [size=1K]
> > >
> > > 00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
> > >         Subsystem: Intel Corp.: Unknown device 4c59
> > >         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> > > ParErr-
> > > Stepping- SERR- FastB2B-
> > >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=medium >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Interrupt: pin B routed to IRQ 11
> > >         Region 4: I/O ports at e000 [size=32]
> > >
> > > 00:1f.5 Multimedia audio controller: Intel Corp.: Unknown
> >
> > device 24c5
> >
> > > (rev
> > > 01) Subsystem: Intel Corp.: Unknown device 0302
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> >
> > VGASnoop- ParErr-
> >
> > > Stepping- SERR- FastB2B-
> > >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=medium >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 0
> > >         Interrupt: pin B routed to IRQ 11
> > >         Region 0: I/O ports at e400 [size=256]
> > >         Region 1: I/O ports at e080 [size=64]
> > >         Region 2: Memory at ffa7f800 (32-bit,
> >
> > non-prefetchable) [size=512]
> >
> > >         Region 3: Memory at ffa7f400 (32-bit,
> >
> > non-prefetchable) [size=256]
> >
> > >         Capabilities: [50] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >
> > > 01:00.0 Unknown mass storage controller: Promise Technology, Inc.
> > > 20268 (rev 02) (prog-if 85)
> > >         Subsystem: Promise Technology, Inc. Ultra100TX2
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr-
> > > Stepping- SERR- FastB2B-
> > >         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
> >
> > DEVSEL=slow >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 32 (1000ns min, 4500ns max), cache line size 08
> > >         Interrupt: pin A routed to IRQ 10
> > >         Region 0: I/O ports at dc00 [size=8]
> > >         Region 1: I/O ports at d880 [size=4]
> > >         Region 2: I/O ports at d800 [size=8]
> > >         Region 3: I/O ports at d480 [size=4]
> > >         Region 4: I/O ports at d400 [size=16]
> > >         Region 5: Memory at ff8fc000 (32-bit,
> >
> > non-prefetchable) [size=16K]
> >
> > >         Expansion ROM at ff8f8000 [disabled] [size=16K]
> > >         Capabilities: [60] Power Management version 1
> > >                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
> > > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >
> > > 01:01.0 Unknown mass storage controller: Promise Technology, Inc.
> > > 20268 (rev 02) (prog-if 85)
> > >         Subsystem: Promise Technology, Inc. Ultra100TX2
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr-
> > > Stepping- SERR- FastB2B-
> > >         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
> >
> > DEVSEL=slow >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 32 (1000ns min, 4500ns max), cache line size 08
> > >         Interrupt: pin A routed to IRQ 11
> > >         Region 0: I/O ports at d080 [size=8]
> > >         Region 1: I/O ports at d000 [size=4]
> > >         Region 2: I/O ports at df00 [size=8]
> > >         Region 3: I/O ports at de80 [size=4]
> > >         Region 4: I/O ports at de00 [size=16]
> > >         Region 5: Memory at ff8f4000 (32-bit,
> >
> > non-prefetchable) [size=16K]
> >
> > >         Expansion ROM at ff8f0000 [disabled] [size=16K]
> > >         Capabilities: [60] Power Management version 1
> > >                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
> > > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >
> > > 01:02.0 Ethernet controller: Intel Corp.: Unknown device
> >
> > 100e (rev 02)
> >
> > >         Subsystem: Intel Corp.: Unknown device 002e
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > > ParErr-
> > > Stepping- SERR+ FastB2B-
> > >         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
> >
> > DEVSEL=medium >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 32 (63750ns min), cache line size 08
> > >         Interrupt: pin A routed to IRQ 5
> > >         Region 0: Memory at ff8c0000 (32-bit,
> >
> > non-prefetchable) [size=128K]
> >
> > >         Region 1: Memory at ff8a0000 (32-bit,
> >
> > non-prefetchable) [size=128K]
> >
> > >         Region 2: I/O ports at dd80 [size=64]
> > >         Expansion ROM at ff880000 [disabled] [size=128K]
> > >         Capabilities: [dc] Power Management version 2
> > >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
> > >         Capabilities: [e4] PCI-X non-bridge device.
> > >                 Command: DPERE- ERO+ RBC=0 OST=0
> > >                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> > > DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
> > >         Capabilities: [f0] Message Signalled Interrupts:
> >
> > 64bit+ Queue=0/0
> >
> > > Enable-
> > >                 Address: 0000000000000000  Data: 0000
> > >
> > > 01:08.0 Ethernet controller: Intel Corp.: Unknown device
> >
> > 1039 (rev 81)
> >
> > >         Subsystem: Intel Corp.: Unknown device 3013
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > > ParErr-
> > > Stepping- SERR+ FastB2B-
> > >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
> >
> > DEVSEL=medium >TAbort-
> >
> > > <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 32 (2000ns min, 14000ns max), cache line size 08
> > >         Interrupt: pin A routed to IRQ 11
> > >         Region 0: Memory at ff8ef000 (32-bit,
> >
> > non-prefetchable) [size=4K]
> >
> > >         Region 1: I/O ports at dd00 [size=64]
> > >         Capabilities: [dc] Power Management version 2
> > >                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> > > PME(D0+,D1+,D2+,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> >
> > --
> > Roy Sigurd Karlsbakk, Datavaktmester
> > ProntoTV AS - http://www.pronto.tv/
> > Tel: +47 9801 3356
> >
> > Computers are like air conditioners.
> > They stop working when you open Windows.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at
>
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

