Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVFMQOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVFMQOB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVFMQOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:14:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57020 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261325AbVFMQNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:13:41 -0400
Message-ID: <42ADAFE5.5050206@redhat.com>
Date: Mon, 13 Jun 2005 09:10:13 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Jakub Jelinek <jakub@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Add pselect, ppoll system calls.
References: <1118444314.4823.81.camel@localhost.localdomain>	 <1118616499.9949.103.camel@localhost.localdomain>	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>	 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>	 <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>	 <42AD2640.5040601@redhat.com> <20050613091600.GA32364@outpost.ds9a.nl>	 <1118655702.2840.24.camel@localhost.localdomain>	 <20050613110556.GA26039@infradead.org>	 <20050613111422.GT22349@devserv.devel.redhat.com>	 <1118661848.2840.34.camel@localhost.localdomain>	 <42ADA880.60303@redhat.com> <1118678548.25956.200.camel@hades.cambridge.redhat.com>
In-Reply-To: <1118678548.25956.200.camel@hades.cambridge.redhat.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig49025BDEC33A66241D5CF3D4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig49025BDEC33A66241D5CF3D4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

David Woodhouse wrote:
> 64-bit value for which? For seconds?

poll()'s timeout value is measrued in milliseconds.  Using a 32bit
value, as implied by using 'int' for the type, limits the mximum timeout
to be 2^31-1 milliseconds, which means about 24 days.  Believe it or
not, people are complaining about this.  Changing the timeout to a 64
bit millisecond timeout would lift the limitation from the API's POV.  I
don't know what limitations exist in the kernel itself.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig49025BDEC33A66241D5CF3D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFCra/l2ijCOnn/RHQRAqeGAKC6XxatgY958Ro7b86/4JQSDF7xxACffY3/
gElDkfRDmp6fMhLijxLzX2U=
=35Lx
-----END PGP SIGNATURE-----

--------------enig49025BDEC33A66241D5CF3D4--
