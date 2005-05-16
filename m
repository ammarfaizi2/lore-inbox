Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVEPSAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVEPSAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVEPR7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:59:40 -0400
Received: from iai.speak-friend.de ([62.75.222.128]:2693 "EHLO
	iai.speak-friend.de") by vger.kernel.org with ESMTP id S261769AbVEPR7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:59:08 -0400
From: Christian Parpart <trapni@gentoo.org>
Organization: Gentoo Linux Foundation
To: linux-kernel@vger.kernel.org
Subject: Re: I'm having 4GB RAM, but Linux sees just 3GB???
Date: Mon, 16 May 2005 19:59:02 +0200
User-Agent: KMail/1.8
References: <200505161604.10881.trapni@gentoo.org> <200505161701.06558.trapni@gentoo.org> <4288DCE7.9070508@didntduck.org>
In-Reply-To: <4288DCE7.9070508@didntduck.org>
X-Face: $-3HTEy*5}2A{'R'VPim$,8KKX$l|:P^RhP{;yQ)g;]4isyohrOfk\)=?utf-8?q?Q=2Ep=23F3RWB=7D!m=24zn=0A=097=5CPUKBYRKDFUU=3A=5CZ+U=5Fa-/=5BhI?=
 =?utf-8?q?8DJZ?="WPC2j~}(N."(JB&VNb}kU&`>
 =?utf-8?q?9=3B=5FN=3BfnM=7BD=7B8=2EI+5=0A=09dg=60p=5EQ?=(:yE{eVgArPf190vEkbGis0vx];"
 =?utf-8?q?1O!L=7ByKN4J=5B4=27=7E=7Eh+o+=7D=2EgzkmqNs=60=7D=7C0uq8a=0A=09?=
 =?utf-8?q?=25WQg=3F=3D=25y7X74tMWEkL=5DQQ?=(_Yc"m*aC+HD%!,6/k>L7S%'<}_B2&cI}/W(p+;rJ%2`0A<)
 =?utf-8?q?F=0A=09P7P=2E=60=3Dy=7C=7DU=7E=3F!?=<z?6Bj!TDP-w|q0K<{P)%u~}q3&#|Zh)Fa]!D8t
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2012638.AcgD6rvrPt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505161959.04440.trapni@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2012638.AcgD6rvrPt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(oops)

On Monday 16 May 2005 7:48 pm, Brian Gerst wrote:
> >  BIOS-e820: 0000000000000000 - 0000000000094800 (usable)
> >  BIOS-e820: 0000000000094800 - 00000000000a0000 (reserved)
> >  BIOS-e820: 00000000000c2000 - 0000000000100000 (reserved)
> >  BIOS-e820: 0000000000100000 - 00000000bff20000 (usable)
> >  BIOS-e820: 00000000bff20000 - 00000000bff2e000 (ACPI data)
> >  BIOS-e820: 00000000bff2e000 - 00000000bff80000 (ACPI NVS)
> >  BIOS-e820: 00000000bff80000 - 00000000c0000000 (reserved)
> >  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
> >  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
> >  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> >  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> >
> > hmm... what does this mean?
>
> It means that there is a hole at 00000000c0000000 - 0000000100000000
> (3GB-4GB) for PCI memory-mapped devices.  The 4th GB of RAM should be
> remapped by the BIOS to 4GB-5GB, but isn't.  Your BIOS is either buggy
> or misconfigured.

Aiiii, that's good news.

I found a "Memhole" area. But I never used to change these items.=20
Unfortunately, my TYAN board reference guide isn't telling me what to chang=
e=20
there for good - so - can you tell me where to find more information about=
=20
there?

If I remember correctly, it provided me the options ("Automatic"/"Manual") =
and=20
a value list with the following items:
=A0 64MB 128MB, 256MB, 512MB, 1024MB 2048MB, 3G, 3.5G.

and another list I can't remember by now.

but *playing* around with these values didn't help much (I just reduced my=
=20
memory in linux down to 2GB once but didn't find the right values for getti=
ng=20
4GB).

So, what should I do then?

Best reagrds,
Christian Parpart.

=2D-=20
Netiquette: http://www.ietf.org/rfc/rfc1855.txt
=A019:52:02 up 54 days, =A08:58, =A00 users, =A0load average: 0.67, 0.64, 0=
=2E62

--nextPart2012638.AcgD6rvrPt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCiN9oPpa2GmDVhK0RAl3BAJwJUnxszG77iWsCXMvjg3qmOngjGQCgg11k
tFm5PIURiEBiIhVUrgdaKk0=
=Y/NR
-----END PGP SIGNATURE-----

--nextPart2012638.AcgD6rvrPt--
