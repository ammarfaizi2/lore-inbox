Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUFNOI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUFNOI2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUFNOI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:08:28 -0400
Received: from pop.gmx.de ([213.165.64.20]:11393 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263032AbUFNOIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:08:10 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-rc3-mm2
Date: Mon, 14 Jun 2004 16:19:52 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20040614021018.789265c4.akpm@osdl.org>
In-Reply-To: <20040614021018.789265c4.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406141620.01731.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 June 2004 11:10, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6
>.7-rc3-mm2/

I got following messages on startup of hotplug:
usb 3-1: control timeout on ep0in
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110
usb 3-1: string descriptor 0 read error: -110

lspci -vvv
...
0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at e2420000 (32-bit, non-prefetchable)

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 21
        Region 0: Memory at e2421000 (32-bit, non-prefetchable)

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin C routed to IRQ 22
        Region 0: Memory at e2422000 (32-bit, non-prefetchable)

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
Controller (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at e2423000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
...

Please CC me from usb-devel list, as I'm not subscribed on it.

greets dominik
