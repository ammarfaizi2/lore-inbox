Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265967AbUFDUFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265967AbUFDUFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUFDUFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:05:47 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:48868 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S265970AbUFDUFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:05:34 -0400
Date: Fri, 4 Jun 2004 16:05:30 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USBDEVFS_RESET deadlocks USB bus.
Message-ID: <20040604200530.GC3261@babylon.d2dc.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	"David A. Desrosiers" <desrod@gnu-designs.com>,
	linux-usb-devel@lists.sourceforge.net
References: <20040604193911.GA3261@babylon.d2dc.net> <20040604195247.GA12688@kroah.com> <20040604200211.GB3261@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <20040604200211.GB3261@babylon.d2dc.net>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2004 at 04:02:11PM -0400, Zephaniah E. Hull wrote:
> On Fri, Jun 04, 2004 at 12:52:47PM -0700, Greg KH wrote:
> > On Fri, Jun 04, 2004 at 03:39:11PM -0400, Zephaniah E. Hull wrote:
> > > Starting at 2.6.7-rc1 or so (that is when we first noticed it) the new
> > > pilot-link libusb back end started deadlocking the entire USB bus that
> > > the palm device was on.
> > >=20
> > > I have finally tracked it down to happening when we make the
> > > USBDEVFS_RESET ioctl, we never return from it and from that point on =
the
> > > bus in question is completely dead, no processing is done, no
> > > notifications of devices being plugged in or unplugged.
> > >=20
> > > This is still happening in 2.6.7-rc2-mm1.
> > >=20
> > > It seems to happen with both the UHCI and OHCI back ends, so it is
> > > probably above that.
> > >=20
> > > Given that there were heavy locking changes, I suspect that the case =
in
> > > question got screwed up somehow.

Further details, existing links with devices remain functional (IE, the
HID layer continues to get data from already connected mice), however
all processing or new devices or removed devices seems to be just gone,
on all USB busses.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

"And now, little kittens, we're going to run across red-hot
motherboards, with our bare feet." -- Buzh.

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwNYKRFMAi+ZaeAERAm4UAJ0f0Rzzkv1/QW4BeahfTKtvg/N1JwCgydOt
wS2tPnbDzT+ImaZnAggkAw4=
=OLTZ
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
