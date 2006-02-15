Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWBOKbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWBOKbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 05:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWBOKbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 05:31:39 -0500
Received: from smtp1.libero.it ([193.70.192.51]:38639 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S1751068AbWBOKbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 05:31:38 -0500
From: <mtassinari@libero.it>
To: "'Adrian Bunk'" <bunk@stusta.de>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>, "'Dave Jones'" <davej@redhat.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       <airlied@linux.ie>, <dri-devel@lists.sourceforge.net>,
       <mtassinari@cmanet.it>
Subject: Re: 2.6.16-rc3: more regressions
Date: Wed, 15 Feb 2006 11:27:15 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAcm3p+dGrIEuKvCi2uAOJU8KAAAAQAAAAevBOOtBLOEyv/vwklq7A/gEAAAAA@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The ID removed by Dave's patch is the only ID listed for an RV370 
>> chips
>> (the other RV370's aren't listed in the radeon DRM driver).
>> 
>> I suspect Dave and Mauro having unrelated problems.
>> 
>> > 		Linus
>> 
>> cu
>> Adrian
>
>The X300 has two pci ids:
>0000:05:00.0 0300: 1002:5b60
>0000:05:00.1 0380: 1002:5b70
>
>0000:05:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 
>[Radeon X300 (PCIE)]
>0000:05:00.1 Display controller: ATI Technologies Inc RV370 [Radeon 
>X300SE]
>
>	Gerhard

This particular pci express card is commercialized as "ASUS EXTREME AX 300
SE-X/TD/128 MB DDR TV OUT DVI" has the following:

04:00.0 Class 0300: 1002:5b60
04:00.1 Class 0380: 1002:5b70

04:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon
X300 (PCIE)] (prog-if 00 [VGA])
        Subsystem: ASUSTeK Computer Inc. Extreme AX300SE-X
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 04
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at e000 [size=256]
        Region 2: Memory at d7fe0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at d7fc0000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #10 [0001]
        Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000

04:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
        Subsystem: ASUSTeK Computer Inc.: Unknown device 002b
        Flags: bus master, fast devsel, latency 0
        Memory at d7ff0000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #10 [0001]

It does indeed work with dri disabled in xorg.conf, as explained by Dave
Airlie in previous post.

the only modules loaded starting xorg are:

Module                  Size  Used by
appletalk              27696  2
ax25                   45784  2
ipx                    21164  2
radeon                 94112  0

this of course on 2.6.15, since 2.6.16 completely hangs, and no other info
can be gathered.

Mauro

