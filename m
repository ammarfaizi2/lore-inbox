Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278364AbRKAIXh>; Thu, 1 Nov 2001 03:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278381AbRKAIX1>; Thu, 1 Nov 2001 03:23:27 -0500
Received: from adiemus.org ([129.210.16.110]:47033 "EHLO adiemus.org")
	by vger.kernel.org with ESMTP id <S278364AbRKAIXY>;
	Thu, 1 Nov 2001 03:23:24 -0500
Date: Thu, 1 Nov 2001 00:23:31 -0800 (PST)
From: Chris Tracy <ctracy@adiemus.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.13-ac2/3/5: Strange cache memory report
Message-ID: <Pine.LNX.4.30.0111010007160.10052-100000@adiemus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

	I've noticed a strange bug in 2.4.13-ac2, 3, and 5.  (It wasn't
there in 2.4.12-ac2)  Namely, shortly after starting X, the reported
amount of cached memory spikes to somewhere around 18 hexabytes.
Needless to say, I don't have this much memory.  :-)

	The problem first occured on my pre-hardware-upgraded system, and
continues to occur on the post-upgrade system.  The first system was:

	ASUS A7V
	900MHz Athlon T-bird
	768MB RAM
	linux-2.4.13-ac2/ac3 (UP, CONFIG_HIGHMEM was off)

	The post-upgrade system is:

	Tyan Tiger MP S2460
	2x 1.4GHz Athlon MP 1600+
	1024MB RAM
	linux-2.4.13-ac5 (SMP, CONFIG_HIGHMEM was on)

	/proc/meminfo on the SMP system is:

        total:    used:    free:  shared: buffers:  cached:
Mem:  1053028352 812806144 240222208  8007680 385331200 18446744073599795200
Swap: 263168000        0 263168000
MemTotal:      1028348 kB
MemFree:        234592 kB
MemShared:        7820 kB
Buffers:        376300 kB
Cached:       4294860112 kB
SwapCached:          0 kB
Active:         453608 kB
Inact_dirty:    191808 kB
Inact_clean:         0 kB
Inact_target:   209700 kB
HighTotal:      131008 kB
HighFree:         2040 kB
LowTotal:       897340 kB
LowFree:        232556 kB
SwapTotal:      257000 kB
SwapFree:       257000 kB

	It doesn't seem to cause any problems, as the system continues to
function normally.  (Though I've not really tested to see if there's any
performance hit associated with the phenomenon)  Either way, I'm guessing
it's not what's supposed to be happening.  (As much as I'd love to have
that much cache)

	If you'd like any further information, please let me know.  Oh,
and please CC me as I'm not on this list.

	Thanks,

	Chris

--------------------------------
Chris Tracy
System/Network Administrator
Engineering Design Center
Santa Clara University
"Wherever you go, there you are."

