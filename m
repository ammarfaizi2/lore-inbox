Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSLAHbw>; Sun, 1 Dec 2002 02:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSLAHbw>; Sun, 1 Dec 2002 02:31:52 -0500
Received: from 28-121-ADSL.red.retevision.es ([80.224.121.28]:1220 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S261495AbSLAHbv>; Sun, 1 Dec 2002 02:31:51 -0500
Date: Sun, 1 Dec 2002 08:39:14 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: khromy <khromy@lnuxlab.ath.cx>, linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021201073914.GA2432@jerry.marcet.dyndns.org>
References: <20021130182345.GA21410@lnuxlab.ath.cx> <20021130184317.GH28164@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20021130184317.GH28164@dualathlon.random>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.4.20-jam0-marcet i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Andrea Arcangeli <andrea@suse.de> [021130 19:47]:

>> > I have the problem without leaving it a few hours, but when I do it ge=
ts
>> > definitely worse. Last vmstat output I quoted here showed around 256MB
>> > swapped. A few hours later - the computer had been sitting idle, only
>> > the mail server for three users was running which poses no overhead at
>> > all -, the entire 512MB SWAP space was used. Why, I don't know.
=20
>> > I'm about to try 2.4.20-jam0, -aa derived. I'll post results from that
>> > kernel later.
=20
>> aa runs beautifully but it locked up once on me..

>send me SYSRQ+T SYSRQ+P and everything else you know about it. if you
>have AGP enabled try to reproduce with 10_x86-fast-pte-2 backed out.
>thanks,

It had locked here before. Right now I'm running 2.4.20-jam0 although
not complete, I didn't apply:

02-revert-fast-pte-2.bz2    ->    since it seems this is a trouble spot
50-ide-10-partial.bz2       ->    because it locked when uncompressing
51-severworks-ide.bz2             mozilla's sources
61-proconfig-0.9.5.bz2      ->    it did not compile, besides I prefer
                                  config.gz I get with other patch
80-bproc-3.2.3.bz2          ->    didn't need that at all on my desktop
81-export-task_nice.bz2     ->    idem

I have also applied acpi-20021126-2.4.20-rc3.diff.gz

So far I've uncompressed mozilla's sources a couple times while
compiling another thing with -j2 and there's been no problem at all.
Also, -aa kernels are the only ones which behave better in vm management
on my system, besides 2.5.x of course.
I'll put the system under some pressure along the day and see if no lock
ups show up.
Anything else you'd like me to try out? Be it io tests or whatever. At
the moment I can say I do not miss preempt-kernel patches nor have I
noticed any slowdown appreciable.

PS This is a UP system, Athlon-XP 1800+ and VIA KT133A based. Both IDE
ATA5 HD connected to VIA's controller and U2W drive connected to Adaptec
2940-U2W. Only 384MB of memory which had led me to believe all my
problems were due to lack of memory, not so I'm seeing with -aa and 2.5
kernels.


--=20
Javier Marcet <jmarcet@pobox.com>

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3pvKEACgkQx/ptJkB7frxERACggTrCrw/RTlT9hm757vSw4R48
xCMAnRdqdJxO1v4XcRG+fxixb292nStO
=bp1W
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
