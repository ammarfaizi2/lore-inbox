Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWBLRNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWBLRNz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWBLRNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:13:55 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:17309 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1750811AbWBLRNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:13:55 -0500
From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       debian-powerpc@lists.debian.org
Subject: 2.6.16-rc2 powerpc timestamp skew
Date: Sun, 12 Feb 2006 17:13:50 +0000
Message-ID: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Hi folks,

When running a 2.6.16-rc2 kernel on a powerpc system (Mac Mini;
Freescale 7447A):

$ date && touch f && ls -l f && rm -f f && date
Sun Feb 12 12:20:14 GMT 2006
=2Drw-r--r-- 1 rleigh rleigh 0 2006-02-12 12:23
Sun Feb 12 12:20:14 GMT 2006

Notice the timestamp is 3 minutes in the future compared with the
system time.  "make" is not a very happy bunny running on this kernel
due to every touched file being 3 minutes in the future.

When the same command is run on 2.6.15.3:

$ date && touch f && ls -l f && rm -f f && date
Sun Feb 12 14:27:27 GMT 2006
=2Drw-r--r-- 1 rleigh rleigh 0 2006-02-12 14:27
Sun Feb 12 14:27:27 GMT 2006

In this case the times are identical, as you would expect.

In both these cases, the chrony NTP daemon is running, if that might
be a problem.


Regards,
Roger

=2D-=20
Roger Leigh
                Printing on GNU/Linux?  http://gutenprint.sourceforge.net/
                Debian GNU/Linux        http://www.debian.org/
                GPG Public Key: 0x25BFB848.  Please sign and encrypt your m=
ail.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD72zRVcFcaSW/uEgRAkspAJ4lWUr/5IzrdYQTBmmdQHaF3eU/3ACggVHP
EWZN3nqv8HKlemS3bwToThk=
=eowg
-----END PGP SIGNATURE-----
--=-=-=--
