Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSKXNXK>; Sun, 24 Nov 2002 08:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSKXNXK>; Sun, 24 Nov 2002 08:23:10 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:47488 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S261286AbSKXNXJ> convert rfc822-to-8bit; Sun, 24 Nov 2002 08:23:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Nero <neroz@iinet.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] rmap15, rmap14c and rc1aa1 with contest
Date: Mon, 25 Nov 2002 00:32:02 +1100
User-Agent: KMail/1.4.3
Cc: Rik van Riel <riel@conectiva.com.br>
References: <3DE0D157.9020906@iinet.net.au>
In-Reply-To: <3DE0D157.9020906@iinet.net.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211250032.05019.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks for this interesting comparison

>noload:
>Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>2.4.19-rmap15 [1]       84.6    95      0       0       1.00
>2.4.19-rmap14c [1]      84.2    96      0       0       1.00
>2.4.20-rc1aa1 [2]       41.0    49      0       0       inf

Clearly my braindead parser failed here. The time of aa1 should probably be 82 
seconds (41.0 x 2) Can you check the full log of 2.4.20-rc1aa1.log ? It has 
raw results.

>process_load:
>Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>2.4.19-rmap15 [1]       140.8   55      133     45      1.66
>2.4.19-rmap14c [1]      139.4   56      126     45      1.65
>2.4.20-rc1aa1 [2]       133.9   14      211     84      inf

If the error continued here (2 runs of process_load) then the time of aa1 
should be 133.9 x 2. Can you check the full log of 2.4.20-rc1aa1.log here 
too?

>io_load:
>Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>2.4.19-rmap15 [1]       164.8   51      33      19      1.95
>2.4.19-rmap14c [1]      160.1   53      33      21      1.90
>2.4.20-rc1aa1 [1]       166.2   49      44      23      inf
>
>read_load:
>Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>2.4.19-rmap15 [1]       0.0     0       0       7       0.00
>2.4.19-rmap14c [1]      121.0   72      20      7       1.44
>2.4.20-rc1aa1 [1]       111.2   79      34      14      inf
>
>rmap15 OOM'd the cc1 process twice and fscked this run up.
>
>list_load:
>Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>2.4.19-rmap15 [1]       99.2    84      0       7       1.17
>2.4.19-rmap14c [1]      100.7   83      0       7       1.20
>2.4.20-rc1aa1 [1]       96.7    85      0       8       inf
>
>mem_load:
>Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>2.4.19-rmap15 [1]       111.2   80      96      8       1.31
>2.4.19-rmap14c [1]      106.1   82      96      9       1.26
>2.4.20-rc1aa1 [1]       126.3   66      77      3       inf

With only one run these numbers appear not to be greatly statistically 
significant, except for the mem_load results.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE94NTSF6dfvkL3i1gRAkwXAJ9YJmnxvxdiYyESNYLeQa9sbwR+2wCcCZal
bFKWReK3EP8oayP/GwiIK7c=
=gYaS
-----END PGP SIGNATURE-----
