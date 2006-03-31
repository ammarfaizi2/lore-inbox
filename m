Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWCaQZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWCaQZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWCaQZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:25:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44978 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751401AbWCaQZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:25:54 -0500
Date: Fri, 31 Mar 2006 11:25:14 -0500
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RFC - Approaches to user-space probes
Message-ID: <20060331162514.GB22505@redhat.com>
References: <20060327065447.GA25745@in.ibm.com> <1143445068.2886.20.camel@laptopd505.fenrus.org> <20060327100019.GA30427@in.ibm.com> <1143489794.2886.43.camel@laptopd505.fenrus.org> <20060328145441.GA25465@in.ibm.com> <y0m64lye28w.fsf@ton.toronto.redhat.com> <20060331115529.GA3501@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20060331115529.GA3501@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi -

On Fri, Mar 31, 2006 at 05:25:29PM +0530, Prasanna S Panchamukhi wrote:
> [...]
> > It's pretty clear that writing the dirtied pages to disk is an
> > *undesirable* side-effect, and should be eliminated. [...]
>=20
> What would the typical situations where the text section in the
> executable is mapped with 'MAP_SHARED'?

Even if such usage is not typical, if it is legal, it may open a
vulnerability.  Imagine an unprivileged attacker doing just such an
mmap on some key shared library or executable, hoping that someone
else puts user-kprobes in there.

- FChE

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFELVfqVZbdDOm/ZT0RApSvAJ0QAX7GLz9Efu0EYiFRKtJ617x85gCfUSXW
jU/vPuF7MatJd9GdWFWNFkw=
=v2D8
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
