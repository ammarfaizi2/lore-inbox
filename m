Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbUKDK27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbUKDK27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 05:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbUKDK27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 05:28:59 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:13718 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262158AbUKDK24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 05:28:56 -0500
Date: Thu, 4 Nov 2004 11:27:52 +0100
From: Martin Waitz <tali@admingilde.org>
To: Tejun Heo <tj@home-tj.org>
Cc: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 0/4] driver-model: manual device attach
Message-ID: <20041104102752.GW3618@admingilde.org>
Mail-Followup-To: Tejun Heo <tj@home-tj.org>, rusty@rustcorp.com.au,
	mochel@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org
References: <20041104074330.GG25567@home-tj.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MUnXZt0Uv08c1hBe"
Content-Disposition: inline
In-Reply-To: <20041104074330.GG25567@home-tj.org>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MUnXZt0Uv08c1hBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Nov 04, 2004 at 04:43:30PM +0900, Tejun Heo wrote:
>  Two files named attach and detach are created under each device's
> sysfs directory.  Reading attach node shows the name of applicable
> drivers.  Writing a driver name attaches the device to the driver.
> Also, per-device parameters can be specified when writing to an attach
> node.  Writing anything to the write-only detach node detaches the
> driver from the currently associated driver.

perhaps it'll be simpler with only the attach file and using a special
magic value ("", "none", "detach", whatever) to manually detach a device
from the driver.

Is it possible (and worthwhile) to reattach a manually detached device
to the default driver? Perhaps using a magic value "auto" for attach.
Something like your dev.autoattach=3D2 rescan method, but for one
device only. (What is the use case to rescan all busses, anyway?)

--=20
Martin Waitz

--MUnXZt0Uv08c1hBe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBie+6j/Eaxd/oD7IRAhCsAJ0UHzcASkUu43jZGv5jgvQUOf1iYACeP7qV
c0m3BzVHlUS+ESfHO3qny1k=
=CZkt
-----END PGP SIGNATURE-----

--MUnXZt0Uv08c1hBe--
