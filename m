Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262736AbSI1GxM>; Sat, 28 Sep 2002 02:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262737AbSI1GxM>; Sat, 28 Sep 2002 02:53:12 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:33990 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262736AbSI1GxL>;
	Sat, 28 Sep 2002 02:53:11 -0400
Message-ID: <1033196310.3d955316425bd@kolivas.net>
Date: Sat, 28 Sep 2002 16:58:30 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.39 with contest 0.41
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here follow the latest benchmarks with contest (http://contest.kolivas.net)

noload:
Kernel                  Time            CPU             Ratio
2.4.19                  67.71           98%             1.00*
2.5.38                  72.38           94%             1.07
2.5.38-mm3              73.00           93%             1.08
2.5.39                  73.17           93%             1.08

process_load:
Kernel                  Time            CPU             Ratio
2.4.19                  110.75          57%             1.64*
2.5.38                  85.71           79%             1.27
2.5.38-mm3              96.32           72%             1.42*
2.5.39                  88.18           77%             1.30

io_load:
Kernel                  Time            CPU             Ratio
2.4.19                  216.05          33%             3.19
2.5.38                  887.76          8%              13.11*
2.5.38-mm3              105.17          70%             1.55*
2.5.39                  216.81          37%             3.20

mem_load:
Kernel                  Time            CPU             Ratio
2.4.19                  105.40          70%             1.56
2.5.38                  107.89          73%             1.59
2.5.38-mm3              117.09          63%             1.73*
2.5.39                  103.72          72%             1.53

Things to note:
Despite the new deadline scheduler, performance under IO load is worse than
2.5.38-mm3 (something else?)

Asterisks are placed where the difference was statistically significant from 2.5.39

Hardware: 1133Mhz P3, 224Mb Ram, IDE ATA100 5400rpm drive, IO load on same drive
as compile.

*NOTE* New version of contest means results are not compatible with results of
0.3x. Process Load now more of a process load (and less of a cpu load), and
changed priming (memory flushing) prior to each test results in far greater
resolution of results - hence the notable change in even noload results.

Comments?
Con.
