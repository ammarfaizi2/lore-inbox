Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWCWVL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWCWVL2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422700AbWCWVL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:11:28 -0500
Received: from smtp06.auna.com ([62.81.186.16]:23994 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1422699AbWCWVL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:11:27 -0500
Date: Thu, 23 Mar 2006 22:11:25 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: [PATCH]  Make __get_cpu_var use raw_smp_processor_id()
Message-ID: <20060323221125.0aacd6c4@werewolf.auna.net>
In-Reply-To: <20060323220711.28fcb82f@werewolf.auna.net>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060323220711.28fcb82f@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.0.0cvs160 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_.nkPQSrYYtdrNvkqkXwV1hN;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Thu, 23 Mar 2006 22:11:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_.nkPQSrYYtdrNvkqkXwV1hN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Mar 2006 22:07:11 +0100, "J.A. Magallon" <jamagallon@able.es> wr=
ote:

> On Thu, 23 Mar 2006 01:40:46 -0800, Andrew Morton <akpm@osdl.org> wrote:
>=20
> >=20
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.=
6.16-mm1/
> >=20
>=20

--- linux-2.6.15-rc5/include/asm-generic/percpu.h.orig	2005-12-21 15:13:27.=
000000000 -0600
+++ linux-2.6.15-rc5/include/asm-generic/percpu.h	2005-12-21 15:13:43.00000=
0000 -0600
@@ -13,7 +13,7 @@ extern unsigned long __per_cpu_offset[NR
=20
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[c=
pu]))
-#define __get_cpu_var(var) per_cpu(var, smp_processor_id())
+#define __get_cpu_var(var) per_cpu(var, raw_smp_processor_id())
=20
 /* A macro to avoid #include hell... */
 #define percpu_modcopy(pcpudst, src, size)			\

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam20 (gcc 4.0.3 (4.0.3-1mdk for Mandriva Linux release 2006.1=
))

--Sig_.nkPQSrYYtdrNvkqkXwV1hN
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIw79RlIHNEGnKMMRAiVzAJ9QILR8jI+zJdCqaSiC8VU5tT8LIgCgms1V
7Lb6T7RAh3ESG0rvu6a/uSw=
=MdfT
-----END PGP SIGNATURE-----

--Sig_.nkPQSrYYtdrNvkqkXwV1hN--
