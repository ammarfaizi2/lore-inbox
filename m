Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbTCQOt1>; Mon, 17 Mar 2003 09:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbTCQOt0>; Mon, 17 Mar 2003 09:49:26 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16811 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261696AbTCQOtZ>; Mon, 17 Mar 2003 09:49:25 -0500
Date: Mon, 17 Mar 2003 07:00:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: performance of 2.4 vs 2.5
Message-ID: <21980000.1047913214@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for amusement I booted 2.4.18 and ran the numbers. 2.4.20 should be
very similar, I just happened to know that 2.4.18 worked. All on 16x
NUMA-Q w/ 16Gb of RAM.

I think I like the system times for kernbench 256 best (2.4 imploded when
I went higher than that) ... 2.5-mjb = 90s ... 2.4 = 735s. Heh ;-)

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
                   2.4.18       83.71      591.42      675.80     1515.00
                   2.5.64       45.25      109.39      562.69     1484.25
              2.5.64-mjb5       43.78       81.58      562.15     1469.50

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
                   2.4.18       96.26      735.75      771.56     1562.25
                   2.5.64       46.32      130.48      566.98     1507.25
              2.5.64-mjb5       44.15       90.71      564.34     1485.25

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
                   2.4.18       She can nay take the strain, captain!
                   2.5.64       46.33      132.55      566.89     1508.00
              2.5.64-mjb5       44.05       89.92      564.59     1484.25


DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
                   2.4.18       100.0%         0.5%
                   2.5.64       163.6%         0.4%
              2.5.64-mjb5       159.4%         1.8%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
                   2.4.18       100.0%         2.2%
                   2.5.64       193.8%         0.7%
              2.5.64-mjb5       171.5%         1.7%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
                   2.4.18       100.0%         1.1%
                   2.5.64       158.3%         0.7%
              2.5.64-mjb5       190.8%         1.4%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
                   2.4.18       100.0%         0.6%
                   2.5.64       176.6%         0.7%
              2.5.64-mjb5       236.2%         0.3%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
                   2.4.18       100.0%         0.9%
                   2.5.64       169.7%         1.8%
              2.5.64-mjb5       336.1%         0.3%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
                   2.4.18       100.0%         0.5%
                   2.5.64       162.0%         1.4%
              2.5.64-mjb5       335.6%         0.4%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
                   2.4.18       100.0%         0.3%
                   2.5.64       173.5%         0.3%
              2.5.64-mjb5       339.4%         0.5%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                   2.4.18       100.0%         0.4%
                   2.5.64       198.3%         0.7%
              2.5.64-mjb5       337.9%         0.1%

