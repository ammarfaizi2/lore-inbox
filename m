Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271089AbTG1WGo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 18:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271140AbTG1WGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 18:06:43 -0400
Received: from niobium.golden.net ([199.166.210.90]:19164 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP id S271089AbTG1WE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 18:04:59 -0400
Date: Mon, 28 Jul 2003 18:04:40 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Thomas Themel <themel-lkml@iwoars.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rivafb still broken in 2.6.0-test2?
Message-ID: <20030728220440.GB29466@linux-sh.org>
Mail-Followup-To: Thomas Themel <themel-lkml@iwoars.net>,
	linux-kernel@vger.kernel.org
References: <20030728182822.GG391@iwoars.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20030728182822.GG391@iwoars.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2003 at 08:28:22PM +0200, Thomas Themel wrote:
> The original problem was encountered on a UP kernel running ACPI, local
> APIC and MTRR support, but removing these features didn't help.
>=20
> This is what rivafb has to say:
>=20
> rivafb: nVidia device/chipset 10DE0171
> rivafb: Detected CRTC controller 0 being used
> rivafb: PCI nVidia NV20 framebuffer ver 0.9.5b (nVidiaGeForce4-M, 64MB @ =
0xD0000000)
> Console: switching to colour frame buffer device 80x30
>=20
> with MTRR enabled, it's:
>=20
> rivafb: nVidia device/chipset 10DE0171
> rivafb: Detected CRTC controller 0 being used
> rivafb: RIVA MTRR set to ON
> rivafb: PCI nVidia NV20 framebuffer ver 0.9.5b (nVidiaGeForce4-M, 64MB @ =
0xD0000000)
> Console: switching to colour frame buffer device 80x30
>=20
> but gives the same result. Is this supposed to work?=20
>=20
Not sure about the GeForce4's, but I can attest that rivafb works fine under
-test1 and -test2 on my GeForce2:

rivafb: nVidia device/chipset 10DE0150
rivafb: RIVA MTRR set to ON
rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-G, 32MB @ 0x=
E8000000)
Console: switching to colour frame buffer device 128x48

I'm running on SMP, and don't have ACPI enabled. MTRR support also works fi=
ne
for me.

The problem you have seems isolated to your board/chip.


--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/JZ331K+teJFxZ9wRAlaNAJ9gfqV8d22dmccBfRwzNuOXLxWFdACeK1NI
fvIlXEg+jQpAW8yitos2juE=
=mMKp
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
