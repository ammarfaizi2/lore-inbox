Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274277AbRIYA1O>; Mon, 24 Sep 2001 20:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274283AbRIYA1K>; Mon, 24 Sep 2001 20:27:10 -0400
Received: from zima.ucf.ics.uci.edu ([128.195.23.150]:38622 "HELO
	zima.ucf.ics.uci.edu") by vger.kernel.org with SMTP
	id <S274277AbRIYA04>; Mon, 24 Sep 2001 20:26:56 -0400
Date: Mon, 24 Sep 2001 17:27:21 -0700 (PDT)
From: Edmund Lau <edlau@ucf.ics.uci.edu>
To: linux-kernel@vger.kernel.org
Subject: VmRSS bug on 2.4.10?
Message-ID: <Pine.GSO.4.40.0109241715210.19607-100000@keg.ucf.ics.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I was doing a "ps aux" on my K6-3 machine running 2.4.10.  I haven't seen
this posted on the newsflash page yet so I'll post it here.  I noticed
that my X server was reporting something funny:

root       328  0.0  0.0  1004    4 tty4     S    Sep23   0:00 /sbin/getty
38400 tty4
root       330  0.2 99.9 24376 4294967072 ?  S    Sep23   3:56
/usr/local/pkg/X11R6-4.1.0/bin/X -auth /usr/local/pkg/X11R6-4.1.0/lib/X11/xdm/authdir/authfiles/A:0-fTtaTO
nobody   25244  0.0  2.4  5884 3064 ?        S    06:51   0:14
/usr/local/pkg/apache-1.3.20/bin/httpd

What in the world? 99.9% MEM?  At first I thought it was because I haven't
updated my ps tools and such, but they've been working just fine w/ all
the other 2.4.x kernels I've been running.

Next thing: cat /proc/330/status shows:

VmSize:    24376 kB
VmLck:         0 kB
VmRSS:  4294967072 kB
VmData:     5192 kB
VmStk:        68 kB
VmExe:      1328 kB
VmLib:      1092 kB

Wow!  Wish I had that much memory!  I thought I only put in a single
128meg PC-100 DIMM...  I don't think it's impacting normal functions, but
I'm not on the console to check if X (X11R6-4.1.0) is still working.

/proc/meminfo currently reports:
        total:    used:    free:  shared: buffers:  cached:
Mem:  129900544 117645312 12255232        0  2711552 39165952
Swap: 205557760  1236992 204320768
MemTotal:       126856 kB
MemFree:         11968 kB
MemShared:           0 kB
Buffers:          2648 kB
Cached:          37476 kB
SwapCached:        772 kB
Active:          20240 kB
Inactive:        20656 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126856 kB
LowFree:         11968 kB
SwapTotal:      200740 kB
SwapFree:       199532 kB

Anything I can do to help you guys figure it out?  It's a production
machine so I probably can't help with full blown debugging, but I'll
produce reports as long as someone tells me what to type in :) I'll leave
the X server alone for a week or so.  Please CC me as I'm not on the list.

-Ed

