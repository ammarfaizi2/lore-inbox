Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWBUS7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWBUS7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWBUS7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:59:49 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:57274 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751207AbWBUS7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:59:49 -0500
Date: Tue, 21 Feb 2006 20:00:32 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1 console (radeonfb) not resumed after s2ram
Message-ID: <20060221190031.GA3531@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060220042615.5af1bddc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220042615.5af1bddc.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc4-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 04:26:15AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/

After suspend the system is fully working except it doesn't resume the
console (I'm using radeonfb). If suspending from X the thing comes back,
X working ok, but switching to vt1 I see the console completely garbled.
Reverting radeonfb-resume-support-for-samsung-p35-laptops.patch (_wild_
guess) does not help.
Any good candidate?

My videocard:

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at d0120000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-- 
mattia
:wq!
