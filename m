Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSKKEUv>; Sun, 10 Nov 2002 23:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbSKKEUv>; Sun, 10 Nov 2002 23:20:51 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:1664 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S265480AbSKKEUs> convert rfc822-to-8bit; Sun, 10 Nov 2002 23:20:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Date: Mon, 11 Nov 2002 15:26:17 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>,
       Marcelo <marcelo@conectiva.com.br>
References: <200211091300.32127.conman@kolivas.net> <200211100854.05713.conman@kolivas.net> <20021110100942.GG31134@suse.de>
In-Reply-To: <20021110100942.GG31134@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211111526.56782.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>On Sun, Nov 10 2002, Con Kolivas wrote:
>> io_load:
>> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> 2420rc1r0 [3]           489.3   15      36      10      6.85
>> 2420rc1r8 [3]           485.5   15      35      10      6.80
>> 2420rc1r16 [3]          570.4   12      43      10      7.99
>> 2420rc1r32 [3]          570.1   12      42      10      7.98
>> 2420rc1r64 [3]          575.0   12      43      10      8.05
>> 2420rc1r128 [3]         611.4   11      46      10      8.56
>> 2420rc1r256 [3]         646.2   11      49      10      9.05
>> 2420rc1r512 [3]         603.7   12      45      10      8.46
>> 2420rc1r1024 [3]        693.9   10      53      10      9.72
>> 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
>>
>> Test hardware is 1133Mhz P3 laptop with 5400rpm ATA100 drive. I don't
>> doubt the response curve would be different for other hardware.
>
>That looks pretty good, the behaviour in 2.4.20-rc1 is no sanely tunable
>unlike before. Could you retest the whole contest suite with 512 as the
>default value? It looks like a good default for 2.4.20.

Ok here they are:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [5]              71.7    93      0       0       1.00
2.4.19 [5]              69.0    97      0       0       0.97
2.4.20-rc1 [3]          72.2    93      0       0       1.01
2420rc1r512 [3]         71.6    93      0       0       1.00

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [2]              66.6    99      0       0       0.93
2.4.19 [2]              68.0    99      0       0       0.95
2.4.20-rc1 [3]          67.2    99      0       0       0.94
2420rc1r512 [3]         67.1    99      0       0       0.94

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              109.5   57      119     44      1.53
2.4.19 [3]              106.5   59      112     43      1.49
2.4.20-rc1 [3]          110.7   58      119     43      1.55
2420rc1r512 [3]         112.1   57      122     43      1.57

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              117.4   63      1       7       1.64
2.4.19 [2]              106.5   70      1       8       1.49
2.4.20-rc1 [3]          102.1   72      1       7       1.43
2420rc1r512 [3]         101.7   73      1       8       1.42

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              150.8   49      2       8       2.11
2.4.19 [1]              132.4   55      2       9       1.85
2.4.20-rc1 [3]          180.7   40      3       8       2.53
2420rc1r512 [3]         170.0   44      3       7       2.38

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              474.1   15      36      10      6.64
2.4.19 [3]              492.6   14      38      10      6.90
2.4.20-rc1 [2]          1142.2  6       90      10      16.00
2420rc1r512 [6]         602.7   12      45      10      8.44

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              102.3   70      6       3       1.43
2.4.19 [2]              134.1   54      14      5       1.88
2.4.20-rc1 [3]          173.2   43      20      5       2.43
2420rc1r512 [3]         112.5   67      11      5       1.58

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              90.2    76      1       17      1.26
2.4.19 [1]              89.8    77      1       20      1.26
2.4.20-rc1 [3]          88.8    77      0       12      1.24
2420rc1r512 [3]         88.0    78      0       12      1.23

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              103.3   70      32      3       1.45
2.4.19 [3]              100.0   72      33      3       1.40
2.4.20-rc1 [3]          105.9   69      32      2       1.48
2420rc1r512 [3]         105.0   70      33      3       1.47

Looks good. Note that read_load is a lot "better" too.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9zzFtF6dfvkL3i1gRAvQ/AJ0UK7za0Uvy6SnyPxFoYEjcX2iGDACcCWfx
WRq8eTboTj6bRCzERw/gMfo=
=kSMm
-----END PGP SIGNATURE-----

