Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWCFM21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWCFM21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 07:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWCFM21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 07:28:27 -0500
Received: from c-14c1e455.43-25-64736c10.cust.bredbandsbolaget.se ([85.228.193.20]:3013
	"HELO styx.klippanlan.net") by vger.kernel.org with SMTP
	id S1750931AbWCFM20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 07:28:26 -0500
Message-ID: <001501c64119$6d8e7bc0$072011ac@majestix>
From: "PaNiC" <panic@klippanlan.net>
To: <linux-kernel@vger.kernel.org>
Subject: Problem: NIC transmit timeouts
Date: Mon, 6 Mar 2006 13:28:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. The problem is that the outbound interface in a Sun Enterprise 250 
running maquerade gets transmit timeouts frequently.

2. I get the error "NETDEV WATCHDOG: eth0: transmit timed out" and a 
couple of seconds later the     interface jumps back up again. This 
seems only to happen after masquerading and packet forwarding is 
activated. When i have momentary traffic going in or out (web browsing 
for instance) it happens mostly. It does not happen as often when 
downloading large files, but will surely happen with somewhat heavy 
traffic going in and out for instance while talking on Skype. I tried 
reversing the interfaces so that the outbound would be the inbound and 
vice versa, mostly to exclude a hardware problem. This moved the 
timeouts again to the outbound interface. This was while using kernel 
2.4.27. The same problem appears with 2.6.8 and 2.6.15.4 which i am 
currently using. Though not as often as with 2.4.27. I have googled 
immensely but have only found people with the same problem, no 
solutions.

4. Linux version 2.6.15.4 (root@kronos) (gcc version 3.3.5 (Debian 
1:3.3.5-13))

7. Sun Enterprise 250, UltrasparcII-400, Debian 3.1,

7.1
Linux kronos 2.6.15.4 #2 SMP Mon Feb 27 17:48:33 CET 2006 sparc64 
GNU/Linux

    Gnu C                  3.3.5
    Gnu make               3.80
    binutils               2.15
    util-linux             2.12p
    mount                  2.12p
    module-init-tools      3.2-pre1
    e2fsprogs              1.37
    reiserfsprogs          line
    reiser4progs           line
    PPP                    2.4.3
    Linux C Library        2.3.2
    Dynamic linker (ldd)   2.3.2
    Procps                 3.2.1
    Net-tools              1.60
    Kbd                    83:
    Sh-utils               5.2.1
    Modules Loaded         isofs

7.2
    cpu             : TI UltraSparc II  (BlackBird)
    fpu             : UltraSparc II integrated FPU
    promlib         : Version 3 Revision 16
    prom            : 3.16.1
    type            : sun4u
    ncpus probed    : 1
    ncpus active    : 1
    D$ parity tl1   : 0
    I$ parity tl1   : 0
    Cpu0Bogo        : 798.72
    Cpu0ClkTck      : 0000000017d78400
    MMU Type        : Spitfire
    State:
    CPU0:           online

7.3
    isofs 34376 0 - Live 0x0000000010000000

7.4
    ioports:
    1fe02000000-1fe0200ffff : PSYCHO0 PBMA
    1fe02010000-1fe0201ffff : PSYCHO0 PBMB
    1fe02011000-1fe020110ff : 0001:00:03.0
    1fe02011000-1fe020110ff : sym53c8xx
    1fe02011400-1fe020114ff : 0001:00:03.1
    1fe02011400-1fe020114ff : sym53c8xx

    iomem:
    1ff00000000-1ff7fffffff : PSYCHO0 PBMA
  1ff000a0000-1ff000bffff : Video RAM area
  1ff000c0000-1ff000c7fff : Video ROM
  1ff000f0000-1ff000fffff : System ROM
1ff80000000-1ffffffffff : PSYCHO0 PBMB
  1ff800a0000-1ff800bffff : Video RAM area
  1ff800c0000-1ff800c7fff : Video ROM
  1ff800f0000-1ff800fffff : System ROM
  1ff81000000-1ff81ffffff : 0001:01:00.0
  1ff82000000-1ff827fffff : 0001:01:00.0
  1ff83000000-1ff83ffffff : 0001:01:00.0
  1ff84000000-1ff84007fff : 0001:01:00.1
    1ff84000000-1ff84007fff : sunhme
  1ff85000000-1ff85ffffff : 0001:01:01.0
  1ff86000000-1ff867fffff : 0001:01:01.0
  1ff87000000-1ff87ffffff : 0001:01:01.0
  1ff88000000-1ff88007fff : 0001:01:01.1
    1ff88000000-1ff88007fff : sunhme
  1ff89000000-1ff89ffffff : 0001:01:02.0
  1ff8a000000-1ff8a7fffff : 0001:01:02.0
  1ff8b000000-1ff8bffffff : 0001:01:02.0
  1ff8c000000-1ff8c007fff : 0001:01:02.1
    1ff8c000000-1ff8c007fff : sunhme
  1ff8d000000-1ff8dffffff : 0001:00:01.0
  1ff8e000000-1ff8effffff : 0001:00:01.1
  1ff8f000000-1ff8fffffff : 0001:01:00.1
  1ff90000000-1ff90007fff : 0001:01:03.1
    1ff90000000-1ff90007fff : sunhme
  1ff90100000-1ff90107fff : 0001:00:01.1
    1ff90100000-1ff90107fff : sunhme
  1ff90108000-1ff901080ff : 0001:00:03.0
    1ff90108000-1ff901080ff : sym53c8xx
  1ff9010a000-1ff9010afff : 0001:00:03.0
    1ff9010a000-1ff9010afff : sym53c8xx
  1ff9010c000-1ff9010c0ff : 0001:00:03.1
    1ff9010c000-1ff9010c0ff : sym53c8xx
  1ff9010e000-1ff9010efff : 0001:00:03.1
    1ff9010e000-1ff9010efff : sym53c8xx
  1ff91000000-1ff91ffffff : 0001:01:01.1
  1ff92000000-1ff92ffffff : 0001:01:02.1
  1ff93000000-1ff93ffffff : 0001:01:03.1
  1fff0000000-1fff0ffffff : 0001:00:01.0
    1fff0000000-1fff00fffff : flashprom
  1fff1000000-1fff17fffff : 0001:00:01.0
    1fff1000000-1fff1001fff : eeprom
    1fff1200000-1fff120007f : se
    1fff1300398-1fff1300399 : ecpp
    1fff13043bc-1fff13043cb : ecpp
    1fff13062f8-1fff13062ff : su
    1fff13083f8-1fff13083ff : su
    1fff1400000-1fff140007f : se
    1fff1500000-1fff1500007 : sc
    1fff1504000-1fff1504002 : SUNW,pll
    1fff1600000-1fff1600003 : SUNW,envctrltwo
    1fff1700000-1fff170000f : ecpp
    1fff1724000-1fff1724003 : power
    1fff1726000-1fff1726003 : auxio
    1fff1728000-1fff1728003 : auxio
    1fff172a000-1fff172a003 : auxio
    1fff172c000-1fff172c003 : auxio
    1fff172f000-1fff172f003 : auxio

7.5
    0000:80:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI 
Bus Module
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64

0001:00:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus 
Module
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64

0001:00:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 (2500ns min, 6250ns max), Cache Line Size: 0x10 (64 
bytes)
        Region 0: Memory at 000001fff0000000 (32-bit, non-prefetchable) 
[size=16M]
        Region 1: Memory at 000001fff1000000 (32-bit, non-prefetchable) 
[size=8M]
        Expansion ROM at 000000008d000000 [disabled] [size=16M]

0001:00:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy 
Meal (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 (2500ns min, 1250ns max), Cache Line Size: 0x10 (64 
bytes)
        Interrupt: pin ? routed to IRQ 8038560
        Region 0: Memory at 000001ff90100000 (32-bit, non-prefetchable) 
[size=32K]
        Expansion ROM at 000000008e000000 [disabled] [size=16M]

0001:00:02.0 PCI bridge: Digital Equipment Corporation DECchip 21153 
(rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00001000-00000fff
        Memory behind bridge: 00100000-100fffff
        Prefetchable memory behind bridge: 
fffffffffff00000-0000000000000000
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+

0001:00:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 
(rev 14)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 17 (4250ns min, 16000ns max), Cache Line Size: 0x10 (64 
bytes)
        Interrupt: pin A routed to IRQ 8038528
        Region 0: I/O ports at 2011000 [size=256]
        Region 1: Memory at 000001ff90108000 (32-bit, non-prefetchable) 
[size=256]
        Region 2: Memory at 000001ff9010a000 (32-bit, non-prefetchable) 
[size=4K]

0001:00:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 
(rev 14)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 17 (4250ns min, 16000ns max), Cache Line Size: 0x10 (64 
bytes)
        Interrupt: pin B routed to IRQ 8038720
        Region 0: I/O ports at 2011400 [size=256]
        Region 1: Memory at 000001ff9010c000 (32-bit, non-prefetchable) 
[size=256]
        Region 2: Memory at 000001ff9010e000 (32-bit, non-prefetchable) 
[size=4K]

0001:01:00.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 (2500ns min, 6250ns max), Cache Line Size: 0x10 (64 
bytes)
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 000001ff81000000 (32-bit, non-prefetchable) 
[size=16M]
        Region 1: Memory at 000001ff82000000 (32-bit, non-prefetchable) 
[size=8M]
        Expansion ROM at 0000000083000000 [disabled] [size=16M]

0001:01:00.1 Ethernet controller: Sun Microsystems Computer Corp. Happy 
Meal (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 (2500ns min, 1250ns max), Cache Line Size: 0x10 (64 
bytes)
        Interrupt: pin B routed to IRQ 8038048
        Region 0: Memory at 000001ff84000000 (32-bit, non-prefetchable) 
[size=32K]
        Expansion ROM at 000000008f000000 [disabled] [size=16M]

0001:01:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 (2500ns min, 6250ns max), Cache Line Size: 0x10 (64 
bytes)
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 000001ff85000000 (32-bit, non-prefetchable) 
[size=16M]
        Region 1: Memory at 000001ff86000000 (32-bit, non-prefetchable) 
[size=8M]
        Expansion ROM at 0000000087000000 [disabled] [size=16M]

0001:01:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy 
Meal (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 (2500ns min, 1250ns max), Cache Line Size: 0x10 (64 
bytes)
        Interrupt: pin B routed to IRQ 8038080
        Region 0: Memory at 000001ff88000000 (32-bit, non-prefetchable) 
[size=32K]
        Expansion ROM at 0000000091000000 [disabled] [size=16M]

0001:01:02.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 (2500ns min, 6250ns max), Cache Line Size: 0x10 (64 
bytes)
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 000001ff89000000 (32-bit, non-prefetchable) 
[size=16M]
        Region 1: Memory at 000001ff8a000000 (32-bit, non-prefetchable) 
[size=8M]
        Expansion ROM at 000000008b000000 [disabled] [size=16M]

0001:01:02.1 Ethernet controller: Sun Microsystems Computer Corp. Happy 
Meal (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 (2500ns min, 1250ns max), Cache Line Size: 0x10 (64 
bytes)
        Interrupt: pin B routed to IRQ 8038112
        Region 0: Memory at 000001ff8c000000 (32-bit, non-prefetchable) 
[size=32K]
        Expansion ROM at 0000000092000000 [disabled] [size=16M]

0001:01:03.1 Ethernet controller: Sun Microsystems Computer Corp. Happy 
Meal (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 (2500ns min, 1250ns max), Cache Line Size: 0x10 (64 
bytes)
        Interrupt: pin B routed to IRQ 8038016
        Region 0: Memory at 000001ff90000000 (32-bit, non-prefetchable) 
[size=32K]
        Expansion ROM at 0000000093000000 [disabled] [size=16M]

7.6
    Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST318203LSUN18G  Rev: 034A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: PIONEER  Model: CD-ROM DR-U16S   Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 09 Lun: 00
  Vendor: IBM-PCCO Model: DDRS-39130Y   !# Rev: S97B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 10 Lun: 00
  Vendor: IBM-PCCO Model: DDRS-39130Y   !# Rev: S97B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 11 Lun: 00
  Vendor: IBM-PCCO Model: DDRS-39130Y   !# Rev: S97B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 12 Lun: 00
  Vendor: IBM-PCCO Model: DDRS-39130Y   !# Rev: S97B
  Type:   Direct-Access                    ANSI SCSI revision: 02

7.7 Interfaces are a Sun Happy Meal and a Sun quad interface.

I will be thankful for any light on this. If i can do anything to help, 
i will.
Thanks for your time.

Best regards
Jonas Bengtsson 


