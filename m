Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWJ2Kd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWJ2Kd3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 05:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWJ2Kd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 05:33:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:21995 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751030AbWJ2Kd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 05:33:28 -0500
X-Authenticated: #20450766
Date: Sun, 29 Oct 2006 11:33:23 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] 2.6.19-rc2: known regressions
In-Reply-To: <20061014111458.GI30596@stusta.de>
Message-ID: <Pine.LNX.4.60.0610291056470.4303@poirot.grange>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
 <20061014111458.GI30596@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I did search the archives, but it does seem to be the new one. r8169 
network driver introduced in 2.6.19-rcX a set_mac_address function, which 
doesn't work for me. It should resolve the bugreport 
http://bugzilla.kernel.org/show_bug.cgi?id=6032 but, as you see from the 
last comment from the original reporter and from my following comment, it 
doesn't seem to. I think, it should either be fixed or reverted. My 
test-system, was a ppc NAS (KuroboxHG):

0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (8000ns min, 16000ns max), Cache Line Size: 0x08 (32 bytes)        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at bfff00 [size=256]
        Region 1: Memory at bfffff00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [dc] Power Management version 0
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Thanks
Guennadi
---
Guennadi Liakhovetski
