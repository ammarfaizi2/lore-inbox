Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTDQRUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTDQRUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:20:45 -0400
Received: from B5390.pppool.de ([213.7.83.144]:10731 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S261824AbTDQRUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:20:44 -0400
Subject: daemonizing tasks detach controlling tty?
From: Daniel Egger <degger@fhm.edu>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Jp065wr+/8IOmsoJ98CV"
Organization: 
Message-Id: <1050600635.7843.17.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Apr 2003 19:30:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jp065wr+/8IOmsoJ98CV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

I'm trying to spawn new threads from a function called from alloc_uid
using daemonize as soon as a new user appears on the system. Somehow=20
this detaches the original shell from the tty causing an exit not
only of the child but also it's parent.

A diagram of the situation would lock like this:

getty -> (login of root) bash -> (su to another user) bash ->
[new thread is spawned] (whatever) -> exit -> getty

Alternativly, when directly logging in a non-root user:
getty -> (login of foo) motd -> [hang]

How can I daemonize something without disturbing other processes?
I already tried playing with reparent_to_init and some signal stuff
as done by other parts of the kernel but to no avail.

--=20
Servus,
       Daniel

--=-Jp065wr+/8IOmsoJ98CV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+nuS7chlzsq9KoIYRAlDBAJ45/yxGtg3F9jme/NpxoixUAtsofACgrzNO
ffODU8MLZabKxFeogG+exbc=
=zhnI
-----END PGP SIGNATURE-----

--=-Jp065wr+/8IOmsoJ98CV--

