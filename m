Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272751AbRIGQIn>; Fri, 7 Sep 2001 12:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272752AbRIGQIc>; Fri, 7 Sep 2001 12:08:32 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:34688 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S272751AbRIGQIS>; Fri, 7 Sep 2001 12:08:18 -0400
Date: Fri, 7 Sep 2001 11:08:36 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: "Cached" grows and grows and grows...
Message-ID: <20010907110836.B1013@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is probably closely related to the vm work going on...and you're
probably aware of it, but...

The "Cached" field in /proc/meminfo grows and grows and grows.  (kernel
2.4.7, 2.4.9, 2.4.10pre4aa1)  The kernel seems to be favoring buffer
cache for the filesystem over programs.  I recently purchased 256MB more
memory for my machine, only to find that Linux is using 200-300MB to
cache the filesystem.  Over time it swaps out everything to disk, and
"Cached" grows as large as 415MB on a 512MB machine.  Every time I come
back to my machine after not using the console for a while, it has to
swap everything back into memory in order to be usable.  (Note this
machine is basically unloaded except for setiathome while I'm away)

Let me place my vote that the vm subsystem should place pages with
program code, and their data at a higher priority to be in-memory than
filesystem cache buffers.  (Is the problem that the filesystem cache
buffers never expire, and stay in memory forever?)

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuY8QQACgkQjwioWRGe9K1rEACeK6AO5+YRTLaCJxMXxtLmJaDx
JE0AoM+OZ1QQVmyfbEGPiWSQ0Vg60vd+
=j0TG
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
