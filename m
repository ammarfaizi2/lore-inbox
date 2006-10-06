Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbWJFCgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWJFCgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 22:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWJFCgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 22:36:06 -0400
Received: from rtsoft3.corbina.net ([85.21.88.6]:784 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S932569AbWJFCgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 22:36:03 -0400
Date: Fri, 6 Oct 2006 06:35:40 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Olof Johansson <olof@lixom.net>
Cc: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix fsl_soc build breaks
Message-ID: <20061006063540.1b5c9528@localhost.localdomain>
In-Reply-To: <20061005211648.0d550152@pb15>
References: <20061005211648.0d550152@pb15>
X-Mailer: Sylpheed-Claws 2.5.2cvs1 (GTK+ 2.10.4; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_4WTd0IpFZsFYIgux4vvO0na;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_4WTd0IpFZsFYIgux4vvO0na
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Oct 2006 21:16:48 -0500
Olof Johansson wrote:

> Hrm, there's no way this ever built at time of merge. There's a
> missing } and the wrong type on phy_irq.
>=20
> Also, another const for get_property().
>=20
>=20
>   CC      arch/powerpc/sysdev/fsl_soc.o
> arch/powerpc/sysdev/fsl_soc.c: In function 'fs_enet_of_init':
> arch/powerpc/sysdev/fsl_soc.c:625: error: assignment of read-only
> variable 'phy_irq' arch/powerpc/sysdev/fsl_soc.c:625: warning:
> assignment makes integer from pointer without a cast
> arch/powerpc/sysdev/fsl_soc.c:661: warning: assignment discards
> qualifiers from pointer target type
> arch/powerpc/sysdev/fsl_soc.c:684: error: subscripted value is
> neither array nor pointer arch/powerpc/sysdev/fsl_soc.c:687: error:
> subscripted value is neither array nor pointer
> arch/powerpc/sysdev/fsl_soc.c:722: warning: ISO C90 forbids mixed
> declarations and code arch/powerpc/sysdev/fsl_soc.c:728: error:
> invalid storage class for function 'cpm_uart_of_init'
> arch/powerpc/sysdev/fsl_soc.c:798: error: initializer element is not
> constant arch/powerpc/sysdev/fsl_soc.c:798: error: expected
> declaration or statement at end of input make[1]: ***
> [arch/powerpc/sysdev/fsl_soc.o] Error 1
>=20
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>
>=20
>=20
> ---
>=20
> There are more issues with this file. Whitespace, if () {}; and other
> things. I'm just fixing the build breaks.
>=20
> These were all introduced by patches fed upstream via git trees
> instead of list posts, as far as I can tell. Maybe posting patches is
> a better idea, more eyes on the code.
>=20

All those were submitted in form of patches prior, and located issues addre=
ssed. I must mistype something with git-push,
so it didn't fed in very latest changes. Thanks for pointing it out and sor=
ry for confusion.

--
Sincerely, Vitaly

--Sig_4WTd0IpFZsFYIgux4vvO0na
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFJcD8uOg9JvQhSEsRAilZAJ9z2huq0aovwaqEfI5BrVlUFasPFACcDgMk
Qa6GGNCqOCWKbHP/JcVTLX4=
=qAdB
-----END PGP SIGNATURE-----

--Sig_4WTd0IpFZsFYIgux4vvO0na--
