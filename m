Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbUASVqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbUASVqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:46:44 -0500
Received: from ns2.masteringczech.com ([216.254.21.213]:21385 "EHLO
	mail.cubesearch.com") by vger.kernel.org with ESMTP id S264446AbUASVqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:46:36 -0500
Date: Mon, 19 Jan 2004 04:51:13 -0500
From: Peter Johanson <latexer@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: x86-kernel@gentoo.org, spyderous@gentoo.org, strider@gentoo.org
Subject: [RFC] standard KBUILD_OUTPUT filesystem location?
Message-ID: <20040119095111.GA25503@gonzo.stern.nyu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(please CC me on any replies, as i'm not subscribed)

Q: If one were to have to pick a "standard" place to assign
KBUILD_OUTPUT in the top level Makefile, where would it be?

In particular, Gentoo has been having problems with compiling external
modules against 2.6 kernels, as most of the time this results in
attempting to write to the source tree, and our sandbox system
preventing this and dying.

After smashing my head against the wall for about a month, I've been
working on a experimental system to *always* set KBUILD_OUTPUT, so
there's always a clean source tree to compile against using the
recommended "make -C /usr/src/linux/ SUBDIRS=3D/foo O=3Dsome/tmp/dir"
(setting O=3D without a clean kernel source tree just causes kbuild to
yell at you to run "make mrproper")

The details of this discussion can be found on our bugzilla here:
http://bugs.gentoo.org/show_bug.cgi?id=3D32737

So, where would you put the "default kernel output"?

The general concensus so far has been /var/tmp/kernel-output/${KV} (KV
is the kernel version, e.g. 2.6.1-mm4)

Comments? feedback? "what a horrible idea"s ?

-pete

--=20
Peter Johanson
<latexer@gentoo.org>

Key ID =3D 0x6EFA3917
Key fingerprint =3D A90A 2518 57B1 9D20 9B71  A2FF 8649 439B 6EFA 3917

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAC6iPhklDm276ORcRAjFlAKCSHrGBPXIlrJ1scAfpQUc2uYE5OgCfahPK
wHKsomT2VCwoiUf/fJgE7hQ=
=eXeV
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
