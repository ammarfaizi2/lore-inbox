Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264939AbTFCGZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 02:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbTFCGZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 02:25:12 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:7557 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264939AbTFCGZL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 02:25:11 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 100Hz preempt v nopreempt contest results
Date: Tue, 3 Jun 2003 16:39:15 +1000
User-Agent: KMail/1.5.1
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306031639.49515.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest results on the same kernel 2.5.70-mm3 set to 100Hz with 
(2.5.70-mm31) and without (2.5.70-mm3n) preempt.

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm31         1   77      94.8    0.0     0.0     1.00
2.5.70-mm3n         1   79      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm31         1   74      98.6    0.0     0.0     0.96
2.5.70-mm3n         1   76      98.7    0.0     0.0     0.96
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm31         2   107     69.2    67.0    29.0    1.39
2.5.70-mm3n         2   137     53.3    133.5   45.3    1.73
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm31         3   105     73.3    0.7     3.8     1.36
2.5.70-mm3n         3   105     73.3    0.7     3.8     1.33
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm31         3   122     61.5    2.0     4.9     1.58
2.5.70-mm3n         3   113     65.5    2.0     4.4     1.43
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm31         4   114     65.8    41.0    19.3    1.48
2.5.70-mm3n         4   112     67.0    41.1    18.8    1.42
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm31         2   112     67.9    46.1    21.4    1.45
2.5.70-mm3n         2   112     67.0    46.0    20.4    1.42
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm31         2   100     76.0    7.5     7.0     1.30
2.5.70-mm3n         2   101     75.2    7.6     5.9     1.28
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm31         2   92      82.6    0.0     5.4     1.19
2.5.70-mm3n         2   94      79.8    0.0     6.4     1.19
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm31         2   95      81.1    53.0    2.1     1.23
2.5.70-mm3n         2   94      80.9    52.0    2.1     1.19
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm31         4   297     24.9    4.5     52.5    3.86
2.5.70-mm3n         4   292     25.7    4.5     52.4    3.70

Note this time the ratio is less useful since they are both 100Hz. The 
difference this time shows a large preempt improvement in process_load much 
like 1000Hz did. Interestingly, even unloaded kernels no_load and cache_load 
runs are faster with preempt. Only in xtar_load (repeatedly extracting a tar 
with multiple small files) was no preempt faster.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+3EKfF6dfvkL3i1gRAjFpAKCpeVUOpCXd1xHrKYhEkeOYhuD1swCgmyRQ
NBf56mnwS02WY9wJ9FHctg0=
=cLte
-----END PGP SIGNATURE-----

