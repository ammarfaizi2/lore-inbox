Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266528AbUF0AmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266528AbUF0AmO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 20:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266307AbUF0AmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 20:42:14 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:58060 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S266528AbUF0AmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 20:42:04 -0400
Subject: [help] Netdev watchdog code?
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tloQjPdvfSwyLVJUYEGG"
Message-Id: <1088296922.23713.45.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 27 Jun 2004 02:42:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tloQjPdvfSwyLVJUYEGG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

Do i understand this right?

Netdev watchdog can only be called when netif_stop_queue(...) has been
called. From what i gather in b44.c it's only called when the send queue
is full, yet it can trigger on a common dhcp request.
(where netif_queue_stopped(...) should return false, and thus the
watchdog shouldn't run at all)

As it is now, i can't understand how i can get watchdog timeouts since
the queue would have to be filled. On a 100mbit fdup link it shouldn't
delay that long not even if you use UDP packets (like nfs, I've even
seen it trigger with ftp now).

Anyways, Doing bio-timing based on the text output, it should work.
And, the current vanila kernel.org kernel doesn't work for me, as i have
stated numerous times and received no feedback.

PS, CC, not in list.
DS.
--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-tloQjPdvfSwyLVJUYEGG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3hfZ7F3Euyc51N8RAvqsAJ9eLIzHA/756UySS+ca9mrOPCdYUQCfQm79
wibUK75mTHiNAx5NNW3KzOw=
=9DKZ
-----END PGP SIGNATURE-----

--=-tloQjPdvfSwyLVJUYEGG--

