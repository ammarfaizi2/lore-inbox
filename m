Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUBWCwJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 21:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbUBWCwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 21:52:09 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:14719 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261784AbUBWCwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 21:52:04 -0500
Date: Sun, 22 Feb 2004 18:52:02 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
Message-ID: <20040223025202.GA26929@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org
References: <20040222172200.1d6bdfae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20040222172200.1d6bdfae.akpm@osdl.org>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2004 at 05:22:00PM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3=
-mm3/

The change made to scripts/Makefile to rake in sumversion.o requires
this change to not break parallel builds:

--- scripts/Makefile~	2004-02-22 18:50:39.000000000 -0800
+++ scripts/Makefile	2004-02-22 18:51:06.000000000 -0800
@@ -24,7 +24,7 @@
=20
 # dependencies on generated files need to be listed explicitly
=20
-$(obj)/modpost.o $(obj)/file2alias.o: $(obj)/elfconfig.h
+$(addprefix $(obj)/,$(modpost-objs)): $(obj)/elfconfig.h
=20
 quiet_cmd_elfconfig =3D MKELF   $@
       cmd_elfconfig =3D $(obj)/mk_elfconfig $(ARCH) < $< > $@

Seems they all depend on elfconfig.h being there, so made it a general
dependency.

--=20
Joshua Kwan

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQIVAwUBQDlq0aOILr94RG8mAQLHOw//S9F38QvbieJOwD3HvvQtV3gtuZ+EtlwD
K3ul3L6WcILp6UVsUEkoNBDRFdP6gq9nvhnuCfzC0wiU+II6Am2A0IXXCR7lwcYO
V+YxfzRS8yAPdl8OX7TaO+93GlsGw9PkVJ9cINhl289LcEs13iBQ5/IRYBdCnDXf
/Q7FPfuURqP+7heE8J9Ece83nAHS4r71lU7rkHZQnQH3cjaEhtQkaiV3vpsO+OER
CN8AzQG+KbR3ErEl6yYl5RLASC8xNAmFa4APy0vf8Dke8qn6ZbFrMavtJ93Ajs5A
vmpi+AHemSYsZ8QuPXxcPFDChAUess1fY0li3lPVhjF1H+COKHQoeJYciE5W/b6S
/jhY/3MDa0D80BEX73mj+Du0jMdAuKLsfwtKiqNphHW9QmwSG11eDKfW9D7j2fLn
Q1dd6xQcUM8NL+H4rHuPHf5fVjoFytnF7ZQ5nDOVpBvJq5fYNwrZliJ56ZK+1pGM
+xWMZuXdPL9zRr0pUAwwGbkLq6lkf9xzKBR6jitZ9uFz+dDiSQOL81Ci2NKrbaCq
Fnj4wd6M+2pA9Mj+kuvoqrWgifwrA/CcoPoGlYPCxWjY4R4TkRZ4lr9IrZY0QpAW
cbNIQGq/+Dp+sSFRQwxmhGrKufIz4diJzK/4K0qrm+tO03ncIhxWxEDNBj5My+sK
DRU/bgG22fs=
=No4j
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
