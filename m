Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSJQKw4>; Thu, 17 Oct 2002 06:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbSJQKw4>; Thu, 17 Oct 2002 06:52:56 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:896 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261356AbSJQKwz> convert rfc822-to-8bit; Thu, 17 Oct 2002 06:52:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.43-mm2 with contest
Date: Thu, 17 Oct 2002 20:56:38 +1000
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1034840438.3dae6976a93fb@kolivas.net> <3DAE6E63.EFAF0F80@digeo.com>
In-Reply-To: <3DAE6E63.EFAF0F80@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210172056.45002.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 17 Oct 2002 6:01 pm, Andrew Morton wrote:
> Con Kolivas wrote:
> > Here are the updated benchmarks with contest v0.51
> > (http://contest.kolivas.net) showing the change from -mm1 to -mm2. Other
> > results removed for clarity.
> >
> > noload:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.18 [3]              71.8    93      0       0       1.01
> > 2.5.43 [2]              74.6    92      0       0       1.04
> > 2.5.43-mm1 [4]          74.9    93      0       0       1.05
> > 2.5.43-mm2 [2]          73.4    93      0       0       1.03
>
> Would be interesting to run
>
> 	blockdev --setra 1024 /dev/hdXX
>
> here.  We're getting more idle time with 2.5 and that can only
> be due to disk wait - the IO scheduler changes.  This might make a
> small difference.

Well that isn't it (b is with ra 1024):

2.5.43-mm2 [2]          73.4    93      0       0       1.03
2.5.43-mm2b [3]         76.4    94      0       0       1.07

>
> > ...
> > Removal of per-cpu pages patch does not seem to have been detrimental to
> > contest benchmarks at least - perhaps this is responsible for the noload
> > being better now?
>
> Well that code is still there.  I'd expect a very small benefit from it
> in this testing.

Sorry. Misunderstood your announce message.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9rpdrF6dfvkL3i1gRAu5AAJ9B3LJ3kuplNHdhJGsW785CJ2i4GgCfRs9W
d2BW4cSQaanL/FjJTu3gU9k=
=+Foh
-----END PGP SIGNATURE-----

