Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264356AbRFLMMA>; Tue, 12 Jun 2001 08:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264353AbRFLMLu>; Tue, 12 Jun 2001 08:11:50 -0400
Received: from [212.18.228.90] ([212.18.228.90]:18706 "HELO
	carrot.linuxgrrls.org") by vger.kernel.org with SMTP
	id <S264348AbRFLMLd>; Tue, 12 Jun 2001 08:11:33 -0400
Message-ID: <3B2606CF.10003@linuxgrrls.org>
Date: Tue, 12 Jun 2001 13:10:55 +0100
From: Rachel Greenham <rachel@linuxgrrls.org>
Organization: LinuxGrrls.Org
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac6 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VIA KT133A crash *post* 2.4.3-ac6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to just run and run... Sorry I couldn't report this earlier, 
but I've only just got this machine...

With DMA (UDMA Mode 5) enabled, my machine crashes on kernel versions 
from 2.4.3-ac7 onwards up to 2.4.5 right up to 2.4.5-ac13. 2.4.3 vanilla 
and 2.4.3-ac6 are completely stable. -ac7 of course is when a load of 
VIA fixes were done. :-}

Details:

System is:

CPU: Athlon 1.33 GHz with 266MHz FSB
Mobo: Asus A7V133 with 266MHz FSB, UltraDMA100 (PDC20265 according to 
kernel boot messages)
    BIOS has been updated to latest available (massively unstable before)
512Mb PC133 RAM
Voodoo 3
3Com 3C905B
IBM UDMA100 41Gb Deskstar

Software:

SuSE 7.1 updated to current-everything
SuSE default kernel and self-built kernels of various versions

Symptoms:

With DMA disabled, *all* kernels are completely stable.

With DMA (any setting, but UDMA mode 5 preferred of course) enabled, on 
kernels 2.4.3-ac7 and onwards, random lockup on disk access within first 
few minutes of use - sometimes very quickly after boot, sometimes as 
much as ten minutes later given use. Running bonnie -s 1024 once or 
twice after boot generally excites it too. :-}. Lockup is pretty severe: 
machine goes completely unresponsive, Magic SysRq doesn't work. About 
the only thing that does still work is the flashing VGA cursor. :-)

Actual tested kernels:

2.4.0.SuSE, 2.4.0 vanilla, 2.4.3 vanilla, 2.4.3-ac6 - No failure
2.4.3-ac7, 2.4.4 vanilla, 2.4.5 vanilla, 2.4.5-ac13 - Failure.

-- 
Rachel


