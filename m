Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272885AbTG3PBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272921AbTG3PBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:01:46 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:26596 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S272885AbTG3PBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:01:41 -0400
Date: Wed, 30 Jul 2003 08:01:22 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test2-mm1 results
Message-ID: <17830000.1059577281@[10.10.2.4]>
In-Reply-To: <170360000.1059513518@flay>
References: <5110000.1059489420@[10.10.2.4]> <170360000.1059513518@flay>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so test2-mm1 fixes the panic I was seeing in test1-mm1.
Only noticeable thing is that -mm tree is consistently a little slower 
at kernbench

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
                   2.5.74       45.17       97.88      568.43     1474.75
               2.5.74-mm1       45.84      109.66      568.05     1477.50
              2.6.0-test1       45.25       98.63      568.45     1473.50
          2.6.0-test2-mm1       45.38      101.47      569.16     1476.25
         2.6.0-test2-mjb1       43.31       75.98      564.33     1478.00

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
                   2.5.74       45.74      114.56      571.62     1500.00
               2.5.74-mm1       46.59      133.65      570.90     1511.50
              2.6.0-test1       45.68      114.68      571.70     1503.00
          2.6.0-test2-mm1       46.66      119.82      579.32     1497.25
         2.6.0-test2-mjb1       44.03       87.85      569.97     1493.75

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
                   2.5.74       46.11      115.86      571.77     1491.50
               2.5.74-mm1       47.13      139.07      571.52     1509.25
              2.6.0-test1       46.09      115.76      571.74     1491.25
          2.6.0-test2-mm1       46.95      121.18      582.00     1497.50
         2.6.0-test2-mjb1       44.08       85.54      570.57     1487.25


DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.74       100.0%         3.7%
               2.5.74-mm1        88.5%        10.9%
              2.6.0-test1       103.0%         2.0%
          2.6.0-test2-mm1        99.7%         3.1%
         2.6.0-test2-mjb1       107.2%         3.6%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.74       100.0%        53.7%
               2.5.74-mm1       133.9%         1.4%
              2.6.0-test1       136.4%         1.9%
          2.6.0-test2-mm1       132.1%         4.2%
         2.6.0-test2-mjb1       156.6%         1.1%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.74       100.0%         3.9%
               2.5.74-mm1        92.5%         2.5%
              2.6.0-test1        96.7%         5.7%
          2.6.0-test2-mm1        70.6%        49.1%
         2.6.0-test2-mjb1       134.2%         2.1%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.74       100.0%        45.9%
               2.5.74-mm1       123.5%         0.6%
              2.6.0-test1        86.1%        70.7%
          2.6.0-test2-mm1       127.8%         0.4%
         2.6.0-test2-mjb1       158.6%         0.7%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.74       100.0%         0.3%
               2.5.74-mm1        92.8%         0.8%
              2.6.0-test1        99.3%         0.6%
          2.6.0-test2-mm1        97.9%         0.5%
         2.6.0-test2-mjb1       120.8%         0.6%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.74       100.0%         0.1%
               2.5.74-mm1        94.4%         0.4%
              2.6.0-test1       100.4%         0.2%
          2.6.0-test2-mm1        97.9%         0.2%
         2.6.0-test2-mjb1       123.2%         0.5%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.74       100.0%         0.4%
               2.5.74-mm1        95.6%         0.3%
              2.6.0-test1       101.1%         0.3%
          2.6.0-test2-mm1       100.3%         0.5%
         2.6.0-test2-mjb1       127.1%         0.2%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.74       100.0%         0.1%
               2.5.74-mm1        97.6%         0.2%
              2.6.0-test1       100.6%         0.6%
          2.6.0-test2-mm1       101.8%         0.0%
         2.6.0-test2-mjb1       127.9%         0.3%

diffprofile for kernbench (from test1 to test2-mm1, so not really
fair, but might help):

      4383     2.6% total
      1600     6.8% page_remove_rmap
       934    61.6% do_no_page
       470    13.9% __copy_from_user_ll
       469    12.8% find_get_page
       373     0.0% pgd_ctor
       368     4.7% __d_lookup
       349     6.6% __copy_to_user_ll
       278    15.1% atomic_dec_and_lock
       273   154.2% may_open
       240    15.6% kmem_cache_free
       182    30.2% __wake_up
       163    11.2% schedule
       152    10.4% free_hot_cold_page
       148    21.2% pte_alloc_one
       123     6.5% path_lookup
       100     9.8% clear_page_tables
        77    12.5% copy_process
        76     4.2% buffered_rmqueue
        70    19.0% .text.lock.file_table
        70     5.8% release_pages
        66   825.0% free_percpu
        55    21.0% vfs_read
        54   300.0% cache_grow
        50     9.5% kmap_atomic
....
       -57   -38.0% __generic_file_aio_read
       -62  -100.0% free_pages_bulk
      -255   -77.5% dentry_open
      -316    -2.2% do_anonymous_page
      -415   -77.3% do_page_cache_readahead
      -562   -96.1% pgd_alloc
      -683   -68.9% filemap_nopage
     -1005    -2.0% default_idle

Someone messing with the pgd alloc stuff, perhaps?
