Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265680AbRFWL6k>; Sat, 23 Jun 2001 07:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263780AbRFWL6b>; Sat, 23 Jun 2001 07:58:31 -0400
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:51469 "HELO
	mail.ludost.net") by vger.kernel.org with SMTP id <S265668AbRFWL6Z>;
	Sat, 23 Jun 2001 07:58:25 -0400
Date: Sat, 23 Jun 2001 14:58:22 +0300 (EEST)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
X-X-Sender: <lnxkrnl@doom.bastun.net>
To: <linux-kernel@vger.kernel.org>
Cc: <riel@conectiva.com.bg>
Subject: Some new problems with 2.4.5 
Message-ID: <Pine.LNX.4.33.0106231455520.24672-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm resending this, it looks like it was lost somewhere ... and there is
some more mem info...)

  Hello,

 I have a machine that's dual coppermine/927 (that's what /proc/cpuinfo say:) ), with 1.2G ram,
Dell PercRaid, 3com 3c905B NIC. I'm using kernel 2.4.5 with the percraid patches.
The problem with the machine is, that it works for some time, and then it goes to hell. I spoke
with Rik van Riel last night, and he asked me to get some info from /proc/meminfo around the
crash. I've appended it here, and the kernel log messages ( recovered from remote logging station,
the machine was unsuble and was rebooted through the power switch :) ) .
It doesn't look like the other problems reported with 2.4 VM, so I still haven't tried to use 2.4.6pre3,
because it's production machine, and I'd like to stuck with something that's not prerelease :)
( full log is avialable at http://www.ludost.net/eru/ - meminfo.log.bz2, the kernel log from the 'crash'
moment, and the dmesg of the machine).
(the log was created with while /bin/true; cat /proc/meminfo >> dumpfile;sleep 20; done ).

meminfo.log , last lines:

        total:    used:    free:  shared: buffers:  cached:
Mem:  1317535744 1308397568  9138176        0 190033920 919121920
Swap: 2657390592 25657344 2631733248
MemTotal:      1286656 kB
MemFree:          8924 kB
MemShared:           0 kB
Buffers:        185580 kB
Cached:         897580 kB
Active:         973212 kB
Inact_dirty:    107736 kB
Inact_clean:      2228 kB
Inact_target:      744 kB
HighTotal:      393208 kB
HighFree:         2036 kB
LowTotal:       893448 kB
LowFree:          6888 kB
SwapTotal:     2595108 kB
SwapFree:      2570052 kB
        total:    used:    free:  shared: buffers:  cached:
Mem:  1317535744 1312010240  5525504        0 184389632 927334400
Swap: 2657390592 25657344 2631733248
MemTotal:      1286656 kB
MemFree:          5396 kB
MemShared:           0 kB
Buffers:        180068 kB
Cached:         905600 kB
Active:         980272 kB
Inact_dirty:    103148 kB
Inact_clean:      2248 kB
Inact_target:      748 kB
HighTotal:      393208 kB
HighFree:         2036 kB
LowTotal:       893448 kB
LowFree:          3360 kB
SwapTotal:     2595108 kB
SwapFree:      2570052 kB
        total:    used:    free:  shared: buffers:  cached:
Mem:  1317535744 1312051200  5484544        0 175587328 936456192
Swap: 2657390592 25657344 2631733248
MemTotal:      1286656 kB
MemFree:          5356 kB
MemShared:           0 kB
Buffers:        171472 kB
Cached:         914508 kB
Active:         985180 kB
Inact_dirty:     98440 kB
Inact_clean:      2368 kB
Inact_target:      712 kB
HighTotal:      393208 kB
HighFree:         2036 kB
LowTotal:       893448 kB
LowFree:          3320 kB
SwapTotal:     2595108 kB
SwapFree:      2570052 kB
        total:    used:    free:  shared: buffers:  cached:
Mem:  1317535744 1312182272  5353472        0 167284736 943894528
Swap: 2657390592 25657344 2631733248
MemTotal:      1286656 kB
MemFree:          5228 kB
MemShared:           0 kB
Buffers:        163364 kB
Cached:         921772 kB
Active:         988760 kB
Inact_dirty:     93888 kB
Inact_clean:      2488 kB
Inact_target:      772 kB
HighTotal:      393208 kB
HighFree:         2036 kB
LowTotal:       893448 kB
LowFree:          3192 kB
SwapTotal:     2595108 kB
SwapFree:      2570052 kB


kern.log , last lines :
Jun 23 08:17:41 eru kernel: possible SYN flooding on port 80. Sending cookies.
Jun 23 08:17:41 eru kernel: __alloc_pages: 1-order allocation failed.
Jun 23 08:18:41 eru last message repeated 3201 times
Jun 23 08:18:41 eru kernel: possible SYN flooding on port 80. Sending cookies.
Jun 23 08:18:41 eru kernel: __alloc_pages: 1-order allocation failed.
Jun 23 08:19:41 eru last message repeated 3191 times
Jun 23 08:19:41 eru kernel: possible SYN flooding on port 80. Sending cookies.
Jun 23 08:19:41 eru kernel: __alloc_pages: 1-order allocation failed.
Jun 23 08:20:41 eru kernel: possible SYN flooding on port 80. Sending cookies.
Jun 23 08:20:41 eru last message repeated 3354 times
Jun 23 08:20:42 eru kernel: __alloc_pages: 1-order allocation failed.

And, meminfo from the last crash ( happened 30 mins ago ) :
        total:    used:    free:  shared: buffers:  cached:
Mem:  1317535744 1310912512  6623232        0 142184448 897589248
Swap: 2657390592  2813952 2654576640
MemTotal:      1286656 kB
MemFree:          6468 kB
MemShared:           0 kB
Buffers:        138852 kB
Cached:         876552 kB
Active:         765348 kB
Inact_dirty:    248260 kB
Inact_clean:      1796 kB
Inact_target:      300 kB
HighTotal:      393208 kB
HighFree:         2036 kB
LowTotal:       893448 kB
LowFree:          4432 kB
SwapTotal:     2595108 kB
SwapFree:      2592360 kB



