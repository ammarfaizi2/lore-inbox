Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272251AbTG3UdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272247AbTG3UdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:33:23 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:32445 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272241AbTG3UdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:33:20 -0400
Date: Wed, 30 Jul 2003 22:33:18 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030730203318.GH1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FKNvYlRPwIaB7a7A"
Content-Disposition: inline
In-Reply-To: <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FKNvYlRPwIaB7a7A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-07-30 21:01:00 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk>
wrote in message <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk>:
> On Mer, 2003-07-30 at 19:45, Adrian Bunk wrote:
> >   Note that this can also allow Step-A 486's to correctly run multi-thr=
ead
> >   applications since cmpxchg has a wrong opcode on this early CPU.
> >=20
> >   Don't use this to enable multi-threading on an SMP machine, the lock
> >   atomicity can't be guaranted!
>=20
> The bigger problem (and certainly with some of the cmov emulation hacks
> I've seen) is getting the security checking right when you need to
> reprocess the user data - another reason to do it in userspace with a
> preload 8)

Well... For sure, I can write a LD_PRELOAD lib dealing with SIGILL, but
how do I enable it for the whole system. That is, I'd need to give
LD_PRELOAD=3Dxxx at the kernel's boot prompt to have it as en environment
variable for each and every process?

That sounds a tad inelegant to me. Really, I'd prefer to see libstdc++
be compiled for i386 ...

=2E..and IFF those new opcodes bring _that_ much performance, then we
should think about another Debian distribution for i686-linux. Up to
now, I was really proud of having _one_ distribution that's basically
capable of running on all and any machines I own...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--FKNvYlRPwIaB7a7A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KCuOHb1edYOZ4bsRAipXAJ4hl+Ct/xR1dirn5uGTEqoM4V63SACfRoQK
71Zu/FZVTh/PgsEOgkTkTSw=
=9N0n
-----END PGP SIGNATURE-----

--FKNvYlRPwIaB7a7A--
