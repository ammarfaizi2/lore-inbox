Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263720AbTDTVxO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbTDTVxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:53:14 -0400
Received: from diale081.ppp.lrz-muenchen.de ([129.187.28.81]:22495 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S263720AbTDTVxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:53:13 -0400
Subject: 2.5: daemonize() playing tricks with ttys?
From: Daniel Egger <degger@fhm.edu>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0XmjepjCGN+sml5UaOSJ"
Organization: 
Message-Id: <1050875983.899.2.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Apr 2003 23:59:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0XmjepjCGN+sml5UaOSJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

I'm trying to spawn new threads from a function called from alloc_uid
using daemonize () as soon as a new user appears on the system. Somehow=20
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

--=-0XmjepjCGN+sml5UaOSJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+oxhPchlzsq9KoIYRAmYAAKCxxX2XZ2Vcd1oLB/ZWTH0s/h/rcwCcCsJa
F7ebi5YuROF4/MMGx0LHx/4=
=z6OT
-----END PGP SIGNATURE-----

--=-0XmjepjCGN+sml5UaOSJ--

