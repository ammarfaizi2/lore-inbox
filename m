Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272395AbTGaGLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 02:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272397AbTGaGLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 02:11:17 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:46291 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272395AbTGaGLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 02:11:15 -0400
Date: Thu, 31 Jul 2003 08:11:13 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030731061113.GL1873@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <20030730221925.GA2858@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F67xnxMyVwCoXwbx"
Content-Disposition: inline
In-Reply-To: <20030730221925.GA2858@werewolf.able.es>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--F67xnxMyVwCoXwbx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-31 00:19:25 +0200, J.A. Magallon <jamagallon@able.es>
wrote in message <20030730221925.GA2858@werewolf.able.es>:
> On 07.30, Jan-Benedict Glaw wrote:
> [...]
> > ...and IFF those new opcodes bring _that_ much performance, then we
> > should think about another Debian distribution for i686-linux. Up to
> > now, I was really proud of having _one_ distribution that's basically
> > capable of running on all and any machines I own...
>=20
> Do as Mandrake (and I suppose another distros), and put optimized librari=
es
> in /lib/i686, /lib/mmx, /lib/sse, /usr/lib/i686, etc. New ld.so supports
> mapping different versions of library depending on arch.

I know. ...and this won't work. Think about this:

	- Some lib links (statically) some parts of libstdc++5.a. This
	  is done on a i386.
	- Some app (compiled for i486 on some other box) links against
	  the above lib (which was copied over).

Now, you've got two ways to access your atomic variables. Do that
multithreaded, and you'll boom.

It's all about "eventually" and "possibly", but you break binary
compatibility at some point.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--F67xnxMyVwCoXwbx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KLMBHb1edYOZ4bsRAlnMAKCAXQ4MyFnEOK5W8QYzfqUAmQJlVwCdGklo
eNe56d4E3Viz7+30/Tt/RSE=
=YdRU
-----END PGP SIGNATURE-----

--F67xnxMyVwCoXwbx--
