Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUEJQFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUEJQFR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264844AbUEJQFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:05:16 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:1754 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S264843AbUEJQFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:05:00 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
From: Ian Kumlien <pomac@vapor.com>
To: a.verweij@student.tudelft.nl
Cc: Ross Dickson <ross@datscreative.com.au>, cbradney@zip.com.au,
       linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       christian.kroener@tu-harburg.de,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Allen Martin <AMartin@nvidia.com>
In-Reply-To: <Pine.GHP.4.44.0405101659320.6908-100000@elektron.its.tudelft.nl>
References: <Pine.GHP.4.44.0405101659320.6908-100000@elektron.its.tudelft.nl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xNDn8q+pqHetcFfht31H"
Message-Id: <1084205099.2954.10.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 18:04:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xNDn8q+pqHetcFfht31H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-10 at 17:05, Arjen Verweij wrote:
> Does the 2.6.6 Changelog section about nforce2 imply that Ross' Patches o=
f
> Stability are no longer required? I don't read lkml regularely, so this
> would be new for me.

Do a grep for nforce and you'll find:
<B.Zolnierkiewicz@elka.pw.edu.pl>
	[PATCH] fixup for C1 Halt Disconnect problem on nForce2 chipsets
=09
	Based on information provided by "Allen Martin" <AMartin@nvidia.com>:
=09
	A hang is caused when the CPU generates a very fast CONNECT/HALT cycle
	sequence.  Workaround is to set the SYSTEM_IDLE_TIMEOUT to 80 ns.
	This allows the state-machine and timer to return to a proper state within
	80 ns of the CONNECT and probe appearing together.  Since the CPU will not
	issue another HALT within 80 ns of the initial HALT, the failure condition
	is avoided.

and:
<len.brown@intel.com>
	[ACPI] workaround for nForce2 BIOS bug: XT-PIC timer in IOAPIC mode=20
	"acpi_skip_timer_override" boot parameter
	dmi_scan for common platforms, may be replaced with PCI-ID in future.
	http://bugzilla.kernel.org/show_bug.cgi?id=3D1203

So it's only missing the patches that ross mentioned, it will still work
without em. (except for clock drift afair)

> Anyway, if this works (tm) I am very happy. Will attempt to test it later
> on, even though I have Maxtor 8MB discs :)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-xNDn8q+pqHetcFfht31H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAn6gr7F3Euyc51N8RAvknAKCgBu4xmmcwJ93WcHTMVab91g38IwCfQXD8
Gl/tUncYU6zV0B1zNCpLiwQ=
=8HOb
-----END PGP SIGNATURE-----

--=-xNDn8q+pqHetcFfht31H--

