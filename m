Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266507AbUAWDiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 22:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUAWDiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 22:38:14 -0500
Received: from resin.csoft.net ([63.111.22.86]:37563 "HELO mail231.csoft.net")
	by vger.kernel.org with SMTP id S266507AbUAWDhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 22:37:54 -0500
Subject: 2.4.24-ck1 updated
From: Eric Hustvedt <lkml@plumlocosoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1/hs8J+yh5hEWIKjiWOS"
Message-Id: <1074829176.32641.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jan 2004 22:39:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1/hs8J+yh5hEWIKjiWOS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The 2.4.24-ck1 patchset has been updated to fix a mis-merge that
affected batch scheduler performance. The patch-2.4.24-ck1.bz2 and
010-ckbase.diff.bz2 files have both been updated to include the fix.

I could have sworn that I triple-checked every line of the patchset, but
one line slipped through. In arch/i386/kernel/entry.S a call to
userspace_resched() was omitted. As a result, SCHED_BATCH tasks
monopolized the CPU and starved other interactive tasks.

The moral of the story is: Don't fall prey to merge-hypnosis. :)

-Eric

--=-1/hs8J+yh5hEWIKjiWOS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAEJdq8O0ZDXGTPEIRAvtDAJwLFHYBiih51LCnG/huXiXC8cKc6gCfX9kI
UXboYhymCS4Bmj2vXapHLSc=
=luAm
-----END PGP SIGNATURE-----

--=-1/hs8J+yh5hEWIKjiWOS--

