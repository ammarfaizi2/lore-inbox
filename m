Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272368AbTGYW16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 18:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272369AbTGYW16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 18:27:58 -0400
Received: from pc-62-31-11-105-bf.blueyonder.co.uk ([62.31.11.105]:11190 "HELO
	prozac") by vger.kernel.org with SMTP id S272368AbTGYW15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 18:27:57 -0400
Subject: Re: [PATCH] Remove module reference counting.
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davem@redhat.com, arjanv@redhat.com, torvalds@transmeta.com,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030725173900.D7DE12C2A9@lists.samba.org>
References: <20030725173900.D7DE12C2A9@lists.samba.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-azJ76A2Q3pwYmEyLGYtw"
Message-Id: <1059172995.16255.6.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 25 Jul 2003 23:43:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-azJ76A2Q3pwYmEyLGYtw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-24 at 19:00, Rusty Russell wrote:
> 	If module removal is to be a rare and unusual event, it
> doesn't seem so sensible to go to great lengths in the code to handle
> just that case.  In fact, it's easier to leave the module memory in
> place, and not have the concept of parts of the kernel text (and some
> types of kernel data) vanishing.

Wasn't the idea once banded about of a 2-stage unload that went
something like:

1. ->cleanup() - unregister IRQ handlers, timers, etc.
2. Quiesce the system
3. Safe to unload

surely if nothing is registered and all CPUs do a voluntary schedule()
then there can be no chance of calling back in to the module.

LOL. Or am I kidding myself here? :)

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-azJ76A2Q3pwYmEyLGYtw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/IbKDkbV2aYZGvn0RAjMIAJ9bzykEGIBBslYqvuuRCNMIES9f8wCfRatC
ExZaTg2ju35heH5/Hv9FNVI=
=j980
-----END PGP SIGNATURE-----

--=-azJ76A2Q3pwYmEyLGYtw--

