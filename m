Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTJUIjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 04:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbTJUIjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 04:39:04 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:16367 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263019AbTJUIjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 04:39:02 -0400
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI
	P-state driver
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-acpi <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Dominik Brodowski <linux@brodo.de>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com>
References: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-S/VVdAcv/ouC+l4UsFx7"
Organization: Red Hat, Inc.
Message-Id: <1066725533.5237.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Tue, 21 Oct 2003 10:38:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S/VVdAcv/ouC+l4UsFx7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-21 at 04:56, Pallipadi, Venkatesh wrote:
> Patch 3/3: New dynamic cpufreq driver (called=20
> DemandBasedSwitch driver), which periodically monitors CPU=20
> usage and changes the CPU frequency based on the demand.


it's all nice code and such, but I still wonder why this can't be done
by a userland policy daemon. The 2.6 kernel has the infrastructure to
give very detailed information to userspace (eg top etc) about idle
percentages...... I didn't see anything in this driver that couldn't be
done from userspace.

Note that I'm not totally against doing some of this in the kernel; I
can well see the point of say, detecting an IRQ overload and based on
that, go to max speed in the kernel because it's a situation where
userspace doesn't even run; but the patch as is doesn't do any such
advanced things...

--=-S/VVdAcv/ouC+l4UsFx7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/lPCdxULwo51rQBIRAv5VAJwMsnktwQ29tXjQfg4ErZ8/A74VyACfWT2O
QCHHEyS3+KWp8/0icuBvGjk=
=BS2i
-----END PGP SIGNATURE-----

--=-S/VVdAcv/ouC+l4UsFx7--
