Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSFANri>; Sat, 1 Jun 2002 09:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317020AbSFANrh>; Sat, 1 Jun 2002 09:47:37 -0400
Received: from mout0.freenet.de ([194.97.50.131]:9172 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S317017AbSFANrg>;
	Sat, 1 Jun 2002 09:47:36 -0400
Date: Sat, 1 Jun 2002 15:46:49 +0200
From: "Axel H. Siebenwirth" <axel@hh59.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.19] swsusp report
Message-ID: <20020601134649.GA373@prester>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

so far swsusp works me but with minor faults and under certain cirumstances.

1) X server and GDM is running: when suspending everything works,
	but when I am logged in to X/Gnome suspend does not work.
	Usually after "echo 4 > /proc/acpi/sleep" the screen blanks and
	comes back after two or three seconds and then suspends. But when I
	am logged in into X/Gnome, the screen blanks, comes back and nothing
	happens afterwards. Only Alt-SysReq-B works.

2) When successfully suspending and resuming without being logged in into X,
	my console is a little strange because I use 80x30 text mode and
	after resume the lower 5 lines, so the difference between 80x30 and 
	80x25, are not used, there is text left from before suspend but
	after resume, the cursor is alway at maximum line 25 and not line
	30.

3) Instead of poweroff after suspend my computer reboots.

I hope I expressed my problems not to hard to understand.


Best regards,
Axel Siebenwirth


Software and hardware setup:

* XFree86 Version 4.2.99.1 / X Window System
	(protocol Version 11, revision 0, vendor release 6600)
* Thread model: single
	gcc version 3.1.1 20020601 (prerelease)
*
00:01.0 VGA compatible controller: Intel Corporation 82810 CGC [Chipset
Graphics Controller] (rev 03) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at d4000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
[Master])
        Subsystem: Intel Corporation 82801AA IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at f000 [size=16]

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

* 
 BIOS-e820: 0000000007ef0000 - 0000000007ef3000 (ACPI NVS)
 BIOS-e820: 0000000007ef3000 - 0000000007f00000 (ACPI data)
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 GBT                        ) @ 0x000f6a00
ACPI: RSDT (v001 GBT    AWRDACPI 16944.11825) @ 0x07ef3000
ACPI: FADT (v001 GBT    AWRDACPI 16944.11825) @ 0x07ef3040
ACPI: MADT not present
PCI: Invalid ACPI-PCI IRQ routing table
ACPI: Bus Driver revision 20020404
ACPI: Core Subsystem revision 20020403
 tbxface-0101 [03] Acpi_load_tables      : ACPI Tables successfully loaded
ACPI Namespace successfully loaded at root c0316398
evxfevnt-0080 [04] Acpi_enable           : Transition to ACPI mode
successful
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
Software suspend => we can do S4.<6>ACPI: PCI Root Bridge [PCI0]
(00:00:00.00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
pci_root-0490 [05] acpi_pci_root_bind    : Device 00:00:1f.03 not present in
PCI namespace
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
ACPI: Thermal Zone [THRM] (41 C)
