Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVEPPH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVEPPH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVEPPH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:07:57 -0400
Received: from iai.speak-friend.de ([62.75.222.128]:65156 "EHLO
	iai.speak-friend.de") by vger.kernel.org with ESMTP id S261680AbVEPPFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:05:44 -0400
From: Christian Parpart <trapni@gentoo.org>
Organization: Gentoo Linux Foundation
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: I'm having 4GB RAM, but Linux sees just 3GB???
Date: Mon, 16 May 2005 17:01:04 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200505161604.10881.trapni@gentoo.org> <4288B1BC.5050207@didntduck.org>
In-Reply-To: <4288B1BC.5050207@didntduck.org>
X-Face: $-3HTEy*5}2A{'R'VPim$,8KKX$l|:P^RhP{;yQ)g;]4isyohrOfk\)=?utf-8?q?Q=2Ep=23F3RWB=7D!m=24zn=0A=097=5CPUKBYRKDFUU=3A=5CZ+U=5Fa-/=5BhI?=
 =?utf-8?q?8DJZ?="WPC2j~}(N."(JB&VNb}kU&`>
 =?utf-8?q?9=3B=5FN=3BfnM=7BD=7B8=2EI+5=0A=09dg=60p=5EQ?=(:yE{eVgArPf190vEkbGis0vx];"
 =?utf-8?q?1O!L=7ByKN4J=5B4=27=7E=7Eh+o+=7D=2EgzkmqNs=60=7D=7C0uq8a=0A=09?=
 =?utf-8?q?=25WQg=3F=3D=25y7X74tMWEkL=5DQQ?=(_Yc"m*aC+HD%!,6/k>L7S%'<}_B2&cI}/W(p+;rJ%2`0A<)
 =?utf-8?q?F=0A=09P7P=2E=60=3Dy=7C=7DU=7E=3F!?=<z?6Bj!TDP-w|q0K<{P)%u~}q3&#|Zh)Fa]!D8t
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1392062.OW0lcv92zF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505161701.06558.trapni@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1392062.OW0lcv92zF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 16 May 2005 4:44 pm, Brian Gerst wrote:
> Christian Parpart wrote:
> > Hi all,
> >
> > I was asking this in gentoo-server mailing list before, however, they
> > finally pointed me to this place as it could also be a bug in the kerne=
l.
> >
> > I'm having a TYAN board with two AMD Opteron 248 and 4x 1GB ECC RAM on
> > it. The BIOS reflects what I've plugged in, however, the operating syst=
em
> > does not.
> >
> > my `uname -a` output is:
> > Linux battousai 2.6.11-gentoo-r8 #1 SMP Sat May 14 02:42:15 CEST 2005
> > x86_64 AMD Opteron(tm) Processor 248 AuthenticAMD GNU/Linux
> >
> > and my `dmidecode` output is located at [0]. For ANY reason, dmidecode
> > even knows about my 4GB RAM, but `free -m` nor `kinfocenter` of KDE
> > claims to see just 3GB.
> >
> > free -m:
> >              total       used       free     shared    buffers     cach=
ed
> > Mem:          3015       2993         22          0         15       26=
38
> > -/+ buffers/cache:        338       2677
> > Swap:          511          1        510
> >
> > This is rather sad to see 1GB RAM plugged in for nothing.
> >
> > Has anyone a hint for my WHY this is happening and HOW I could get rid =
of
> > it?
> >
> > Thanks in advance,
> > Christian Parpart.
> >
> > [0] http://dev.gentoo.org/~trapni/dmidecode.txt
>
> Are you running a 64-bit kernel?  What does "dmesg | grep e820" show?

 BIOS-e820: 0000000000000000 - 0000000000094800 (usable)
 BIOS-e820: 0000000000094800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c2000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bff20000 (usable)
 BIOS-e820: 00000000bff20000 - 00000000bff2e000 (ACPI data)
 BIOS-e820: 00000000bff2e000 - 00000000bff80000 (ACPI NVS)
 BIOS-e820: 00000000bff80000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)

hmm... what does this mean?

Well, yeah, the whole system is 64bit compiled.

Regards,
Christian Parpart.

=2D-=20
Netiquette: http://www.ietf.org/rfc/rfc1855.txt
 17:00:30 up 54 days,  6:06,  0 users,  load average: 0.64, 0.45, 0.46

--nextPart1392062.OW0lcv92zF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCiLWyPpa2GmDVhK0RAplmAJ9WI94I1FwS0fyx7rWaFYH7nX64QwCfdbAk
5VJyfPcgzmojlKOPgIpDowE=
=s4l2
-----END PGP SIGNATURE-----

--nextPart1392062.OW0lcv92zF--
