Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbSK3FKM>; Sat, 30 Nov 2002 00:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbSK3FKL>; Sat, 30 Nov 2002 00:10:11 -0500
Received: from 174-121-ADSL.red.retevision.es ([80.224.121.174]:32195 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S267215AbSK3FKK>; Sat, 30 Nov 2002 00:10:10 -0500
Date: Sat, 30 Nov 2002 06:17:32 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021130051731.GG15682@jerry.marcet.dyndns.org>
References: <20021130013832.GF15682@jerry.marcet.dyndns.org> <Pine.LNX.4.44L.0211292349550.15981-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211292349550.15981-100000@imladris.surriel.com>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.4.20-ac1-marcet i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Rik van Riel <riel@conectiva.com.br> [021130 02:57]:

>> root # vmstat 1
>> procs -----------memory---------- ---swap-- -----io---- --system-- ----c=
pu----
>>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy=
 id wa
>>  0  1 265048   5248  32248 119108    6   15    65    62  252   585 21  6=
 73  0
>>  1  6 266648   4480  32316 120300    0 4656  2152  4652 1348   821 13  8=
 79  0
>>  1  0 265052   4496  31036 120184    8  336  1668   340 1226   765 15  7=
 78  0
>>  0  1 265052   4496  31112 121564    4    0  3152     0 1198   894 18  8=
 74  0
>>  1  0 265052   4504  31076 123112    0    0  3024  8576 1229   857 17  7=
 76  0
>                                      ^^^^^^^^^^^^^^^^^^^

>Looks like my guess was right after all.  The amount of swap
>IO is maybe 10% of the amount of filesystem IO in your vmstat
>snippet above.

>Two things could be happening here:

>1) the kernel decides to cache the wrong things in the
>   page cache

>and/or

>2) the IO scheduler is giving worse latencies now

>If the problem is (1) it might get resolved by using the -rmap
>or -aa kernels.  If the problem is (2) you'll want Andrew Morton's
>read_latency patch (which I'll port to 2.4.20 real soon now).

All right. I might be wrong, but this was with kernel 2.4.20-rc4-ac1
Doesn't it include rmap?
Also it was patched with Robert Love's preempt-kernel. Of course I've
tried without it as with various other kernel tidbits.
I always tend to use ac kernels + some other patches which aside from
preempt have nothing to do with system's basic behavior.
Yet the only time I get a good system response is with 2.5.47-ac6
(2.5.48+ drive me nuts with module loading) and with Marc-Christian
Petersen's 2.4.18-wolk which includes nearly everything out there.


--=20
Javier Marcet <jmarcet@pobox.com>

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3oSesACgkQx/ptJkB7frzhEQCbBhAAlhZy1/QxUpxeerrrKuSF
ok4AmgPgfhhTyF2U66lcQ8kcuic1gU42
=DF1k
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
