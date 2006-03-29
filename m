Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWC2Njd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWC2Njd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWC2Njd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:39:33 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:16576 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1750703AbWC2Njc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:39:32 -0500
Date: Thu, 30 Mar 2006 00:39:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: apgo@patchbomb.org (Arthur Othieno)
Cc: sam@ravnborg.org, psmith@gnu.org, linux-kernel@vger.kernel.org,
       stable@kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] change kbuild to not rely on incorrect GNU make
 behavior
Message-Id: <20060330003927.1db023b5.sfr@canb.auug.org.au>
In-Reply-To: <20060329131501.GA8537@krypton>
References: <E1FG1UQ-00045B-5P@fencepost.gnu.org>
	<20060305231312.GA25673@mars.ravnborg.org>
	<20060329131501.GA8537@krypton>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__30_Mar_2006_00_39_27_+1100_q=cKnk.tTWyv5eBl"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__30_Mar_2006_00_39_27_+1100_q=cKnk.tTWyv5eBl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Mar 2006 08:15:01 -0500 apgo@patchbomb.org (Arthur Othieno) wrot=
e:
>
> Sam, this was merged into Linus' tree post v2.6.16 (like you intended),
> but, won't the window between now and 2.6.17 be a little too big for such
> a fix? Debian etch (and sid) already ships with the affected make version:
>=20
>   $ make -v | head -1
>   GNU Make 3.81rc1
>=20
> Now, this patch re-based against 2.6.16 is still too big for -stable
> (~830 lines plus context). I'm Cc'ing -stable team here for comments, and
> also because this will continue to bite between -stable releases. Should
> they decide to pick it up, I'll post re-based version as a reply.

You should note this changelog entry from Debian sid:

make-dfsg (3.80+3.81.rc2-1) unstable; urgency=3Dlow

  * New upstream release candidate.
  * Bug fix: "Make always recompiles everything in the Linux Kernel.",
    thanks to Neil Brown. This is really a bug in the kernel build system,
    not make. However, this release defers the change so as not to trigger
    the bug.                                      (Closes: #356552, #356630=
).

 -- Manoj Srivastava <srivasta@debian.org>  Mon, 20 Mar 2006 15:37:15 -0600

So that the make in sid is no longer affected and (hopefully) this version =
will
make its way into etch soon.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__30_Mar_2006_00_39_27_+1100_q=cKnk.tTWyv5eBl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEKo4PFdBgD/zoJvwRAs45AJ9IDS7xZSYxs8YCZL2DVs/E89W6AgCgifbA
U9nChC56vuoPsU5NdZ61Bm4=
=sQmW
-----END PGP SIGNATURE-----

--Signature=_Thu__30_Mar_2006_00_39_27_+1100_q=cKnk.tTWyv5eBl--
