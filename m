Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317860AbSGZREc>; Fri, 26 Jul 2002 13:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317861AbSGZREc>; Fri, 26 Jul 2002 13:04:32 -0400
Received: from web20709.mail.yahoo.com ([216.136.226.182]:2311 "HELO
	web20709.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317860AbSGZREb>; Fri, 26 Jul 2002 13:04:31 -0400
Message-ID: <20020726170747.227.qmail@web20709.mail.yahoo.com>
Date: Fri, 26 Jul 2002 10:07:47 -0700 (PDT)
From: abhishek Sinha <aby_sinha@yahoo.com>
Subject: Re: Intel Plumas Chipset and 100Mhz PCI cards
To: linux-kernel@vger.kernel.org
Cc: christopher.leech@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi/

Both the PCI slots are running the same controller.

The following is the output from the lspci -vv command
for the ethernet controllers

02:01.0 Ethernet controller: Intel Corp. 82544EI
Gigabit Ethernet Controller (rev 02)
        Subsystem: Intel Corp. PRO/1000 XF Server
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at fc220000 (32-bit,
non-prefetchable) [size=128K]
        Region 1: Memory at fc200000 (32-bit,
non-prefetchable) [size=128K]
        Region 2: I/O ports at 7000 [size=32]
        Expansion ROM at <unassigned> [disabled]
[size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2-
AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1
PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit-
133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0,
DMCRS=0, RSCEM-
        Capabilities: [f0] Message Signalled
Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

02:02.0 Ethernet controller: Intel Corp. 82544EI
Gigabit Ethernet Controller (rev 02)
        Subsystem: Intel Corp. PRO/1000 XF Server
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at fc260000 (32-bit,
non-prefetchable) [size=128K]
        Region 1: Memory at fc240000 (32-bit,
non-prefetchable) [size=128K]
        Region 2: I/O ports at 7020 [size=32]
        Expansion ROM at <unassigned> [disabled]
[size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2-
AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1
PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit-
133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0,
DMCRS=0, RSCEM-
        Capabilities: [f0] Message Signalled
Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000


As you can see the capabilites does list PCI-X. I am
currently running BIOS version 1.10 on the
machine.Intel has released a new BIOS 1.12 ;I went
through the release notes and couldnt find anything
which would help.

Any ideas /suggestions.

Please cc: me your replies ; I am not on the Linux
-kernel mailing list.


Thanks
Abhishek


>Not only is the bus running at 66 MHz, it's using the
>PCI protocol not
>?PCI-X. Is there a card in the other PCI-X capable
>slot? I think they
>are on the same bus, so installing a PCI card there
>would bring both
>slots down to this speed. You should check the output
>of lspci -v and
>make sure all the devices on bus 2 have the PCI-X
>capability.

>- Chris Leech

> PCI_Bus_Type PCI
> PCI_Bus_Speed 66MHz
> PCI_Bus_Width 64-bit

- 

__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com
