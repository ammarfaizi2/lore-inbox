Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUIEHfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUIEHfo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 03:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUIEHfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 03:35:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25531 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266333AbUIEHfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 03:35:42 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Robert Love <rml@ximian.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, kay.sievers@vrfy.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1094353088.2591.19.camel@localhost>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
	 <1094142321.2284.12.camel@betsy.boston.ximian.com>
	 <20040904005433.GA18229@kroah.com>  <1094353088.2591.19.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-g7iuVps7ufSXVfMOVJLZ"
Organization: Red Hat UK
Message-Id: <1094369728.2809.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Sep 2004 09:35:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g7iuVps7ufSXVfMOVJLZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Look, I agree that unifying the two ideas and transports as much as
> possible is the right way to proceed.  But the fact is, as you said,
> transports _are_ important.  And simply always sending out a hotplug
> event _and_ a netlink event is silly and superfluous.  We need to make
> up our minds.

in addition I consider the 2 *uses* ortogonal. Hotplug historically has
been 1) reasonably heavy weight and 2) concerned with hardware changes.
General events such as say, "thermal throttling started" could of course
be munged into hotplug but to me that is something artificial.
Saying "look ma, the interfaces have the same types, so it has to be one
function" is imo the wrong thing to do. The usage is different (although
I will admit there is an overlapping area). The cost of sending a
message is different.=20

--=-g7iuVps7ufSXVfMOVJLZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBOsHAxULwo51rQBIRAhsMAJ49/toG1VUeav4GMqQY3jf0qNLAdACfXO1Q
Z/7HQXUovhMrM++XwlD3ulk=
=FvRQ
-----END PGP SIGNATURE-----

--=-g7iuVps7ufSXVfMOVJLZ--

