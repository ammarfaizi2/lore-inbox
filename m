Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132584AbRDKO33>; Wed, 11 Apr 2001 10:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132598AbRDKO3S>; Wed, 11 Apr 2001 10:29:18 -0400
Received: from wilhelm.eyp.ee ([193.40.76.18]:2820 "EHLO wilhelm.eyp.ee")
	by vger.kernel.org with ESMTP id <S132590AbRDKO2C>;
	Wed, 11 Apr 2001 10:28:02 -0400
Message-ID: <3AD46930.B6CC9565@eyp.ee>
Date: Wed, 11 Apr 2001 16:24:48 +0200
From: Priit Randla <priit.randla@eyp.ee>
Organization: Eesti =?iso-8859-1?Q?=DChispank?=
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: scheduler went mad?
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
   

   Yesterday i tried to start cdda2wav but somehow it didn't do
anything.
  It didn't die to kill -9 too. Machine was slow but usable. 
  vmstat 10 output:

  procs                      memory    swap          io    
system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us 
sy  id
 2  0  1   2972  40916    108  18292   0   0     0     0  121 12735   0
100   0
 2  0  1   2972  40492    108  18292   0   0     0     0  109 12740   1 
99   0
 2  0  1   2972  40492    108  18292   0   0     0     0  103 12996   0
100   0
 3  0  0   2972  40492    108  18292   0   0     0     0  102 12932   0
100   0
 3  0  1   2972  40492    108  18292   0   0     0     0  131 12652   1 
99   0
 2  0  0   2972  40496    108  18292   0   0     0     0  142 12562   1 
99   0
 2  0  0   2972  40500    108  18292   0   0     0     0  120 12684   0
100   0
 2  0  1   2972  40496    108  18292   0   0     0     0  140 12480   1 
99   0
 2  0  0   2972  39952    108  18292   0   0     0     0  160 11445   7 
93   0
 3  0  0   2972  39952    108  18292   0   0     0     0  178 12295   2 
98   0
 2  0  0   2972  39956    108  18292   0   0     0     0  214 11958   2 
98   0
 3  0  1   2972  39952    108  18292   0   0     0     0  138 12579   1 
99   0

cs field is absolutely ridiculous for my machine.																							

ps showed cdda2wav & kswapd eating all of processor time. When i tried
to close
netscape, it hang too and joined cdda2wav and kswapd:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME
COMMAND
 9990 priitr    17   0 42380  41M  9928 R       0 32.5 33.4  21:47
netscape-commun
    3 root      17   0     0    0     0 SW      0 32.3  0.0  11:12
kswapd
10538 priitr    16   0    84    8     0 R       0 32.3  0.0  11:09
cdda2wav
    5 root       9   0     0    0     0 SW      0  1.5  0.0   0:19
bdflush
10616 priitr    13   0   856  856   668 R       0  0.7  0.6   0:00 top
  657 root       9   0 21160  20M  1668 S       0  0.1 16.7  29:36 X


I couldn't leave X and had to kill it. After that, both netscape and
cdda2wav were
gone and everything looks normal since then.
I'm running 2.4.3ac3 right now.

dmesg:
