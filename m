Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263939AbUEMIQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbUEMIQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 04:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbUEMIQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 04:16:46 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:49836 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S263939AbUEMIQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 04:16:43 -0400
Date: Thu, 13 May 2004 11:05:17 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Gibson <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Adam Litke <agl@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>
Subject: Re: More convenient way to grab hugepage memory
Message-ID: <20040513080517.GA13972@mulix.org>
References: <20040513055520.GF27403@zax> <20040513060549.GA12695@mulix.org> <20040513065912.GR1397@holomorphy.com> <1084432141.13731.99.camel@gaston> <20040513071359.GU1397@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20040513071359.GU1397@holomorphy.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2004 at 12:13:59AM -0700, William Lee Irwin III wrote:
> On Thu, 2004-05-13 at 16:59, William Lee Irwin III wrote:
> >> Atop my other patch to nuke the unused global variables, here is a pat=
ch
> >> to manually inline __do_mmap_pgoff(), removing the inline usage. Untes=
ted.
> >> Are you sure you want this? #ifdef'ing out the hugetlb case is somewhat
> >> more digestible with the inline in place, e.g.:
>=20
> On Thu, May 13, 2004 at 05:09:01PM +1000, Benjamin Herrenschmidt wrote:
> > Well, I did the breakup in 2 pieces in the first place for 2 reasons:
> >  - the original patch had some subtle issues with accounting
> >  - do_mmap_pgoff is already such a mess, let's not make it worse
> > I mean, it's awful to get anything right in this function, especially
> > the cleanup/exit path, which is why I think it's more maintainable
> > cut in 2.
>=20
> Well, writing it vaguely convinced me that it wasn't a great idea; I
> suppose now that Muli can look at the result he'll be convinced
> likewise.

No need to convince me; my comment was strictly with regards to
inlining the function (as opposed to just leaving it static), not with
regards to splitting up the messy horror that is do_mmap_pgoff, which
I am very much in favor of.

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoyw9KRs727/VN8sRAshdAJ9ExrqKHuH4ll5d5mPQJmRhgt5DTQCgrd3U
UdDyOTMOXrswLM2Rfn+bGzw=
=vMlm
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
