Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267085AbSLXLM0>; Tue, 24 Dec 2002 06:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbSLXLMZ>; Tue, 24 Dec 2002 06:12:25 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:5259 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267085AbSLXLMY>;
	Tue, 24 Dec 2002 06:12:24 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] ext2 v ext3 with contest
Date: Tue, 24 Dec 2002 22:20:22 +1100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212242220.33049.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here's a contest run comparing 2.5.52-mm2 on the same osdl hardware with the 
ext3 partitions mounted ext2 for comparison:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          39.2    181     0       0       1.08
2552mm2ext2 [5]         39.1    180     0       0       1.08
not significant

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          36.5    194     0       0       1.01
2552mm2ext2 [5]         36.1    194     0       0       1.00
slight speedup here. 

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          46.5    152     8       41      1.28
2552mm2ext2 [5]         48.3    144     10      48      1.33
slight shift in the balance; no significant change

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          52.8    154     1       10      1.46
2552mm2ext2 [5]         47.2    163     1       7       1.30
speedup with better overall cpu usage with ext2

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          76.1    124     1       8       2.10
2552mm2ext2 [5]         95.6    101     1       5       2.64
interesting - a shift in the opposite direction here with ext2 much slower 
(large)

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          74.5    112     11      20      2.06
2552mm2ext2 [5]         77.4    118     11      13      2.14
same here

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          59.9    134     6       18      1.65
2552mm2ext2 [5]         52.8    137     6       11      1.46
slightly better with ext2

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          50.5    147     5       6       1.39
2552mm2ext2 [5]         49.3    149     5       6       1.36
slightly better ext2

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          43.7    167     0       9       1.21
2552mm2ext2 [5]         43.4    166     0       9       1.20

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          66.0    141     39      3       1.82
2552mm2ext2 [5]         63.9    145     38      3       1.76
slightly better here

It seems the (possibly?) faster writing with ext2 causes slowdowns under heavy 
writing loads on the same disk, but improvements with the other loads.

Interesting results (not quite what I was expecting)

Enjoy the festive season

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+CEL2F6dfvkL3i1gRAq/1AJ4wsVsERAUng6ALtmpnMflpb8co0gCfTYWB
JzOrStkqsDGV/fC+21N69f8=
=pUSo
-----END PGP SIGNATURE-----
