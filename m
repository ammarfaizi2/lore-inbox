Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263303AbTCNITy>; Fri, 14 Mar 2003 03:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263304AbTCNITy>; Fri, 14 Mar 2003 03:19:54 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:27776 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S263303AbTCNITu>;
	Fri, 14 Mar 2003 03:19:50 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
References: <20030313032615.7ca491d6.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 14 Mar 2003 10:29:59 +0100
In-Reply-To: <20030313032615.7ca491d6.akpm@digeo.com>
Message-ID: <87bs0eqors.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've used tried the -mm-kernels since they've actually made
2.5-kernels usable on my laptop lately (Compaq Evo800c), but
2.5.64-mm2 and onwards doesnt work with X anymore. I run 4.3.0-r1 from
the Gentoo unstable "branch".

with -mm1 I X coming up just nicely, and now the screen just goes
black after trying to start X, and it seems related to DRM. With
-mm[56] the last bit I see in my X startup is this:

(==) RADEON(0): Write-combining range (0x88000000,0x4000000)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
[HANG]

With -mm1 and 2.4.21preX it shows this:
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmGetBusid returned ''
(II) RADEON(0): [drm] loaded kernel module for "radeon" driver
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:1:0:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xf098d000
(II) RADEON(0): [drm] mapped SAREA 0xf098d000 to 0x40013000
.
.
.

Although it hangs under -mm[56] the machine will still respond to
CRTL-ALT-DEL and reboot nicely. The only modification to the kernel
I've done it backing out smalldevfs (Gentoo likes to have the full
thing). I've also tried having the DRM-stuff as modules and as
compiled in, no difference

The graphics adapter is a Radeon with 64Mb RAM:

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 88000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at 80380000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Other than that 2.5.64-mm6 is very usable, but only in text mode.

mvh,
A

Andrew Morton <akpm@digeo.com> writes:

> [SNIP]
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
