Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268149AbRHKPYS>; Sat, 11 Aug 2001 11:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268206AbRHKPYI>; Sat, 11 Aug 2001 11:24:08 -0400
Received: from citd-ppp.paderlinx.de ([193.189.252.149]:50180 "EHLO
	mail.citd.de") by vger.kernel.org with ESMTP id <S268149AbRHKPYB>;
	Sat, 11 Aug 2001 11:24:01 -0400
Date: Sat, 11 Aug 2001 17:24:09 +0200 (MEST)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: VM(/cache) got worse from 2.4.4 -> 2.4.8
Message-ID: <Pine.LNX.4.20.0108111700440.7319-100000@citd.owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#Include <hallo.h>



System:
MB: Severworks HE-SL-Chipset
RAM: 3GB
CPU: 2xPIII 933Mhz
Relevant HDDs:
2x IBM DTLA 307045 connected via PDC20268(I patched the kernel with latest
IDE-driver i could find in people/hedrick)

Swap: NONE

When i do "big" (DATA>RAM) copies from HDD1 to HDD2 the system gets
"inresponsive" (Hitting keys are noticeable delayed (I'd says around
500ms)) when cache reaches maximum.

# free
             total       used       free     shared    buffers     cached
Mem:       3090664    3085452       5212          0      15156    2959200
-/+ buffers/cache:     111096    2979568
Swap:            0          0          0

The Sound(SB-Live, without the other patches for 2.4.8) hangs with the
EXACT same pattern as the blinking of the HDD-LED from where the data is
read. (LED goes out, sound hangs. LED lid sound plays)

Also the "Pattern" of cache "full" is diffrent from 2.4.4 to 2.4.8 when
2.4.4 reaches "maximun" then it "stops" and some MB of dirty caches are
written to target driver. (This could take severeal seconds) Whereas 2.4.8
uses very short "burstes" of reading source/writing target. (About 2/3 per
Second)

After the trashing situation is gone (Copy done) sound hanges exactly
every second. (Could be used as a timer. And doesn't get better until
reset)

2.4.4 didn't have ANY of those problems. (I haven't tried any kernel in
between)


OK. Time to downgrade to 2.4.4




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.


