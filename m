Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbSJOGsc>; Tue, 15 Oct 2002 02:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSJOGsc>; Tue, 15 Oct 2002 02:48:32 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:20131 "EHLO
	kolivas.net") by vger.kernel.org with ESMTP id <S263026AbSJOGsb>;
	Tue, 15 Oct 2002 02:48:31 -0400
Message-ID: <1034664862.3dabbb9e44183@kolivas.net>
Date: Tue, 15 Oct 2002 16:54:22 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.42-mm3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the contest (http://contest.kolivas.net) benchmark results for
2.5.42-mm3 and how it compares to mm2 - statistical significance from mm3
indicated by *

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42 [2]              72.5    93      0       0       1.08 *
2.5.42-mm2 [3]          79.0    92      0       0       1.18
2.5.42-mm3 [2]          78.1    93      0       0       1.16

There really is no other load on the machine during this noload run. It seems
that the mem_load flushing prior to 2.5 kernels seems to make the kernel compile
start more slowly (with heavy disk activity), and mm2/3 are showing this more.
This may be an artifact of what happens to the vm after mem_load has been run. 

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42 [1]              98.0    69      44      33      1.46
2.5.42-mm2 [2]          104.5   72      31      30      1.56
2.5.42-mm3 [2]          100.9   69      48      33      1.50

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42 [1]              96.7    80      1       7       1.44
2.5.42-mm2 [2]          102.3   79      1       6       1.52 *
2.5.42-mm3 [2]          96.2    80      1       6       1.43

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42 [1]              112.7   66      1       7       1.68 *
2.5.42-mm2 [2]          195.0   41      2       6       2.90
2.5.42-mm3 [2]          203.0   37      2       7       3.02

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42 [1]              849.1   9       69      12      12.64 *
2.5.42-mm2 [2]          250.7   34      15      10      3.73 *
2.5.42-mm3 [2]          393.1   19      27      11      5.85

This has crept up since mm2.

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42 [1]              102.0   75      8       5       1.52 *
2.5.42-mm2 [2]          109.0   75      7       4       1.62
2.5.42-mm3 [2]          107.1   72      6       4       1.59

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42 [1]              97.5    71      1       20      1.45
2.5.42-mm2 [2]          105.3   72      1       24      1.57 *
2.5.42-mm3 [2]          97.1    73      1       21      1.45

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42 [1]              104.0   72      30      3       1.55
2.5.42-mm2 [2]          121.2   65      30      2       1.80 *
2.5.42-mm3 [2]          109.6   67      27      2       1.63

Con.
