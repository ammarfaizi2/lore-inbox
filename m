Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWBHXql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWBHXql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWBHXql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:46:41 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:28565 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1422644AbWBHXqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:46:40 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Dynamically allocated pageflags
Date: Thu, 9 Feb 2006 09:43:21 +1000
User-Agent: KMail/1.9.1
Cc: "linux-mm" <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <200602022111.32930.ncunningham@cyclades.com> <200602021431.30194.ak@suse.de>
In-Reply-To: <200602021431.30194.ak@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1322261.PFn1ScY5Cy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602090943.25550.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1322261.PFn1ScY5Cy
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 23:31, Andi Kleen wrote:
> On Thursday 02 February 2006 12:11, Nigel Cunningham wrote:
> > Hi everyone.
> >=20
> > This is my latest revision of the dynamically allocated pageflags patch.
> >=20
> > The patch is useful for kernel space applications that sometimes need t=
o flag
> > pages for some purpose, but don't otherwise need the retain the state. =
A prime
> > example is suspend-to-disk, which needs to flag pages as unsaveable, al=
located
> > by suspend-to-disk and the like while it is working, but doesn't need to
> > retain any of this state between cycles.
>=20
> It looks like total overkill for a simple problem to me. And is there rea=
lly
> any other user of this other than swsusp?

Sorry for the slow response. I switched email clients and gained a bogus
filter along the way (entirely my fault, of course).

As Dave said, he might make use of them too. I use about 5 or 6 of these,
depending upon exactly how Suspend2 is configured.

In the meanwhile, AKPM gave me a suggestion for a better solution
(radix-trees). My algorithms & data-structures course was 14 years ago,
so I'll go dust off Kingston (IIRC) and learn what he's talking about again=
 :)

Thanks for the feedback and regards,

Nigel

--nextPart1322261.PFn1ScY5Cy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6oIdN0y+n1M3mo0RAlEcAJ90Z50N05zRpayBvEN8kigs1ctAGgCgn0dv
EaIQmZfFLw0FLtNvlO0u1/Q=
=XGBJ
-----END PGP SIGNATURE-----

--nextPart1322261.PFn1ScY5Cy--
