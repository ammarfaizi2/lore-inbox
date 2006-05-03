Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWECBpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWECBpl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 21:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWECBpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 21:45:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18322 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965066AbWECBpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 21:45:40 -0400
Message-ID: <44580B10.2000205@redhat.com>
Date: Tue, 02 May 2006 18:44:48 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Val Henson <val.henson@intel.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
References: <20060430172953.409399000@zion.home.lan> <1146565266.32045.29.camel@laptopd505.fenrus.org> <200605030226.28047.blaisorblade@yahoo.it>
In-Reply-To: <200605030226.28047.blaisorblade@yahoo.it>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD83C663E2910DB07ECD2DAEF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD83C663E2910DB07ECD2DAEF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Blaisorblade wrote:
>> I've not seen much of this if any at all, the various caches that are =
in
>> place for these lookups seem to function quite well; what we did see w=
as
>> glibc's malloc implementation being mistuned resulting in far too many=

>> mmaps than needed (which in turn leads to far too much page zeroing
>> which is the really expensive part. It's not the vma lookup that is
>> expensive, it's the page zeroing)
> Even to this email, I hope Ulrich will answer.

All I can say is that some of our guys tuning a big application on a
customer's site reported seeing the VMA lookups being on the profile
list.  This was some huge Java program.  It might be that every other
page had a different protection, executable or not, read-only mmap etc.
 And data access for very non-local.

I cannot say more since this was near to the end of the trials.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigD83C663E2910DB07ECD2DAEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEWAsQ2ijCOnn/RHQRAsvDAKCu+MTajeFuKjHBu+0sJwen3PC8XwCfSxsf
oVR5Xin+kflIel9RSO4aRjs=
=40aS
-----END PGP SIGNATURE-----

--------------enigD83C663E2910DB07ECD2DAEF--
