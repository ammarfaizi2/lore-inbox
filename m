Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263507AbTCNVVd>; Fri, 14 Mar 2003 16:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263509AbTCNVVd>; Fri, 14 Mar 2003 16:21:33 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:39420 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263507AbTCNVVa>; Fri, 14 Mar 2003 16:21:30 -0500
Date: Fri, 14 Mar 2003 13:22:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>, anton@samba.org
Subject: Re: [PATCH] concurrent block allocation for ext3
Message-ID: <227420000.1047676948@flay>
In-Reply-To: <m3zno3grfz.fsf@lexa.home.net>
References: <m3zno3grfz.fsf@lexa.home.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SDET on my machine (16x NUMA-Q) has fallen in love with your patch, 
and has decided to elope with it to a small desert island. This is 
despite it's one disk hung off node 0, and the IO througput of a 
slightly damp piece of cotton thread. Apologies for the loss of your 
patch as it gets whisked away ;-)

M.

PS. Oh, I had this bit, per akpm-instructions: For best results, add ____cacheline_aligned_in_smp to struct ext2_bg_info

PPS. I'll try to run some more focused tests with aim7 over the weekend.
As if we needed it ...

-------------------------

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
          2.5.64-bk3-mjb3       100.0%         1.8%
         2.5.64-mjb3-ext2       102.0%         1.1%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
          2.5.64-bk3-mjb3       100.0%         3.7%
         2.5.64-mjb3-ext2       106.1%         3.1%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
          2.5.64-bk3-mjb3       100.0%         1.5%
         2.5.64-mjb3-ext2       101.1%         2.1%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
          2.5.64-bk3-mjb3       100.0%         0.2%
         2.5.64-mjb3-ext2       113.3%         0.7%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
          2.5.64-bk3-mjb3       100.0%         1.1%
         2.5.64-mjb3-ext2       167.1%         0.8%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
          2.5.64-bk3-mjb3       100.0%         0.9%
         2.5.64-mjb3-ext2       170.7%         0.1%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
          2.5.64-bk3-mjb3       100.0%         0.7%
         2.5.64-mjb3-ext2       157.2%         0.5%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
          2.5.64-bk3-mjb3       100.0%         0.3%
         2.5.64-mjb3-ext2       151.3%         0.8%

