Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVBSMMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVBSMMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 07:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVBSMMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 07:12:16 -0500
Received: from postin.uv.es ([147.156.1.90]:63625 "EHLO postin.uv.es")
	by vger.kernel.org with ESMTP id S261552AbVBSMMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 07:12:09 -0500
Date: Sat, 19 Feb 2005 13:11:57 +0100
From: uaca@alumni.uv.es
To: linux-kernel@vger.kernel.org
Cc: Tomas Szepe <szepe@pinerecords.com>
Subject: intel8x0: no sound in 2.6.11 rc3 & 4 (fine with 2.6.10)
Message-ID: <20050219121157.GA14437@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have read a post in lkml.org that states that the problem experienced in
rc3 has gone (1). That is not the case for me.

My audio device is

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
        Subsystem: IBM: Unknown device 0554
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 18c0 [size=64]
        Region 2: Memory at d0100c00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at d0100800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

In 2.6.10 and in 2.6.11-rc3 & 4 the clock is set to 48khz.

eg:

intel8x0_measure_ac97_clock: measured 49502 usecs
intel8x0: clocking to 48000

It uses an Analog Devices AD1981B

I have put a tar file of the /proc/asound directory of 2.6.10 and 2.6.11-rc4 in

	http://pusa.uv.es/~ulisses/asound-intel8x0/

the tar files were done while playing pcm audio, (not being eard in rc4).

I have found that I had to Mute __both__ "Headphone Jack Sense" and
"Line Jack Sense" in order to ear the audio in rc4.

Please let me know if you need further info or you want a tester

All this is on a IBM Thinkpad R51 - Type 2887 -AVG

(tot toc: IBM, we're buying your laptops too)

Thanks in advance

	Ulisses			

(1) http://lkml.org/lkml/2005/2/18/93											
-- 
                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

