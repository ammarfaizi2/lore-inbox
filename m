Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131023AbRAJJ61>; Wed, 10 Jan 2001 04:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130356AbRAJJ6R>; Wed, 10 Jan 2001 04:58:17 -0500
Received: from zen.via.ecp.fr ([138.195.130.71]:9482 "HELO zen.via.ecp.fr")
	by vger.kernel.org with SMTP id <S131023AbRAJJ6D>;
	Wed, 10 Jan 2001 04:58:03 -0500
Date: Wed, 10 Jan 2001 10:57:50 +0100
From: Stéphane Borel <stef@via.ecp.fr>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Netfinity with 2.4.0
Message-ID: <20010110105750.B29666@via.ecp.fr>
Mail-Followup-To: Stéphane Borel <stef@via.ecp.fr>,
	Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20010110024744.A26255@via.ecp.fr> <3A5C2142.C119CE7C@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5C2142.C119CE7C@uow.edu.au>; from andrewm@uow.edu.au on Wed, Jan 10, 2001 at 07:45:54PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 07:45:54PM +1100, Andrew Morton wrote:
> "Stéphane Borel" wrote:
> > *On the 7100, the final kernel can't detect two pci card (3C980 and
> > ForeRunnerLE.
> 
> Can it detect other PCI devices?

The serveraid card is detected well.
 
> The output from `dmesg' and `lspci -vv' would be interesting.

part of dmseg :

    Setting commenced=1, go go go
    PCI: PCI BIOS revision 2.10 entry at 0xfd5cc, last bus=6
    PCI: Using configuration type 1
    PCI: Probing PCI hardware
    PCI: ServerWorks host bridge: secondary bus 01
    PCI: ServerWorks host bridge: secondary bus 00
    PCI->APIC IRQ transform: (B1,I1,P0) -> 20
    PCI->APIC IRQ transform: (B0,I5,P0) -> 16
    PCI->APIC IRQ transform: (B0,I15,P0) -> 26
    Linux NET4.0 for Linux 2.4
    Based upon Swansea University Computer Society NET3.039
    DMI 2.1 present.
    82 structures occupying 4232 bytes.
    DMI table at 0x000F944D.
    BIOS Vendor: IBM
    BIOS Version: -[MWE121AUS-1.04]-
    BIOS Release: 06/22/2000
    System Vendor: IBM.
    Product Name: Netfinity 7100 -[8666]-.
    Version 1-jumper on pins 2-3.
    Serial Number 550236H.
    Board Vendor: IBM.
    Board Name: ,.
    Board Version: ,.
    Asset Tag: Changing the position of this jumper does not affect .
    Starting kswapd v1.8
    pty: 256 Unix98 ptys configured
    Uniform Multi-Platform E-IDE driver Revision: 6.31
    ide: Assuming 33MHz system bus speed for PIO modes; override with
    idebus=xx
    ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
    ServerWorks OSB4: chipset revision 0
    ServerWorks OSB4: not 100% native mode: will probe irqs later
        ide0: BM-DMA at 0x0840-0x0847, BIOS settings: hda:DMA, hdb:DMA
        ide1: BM-DMA at 0x0848-0x084f, BIOS settings: hdc:pio, hdd:pio
    hda: LTN485S, ATAPI CDROM drive
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    hda: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
    Uniform CD-ROM driver Revision: 3.12
    Floppy drive(s): fd0 is 1.44M
    FDC 0 is a National Semiconductor PC87306
    Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
    SERIAL_PCI enabled
    ttyS00 at 0x03f8 (irq = 4) is a 16550A
    ttyS01 at 0x02f8 (irq = 3) is a 16550A
    pcnet32_probe_pci: found device 0x001022.0x002000
        ioaddr=0x002000  resource_flags=0x000101
    eth0: PCnet/FAST III 79C975 at 0x2000, 00 06 29 55 43 74
    pcnet32: pcnet32_private lp=f7bfc000 lp_dma_addr=0x37bfc000 assigned IRQ
    16.
    pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de
    SCSI subsystem driver Revision: 1.00
    scsi0 : IBM PCI ServeRAID 4.20.20  <ServeRAID 4M>

lspci -vv

    00:00.0 Host bridge: Relience Computer CNB20HE (rev 21)
    	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
    ParErr- Stepping- SERR- FastB2B-
    	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
    <TAbort- <MAbort- >SERR- <PERR-
    
    00:00.1 Host bridge: Relience Computer CNB20HE (rev 01)
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
    ParErr+ Stepping- SERR+ FastB2B-
    	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
    <TAbort- <MAbort+ >SERR- <PERR-
    	Latency: 96 set, cache line size 08
    
    00:00.2 Host bridge: Relience Computer: Unknown device 0006
    	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
    ParErr+ Stepping- SERR+ FastB2B-
    	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
    <TAbort- <MAbort+ >SERR- <PERR-
    
    00:00.3 Host bridge: Relience Computer: Unknown device 0006
    	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
    ParErr+ Stepping- SERR+ FastB2B-
    	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
    <TAbort- <MAbort+ >SERR- <PERR-
    
    00:05.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
    LANCE] (rev 44)
    	Subsystem: IBM: Unknown device 2000
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
    ParErr+ Stepping- SERR+ FastB2B-
    	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
    <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 24 min, 24 max, 100 set
    	Interrupt: pin A routed to IRQ 16
    	Region 0: I/O ports at 2000 [size=32]
    	Region 1: Memory at febffc00 (32-bit, non-prefetchable)
    [size=32]
    	Expansion ROM at <unassigned> [disabled] [size=1M]
    	Capabilities: [40] Power Management version 2
    		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
    		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
    
    00:06.0 VGA compatible controller: S3 Inc. Trio 64 3D (rev 01) (prog-if
    00 [VGA])
    	Subsystem: IBM Integrated Trio3D
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
    ParErr- Stepping- SERR- FastB2B-
    	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
    <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 4 min, 255 max, 96 set
    	Region 0: Memory at f8000000 (32-bit, non-prefetchable)
    [size=64M]
    	Expansion ROM at <unassigned> [disabled] [size=64K]
    	Capabilities: [44] Power Management version 1
    		Flags: PMEClk- AuxPwr- DSI+ D1+ D2- PME-
    		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    
    00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 4f)
    	Subsystem: Relience Computer: Unknown device 0200
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
    ParErr+ Stepping- SERR+ FastB2B-
    	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
    <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 0 set
    
    00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if
    8a [Master SecP PriP])
    	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
    ParErr+ Stepping- SERR+ FastB2B-
    	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
    <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 100 set
    	Region 4: I/O ports at 0840 [size=16]
    
    00:0f.2 USB Controller: Relience Computer: Unknown device 0220 (rev 04)
    (prog-if 10 [OHCI])
    	Subsystem: Relience Computer: Unknown device 0220
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
    ParErr+ Stepping- SERR+ FastB2B-
    	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
    <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 80 max, 96 set, cache line size 08
    	Interrupt: pin A routed to IRQ 26
    	Region 0: Memory at febfe000 (32-bit, non-prefetchable)
    [size=4K]
    
    01:01.0 RAID bus controller: IBM: Unknown device 01bd
    	Subsystem: IBM: Unknown device 01be
    	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
    ParErr+ Stepping- SERR+ FastB2B-
    	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
    <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 96 set, cache line size 08
    	Interrupt: pin A routed to IRQ 20
    	Region 0: Memory at f4ffe000 (32-bit, prefetchable) [size=8K]
    	Expansion ROM at <unassigned> [disabled] [size=32K]


The network adapter found is an onboard chip ; we also have a 3com 3c980
and an atm adapter in the server, which give the following lines with
2.2.18 :

    02:03.0 Ethernet controller: 3Com Corporation: Unknown device 9805 (rev
    78)
    	Subsystem: 3Com Corporation: Unknown device 1000
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
    ParErr+ Stepping- SERR+ FastB2B-
    	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
    <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 10 min, 10 max, 96 set, cache line size 08
    	Interrupt: pin A routed to IRQ 22
    	Region 0: I/O ports at 2080
    	Region 1: Memory at f6fffc00 (32-bit, non-prefetchable)
    	Capabilities: [dc] Power Management version 2
    		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
    		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
    
    02:04.0 ATM network controller: Integrated Device Tech IDT77211 ATM
    Adapter (rev 03)
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
    ParErr+ Stepping- SERR+ FastB2B-
    	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
    <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 5 min, 5 max, 96 set
    	Interrupt: pin A routed to IRQ 23
    	Region 0: I/O ports at 2100
    	Region 1: Memory at f6ffe000 (32-bit, non-prefetchable)
.

-- 
Stef
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
