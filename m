Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262955AbTC1L12>; Fri, 28 Mar 2003 06:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbTC1L12>; Fri, 28 Mar 2003 06:27:28 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:21765 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S262955AbTC1L1Z>;
	Fri, 28 Mar 2003 06:27:25 -0500
Date: Fri, 28 Mar 2003 12:38:40 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix non-TSC ia32 CPUs
Message-ID: <20030328113840.GR11958@lug-owl.de>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKys6zTV8iyMJiwY"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NKys6zTV8iyMJiwY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo!

I'm currently resurrecting some old i386SX16 and Am386 systems. Linux
doesn't boot on thhese boxes because TSC support wasn't switched off as
axpected. This patch fixes it for me. Please apply...

MfG, JBG

--- linux-2.4.21-pre5-clean/arch/i386/config.in	2003-03-25 10:57:12.0000000=
00 +0100
+++ linux-2.4.21-pre5/arch/i386/config.in	2003-03-28 11:59:54.000000000 +01=
00
@@ -55,6 +55,7 @@
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
+   define_bool CONFIG_X86_HAS_TSC n
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -71,6 +72,7 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
+   define_bool CONFIG_X86_HAS_TSC n
 fi
 if [ "$CONFIG_M586" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -78,6 +80,7 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
+   define_bool CONFIG_X86_HAS_TSC n
 fi
 if [ "$CONFIG_M586TSC" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--NKys6zTV8iyMJiwY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+hDRAHb1edYOZ4bsRAvcYAJ49dlGjkKFUybiQgqaGgJ+ZSOZOLQCeOnYd
ZZ7nzsv7B85E24uii77IBdk=
=1pEH
-----END PGP SIGNATURE-----

--NKys6zTV8iyMJiwY--
