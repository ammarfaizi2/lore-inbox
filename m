Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWC2WjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWC2WjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWC2WjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:39:18 -0500
Received: from ozlabs.org ([203.10.76.45]:34026 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751141AbWC2WjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:39:17 -0500
Subject: Re: [PATCH] powerpc: Move pSeries firmware feature setup into
	platforms/pseries
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20060329195212.GA19236@redhat.com>
References: <200603230714.k2N7EmH1021685@hera.kernel.org>
	 <20060329195212.GA19236@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6Bxyjf+t739xaRblt8s9"
Date: Thu, 30 Mar 2006 09:39:15 +1100
Message-Id: <1143671955.23392.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6Bxyjf+t739xaRblt8s9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-29 at 14:52 -0500, Dave Jones wrote:
> On Thu, Mar 23, 2006 at 07:14:49AM +0000, Linux Kernel wrote:
>  > commit 1965746bce49ddf001af52c7985e16343c768021
>  > tree d311fce31613545f3430582322d66411566f1863
>  > parent 0941d57aa7034ef7010bd523752c2e3bee569ef1
>  > author Michael Ellerman <michael@ellerman.id.au> Fri, 10 Feb 2006 15:4=
7:36 +1100
>  > committer Paul Mackerras <paulus@samba.org> Fri, 10 Feb 2006 16:52:03 =
+1100
>  >=20
>  > [PATCH] powerpc: Move pSeries firmware feature setup into platforms/ps=
eries
>  >=20
>  > Currently we have some stuff in firmware.h and kernel/firmware.c that =
is
>  > #ifdef CONFIG_PPC_PSERIES. Move it all into platforms/pseries.
>=20
> This (or one of the other firmware patches, I've not narrowed it down tha=
t close)
> breaks ppc64 oprofile.
>=20
> modpost now complains with..
>=20
> kernel/arch/powerpc/oprofile/oprofile.ko needs unknown symbol ppc64_firmw=
are_features

Hi Dave,

I'm not sure about that patch, but I think the firmware feature stuff
has been broken for modules for a while, we weren't exporting
ppc64_firmware_features anywhere.

The fix just got merged in the last day or so:
http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3Dd0160bf0b3e87032be8e85f80ddd2f18e107b86f

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-6Bxyjf+t739xaRblt8s9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEKwySdSjSd0sB4dIRAtJMAJkBd/ydHFQsY4qxf0celOg7wwmZ0QCfRVsf
2xqOWhn1O6aHCki9XPjSCIE=
=FNce
-----END PGP SIGNATURE-----

--=-6Bxyjf+t739xaRblt8s9--

