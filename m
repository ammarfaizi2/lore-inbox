Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVH1FMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVH1FMd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 01:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVH1FMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 01:12:33 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:56246 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750767AbVH1FMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 01:12:32 -0400
Date: Sat, 27 Aug 2005 22:12:25 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Michael Marineau <marineam@engr.orst.edu>
Cc: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Radeon acpi vgapost
Message-ID: <20050828051225.GA4225@us.ibm.com>
References: <43111298.80507@engr.orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43111298.80507@engr.orst.edu>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.08.2005 [18:25:44 -0700], Michael Marineau wrote:
> Thses patches resume ATI radeon cards from acpi S3 suspend when using
> radeonfb by reposting the video bios. This is needed to be able to use
> S3 when the framebuffer is enabled.

Just wanted to report that these patches lead to progress on my T41p;
relevant lspci -vvv:

0000:01:00.0 VGA compatible controller: ATI Technologies Inc M10 NT [FireGL Mobility T2] (rev 80) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 054f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

In 2.6.13-rc7 or 2.6.13-rc6-mm2, after echo mem > /sys/power/state, the
lcd light comes back, but no video is actually displayed (I just notice
that the backlight turns on). With your patches, I now see (with either
rc7 or rc6-mm2) a mostly black screen with "inux" in the upper left --
basically a garbled console -- which slowly turns completely white.

If you would like me to do more debugging, I would be more than happy to
do so.

Thanks for the work so far,
Nish
