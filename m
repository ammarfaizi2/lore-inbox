Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275114AbRIYRFz>; Tue, 25 Sep 2001 13:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275115AbRIYRFp>; Tue, 25 Sep 2001 13:05:45 -0400
Received: from [213.97.45.174] ([213.97.45.174]:16388 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S275114AbRIYRFf>;
	Tue, 25 Sep 2001 13:05:35 -0400
Date: Tue, 25 Sep 2001 19:04:58 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: Rik van Riel <riel@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.9-ac15 painfully sluggish
In-Reply-To: <Pine.LNX.4.33L.0109251336380.26091-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0109251855450.1309-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Rik van Riel wrote:

> Could you send me one screen's worth of output from top
> and 5 lines from 'vmstat -a 5' ?

This is what happens only trying to start evolution for the first time,
nothing else. With ac10 works perfectly. With ac15 it takes minutes, at
least 4.

It was even worst the first time I run the ac15 kernel when updatedb run
the find in all the directories.

Now I can hardly write this email with pine.

[pau@pau pau]$ vmstat -n 5
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  6  1   2392   3040    476   9644   5   7   585    17  170   479  85   6   9
 2 12  0   2520   2800    408   9028  25  27  1425    35  208   184  92   6   2
 2  4  0   2596   2812    408   9500  15  22  1174    24  204   304  79   6  16
 4  5  1   2316   2800    432   9044  47   5  1150     5  227   420  85   7   8
 2  4  0   2344   2848    412   8988  30  18  1210    26  238   364  77  11  12
 3  3  0   2480   2800    416   8916  15  27  1050    30  188   223  93   6   2
 1  3  0   2520   3832    436   8688  22  24  1110    26  195   351  85   5   9
 2  9  0   2628   2800    420   9808   4  31  1342    32  191   322  90   8   3
 1 10  0   2616   2800    412  10032  33  26  1459    26  241   244  94   6   0
 3  7  1   2584   2812    420  10476  10  10  1494    10  206   221  53   6  41
 1  7  0   2440   2780    468   9944  49   0  1102     0  187   228  95   5   0

  6:58pm  up 14 min,  5 users,  load average: 7,68, 6,21, 3,22
112 processes: 110 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:  2,7% user,  5,2% system, 92,0% nice,  0,0% idle
Mem:   127072K av,  124272K used,    2800K free,     564K shrd,     440K buff
Swap:  401536K av,    2132K used,  399404K free                    9368K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1008 setiatho  19  19 14796  14M   152 R N  92,4 11,6  11:37 setiathome
    4 root       9   0     0    0     0 SW    3,3  0,0   0:20 kswapd
 1130 pau        9   0  1916 1916   512 S     1,2  1,5   0:02 sawfish
 1516 root      12   0   568  568   324 R     1,2  0,4   0:05 top
 1045 root       9   0 25712  16M   616 S     0,9 13,5   0:21 X
 1275 pau        9   0  1376 1376   540 D     0,3  1,0   0:13 deskguide_apple
 1403 pau        9   0  9512 9512   340 S     0,3  7,4   0:04 galeon-bin
    1 root       8   0   100  100    28 S     0,0  0,0   0:04 init
    2 root       9   0     0    0     0 SW    0,0  0,0   0:00 keventd
    3 root      19  19     0    0     0 SWN   0,0  0,0   0:00 ksoftirqd_CPU0
    5 root       9   0     0    0     0 SW    0,0  0,0   0:00 kreclaimd
    6 root       9   0     0    0     0 SW    0,0  0,0   0:00 bdflush
    7 root       9   0     0    0     0 SW    0,0  0,0   0:00 kupdated
   89 root       9   0     0    0     0 SW    0,0  0,0   0:00 khubd
  171 root      -1 -20     0    0     0 SW<   0,0  0,0   0:00 mdrecoveryd
  536 root       9   0   100  100     0 S     0,0  0,0   0:00 syslogd
  541 root       9   0   616  616     0 S     0,0  0,4   0:00 klogd
  553 rpc        9   0    92   92     0 S     0,0  0,0   0:00 portmap
  633 root       9   0  1968 1968  1712 S     0,0  1,5   0:00 ntpd
  681 root       9   0   132  132    28 S     0,0  0,1   0:00 automount
  693 daemon     9   0    76   76     0 S     0,0  0,0   0:00 atd
  708 named      9   0  1756 1756    92 S     0,0  1,3   0:00 named
  712 named      9   0  1756 1756    92 S     0,0  1,3   0:00 named
  713 named      9   0  1756 1756    92 S     0,0  1,3   0:00 named
  714 named      9   0  1756 1756    92 S     0,0  1,3   0:00 named
  715 named      9   0  1756 1756    92 S     0,0  1,3   0:00 named
  724 root       9   0   200  200     0 S     0,0  0,1   0:00 sshd
  738 root       9   0   216  200     0 S     0,0  0,1   0:00 xinetd
  760 lp         9   0   152  152     0 S     0,0  0,1   0:00 lpd
  775 root       9   0   180  180     0 S     0,0  0,1   0:00 safe_mysqld
  803 root       9   0   140  140    56 S     0,0  0,1   0:00 noflushd
  821 mysql      9   0  2700 2700    16 S     0,0  2,1   0:00 mysqld
  827 mysql      9   0  2700 2700    16 S     0,0  2,1   0:00 mysqld
  828 mysql      9   0  2700 2700    16 S     0,0  2,1   0:00 mysqld
  836 root       9   0   580  580    40 S     0,0  0,4   0:00 sendmail
  847 mysql      9   0  2700 2700    16 S     0,0  2,1   0:00 mysqld
  879 junkbust   8   0   524  524     0 S     0,0  0,4   0:00 junkbuster
  892 root       9   0    84   84    12 S     0,0  0,0   0:00 gpm
  904 root       8   0   152  152    44 S     0,0  0,1   0:00 crond
  944 xfs        9   0  3224 3224     0 S     0,0  2,5   0:00 xfs
  969 root       9   0    80   80     0 S     0,0  0,0   0:00 rhnsd
 1019 root       9   0     0    0     0 SW    0,0  0,0   0:00 kapm-idled
 1031 root       9   0    64   64     0 S     0,0  0,0   0:00 mingetty
 1032 root       9   0    64   64     0 S     0,0  0,0   0:00 mingetty
 1033 root       9   0    64   64     0 S     0,0  0,0   0:00 mingetty
 1034 root       9   0    64   64     0 S     0,0  0,0   0:00 mingetty
 1035 root       9   0    64   64     0 S     0,0  0,0   0:00 mingetty
 1036 root       9   0    64   64     0 S     0,0  0,0   0:00 mingetty
 1037 root       9   0   268  268   140 S     0,0  0,2   0:00 gdm


Pau

