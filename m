Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSINSHA>; Sat, 14 Sep 2002 14:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317398AbSINSHA>; Sat, 14 Sep 2002 14:07:00 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:59319 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S317393AbSINSG7>;
	Sat, 14 Sep 2002 14:06:59 -0400
Subject: Re: [PATCH 2.4.20-pre7] net/ipv4/netfilter/ip_conntrack_ftp and
	_irc to export objs
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Jarno Paananen <jpaana@s2.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3vg58qwz1.fsf@kalahari.s2.org>
References: <m3vg58qwz1.fsf@kalahari.s2.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-6ZqiDsqVjabztJiOk1iM"
X-Mailer: Ximian Evolution 1.0.7 
Date: 14 Sep 2002 20:11:45 +0200
Message-Id: <1032027105.29595.129.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6ZqiDsqVjabztJiOk1iM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-09-14 at 19:53, Jarno Paananen wrote:
> Hi,
>=20
> the two modules mentioned export symbols but are not mentioned in
> export-objs in Makefile and thus give errors. Patch attached.
>=20
> // Jarno
>=20
> --- net/ipv4/netfilter/Makefile.bak	2002-09-14 19:50:38.000000000 +0300
> +++ net/ipv4/netfilter/Makefile	2002-09-14 19:51:28.000000000 +0300
> @@ -9,7 +9,7 @@
> =20
>  O_TARGET :=3D netfilter.o
> =20
> -export-objs =3D ip_conntrack_standalone.o ip_fw_compat.o ip_nat_standalo=
ne.o ip_tables.o arp_tables.o
> +export-objs =3D ip_conntrack_standalone.o ip_fw_compat.o ip_nat_standalo=
ne.o ip_tables.o arp_tables.o ip_conntrack_ftp.o ip_conntrack_irc.o
> =20
>  # Multipart objects.
>  list-multi		:=3D ip_conntrack.o iptable_nat.o ipfwadm.o ipchains.o

Did you see this part starting at row 34?

# connection tracking helpers
obj-$(CONFIG_IP_NF_FTP) +=3D ip_conntrack_ftp.o
ifdef CONFIG_IP_NF_NAT_FTP
        export-objs +=3D ip_conntrack_ftp.o
endif

obj-$(CONFIG_IP_NF_IRC) +=3D ip_conntrack_irc.o
ifdef CONFIG_IP_NF_NAT_IRC
        export-objs +=3D ip_conntrack_irc.o
endif

but maybe the ifdefs shouldn't use the NAT define...
I don't think I've compiled without NAT support...
=20
--=20
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.

--=-6ZqiDsqVjabztJiOk1iM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9g3vhWm2vlfa207ERAlcDAKCGeIOOqoaSl5YE6OE/J6KbfkLZvgCdFOtr
X4gqrzTEWUBjSMiANkfSbp0=
=+9lx
-----END PGP SIGNATURE-----

--=-6ZqiDsqVjabztJiOk1iM--
