Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbVJEMeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbVJEMeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVJEMeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:34:31 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:65181 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965151AbVJEMeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:34:31 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.13-ck7
Date: Wed, 5 Oct 2005 22:34:18 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1325613.oHj1g7AUGh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510052234.22302.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1325613.oHj1g7AUGh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.


THIS INCLUDES ALL THE PATCHES IN 2.6.13.3 SO YOU SHOULD START WITH 2.6.13 T=
O=20
USE THESE PATCHES

Apply to 2.6.13
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck7/patch-2.6.13-ck7.bz2

or server version
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck7/patch-2.6.13-ck7-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:

Added:

 +sp11_sp14.patch
Swap prefetch version 14. Substantial improvements were done to the swap=20
prefetching code. Numerous locking improvements, better testing of when to=
=20
prefetch, and most importantly the pinned swapcache bug which would=20
eventually lead to slowdowns and even out-of-memory kills was found and=20
fixed.=20
It is now tunable with the parameter in=20

/proc/sys/vm/swap_prefetch

to determine how many blocks of 128kb it will prefetch at a time. The defau=
lt=20
is set to 2, setting it to 0 disables prefetching, and you can set a high=20
value (such as 1000) to basically prefetch everything it can in one go whil=
e=20
the vm is idle.
This code is considered safe and I believe stable now.


Changed:

 -patch-2.6.13.2.bz2
 +patch-2.6.13.3.bz2
Latest stable version

 -2613ck6-version.diff
 +2613ck7-version.diff
Version update


=46ull patchlist:
sched-run_normal_with_rt_on_sibling.diff=20
2.6.13_to_staircase12.diff=20
schedrange.diff=20
schedbatch2.9.diff=20
sched-iso3.1.patch=20
sched-iso_tunables.patch=20
smp-nice-support7.diff=20
1g_lowmem1_i386.diff=20
defaultcfq.diff=20
isobatch_ionice2.diff=20
rt_ionice.diff=20
pdflush-tweaks.patch=20
hz-default_values.patch=20
vm-mapped.diff=20
vm-lots_watermark.diff=20
vm-background_scan.diff=20
vm-swap_prefetch-2.patch=20
sched-staircase12_tweak.patch=20
vm-sp2_sp5.patch=20
hz-no250.patch=20
vm-fix_background_scan.patch=20
vm-sp5_sp6.patch=20
vm-sp6_sp7.2.patch=20
ck5_sp11.patch=20
patch-2.6.13.3.bz2=20
sp11_sp14.patch=20
2613ck7-version.diff=20


Cheers,
Con

--nextPart1325613.oHj1g7AUGh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDQ8hOZUg7+tp6mRURAlEUAJ0aWP3MjoLGXbFtn4oWm81A7xGsTgCdHQoa
9tw9vgDcXRC+l9ZoL+/N2Kk=
=t6AA
-----END PGP SIGNATURE-----

--nextPart1325613.oHj1g7AUGh--
