Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVF0JSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVF0JSh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVF0JSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:18:37 -0400
Received: from nysv.org ([213.157.66.145]:34693 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261965AbVF0JS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:18:26 -0400
Date: Mon, 27 Jun 2005 12:18:08 +0300
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050627091808.GC11013@nysv.org>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com> <1119609680.17066.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="edESjMboOAwUFn6i"
Content-Disposition: inline
In-Reply-To: <1119609680.17066.81.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--edESjMboOAwUFn6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 24, 2005 at 11:41:21AM +0100, Alan Cox wrote:
>
>More fundamentally - prototype things *out* of the main kernel. If
>everyone was doing their prototyping in kernel Andrew Morton would by
>now be a team of about 25

This is going semi off-topic but how then do you justify regression
that's apparently confessed? :)

It appears -mm is more of a prototype tree than a development tree;
I remember Con Kolivas cursing (with SMP nice support) that the
interface is too lively to keep supporting one patch. Unfortunately
I can't find the original post I'm thinking about but
http://lkml.org/lkml/2005/5/16/68 says essentially the same thing.

There's also my all-time favorite, http://lkml.org/lkml/2005/3/14/4

The lack of QA seems appalling here, and I'm sure Reiser has had
to do more of that for DARPA than most linux kernel hackers around.

What I'm saying here is isn't it a bit hypocritic to ramble on that
we need real assurances for this to work, community proof and bugfixes
on the list mean nothing, when other core systems seem to be much
looser in this respect?

Sure, "other people merge design-breakers and bugs" is NOT a justification
for merging Reiser4, of course, but Reiser4's track record has vastly
cleaned itself up.

Most bug reports come from broken hardware or unsupported patches or
old code. Just have Namesys swear they won't introduce design changes
until the userland utils are available, and won't do it at all after
EXPERIMENTAL has been removed.
They already did this with changes that require mkfs :>

Here's a real suggestion, for LKML et al, dropping the sarcastic mode.

0. Namesys addresses the code beautification reqs mentioned here earlier.

1. Merge Reiser4 sans metas into 2.6.13.
2. Namesys can have a separate metas patch for testing.
3. Gradually merge Reiser4 architecture into VFS and if this really
   requires a 2.7, as (iirc) Valdis Kletnieks suggested, make it so.
   Might do the rest of the kernel some good too.

The above is a lame compromise; I'd much rather have the meta system
in, as is dropping the stupid name, ..metas/ is better, and dropping "meta
files can have meta data, ie. endless recursion in ..metas/

Then it can be merged into the VFS as needed, but if there truly are issues=
=20
left, I realize it can't probably be fixed fast enough.

Having metas on by default probably leads to a lot of bug reports,
which get fixed, and at the same time makes VFS-merging easier,
when metas-related bug issues are fixed in VFS.

My two grumpy cents.

--=20
mjt


--edESjMboOAwUFn6i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCv8RQIqNMpVm8OhwRAmCaAJ9qz7uok+3blFUX+SKsRAQgkn0l/wCdFk7F
J/e803o8aZYf6Xk7kJ2TLRk=
=qQAV
-----END PGP SIGNATURE-----

--edESjMboOAwUFn6i--
