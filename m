Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSFNNn6>; Fri, 14 Jun 2002 09:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSFNNn5>; Fri, 14 Jun 2002 09:43:57 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:16904 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S316608AbSFNNn4>;
	Fri, 14 Jun 2002 09:43:56 -0400
Date: Fri, 14 Jun 2002 17:41:52 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Dave Jones <davej@suse.de>, James Bottomley <James.Bottomley@steeleye.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager (3/4/5xxx series)
Message-ID: <20020614134152.GA1293@pazke.ipt>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Bottomley <James.Bottomley@steeleye.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <davej@suse.de> <200206140013.g5E0DQR25561@localhost.localdomain> <20020614024547.H16772@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.5.10 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=9F=D1=82=D0=BD, =D0=98=D1=8E=D0=BD 14, 2002 at 02:45:47 +0200, Dave =
Jones wrote:
> On Thu, Jun 13, 2002 at 08:13:26PM -0400, James Bottomley wrote:
>  > > Would it make sense for the subarchs to use the generic code where
>  > > possible, and only reimplement it's own (for eg) apic.c as and when =
it
>  > > actually *needs* to be different ?=20
>  > That is really the way I've implemented it.
>=20
> Ah, good.
>=20
>  >  The only PC specific file in the=20
>  > generic directory is mpparse.c (since neither visws nor voyager has an=
 MP=20
>  > compliant bios).  All the shareable files are kept in `kernel' and act=
ivated=20
>  > by config options.
>=20
> Another piece of low hanging fruit is probably dmi_scan.c
> There are no workarounds there for either (are they even DMI compliant?)
> so compiling it in doesn't make much sense.

We also have apm.c, bootflag.c and acpi.c which are definetely PC specific.

>  > I can certainly move mpparse.c back to kernel and add an extra (non us=
er=20
>  > visible) config option.
>=20
> if neither visws or voyager need it, I'd say it doesn't belong in the
> respective subarch directories period.

"Latest" (2.4.17) visws patch which i'm planning to convert for 2.5, uses
function MP_processor_info() from generic mpparse.c. May be it makes sence
to move to some generic file ?

>  > > Sounds quite logical. What does the current patches you have do ? I'=
ve
>  > > not had chance to look at them yet.=20
>  > It creates directories `generic' for the standard pc and `visws'.  The=
 voyager=20
>  > patch creates a `voyager' directory.  Alternatively, these could be `m=
ach-pc',=20
>  > `mach-visws' and `mach-voyager'.
>=20
> Yeah, I think mach-foo would be more aesthetically pleasing, so I'll
> cast my vote for that one. If nothing else, it makes it obvious that
> the subdir isn't important if you don't care about $subarch
>=20
>         Dave.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9CfKgBm4rlNOo3YgRAu30AJ9YqKtH2xxCuNJ2cVNJfR9O/593LACeIOfa
9ejZQVu0br1YQBX/71EsaLc=
=pLTH
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
