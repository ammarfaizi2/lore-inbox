Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbULGVBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbULGVBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbULGVBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:01:47 -0500
Received: from mail.gmx.de ([213.165.64.20]:39854 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261892AbULGVBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:01:17 -0500
X-Authenticated: #3340650
Subject: Re: [<02282da7>] (usb_hcd_irq+0x0/0x4b) Disabling IRQ #5 - USB
	Devices do not work
From: Florian Krammel <florian_kr@gmx.de>
To: Kernel-list <linux-kernel@vger.kernel.org>
In-Reply-To: <1102450409.7531.10.camel@orange-bud>
References: <1102333735.5095.4.camel@orange-bud>
	 <1102339694.13485.26.camel@localhost.localdomain>
	 <1102450409.7531.10.camel@orange-bud>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yCmHQkHtMi338+fnSWKW"
Date: Tue, 07 Dec 2004 21:52:09 +0100
Message-Id: <1102452729.7531.29.camel@orange-bud>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yCmHQkHtMi338+fnSWKW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > What chipset is the motherboard ?

I don't know, I don't have the motherboard manuals.
How can I get this information via software?


> > Windows XP and Linux may well hit the same problems with USB.

really? ;)


> > The latest FC3 kernel should have new enough -ac patches to run on boxe=
s
> > with
> > totally broken BIOS IRQ routing. Try the boot option "irqpoll"

this is great, thank you! I get the error message but everything works


> > Ditto, and this is quite possibly the root cause. That suggests the BIO=
S
> > handover code for EHCI is insufficient for some cases (and it appears t=
o
> > be looking at the code quickly - it should register IRQ 5 before doing =
a
> > handover which it does but it probably needs to just ack and mask IRQ 5
> > during the handover. It could be another device breaking IRQ5 however)
> >=20
> >=20
> > What occurs if you build a kernel with EHCI disabled, ditto what occurs
> > if you boot with init=3D/bin/sh and then load ohci before ehci ?

I don't tested this because "irqpoll" solve my problem. Are you
interested in the result? I can try it.


thank you for help...

mfg
florian

--=20
Florian Krammel <florian_kr@gmx.de>

--=-yCmHQkHtMi338+fnSWKW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBthf4m9XQAcbR/eIRAgjeAJ90BZn4HLhLlDngCzafSzuHabfdSgCfSJML
q3OYkLsU7CB19cxTpuP3Myk=
=3bR3
-----END PGP SIGNATURE-----

--=-yCmHQkHtMi338+fnSWKW--

