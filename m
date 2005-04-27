Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVD0MAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVD0MAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 08:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVD0MAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 08:00:36 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:49846 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261489AbVD0MAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 08:00:24 -0400
Date: Wed, 27 Apr 2005 13:57:54 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@suse.cz, hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050427115754.GA8981@vagabond>
References: <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2005 at 12:42:04 +0200, Miklos Szeredi wrote:
> > > This is the controversial part in all it's glory:
> > >=20
> > > 	if (!(fc->flags & FUSE_ALLOW_OTHER) && current->fsuid !=3D fc->user_=
id)
> > > 		return -EACCES;
> > >=20
> > > Leaving it out would gain us what exactly?
> >=20
> > Well, if it brings us ugly semantics, keeping those two lines out for
> > a while can help merge a lot...
>=20
> To the mount owner the semantics are quite normal.  Others will be
> denied access to the mountpoint, which doesn't introduce any new
> semantics either.

What makes you think Pavel was talking about semantics?!

The point was that:
Ok, there is a strong disagreement about these two lines. Could we have
a patch with everything but these two lines, so it can be integrated
immediately to profit of the testing and generally be useful, and then
the controversial bits when the issue is beaten to death?

So, please, could you send a stripped-down version, that is not safe for
mounting by users, but can be tested for many cases where that is
sufficient?

> If you look at it from the POV of _any_ process, there are NO NEW
> SEMANTICS.  Nothing that programs, scripts or anything has to be
> modified for.  Nothing that could cause _any_ problems later, if this
> check was removed.
>=20
> Prove me wrong!

As I understand it, doing things like this is butt ugly. Not just in
fuse -- in NFS, in samba, everywhere where such hacks are employed. But
now they just have enough of those hacks and want a cleaner solution.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCb35CRel1vVwhjGURApqsAKDv4ro7NEKrI2CCT7kNU8Y29EmbOQCfeMmV
mOz00Q5hxBXtxctkvIM1NEc=
=SjGs
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
