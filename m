Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVJKNsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVJKNsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVJKNsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:48:13 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:48865 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751205AbVJKNsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:48:12 -0400
Date: Tue, 11 Oct 2005 10:28:38 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, security@linux.kernel.org,
       vendor-sec@lst.de
Subject: Re: [linux-usb-devel] Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20051011082838.GD4290@rama>
References: <20051010174429.GH5627@rama> <Pine.LNX.4.44L0.0510101559330.10768-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0510101559330.10768-100000@netrider.rowland.org>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2005 at 04:03:13PM -0400, Alan Stern wrote:
> On Mon, 10 Oct 2005, Harald Welte wrote:
>=20
> > +	if ((!info || ((unsigned long)info !=3D 1 &&
> > +			(unsigned long)info !=3D 2 && SI_FROMUSER(info)))
> > +	    && (euid ^ p->suid) && (euid ^ p->uid)
> > +	    && (uid ^ p->suid) && (uid ^ p->uid)) {
>=20
> No doubt this was copied from somewhere else.  But why do people go to the
> effort of confusing readers by using "^" instead of "!=3D"?  These aren't=
=20
> bit-oriented values.

Well, I'd rather keep the new code as close as possible to the original
check_permission() code, to make it obvious that it's basically doing
the same thing.  I think if you want to clean this up, it could be an
additional patch on top of mine (once there is a final version and it
gets merged.

> Alan Stern

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDS3e2XaXGVTD0i/8RAi53AJ9lyKy17tjK99aaw7MuZP0E5ab/lgCeIYuY
yRYLLu11ncDErpOSG6o7b7I=
=1LXD
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
