Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbSJYH5n>; Fri, 25 Oct 2002 03:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSJYH5n>; Fri, 25 Oct 2002 03:57:43 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:33551 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S261300AbSJYH5m>;
	Fri, 25 Oct 2002 03:57:42 -0400
Date: Fri, 25 Oct 2002 12:01:57 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [miniPATCH][RFC] Compilation fixes in the 2.5.44
Message-ID: <20021025080157.GA311@pazke.ipt>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
References: <20021025062809.GA7522@hazard.jcu.cz> <200210250651.g9P6pnp14035@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <200210250651.g9P6pnp14035@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.5.25 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2002 at 09:44:21AM -0200, Denis Vlasenko wrote:
> On 25 October 2002 04:28, Jan Marek wrote:
> > Hallo l-k,
> >
> > I'm beginner in the kernel hacking (or fixing ;-))).
> >
> > I have small patch, which is fixing some compilation errors (I'm
> > using gcc-2.95.4-17 from Debian sid).
> >
> > The first chunk fixed this warning:
> >
> > arch/i386/kernel/irq.c: In function `do_IRQ':
> > arch/i386/kernel/irq.c:331: warning: unused variable `esp'
> >
> > I move declaration of variable esp to the #ifdef blok, where it is
> > using...
>=20
>=20
>         unsigned int status;
> -       long esp;
> =20
>         irq_enter();
> =20
>  #ifdef CONFIG_DEBUG_STACKOVERFLOW
>         /* Debugging check for stack overflow: is there less than 1KB fre=
e? */
> +       long esp;
>=20
> Most C compilers don't allow you to mix declarations and code.
> This is allowed only in new C standards. But GCC 3 seems to cope,
> so it's probably fine for new kernels.

This fragment must be fixed, look at Documentation/Changes:

"The recommended compiler for the kernel is gcc 2.95.x (x >=3D 3)"

Best regards.
=20
--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9uPp1Bm4rlNOo3YgRAv3gAJ9fmAbsJ/yN9/l6Mu4YWNMQyE3hvgCcC1xv
bAhvJBRGeguxLI8byI4iqCQ=
=3xP5
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
