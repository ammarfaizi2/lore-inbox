Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRCTRGW>; Tue, 20 Mar 2001 12:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbRCTRGN>; Tue, 20 Mar 2001 12:06:13 -0500
Received: from zeus.kernel.org ([209.10.41.242]:24000 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130507AbRCTRFz>;
	Tue, 20 Mar 2001 12:05:55 -0500
Date: Tue, 20 Mar 2001 11:01:52 -0600 (CST)
From: Josh Grebe <squash@primary.net>
To: linux-kernel@vger.kernel.org
Subject: Question about memory usage in 2.4 vs 2.2
In-Reply-To: <200103190207.UAA13397@senechalle.net>
Message-ID: <Pine.LNX.4.21.0103201038140.2405-100000@scarface.primary.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have a server farm made of identical hardware running pop3 and imap mail
functions. recently, we upgraded all the machines to kernel 2.4.2, but we
noticed that according to free, our memory utilization went way up. Here
is the output of free on the 2.4.2 machine:
             total       used       free     shared    buffers     cached
Mem:        513192     492772      20420          0       1684     263188
-/+ buffers/cache:     227900     285292
Swap:       819304        540     818764


On the 2.2..18 machine:
             total       used       free     shared    buffers     cached
Mem:        517256     351280     165976      19920      82820     186836
-/+ buffers/cache:      81624     435632
Swap:       819304          0     819304


Doing the math, the 2.4 machine is using 44% of available memory, while
the 2.2 is using only about 14%.

Here are the contents of /proc/meminfo on 2.4:
        total:    used:    free:  shared: buffers:  cached:
Mem:  525508608 517480448  8028160        0  1138688 282091520
Swap: 838967296   552960 838414336
MemTotal:       513192 kB
MemFree:          7840 kB
MemShared:           0 kB
Buffers:          1112 kB
Cached:         275480 kB
Active:         254876 kB
Inact_dirty:     18880 kB
Inact_clean:      2836 kB
Inact_target:       48 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513192 kB
LowFree:          7840 kB
SwapTotal:      819304 kB
SwapFree:       818764 kB

on 2.2:
        total:    used:    free:  shared: buffers:  cached:
Mem:  529670144 366837760 162832384 22945792 84807680 194367488
Swap: 838967296        0 838967296
MemTotal:    517256 kB
MemFree:     159016 kB
MemShared:    22408 kB
Buffers:      82820 kB
Cached:      189812 kB
SwapTotal:   819304 kB
SwapFree:    819304 kB

These machines are dual P2-400's, with 512M ECC ram, adaptec 2940, and
dual intel etherexpress pro 100 cards.

I also tried 2.4.2-ac20 with similar results.

Am I missing something here? I'd really like to move the farm back up to
2.4 series.

Thanks,

Josh

---
Josh Grebe
Senior Unix Systems Administrator
Primary Network, an MPower Company
http://www.primary.net


