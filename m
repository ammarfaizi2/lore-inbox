Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131865AbQL3Fq1>; Sat, 30 Dec 2000 00:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132708AbQL3FqS>; Sat, 30 Dec 2000 00:46:18 -0500
Received: from entropy.muc.muohio.edu ([134.53.213.10]:1154 "EHLO
	entropy.muc.muohio.edu") by vger.kernel.org with ESMTP
	id <S131865AbQL3FqL>; Sat, 30 Dec 2000 00:46:11 -0500
Date: Sat, 30 Dec 2000 00:15:44 -0500 (EST)
From: George <greerga@entropy.muc.muohio.edu>
To: <linux-kernel@vger.kernel.org>
Subject: bttv in 2.2.18 worse than 2.2.17
Message-ID: <Pine.LNX.4.30.0012300009240.23919-100000@entropy.muc.muohio.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With 2.2.18, I've noticed a few problems with my Hauppauge Win/TV 401
(bt878) card not present in 2.2.17 (using XawTV 2.46 in overlay mode for
both):

1) Switching channels causes a brief flicker where the picture shrinks to
1/4 the size in the upper left corner, then changes to the next channel.

2) JPEG captures cause a purple and green fuzzy screen to briefly flash in
place of the television image.

3) The first time I run XawTV after loading the module, I get no picture
until I change Television -> Composite -> Television.  Subsequent runs are
fine.

Video card is an S3 Virge DX.

00:14.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Hauppage computer works Inc.: Unknown device 13eb
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 min, 40 max, 32 set
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e4001000 (32-bit, prefetchable)

00:14.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Hauppage computer works Inc.: Unknown device 13eb
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 4 min, 255 max, 32 set
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e4002000 (32-bit, prefetchable)

00:11.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)
(prog-if 00 [VGA])
        Subsystem: S3 Inc. ViRGE/DX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 4 min, 255 max, 32 set
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at e0000000 (32-bit, non-prefetchable)

Two Pentium 233MMX, Tyan Tomcat IV SMP motherboard (Triton HX chipset)

Just changing the array value back to 3 that was flipped 3->4 in the 2.2.18
patch doesn't do anything by itself.

-George Greer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
