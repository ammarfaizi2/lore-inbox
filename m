Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbTBAA21>; Fri, 31 Jan 2003 19:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbTBAA21>; Fri, 31 Jan 2003 19:28:27 -0500
Received: from dial-ctb0572.webone.com.au ([210.9.245.72]:23556 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S263991AbTBAA2X>;
	Fri, 31 Jan 2003 19:28:23 -0500
Message-ID: <3E3B16CF.9050806@cyberone.com.au>
Date: Sat, 01 Feb 2003 11:37:35 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.59-mm7 with contest
References: <200302010930.54538.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Here are contest (http://contest.kolivas.net) benchmarks using the osdl 
>(http://www.osdl.org) hardware comparing mm7
>
>no_load:
>Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
>2.5.59          3       79      94.9    0       0.0     1.00
>2.5.59-mm6      1       78      96.2    0       0.0     1.00
>2.5.59-mm7      5       78      96.2    0       0.0     1.00
>cacherun:
>Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
>2.5.59          3       76      98.7    0       0.0     0.96
>2.5.59-mm6      1       76      97.4    0       0.0     0.97
>2.5.59-mm7      5       75      98.7    0       0.0     0.96
>process_load:
>Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
>2.5.59          3       92      81.5    28      16.3    1.16
>2.5.59-mm6      1       92      81.5    25      15.2    1.18
>2.5.59-mm7      4       90      82.2    25      18.3    1.15
>ctar_load:
>Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
>2.5.59          3       98      80.6    2       5.1     1.24
>2.5.59-mm6      3       112     70.5    2       4.5     1.44
>2.5.59-mm7      5       96      80.2    1       3.4     1.23
>xtar_load:
>Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
>2.5.59          3       101     75.2    1       4.0     1.28
>2.5.59-mm6      3       115     66.1    1       4.3     1.47
>2.5.59-mm7      5       96      79.2    0       3.3     1.23
>io_load:
>Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
>2.5.59          3       153     50.3    8       13.7    1.94
>2.5.59-mm6      2       90      83.3    2       6.7     1.15
>2.5.59-mm7      5       110     68.2    2       6.4     1.41
>read_load:
>Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
>2.5.59          3       102     76.5    5       4.9     1.29
>2.5.59-mm6      3       733     10.8    56      6.3     9.40
>2.5.59-mm7      4       90      84.4    1       1.3     1.15
>list_load:
>Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
>2.5.59          3       95      80.0    0       6.3     1.20
>2.5.59-mm6      3       97      79.4    0       6.2     1.24
>2.5.59-mm7      4       94      80.9    0       6.4     1.21
>mem_load:
>Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
>2.5.59          3       97      80.4    56      2.1     1.23
>2.5.59-mm6      3       94      83.0    50      2.1     1.21
>2.5.59-mm7      4       92      82.6    45      1.4     1.18
>dbench_load:
>Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
>2.5.59          3       126     60.3    3       22.2    1.59
>2.5.59-mm6      3       122     61.5    3       25.4    1.56
>2.5.59-mm7      4       121     62.0    2       24.8    1.55
>io_other:
>Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
>2.5.59          3       89      84.3    2       5.5     1.13
>2.5.59-mm6      2       90      83.3    2       6.7     1.15
>2.5.59-mm7      3       90      83.3    2       5.6     1.15
>
>Seems the fix for "reads starves everything" works. Affected the tar loads 
>too?
>
Yes, at the cost of throughput, however for now it is probably
the best way to go. Hopefully anticipatory scheduling will provide
as good or better kernel compile times and better throughput.

Con, tell me, are "Loads" normalised to the time they run for?
Is it possible to get a finer grain result for the load tests?

Thanks
Nick

