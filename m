Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276445AbRI2HHi>; Sat, 29 Sep 2001 03:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276446AbRI2HH2>; Sat, 29 Sep 2001 03:07:28 -0400
Received: from [213.97.45.174] ([213.97.45.174]:53007 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S276445AbRI2HHW>;
	Sat, 29 Sep 2001 03:07:22 -0400
Date: Sat, 29 Sep 2001 09:07:39 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.9-ac16 performs great under heavy memmory pressure
Message-ID: <Pine.LNX.4.33.0109290907030.10387-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running a nautilus process in a directory with 1600 pictures and enlarging
them to 200% (heavy cpu and RAM usage), I can still write this email
without problems.

Good work!!

[pau@pau pau]$ vmstat -n 5
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  1  0 340604   2800    552  13480  36  16    73    32  123    17  94   3   3
 0  3  1 343892   2800    548  12532 934 302  1065   303  178   327  24   4  72
 0  3  1 347428   2832    536  12608  54 1454    75  1454  207   197   4   2  94 2  3  0 347696   2800    500  14316 609 424  1078   426  178   277   7   3  89
 2  0  0 350012   2800    540  14552 1164   0  1419     0  175   404  21   4  75 3  0  0 353652   2800    520  14448 259 1400   294  1400  193   285  10   4  86 0  1  0 351900   2800    552  14404 1175   0  1426     0  158   337  31   2  67 2  1  1 357716   2800    524  14124 346 1791   392  1790  186   321  12   4  84 2  0  0 360672   2800    536  14716 677 348   846   349  180   351  19   4  77
 0  3  0 362284   2800    572  13124 1217   0  1441     0  185   410  21   5  75 1  2  0 368268   2812    512  12900 468 1430   535  1430  234   437  10   8  83 0  1  0 367244   2800    544  12860 1206   0  1392     0  203   535  22   5  73 2  2  1 368476   2800    452  12024 814 1284   901  1350  173  1008  16   7  77 2  0  0 377232   2800    440  12524 172 1130   301  1131  200   362   7   4  89 0  1  0 375556   2800    472  11508 1435   0  1594     0  167   382  25   4  72 0  1  1 382908   2800    456  11380 1186 180  1358   180  170   356  23   5  73 0  2  0 384184   2800    436  11336 361 1398   394  1399  270   328   2   4  93 3  0  0 385472   2800    540  12264 1783   0  2146     0  183   360   8   3  88 1  0  0 386784   2800    520  11604 587 1861   603  1861  203   338   6   4  89 2  0  0 383388   2800    536  11300 2173   0  2226     2  178   388  10   4  87 0  5  1 385280   2804    508  11396 749 1682   817  1683  181   330  10   4  85 0  3  0 391780   2800    508!
  11548 123 729   197   731  201   287   6   3  91
 1  1  0 391516   2800    564  12028 1407   0  1591     0  183   389  13   5  82 0  2  1 391372   2808    556   9396 1626 457  1708   458  202   372  14   4  83 1  2  0 393540   2800    548   9440  57 1190    68  1191  209   287   5   4  91 0  1  0 389832   2800    560   9524 1711   0  1806     0  206   422  17   3  79 1  3  0 392852   2804    464  10300 654 1196   817  1198  204   345   6   5  89 1  3  0 397316   2800    484  10392 110 707   180   708  227   333   4   3  92
 2  4  0 395440   2800    548  11660 1083   0  1556     0  191   386  11   3  86

  9:19pm  up 13:46,  9 users,  load average: 2,27, 1,93, 1,49
137 processes: 134 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  9,3% user,  4,6% system,  0,0% nice, 85,9% idle
Mem:   127072K av,  124272K used,    2800K free,     612K shrd,     512K
buff
Swap:  401536K av,  368028K used,   33508K free                   12576K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1182 pau       15   0  247M  34M  4656 R     5,4 27,4   5:44 nautilus
 1275 pau       13   0  2740 2184  1868 S     2,5  1,7  19:38 deskguide_apple
19634 pau       18   0  1020  964   756 R     2,1  0,7   0:18 top
    4 root      10   0     0    0     0 SW    1,1  0,0   0:25 kswapd
 1192 pau        9   0 10024 2224  1744 S     0,9  1,7   0:23 gnome-terminal
 1045 root       9   0 61288 9172  2072 S     0,7  7,2  84:04 X
20549 pau        9   0   524  496   444 S     0,3  0,3   0:00 vmstat
    1 root       8   0   536  480   464 S     0,0  0,3   0:04 init
    2 root       9   0     0    0     0 SW    0,0  0,0   0:01 keventd
    3 root      19  19     0    0     0 SWN   0,0  0,0   0:00 ksoftirqd
    5 root       9   0     0    0     0 SW    0,0  0,0   0:00 kreclaimd
    6 root       9   0     0    0     0 SW    0,0  0,0   0:00 bdflush
    7 root       9   0     0    0     0 SW    0,0  0,0   0:00 kupdated
   89 root       9   0     0    0     0 SW    0,0  0,0   0:00 khubd
  171 root      -1 -20     0    0     0 SW<   0,0  0,0   0:00 mdrecoveryd
  536 root       9   0   588  512   508 S     0,0  0,4   0:00 syslogd
  541 root       9   0  1052  440   436 S     0,0  0,3   0:00 klogd
  553 rpc        9   0   528  440   440 S     0,0  0,3   0:00 portmap
  633 root       9   0  1968 1968  1712 S     0,0  1,5   0:00 ntpd
  681 root       8   0   596  508   504 S     0,0  0,3   0:00 automount
  693 daemon     9   0   544  472   468 S     0,0  0,3   0:00 atd
  708 named      9   0  3608 1700  1124 S     0,0  1,3   0:00 named
  712 named      9   0  3608 1700  1124 S     0,0  1,3   0:00 named
  713 named      9   0  3608 1700  1124 S     0,0  1,3   0:29 named
  714 named      9   0  3608 1700  1124 S     0,0  1,3   0:00 named
  715 named      9   0  3608 1700  1124 S     0,0  1,3   0:03 named
  724 root       9   0   720  524   520 S     0,0  0,4   0:00 sshd
  738 root       9   0   872  660   656 S     0,0  0,5   0:00 xinetd
  760 lp         8   0   672  524   520 S     0,0  0,4   0:00 lpd
  775 root       9   0   784  608   608 S     0,0  0,4   0:00 safe_mysqld
  791 root       9   0   544  508   456 S     0,0  0,3   0:02 noflushd
  821 mysql      9   0  3340  668   656 S     0,0  0,5   0:00 mysqld
  827 mysql      9   0  3340  668   656 S     0,0  0,5   0:00 mysqld
  829 mysql      9   0  3340  668   656 S     0,0  0,5   0:00 mysqld
  849 mysql      9   0  3340  668   656 S     0,0  0,5   0:00 mysqld
  892 root       9   0   476  420   404 S     0,0  0,3   0:00 gpm
  904 root       8   0   688  612   600 S     0,0  0,4   0:00 crond
  944 xfs        9   0  7112  648   648 S     0,0  0,5   0:06 xfs
  972 root       8   0   540  464   460 S     0,0  0,3   0:00 rhnsd
 1008 setiatho  19  19  1272  756   752 S N   0,0  0,5 636:12 setiathome
 1019 root       9   0     0    0     0 SW    0,0  0,0   5:14 kapm-idled
 1032 root       9   0   424  364   360 S     0,0  0,2   0:00 mingetty
 1033 root       9   0   424  364   360 S     0,0  0,2   0:00 mingetty
 1034 root       9   0   424  364   360 S     0,0  0,2   0:00 mingetty
 1035 root       9   0   424  364   364 S     0,0  0,2   0:00 mingetty
 1036 root       9   0   424  364   360 S     0,0  0,2   0:00 mingetty
 1037 root       9   0   940  672   672 S     0,0  0,5   0:00 gdm
 1044 root       9   0  1336  872   868 S     0,0  0,6   0:00 gdm
 1052 pau        9   0  2268 1300  1296 S     0,0  1,0   0:00 gnome-session



Pau

