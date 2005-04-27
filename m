Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVD0MnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVD0MnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 08:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVD0Mmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 08:42:54 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:62902 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261542AbVD0Mks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 08:40:48 -0400
Date: Wed, 27 Apr 2005 14:39:44 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@suse.cz, hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050427123944.GA11020@vagabond>
References: <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427115754.GA8981@vagabond> <E1DQla0-0001vG-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <E1DQla0-0001vG-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2005 at 14:23:48 +0200, Miklos Szeredi wrote:
> > What makes you think Pavel was talking about semantics?!
>=20
>     Well, if it brings us ugly semantics, keeping those two lines out for
>                                ^^^^^^^^^
>     a while can help merge a lot...
>=20
> > The point was that:
> > Ok, there is a strong disagreement about these two lines. Could we have
> > a patch with everything but these two lines, so it can be integrated
> > immediately to profit of the testing and generally be useful, and then
> > the controversial bits when the issue is beaten to death?
>=20
> I could remove this check.
>=20
> But it would only cause confusion.  How would the userspace utilities
> differentiate between the safe out-of-kernel and the unsafe in-kernel
> module?  Adding hacks to make this possible is far more ugly IMO than
> integrating the current well tested solution.
>=20
> It makes no sense.  If someone would give me a rational explanation
> why it is bad, I would be content.  But you just tell me it's
> terrible, ugly, crap which may well be true, but are not technical
> terms, which I can relate to.

Where the hell do you see it above. The only thing I said above is it is
controversial.

The userland tools don't need to know. They just need to not be suid.

> > As I understand it, doing things like this is butt ugly. Not just in
> > fuse -- in NFS, in samba, everywhere where such hacks are employed. But
> > now they just have enough of those hacks and want a cleaner solution.
>=20
> Please do.  I want it too.
>=20
> _When_ we have a better solution, all the hacks can be removed, and
> the world will rejoice.
>=20
> Until then, let the hacks live!  Please!

Ok, here I say it is ugly (but not that it's crap). And the reason is,
that there is a permission system, with some semantics, and then various
filesystems adapt it in varous ways to fit what they want. So every
filesystem ends up with it's onw little different behaviour.

That being said, fuse does just about the same as NFS, samba and others
and I don't really see the reason why it couldn't be integrated. But
I am not the one to decide.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCb4gQRel1vVwhjGURAunBAJ0Ybg56uPEfFWLK2eAG2iRcIIrCkQCfbs6y
tjSaFOB5BVKwlWd8R3YfcYc=
=WXHD
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
