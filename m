Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUBTWra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 17:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUBTWo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 17:44:56 -0500
Received: from chef.nerp.net ([199.199.210.160]:5767 "EHLO chef.nerp.net")
	by vger.kernel.org with ESMTP id S261406AbUBTWlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 17:41:37 -0500
Date: Fri, 20 Feb 2004 16:41:34 -0600
From: Chad Walstrom <chewie@wookimus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: NAT over 3c59x cards freezes interactivity on 2.6.2
Message-ID: <20040220224134.GA24203@wookimus.net>
References: <20040212171647.GW6864@wookimus.net> <20040212184208.48a93b39.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20040212184208.48a93b39.akpm@osdl.org>
X-Operating-System: Linux skuld 2.6.2-k7
X-GnuPG-Fingerprint: B4AB D627 9CBD 687E 7A31  1950 0CC7 0B18 206C 5AFD
Keywords: none
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2004 at 06:42:08PM -0800, Andrew Morton wrote:
> Chad Walstrom <chewie@wookimus.net> wrote:
> >
> > [2.] DETAILS: Upon upgrading from 2.4.x to 2.6.2, I've noticed that my
> >  workstation/NAT box freezes on interactive processes while transfering
> >  large files over NAT to other machines on the network.=20
>=20
> Please monitor the system time with top or `vmstat 1'.  Is it excessive?

I'm not sure what excessive might mean.  There doesn't seem to be any
spikes in memory consumption.  Following is the output from 'vmstat 1'.
The number of procs waiting for run time increases when the
interactivity freezes (while the laptop is downloading files over the
workstation's NAT).  The '6' and '5' both occur during download attempts
and interactivy freezes.  When I kill the download, interactivy resumes,
and the waiting processes drops.

Script started on Fri Feb 20 16:17:30 2004
[16:17:30] chewie@skuld (501)$ vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu-=
---
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id=
 wa
 2  0   9364   2560  46256 300188    0    0    10    12   35    44 96  1  3=
  0
 1  0   9364   2560  46256 300188    0    0     0     0 1008    63 100  0  =
0  0
 1  0   9364   2560  46264 300188    0    0     0    12 1008    56 100  0  =
0  0
 1  0   9364   2368  46264 300216    0    0     0     0 1151   173 96  4  0=
  0
 1  0   9364   2240  46272 300340    0    0     0    12 1690   654 93  7  0=
  0
 6  1   9364   3584  45232 300448    0    0     0     8 1600   737 92  8  0=
  0
 3  0   9364   3584  45236 300600    0    0     0     1 1834   846 90 10  0=
  0
 3  0   9364   3528  45236 300656    0    0     0     0 1308   350 98  2  0=
  0
 3  0   9364   3528  45240 300664    0    0     0    12 1055   113 99  1  0=
  0
 1  0   9364   3144  45240 300848    0    0     0     0 1898   913 92  8  0=
  0
 1  0   9364   2888  45240 301088    0    0     0     0 2172  1249 85 15  0=
  0
 1  0   9364   2696  45240 301304    0    0     0     0 2107  1148 87 13  0=
  0
 5  0   9364   2696  45244 301472    0    0     0    12 1554   864 86 14  0=
  0
 1  0   9364   2504  45244 301508    0    0     0     0  473   165 95  5  0=
  0
 1  0   9364   2568  45244 301584    0    0     0     0 1289   438 100  0  =
0  0
 1  0   9364   2568  45244 301592    0    0     0     0 1039    91 99  1  0=
  0
 1  0   9364   2568  45304 301592    0    0     0   112 1023    83 100  0  =
0  0
 1  0   9364   2568  45304 301596    0    0     0     0 1016   100 100  0  =
0  0

[16:17:49] chewie@skuld (502)$ exit
exit

Script done on Fri Feb 20 16:17:54 2004

> A kernel profile might tell us what is going on.  See
> Documentation/basic_profiling.txt.

I'll have to recompile the kernel to test this for you.  I'll do so and
compile 2.6.3.

> If you remove all the netfilter rules, what happens?

Then I wouldn't be able to NAT. ;-)  The workstation works fine as a
standalone.  I've downloaded large files w/o too much difficulty, and
interactivity remains stable.  The only time I see problems is when I'm
downloading files through NAT to the laptop.

(Sorry it took so long to reply.  We're a bit down in the weather at our
house lately.)

--=20
Chad Walstrom <chewie@wookimus.net>           http://www.wookimus.net/
           assert(expired(knowledge)); /* core dump */

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFANo0eDMcLGCBsWv0RAmvzAKDaU6DH7GOywh8OexuF8OLA2/qkuwCgz/ZS
gJ9aRgdSjSmh2Kmyw613Yx0=
=5X9l
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
