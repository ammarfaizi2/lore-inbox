Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSLQBl0>; Mon, 16 Dec 2002 20:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSLQBl0>; Mon, 16 Dec 2002 20:41:26 -0500
Received: from services.cam.org ([198.73.180.252]:16629 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261640AbSLQBlZ>;
	Mon, 16 Dec 2002 20:41:25 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Date: Mon, 16 Dec 2002 20:49:16 -0500
User-Agent: KMail/1.4.3
Cc: Dave Jones <davej@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212162049.16039.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting the above message in 2.5.51, 52, and 52+bk current.  
Pci info follows:

oscar# lspci -vv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 16
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


with a mga G400

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

What else would help to debug this?  The drm error above is all I find in the logs...

TIA
Ed Tomlinson


