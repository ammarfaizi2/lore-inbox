Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992507AbWKAOhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992507AbWKAOhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 09:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992510AbWKAOhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 09:37:09 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:11952 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S2992507AbWKAOhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 09:37:07 -0500
Date: Wed, 1 Nov 2006 15:39:33 +0100
From: Luotao Fu <l.fu@pengutronix.de>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [PATCH] trivial patch for comment correction in -rt patches since 2.6.18
Message-ID: <20061101143932.GA25890@localhost.localdomain>
Mail-Followup-To: mingo@elte.hu, linux-kernel@vger.kernel.org,
	Robert Schwebel <r.schwebel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
X-PGP-Key-ID: 0xE5325261
X-URL: http://www.pengutronix.de
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1SQmhf2mF2YjsYvc
Content-Type: multipart/mixed; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
the trivial patch in the following fixes a comment in latency_trace.c
about user triggerring the tracer, which says that the latency tracer is=20
to be triggered on- and off by gettimeofday() from userspace. However it
is done by prctl() since 2.6.18-rt1 now.

Regards
Luotao Fu
--=20
     Dipl.-Ing. Luotao Fu | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usertriggertrace_comment.diff"
Content-Transfer-Encoding: quoted-printable

Correct the comment about userspace function which triggers the latency tra=
cer

Signed-off-by: Luotao Fu <lfu@pengutronix.de>

Index: linux-2.6.18-rt.sec/kernel/latency_trace.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/latency_trace.c
+++ kernel/latency_trace.c
@@ -263,7 +263,7 @@ int trace_all_cpus =3D 0;
 int print_functions =3D 0;
=20
 /*
- * user-triggered via gettimeofday(0,1)/gettimeofday(0,0)
+ * user-triggered via prctl(0,1)/prctl(0,0)
  */
 int trace_user_triggered =3D 0;
 int trace_user_trigger_irq =3D -1;

--9zSXsLTf0vkW971A--

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFSLGkiruQY+UyUmERAj6fAJ9/cIY32E0wRy8PgVEOL5YI0c/SUwCfcbph
sBOgdiKrOXvplqhHeNjStbM=
=3ZWh
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
