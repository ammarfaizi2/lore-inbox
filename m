Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268856AbUIHGOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268856AbUIHGOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268868AbUIHGOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:14:04 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:20398 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268856AbUIHGN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:13:58 -0400
Date: Wed, 8 Sep 2004 08:11:59 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Pavel Machek <pavel@ucw.cz>
Cc: Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040908061159.GC1630@thundrix.ch>
References: <20040905111743.GC26560@thundrix.ch> <1215700165.20040905135749@tnonline.net> <20040905115854.GH26560@thundrix.ch> <1819110960.20040905143012@tnonline.net> <20040906105018.GB28111@atrey.karlin.mff.cuni.cz> <6010544610.20040906143222@tnonline.net> <m3wtz7h2l6.fsf@zoo.weinigel.se> <826067315.20040906171320@tnonline.net> <m3sm9vh06b.fsf@zoo.weinigel.se> <20040906155456.GC13539@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20040906155456.GC13539@atrey.karlin.mff.cuni.cz>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Mon, Sep 06, 2004 at 05:54:56PM +0200, Pavel Machek wrote:
> Who is going to umount it when application crashes, etc?

This  has   been  discussed  along   with  the  HAL  people   a  while
ago. Actually, file systems can  introduce a refcount, where we need a
decrement function  which automatically unmounts the  filesystem if we
decrement the use count to zero. Kind of an automatic umount.

How  do  you tell  which  file  systems  shall be  autoumounted?   HAL
suggestion: introduce a no-op mount  option. For some classes of fs'es
we might as well make that obligatory, such as tar.

			    Tonnerre

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPqKu/4bL7ovhw40RAlawAKCflGQw29Ffm35rXC1X9PkvK7Xt3QCfeeH3
E+MhBPhAxXtYzrD7ODR0ixc=
=i5aS
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
