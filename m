Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbULFKCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbULFKCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 05:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbULFKCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 05:02:44 -0500
Received: from mout0.freenet.de ([194.97.50.131]:6081 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261478AbULFKCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 05:02:35 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [RFC] Strange code in cpu_idle()
Date: Mon, 6 Dec 2004 11:01:01 +0100
User-Agent: KMail/1.7.1
References: <20041204231149.GA1591@us.ibm.com> <200412060132.40912.mbuesch@freenet.de> <Pine.LNX.4.61.0412060250410.1036@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0412060250410.1036@montezuma.fsmlabs.com>
Cc: paulmck@us.ibm.com, dipankar@in.ibm.com, rusty@au1.ibm.com, ak@suse.de,
       gareth@valinux.com, davidm@hpl.hp.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1295562.yv39L3NK4g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412061101.07264.mbuesch@freenet.de>
X-Warning: freenet.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1295562.yv39L3NK4g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Zwane Mwaikambo <zwane@arm.linux.org.uk>:
> On Mon, 6 Dec 2004, Michael Buesch wrote:
>=20
> > Hi Paul,
> >=20
> > Well, your mail is _very_ interresting for me.
> >=20
> > I get this oops for weeks with several kernel versions now:
>=20
> There shouldn't be any oopses with the changes in question, the original=
=20
> bugfix was for crashes whilst unloading ACPI processor or APM module.
>=20
> > Unable to handle kernel paging request at virtual address 00099108
> >  printing eip:
> > b01010c0
> > *pde =3D 00000000
> > Oops: 0000 [#1]
> > SMP=20
> > Modules linked in: nfs lockd sunrpc nvidia ipv6 ohci_hcd tuner tvaudio =
msp3400 bttv video_buf firmware_class btcx_risc ehci_hcd uhci_hcd usbcore i=
ntel_agp agpgart evdev
> > CPU:    0
> > EIP:    0060:[<b01010c0>]    Tainted: P      VLI
> > EFLAGS: 00010286   (2.6.10-rc2-ck2-nozeroram-findvmastat)
>=20
> It would be a lot easier to debug with a vanilla kernel and no nvidia=20
> loaded.
>=20
> > The above oops shows a crash when we try to access the
> > thread_info->flags field. This is done by need_resched()
> > to check the TIF_NEED_RESCHED flag.
> > I don't know how to interpret the oops correctly to find
> > the source of the crash.
>=20
> Looks like thread_info was. Wow i think you're in a different world of=20
> hurt. If you can reproduce with less patches and no nvidia please send=20
> over the bugreport.

Yes. That's the problem.
It's impossible to reproduce and it's pure luck when it's triggered.
I'll look what I can do. nvidia already received this bugreport.

> Thanks,
>  Zwane
>=20
>=20
>=20

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]



--nextPart1295562.yv39L3NK4g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBtC3jFGK1OIvVOP4RAre0AJwJ8H/Tzy7LIgvBPXwbO+NX/IHIKwCeLRuA
+GSNwQVO2zOklrrC6+zXUc0=
=EzLA
-----END PGP SIGNATURE-----

--nextPart1295562.yv39L3NK4g--
