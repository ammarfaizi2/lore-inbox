Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbUCMJ5c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 04:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbUCMJ5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 04:57:32 -0500
Received: from vsmtp2alice.tin.it ([212.216.176.142]:48797 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S263075AbUCMJ5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 04:57:15 -0500
Subject: Radeonfb (new driver) problem with kernel 2.6.4
From: GhePeU <ghepeu@libero.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1079171829.5899.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Mar 2004 10:57:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting with kernel command line parameter
"video=radeonfb:1024x768-32@85" gives only a blank screen: system works,
and X starts flawlessy, but framebuffer console doesn't display
anything. Framebuffer works correctly only with refresh 60Hz. There are
no error messages and dmesg output is the same I have on 2.6.3 (working
flawlessy with the same command line and kernel configuration):

kernel 2.6.3 and kernel 2.6.4:
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=290.00 Mhz,
System=230.00 MHz
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Monitor Operating Limits: From EDID
     H: 30-72KHz V: 50-120Hz DCLK: 110MHz
radeonfb: ATI Radeon QW  DDR SGRAM 64 MB


videocard is an ATI Radeon 7500:

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW
[Radeon 7500] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon 7500
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at a800 [size=256]
        Region 2: Memory at dfef0000 (32-bit, non-prefetchable)
[size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit-
FW- Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

on a via chipset kt266a:

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
        Subsystem: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


running fbset from a X console in 2.6.4 gives same output that with
2.6.3:

mode "1024x768-85"
    # D: 94.384 MHz, H: 68.593 kHz, V: 84.998 Hz
    geometry 1024 768 1024 768 32
    timings 10595 176 66 35 1 110 3
    rgba 8/16,8/8,8/0,0/0
endmode



