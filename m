Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264895AbSJPGTB>; Wed, 16 Oct 2002 02:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264898AbSJPGTB>; Wed, 16 Oct 2002 02:19:01 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:39349 "EHLO
	kolivas.net") by vger.kernel.org with ESMTP id <S264895AbSJPGTA>;
	Wed, 16 Oct 2002 02:19:00 -0400
Message-ID: <1034749489.3dad063203723@kolivas.net>
Date: Wed, 16 Oct 2002 16:24:50 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.43 with contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the latest contest (http://contest.kolivas.net) benchmarks including 2.5.43

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.38 [3]              72.0    93      0       0       1.07
2.5.39 [2]              72.2    93      0       0       1.07
2.5.40 [1]              72.5    93      0       0       1.08
2.5.41 [1]              73.8    93      0       0       1.10
2.5.42 [2]              72.5    93      0       0       1.08
2.5.42-mm3 [2]          78.1    93      0       0       1.16
2.5.43 [2]              74.6    92      0       0       1.11

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.38 [3]              89.5    74      34      28      1.33
2.5.39 [2]              91.2    73      36      28      1.36
2.5.40 [2]              82.8    80      25      23      1.23
2.5.41 [1]              91.1    73      38      30      1.36
2.5.42 [1]              98.0    69      44      33      1.46
2.5.42-mm3 [2]          100.9   69      48      33      1.50
2.5.43 [2]              99.7    71      44      31      1.48

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.38 [1]              97.2    79      1       6       1.45
2.5.39 [1]              91.8    83      1       6       1.37
2.5.40 [1]              96.9    80      1       6       1.44
2.5.41 [1]              93.3    81      1       6       1.39
2.5.42 [1]              96.7    80      1       7       1.44
2.5.42-mm3 [2]          96.2    80      1       6       1.43
2.5.43 [1]              97.6    79      1       7       1.45

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.38 [1]              120.5   63      2       8       1.79
2.5.39 [1]              108.3   69      1       6       1.61
2.5.40 [1]              110.7   68      1       6       1.65
2.5.41 [2]              138.8   53      2       8       2.07
2.5.42 [1]              112.7   66      1       7       1.68
2.5.42-mm3 [2]          203.0   37      2       7       3.02
2.5.43 [1]              114.9   67      1       7       1.71

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.38 [1]              4000.0  1       500     1       59.55
2.5.39 [2]              423.9   18      30      11      6.31
2.5.40 [1]              315.7   25      22      10      4.70
2.5.41 [2]              607.5   13      47      12      9.04
2.5.42 [1]              849.1   9       69      12      12.64
2.5.42-mm3 [2]          393.1   19      27      11      5.85
2.5.43 [1]              578.9   13      45      12      8.62

Difference between 2.5.42 and .43 is likely to be due to lack of enough runs to
get a real average. They're probably the same (ie. more than the -mm tree).

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.38 [2]              100.5   76      9       5       1.50
2.5.39 [2]              101.3   74      14      6       1.51
2.5.40 [1]              101.5   73      13      5       1.51
2.5.41 [1]              101.1   75      7       4       1.51
2.5.42 [1]              102.0   75      8       5       1.52
2.5.42-mm3 [2]          107.1   72      6       4       1.59
2.5.43 [3]              117.3   64      6       3       1.75

This is the only significant difference. Continually reading a large file seems
to have caused a new slow down.

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.38 [1]              99.1    71      1       20      1.48
2.5.39 [1]              101.3   70      2       24      1.51
2.5.40 [1]              97.0    72      1       21      1.44
2.5.41 [1]              93.6    75      1       18      1.39
2.5.42 [1]              97.5    71      1       20      1.45
2.5.42-mm3 [2]          97.1    73      1       21      1.45
2.5.43 [2]              93.0    76      1       18      1.38

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.38 [3]              107.3   70      34      3       1.60
2.5.39 [2]              103.1   72      31      3       1.53
2.5.40 [2]              102.5   72      31      3       1.53
2.5.41 [1]              101.6   73      30      3       1.51
2.5.42 [1]              104.0   72      30      3       1.55
2.5.42-mm3 [2]          109.6   67      27      2       1.63
2.5.43 [1]              102.0   75      28      2       1.52

Hardware: 1133Mhz P3 with 224Mb Ram, 5400rpm ATA100 HD with reiserFS. IO loads
on same disk as kernel compile.

Con.
