Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424252AbWKJDKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424252AbWKJDKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 22:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424343AbWKJDKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 22:10:47 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:33244 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1424252AbWKJDKq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 22:10:46 -0500
From: Ed Tomlinson <edt@aei.ca>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1
Date: Thu, 9 Nov 2006 22:21:49 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061108015452.a2bb40d2.akpm@osdl.org>
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611092221.49238.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 November 2006 04:54, Andrew Morton wrote:
> -radeonfb-support-24bpp-32bpp-minus-alpha.patch
> 
>  Dropped
> 
> +various-fbdev-files-mark-structs-fix.patch
> 
>  Fix various-fbdev-files-mark-structs.patch
> 
> +fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch
> 
>  fbdev fix

Strongly suspect that something is not right with these patches.  I have a:

01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Unknown device 2002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 8000 [size=256]
        Region 2: Memory at e9010000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at e8000000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
booting with: 

kernel /boot/2.6.19-rc5-mm1 root=/dev/sda3 vga=0x318 video=vesafb:ywrap,mtrr:3 console=tty0 console=ttyS0,38400 nmi_watchdog=1

gives a strangely corrupted screen.  The characters seem reversed...

What else can help?

Ed Tomlinson
