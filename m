Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264236AbUFTIte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbUFTIte (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 04:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUFTIte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 04:49:34 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:30092 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264236AbUFTItb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 04:49:31 -0400
Date: Sun, 20 Jun 2004 10:49:29 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       dwmw2@infradead.org, arjanv@redhat.com,
       Linus Torvalds <torvalds@osdl.org>, matthew-lkml@newtoncomputing.co.uk
Subject: Re: [PATCH] Stop printk printing non-printable chars
Message-ID: <20040620084929.GG20632@lug-owl.de>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	dwmw2@infradead.org, arjanv@redhat.com,
	Linus Torvalds <torvalds@osdl.org>,
	matthew-lkml@newtoncomputing.co.uk
References: <1087704177.8185.951.camel@cube>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNit++U8fcW0+xt6"
Content-Disposition: inline
In-Reply-To: <1087704177.8185.951.camel@cube>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNit++U8fcW0+xt6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-20 00:02:58 -0400, Albert Cahalan <albert@users.sf.net>
wrote in message <1087704177.8185.951.camel@cube>:
> > Get real: either you *want* to get those codes
> > interpreted (think about full-blown ncurses apps
> > being run over serial link), or you *don't* (think
> > about simply recording serial console's output).
> > You just have to choose the correct application
> > for your task.
>=20
> If there are full-blown ncurses apps being routed
> through printk -- that is, the KERNEL log -- then
> we have far bigger issues.

You're right, I mixed up the ways for console output and for userspace
apps using a shell over the very same serial line (what I commonly do).

> The 0x9b character must be blocked, at least when
> a serial console is in use. (apps on such a console
> may of course use 0x9b as desired -- just not printk)

I still don't see a need to filter out *anything*. To be exact, I've
seen other places where a \r is added when a \n occures. Not always a
great idea, too...  Just keep it as it is, I think it's fine...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--PNit++U8fcW0+xt6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1U+ZHb1edYOZ4bsRAjqSAJ0Vm81qGuuHOz/xORGeUyam+tJNRwCbBX5N
3EZFF0FSbDerL6eYrHDnpAQ=
=XBU/
-----END PGP SIGNATURE-----

--PNit++U8fcW0+xt6--
