Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbTGBTxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 15:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTGBTxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 15:53:22 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:25756 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264465AbTGBTxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 15:53:19 -0400
Date: Wed, 02 Jul 2003 12:56:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm3
Message-ID: <537120000.1057175763@flay>
In-Reply-To: <20030701221829.3e0edf3a.akpm@digeo.com>
References: <20030701203830.19ba9328.akpm@digeo.com><15570000.1057122469@[10.10.2.4]> <20030701221829.3e0edf3a.akpm@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spiffy - works now.

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
                   2.5.73       45.08       98.30      568.56     1479.00
               2.5.73-mm3       44.39       92.72      563.04     1476.25
              2.5.73-mjb1       43.70       75.71      564.62     1465.00

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
                   2.5.73       45.99      115.34      571.60     1493.00
               2.5.73-mm3       45.36      111.71      565.71     1493.75
              2.5.73-mjb1       43.88       88.37      570.41     1500.75

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
                   2.5.73       46.01      115.06      571.66     1491.75
               2.5.73-mm3       45.38      114.91      565.81     1497.75
              2.5.73-mjb1       43.93       85.48      570.47     1492.25


DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.73       100.0%         2.5%
               2.5.73-mm3       105.3%         2.2%
              2.5.73-mjb1       112.8%         0.0%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.73       100.0%         7.1%
               2.5.73-mm3        99.3%         3.4%
              2.5.73-mjb1       108.8%         4.7%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.73       100.0%         0.5%
               2.5.73-mm3       102.5%         2.2%
              2.5.73-mjb1       132.3%         0.0%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.73       100.0%         1.4%
               2.5.73-mm3        96.7%         0.7%
              2.5.73-mjb1       122.5%         0.3%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.73       100.0%         0.5%
               2.5.73-mm3       101.8%         0.3%
              2.5.73-mjb1       122.3%         0.9%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.73       100.0%         0.1%
               2.5.73-mm3       103.6%         0.8%
              2.5.73-mjb1       123.2%         0.8%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.73       100.0%         0.2%
               2.5.73-mm3       104.1%         0.2%
              2.5.73-mjb1       123.8%         0.1%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.73       100.0%         0.2%
               2.5.73-mm3       103.5%         0.1%
              2.5.73-mjb1       122.6%         0.3%


