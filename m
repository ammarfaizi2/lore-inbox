Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278359AbRJMSxg>; Sat, 13 Oct 2001 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278361AbRJMSx1>; Sat, 13 Oct 2001 14:53:27 -0400
Received: from grip.panax.com ([63.163.40.2]:33555 "EHLO panax.com")
	by vger.kernel.org with ESMTP id <S278359AbRJMSxQ>;
	Sat, 13 Oct 2001 14:53:16 -0400
Date: Sat, 13 Oct 2001 14:53:42 -0400
From: Patrick McFarland <unknown@panax.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
Message-ID: <20011013145341.R249@localhost>
In-Reply-To: <20011013141709.L249@localhost> <Pine.LNX.4.33L.0110131526500.2847-100000@imladris.rielhome.conectiva> <20011013144220.P249@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vNrHrykRFvLVX6W3"
Content-Disposition: inline
In-Reply-To: <20011013144220.P249@localhost>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux 2.4.12 i586
X-Distributed: Join the Effort!  http://www.distributed.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vNrHrykRFvLVX6W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Also, I'd like to say about the documentation...

<quote>
Currently, these files are in /proc/sys/vm:
- bdflush
- buffermem
- freepages
- kswapd
- overcommit_memory
- page-cluster
- pagecache
- pagetable_cache
</quote>

but a simple ls of /proc/sys/vm reports:
bdflush  kswapd  overcommit_memory  page-cluster  pagetable_cache

Shouldnt the documentation be updated, seeing for the fact it was written i=
n the 2.2.10 days?

On 13-Oct-2001, Patrick McFarland wrote:
> Ill reiterate something here, im on a p133 with 16 megs. Yeah, the kind o=
f the crappy ide controller that eats cpu time to swap. (Enough so that my =
mouse pointer will freeze in X that its swapping so much. Swapping is the o=
nly thing ive found that can pull that off) Swapping the least ammount woul=
d be the best for a box like that.
>=20
> On 13-Oct-2001, Rik van Riel wrote:
> > On Sat, 13 Oct 2001, Patrick McFarland wrote:
> >=20
> > > Hmm, I see that as very bad. There should be a bunch of sysctls to do
> > > that easily.
> >=20
> > See /proc/sys/vm/* and the documentation ;)
> >=20
> > > Also, I heard that 2.4 (and I'm assuming 2.2 as well) swaps pages on a
> > > last-used-age basis, instead of either a number-of-times-used or a
> > > hybrid of the two. That kinda seems stupid,
> >=20
> > Don't worry since it's not true, at least the VM in the -ac
> > kernels _does_ use a hybrid of access recency and frequency
> > to determine page replacement.
> >=20
> > The -linus kernel, however only has LRU-like selection.
> >=20
> > At the moment the -linus kernel is faster than the -ac kernel
> > for some workloads. This may have something to do with better
> > clusterable IO ... when page replacement is less precise the
> > chance that IO is clusterable is probably larger due to the
> > way we scan.
> >=20
> > I plan to do more explicit IO clustering in -ac to try and
> > remedy this difference.
> >=20
> > regards,
> >=20
> > Rik
> > --=20
> > DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers ne=
eded)
> >=20
> > http://www.surriel.com/		http://distro.conectiva.com/
> >=20
>=20
> --=20
> Patrick "Diablo-D3" McFarland || unknown@panax.com



--=20
Patrick "Diablo-D3" McFarland || unknown@panax.com

--vNrHrykRFvLVX6W3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE7yI208Gvouk7G1cURApQbAKC/S+jmYZ1uGjqgNwPFp5TH7a3wVQCfWb/0
0iACLOI7o0rY3zvq22RQsWQ=
=sG/R
-----END PGP SIGNATURE-----

--vNrHrykRFvLVX6W3--
