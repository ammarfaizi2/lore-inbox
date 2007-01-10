Return-Path: <linux-kernel-owner+w=401wt.eu-S964952AbXAJSP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbXAJSP5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 13:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbXAJSP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 13:15:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45099 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964952AbXAJSP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 13:15:56 -0500
Message-ID: <45A52D2A.2030300@redhat.com>
Date: Wed, 10 Jan 2007 10:15:06 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Pierre Peiffer <pierre.peiffer@bull.net>
CC: Jakub Jelinek <jakub@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2.6.20-rc4 1/4] futex priority based wakeup
References: <45A3B330.9000104@bull.net> <45A3BFC8.1030104@bull.net> <45A3C2CE.7070500@redhat.com> <45A4D249.8080904@bull.net> <20070110125416.GW29911@devserv.devel.redhat.com> <45A500CC.3030408@bull.net>
In-Reply-To: <45A500CC.3030408@bull.net>
X-Enigmail-Version: 0.94.1.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5581E770121F0DA7897A3615"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5581E770121F0DA7897A3615
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pierre Peiffer wrote:
> But there can be a performance impact when several processes use
> different futexes which have the same hash key.
> In fact, the plist contains all waiters _of_all_futexes_ having the sam=
e
> hash key, not only the waiters of a given futex. This can be more a
> problem,

s/can be/is/

There are systems with thousands of active futexes, maybe tens of
thousands.  Not only is hash collision likely, it's also a matter of
using and administering the plist.  We have to make futexes less
connected, not more.  Now I definitely want to see real world tests first=
=2E

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig5581E770121F0DA7897A3615
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFpS0q2ijCOnn/RHQRAucdAJ0XWtfzlus7pk3nGFG7IlqMNX3HHACeOtIz
jWR6oFWxteCcqzYXpnW0JDo=
=1EE6
-----END PGP SIGNATURE-----

--------------enig5581E770121F0DA7897A3615--
