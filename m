Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVIBOGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVIBOGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVIBOGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:06:54 -0400
Received: from ciistr1.ist.utl.pt ([193.136.128.1]:14803 "EHLO
	ciistr1.ist.utl.pt") by vger.kernel.org with ESMTP id S1751332AbVIBOGy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:06:54 -0400
From: Pedro Venda <pjvenda@arrakis.dhis.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: [PATCH][RFC] vm: swap prefetch
Date: Fri, 2 Sep 2005 15:01:25 +0000
User-Agent: KMail/1.8.2
Cc: Con Kolivas <kernel@kolivas.org>, Hans Kristian Rosbach <hk@isphuset.no>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200509012346.33020.kernel@kolivas.org> <1125584303.25400.3.camel@linux> <200509020018.32993.kernel@kolivas.org>
In-Reply-To: <200509020018.32993.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2398119.xTDFrh9hZ7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509021501.29505.pjvenda@arrakis.dhis.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2398119.xTDFrh9hZ7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 01 September 2005 14:18, Con Kolivas wrote:
> On Fri, 2 Sep 2005 00:18, Hans Kristian Rosbach wrote:
> > On Thu, 2005-09-01 at 23:46 +1000, Con Kolivas wrote:
> > > Here is a working swap prefetching patch for 2.6.13. I have
> > > resuscitated and rewritten some early prefetch code Thomas Schlichter
> > > did in late 2.5 to create a configurable kernel thread that reads in
> > > swap from ram in reverse order it was written out. It does this once
> > > kswapd has been idle for a minute (implying no current vm stress). Th=
is
> > > patch attached below is a rollup of two patches the current versions =
of
> > > which are here:

> > That said, I have often thought it might be good to have something like
> > pre-writing swap, ie reverse what your patch does.
> >
> > In other words it'd keep as much of swappable data on disk as possible,
> > but without removing it from memory. So when it comes time to free up
> > some memory, the data is already on disk so no performance penalty from
> > writing it out.

both ideas make all the sense to me. I'll give it a try, but in what way ca=
n=20
we test this kind of enhancement? maybe write a small program that starts=20
fills a good part of swap space and then, after 1min idle, 'watch free -m'=
=20
should show free memory decreasing (not counting cache/buffers) with idle=20
activity. decent?

about the Hans's proposal - it would increase power consumption, because of=
=20
increased disk activity. about con's swap prefetch, I'm not so sure...

regards,
pedro venda.
=2D-=20

Pedro Jo=E3o Lopes Venda
email: pjvenda < at > arrakis.dhis.org
http://arrakis.dhis.org

--nextPart2398119.xTDFrh9hZ7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDGGlJeRy7HWZxjWERAuy7AKDyFaCUJRCtrXZgFM0pQf/+JWcbzwCguXtV
uSR+OnoFbo6BXcCIMqPk7GI=
=0FpG
-----END PGP SIGNATURE-----

--nextPart2398119.xTDFrh9hZ7--
