Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVD0JPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVD0JPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 05:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVD0JPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 05:15:24 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:26037 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261299AbVD0JPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 05:15:02 -0400
Date: Wed, 27 Apr 2005 11:14:03 +0200
From: Jan Hudec <bulb@ucw.cz>
To: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
Cc: Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       John Stoffel <john@stoffel.org>, Ville Herva <v@iki.fi>,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050427091402.GA1904@vagabond>
References: <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <17006.22498.394169.98413@smtp.charter.net> <1114528782.13568.8.camel@lade.trondhjem.org> <20050426154708.GC14297@mail.shareable.org> <426E638B.9070704@oktetlabs.ru> <20050426155615.GE14297@mail.shareable.org> <426E65E9.5070306@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <426E65E9.5070306@oktetlabs.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2005 at 20:01:45 +0400, Artem B. Bityuckiy wrote:
> Jamie Lokier wrote:
> >No.  Why would you block?  You can have transactions without blocking
> >other processes.
> >
> >When updating, say, the core-utils package (which contains cat),
> >there's no reason why a program which executes "cat" should have to
> >block during the update.  It can simply execute the old one until the
> >new one is committed at the end of the update.
> >
> >It's analogous to RCU for protecting kernel data structures without
> >blocking readers.
> >
> Hmm, can't we implement a user-space locking system which admits of=20
> readers during transactions? I gues we can.

The problem with implementing in userland, as was already said in the
thread, is, that if some process does not use the library, it can
completely mess it up. It is only safe in kernel.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCb1faRel1vVwhjGURAuKzAKDAn6YyOhPAPFTexM9OyFkwfPv46QCfWezt
b7y7zyxeuOakqmo0xCN2+ik=
=bnoE
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
