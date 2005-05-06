Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVEFSPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVEFSPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 14:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVEFSPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 14:15:54 -0400
Received: from mail01.solnet.ch ([212.101.4.135]:48399 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S261258AbVEFSPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 14:15:45 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm2 - kswapd0 keeps running
Date: Fri, 6 May 2005 20:07:23 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20050430164303.6538f47c.akpm@osdl.org> <200505021732.00590.damir.perisa@solnet.ch> <20050502111452.0dca6625.akpm@osdl.org>
In-Reply-To: <20050502111452.0dca6625.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4984204.07VR7y0KTh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505062007.27256.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4984204.07VR7y0KTh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Monday 02 May 2005 20:14, Andrew Morton a =E9crit=A0:
> hm. =A0I wonder why you had any cachefs pages anyway. =A0Is the sysrq-P
> trace always the same?

ok, now after collecting the data after a lot of "sysrq-p" after a lot=20
times running into the same 100% of kswapd0, i am sure: it's always the=20
same trouble.

it's also reproducable with rc3-mm3

> Does disabling cachefs in kerel config fix it?

it seems so, yes. now i'm running rc3-mm3 with disabled cachefs (config=20
can be found at [1]) for more than 6 hours (also under heavy I/O on=20
harddrives) and it is still behaving normal - no running kswapd0 any more=20
(kswapd0 finally managed to find some sleep ;-) )

greetings,

Damir

[1] :=20
http://cvs.archlinux.org/cgi-bin/viewcvs.cgi/kernels/kernel26mm/config?rev=
=3D1.20&cvsroot=3DExtra&only_with_tag=3DCURRENT&content-type=3Dtext/vnd.vie=
wcvs-markup


=2D-=20
"Protozoa are small, and bacteria are small, but viruses are smaller
than the both put together."

--nextPart4984204.07VR7y0KTh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCe7JfPABWKV6NProRAn5yAJ9F5I88cYS1cfOGdnosqVYnrz17zQCaAi9c
kVjiTOvXikLLiTcnnzd2uuE=
=eMZW
-----END PGP SIGNATURE-----

--nextPart4984204.07VR7y0KTh--
