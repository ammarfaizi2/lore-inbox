Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269144AbUHZQTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbUHZQTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269156AbUHZQSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:18:44 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:32413 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269150AbUHZQOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:14:33 -0400
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
From: Christophe Saout <christophe@saout.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
In-Reply-To: <20040826160601.GB4326@lst.de>
References: <20040826124929.GA542@lst.de>
	 <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de>
	 <1093526273.11694.8.camel@leto.cs.pocnet.net>
	 <20040826132439.GA1188@lst.de>
	 <1093527307.11694.23.camel@leto.cs.pocnet.net>
	 <20040826134034.GA1470@lst.de>
	 <1093528683.11694.36.camel@leto.cs.pocnet.net>
	 <20040826153748.GA3700@lst.de> <1093535334.5482.1.camel@leto.cs.pocnet.net>
	 <20040826160601.GB4326@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U2ANUOr/MfUPbPSXD9E8"
Date: Thu, 26 Aug 2004 18:14:19 +0200
Message-Id: <1093536859.5482.13.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U2ANUOr/MfUPbPSXD9E8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 18:06 +0200 schrieb Christoph Hellwig:

> Again, your confusing upper and lower plugins.  For things happening
> below the pagecache you could register different address_space
> operations which sometimes makes sense.  But you want e.g. different
> inode_operations for directories vs symlinks vs files.

Ok, I see your point. aops. Sorry.
Looking at the code this could be done. The wrappers that dispatch the
operations are really small and call the plugin that is registered with
the inode of the mapping. Instead it could have directly set the
corresponding operations. Right. The wrappers are doing a few things
before calling the plugin. That could be done the other way round too.
But that's more of an implementation issue and could still be changed.

> Please read through some linux filesystem code, okay :)

I'm partly familiar with that, I just either misunderstood you or wasn't
really thinking (probably the latter...).


--=-U2ANUOr/MfUPbPSXD9E8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLgxbZCYBcts5dM0RAtCjAJ9CcjaOWXhYVEpQBGRZfu868yjQmACfQAB8
KjPKjD4K93nNEpYYAnWQGJg=
=k/8e
-----END PGP SIGNATURE-----

--=-U2ANUOr/MfUPbPSXD9E8--

