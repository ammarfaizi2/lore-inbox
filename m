Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbVJ1WGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbVJ1WGD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbVJ1WGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:06:02 -0400
Received: from lug-owl.de ([195.71.106.12]:2776 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751865AbVJ1WGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:06:01 -0400
Date: Sat, 29 Oct 2005 00:05:57 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Lever, Charles" <Charles.Lever@netapp.com>
Cc: "Myklebust, Trond" <Trond.Myklebust@netapp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Link error in ./net/sunrcp/
Message-ID: <20051028220557.GR27184@lug-owl.de>
Mail-Followup-To: "Lever, Charles" <Charles.Lever@netapp.com>,
	"Myklebust, Trond" <Trond.Myklebust@netapp.com>,
	linux-kernel@vger.kernel.org
References: <044B81DE141D7443BCE91E8F44B3C1E288E5B7@exsvl02.hq.netapp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xr6Gr0irOxp3+3c"
Content-Disposition: inline
In-Reply-To: <044B81DE141D7443BCE91E8F44B3C1E288E5B7@exsvl02.hq.netapp.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5xr6Gr0irOxp3+3c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-10-28 14:26:11 -0700, Lever, Charles <Charles.Lever@netapp.com=
> wrote:
> > I get this link error:
> >=20
> > net/built-in.o: In function=20
> > `xs_bindresvport':xprtsock.c:(.text+0x46970): undefined=20
> > reference to `xprt_min_resvport'
> > :xprtsock.c:(.text+0x46978): undefined reference to=20
> > `xprt_max_resvport'
> > net/built-in.o: In function `xs_setup_udp': undefined=20
> > reference to `xprt_udp_slot_table_entries'
> > net/built-in.o: In function `xs_setup_tcp': undefined=20
> > reference to `xprt_tcp_slot_table_entries'
> > make: *** [.tmp_vmlinux1] Error 1
> >=20
> > in case of CONFIG_SYSCTL not being enabled. This is on the VAX port,
> > but I guess it'll show up on any target...
>=20
> i thought that you couldn't actually get a .config that would build
> the sunrpc stuff if CONFIG_SYSCTL was disabled.  thus the macro logic
> in net/sunrpc doesn't check for it.
>=20
> was i wrong about that?

I just configured for i386, NFS support compiled in, but "Sysctl
support" (in "General setup") being switched off:

  LD      .tmp_vmlinux1
net/built-in.o: In function `xs_bindresvport':
: undefined reference to `xprt_max_resvport'
net/built-in.o: In function `xs_bindresvport':
: undefined reference to `xprt_min_resvport'
net/built-in.o: In function `xs_setup_udp':
: undefined reference to `xprt_udp_slot_table_entries'
net/built-in.o: In function `xs_setup_udp':
: undefined reference to `xprt_max_resvport'
net/built-in.o: In function `xs_setup_tcp':
: undefined reference to `xprt_tcp_slot_table_entries'
net/built-in.o: In function `xs_setup_tcp':
: undefined reference to `xprt_max_resvport'
net/built-in.o:(__ksymtab+0xfb0): undefined reference to `xprt_udp_slot_tab=
le_entries'
net/built-in.o:(__ksymtab+0xfb8): undefined reference to `xprt_tcp_slot_tab=
le_entries'
make: *** [.tmp_vmlinux1] Error 1

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--5xr6Gr0irOxp3+3c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDYqDFHb1edYOZ4bsRAhDRAKCMU6aIhSYFvFFV0ALxWlZvtuMJEQCeKt2l
UlyS2nSplkeF9AwDFo2P0XY=
=pIiS
-----END PGP SIGNATURE-----

--5xr6Gr0irOxp3+3c--
