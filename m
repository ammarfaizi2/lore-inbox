Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264728AbSJUEJ5>; Mon, 21 Oct 2002 00:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbSJUEJ5>; Mon, 21 Oct 2002 00:09:57 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:13193 "EHLO
	pc.kolivas.net") by vger.kernel.org with ESMTP id <S264728AbSJUEJ4>;
	Mon, 21 Oct 2002 00:09:56 -0400
Message-ID: <1035173759.3db37f7f3c495@kolivas.net>
Date: Mon, 21 Oct 2002 14:15:59 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.44-mm1 with contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are contest 0.51 benchmarks for 2.5.44-mm1 with shared pagetables enabled:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [2]          73.4    93      0       0       1.03
2.5.44 [3]              74.6    93      0       0       1.04
2.5.44-mm1 [3]          75.0    93      0       0       1.05

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [2]          105.8   71      44      31      1.48
2.5.44 [3]              90.9    76      32      26      1.27
2.5.44-mm1 [3]          191.5   36      168     64      2.68

These were all checked to ensure it was not one pathological run making the
value high. The range was 190.6->192.7.

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [1]          92.3    82      1       5       1.29
2.5.44 [3]              97.7    80      1       6       1.37
2.5.44-mm1 [3]          99.2    78      1       6       1.39

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [2]          171.0   45      2       8       2.39
2.5.44 [3]              117.0   65      1       7       1.64
2.5.44-mm1 [3]          156.2   49      2       7       2.19

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [2]          301.1   26      21      11      4.22
2.5.44 [3]              873.8   9       69      12      12.24
2.5.44-mm1 [3]          347.3   22      35      15      4.86

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [1]          105.7   73      6       4       1.48
2.5.44 [3]              110.8   68      6       3       1.55
2.5.44-mm1 [3]          110.5   69      7       3       1.55

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [1]          98.9    72      1       23      1.39
2.5.44 [3]              99.1    71      1       21      1.39
2.5.44-mm1 [3]          96.5    74      1       22      1.35

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43-mm2 [2]          106.5   69      27      2       1.49
2.5.44 [3]              114.3   67      30      2       1.60
2.5.44-mm1 [3]          159.7   47      38      2       2.24

Notably different results in many places. This is a similar pattern to the last
time I enabled shared pagetables. I haven't had the time to try without it
enabled yet.

Con
