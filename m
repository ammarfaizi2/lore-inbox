Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVAYM5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVAYM5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVAYM5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:57:06 -0500
Received: from smtp08.auna.com ([62.81.186.18]:24724 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261926AbVAYM4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:56:36 -0500
Date: Tue, 25 Jan 2005 12:56:25 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: patch to enable Nvidia v5336 on v2.6.11 kernel (was Re:
 inter_module_get and __symbol_get)
To: davidm@hpl.hp.com
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <16885.32149.788747.550216@napali.hpl.hp.com>
	<31612.1106607781@ocs3.ocs.com.au>
	<16885.38947.35646.558780@napali.hpl.hp.com>
In-Reply-To: <16885.38947.35646.558780@napali.hpl.hp.com> (from
	davidm@napali.hpl.hp.com on Tue Jan 25 01:51:47 2005)
X-Mailer: Balsa 2.2.6
Message-Id: <1106657785l.6979l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-8A00Bs7e3E3i7Llc4Olt"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-8A00Bs7e3E3i7Llc4Olt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2005.01.25, David Mosberger wrote:
> >>>>> On Tue, 25 Jan 2005 10:03:01 +1100, Keith Owens <kaos@ocs.com.au> s=
aid:
>=20
>   Keith> I have always hated the dynamic resolution model used by
>   Keith> DRM/AGP and (originally) MTD.
>=20
> Well, the attached patch does the trick for me for Nvidia driver v5336
> on ia64.  It compiles with a minimum amount of fuss with gcc v3.4
> (just a handful of warnings about deprecated pm_{un,}register() and
> inter_module_put()).
>=20

You can use the latest drivers (6629) with this patches:

http://www.minion.de/files/1.0-6629/

They work fine up to -rc2.

If you want to use the driver with -mm, you have to kill the support
for AGPGART in nvidia driver, add -DNOAGPGART to EXTRA_CFLAGS in the
makefile. It will require a big change to use the multi-agp patches
in -mm. But you are restricted to those AGPs supported by nvidia
(ah, and don't load any agp related module...).

Ah, just a ton of workarounds....

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam6 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


--=-8A00Bs7e3E3i7Llc4Olt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB9kH5RlIHNEGnKMMRAoI5AKCZvDZsNrbEeibITnV5moWoccF0mQCfTrQ9
yjySFTu9qKu8e9dcBXXmOOc=
=LRGF
-----END PGP SIGNATURE-----

--=-8A00Bs7e3E3i7Llc4Olt--

