Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTJUIDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 04:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTJUIDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 04:03:15 -0400
Received: from kwisatz.net1.nerim.net ([80.65.225.31]:34308 "EHLO
	www.rubis.org") by vger.kernel.org with ESMTP id S263009AbTJUIDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 04:03:10 -0400
Date: Tue, 21 Oct 2003 10:03:07 +0200
From: Stephane Jourdois <stephane@rubis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1
Message-ID: <20031021080306.GA10162@rubis.org>
Reply-To: stephane@rubis.org
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20031020020558.16d2a776.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031020020558.16d2a776.akpm@osdl.org>
X-Operating-System: Linux 2.4.22-ac4
X-Send-From: www.rubis.org
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 02:05:58AM -0700, Andrew Morton wrote:
> . Included a much updated fbdev patch.  Anyone who is using framebuffers,
>   please test this.

Hello,

rivafb still doesn't work on my card, but that isn't surprising :

root(pts/7)@saphir:~(102Ko) # lspci -vvn -s 01:00.0
01:00.0 Class 0300: 10de:0181 (rev a2)
        Subsystem: 1043:80bb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 4
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at effe0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

This card is a Geforce4 440 MX.

please note the 10de:0181, whereas in includes/linux/pci_ids.h we have :
#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_440    0x0171

So I tried to replace 0171 with 0181, and the card was detected, but the
frame buffer still doesn't work (blank screen for most resolutions,
corrupted screen for some).

Also, What is that subsystem 1043:80bb (Asustek:device not-known) ?


Should I provide more informataions about my card ?
I'm ready to test any patch needed.

Thanks,

-- 
 ///  Stephane Jourdois         /"\  ASCII RIBBON CAMPAIGN \\\
(((    Ingénieur développement  \ /    AGAINST HTML MAIL    )))
 \\\   24, rue Cauchy            X                         ///
  \\\  75008  Paris             / \    +33 6 8643 3085    ///
