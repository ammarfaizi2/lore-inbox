Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbULPI0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbULPI0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 03:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbULPI0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 03:26:32 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:3036 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262643AbULPIZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 03:25:59 -0500
Date: Thu, 16 Dec 2004 09:25:50 +0100
From: Martin Waitz <tali@admingilde.org>
To: tony osborne <tonyosborne_a@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OS I/O operations concepts
Message-ID: <20041216082550.GL31835@admingilde.org>
Mail-Followup-To: tony osborne <tonyosborne_a@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY14-F1340F1BEA5470EBDE3DD2095AD0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7l042bGvurpep9Wg"
Content-Disposition: inline
In-Reply-To: <BAY14-F1340F1BEA5470EBDE3DD2095AD0@phx.gbl>
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
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7l042bGvurpep9Wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Dec 15, 2004 at 09:10:03PM +0000, tony osborne wrote:
> What about the disk bitmap and the one loaded into the memory. Will this =
be=20
> updated at each Byte write operation? This will slow down extremely the=
=20
> system speed.

no, all data is first written into the buffer cache and will be written
to disk later.

> Should the programmer force the second option (by using BufferOutputStrea=
m=20
> as in java) or is it done automatically by the JVM or OS?

Writing single bytes can be slow because of another reason:
system calls are expensive and it makes sense to buffer data in the
application and send it to the operating system in one big system call.

> Does the I/O controller (once the device driver installed) full privilege=
s=20
> as the main CPU when on kernel mode?

I'm not sure if i understood your question correctly but yes,
The IO Controller has full access to physical memory through DMA.

> is Java system.in.read (system.out.println) synchronous or asynchronous I=
/O=20
> Op

They are synchronous. Otherwise you couldn't access your data at the
moment read() returns.

--=20
Martin Waitz

--7l042bGvurpep9Wg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBwUaNj/Eaxd/oD7IRAshUAJ9E2wgWuZ5gjP8P9z5p8wjPLLTvaACcDgmw
iKJSsr4EUjucph/SDV/5wMs=
=F3oG
-----END PGP SIGNATURE-----

--7l042bGvurpep9Wg--
