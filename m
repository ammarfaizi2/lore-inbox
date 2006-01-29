Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWA2Pi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWA2Pi3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 10:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWA2Pi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 10:38:29 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40153 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751026AbWA2Pi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 10:38:29 -0500
Date: Sun, 29 Jan 2006 16:38:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Moritz Muehlenhoff <jmm@inutil.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Display corruption with radeonfb after resuming from suspend-to-ram
Message-ID: <20060129153811.GE1764@elf.ucw.cz>
References: <20060128155237.GA4601@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128155237.GA4601@informatik.uni-bremen.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a hard-to-reproduce problem with radeonfb and suspend-to-ram:
> 
> I'm using radeonfb with fbcon in a pure console environment for most
> os the time (with mplayer on X11 being the rare exception) and I
> sometimes encounter display corruption after resuming from suspend to
> RAM. My notebook is a ThinkPad X31 with this Radeon model:
> 
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
>         Subsystem: IBM: Unknown device 052f
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
>         Region 1: I/O ports at 3000 [size=256]
>         Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
>         Expansion ROM at c0120000 [disabled] [size=128K]
>         Capabilities: <available only to root>
> 
> Resuming from suspend-to-ram works flawless in roughly 98% of all cases, but
> sometimes the display gets corrupted; some bits are set in the display in a
> weird way and the display starts to shift with every line break. An
> example:

Happens here, too... or happened, I think I have a solution. Reseting
video card during resume seems like a way to go.

Could you get s2ram.c from www.sf.net/projects/suspend, and add your
X31 with same parameters as X32 system, and let me know if it helps?

(You'll need an -mm kernel for parameter to be passed into kernel).

								Pavel
-- 
Thanks, Sharp!
