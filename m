Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSLGNUC>; Sat, 7 Dec 2002 08:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSLGNUC>; Sat, 7 Dec 2002 08:20:02 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:19585 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S262457AbSLGNUB> convert rfc822-to-8bit; Sat, 7 Dec 2002 08:20:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] max bomb segment tuning with read latency 2 patch in contest
Date: Sun, 8 Dec 2002 00:29:46 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
References: <200212071620.05503.conman@kolivas.net>
In-Reply-To: <200212071620.05503.conman@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212080030.04381.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>Here are some io_load contest benchmarks with 2.4.20 with the read latency2
>patch applied and varying the max bomb segments from 1-6 (SMP used to save
>time!)
>
>io_load:
>Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>2.4.20 [5]              164.9   45      31      21      4.55
>2420rl2b1 [5]           93.5    81      18      22      2.58
>2420rl2b2 [5]           88.2    87      16      22      2.44
>2420rl2b4 [5]           87.8    84      17      22      2.42
>2420rl2b6 [5]           100.3   77      19      22      2.77
>
>io_other:
>Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>2.4.20 [5]              89.6    86      17      21      2.47
>2420rl2b1 [3]           48.1    156     9       21      1.33
>2420rl2b2 [3]           50.0    149     9       21      1.38
>2420rl2b4 [5]           51.9    141     10      21      1.43
>2420rl2b6 [5]           52.1    142     9       20      1.44
>
>There seems to be a limit to the benefit of decreasing max bomb segments. It
>does not seem to have a significant effect on io load on another hard disk
>(although read latency2 is overall much better than vanilla).
>
>Con

Further testing with changing values of read and write latencies (with fixed 
max_bomb to 4) and the read latency 2 patch in place shows no significant 
change to these figures over a wide range of numbers. This was not the case 
when I ran contest with different read latency values on the vanilla kernel 
(and found -r 512 to be a reasonable compromise according to Jens). Is there 
some other advantage to be gained by say increasing these numbers? (since 
contest results don't change with higher numbers either)

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE98ffKF6dfvkL3i1gRAo01AJ0Zvs0x80vGF1hUillnIL4y+f6xRQCfZyni
YkNWPMORdfjRHfG5/6NxV4M=
=g1ht
-----END PGP SIGNATURE-----
