Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTKEXIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 18:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTKEXIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 18:08:21 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:58570 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263273AbTKEXIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 18:08:19 -0500
Date: Wed, 05 Nov 2003 15:07:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm2
Message-ID: <225880000.1068073678@flay>
In-Reply-To: <20031104225544.0773904f.akpm@osdl.org>
References: <20031104225544.0773904f.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to work fine on my box. Nothing very interesting from a performance
perspective, but it does seem a touch faster than mainline on kernbench.
NFI why ;-)

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
              2.6.0-test9       45.28      100.19      568.01     1474.75
          2.6.0-test9-mm2       44.83      100.79      567.74     1491.00
         2.6.0-test9-mjb1       43.73       80.19      559.91     1463.25

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
              2.6.0-test9       46.17      122.20      571.58     1501.00
          2.6.0-test9-mm2       45.89      120.39      570.67     1504.75
         2.6.0-test9-mjb1       43.52       89.98      562.91     1500.50

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
              2.6.0-test9       45.84      120.14      570.93     1507.00
          2.6.0-test9-mm2       44.21      118.81      571.28     1566.00
         2.6.0-test9-mjb1       43.73       87.19      564.39     1488.50


DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
              2.6.0-test9       100.0%         1.2%
          2.6.0-test9-mm2        98.3%         2.3%
         2.6.0-test9-mjb1       112.2%         1.8%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
              2.6.0-test9       100.0%         2.0%
          2.6.0-test9-mm2       103.8%         1.8%
         2.6.0-test9-mjb1       116.4%         0.6%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
              2.6.0-test9       100.0%         0.9%
          2.6.0-test9-mm2       102.6%         1.0%
         2.6.0-test9-mjb1       120.5%         0.6%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
              2.6.0-test9       100.0%         0.4%
          2.6.0-test9-mm2        98.9%         0.4%
         2.6.0-test9-mjb1       123.7%         0.2%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
              2.6.0-test9       100.0%         0.8%
          2.6.0-test9-mm2       100.6%         0.9%
         2.6.0-test9-mjb1       127.6%         0.0%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
              2.6.0-test9       100.0%         0.3%
          2.6.0-test9-mm2        99.8%         0.3%
         2.6.0-test9-mjb1       125.9%         0.5%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
              2.6.0-test9       100.0%         0.4%
          2.6.0-test9-mm2        99.7%         0.4%
         2.6.0-test9-mjb1       127.6%         0.9%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
              2.6.0-test9       100.0%         0.1%
          2.6.0-test9-mm2        99.0%         0.3%
         2.6.0-test9-mjb1       127.7%         0.2%

