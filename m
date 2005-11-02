Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbVKBMsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbVKBMsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 07:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbVKBMsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 07:48:40 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:26056 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932672AbVKBMsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 07:48:39 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.14-ck2
Date: Wed, 2 Nov 2005 23:48:07 +1100
User-Agent: KMail/1.8.3
Cc: ck@vds.kolivas.org, Wu Fengguang <wfg@mail.ustc.edu.cn>, mpm@selenic.com
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2801608.KQ6clzeF0H";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511022348.09812.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2801608.KQ6clzeF0H
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.14
http://ck.kolivas.org/patches/2.6/2.6.14/2.6.14-ck2/patch-2.6.14-ck2.bz2

or server version
http://ck.kolivas.org/patches/2.6/2.6.14/2.6.14-ck2/patch-2.6.14-cks2.bz2

*note name change for server version

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:
 The server patch has had its name changed to cks* to support patching with=
=20
ketchup which Matt Mackall has kindly enabled for -ck.

Added:
+sched-staircase12.1_12.2.patch
 A small buglet fix for the staircase cpu scheduler (mostly harmless)

+mm-kswapd_inherit_prio.patch
+mm-prio_dependant_scan.patch
+mm-batch_prio.patch
 These are patches designed to change the way the virtual memory subsystem=
=20
behaves according to the 'nice' level of the task that called it. This has=
=20
some weak influence on how much cpu ram allocation takes, and how quickly i=
t=20
will try to allocate that ram, thus providing some support for 'nice' withi=
n=20
the vm. In the presence of an obscene memory load that was niced this showe=
d=20
some improvement in the time taken to compile a minimal kernel config (2:10=
=20
vs 2:55).


Modified:
=2Dadaptive-readahead-4.patch
+adaptive-readahead-6.patch
 Updated to the latest adaptive readahead code (thanks Wu Fengguang) which=
=20
enables the thrash protection by default and has numerous other enhancement=
s.=20
Please cc him if you have any feedback about it.

=2D2614ck1-version.diff
+2614ck2-version.diff
 Version


Cheers,
Con

--nextPart2801608.KQ6clzeF0H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDaLWJZUg7+tp6mRURAo18AJ43s3X2EUtwFjcH59MFm0hjE0lZjgCdFKT4
a1jfgfl1fvACwVWSftyp0Og=
=onjj
-----END PGP SIGNATURE-----

--nextPart2801608.KQ6clzeF0H--
