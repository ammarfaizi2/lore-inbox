Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290492AbSAYBxW>; Thu, 24 Jan 2002 20:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290494AbSAYBxN>; Thu, 24 Jan 2002 20:53:13 -0500
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:62434 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S290492AbSAYBw6>; Thu, 24 Jan 2002 20:52:58 -0500
Date: Thu, 24 Jan 2002 20:52:48 -0500
To: knobo@linpro.no
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile error -rmap12a and 2.4.18-pre7
Message-ID: <20020125015248.GA27418@opeth.ath.cx>
In-Reply-To: <ujpadv3tj87.fsf@false.linpro.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <ujpadv3tj87.fsf@false.linpro.no>
User-Agent: Mutt/1.3.27i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I believe you applied this in the reverse order. Patch
=2E17->.18-pre7->rmap12a. Use
http://www.cs.unc.edu/~chenda/Other/2.4.18-pre7_to_rmap12a.diff

I did a sanity build, and the kernel did compile and link correctly
using default config (though I did not reboot as I'm running tied up at
the moment).

On Fri, Jan 25, 2002 at 12:36:08AM +0100, knobo@linpro.no wrote:
> Hi
>=20
> I applied first rmap12a ant then 2.4.18-pre7
>=20
> then I removed line 502 (i think) "nr_pages--" from
> linux/mm/vmscan.c. (thanx to mjc)
>=20
> Then I did  make dep clean bzImage.=20
>=20
> then I got some warnings:
> In file included from /usr/src/linux/include/linux/modversions.h:144,
>                  from /usr/src/linux/include/linux/module.h:21,
>                  from dec_and_lock.c:1:
> /usr/src/linux/include/linux/modules/ksyms.ver:249: warning: `__ver_waitf=
or_one_page' redefined
> /usr/src/linux/include/linux/modules/buffer.ver:13: warning: this is the =
location of the previous definition
>=20
> And finally:
>=20
> fs/fs.o(__ksymtab+0x38): multiple definition of `__ksymtab_waitfor_one_pa=
ge'
> kernel/kernel.o(__ksymtab+0x548): first defined here
> fs/fs.o(.kstrtab+0xfb): multiple definition of `__kstrtab_waitfor_one_pag=
e'
> kernel/kernel.o(.kstrtab+0x10fa): first defined here
> make: *** [vmlinux] Error 1
>=20
>=20
>=20
> Then I turned off loadable module support, and the kernel compiled ok.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ULpwMwVVFhIHlU4RAgXdAJ9r6NIOl8MfIC64qOPj41335+tyUACfax4F
ELFfOi7OfNaieTGlfc1WCho=
=tQUK
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
