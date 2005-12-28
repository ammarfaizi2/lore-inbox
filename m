Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVL1WOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVL1WOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 17:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVL1WOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 17:14:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56466 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964917AbVL1WOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 17:14:45 -0500
Message-ID: <43B30E19.6080207@redhat.com>
Date: Wed, 28 Dec 2005 14:13:45 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: mpm@selenic.com, akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-tiny@selenic.com
Subject: Re: Fwd: [PATCH] Make sysenter support optional
References: <20051228212402.GX3356@waste.org> <a36005b50512281407x74415958tb0fa2b52f4dd7988@mail.gmail.com>
In-Reply-To: <a36005b50512281407x74415958tb0fa2b52f4dd7988@mail.gmail.com>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDF0E749CB13F96DD47197CD1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF0E749CB13F96DD47197CD1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> This adds configurable sysenter support on x86. This saves about 5k on
> small systems.

You not only remove the sysenter support but also the vdso.  And the
later is a very bad idea.  It is already today basically impossible to
have reliable backtraces without the vdso and the unwind info it
contains for signal handlers.  And things can only get worse in future.
 The magic heuristics in the compiler are not reliable.  It's simply the
wrong face, this in a interface between the kernel and the libc, the
compiler should not have such knowledge.

The vdso should be mandatory for all configurations.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigDF0E749CB13F96DD47197CD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDsw4Z2ijCOnn/RHQRAmCbAKC+NTcVW1s6Z8QQExQ2EkHc1KGHzgCdHsZj
t/QjzlbmYa96H91HzQCEp2c=
=oftl
-----END PGP SIGNATURE-----

--------------enigDF0E749CB13F96DD47197CD1--
