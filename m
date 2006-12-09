Return-Path: <linux-kernel-owner+w=401wt.eu-S1759001AbWLIFOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759001AbWLIFOf (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 00:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758983AbWLIFOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 00:14:35 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:34170 "EHLO
	mail03.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759001AbWLIFOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 00:14:34 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.19-ck2
Date: Sat, 9 Dec 2006 15:14:27 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Message-Id: <200612091614.30096.kernel@kolivas.org>
X-Length: 2613
Content-Type: multipart/signed;
  boundary="nextPart2771873.fScqGZpmx0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2771873.fScqGZpmx0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patchset is designed to improve system responsiveness and interactivit=
y.=20
It is configurable to any workload but the default -ck patch is aimed at th=
e=20
desktop and -cks is available with more emphasis on serverspace.

Apply to 2.6.19
http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/2.6.19/2.6.19-=
ck2/patch-2.6.19-ck2.bz2

or server version
http://www.kernel.org/pub/linux/kernel/people/ck/patches/cks/patch-2.6.19-c=
ks2.bz2

web:
http://kernel.kolivas.org

all patches:
http://www.kernel.org/pub/linux/kernel/people/ck/patches/


Changes (first significant changes since :
Added:
+sched-fix_iso_starvation.patch
A bug first introduced into 2.6.18-ck1/cks1 meant that SCHED_ISO tasks were=
=20
not being throttled when above their cpu limit. This presents a security ri=
sk=20
to any machine with user logins and upgrading for this issue should be=20
considered a high priority.

 +sched-make_softirqd_batch.patch
Instead of 'nice'ing ksoftirqd we can use the policy hint of SCHED_BATCH wh=
ich
specifies it as not requiring low latency. This increases the cpu use possi=
ble
under very heavy softirq traffic (such as network loads) and decreases the
latency that might otherwise be seen (such as keyboard input under heavy cpu
load on slow machines).

Split patches available.

=46ull patchlist:

sched-staircase-16.2.patch
sched-staircase16_interactive_tunable.patch
sched-staircase16_compute_tunable.patch
sched-range.patch
sched-iso-4.6.patch
sched-fix_iso_starvation.patch
track_mutexes-1.patch
sched-idleprio-1.11.patch
sched-limit_policy_changes.patch
sched-make_softirqd_batch.patch
cfq-ioprio_inherit_rt_class.patch
cfq-iso_idleprio_ionice.patch
hz-default_1000.patch
hz-no_default_250.patch
sched-add-above-background-load-function.patch
mm-swap_prefetch-33.patch
mm-convert_swappiness_to_mapped.patch
mm-lots_watermark.diff
mm-kswapd_inherit_prio-1.patch
mm-prio_dependant_scan-2.patch
mm-background_scan-2.patch
mm-idleprio_prio.patch
mm-decrease_minimum_dirty_ratio.patch
mm-set_zero_dirty_ratio.patch
mm-filesize_dependant_lru_cache_add.patch
kconfig-expose_vmsplit_option.patch
ck2-version.patch


=E6=A5=BD=E3=81=97=E3=81=BF=E3=81=AA=E3=81=95=E3=81=84

=2D-=20
=2Dck
=2D-=20
=2Dck

--nextPart2771873.fScqGZpmx0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFekY2ZUg7+tp6mRURAioFAJ9CGYWzz3da0ZkbVfrLVS5nAHONUgCfYQ5H
GqLGMSBi4cK4D3CBACJHadE=
=yZBe
-----END PGP SIGNATURE-----

--nextPart2771873.fScqGZpmx0--
