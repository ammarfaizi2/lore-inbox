Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbTJAUQB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 16:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTJAUQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 16:16:01 -0400
Received: from smtp2.actcom.co.il ([192.114.47.15]:22479 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S262304AbTJAUP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 16:15:59 -0400
Date: Wed, 1 Oct 2003 23:15:53 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] CONFIG_* In Comments Considered Harmful
Message-ID: <20031001201552.GR729@actcom.co.il>
References: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk> <20031001143959.GI31698@wohnheim.fh-wedel.de> <20031001145206.GH29313@actcom.co.il> <20031001151011.GL31698@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="De7JZ5cYyW/PeqB+"
Content-Disposition: inline
In-Reply-To: <20031001151011.GL31698@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--De7JZ5cYyW/PeqB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2003 at 05:10:11PM +0200, J?rn Engel wrote:

> > > --- a/include/linux/mm.h	28 Sep 2003 04:06:20 -0000	1.5
> > > +++ b/include/linux/mm.h	1 Oct 2003 13:15:53 -0000
> > > @@ -196,7 +196,7 @@ struct page {
> > >  #if defined(WANT_PAGE_VIRTUAL)
> > >  	void *virtual;			/* Kernel virtual address (NULL if
> > >  					   not kmapped, ie. highmem) */
> > > -#endif /* CONFIG_HIGMEM || WANT_PAGE_VIRTUAL */
> > > +#endif /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
> > >  };
> >=20
> > This is broken, the CONFIG_HIG(H)MEM shouldn't be there at all. Look
> > at the #if defined(...) line.=20

[snipped]=20

Looks like this patch made it past Linus's famous patch barriers and
into the bk tree after all. J?rn, I trust you'll send a patch to
revert it? (Linus, if you want to fix it by hand, just deleted the
CONFIG_HIGHMEM bit completely from the #endif line).
--=20
Muli Ben-Yehuda
http://www.mulix.org


--De7JZ5cYyW/PeqB+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ezX4KRs727/VN8sRAmhsAJsFwo78uiPpkAo6jK+a79IbBE3mPgCgty4u
LLkipm49Bh23NlWWi7pLFu0=
=t1qN
-----END PGP SIGNATURE-----

--De7JZ5cYyW/PeqB+--
