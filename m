Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265168AbUGHWlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbUGHWlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUGHWlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:41:36 -0400
Received: from zlynx.org ([199.45.143.209]:5382 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S265170AbUGHWlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:41:24 -0400
Subject: Re: GCC 3.4 and broken inlining.
From: Zan Lynx <zlynx@acm.org>
To: ncunningham@linuxmail.org
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1089324043.3098.3.camel@nigel-laptop.wpcb.org.au>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au>
	 <20040708120719.GS21264@devserv.devel.redhat.com>
	 <1089288664.2687.23.camel@nigel-laptop.wpcb.org.au>
	 <200407090036.39323.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1089324043.3098.3.camel@nigel-laptop.wpcb.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mEHhHb22II3g6S9TUgvy"
Message-Id: <1089326491.22042.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 08 Jul 2004 16:41:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mEHhHb22II3g6S9TUgvy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-08 at 16:00, Nigel Cunningham wrote:
> On Fri, 2004-07-09 at 07:36, Denis Vlasenko wrote:
> > It was decided to #define inline so that it means always_inline for lk.
> > Dunno why include/linux/compiler-gcc3.h stopped doing that
> > specifically for gcc 3.4...
>=20
> I tried getting it to use the always_inline definition for gcc 3.4. It
> resulted in the compilation failing in a number of places. The fixes
> were generally trivial, involving rearranging the contents of files so
> that inline function bodies appear before routines calling them, or
> removing the inline where this isn't possible. IMHO, this is what should
> be done. I didn't complete the changes, however: I thought I'd try for a
> simpler solution, just in case I'm wrong.

I believe that just adding -funit-at-a-time as a compile option solves
the problems with inline function body ordering.
--=20
Zan Lynx <zlynx@acm.org>

--=-mEHhHb22II3g6S9TUgvy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7c2bG8fHaOLTWwgRAkUtAJ9uu6FMH9kHwLANp17Jz9lRJb/JGwCfZkBk
1CKwOtY749adNqsCI/hrKpY=
=ZrtX
-----END PGP SIGNATURE-----

--=-mEHhHb22II3g6S9TUgvy--

