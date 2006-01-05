Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932957AbWAECiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932957AbWAECiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 21:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbWAECiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 21:38:06 -0500
Received: from triton.atia.com ([193.16.246.115]:41533 "EHLO triton.atia.com")
	by vger.kernel.org with ESMTP id S932963AbWAEChi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 21:37:38 -0500
To: linux-kernel@vger.kernel.org
Subject: sched.c:659 dec_rt_tasks BUG with patch-2.6.15-rt1
 (realtime-preempt)
References: <87ek3ug314.fsf@arnaudov.name> <87mzie2tzu.fsf@arnaudov.name>
	<20060102214516.GA12850@elte.hu> <87lkxyrzby.fsf_-_@arnaudov.name>
From: Nedko Arnaudov <nedko@arnaudov.name>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAMAAABg3Am1AAAAM1BMVEX///8HBgUeFhGwUjwr
 NDF5RjOgVz2UVTxxTz9pNSXCiW2OUjhNIxi6bE6ROChWammgrK7+pa2IAAAAAXRSTlMAQObYZgAA
 AkxJREFUeAGtlAuTgyAMhK9gIGl4+P9/7W2wVbBo52YOZ2of+djdBPtT/7h+/lhf/wNYXFtLu38Y
 OCss7jEut4zMCTiXGzwiA7CMm78+XQPzemC9q15hun/7sovRAZcCg8QBfPRnF3QPd0jswHW9gUeK
 rwC2nwPTCRyudk9vhXtHXYgT4FxKOEn7zu83R+o3ULefUipKxjTn73LcPyzVbdck0YdAclJxE8C2
 hKHiM5ZKGm1NLFn9IyUNBoQzMZsDjCKxD89sl6dBYwJYCFgi/8TKGfWWYzPmDkfdM40nEgRSWIYE
 NREkQcdMem9SBzAStJJiCaxcpOAy4HDUARWbJyyRAKKwzbBoKQmAzBSqw/7iOJaYC+mTSYtiJs3d
 FFjggTkGKr54r6gPwRoMZboASonB+wJA2/wQ32tysfAU4MWr97kBuLdx4FNy5QKoCfVYprCdEAhE
 tFY7gb5LlcnqMwIgBASaI3S4S1AHoO7ASwH+bCTdFE4AmxP4wcIJMQFPaN01YBI5F7QT9wagq5KO
 FuHd/sS1b8VCUMTeofUV07gH4Cno1iuo2BQY079RqKSK49MWYcyBSOgWEMWk2iCsUV4RQW6BNopN
 wYJYBB7GcAqN2UXLbc3Cssyk9wpiw7NimwPqkemLArVZGBKIhWP8qkCExyaHHBn+Y4iR+rP3mQH1
 zKpMuDjmZ8DHfhDjpCsyYkUsxqsZy3EcxAgsDUCl/TnZYcJLgLVOogPWKkIB/rHzVm9QyGzE+mZ2
 YF1XHAQcPPy51kOhecI06vpCfgFqlF1IG9UTLgAAAABJRU5ErkJggg==
Date: Thu, 05 Jan 2006 04:37:33 +0200
In-Reply-To: <87lkxyrzby.fsf_-_@arnaudov.name> (Nedko Arnaudov's message of
 "Tue, 03 Jan 2006 01:21:05 +0200")
Message-ID: <87u0cj5riq.fsf_-_@arnaudov.name>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


> cdrecord issue is still there however. I got new screenshot (attached)
> for it. In the new one, some stack was dumped before freeze.

I was able to reproduce this by running oss2jack with -d option too.
oss2jack -d option daemonizes it. If I run oss2jack without daemonizing,
everything works and i'm not getting BUG at all.

=2D-=20
Nedko Arnaudov <GnuPG KeyID: DE1716B0>

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDvIZx6bb4v94XFrARAuWHAJ0RLCyA++qt8HUuTHHRsokXzftOyQCgjxyB
gPJboZieag64mP0OYLSlk/c=
=C5lw
-----END PGP SIGNATURE-----
--=-=-=--

