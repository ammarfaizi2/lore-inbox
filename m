Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVCIKjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVCIKjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVCIKgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:36:49 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:59575 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262293AbVCIKc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:32:59 -0500
From: Con Kolivas <kernel@kolivas.org>
Date: Wed, 9 Mar 2005 21:32:52 +1100
User-Agent: KMail/1.8
MIME-Version: 1.0
X-Length: 3601
To: ck@vds.kolivas.org
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.11-ck2
Content-Type: multipart/signed;
  boundary="nextPart1306310.dNeOkGRTxC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503092132.55164.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1306310.dNeOkGRTxC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness. It is=20
configurable to any workload but the default ck* patch is aimed at the=20
desktop and ck*-server is available with more emphasis on serverspace.

http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck2/patch-2.6.11-ck2.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches and a server specific patch available.


Note:
Please do not set the mapped value any higher than the default (66) with a=
=20
hardmaplimit on. This will bring an out of memory condition easily. Try the=
=20
default setting and you'll find it avoids swap much more aggressively than=
=20
higher mapped settings did on previous versions.


Added since 2.6.11-ck1:
+s10.5_s10.6.diff
Staircase scheduler update. Somehow the merge from 2.6.10-staircase10.5 to=
=20
2.6.11 included an experimental change that was never meant to be part of=20
staircase10.5. This patch removes that change so brings it back to the 10.5=
=20
design. Some slowdown was experienced over time on slower hardware and this=
=20
patch fixes it. To avoid confusion the version number has been updated.=20
Thanks to Martin Josefsson for tracking this down!

+cfq-ts21-fix.diff
Jens had some fixes to the latest cfq-ts code that hadn't yet made it to my=
=20
tree. This brings it in line with his current stable tree.

+patch-2.6.11.1
+patch-2.6.11.2
The obvious and security fixes tree.

+2611ck2-version.diff
Version


Removed:
=2D2611ck1-version.diff


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

 s10.5_s10.6.diff
Staircase scheduler update.

 cfq-ts21-fix.diff
Jens had some fixes to the latest cfq-ts code that hadn't yet made it to my=
=20
tree. This brings it in line with his current stable tree.

 patch-2.6.11.1
 patch-2.6.11.2
The obvious and security fixes tree.

 2611ck2-version.diff
Version

and available separately in the patches/ dir as an addon:
 supermount-ng208-2611.diff
Simplest way to automount removable media


And don't forget to pour one of these before booting this kernel:
http://ck.kolivas.org/patches/2.6/2.6.11/cognac.JPG


Cheers,
Con

--nextPart1306310.dNeOkGRTxC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCLtDXZUg7+tp6mRURAjl0AJ9wl2aU5+xaZvKKoPmf0vHEY7dtAgCeNCKO
VodF8Jxcu4Tgk3faOBmnpw4=
=votW
-----END PGP SIGNATURE-----

--nextPart1306310.dNeOkGRTxC--
