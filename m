Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbUKDOiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUKDOiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbUKDOgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:36:13 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:112 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262245AbUKDOeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:34:21 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-user] [PATCH] extend the limits for command line
Date: Thu, 4 Nov 2004 15:34:19 +0100
User-Agent: KMail/1.7.1
Cc: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>, jdike@karaya.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-user@lists.sourceforge.net
References: <Pine.LNX.4.61.0411040859130.18123@webhosting.rdsbv.ro>
In-Reply-To: <Pine.LNX.4.61.0411040859130.18123@webhosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4512772.CgWUMq10Im";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411041534.31568.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4512772.CgWUMq10Im
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 November 2004 08:08, Catalin(ux aka Dino) BOIE wrote:
> Hello!
>
> (I resend this because I get no feedback.)
Sorry, miss of time.

> Testing UML on my project, I hit the limit for command line with something
> like this:

> default \
>          mem=3D64M \
>          ubda=3DCOW,/data/UML4/roots/ROOT1 \
>          ubdb=3DSWAP \
>          ubdc=3DCONF.tar \
>          ${HSSTR} \
>          eth0=3Ddaemon,fe:fd:39:bd:cc:d7,,/data/UML4/conf/example1/socks/=
SW1
> eth1=3Ddaemon,fe:fd:01:01:01:12,,/data/UML4/conf/example1/socks/SW2
> eth2=3Ddaemon,fe:fd:01:01:01:99,,/data/UML4/conf/example1/socks/SW4
> eth3=3Ddaemon,fe:fd:01:01:01:03,,/data/UML4/conf/example1/socks/SW5
> eth4=3Ddaemon,fe:fd:01:01:01:04,,/data/UML4/conf/example1/socks/SW6
> eth5=3Ddaemon,fe:fd:01:01:01:81,,/data/UML4/conf/example1/socks/SW8p1
> eth6=3Ddaemon,fe:fd:3f:a9:35:e2,,/data/UML4/conf/EXTERN/E1  \
>          con=3Dnull \
>          ssl0=3Dport:9101 \
>          umid=3Dexample1-pc1 \
>          @pc1@

> Patch to extend the limits (buffer and number of args/envs) is attached.
> Please consider including it because UML is intended to be run with such
> long lines.
> I'm open to other alternatives as a Kconfig entry for this.

> Thank you!

> Signed-off-by: Catalin(ux aka Dino) BOIE <catab at umbrella dot ro>

The idea of the patch is correct.

The UML part should be mergeable immediately - however, I don't know if tha=
t=20
could be a security risk or has any bug (any place still using the old size=
).

Also, I'd like to understand what arch/um/kernel/user_util.c wants to do ne=
ar=20
its beginning!

=46or the arch-independent code, there needs to be something like a Kconfig=
=20
entry (not necessarily a user-question, see CONFIG_GENERIC_RWSEM for=20
instance).

Also, I'd like to cross-check this patch with the one used by Knoppix for a=
ges=20
to do the same thing.

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart4512772.CgWUMq10Im
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBij33qH9OHC+5NscRAiphAJwMv49+bPMkoXfXGbAyGdujY6IpwQCcDPq2
rDoXRZrDnaF4CTEfLV1rA+E=
=PAIm
-----END PGP SIGNATURE-----

--nextPart4512772.CgWUMq10Im--
