Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbULWPsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbULWPsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 10:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbULWPsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 10:48:47 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:58310 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261255AbULWPsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 10:48:43 -0500
Date: Thu, 23 Dec 2004 16:48:41 +0100 (CET)
From: Folkert van Heusden <folkert@vanheusden.com>
X-X-Sender: <folkert@muur.intranet.vanheusden.com>
To: bert hubert <ahu@ds9a.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: pc stalling when processing large files [2.6.9]
In-Reply-To: <20041223135059.GA12540@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.33.0412231644200.19464-100000@muur.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > /usr/sbin/hdparm -c 3 -d 1 -X 69 -u 1 /dev/hda
> And if you remove that line, does that help?

No since disk-i/o goes back to 3MB/s then.

> Also, output of 'vmstat 1' during stalls would be helpful.

procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
wa
 1 13 272232   1880   3752  19952   15    7     0     2    6    24  7  1 88
4
 0 14 272636   1236   3752  19900   68 1220    68  1408 1216   441 10  2  0
88
 0 12 272904    992   3752  19888   48 1356    48  1356 1205   225  4  2  0
94
 0 14 273800    584   3784  19788  540 3600   716  3608 3643   731  3  2  0
95
 0 17 273940    856   3792  19788  284  660   300   664 1202   313  0  3  0
97
 0 16 274068    840   3800  20072  296  796   588   860 1146   224  5  2  0
93
 0 15 274504   1232   3804  20284   48 1036   264  1036 1153   286  3  3  0
94
 0 20 277020   1344   3868  20908 1048 8212  1896  8508 7863  2125  6  3  0
91
 0 17 277688   1192   3868  20904    0 1484     0  1488 1208   236 11  2  0
87
 0 17 278728    680   3868  20884    0 1504     0  1548 1204   474  8  4  0
88
 0 16 279428   1392   3852  20980    0 1712   104  1716 1191   240  1  3  0
96
 0 19 280080   4964   3852  21112   32 1652   168  1652 1215   272 18  4  0
78
 0 14 280436   1376   3868  21112    0 1180     8  1460 1192   193 29  5  0
66
 1  9 280768   2144   3868  21112    4  940     4   940 1208   234  0  1  0
99
 0 15 281472   1032   3888  21044   32 1312    48  1316 1202   251  9  3  0
88
 2  7 282356   2628   3888  20948   16 1280    16  1284 1244   308 21  5  0
74
 0  9 282816    672   3888  20928    0 1000     0  1072 1182   212  9  3  0
88
 0 13 284020    848   3896  20664    0 3488     0  3816 3778   586  3  1  0
96
 0 13 284752    656   3896  20656    0 1488     0  1488 1201   284  4  2  0
94
 0 13 285768    720   3900  20656    0 1352     0  1356 1208   280  5  2  0
93
 0  9 286848   1688   3900  20544   64 5028    64  5028 1283   300  3  4  0
93
 0  9 288312   1504   3940  20348   32 3596   292  3632 1399   678 22 11  0
67
 0 21 288492    736   3944  19960   56 1096   300  1100 1209   248  8  3  0
89
 0 16 290128    992   3944  19960   32 2072    32  2076 1234   232  4  3  0
93
 0 10 293500    672   3936  19980   64 3376   136  3456 1236   290  8  4  0
88
 3 10 297412   1596   3836  18892    0 3912   184  3916 1493   355 27  9  0
64
 0 12 301468    736   3856  19008    8 4068   220  4140 1342   289 17  6  0
77
 0 13 305624    664   3876  19000   64 4176   128  4180 1308   307 10  6  0
84
 0 16 309084    664   3872  19068   92 3480   268  3824 1284   268 25  7  0
68
 0 12 317984    976   3776  18704  100 8908   348  9100 2635   542 25  6  0
69
 0 13 319692    792   3836  19716   36 1712  1160  1744 1241   300  6  5  0
89
 0 14 322012   1576   3904  20000  524 2412   900  2412 1254   414  4  4  0
92
 0 10 327280   1808   3912  19852 1700 5536  1712  5784 1725   448  7  3  0
90
 0 11 334216    720   3900  19780  224 6972   224  6976 1227   213 19  6  0
75
 0 10 335988   3928   3900  19008 2128 2112  2140  2112 1218   410 20  3  0
77


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+

