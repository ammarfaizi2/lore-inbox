Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUD1ULw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUD1ULw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUD1UKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:10:54 -0400
Received: from mh57.com ([217.160.185.21]:54507 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S261976AbUD1Tyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:54:37 -0400
Date: Wed, 28 Apr 2004 21:54:29 +0200
From: Martin Hermanowski <martin@mh57.de>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e1000 EEPROM wrong after suspending.
Message-ID: <20040428195429.GA11077@mh57.de>
References: <200404272353.27989@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <200404272353.27989@zodiac.zodiac.dnsalias.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::1
X-Spam-Score: 0.1 (/)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2004 at 11:53:23PM +0200, Alexander Gran wrote:
> Hi,
>=20
>=20
> I've got an e1000 Mobile in an IBM t40p. after a suspend/resume cycle the=
 card=20
> isn't working any longer. I'm unloading the module before the suspending,=
=20
> realoding it afterwards.
> Kernel is 2.6.6-rc2-mm2, ACPI enabled, APIC disabled (didn't boot, last t=
ime I=20
> tried)
[...]
> PCI: Setting latency timer of device 0000:02:01.0 to 64
> The EEPROM Checksum Is Not Valid
> e1000: probe of 0000:02:01.0 failed with error -5

I am using the e1000 on the t41p with enabled local apic, and I got no
problem. But when I compiled the kernel (2.6.4-rc1-mm2) without local
apic (so the notebook would turn off), I got the same problem. This was,
besides a patch to the orinico driver, the only difference between the
two kernels.

The working one has these options set:
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy

LLAP, Martin

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAkAv1mGb6Npij0ewRAj8EAJwO09iXzw5BDDP8Hb8vNpWQNlJvNQCfSNdJ
PxBLFxSLQ/oPJS1hdww7reA=
=0l1O
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
