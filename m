Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWD0MkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWD0MkF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWD0MkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:40:04 -0400
Received: from lug-owl.de ([195.71.106.12]:26064 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S965118AbWD0MkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:40:02 -0400
Date: Thu, 27 Apr 2006 14:40:01 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Or Gerlitz <ogerlitz@voltaire.com>
Cc: rdreier@cisco.com, openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] iSER's Makefile and Kconfig
Message-ID: <20060427124001.GZ25520@lug-owl.de>
Mail-Followup-To: Or Gerlitz <ogerlitz@voltaire.com>,
	rdreier@cisco.com, openib-general@openib.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0604271528140.16463-100000@zuben> <Pine.LNX.4.44.0604271530141.16463-100000@zuben>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5FFaGRZUwcpbKFrw"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0604271530141.16463-100000@zuben>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5FFaGRZUwcpbKFrw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-04-27 15:30:32 +0300, Or Gerlitz <ogerlitz@voltaire.com> wrote:
> Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>
>=20
> --- /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser-x/Makefile	1970=
-01-01 02:00:00.000000000 +0200
> +++ /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser/Makefile	2006-0=
4-27 15:12:33.000000000 +0300
> @@ -0,0 +1,6 @@
> +obj-$(CONFIG_INFINIBAND_ISER)	+=3D ib_iser.o
> +
> +ib_iser-y			:=3D iser_verbs.o \
> +				   iser_initiator.o \
> +				   iser_memory.o \
> +				   iscsi_iser.o=20
> --- /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser-x/Kconfig	1970-=
01-01 02:00:00.000000000 +0200
> +++ /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser/Kconfig	2006-04=
-16 11:04:42.000000000 +0300
> @@ -0,0 +1,12 @@
> +config INFINIBAND_ISER
> +	tristate "ISCSI RDMA Protocol"
> +	depends on INFINIBAND && SCSI
> +	select SCSI_ISCSI_ATTRS
> +	---help---
> +
> +	  Support for the ISCSI RDMA Protocol over InfiniBand.  This
> +	  allows you to access storage devices that speak ISER/ISCSI
> +	  over InfiniBand.
> +
> +	  The ISER protocol is defined by IETF.
> +	  See <http://www.ietf.org/>.

Please always send patches in an order so that the kernel still is
compilable.

Eg. with your first patch introducing the Makefile stuff (while the C
files are still not there), this will break and thus make it harder to
automatically trace down unrelated breakages.

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

--5FFaGRZUwcpbKFrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEULuhHb1edYOZ4bsRAovMAJ4737FpNbFY2UHhh526oYC5Q8F5+gCffSE8
9fKsBFehi03FMMK2CCOJMbY=
=zpj1
-----END PGP SIGNATURE-----

--5FFaGRZUwcpbKFrw--
