Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267850AbTAMFOY>; Mon, 13 Jan 2003 00:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267857AbTAMFOX>; Mon, 13 Jan 2003 00:14:23 -0500
Received: from pop018pub.verizon.net ([206.46.170.212]:7310 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S267850AbTAMFOO>; Mon, 13 Jan 2003 00:14:14 -0500
Date: Mon, 13 Jan 2003 16:23:15 +1100
From: Jonathan Thorpe <wd.dev@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: via82cxxx_audio on VT8235
Message-Id: <20030113162315.679f7392.wd.dev@verizon.net>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop018.verizon.net from [144.136.112.171] at Sun, 12 Jan 2003 23:22:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I've been using an Asrock K7VT2 motherboard for the past few weeks which
is based upon a VT8235 south bridge and KT266 north bridge chipset. The
VT8235 is attached to a VT1612A 2-channel AC97 codec which works very well
with Alan's recent updates to the via82cxxx_audio driver (and in
particular with the later of the 2.4.21-preX releases which allow more
applications to work with the chip - I've tested MPlayer and Ogle to work
well). The ALSA driver has been shocking with these chipsets, in
particular the 2 channel chip which appears to be accepting data, but
doesn't produce any audio (turning up the speakers to max will allow you
to hear the sound fiently).

There are however two minor problems that I'm having with this chip that I
thought I'd let you know about. The first is the fact that ESound hangs
(even the very latest version) when it is loaded, something that hasn't
occured before; this problem has been seen on a variety of codecs attached
to the VT8235 (including the VT1616, a 6 channel codec found on a few Epox
and VIA Epia-M Boards). Is there anything that ESound does that would
cause a problem with this particular driver?

The second problem I'm having is exclusive to the VT1612A (2 channel) and
is very minor; the Master Volume does not do anything at all, however
there's an additional "PCM2" volume control which behaves exactly as the
Master Volume should. What would be involved with solving this problem?

The output of lspci for the VT1612A chipset is:
--
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97
Audio Controller (rev 50)
        Subsystem: VIA Technologies, Inc.: Unknown device 4161
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 12
        Region 0: I/O ports at dc00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

--

Hope this feedback helps. I am not subscribed to linux-kernel, so please
feel free to CC.

Thanks,
Jonathan
