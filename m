Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSJPMCn>; Wed, 16 Oct 2002 08:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSJPMCn>; Wed, 16 Oct 2002 08:02:43 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:16580 "EHLO
	kolivas.net") by vger.kernel.org with ESMTP id <S262392AbSJPMCj> convert rfc822-to-8bit;
	Wed, 16 Oct 2002 08:02:39 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.43-mm1 with contest
Date: Wed, 16 Oct 2002 20:38:48 +1000
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210162038.50189.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are the contest results for 2.5.43-mm1:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              67.7    98      0       0       1.01
2.5.42 [2]              72.5    93      0       0       1.08
2.5.42-mm3 [2]          78.1    93      0       0       1.16
2.5.43 [2]              74.6    92      0       0       1.11
2.5.43-mm1 [4]          74.9    93      0       0       1.12

Whatever it was that was making it take longer in 2.5.42-mm3 has made it go 
back to that of 2.5.43 vanilla. Note this is slower than 2.5.42 which is 
slower than 2.4.19.

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42-mm3 [2]          100.9   69      48      33      1.50
2.5.43 [2]              99.7    71      44      31      1.48
2.5.43-mm1 [4]          201.3   59      178     42      3.00

The context switching has gone mad here and done heaps more work at the 
expense of kernel compilation time. No cpu time appears to have been wasted 
though.

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42-mm3 [2]          96.2    80      1       6       1.43
2.5.43 [1]              97.6    79      1       7       1.45
2.5.43-mm1 [3]          94.6    81      1       6       1.41

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42-mm3 [2]          203.0   37      2       7       3.02
2.5.43 [1]              114.9   67      1       7       1.71
2.5.43-mm1 [3]          221.2   46      3       7       3.29

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42-mm3 [2]          393.1   19      27      11      5.85
2.5.43 [1]              578.9   13      45      12      8.62
2.5.43-mm1 [3]          383.0   21      27      11      5.70

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42-mm3 [2]          107.1   72      6       4       1.59
2.5.43 [3]              117.3   64      6       3       1.75
2.5.43-mm1 [3]          104.4   74      7       4       1.55

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42-mm3 [2]          97.1    73      1       21      1.45
2.5.43 [2]              93.0    76      1       18      1.38
2.5.43-mm1 [3]          97.3    73      0       19      1.45

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42-mm3 [2]          109.6   67      27      2       1.63
2.5.43 [1]              102.0   75      28      2       1.52
2.5.43-mm1 [3]          104.4   71      27      2       1.55

Con.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9rUG4F6dfvkL3i1gRAuXkAJ4n3BQCJo0IdI6ksPu2WmHNOyjr/wCgilC7
anG32JmGiFP3LQdXwa2yY1U=
=IbRi
-----END PGP SIGNATURE-----

