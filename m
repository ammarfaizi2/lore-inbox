Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWBQC7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWBQC7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 21:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWBQC7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 21:59:03 -0500
Received: from threatwall.zlynx.org ([199.45.143.218]:5074 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S1751329AbWBQC7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 21:59:02 -0500
Subject: Re: Wrong number of core_siblings in sysfs for Athlon64 X2
From: Zan Lynx <zlynx@acm.org>
To: Andi Kleen <ak@suse.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <200602170318.15511.ak@suse.de>
References: <9a8748490602161346x6e2802e8r4edf7dcbdafa5e17@mail.gmail.com>
	 <9a8748490602161408i736a7ab3vef09f3e1c95916fe@mail.gmail.com>
	 <1140142257.29021.31.camel@localhost>  <200602170318.15511.ak@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6uFaJ0icieqFL1Du4HNk"
Date: Thu, 16 Feb 2006 19:58:57 -0700
Message-Id: <1140145137.29021.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6uFaJ0icieqFL1Du4HNk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-02-17 at 03:18 +0100, Andi Kleen wrote:
> On Friday 17 February 2006 03:10, Zan Lynx wrote:
>=20
> > It seems to me that this could be confusing for a lot of people who are
> > casually browsing through sysfs.  Why not name core_siblings something
> > like core_sibling_bitmap?=20
>=20
> Because it's already a fixed ABI that is put in stone.

Hardly "fixed in stone."  I checked before making the suggestion to
change it, the topology sysfs entries are only in 2.6.16-rc kernels, so
they've never been released in an official mainline kernel.  Fixed in
clay that hasn't been fired yet, perhaps.  Maybe by -rc3 it's already
baking in the kiln, but its still changeable.

> The only way to do what you want would be to add a new field
> and keep the old one alone, but frankly your rationale for=20
> it ("could be confusing to someone") doesn't seem convincing enough=20
> for such a thing.  Especially since each sysfs field can
> cost considerable memory when a dentry and a inode have to be allocated
> for it.

Now is hardly the time to worry about efficiency in sysfs.  It's already
a maze of twisty symlinks.  And the whole rationale of sysfs is easy
shell-tool access to kernel data about the system. =20

> I guess if you worry about such people a better way to help
> them would be to write them a frontend that displays
> the information in there in nice form.

Nice frontends processing efficient but hard to read data would be best
implemented in binary through netlink or system calls where there would
be no need to format to text, create an inode, then have userspace open
directories, follow links, open a file, read it, parse it BACK into
binary, etc. =20

So obviously efficiency isn't a primary sysfs consideration.  That would
leave ... ease of use? :-)

Your two objections aren't convincing to me, but I don't suppose it
matters since I don't have a major interest in the topology code or how
it works.  So continue on!  It was only a helpful suggestion.
--=20
Zan Lynx <zlynx@acm.org>

--=-6uFaJ0icieqFL1Du4HNk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD9TvxG8fHaOLTWwgRArSLAKCPnr4nmYoj6ji4MLY+f2FdpJCDegCglC8a
fXJayUD3DRtKDdQSTOsj0so=
=HCf3
-----END PGP SIGNATURE-----

--=-6uFaJ0icieqFL1Du4HNk--

