Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVBWT0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVBWT0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 14:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVBWT0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 14:26:52 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:56022 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261518AbVBWT0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 14:26:48 -0500
Message-ID: <421CDA08.3090602@tmr.com>
Date: Wed, 23 Feb 2005 14:31:20 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: uaca@alumni.uv.es
CC: linux-kernel@vger.kernel.org, Tomas Szepe <szepe@pinerecords.com>
Subject: Re: intel8x0: no sound in 2.6.11 rc3 & 4 (fine with 2.6.10)
References: <20050219121157.GA14437@pusa.informat.uv.es>
In-Reply-To: <20050219121157.GA14437@pusa.informat.uv.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uaca@alumni.uv.es wrote:
> Hello
> 
> I have read a post in lkml.org that states that the problem experienced in
> rc3 has gone (1). That is not the case for me.
> 
> My audio device is
> 
> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
>         Subsystem: IBM: Unknown device 0554
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 11
>         Region 0: I/O ports at 1c00 [size=256]
>         Region 1: I/O ports at 18c0 [size=64]
>         Region 2: Memory at d0100c00 (32-bit, non-prefetchable) [size=512]
>         Region 3: Memory at d0100800 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> In 2.6.10 and in 2.6.11-rc3 & 4 the clock is set to 48khz.
> 
> eg:
> 
> intel8x0_measure_ac97_clock: measured 49502 usecs
> intel8x0: clocking to 48000
> 
> It uses an Analog Devices AD1981B
> 
> I have put a tar file of the /proc/asound directory of 2.6.10 and 2.6.11-rc4 in
> 
> 	http://pusa.uv.es/~ulisses/asound-intel8x0/
> 
> the tar files were done while playing pcm audio, (not being eard in rc4).
> 
> I have found that I had to Mute __both__ "Headphone Jack Sense" and
> "Line Jack Sense" in order to ear the audio in rc4.

I keep seeing this advice, but what tool do you use to mute them? I 
don't see anything like that in alsamixer, aumix, or any other program I 
tried.
> 
> Please let me know if you need further info or you want a tester
> 
> All this is on a IBM Thinkpad R51 - Type 2887 -AVG

ASUS 1681 - same symptoms.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
