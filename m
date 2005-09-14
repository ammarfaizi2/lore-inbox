Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbVINJnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbVINJnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVINJnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:43:39 -0400
Received: from femail.waymark.net ([206.176.148.84]:42968 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S965119AbVINJni convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:43:38 -0400
Date: 14 Sep 2005 09:22:34 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: Re: [PROBLEM] mtrr's not set, 2.6.13
To: linux-kernel@vger.kernel.org
Message-ID: <603fb7.2e22d1@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> In 13 Sep 05  15:30:16 article, Dave Jones wrote to All and Jim <=-

[...]

 JM> /proc/mtrr:
 JM>
 JM> reg00: base=0x00000000 (   0MB), size=983552MB: write-back, count=1

 DJ> That's an incredibly huge amount of system ram :)
 DJ> Have you done a BIOS update between the kernel upgrades by any
 chance ?
 DJ> Or altered any options in the BIOS ?

 DJ> Does booting the older kernel definitly still work ?

 DJ> AFAIR, we don't touch the first MTRR, that's typically set up by
 DJ> the BIOS before we even boot.

not sure when this changed, but this computer, a 99 e-machines cyrix m
ii and via mvp3 unit, is showing more than the 512 megas pc 100 ram it
actually has, apparently, in the first line of /proc/mtrr quoted below

 3 Wed Sep 14 03:44:18 0 ~/build/kernel/linux-2.6.14-rc1 $ cat /proc/mtrr
reg00: base=0xfd000000 (4048MB), size=   4MB: write-combining, count=1
reg01: base=0x000c0000 (   0MB), size= 256KB: uncachable, count=1
reg07: base=0x00000000 (   0MB), size= 512MB: write-back, count=1

X shows the video with four MB, lspci shows 16MB -- been that
way for awhile..

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev
7a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage IIC AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste
SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbor
<MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at feac0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3ho
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Linux fret 2.6.14-rc1 #6 Wed Sep 14 01:05:11 CDT 2005 i686 unknown unknown
GNU/Linux

p.s. this 2.6.14-rc1 kernel shows four lines plus one or two
pixels of the next line, at the bottom of each text console, filled with
what looks like earlier buffer.  and it scrolls, with new output. ??

--- MultiMail/Linux v0.46
