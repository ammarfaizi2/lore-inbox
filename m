Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUEFX5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUEFX5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 19:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUEFX5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 19:57:47 -0400
Received: from www.amthinking.net ([65.104.119.37]:23340 "EHLO
	ex0.amthinking.net") by vger.kernel.org with ESMTP id S261528AbUEFX5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 19:57:44 -0400
Message-ID: <409AD0E2.4040705@appliedminds.com>
Date: Thu, 06 May 2004 16:57:22 -0700
From: James Lamanna <jamesl@appliedminds.com>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20040421)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: adaplas@pol.net
Subject: Getting i815 Framebuffer working?!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2004 23:57:43.0122 (UTC) FILETIME=[EBD25320:01C433C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using stock 2.6.5, I'm trying to get the Intel i810/5 framebuffer driver 
to work. So far I have had no success.

Any help would be appreciated, system data follows.

Please CC me for I am not subscribed.

-- James Lamanna

I'm using the following lilo.conf line:
append="video=i810fb:vram:2,xres:1024,yres:768,bpp:8,hsync1:30,\
         hsync2:55,vsync1:50,vsync2:85,accel,mtrr"


Relevant Statements from dmesg:
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: AGP aperture is 64M @ 0xe0000000
i810fb: probe of 0000:00:02.0 failed with error -22
^^^^ Not promising... :)
NTFS driver 2.1.6 [Flags: R/O].
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized i810 1.4.0 20030605 on minor 0
[drm] Initialized i830 1.3.2 20021108 on minor 1

Relevant lspci output:

0000:00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset
Graphics Controller] (rev 04) (prog-if 00 [VGA])
         Subsystem: Intel Corp. 82815 CGC [Chipset Graphics Controller]
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at e0000000 (32-bit, prefetchable)
         Region 1: Memory at e4100000 (32-bit, non-prefetchable)
[size=512K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Relevant parts of .config:

# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_VIDEO_SELECT is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I810=y
CONFIG_FB_I810_GTF=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

