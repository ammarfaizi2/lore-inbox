Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSKXN1w>; Sun, 24 Nov 2002 08:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSKXN1w>; Sun, 24 Nov 2002 08:27:52 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:61453 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S261290AbSKXN1v>;
	Sun, 24 Nov 2002 08:27:51 -0500
Message-ID: <3DE0D57E.8060203@iinet.net.au>
Date: Mon, 25 Nov 2002 00:34:54 +1100
From: Nero <neroz@iinet.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] rmap15, rmap14c and rc1aa1 with contest
References: <3DE0D157.9020906@iinet.net.au> <200211250032.05019.conman@kolivas.net>
In-Reply-To: <3DE0D157.9020906@iinet.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Thanks for this interesting comparison
>
>
> >noload:
> >Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> >2.4.19-rmap15 [1]       84.6    95      0       0       1.00
> >2.4.19-rmap14c [1]      84.2    96      0       0       1.00
> >2.4.20-rc1aa1 [2]       41.0    49      0       0       inf
>
>
> Clearly my braindead parser failed here. The time of aa1 should 
> probably be 82
> seconds (41.0 x 2) Can you check the full log of 2.4.20-rc1aa1.log ? 
> It has
> raw results.
>
Yep.
noload Time: 81.95  CPU: 98%  LoadRuns: 0  LoadCPU%: 0

>
> >process_load:
> >Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> >2.4.19-rmap15 [1]       140.8   55      133     45      1.66
> >2.4.19-rmap14c [1]      139.4   56      126     45      1.65
> >2.4.20-rc1aa1 [2]       133.9   14      211     84      inf
>
>
> If the error continued here (2 runs of process_load) then the time of aa1
> should be 133.9 x 2. Can you check the full log of 2.4.20-rc1aa1.log here
> too?

process_load Time: 267.85  CPU: 29%  LoadRuns: 422  LoadCPU%: 70%

>
>
> >io_load:
> >Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> >2.4.19-rmap15 [1]       164.8   51      33      19      1.95
> >2.4.19-rmap14c [1]      160.1   53      33      21      1.90
> >2.4.20-rc1aa1 [1]       166.2   49      44      23      inf
> >
> >read_load:
> >Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> >2.4.19-rmap15 [1]       0.0     0       0       7       0.00
> >2.4.19-rmap14c [1]      121.0   72      20      7       1.44
> >2.4.20-rc1aa1 [1]       111.2   79      34      14      inf
> >
> >rmap15 OOM'd the cc1 process twice and fscked this run up.
> >
> >list_load:
> >Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> >2.4.19-rmap15 [1]       99.2    84      0       7       1.17
> >2.4.19-rmap14c [1]      100.7   83      0       7       1.20
> >2.4.20-rc1aa1 [1]       96.7    85      0       8       inf
> >
> >mem_load:
> >Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> >2.4.19-rmap15 [1]       111.2   80      96      8       1.31
> >2.4.19-rmap14c [1]      106.1   82      96      9       1.26
> >2.4.20-rc1aa1 [1]       126.3   66      77      3       inf
>
>
> With only one run these numbers appear not to be greatly statistically
> significant, except for the mem_load results.
>
> Con
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.0 (GNU/Linux)
>
> iD8DBQE94NTSF6dfvkL3i1gRAkwXAJ9YJmnxvxdiYyESNYLeQa9sbwR+2wCcCZal
> bFKWReK3EP8oayP/GwiIK7c=
> =gYaS
> -----END PGP SIGNATURE-----
>
>


