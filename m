Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUDOB0B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 21:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUDOBZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 21:25:55 -0400
Received: from ozlabs.org ([203.10.76.45]:21194 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262518AbUDOBZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 21:25:46 -0400
Date: Thu, 15 Apr 2004 11:23:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, lse-tech@lists.sourceforge.net,
       raybry@sgi.com, "'Andy Whitcroft'" <apw@shadowen.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: hugetlb demand paging patch part [0/3]
Message-ID: <20040415012345.GA24941@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Arjan van de Ven <arjanv@redhat.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	lse-tech@lists.sourceforge.net, raybry@sgi.com,
	'Andy Whitcroft' <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
References: <200404132317.i3DNH4F21162@unix-os.sc.intel.com> <1081933442.4688.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <1081933442.4688.6.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2004 at 11:04:02AM +0200, Arjan van de Ven wrote:
> On Wed, 2004-04-14 at 01:17, Chen, Kenneth W wrote:
> > In addition to the hugetlb commit handling that we've been working on
> > off the list, Ray Bryant of SGI and I are also working on demand paging
> > for hugetlb page.  Here are our final version that has been heavily
> > tested on ia64 and x86.  I've broken the patch into 3 pieces so it's
> > easier to read/review, etc.
>=20
> Ok I think it's time to say "HO STOP" here.
>=20
> If you're going to make the kernel deal with different, concurrent page
> sizes then please do it for real. Or alternatively leave hugetlb to be
> the kludge/hack it is right now. Anything inbetween is the road to
> madness...

Well, bear in mind that in a number of ways these patches actually
simplify the hugetlb code, although I think most of that is not
inherently related to making the hugepage allocation on-demand rather
than prefaulted.  Nonetheless, doing the demand allocation is actually
really easy.  Even if you add COW as well, which these patches don't,
it doesn't actually make the hack any worse than it was already, but
it does make it more useful.

--=20
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfeQhaILKxv3ab8YRAiWnAJ9Ci0aqAqAL1kIaUrifvugY5hwjMwCfXXWg
2tJdGbSGhecUD/9XjwCkpYE=
=Adqz
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
