Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIPtQ>; Tue, 9 Jan 2001 10:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbRAIPtG>; Tue, 9 Jan 2001 10:49:06 -0500
Received: from ns.snowman.net ([63.80.4.34]:42509 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S129324AbRAIPs4>;
	Tue, 9 Jan 2001 10:48:56 -0500
Date: Tue, 9 Jan 2001 10:48:00 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, hch@caldera.de,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109104800.R26953@ns>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Rik van Riel <riel@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, hch@caldera.de,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010109102525.Q26953@ns> <Pine.LNX.4.30.0101091638130.4491-100000@e2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="znxST63EDyM/OAm8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101091638130.4491-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 04:40:46PM +0100
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 10:42am  up 145 days, 14:28,  6 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--znxST63EDyM/OAm8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Ingo Molnar (mingo@elte.hu) wrote:
>=20
> On Tue, 9 Jan 2001, Stephen Frost wrote:
>=20
> > 	Now, the interesting bit here is that the processes can grow to be
> > pretty large (200M+, up as high as 500M, higher if we let it ;) ) and w=
hat
> > happens with MOSIX is that entire processes get sent over the wire to
> > other machines for work.  MOSIX will also attempt to rebalance the load=
 on
> > all of the machines in the cluster and whatnot so it can often be moving
> > processes back and forth.
>=20
> then you'll love the zerocopy patch :-) Just use sendfile() or specify
> MSG_NOCOPY to sendmsg(), and you'll see effective memory-to-card
> DMA-and-checksumming on cards that support it.

	Excellent, this patch certainly sounds interesting which is why
I've been following this discussion.  Once the MOSIX patch for 2.4 comes
out I think I'm going to tinker with this and see if I can get MOSIX to
use these methods.

> the discussion with Stephen is about various device-to-device schemes.
> (which Mosix i dont think wants to use. Mosix wants to use memory to
> device zero-copy, right?)

	Yes, very much so actually now that I think about it.  Alot of
memory->device and device->memory work going on.  I was mainly replying
to the idea of clustering since that's what MOSIX is all about.


		Stephen

--znxST63EDyM/OAm8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6WzKwrzgMPqB3kigRAlkxAJ95LQoPFn9t0rxpT4cHlGNyt3ToCQCdG58i
yvQlMGYSS7HhAkBeSHG+tgY=
=gIcs
-----END PGP SIGNATURE-----

--znxST63EDyM/OAm8--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
