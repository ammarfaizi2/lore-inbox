Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVEaWNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVEaWNQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 18:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVEaWNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 18:13:16 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:30629 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261153AbVEaWNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 18:13:12 -0400
Date: Wed, 1 Jun 2005 00:12:58 +0200
From: Harald Welte <laforge@gnumonks.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BUG] oops while completing async USB via usbdevio
Message-ID: <20050531221258.GI29780@sunbeam.de.gnumonks.org>
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org> <200505301555.39985.david-b@pacbell.net> <20050531084852.GJ25536@sunbeam.de.gnumonks.org> <200505311153.24747.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline
In-Reply-To: <200505311153.24747.david-b@pacbell.net>
User-Agent: mutt-ng 1.5.8-r168i (Debian)
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tue, May 31, 2005 at 11:53:24AM -0700, David
	Brownell wrote: > I'm still hoping that one of the folk who want make
	an interesting and > useful contribution to Linux will take the hint.
	It goes slowly. :) [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2005 at 11:53:24AM -0700, David Brownell wrote:
> I'm still hoping that one of the folk who want make an interesting and
> useful contribution to Linux will take the hint.  It goes slowly. :)

I've pondered about three times whether to start or not.  I'd rather
not, since I'm already having problems keeping up with all my other
projects :(

> > meanwhile, the current usbfs aio handling is the only way how to deal
> > with delivery of interrupt pipe URB's to userspace drivers.
>=20
> Other than tying up the file descriptor with a blocking read, that is.

you're probably using that same file descriptor for reading/writing
=66rom/to bulk endpoints at the same time.  I don't see how a 'blocking
read' would help.

> > Wouldn't it help to associate the URB with the file (instaed of the
> > task), and then send the signal to any task that still has opened the
> > file?  I'm willing to hack up a patch, if this is considered a sane fix.
>=20
> Sounds reasonable, except that not all such tasks will want the signal.
> Though I guess the infrastructure to filter the signal out already exists,
> so the main missing piece is that urb-to-file binding.

Ok, I'll get something coded shortly.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCnOFqXaXGVTD0i/8RAlMzAKCXBZAQBuTK1fRYXCy2TK9uWsbB0wCeJXb8
PM9PNBk7G1vwfcRKdvTWD1E=
=aoqI
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
