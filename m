Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVAESkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVAESkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVAESkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:40:11 -0500
Received: from 213-0-210-61.dialup.nuria.telefonica-data.net ([213.0.210.61]:7560
	"EHLO dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S262549AbVAESjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:39:52 -0500
Date: Wed, 5 Jan 2005 19:39:48 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.10-rc3-bk15 hanged under high load (i386)
Message-ID: <20050105183947.GA5601@localhost>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all:

I have been experiencing kernel crashes for the last couple of weeks, and
now it has happened again, but this time I have some info, hope it helps.

* Problem: box freezes (no panic or other kind of messages in the logs),
  under high load (loadavg up to 10, several "spamassassin" processes=20
  doing their job).

* Description: the box just hangs, nothing gets printed in the logs (at the
  time of the crash), SysRq+T, SysRq+M don't dump anything to disk (can't
  verify if they get to the local console, because X was running when the
  box hangs). However, some time (in the order of seconds, maybe a minute
  or so) before the box freezes, I get the following in the logs:

  Jan  5 19:09:52 dardhal kernel: swap_dup: Bad swap file entry 10000000
  Jan  5 19:09:52 dardhal kernel: swap_free: Bad swap file entry 10000000
  Jan  5 19:09:52 dardhal kernel: swap_free: Bad swap file entry 10000000
  Jan  5 19:10:08 dardhal kernel: VM: killing process spamassassin
  Jan  5 19:10:08 dardhal kernel: swap_free: Bad swap offset entry 00730000
 =20
  (I noticed my incoming email was not being tagged as spam by
  "spamassasin" any more, at least some of it ("spamassassin" configured
  to have several copies running in parallel).

* When I noticed the box didn't respond, I tried several SysRq (T, M), and
  then tried an emergency reboot via SysRq+S, SysRq+U, SysRq+B. It worked
  as expected (root file system seemed to be synced to disk, unmounted,
  and the box rebooted), at least upon reboot the root filesystem was
  clean, as it should be.


I have searched for old kernel logs, to check if some other hang in the
past happened just after a message similar to the ones above. And in fact,
this is the case, but I am not sure if the following was the last time the
box crashed until today. What I know for sure is the following message
(and the crashed it happened just after it) was also with kernel version
2.6.10-rc3-bk15, as happened today.
 =20
  Dec 29 20:41:38 dardhal kernel: swap_free: Bad swap offset entry 003f0000


Could it be just a defective sector under my swap partition?. Any help
greatly appreciated, please ask for more information if needed.

Greetings,

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.10-rc3-bk15)


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB3DRzao1/w/yPYI0RArnCAKCJ4Ov/FyXEHbBBX55GmcA+1LygdwCfdU6z
e9WQxVbs3LYcg+OSRbOuNtw=
=nixO
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
