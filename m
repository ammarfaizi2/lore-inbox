Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287109AbSALPXM>; Sat, 12 Jan 2002 10:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287111AbSALPXC>; Sat, 12 Jan 2002 10:23:02 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:55542 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S287109AbSALPWw>; Sat, 12 Jan 2002 10:22:52 -0500
Message-ID: <00be01c19b7d$e47e6330$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <009e01c19b7c$463457d0$02c8a8c0@kroptech.com>
Subject: Re: Writeout in recent kernels/VMs poor compared to last -ac
Date: Sat, 12 Jan 2002 10:29:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 12 Jan 2002 15:29:14.0965 (UTC) FILETIME=[E47C4050:01C19B7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arg... Sorry for the wrapped vmstat output. This should be better...

--Adam

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy id
 0  1  1      0   4408   2712 118756   0   0     0     0  109    16   0   0 100
 0  1  1      0   4436   2716 118724   0   0     1  3913  287    13   0   8 92
 0  1  0      0   4436   2716 118724   0   0     0     0  118    11   0   0 100
 0  0  0      0   4352   2724 118816   0   0     8     0 3639   203   2  28 70
 0  0  0      0   4420   2736 118752   0   0    11     0 4530   259   0  33 67
 0  0  0      0   4348   2744 118816   0   0    10     0 4273   245   0  42 58
 1  0  0      0   4376   2756 118772   0   0    11     0 4551   246   1  39 60
 0  1  1      0   4364   2760 118724   0   0     4  6730 1710    93   1  19 80
 0  1  1      0   4364   2760 118724   0   0     0     0  108     9   0   0 100
 0  1  1      0   4364   2760 118724   0   0     0  3667  117     9   0   2 98
 0  1  1      0   4364   2760 118724   0   0     0     0  125     8   0   0 100
 1  0  1      0   4364   2760 118724   0   0     0  3819  124    10   0   2 98
 0  1  1      0   4372   2760 118704   0   0     0  2055  195    10   0   5 95
 0  1  1      0   4372   2760 118704   0   0     0     0  120     6   0   0 100
 0  1  1      0   4408   2760 118668   0   0     0  2415  203    16   0   4 96
 0  1  1      0   4472   2760 118608   0   0     0  4321  280    18   1   6 93
 0  2  1      0   4468   2760 118608   0   0     0     0  112     8   0   0 100
 0  1  1      0   4352   2760 118724   0   0     1  3232  227     9   0  10 90
 0  1  1      0   4352   2760 118724   0   0     0     0  108     8   0   0 100
 0  0  0      0   4440   2768 118696   0   0     7     0 3233   179   1  25 74
 1  0  0      0   4448   2776 118680   0   0    11     0 4417   253   0  36 63

-ac, on the other hand, is very smooth (still a noticeable oscillation, but
far more consistent):

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy id
 0  1  0      0   3064   3900 121580   0   0     4  2051 1714   174   0  16 83
 0  1  0      0   3064   3904 121576   0   0     3  1572 1331   133   0  10 90
 0  1  0      0   3064   3904 121576   0   0     4  2048 1727   163   0  14 86
 0  1  0      0   3064   3908 121572   0   0     4  2048 1720   160   0  17 82
 0  1  0      0   3064   3912 121568   0   0     3  1536 1312   124   0  12 88
 0  1  0      0   3064   3916 121564   0   0     4  2048 1727   168   0  16 84
 0  1  1      0   3064   3920 121560   0   0     4  2080 1720   158   0  16 84
 0  1  0      0   3064   3924 121556   0   0     3  1536 1314   119   0  12 87
 0  1  0      0   3064   3928 121552   0   0     4  2048 1719   160   1  13 86
 0  1  1      0   3064   3932 121548   0   0     4  2048 1726   159   1  15 84
 0  1  0      0   3064   3936 121544   0   0     3  1536 1327   129   1  12 86
 0  1  0      0   3064   3940 121540   0   0     4  2048 1714   159   0  18 82
 1  0  1      0   3064   3944 121536   0   0     3  1920 1604   151   0  16 83
 0  1  0      0   3064   3944 121536   0   0     4  1696 1429   130   1  13 86
 0  1  0      0   3064   3948 121532   0   0     4  2048 1726   159   1  17 82
 0  1  0      0   3064   3952 121528   0   0     3  1536 1324   121   0  11 88
 0  1  0      0   3064   3956 121524   0   0     4  2051 1722   164   1  15 83
 0  0  1      0   3064   3960 121520   0   0     3  1728 1586   139   1  13 86
 0  1  0      0   3064   3964 121516   0   0     4  1856 1455   129   1  12 86
 0  1  0      0   3064   3968 121512   0   0     4  2052 1717   162   0  17 83
 0  1  0      0   3064   3972 121508   0   0     3  1568 1327   131   0  12 88


