Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130793AbRCFN6m>; Tue, 6 Mar 2001 08:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130821AbRCFN6b>; Tue, 6 Mar 2001 08:58:31 -0500
Received: from mailserver-ng.cs.umbc.edu ([130.85.100.230]:48289 "EHLO
	mailserver-ng.cs.umbc.edu") by vger.kernel.org with ESMTP
	id <S130793AbRCFN6I>; Tue, 6 Mar 2001 08:58:08 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.2ac7 success story, one question
From: Ian Soboroff <ian@cs.umbc.edu>
Emacs: Our Lady of Perpetual Garbage Collection
Date: 06 Mar 2001 08:57:06 -0500
Message-ID: <87k863xaod.fsf@danube.cs.umbc.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


since of course all anyone hears are the disaster reports, i just
wanted to throw out my experience so far with 2.4... 2.4.0 and 2.4.1
didn't work very well on my box (a Dell Latitude CS-X laptop, PII-400,
256MB RAM, 20GB IDE), but i'm currently running 2.4.2-ac7 with no
problems at all.  the only difficulties i've had are that i've tried
the in-kernel PCMCIA on each 2.4 release with no luck (nothing works
with all my Ethernet cards, primarily my Farallon cardbus tulip card,
but also with my wavelan wireless and IDE cards), so i use David
Hinds' drivers.

performance in general screams, but sometimes when i start up a large
process (netscrape, or vmware) it dogs down for a couple seconds.

the one question i have is about VM.  the machine has 256MB of RAM in
it, and i never get near this usage with the actual processes
running.  nevertheless, /proc/meminfo says:
danube:/# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  262098944 257241088  4857856        0 81330176 91557888
Swap: 127950848 57208832 70742016
MemTotal:       255956 kB
MemFree:          4744 kB
MemShared:           0 kB
Buffers:         79424 kB
Cached:          89412 kB
Active:         164996 kB
Inact_dirty:      1244 kB
Inact_clean:      2596 kB
Inact_target:      104 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255956 kB
LowFree:          4744 kB
SwapTotal:      124952 kB
SwapFree:        69084 kB

if 90MB are just cache, why do i have ~55MB swapped?  i'm not sure how
to see exactly how much of that swap is really being used or how often
things move in and out of swap, though.

ian

-- 
----
Ian Soboroff                                       ian@cs.umbc.edu
University of MD Baltimore County      http://www.cs.umbc.edu/~ian
