Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUCJJWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 04:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbUCJJWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 04:22:52 -0500
Received: from ns.cohaesio.net ([212.97.129.16]:50101 "EHLO ns.cohaesio.net")
	by vger.kernel.org with ESMTP id S261567AbUCJJWm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 04:22:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.3 userspace freeze
Date: Wed, 10 Mar 2004 10:12:50 +0100
Message-ID: <222BE5975A4813449559163F8F8CF50345842F@cohsrv1.cohaesio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.3 userspace freeze
Thread-Index: AcQGKQRdvNMMwIu0SDqpSSEyBS8OEgAVFfKA
From: "Anders K. Pedersen" <akp@cohaesio.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

"Andrew Morton" <akpm@osdl.org> wrote:
> It could be a kernel deadlock, or a memory leak, or a disk 
> device driver
> bug.
> 
> Would it be possible to run a `vmstat 1' somewhere and 
> capture the last
> thirty or so lines prior to the reboot?

I ran it again tonight - here are the last lines from 'vmstat 1' on the
serial console:

   procs                      memory      swap          io     system
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
 1  0  0      0  55736  25252 552272    0    0    44    80 1302   614  9
2 90
 0  0  0      0  56952  25284 552308    0    0     0   244 1189   495  4
1 95
 0  0  0      0  56376  25284 552308    0    0     0     0 1205   598  4
1 95
 0  0  0      0  54832  25316 552276    0    0     0   132 1136   528  2
8 91
 0  0  0      0  51488  25324 552268    0    0     0   160 1124   384  4
3 94
 0  0  0      0  51416  25332 552260    0    0     0    48 1091   348  1
0 99
 0  0  0      0  51272  25332 552260    0    0     0     0 1055   290  1
0 98
 0  0  0      0  51072  25332 552260    0    0     0     0 1078   345  1
0 99
 0  0  0      0  50616  25340 552320    0    0     0    40 1156   491  7
9 85
 0  0  0      0  50232  25348 552312    0    0     0    68 1188   509  4
0 95
 0  0  0      0  50232  25356 552372    0    0    16    56 1101   395  1
1 99
 0  0  0      0  50232  25356 552372    0    0     0     0 1075   314  0
0 99
 1  0  0      0  50104  25356 552372    0    0    24     0 1094   323  2
0 98
 0  0  0      0  50232  25364 552364    0    0     0    40 1150   516  3
8 89
 0  0  0      0  50120  25388 552408    0    0    36   324 1151   374  2
1 98
 0  0  0      0  50056  25396 552468    0    0    32    48 1142   401  1
0 99
 2  0  0      0  49032  25396 552604    0    0   108     0 1146   380  3
1 96
 0  0  0      0  49800  25404 552596    0    0    12    32 1250   516  1
0 98
 0  0  0      0  49688  25404 552596    0    0     0     0 1209   532  6
7 87
 0  0  0      0  49368  25412 552588    0    0     0   200 1347   780  6
1 92
 0  0  0      0  49368  25432 552704    0    0    76    64 1296   696 10
2 88
   procs                      memory      swap          io     system
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
 0  0  0      0  48024  25456 552748    0    0    52     0 1148   418  4
3 94
 0  0  0      0  41560  25456 552748    0    0    12     0 1213   483 10
3 87
 0  0  0      0  35504  25464 552740    0    0    32   116 1227   631  8
10 82
 2  0  0      0  26656  25464 552740    0    0     0     0 1274   491 16
6 78
 0  0  0      0  12040  23296 552936    0    0     0   248 1322   691 12
11 77
 4  0  1      0   6128  21452 547368    0    0     4     0 1370   704 16
10 74
 0  0  0      0   6448  17008 533520    0    0     0     0 1138   517  9
18 73
 2  0  0      0   5512  16900 531996    0    0     0   120 1200   560  6
8 86
 0  0  0      0   5832  16792 529724    0    0     8   192 1197   524  7
6 88
 1  0  0      0   6848  16804 529168    0    0    12    68 1148   411  3
2 95
 0  0  0      0   6976  16836 529136    0    0     0   212 1178   428  6
1 93
 0  0  0      0   6976  16836 529136    0    0     0     0 1051   262  0
0 100
 0  0  0      0   6912  16884 529088    0    0    12   116 1137   404  2
1 98
 0  0  0      0   6464  16892 529080    0    0     8     0 1096   364  2
8 90
 0  0  0      0   6016  16788 528504    0    0     8   180 1147   384  4
1 95
 0  0  0      0   6784  16796 527544    0    0     8     0 1105   344  4
1 95
 0  0  0      0   7104  16808 523316    0    0     8     0 1173   493 12
2 86
 0  2  0      0   5952  16608 519980    0    0  4260   200 1860   912 29
10 61
 0  1  0      0   5568  16624 520780    0    0  3852     8 1926   616 16
21 62
 0  1  0      0   5944  16676 518348    0    0  2864   976 1498   829 17
4 79
 1  0  0      0   5680  16524 516324    0    0  1072     4 1405  1003 39
8 53
   procs                      memory      swap          io     system
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
 0  1  0      0   5936  16504 511584    0    0  1188     0 1452  1003 40
7 53
 2  0  0      0   6608  16568 508664    0    0  1116   184 1476  1034 42
6 52
 1  0  0      0   5520  16628 506156    0    0  1056     0 1475  1086 37
22 41
 0  1  0      0   5520  16716 504300    0    0  1176   408 1418  1026 32
7 61
 2  0  0      0   5648  16636 499824    0    0  1172   144 1444  1003 39
6 56
 0  1  0      0   5648  16692 498612    0    0  1176     0 1405   955 33
5 61
 0  1  0      0   6040  16708 494584    0    0  1072   344 1422  1069 33
7 59
 0  1  0      0   6056  16728 491300    0    0   852     0 1462   976 38
23 39
 0  1  0      0   7080  16660 488580    0    0  1112   336 1492  1050 27
6 67
 1  0  0      0   5864  16700 486976    0    0  1200   116 1502  1209 20
5 75
 0  1  0      0   6568  16584 482060    0    0  1592     0 1514  1204 24
8 68
 9  0  9      0 508980  16616 469516    0    0  1452   708 3347  1647 14
68 18
 6  0  0      0 476088  17520 470924    0    0  2396   316 1449  2154 80
19  1
 3  0  0      0 474096  17680 470968    0    0   140     0 1131  4116 87
13  0
 4  0  0      0 471792  17716 471000    0    0     0  1564 1080  5567 87
13  0
 1  1  0      0 463344  17804 477372    0    0  5856     0 1438  3048 87
10  3
 3  0  0      0 456880  17980 481140    0    0  4605     0 1758  2237 78
18  4
 2  0  0      0 455408  18616 481184    0    0   584  2080 1259   731 77
20  3
 2  0  2      0 442136  19096 481180    0    0   484     0 1158   467 45
55  0
 3  0  1      0 430520  19300 481248    0    0   172   284 1119   329 11
89  0
 0  2  0      0 418720  19508 481244    0    0   200     8 1085   301 12
88  0
   procs                      memory      swap          io     system
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
 2  0  0      0 399552  20080 482032    0    0  1255   822 1232   691 44
44 12
 7  3  0      0 331768  20208 482448    0    0   588     0 1424   788 60
40  0
 0  1  0      0 293128  20464 482668    0    0   412     0 1576   980 56
34  9
 0  1  1      0 289544  21364 482856    0    0  1056   252 1526  1380  9
7 85
 2  1  0      0 285000  22376 483068    0    0  1164    24 1551  1259 16
5 79
 0  1  1      0 277976  23024 483372    0    0   924    60 1674  1442 30
7 64
 0  1  0      0 273560  23828 483520    0    0   900  1128 1480  1149  9
21 70
 0  1  0      0 268832  24656 483576    0    0   864     0 1373   844  9
5 86
SOFTDOG: Initiating system reboot.

I also got had a top running - this is the last output before it froze:

 04:02:33  up  3:33,  2 users,  load average: 1.27, 0.44, 0.35
266 processes: 265 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  24.4% user  15.1% system    0.1% nice  22.0% iowait  38.2%
idle
CPU1 states:  25.2% user  13.2% system    0.2% nice  49.2% iowait  11.1%
idle
Mem:  2072988k av, 1795780k used,  277208k free,       0k shrd,   23232k
buff
       573192k active,             372544k inactive
Swap: 8384880k av,       0k used, 8384880k free                  483436k
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU
COMMAND
      httpd     16   0  111M 104M 11320 S    62.8  5.1   0:25   0 httpd
 4306 root      16   0  2476 1464  1936 R     3.3  0.0   5:57   1 top
29761 root      34  19  1464  520  1368 D N   2.5  0.0   0:00   0
updatedb
29889 root      16   0 29628  27M  1712 S     2.1  1.3   0:00   1
rotatelogspsoft
 1515 root      16   0  372M  65M 44444 S     0.7  3.2   1:10   1
caspeng
 1973 root      16   0  1416  472  1356 S     0.7  0.0   1:40   1 vmstat
29891 root      16   0  2584 1300  1712 S     0.5  0.0   0:00   1
rotatelogspsoft
 1559 root      16   0  2068 1064  1864 S     0.3  0.0   0:44   1
soagent
29890 root      16   0  2684 1400  1712 S     0.3  0.0   0:00   1
rotatelogspsoft
    1 root      16   0  1376  484  1328 S     0.0  0.0   0:01   0 init
    2 root      RT   0     0    0     0 SW    0.0  0.0   0:00   0
migration/0
    3 root      34  19     0    0     0 SWN   0.0  0.0   0:00   0
ksoftirqd/0
    4 root      RT   0     0    0     0 SW    0.0  0.0   0:00   1
migration/1
    5 root      34  19     0    0     0 SWN   0.0  0.0   0:00   1
ksoftirqd/1
    6 root       5 -10     0    0     0 SW<   0.0  0.0   0:00   0
events/0
    7 root       5 -10     0    0     0 SW<   0.0  0.0   0:00   1
events/1
    8 root       5 -10     0    0     0 SW<   0.0  0.0   0:00   0
kblockd/0
    9 root       5 -10     0    0     0 SW<   0.0  0.0   0:00   1
kblockd/1
   10 root      15   0     0    0     0 SW    0.0  0.0   0:00   0 khubd
   14 root      15   0     0    0     0 SW    0.0  0.0   0:07   1
kswapd0
   13 root      25   0     0    0     0 SW    0.0  0.0   0:00   0
pdflush
   12 root      15   0     0    0     0 SW    0.0  0.0   0:00   1
pdflush
   11 root      15   0     0    0     0 SW    0.0  0.0   0:00   0 kirqd
   15 root      15 -10     0    0     0 SW<   0.0  0.0   0:00   0 aio/0
   16 root      10 -10     0    0     0 SW<   0.0  0.0   0:00   1 aio/1
   17 root      25   0     0    0     0 SW    0.0  0.0   0:00   1
scsi_eh_0
   18 root      19   0     0    0     0 SW    0.0  0.0   0:00   0
kseriod
   19 root      15   0     0    0     0 SW    0.0  0.0   0:02   1
kjournald
  155 root      15   0     0    0     0 SW    0.0  0.0   0:00   1
kjournald
  156 root      15   0     0    0     0 DW    0.0  0.0   0:00   1
kjournald
  157 root      15   0     0    0     0 SW    0.0  0.0   0:03   1
kjournald
  236 root      18   0  1352  404  1312 S     0.0  0.0   0:00   0
mingetty
  303 root       6 -10  1356  420  1308 S <   0.0  0.0   0:00   0
watchdogd
  591 root      16   0  1428  540  1368 S     0.0  0.0   0:01   1
syslogd
  596 root      16   0  1368  444  1324 S     0.0  0.0   0:00   0 klogd
  760 ntp       16   0  1896 1892  1740 S     0.0  0.0   0:00   1 ntpd
  781 named     15   0 52648  50M  2056 S     0.0  2.4   0:12   1 named
  799 root      15   0  3468 1484  3184 S     0.0  0.0   0:00   1 sshd
  902 root      16   0  3708 1200  3416 S     0.0  0.0   0:00   1 master

If you need anything further, please let me know.

Med venlig hilsen - Best regards

Anders K. Pedersen
Network Engineer
------------------------------------------------ 
Cohaesio A/S - Maglebjergvej 5D - DK-2800 Lyngby
Phone: +45 45 880 888  - Fax: +45 45 880 777
Mail: akp@cohaesio.com - http://www.cohaesio.com
------------------------------------------------
