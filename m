Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTLGVxH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264570AbTLGVxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:53:06 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:13293 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S264569AbTLGVxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 16:53:01 -0500
Subject: Re: Nick's scheduler v19a
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FCE6073.7040503@cyberone.com.au>
References: <3FB62608.4010708@cyberone.com.au>
	 <1069361130.13479.12.camel@midux>  <3FBD4F6E.3030906@cyberone.com.au>
	 <1069395102.16807.11.camel@midux>  <3FBDAE99.9050902@cyberone.com.au>
	 <1069405566.18362.5.camel@midux>  <3FBDD790.5060401@cyberone.com.au>
	 <1070468086.17208.4.camel@midux>  <3FCE6073.7040503@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yTt+vvyyzabPmF51ONBx"
Message-Id: <1070833955.3572.2.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 07 Dec 2003 23:52:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yTt+vvyyzabPmF51ONBx
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hi again Nick, I ported the patch forward to -bk1>, the problem was
here:
<snip>
-                       if (sync)
<snip>

That should be:
<snip>
-                       if (sync && (task_cpu(p) =3D=3D smp_processor_id())=
)
<snip>
when patchin kernel/sched.c
Is this right?
Regards,
Markus
On Thu, 2003-12-04 at 00:15, Nick Piggin wrote:
> Markus H=E4stbacka wrote:
>=20
> >Hi Nick,
> >I noticed that v19a patch wont apply to 2.6.0-test11-bk1
> >
>=20
> Hi Markus,
> OK, thanks for the notice, I'll bring it up to date when I get time
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-yTt+vvyyzabPmF51ONBx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/06Ei3+NhIWS1JHARAuC8AJ9AdsssOWRxxGIvPnBSmnxMB7kkXQCgmmq5
Pd1L5LPDDSm8zjpInNzqVew=
=gVAj
-----END PGP SIGNATURE-----

--=-yTt+vvyyzabPmF51ONBx--

