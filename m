Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTHZMNr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 08:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTHZMNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 08:13:47 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:16351 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263628AbTHZMNp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 08:13:45 -0400
Date: Tue, 26 Aug 2003 12:02:48 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, mingo@redhat.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-ID: <20030826090248.GB16407@actcom.co.il>
References: <20030825231449.7de28ba6.akpm@osdl.org> <Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com> <20030826000218.2ceaea1d.akpm@osdl.org> <1061884611.2982.4.camel@laptop.fenrus.com> <20030826080759.GK13390@actcom.co.il> <20030826012529.7be1955f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <20030826012529.7be1955f.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2003 at 01:25:29AM -0700, Andrew Morton wrote:
> Muli Ben-Yehuda <mulix@mulix.org> wrote:

> >  How about combining something that's shared to all of the threads that
> >  share a futex but not system wide (the mm?) with something simple that
> >  won't change, like the page offset?
>=20
> The mm's could well be independent.

I assumed all threads sharing a futex share an mm since you suggested
hashing on mm + vaddr? =20

> Some userspace help would be needed to avoid defeating the hash.  In the
> case where a bunch of threads with a shared mm are waiting on the same
> futex things should automatically be OK.

Userspace help would be fine, but relying only on userspace could lead
to an immediate DoS by forcing the hash to always hash to the same
bucket.
--=20
Muli Ben-Yehuda
http://www.mulix.org


--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/SyI4KRs727/VN8sRAme4AJ0ZjVDbZZFCzkHkNd2MeLDwNReQ7ACdH2o5
M8Z+iSdiNm2H2pUm9D9sgIE=
=1T0F
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
