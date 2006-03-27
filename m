Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWC0Arn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWC0Arn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 19:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWC0Arn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 19:47:43 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:49378 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932279AbWC0Arn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 19:47:43 -0500
Date: Mon, 27 Mar 2006 02:47:41 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: funny framebuffer fonts on PowerBook with radeonfb
Message-ID: <20060327004741.GA19187@MAIL.13thfloor.at>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Ben!

2.6.16 and 2.6.15-something show a funny behaviour
when using the radeonfb driver (for text mode), they
kind of twist and break the fonts in various places
some characters or parts seem to be mirrored like
'[' becoming ']' but not on character boundary but
more on N pixels, colors seem to be correct for the
characters, and sometimes the font is perfectly fine
for larger runs, e.g. I can read the logon prompt
fine, but everything I type is garbled ...

just for an example, when I type 'echo "Test"' then
all characters are mirrored and cut off on the right
side but the locations are as shown above, on enter
the T is only a few pixels wide, but the est part is
written perfectly fine ... this is a new behaviour
and going back to 2.6.13.3 doesn't show this ...

if there is some testing I can do for you, or when
you need more info, please let me know. here a few
details for the machine:

TIA,
Herbert

 processor	: 0
 cpu		: 7450, altivec supported
 clock		: 667.000000MHz
 revision	: 0.1 (pvr 8000 0201)
 bogomips	: 66.56
 timebase	: 33290001
 machine	: PowerBook3,3
 motherboard	: PowerBook3,3 MacRISC2 MacRISC Power Macintosh
 detected as	: 72 (PowerBook Titanium II)
 pmac flags	: 0000001b
 L2 cache	: 256K unified
 pmac-generation: NewWorld

00:10.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
 Subsystem: ATI Technologies Inc Radeon Mobility M6 LY
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 255 (2000ns min), cache line size 08
 Interrupt: pin A routed to IRQ 48
 Region 0: Memory at b8000000 (32-bit, prefetchable) [size=128M]
 Region 1: I/O ports at f0000400 [size=256]
 Region 2: Memory at b0000000 (32-bit, non-prefetchable) [size=64K]
 Expansion ROM at f1000000 [disabled] [size=128K]
 Capabilities: [58] AGP version 2.0
  Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
  Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
  Capabilities: [50] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

 PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
 radeonfb (0000:00:10.0): Invalid ROM signature 8080 should be 0xaa55
 radeonfb: Retrieved PLL infos from Open Firmware
 radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=166.00 Mhz, System=166.00 MHz
 radeonfb: PLL min 12000 max 35000
 radeonfb: Monitor 1 type LCD found
 radeonfb: EDID probed
 radeonfb: Monitor 2 type no found
 radeonfb: Using Firmware dividers 0x0001003a from PPLL 0
 radeonfb: Dynamic Clock Power Management enabled
 Console: switching to colour frame buffer device 164x54
 Registered "ati" backlight controller,level: 15/15
 radeonfb (0000:00:10.0): ATI Radeon LY 


