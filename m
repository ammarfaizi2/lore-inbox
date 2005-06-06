Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVFFQua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVFFQua (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 12:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVFFQua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 12:50:30 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:50604 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261245AbVFFQuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 12:50:21 -0400
Date: Mon, 6 Jun 2005 18:50:14 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BUG] oops while completing async USB via usbdevio
Message-ID: <20050606165014.GM6596@sunbeam.de.gnumonks.org>
References: <20050606160531.GG6596@sunbeam.de.gnumonks.org> <Pine.LNX.4.44L0.0506061222380.5651-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0kRkyLZR5zsR9u2P"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0506061222380.5651-100000@iolanthe.rowland.org>
User-Agent: mutt-ng 1.5.8-r168i (Debian)
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Mon, Jun 06, 2005 at 12:24:25PM -0400, Alan Stern
	wrote: > > > Ok, I'll get something coded shortly. > > > >
	Unfortunately this approach is not feasible, since there is no 'reverse
	> > mapping' from a file to a process. So for every URB delivery, we
	would > > have to walk that task_list and check which tasks have opened
	this file. > > What about something like the standard FSETOWN fnctl?
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0kRkyLZR5zsR9u2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2005 at 12:24:25PM -0400, Alan Stern wrote:
> > > Ok, I'll get something coded shortly.
> >=20
> > Unfortunately this approach is not feasible, since there is no 'reverse
> > mapping' from a file to a process.  So for every URB delivery, we would
> > have to walk that task_list and check which tasks have opened this file.
>=20
> What about something like the standard FSETOWN fnctl?

I investigated this option, too. The magic behind FSETOWN doesn't allow
us to pass the URB address back to the process (together with the
signal).

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--0kRkyLZR5zsR9u2P
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCpH7GXaXGVTD0i/8RAkRGAJ9NqygVefhCvuS4gz9FYxIJa1d+dwCfarjv
cZjgGV99WRP7GZetPUHxDyE=
=l7Mm
-----END PGP SIGNATURE-----

--0kRkyLZR5zsR9u2P--
