Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWJLOC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWJLOC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWJLOC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:02:27 -0400
Received: from wavehammer.waldi.eu.org ([82.139.201.20]:13453 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1751414AbWJLOC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:02:26 -0400
Date: Thu, 12 Oct 2006 16:02:24 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: md@linux.it
Subject: 2.6.18 - check for chroot, broken root and cwd values in procfs
Message-ID: <20061012140224.GA7632@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	md@linux.it
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks

The commit 778c1144771f0064b6f51bee865cceb0d996f2f9 replaced the old
root-based security checks in procfs with processed based ones.

This makes the old check for chroot "[ -r /proc/1/root ]" unusable as
readlink on it now always succedds. Also it provides buggy values inside
a chroot, both /proc/1/root and /proc/self/root points to / but in real
they are different.

Is this a desired output or can I call this a bug? If the behaviour is
correct, is there a replacement for this check?

Bastian

--=20
Behind every great man, there is a woman -- urging him on.
		-- Harry Mudd, "I, Mudd", stardate 4513.3

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iEYEARECAAYFAkUuSvAACgkQnw66O/MvCNEzkQCfdh8eLk8VWpycnGZPOAAYBjsg
AVEAnRhvZ0a36nClh62lAvBauG2CQRil
=ihJn
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
