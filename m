Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267054AbRGIMoR>; Mon, 9 Jul 2001 08:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267055AbRGIMoH>; Mon, 9 Jul 2001 08:44:07 -0400
Received: from mx1.nameplanet.com ([62.70.3.31]:3597 "HELO mx1.nameplanet.com")
	by vger.kernel.org with SMTP id <S267054AbRGIMn4>;
	Mon, 9 Jul 2001 08:43:56 -0400
Date: Mon, 9 Jul 2001 16:36:50 +0200 (CEST)
From: Ketil Froyn <ketil@froyn.com>
X-X-Sender: <ketil@ketil.np>
To: <linux-kernel@vger.kernel.org>
Subject: 0k shared?
Message-ID: <Pine.LNX.4.33.0107091622510.1031-100000@ketil.np>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This may be a stupid question, but I found this strange. In making a small
benchmarking utility, I made the following directory structure by mistake:
a/a/a/a/a/a/a/a/a/a/.....

By ..... I mean this goes on and on, there were around 18 thousand
directories inward like this. A great example of the damage a bug in a
recursive program can do ;) Anyway, I've removed it now (btw, rm -rf on
this sigsegved :D).

And now for the question. My /proc/meminfo looks like this:

        total:    used:    free:  shared: buffers:  cached:
Mem:  195678208 192753664  2924544        0 116613120 45502464
Swap: 361902080 98807808 263094272
MemTotal:       191092 kB
MemFree:          2856 kB
MemShared:           0 kB
Buffers:        113880 kB
Cached:          44436 kB
Active:          20256 kB
Inact_dirty:    136116 kB
Inact_clean:      1944 kB
Inact_target:        8 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       191092 kB
LowFree:          2856 kB
SwapTotal:      353420 kB
SwapFree:       256928 kB

As you can see, there is no shared memory here. Is this something I ought
to worry about, or is it normal? I've been using the system, and since
things were lagging, I looked at 'top', and this just caught my eye.
Any reason for worry?

And if you *really* want me to, I can see if I can reproduce this, though
I'd rather not. :-)

# uname -a
Linux ketil.np 2.4.3 #3 SMP Sat Jun 30 05:23:12 CEST 2001 i686 unknown

The kernel has the international kernel patch.

Ketil

