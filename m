Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbSJANgX>; Tue, 1 Oct 2002 09:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261622AbSJANgX>; Tue, 1 Oct 2002 09:36:23 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:2176 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261619AbSJANgV> convert rfc822-to-8bit; Tue, 1 Oct 2002 09:36:21 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.40{-mm1} with contest 0.42
Date: Tue, 1 Oct 2002 23:38:57 +1000
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210012339.06423.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here follow the latest benchmarks for 2.5.40 and 2.5.40-mm1:

noload:
Kernel                  Time            CPU%            Ratio
2.4.19                  67.7            98              1.00
2.5.38                  72.4            94              1.07
2.5.38-mm3              73.0            93              1.08
2.5.39                  73.2            93              1.08
2.5.39-mm1              73.0            94              1.08
2.5.40                  73.2            94              1.08
2.5.40-mm1              73.4            93              1.08

process_load:
Kernel                  Time            CPU%            Ratio
2.4.19                  110.8           57              1.64
2.5.38                  85.7            79              1.27
2.5.38-mm3              96.3            72              1.42
2.5.39                  88.9            76              1.31
2.5.39-mm1              99.0            69              1.46
2.5.40                  96.4            71              1.43
2.5.40-mm1              94.5            72              1.40

io_load:
Kernel                  Time            CPU%            Ratio
2.4.19                  216.1           33              3.19
2.5.38                  887.8           8               13.11
2.5.38-mm3              105.2           70              1.55
2.5.39                  229.4           34              3.39
2.5.39-mm1              239.5           32              3.54
2.5.40                  230.3           33              3.40
2.5.40-mm1              117.5           62              1.74

mem_load:
Kernel                  Time            CPU%            Ratio
2.4.19                  105.4           70              1.56
2.5.38                  107.9           73              1.59
2.5.38-mm3              117.1           63              1.73
2.5.39                  103.7           72              1.53
2.5.39-mm1              104.6           73              1.54
2.5.40                  103.0           73              1.52
2.5.40-mm1              111.3           67              1.64

Summary: 
2.5.40 shows no significant difference from 2.5.39 (except in process_load; 
now equivalent to 2.5.39-mm1 - the significance of which is not clear of it's 
importance)

2.5.40-mm1 shows a substantial improvement under IO load (consistent with the 
change in fifo_batch as discussed under the thread "[BENCHMARK] 2.5.39-mm1")
2.5.40-mm1 also shows a slight drop in performance under mem_load. Note of 
interest that both 2.5.38-mm3 and 2.5.40-mm1 which have fifo_batch set to 16 
instead of 32 have both better IO load performance, and worse mem_load 
performance - related?

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9maV0F6dfvkL3i1gRAjQZAJ9Ue60e1pe9A/WKigGW3UiMfshngACfT/FW
cpLOyqDqFq7LkaTCMJo51l8=
=yrf+
-----END PGP SIGNATURE-----
