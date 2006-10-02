Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWJBA51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWJBA51 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 20:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWJBA51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 20:57:27 -0400
Received: from remus.commandcorp.com ([130.205.32.4]:49314 "EHLO
	remus.wittsend.com") by vger.kernel.org with ESMTP id S932550AbWJBA50
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 20:57:26 -0400
Subject: Re: [PATCH] drivers/char/ip2: kill unused code, label
From: "Michael H. Warfield" <mhw@WittsEnd.com>
Reply-To: mhw@WittsEnd.com
To: Jeff Garzik <jeff@garzik.org>
Cc: mhw@WittsEnd.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061001153753.GA5388@havoc.gtf.org>
References: <20061001153753.GA5388@havoc.gtf.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TeSfFaMXFkLYp1MC7oef"
Organization: Thaumaturgy & Speculums Technology
Date: Sun, 01 Oct 2006 20:57:07 -0400
Message-Id: <1159750627.24836.1.camel@canyon.wittsend.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-WittsEnd-MailScanner-Information: Please contact the ISP for more information
X-WittsEnd-MailScanner: Found to be clean
X-WittsEnd-MailScanner-From: mhw@wittsend.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TeSfFaMXFkLYp1MC7oef
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-01 at 11:37 -0400, Jeff Garzik wrote:
> Kill warning:

> drivers/char/ip2/ip2main.c: In function =E2=80=98ip2_loadmain=E2=80=99:
> drivers/char/ip2/ip2main.c:782: warning: label =E2=80=98out_class=E2=80=
=99 defined but not used

> This driver's initialization (and cleanup of errors during init) is
> extremely convoluted, and could stand to be transformed into the
> standard unwinding-goto style of error cleanup.

> Signed-off-by: Jeff Garzik <jeff@garzik.org>

	Looks good to me.  I'll look into the unwinding suggestion.

	Signed-off-by: Michael H. Warfield <mhw@wittsend.com>

> diff --git a/drivers/char/ip2/ip2main.c b/drivers/char/ip2/ip2main.c
> index 331f447..bcf6573 100644
> --- a/drivers/char/ip2/ip2main.c
> +++ b/drivers/char/ip2/ip2main.c
> @@ -779,8 +779,6 @@ retry:
>  	ip2trace (ITRC_NO_PORT, ITRC_INIT, ITRC_RETURN, 0 );
>  	goto out;
> =20
> -out_class:
> -	class_destroy(ip2_class);
>  out_chrdev:
>  	unregister_chrdev(IP2_IPL_MAJOR, "ip2");
>  out:
--=20
Michael H. Warfield (AI4NB) | (770) 985-6132 |  mhw@WittsEnd.com
   /\/\|=3Dmhw=3D|\/\/          | (678) 463-0932 |  http://www.wittsend.com=
/mhw/
   NIC whois: MHW9          | An optimist believes we live in the best of a=
ll
 PGP Key: 0xDF1DD471        | possible worlds.  A pessimist is sure of it!


--=-TeSfFaMXFkLYp1MC7oef
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQCVAwUARSBj4uHJS0bfHdRxAQIHxgP/ajgRx3SYspHXyMpx2so+EAikiR1getiu
KsKeFCLswsJreoezmjwywVCyJP0/rqV2YPNF5vasZg27SmAEhOhNQpSWuJHh05Su
DedFfZ2MBcGPqtyivpXVcCY4e6FY4U///mbMf1tMNZ4wnaJNqanaCHKam4fjOBHD
53CWMVITQP0=
=Ldy1
-----END PGP SIGNATURE-----

--=-TeSfFaMXFkLYp1MC7oef--

