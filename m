Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVBBEbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVBBEbT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 23:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVBBEbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 23:31:19 -0500
Received: from zlynx.org ([199.45.143.209]:61192 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S261260AbVBBEbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 23:31:15 -0500
Subject: Re: [PATCH 2/8] lib/sort: Replace qsort in XFS
From: Zan Lynx <zlynx@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42000122.90104@osdl.org>
References: <6.416337461@selenic.com> <7.416337461@selenic.com>
	 <5.416337461@selenic.com> <6.416337461@selenic.com>
	 <3.416337461@selenic.com> <4.416337461@selenic.com>
	 <2.416337461@selenic.com> <3.416337461@selenic.com>
	 <20050201222915.GA9285@taniwha.stupidest.org>  <42000122.90104@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Sq+CYX+x/qdWr/psdw8r"
Date: Tue, 01 Feb 2005 21:31:13 -0700
Message-Id: <1107318673.15928.68.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Sq+CYX+x/qdWr/psdw8r
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-02-01 at 14:22 -0800, Randy.Dunlap wrote:
> Chris Wedgwood wrote:
> > On Mon, Jan 31, 2005 at 01:34:59AM -0600, Matt Mackall wrote:
> >=20
> >=20
> >>+#define qsort xfs_sort
> >>+static inline void xfs_sort(void *a, size_t n, size_t s,
> >>+			int (*cmp)(const void *,const void *))
> >>+{
> >>+	sort(a, n, s, cmp, 0);
> >>+}
> >>+
> >=20
> >=20
> > why not just:
> >=20
> > #define qsort(a, n, s, cmp)	sort(a, n, s, cmp, NULL)
> >=20
> >=20
> >=20
> > On Mon, Jan 31, 2005 at 01:35:00AM -0600, Matt Mackall wrote:
> >=20
> >=20
> >>Switch NFS ACLs to lib/sort
> >=20
> >=20
> >>+	sort(acl->a_entries, acl->a_count, sizeof(struct posix_acl_entry),
> >>+	     cmp_acl_entry, 0);
> >=20
> >=20
> > There was a thread about stlye and I though the concensurs for null
> > pointers weas to use NULL and not 0?
>=20
> Yes, otherwise sparse complains... and maybe Linus  :)

And you get in the habit of using 0 instead of NULL and before you know
it you've used it in a variable argument list for a GTK library call on
an AMD64 system and corrupted the stack. :-)

(The compiler can't convert 0 to a pointer if it doesn't know that it's
supposed to be one.  Variable argument lists are evil that way.)

--=20
Zan Lynx <zlynx@acm.org>

--=-Sq+CYX+x/qdWr/psdw8r
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCAFeRG8fHaOLTWwgRAld/AJwJsgr12hU6ahhdknqjK6S3z29YSgCeJyBY
m+/xOH1oTn7lwjqeS38VTjg=
=oklz
-----END PGP SIGNATURE-----

--=-Sq+CYX+x/qdWr/psdw8r--

