Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261987AbSI3JjE>; Mon, 30 Sep 2002 05:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261989AbSI3JjE>; Mon, 30 Sep 2002 05:39:04 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:1920 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261987AbSI3JjD> convert rfc822-to-8bit; Mon, 30 Sep 2002 05:39:03 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.39-mm1
Date: Mon, 30 Sep 2002 19:41:37 +1000
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301941.41627.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here follow the contest v0.41 (http://contest.kolivas.net) results for 
2.5.39-mm1:

noload:
Kernel                  Time            CPU             Ratio
2.4.19                  67.71           98%             1.00
2.5.38                  72.38           94%             1.07
2.5.38-mm3              73.00           93%             1.08
2.5.39                  73.17           93%             1.08
2.5.39-mm1              72.97           94%             1.08

process_load:
Kernel                  Time            CPU             Ratio
2.4.19                  110.75          57%             1.64
2.5.38                  85.71           79%             1.27
2.5.38-mm3              96.32           72%             1.42
2.5.39                  88.9            75%             1.33*
2.5.39-mm1              99.0            69%             1.45*

io_load:
Kernel                  Time            CPU             Ratio
2.4.19                  216.05          33%             3.19
2.5.38                  887.76          8%              13.11
2.5.38-mm3              105.17          70%             1.55
2.5.39                  229.4           34%             3.4
2.5.39-mm1              239.5           33%             3.4

mem_load:
Kernel                  Time            CPU             Ratio
2.4.19                  105.40          70%             1.56
2.5.38                  107.89          73%             1.59
2.5.38-mm3              117.09          63%             1.73
2.5.39                  103.72          72%             1.53
2.5.39-mm1              104.61          73%             1.54

process_load and io_load results are averages of 6 runs.

Statistical significance in process_load performance (p=0.017), with mm1 
slower. The other changes did not show statistical significance, with trends 
as noted above.

note: these were done with the temporary fix for the reiserfs breakage but as 
far as I'm aware it shouldn't affect this test

Hardware: 1133MhzP3, 224Mb Ram, IDE-ATA100 5400rpm drive with io_load tested 
on same disk, reiserFS. Preempt=N for all kernels.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9mBxUF6dfvkL3i1gRAr4kAJ47cICW0qIXLmswyBL9t1ZsiyxgVwCfaHCN
bXOSrZtwTjJsSibiBm5KrRo=
=XWpt
-----END PGP SIGNATURE-----
