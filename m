Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbSLGFKB>; Sat, 7 Dec 2002 00:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267620AbSLGFKB>; Sat, 7 Dec 2002 00:10:01 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:15744 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267615AbSLGFKA> convert rfc822-to-8bit; Sat, 7 Dec 2002 00:10:00 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] max bomb segment tuning with read latency 2 patch in contest
Date: Sat, 7 Dec 2002 16:20:01 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212071620.05503.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are some io_load contest benchmarks with 2.4.20 with the read latency2 
patch applied and varying the max bomb segments from 1-6 (SMP used to save 
time!)

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              164.9   45      31      21      4.55
2420rl2b1 [5]           93.5    81      18      22      2.58
2420rl2b2 [5]           88.2    87      16      22      2.44
2420rl2b4 [5]           87.8    84      17      22      2.42
2420rl2b6 [5]           100.3   77      19      22      2.77

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              89.6    86      17      21      2.47
2420rl2b1 [3]           48.1    156     9       21      1.33
2420rl2b2 [3]           50.0    149     9       21      1.38
2420rl2b4 [5]           51.9    141     10      21      1.43
2420rl2b6 [5]           52.1    142     9       20      1.44

There seems to be a limit to the benefit of decreasing max bomb segments. It 
does not seem to have a significant effect on io load on another hard disk 
(although read latency2 is overall much better than vanilla).

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE98YUEF6dfvkL3i1gRAn4kAJ4x414sM3G+8fVrXv2P0huRhNKicgCgqFyo
kCXIKMVtO/Zp+tM92qlUz4s=
=HOKs
-----END PGP SIGNATURE-----
