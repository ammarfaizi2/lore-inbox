Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266305AbUG0HqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266305AbUG0HqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUG0HqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:46:10 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:33040 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S266305AbUG0HqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:46:03 -0400
Date: Tue, 27 Jul 2004 10:45:57 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Gerard Roudier <groudier@free.fr>, linux-kernel@vger.kernel.org
Subject: Sym53C896: CACHE INCORRECTLY CONFIGURED
Message-ID: <Pine.LNX.4.58.0407271038530.13593@ondatra.tartu-labor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a 53c896 dual channel 64-bit PCI card (Compaq series EOB003). Tried
it in x86 (i815 mainboard) and Sun Ultra 5 (both with 32-bit PCI slots).
Both errored out basically the same way (this is from the PC, Linux
2.6.8-rc2):

ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 11 (level, low) -> IRQ 11
sym0: <896> rev 0x5 at pci 0000:01:09.0 irq 11
sym0: using 64 bit DMA addressing
sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
CACHE TEST FAILED: timeout.
sym0: CACHE INCORRECTLY CONFIGURED.
sym0: giving up ...
ACPI: PCI interrupt 0000:01:09.1[B] -> GSI 9 (level, low) -> IRQ 9
sym0: <896> rev 0x5 at pci 0000:01:09.1 irq 9
sym0: using 64 bit DMA addressing
sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
CACHE TEST FAILED: timeout.
sym0: CACHE INCORRECTLY CONFIGURED.
sym0: giving up ...

Is the card toast or can I tweak something somewhere?

0000:01:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 05)
        Subsystem: Compaq Computer Corporation: Unknown device 6004
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at c400 [size=256]
        Region 1: Memory at ff8ff800 (64-bit, non-prefetchable) [size=1K]
        Region 3: Memory at ff8fa000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 00 10 0b 00 13 01 10 82 05 00 00 01 08 20 80 00
10: 01 c4 00 00 04 f8 8f ff 00 00 00 00 04 a0 8f ff
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 04 60
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 11 40
40: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:09.1 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 05)
        Subsystem: Compaq Computer Corporation: Unknown device 6004
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at c800 [size=256]
        Region 1: Memory at ff8ffc00 (64-bit, non-prefetchable) [size=1K]
        Region 3: Memory at ff8fc000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 00 10 0b 00 13 01 10 82 05 00 00 01 08 20 80 00
10: 01 c8 00 00 04 fc 8f ff 00 00 00 00 04 c0 8f ff
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 04 60
30: 00 00 00 00 40 00 00 00 00 00 00 00 09 02 11 40
40: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


-- 
Meelis Roos
