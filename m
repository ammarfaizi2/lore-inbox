Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263013AbVAFVSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbVAFVSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVAFVQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:16:43 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:14815 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262969AbVAFVOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:14:51 -0500
Subject: Swapoff inifinite loops on 2.6.10-bk (was: .6.10-bk8 swapoff after
	resume)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050106134714.GB24188@mail.muni.cz>
References: <20050106134714.GB24188@mail.muni.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-W3ld2RuFlYkzEnmPdEmL"
Date: Thu, 06 Jan 2005 22:14:45 +0100
Message-Id: <1105046085.1087.29.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W3ld2RuFlYkzEnmPdEmL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-01-06 at 14:47 +0100, Lukas Hejtmanek wrote:
> Hello,

Hi

> I've tried 2.6.10-bk8 suspend/resume. After resume I usually do swapoff -=
a to
> load all the pages from swap to memory. Unfortunately with the latest ver=
sion
> swapoff does not work. It seems to cycle in an endless loop reading data =
from=20
> disk.

I second that, after resume my machine does exactly the same.
It swaps in most of the data, but it leaves ~1700kB on the swapdevice
that it doesn't manage to swap in, and apparently reads this over and
over again.

But it probably doesn't have anything to do with swsusp, I can reproduce
it without ever having suspended, just fill up the memory so the machine
swaps and then the same thing happens.

Apparently kernels from -bk in late december works fine, so it's a
recent introduction.
Needs investigating.

--=20
/Martin

--=-W3ld2RuFlYkzEnmPdEmL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB3apFWm2vlfa207ERAqJzAKCCpV1yYAPcnQpbnJhfu7oET3tBDgCfTEJF
629cfSCMKcbm3TuOXdcK1s0=
=orwo
-----END PGP SIGNATURE-----

--=-W3ld2RuFlYkzEnmPdEmL--
