Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264661AbTFAQNm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 12:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264662AbTFAQNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 12:13:42 -0400
Received: from ik-dynamic-66-102-74-246.kingston.net ([66.102.74.246]:7689
	"EHLO linux.interlinx.bc.ca") by vger.kernel.org with ESMTP
	id S264661AbTFAQNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 12:13:40 -0400
Subject: Re: [PATCH][2.5] Honour dont_enable_local_apic flag
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: mikpe@csd.uu.se
Cc: zwane@linuxpower.ca, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <200306011123.h51BNIT7019716@harpo.it.uu.se>
References: <200306011123.h51BNIT7019716@harpo.it.uu.se>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jQyohiA/CnmGL0iIcabD"
Message-Id: <1054484816.6676.61.camel@pc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3-1mdk (Preview Release)
Date: 01 Jun 2003 12:26:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jQyohiA/CnmGL0iIcabD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-06-01 at 07:23, mikpe@csd.uu.se wrote:
>=20
> I didn't follow this thread closely, but:
>=20
> 1. dont_enable_local_apic was originally only intended for those
>    systems (i.e., Dell laptops) where enabling the local APIC in
>    HW (via APIC_BASE MSR) causes problems due to broken BIOSen.
>    It was never intended as a "Kernel, please don't use the local
>    APIC even though I configured it" option. It doesn't help you
>    if your machine boots with the local APIC enabled, but the
>    local APIC doesn't work for some reason.

OK.  I really have no experience or knowledge about this stuff to argue
this point.

> 2. The only way to reach no_apic is if we boot on a vendor/model
>    combination that isn't known to have a local APIC that can be
>    enabled in software. And the second patch hunk only makes a
>    difference if the CPU boots with an enabled local APIC.
>=20
>    So what vendor/model CPU is used in the failure case?

VMware 2.0.4.

When the kernel boots, it detects the local APIC, however when it comes
time to calibrate the APIC timer interrupts, the kernel "stops"/hangs.

>    (And if its local APIC is broken, cpu_has_apic should be cleared
>    rather than setting the dont_enable flag. Post-boot code may
>    access the local APIC if CONFIG_X86_LOCAL_APIC && cpu_has_apic.)
>=20
> 3. What is the exact failure? Hang or crash?

Normal boot until here:

Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1658.7651 MHz.
..... host bus clock speed is 0.0000 MHz.
cpu: 0, clocks: 0, slice: 0

>  Where? UP or SMP kernel?

UP.

b.

--=20
Brian J. Murrell <brian@interlinx.bc.ca>

--=-jQyohiA/CnmGL0iIcabD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+2ilQl3EQlGLyuXARAkDKAJ4+vY7UxgskpVvZnRCqrpInsP3y+gCfZVJ+
9FcIPG+9ZIqi/7RAosXWwaA=
=wAo4
-----END PGP SIGNATURE-----

--=-jQyohiA/CnmGL0iIcabD--
