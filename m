Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTFHGHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 02:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTFHGHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 02:07:09 -0400
Received: from hob.slb.nwc.acsalaska.net ([209.112.155.42]:36625 "EHLO
	hob.acsalaska.net") by vger.kernel.org with ESMTP id S264540AbTFHGHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 02:07:06 -0400
Date: Sat, 7 Jun 2003 22:20:40 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ext2 file flag inheritance
Message-ID: <20030608062040.GB8983@plato.local.lan>
Mail-Followup-To: Ethan Benson <erbenson@alaska.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Debian GNU
X-gpg-fingerprint: E3E4 D0BC 31BC F7BB C1DD  C3D6 24AC 7B1A 2C44 7AFC
X-gpg-key: http://www.alaska.net/~erbenson/gpg/key.asc
X-ACS-Spam-Status: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

I noticed that when flags (such as append-only) are set on a
directory any new file/dir created in that directory inherits its'
flags.

This is somewhat of a problem with append-only since ext2 only
refrains from doing this on symlinks, not device special files,
therefore if you create a device special node in an append-only
directory the only way to get rid of it is debugfs.

At the very least this should probably be changed to not inherit flags
to non-regular files or directories, but I am also not quite sure the
whole idea really makes sense for all the flags (it makes some sense
for sync, and perhaps noatime, but not so much for append-only).

I am not subscribed to linux-kernel so please CC any replies, thanks.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj7i1bgACgkQJKx7GixEevw9ZACcD56dT74Btyy/leJycC2SJZiN
MzkAmwegmjShcRa9ZmJej3L4lamxyBAd
=kikP
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
