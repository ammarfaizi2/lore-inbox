Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTLKWvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 17:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbTLKWvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 17:51:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:35039 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264392AbTLKWvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 17:51:23 -0500
Date: Thu, 11 Dec 2003 14:43:12 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Dan Creswell <dan@dcrdev.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: E7505 has only 2 APIC's but Linux says 3
Message-Id: <20031211144312.5662904f.rddunlap@osdl.org>
In-Reply-To: <3FD5C2FD.4080609@dcrdev.demon.co.uk>
References: <3FD5C2FD.4080609@dcrdev.demon.co.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Dec 2003 12:41:33 +0000 Dan Creswell <dan@dcrdev.demon.co.uk> wrote:

| Hi,
| 
| According to Intel's spec. for the E7505 chipset, there are only two 
| APICs mapped at 0xFEC00000 and 0xFEC80000.
| 
| On boot, however, both kernel's 2.4 and 2.6 report three APIC's (see 
| dmesg snippet below).  That third memory address (oxFEC80100) looks odd 
| to me.
| 
| Could the MPTable be incorrect thus leading Linux astray or could it be 
| a kernel problem?
| 
| Could my system's APIC's end up being mis-configured/mis-used as a result?

Is your system expierie^W having problems that you think might be
attributable to interrupt routing?

I don't see a problem.  The 82801xx chipset has 1 IO APIC and
the P64H2 controller has 2 more IO APICs, with configurable addreses
like you listed.



| Output from dmesg:
| 
| Intel MultiProcessor Specification v1.4
|     Virtual Wire compatibility mode.
| OEM ID:   Product ID: PLACER CRB   APIC at: 0xFEE00000
| I/O APIC #2 Version 32 at 0xFEC00000.
| I/O APIC #3 Version 32 at 0xFEC80000.
| I/O APIC #4 Version 32 at 0xFEC80100.
| Enabling APIC mode:  Flat.  Using 3 I/O APICs
| 
| Output from lspci:
| 
| 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 82) 
| (prog-if 00 [Normal decode])
|         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
| ParErr+ Stepping- SERR+ FastB2B-
|         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
|         Latency: 0
|         Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
|         I/O behind bridge: 00003000-00003fff
|         Memory behind bridge: da200000-da2fffff
|         Prefetchable memory behind bridge: fff00000-000fffff
|         BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
|  
| 00:1f.0 ISA bridge: Intel Corp. 82801DB LPC Interface Controller (rev 02)
|         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
| ParErr+ Stepping- SERR+ FastB2B-
|         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
|         Latency: 0
|  
| 02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 
| [IO(X)-APIC])
|         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
| ParErr+ Stepping- SERR+ FastB2B-
|         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
|         Latency: 0
|         Region 0: Memory at da000000 (32-bit, non-prefetchable) [size=4K]
|         Capabilities: [50] PCI-X non-bridge device.
|                 Command: DPERE- ERO- RBC=0 OST=0
|                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, 
| DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

| 02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) 
| (prog-if 00 [Normal decode])
|         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
| ParErr+ Stepping- SERR+ FastB2B-
|         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
|         Latency: 248, cache line size 20
|         Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
|         I/O behind bridge: 00002000-00002fff
|         Memory behind bridge: da100000-da1fffff
|         Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
|         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
|         Capabilities: [50] PCI-X non-bridge device.
|                 Command: DPERE+ ERO+ RBC=0 OST=0
|                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, 
| DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

| 02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 
| [IO(X)-APIC])
|         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
| ParErr+ Stepping- SERR+ FastB2B-
|         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
|         Latency: 0
|         Region 0: Memory at da001000 (32-bit, non-prefetchable) [size=4K]
|         Capabilities: [50] PCI-X non-bridge device.
|                 Command: DPERE- ERO- RBC=0 OST=0
|                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, 
| DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

| 02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) 
| (prog-if 00 [Normal decode])
|         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
| ParErr+ Stepping- SERR+ FastB2B-
|         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
|         Latency: 248, cache line size 20
|         Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
|         I/O behind bridge: 0000f000-00000fff
|         Memory behind bridge: fff00000-000fffff
|         Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
|         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
|         Capabilities: [50] PCI-X non-bridge device.
|                 Command: DPERE+ ERO+ RBC=0 OST=4
|                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, 
| DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-


--
~Randy
MOTD:  Always include version info.
