Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261273AbSJIJUg>; Wed, 9 Oct 2002 05:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSJIJUg>; Wed, 9 Oct 2002 05:20:36 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:65489 "EHLO
	kolivas.net") by vger.kernel.org with ESMTP id <S261273AbSJIJUe>;
	Wed, 9 Oct 2002 05:20:34 -0400
Message-ID: <1034155574.3da3f636b97df@kolivas.net>
Date: Wed,  9 Oct 2002 19:26:14 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.41-mm1 with contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the contest (http://contest.kolivas.net) benchmark results for 2.5.41-mm1

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              67.7    98      0       0       1.01
2.5.38 [3]              72.0    93      0       0       1.07
2.5.39 [2]              72.2    93      0       0       1.07
2.5.40 [1]              72.5    93      0       0       1.08
2.5.40-mm2 [1]          72.2    93      0       0       1.07
2.5.41 [1]              73.8    93      0       0       1.10
2.5.41-mm1 [3]          73.3    92      0       0       1.09

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              106.5   59      112     43      1.59
2.5.38 [3]              89.5    74      34      28      1.33
2.5.39 [2]              91.2    73      36      28      1.36
2.5.40 [2]              82.8    80      25      23      1.23
2.5.40-mm2 [1]          98.0    69      45      33      1.46
2.5.41 [1]              91.1    73      38      30      1.36
2.5.41-mm1 [3]          88.8    75      32      27      1.32

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              492.6   14      38      10      7.33
2.5.38 [1]              4000.0  1       500     1       59.55
2.5.39 [2]              423.9   18      30      11      6.31
2.5.40 [1]              315.7   25      22      10      4.70
2.5.40-mm2 [2]          208.0   38      12      10      3.10
2.5.41 [2]              607.5   13      47      12      9.04
2.5.41-mm1 [3]          307.7   26      18      10      4.58

Significantly better than the new IO based choking in 2.5.41.

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              100.0   72      33      3       1.49
2.5.38 [3]              107.3   70      34      3       1.60
2.5.39 [2]              103.1   72      31      3       1.53
2.5.40 [2]              102.5   72      31      3       1.53
2.5.40-mm2 [2]          165.1   44      38      2       2.46
2.5.41 [1]              101.6   73      30      3       1.51
2.5.41-mm1 [3]          144.6   50      37      2       2.15

Subtle differences only between 2.5.40-mm2 and 2.5.41-mm1 except for mem_load
which shows some relaxing of the aggressive swap avoiding in 2.5.40-mm2, but
still significantly longer than 2.5.41.

Experimental loads:

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              134.1   54      14      5       2.00
2.5.38 [2]              100.5   76      9       5       1.50
2.5.39 [2]              101.3   74      14      6       1.51
2.5.40 [1]              101.5   73      13      5       1.51
2.5.40-mm2 [1]          102.7   75      7       4       1.53
2.5.41 [1]              101.1   75      7       4       1.51
2.5.41-mm1 [3]          106.8   70      5       3       1.59

Slight drop off here, with longer kernel compile time despite doing less load work.

lslr_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              89.8    77      1       20      1.34
2.5.38 [1]              99.1    71      1       20      1.48
2.5.39 [1]              101.3   70      2       24      1.51
2.5.40 [1]              97.0    72      1       21      1.44
2.5.40-mm2 [1]          94.3    75      1       21      1.40
2.5.41 [1]              93.6    75      1       18      1.39
2.5.41-mm1 [3]          96.8    72      1       21      1.44

tarc_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              106.5   70      1       8       1.59
2.5.38 [1]              97.2    79      1       6       1.45
2.5.39 [1]              91.8    83      1       6       1.37
2.5.40 [1]              96.9    80      1       6       1.44
2.5.40-mm2 [1]          91.9    82      1       6       1.37
2.5.41 [1]              93.3    81      1       6       1.39
2.5.41-mm1 [3]          91.6    81      1       5       1.36

tarx_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              132.4   55      2       9       1.97
2.5.38 [1]              120.5   63      2       8       1.79
2.5.39 [1]              108.3   69      1       6       1.61
2.5.40 [1]              110.7   68      1       6       1.65
2.5.40-mm2 [1]          188.1   39      3       7       2.80
2.5.41 [2]              138.8   53      2       8       2.07
2.5.41-mm1 [3]          188.4   43      2       7       2.80

Con
