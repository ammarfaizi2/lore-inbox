Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSG3Olm>; Tue, 30 Jul 2002 10:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318311AbSG3Oll>; Tue, 30 Jul 2002 10:41:41 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:10384 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S318310AbSG3Olk>;
	Tue, 30 Jul 2002 10:41:40 -0400
Date: Tue, 30 Jul 2002 16:48:53 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: questions about network device drivers
Message-ID: <20020730164853.A24348@crystal.2d3d.co.za>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20020730161505.A23281@crystal.2d3d.co.za> <1028044126.6726.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1028044126.6726.35.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Jul 30, 2002 at 16:48:46 +0100
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 4:39pm  up 1 day, 12:37,  9 users,  load average: 0.07, 0.08, 0.03
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan!

> > hard_start_xmit() method
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > when should this function return 0 and when should it return 1 and in w=
hich
> > cases should it do netif_stop_queue() and/or free the dev_kfree_skb() ?
>=20
> 0 - OK
> 1 - I am busy, give me it later.
>=20
> If you return 1 be sure to netif_stop_queue. The netif_wake_queue will
> continue transmission

In both cases, should I free the sk_buff structure or only if I return 0?
Also, if I understand you correctly, I should _only_ call netif_stop_queue()
if the function fails to transmit the packet?

What about cases where the packet will always fail, e.g. the frame length is
bigger than what the device supports. I take it in those cases I should
return 0, but should I call netif_stop_queue() as well?

--=20

Regards
 Abraham

Here there be tygers.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9RqdVzNXhP0RCUqMRAmY/AJwN/ucKgpSjM0KAyiDTvravXS6mHgCginBw
WzXVSwpiQhGcAib8akpy/ok=
=HbwZ
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
