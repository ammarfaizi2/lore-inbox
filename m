Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWEFP05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWEFP05 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 11:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWEFP05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 11:26:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28909 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750899AbWEFP04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 11:26:56 -0400
Message-ID: <445CC02D.8000600@redhat.com>
Date: Sat, 06 May 2006 08:26:37 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Blaisorblade <blaisorblade@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Val Henson <val.henson@intel.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <200605030245.01457.blaisorblade@yahoo.it> <445C6717.1000402@yahoo.com.au>
In-Reply-To: <445C6717.1000402@yahoo.com.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCCBD25E0A5A9940137CF407B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCCBD25E0A5A9940137CF407B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Nick Piggin wrote:
> I see no reason why they couldn't both go in. In fact, having an mmap
> flag for
> adding guard regions around vmas (and perhaps eg. a system-wide /
> per-process
> option for stack) could almost go in tomorrow.

This would have to be flexible, though.  For thread stacks, at least,
the programmer is able to specify the size of the guard area.  It can be
arbitrarily large.

Also, consider IA-64.  Here we have two stacks.  We allocate them with
one mmap call and put the guard somewhere in the middle (the optimal
ratio of CPU and register stack size is yet to be determined) and have
the stack grow toward each other.  This results into three VMAs in the
moment.  Anything which results on more VMAs obviously isn't good.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigCCBD25E0A5A9940137CF407B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEXMAt2ijCOnn/RHQRAgi3AKCn8g85TEA3i67iQlwdjk8czqUC1gCfb1wW
D4lwcZR3hhs1F6QmzOXPam8=
=HZtW
-----END PGP SIGNATURE-----

--------------enigCCBD25E0A5A9940137CF407B--
