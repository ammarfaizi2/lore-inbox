Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267230AbSKPGQv>; Sat, 16 Nov 2002 01:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267231AbSKPGQv>; Sat, 16 Nov 2002 01:16:51 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:9344 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267230AbSKPGQu> convert rfc822-to-8bit; Sat, 16 Nov 2002 01:16:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.47-mm3 with contest
Date: Sat, 16 Nov 2002 17:23:25 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200211161422.17438.conman@kolivas.net> <3DD5BBD9.7DA70FFF@digeo.com>
In-Reply-To: <3DD5BBD9.7DA70FFF@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211161723.35763.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>Con Kolivas wrote:
>> Note the significant discrepancy between mm1 and mm3. This reminds me of
>> what happened last time I enabled shared 3rd level pagetables - Andrew do
>> you want me to do a set of numbers with this disabled?
>
>That certainly couldn't hurt.  But your tests are, in general, tesging
>the IO scheduler.  And the IO scheduler has changed radically in each
>of the recent -mm's.
>
>So testing with rbtree-iosched reverted would really be the only way
>to draw comparisons on how the rest of the code is behaving.

Ok. Tested with shared disabled (2.5.47-mm3ns) and are very similar. These 
were the only significant differences:

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.47-mm3 [2]          218.5   34      10      2       3.06
2.5.47-mm3ns [2]        257.9   29      11      2       3.61

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.47-mm3 [2]          211.3   38      2       6       2.96
2.5.47-mm3ns [2]        152.8   49      2       7       2.14

Con.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE91eRiF6dfvkL3i1gRAtclAJwLr2jxRHuhqkKUpwraJW3z8zawAACffH+c
4D5+HaXXSNwuyiGqULB02B4=
=dpn2
-----END PGP SIGNATURE-----

