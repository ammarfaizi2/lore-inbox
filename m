Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbVIBVVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbVIBVVe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbVIBVVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:21:33 -0400
Received: from dns.toxicfilms.tv ([150.254.220.184]:45282 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S1161042AbVIBVVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:21:33 -0400
X-QSS-TOXIC-Mail-From: solt2@dns.toxicfilms.tv via dns
X-QSS-TOXIC: 1.25st (Clear:RC:1(213.238.103.113):. Processed in 0.100395 secs Process 6070)
Date: Fri, 2 Sep 2005 23:21:39 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1957123248.20050902232139@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: agp_backend_initialize() failed on ServerWorks CNB20LE
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On a server with ServerWorks CNB20LE and CONFIG_AGP_SWORKS enabled
I get these upon bootup:
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart-serverworks: probe of 0000:00:00.0 failed with error -22
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart-serverworks: probe of 0000:00:00.1 failed with error -22

lspci -vvv shows (i skipped the IDE, ISA and NIC lines):
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08

00:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (rev 7a) (prog-if 00 [VGA])
        Subsystem: Intel Corporation: Unknown device 4756
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at 5000 [size=256]
        Region 2: Memory at fb100000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 50000000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


The only problems I have that *may* be related to these messages is the
fact that when I boot into X and try to switch to a text console, the
screen gets garbled and freezes, the server works fine besides the
screen throwing trash at me.
It is not a big issue, but maybe anyone would like to know.
Or enlighten me if it

Regards,
Maciej


