Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275424AbRIZSOL>; Wed, 26 Sep 2001 14:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275423AbRIZSNv>; Wed, 26 Sep 2001 14:13:51 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:26833 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S275424AbRIZSNs>; Wed, 26 Sep 2001 14:13:48 -0400
Message-ID: <3BB219C7.5010507@antefacto.com>
Date: Wed, 26 Sep 2001 19:09:11 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <Pine.LNX.4.30.0109261958290.8655-100000@Appserv.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Wed, 26 Sep 2001, Alan Cox wrote:
>
>>VIA Cyrix CIII (original generation 0.18u)
>>
>>nothing: 28 cycles
>>locked add: 29 cycles
>>cpuid: 72 cycles
>>
>
>Interesting. From a newer C3..
>
>nothing: 30 cycles
>locked add: 31 cycles
>cpuid: 79 cycles
>
>Only slightly worse, but I'd not expected this.
>This was from a 866MHz part too, whereas you have a 533 iirc ?
>
>regards,
>
>Dave.
>
Interesting, does the origonal CIII have a TSC? would that affect the 
timings Alan got?

The following table may  be of use to people:

(All these S370)
----------------------------------------------------------------------------------------
core        size    name        code    Notes
----------------------------------------------------------------------------------------
samuel        0.18µm    Via Cyrix III(C5)   (128K L1 0K L2 cache). FPU 
doesn't run @ full clock speed.
samuel II    0.15µm    Via C3        (C5B)   667MHz CIII in Dabs are 
C3's (128K L1, 64K L2 cache), (MMX/3D now!), FPU @ full clock speed.
mathew      0.15µm    Via C3        (C5B)   mobile samuel II with 
integrated north bridge & 2D/3D graphics. (1.6v)
ezra        0.13µm    Via C3        (C5C)   Debut @ 850MHz rising to 
1GHz quickly (1.35v)
nehemiah    0.13µm    Via C4        (C5X)   Debut @ 1.2GHz (128K L1, 
256K L2 cache) (SSE)
esther        0.10µm    Via C4        (C5Y)   ?

----------------------

C3 availability details:
667    66 / 100 / 133    1.5    Socket 370    L1: 128kB,L2: 64kB    
0.15µ    6-12W    Mar 2001
733    66 / 100 / 133    1.5    Socket 370    L1: 128kB,L2: 64kB    
0.15µ    6-12W    May 2001
733    66 / 100 / 133    1.5    Socket 370    L1: 128kB,L2: 64kB    
0.15µ    1+ W    May 2001 (e series)
750    100 / 133    1.5    Socket 370    L1: 128kB,L2: 64kB    0.15µ    
6-12W    May 2001
800    100 / 133    1.5    Socket 370    L1: 128kB,L2: 64kB    0.13µ    
7-12W    May 2001 (ezra)

----------------------


