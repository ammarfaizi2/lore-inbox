Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUJNAT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUJNAT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 20:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269798AbUJNATZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 20:19:25 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:21148 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266263AbUJNATN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 20:19:13 -0400
Date: Thu, 14 Oct 2004 02:16:19 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: single linked list header in kernel?
Message-ID: <20041014001619.GA19436@thundrix.ch>
References: <416C1F48.4040407@nortelnetworks.com> <pan.2004.10.13.05.50.46.937470@smurf.noris.de> <416D4255.9080501@nortelnetworks.com> <pan.2004.10.13.18.25.41.367757@smurf.noris.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <pan.2004.10.13.18.25.41.367757@smurf.noris.de>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Wed, Oct 13, 2004 at 08:25:43PM +0200, Matthias Urlichs wrote:
> I dunno, though -- open-coding a singly-linked list isn't that much of a
> problem; compared to a doubly-linked one, there's simply fewer things that
> can go horribly wrong. :-/

The problem is that=20

1. you have to use circular lists

2. going forward is  O(1), going backward is O(N).  This doesn't sound
   like a problem,  but deleting from lists and  alike requires you to
   go back in the list.

I guess  that if  you have lists  that you  edit a lot,  double linked
lists should be  less overhead. However, if you only  walk the lists a
lot, both models should perform equally well.

Insertion is faster, but that's the only good news..

I'm all against them, though. ;)

			    Tonnerre


--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBbcVT/4bL7ovhw40RAhFYAKCTzqoEXmaLiSyZPp47vtv0zu8B0gCdHCtm
YqIf6/FtIuOCcTUqqq31tsE=
=HOWO
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
