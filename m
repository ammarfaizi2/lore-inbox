Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757365AbWKWNM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbWKWNM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933670AbWKWNM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:12:27 -0500
Received: from systemlinux.org ([83.151.29.59]:64132 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S933669AbWKWNMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:12:25 -0500
Date: Thu, 23 Nov 2006 14:08:17 +0100
From: Andre Noll <maan@systemlinux.org>
To: Mel Gorman <mel@skynet.ie>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Message-ID: <20061123130817.GJ27761@skl-net.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de> <200611221142.21212.ak@suse.de> <20061122155233.GA30607@skynet.ie> <20061122174223.GE27761@skl-net.de> <20061123120141.GA20920@skynet.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3bvv0EcKsvvYeex"
Content-Disposition: inline
In-Reply-To: <20061123120141.GA20920@skynet.ie>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3bvv0EcKsvvYeex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12:01, Mel Gorman wrote:

> > > Andre, if the bug still exists for you, can you apply Andi's patch to
> > > reduce the log size and the following patch please and post us the
> > > output with loglevel=3D8 please? Thanks
> >=20
> > Done. Here's the output of dmesg with your and Andi's patch applied.
> >
>=20
> ahhh, I believe I see the problem now. Please try out the following patch.

[...]

> This patch sorts the early_node_map in find_min_pfn_for_node(). It has
> been boot tested on x86, x86_64, ppc64 and ia64.

That did the trick, you're the man!

Thanks a lot
Andre

--=20
The only person who always got his work done by Friday was Robinson Crusoe

--u3bvv0EcKsvvYeex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFZZ1BWto1QDEAkw8RAi2tAJ9LW3VAI7ffFdeBivvv8JHII5xOzgCcCokz
td+KFW7Lzvur1ij9HfkUW8k=
=RxfS
-----END PGP SIGNATURE-----

--u3bvv0EcKsvvYeex--
