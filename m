Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSLFLuq>; Fri, 6 Dec 2002 06:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbSLFLuq>; Fri, 6 Dec 2002 06:50:46 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:17793 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S261996AbSLFLup> convert rfc822-to-8bit; Fri, 6 Dec 2002 06:50:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH 2.4.20-aa1] Readlatency-2
Date: Fri, 6 Dec 2002 23:00:42 +1100
User-Agent: KMail/1.4.3
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
References: <200212061038.27387.m.c.p@wolk-project.de> <200212062045.25377.conman@kolivas.net> <3DF08BC7.62436532@digeo.com>
In-Reply-To: <3DF08BC7.62436532@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212062300.49274.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>Con Kolivas wrote:
>> io_load:
>> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> 2.4.20 [5]              203.4   33      40      15      3.07
>> 2.4.20aa1 [3]           238.3   27      46      15      3.60
>> 2.4.20aa1rl2 [3]        302.5   22      63      16      4.57
>
>Something must have gone wrong here.  rl2 cannot be worse than
>2.4.20 in this test.
>
>Umm, quick sanity check:
>
>2.4.20-rl2      321.44  147%    96      24%
>2.4.20          361.70  130%    108     24%
>
>So only a 10% speedup, but certainly not a 50% slowdown.  (That is
>on scsi).
>
>Maybe a patch preparation problem?

This seems to be more of a disagreement with -aa1 and -rl2 than -rl2 per se.
Just FYI here's a copy of the SMP results that were in the other thread 
entitled "[PATCH] 2.4.20-rmap15a": 

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              162.3   45      28      19      4.48
2.4.20 [5]              164.9   45      31      21      4.55
2.4.20-rl2 [3]          101.8   76      19      22      2.81

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              62.3    117     11      20      1.72
2.4.20 [5]              89.6    86      17      21      2.47
2.4.20-rl2 [3]          51.8    142     10      21      1.43

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE98JFqF6dfvkL3i1gRAgKLAJ49oxR+oe3k3UXrUycrsMeFVm8eYACdGmWU
mUuOA1uyw0xhPyQtcxvRyz0=
=OR9G
-----END PGP SIGNATURE-----
