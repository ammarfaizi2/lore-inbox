Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270179AbRHMNG4>; Mon, 13 Aug 2001 09:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270180AbRHMNGq>; Mon, 13 Aug 2001 09:06:46 -0400
Received: from mail.intrex.net ([209.42.192.246]:23315 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S270179AbRHMNGi>;
	Mon, 13 Aug 2001 09:06:38 -0400
Date: Mon, 13 Aug 2001 09:07:43 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Still problems with 2.4.8 VM
Message-ID: <20010813090743.A7418@bessie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I am trying out the 2.4.8-pre8 VM (which I hope is the same as the 2.4.8
VM).  I am still having problems with the machine becomming unresponsive for
long periods of time.  It does seem to be somewhat better than 2.4.5 which
could dissappear for several minutes at a time.  However I still see this
kernel disappearing for maby 30 seconds at a time.  From what I can tell
with top, kswapd is running a lot:

67 processes: 57 sleeping, 10 running, 0 zombie, 0 stopped
CPU0 states:  0.5% user, 96.26% system,  0.0% nice,  2.29% idle
CPU1 states:  0.3% user, 97.3% system,  0.0% nice,  2.23% idle
Mem:  2059864K av, 2054856K used,    5008K free,       0K shrd,     636K buff
Swap: 4192880K av, 2270408K used, 1922472K free                  299064K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    5 root      20   0     0    0     0 SW   96.6  0.0  18:46 kswapd
20460 jnance    20   0 1176M 263M  170M R    96.6 13.1  13:24 tclsh8.2
20495 jnance    14   0  1164 1164   924 R     0.4  0.0   0:00 top
20466 jnance    12   0 1176M 264M  208M D     0.2 13.1  13:16 tclsh8.2
    1 root       8   0   112   60    60 S     0.0  0.0   0:06 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd

I am a bit confused by this though.  The RSS of the two large processes totals
about 530M.  The machine has 2G of ram so why do I need to swap at all?

Oh, Here is a good way to demonstrate how sluggish things are:

    lucy> date; sleep 5; date
    Mon Aug 13 06:04:56 PDT 2001
    Mon Aug 13 06:05:22 PDT 2001

Perhaps this would be helpful too:
lucy> vmstat 5 5
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  2  1 2377836  5012    620 294044   3   5     3     7   72    30   1   1   6
 0  2  1 2377836  4772    620 290792 661 3242   661  3344  312    79   1   2  98
 0  2  1 2377836  4940    620 288780 457 2770   457  2796  491    74   1   2  97
 0  2  1 2377836  4928    628 282952 1196 6781  1198 6806  332   122   1   2  96
 0  2  1 2377836  4728    628 278660 946 5105   946  5463  313    98   1   2  97

Let me know if any further information would be helpful.

Thanks,

Jim
