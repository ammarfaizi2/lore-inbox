Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267313AbTAPW4K>; Thu, 16 Jan 2003 17:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267315AbTAPW4K>; Thu, 16 Jan 2003 17:56:10 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:62981 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S267313AbTAPW4J>; Thu, 16 Jan 2003 17:56:09 -0500
Date: Thu, 16 Jan 2003 17:26:32 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] ctxbench 2.5.58 compared to recent and 2.4.20
Message-ID: <Pine.LNX.4.44.0301161722580.1062-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The general trend of this IPC benchmark is downward. I'm going to try 
adding prempt to see what that brings. I'm having a bit of problem with 
networking in 5[78], I want to resolve that first.

Two processes, passing a token back and forth uning various IPC methods.



================================================================
    Results by IPC type
================================================================

                                   loops/sec
SIGUSR1                     low       high    average    avg/MHz
  2.4.20.out              47304      47514      47424    136.083
  2.5.52.out              40961      41699      41290    118.517
  2.5.53.out              40567      41995      41434    118.926
  2.5.54.out              39573      39699      39647    113.785
  2.5.55.out              32949      36951      35385    101.574
  2.5.56.out              36875      36933      36909    105.932
  2.5.57.out              40728      40777      40745    116.944
  2.5.58.out              37114      37157      37129    106.562

                                   loops/sec
message queue               low       high    average    avg/MHz
  2.4.20.out              75206      83700      80822    231.920
  2.5.52.out              78427      79163      78675    225.823
  2.5.53.out              75709      75848      75759    217.448
  2.5.54.out              74131      75390      74969    215.156
  2.5.55.out              71276      71418      71361    204.842
  2.5.56.out              68177      71334      70228    201.557
  2.5.57.out              77646      77912      77809    223.320
  2.5.58.out              75526      77816      76481    219.504

                                   loops/sec
pipes                       low       high    average    avg/MHz
  2.4.20.out              87640      88381      87889    252.198
  2.5.52.out              77020      77586      77365    222.061
  2.5.53.out              67799      68893      68310    196.065
  2.5.54.out              70445      70572      70489    202.297
  2.5.55.out              73521      73758      73637    211.375
  2.5.56.out              66728      71280      69736    200.145
  2.5.57.out              65323      74089      70839    203.315
  2.5.58.out              70613      72484      71370    204.837

                                   loops/sec
semiphore                   low       high    average    avg/MHz
  2.4.20.out              92052      92569      92307    264.876
  2.5.52.out              84367      84639      84516    242.589
  2.5.53.out              77355      77724      77540    222.560
  2.5.54.out              77304      77521      77379    222.072
  2.5.55.out              75619      76906      76456    219.467
  2.5.56.out              77120      77358      77245    221.697
  2.5.57.out              80238      81108      80777    231.838
  2.5.58.out              81754      83169      82280    236.148

                                   loops/sec
spin+yield                  low       high    average    avg/MHz
  2.4.20.out             211801     211957     211855    607.921
  2.5.52.out             219279     219658     219470    629.947
  2.5.53.out             180547     180625     180584    518.319
  2.5.54.out             160157     178830     172598    495.341
  2.5.55.out             175182     175957     175603    504.065
  2.5.56.out             172703     173159     172973    496.440
  2.5.57.out             179346     179889     179579    515.410
  2.5.58.out             178850     179044     178941    513.568

                                   loops/sec
spinlock                    low       high    average    avg/MHz
  2.4.20.out                  4          4          4      0.014
  2.5.52.out                  3          3          3      0.009
  2.5.53.out                  3          3          3      0.009
  2.5.54.out                  3          3          3      0.009
  2.5.55.out                  3          3          3      0.009
  2.5.56.out                  3          3          3      0.009
  2.5.57.out                  3          3          3      0.009
  2.5.58.out                  3          3          3      0.009


