Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVCBNbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVCBNbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 08:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVCBNbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 08:31:01 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:1446 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262289AbVCBNag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 08:30:36 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: 2.6.11-ck1
Date: Thu, 3 Mar 2005 00:30:26 +1100
User-Agent: KMail/1.8
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1420173.JvkZrMepSg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503030030.29722.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1420173.JvkZrMepSg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness. It is=20
configurable to any workload but the default ck* patch is aimed at the=20
desktop and ck*-server is available with more emphasis on serverspace.

http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck1/patch-2.6.11-ck1.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches and a server specific patch available.


Added since 2.6.10-ck7:
+cfq-ts-21.diff
The latest version of Jens' cfq-timeslice i/o scheduler now heavily tested =
and=20
with full read i/o priority support

+isobatch_ionice2.diff
Support for i/o priorities suitable for SCHED_ISO and SCHED_BATCH tasks

+rt_ionice.diff
Support for i/o priority suitable for real time tasks


Changed:
+schediso2.11.diff
The development of the 3.x series of Isochronous scheduling support did not=
=20
reach full maturity and its features were no longer deemed desirable. This=
=20
has a minor bugfix for the 2.10 version included previously instead.

+mapped_watermark3.diff
=46inally I have tweaked the mapped watermark patch which makes for memory=
=20
scanning to be progressively more aggressive the more stress/fragmentation =
it=20
is under, to swap far less under all sorts of load (especially i/o load), y=
et=20
not risk out-of-memory kills.=20


Rolled up:
~2.6.10_to_staircase9.2.diff
~schedbatch2.6.diff
~schediso2.8.diff
~mwII.diff
~s9.2_s9.3.diff
~2.8_i2.9.diff
~9.3_s9.4.diff
~i2.9_i2.10.diff
~b2.6_b2.7.diff
~s9.4_s10.diff
~s10_test1.diff
~s10_s10.1.diff
~s10.1_s10.2.diff
~s10.2_s10.3.diff
~s10.3_s10.4.diff
~s10.4_s10.5.diff
All merged into their newer versions


Removed:
=2Dpatch-2.6.10-as6
=2D2.6.10-mingoll.diff
=2Dvm-pageout-throttling.patch
=2Dfix-ll-resume.diff
=2D1504_vmscan-writeback-pages.patch
=2D2610ck7-version.diff
All not required as included in 2.6.11 or deprecated


=46ull patchlist:
 2.6.11_to_staircase10.5.diff
Latest version of the staircase O(1) single priority array=20
foreground-background cpu scheduler

 schedrange.diff
Eases addition of scheduling policies

 schedbatch2.7.diff
Idle cpu scheduling

 schediso2.11.diff
Unprivileged low latency cpu scheduling

 mapped_watermark3.diff
Lighter memory scanning under light loads and far less swapping

 1g_lowmem1_i386.diff
Support 1GB of memory without enabling HIGHMEM

 cddvd-cmdfilter-drop.patch
Support normal user burning of cds

 nvidia_6111-6629_compat2.diff
Make nvidia compile support easier. Note to build the actual module you nee=
d=20
to manually extract the NVIDIA_kernel file and patch (-p0) one of the =20
relevant compatibility patches from here:
http://ck.kolivas.org/patches/2.6/2.6.11/NVIDIA_kernel-1.0-6111-1132076.diff
http://ck.kolivas.org/patches/2.6/2.6.11/NVIDIA_kernel-1.0-6629-1201042.diff

 cfq-ts-21.diff
Complete fair queueing timeslice i/o scheduler v21

 defaultcfq.diff
Enable the cfq I/O scheduler by default

 isobatch_ionice2.diff
Support for i/o priorities suitable for SCHED_ISO and SCHED_BATCH tasks

 rt_ionice.diff
Support for i/o priority suitable for real time tasks

 2611ck1-version.diff
version

and available separately in the patches/ dir as an addon:
 supermount-ng208-2611.diff
Simplest way to automount removable media


And don't forget to pour one of these before booting this kernel:
http://ck.kolivas.org/patches/2.6/2.6.11/cognac.JPG


Cheers,
Con

--nextPart1420173.JvkZrMepSg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCJb/1ZUg7+tp6mRURAoPoAJwIYhdLGLNzzo/ZcZ05c0upySOyegCfTgWL
81ghFQEjp1kMCD1z8HeaV9w=
=s9Y0
-----END PGP SIGNATURE-----

--nextPart1420173.JvkZrMepSg--
