Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTJAOmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJAOmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:42:00 -0400
Received: from smtp2.actcom.co.il ([192.114.47.15]:51846 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S261974AbTJAOl4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:41:56 -0400
Date: Wed, 1 Oct 2003 17:41:43 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Dave Jones <davej@redhat.com>, Matthew Wilcox <willy@debian.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_* In Comments Considered Harmful
Message-ID: <20031001144143.GG29313@actcom.co.il>
References: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk> <20031001141950.GA13115@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uWFPrswxdEczfxSh"
Content-Disposition: inline
In-Reply-To: <20031001141950.GA13115@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uWFPrswxdEczfxSh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2003 at 03:19:52PM +0100, Dave Jones wrote:

> Maybe it should be taught to parse comments? There are zillions of
> #endif /* CONFIG_FOO */
> braces in the tree. Why is this one special ?

I wondered the same, until I noticed:=20

 #if defined(WANT_PAGE_VIRTUAL)=20
             ^^^^^^^^^^^^^^^^^
        void *virtual;                  /* Kernel virtual address  (NULL if
                                           not kmapped, ie. highmem) */
 #endif /* CONFIG_HIGMEM || WANT_PAGE_VIRTUAL */
           ^^^^^^^^^^^^^    ^^^^^^^^^^^^^^^^^

the #defined check is on WANT_PAGE_VIRTUAL only - the script tripped
over CONFIG_HIGMEM, which is in the #endif only.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--uWFPrswxdEczfxSh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/euenKRs727/VN8sRAn4NAKCkF36avYZKskeixm2TvYfQ1QR93QCfSeJO
qnEf0NVZSwaZId9PHHvxYSs=
=NJqP
-----END PGP SIGNATURE-----

--uWFPrswxdEczfxSh--
