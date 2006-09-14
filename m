Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWINS2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWINS2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWINS2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:28:35 -0400
Received: from mail.isohunt.com ([69.64.61.20]:44499 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1750962AbWINS2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:28:34 -0400
X-Spam-Check-By: mail.isohunt.com
Date: Thu, 14 Sep 2006 12:53:44 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: robbat2@gentoo.org
Subject: x86_64 (EM64T Core2 Duo, DG965RY) PCI mmconfig regression - complete hangs on boot - ACPI interaction?
Message-ID: <20060914195344.GC27531@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Please CC me, I'm not subscribed to LKML.]

I recently picked up a new server of really new hardware, and I've run
into a number of issues with the latest git HEAD kernels. I'll make
separate posts for each of the issues.

CPU: Intel Core 2 Duo E6400
Motherboard: Intel DG965RY
BIOS revisions: July/07/2006 AND September/06/2006 (tried both)

The most significant of them - is that somewhere between 2.6.17.11 and
2.6.18-rc6-git4, MMCONFIG is now being used, but leads to a complete
hardware hang (SYSRQ does not respond).

As of the current HEAD, I need to boot with pci=3Dnommconf OR acpi=3Doff,
otherwise the machine completely freezes a short while into the PCI
detection routine. Using acpi=3Doff disables SMP, which is not desirable
on this box, but otherwise does work.

All of the following boot params lead to a failure:
pci=3Dassign-busses
acpi=3Dstrict
pci=3Dnoacpi
acpi=3Dht
pci=3Dnomsi

At the following URL, I have photos and transcriptions of the kernel
boots, as well as dmesg output from working 2.6.17.11 and .18-rc7-git1
with pci=3Dnommconf.
http://www.orbis-terrarum.net/~robbat2/x86_64-mmconfig-failure/

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFCbNIPpIsIjIzwiwRAvdtAKCaF7J/cTAuVYX3Y+NV7zwYOSAfvQCg53H8
JNszsw74QYyOU3Mz4DIt/5Y=
=N4/o
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
