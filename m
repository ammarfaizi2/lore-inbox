Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUFFGgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUFFGgK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 02:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUFFGgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 02:36:10 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:8355 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S262960AbUFFGgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 02:36:05 -0400
Date: Sun, 6 Jun 2004 02:35:59 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Duncan Sands <baldrick@free.fr>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Message-ID: <20040606063559.GA3018@babylon.d2dc.net>
Mail-Followup-To: Duncan Sands <baldrick@free.fr>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	"David A. Desrosiers" <desrod@gnu-designs.com>,
	linux-usb-devel@lists.sourceforge.net
References: <20040604193911.GA3261@babylon.d2dc.net> <200406042240.43490.baldrick@free.fr> <20040604213037.GA2881@babylon.d2dc.net> <200406050955.01677.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <200406050955.01677.baldrick@free.fr>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 05, 2004 at 09:55:01AM +0200, Duncan Sands wrote:
> On Friday 04 June 2004 23:30, Zephaniah E. Hull wrote:
> > On Fri, Jun 04, 2004 at 10:40:43PM +0200, Duncan Sands wrote:
> > > > c4bae310 Call Trace:
> > > >  [<c0336735>] __down+0x85/0x120
> > > >  [<c033692f>] __down_failed+0xb/0x14
> > > >  [<c026af27>] .text.lock.hub+0x69/0x82
> > > >  [<c0272b7f>] usbdev_ioctl+0x19f/0x710
> > > >  [<c015a45d>] file_ioctl+0x5d/0x170
> > > >  [<c015a686>] sys_ioctl+0x116/0x250
> > > >  [<c0103f8f>] syscall_call+0x7/0xb
> > >
> > > Does this help?
> >
> > I'm afraid not.
>=20
> Are you sure?  That seems impossible to me!  Can you
> get a new call trace please.

Hrm, I could have sworn that the kernel I tested with was rebuilt with
the patch, but now that I am trying it on rc2-mm1 with the patch, it
does in fact seem to be working, mostly.

Thanks a lot, and sorry for the previous report.

I seem to be seeing a locking related race condition on bulk reads and
writes as well, should I start a new thread for those?

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

* james would be more impressed if netgod's magic powers could stop the
splits in the first place...
* netgod notes debian developers are notoriously hard to impress
        -- Seen on #Debian

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwrtPRFMAi+ZaeAERAnSPAJsElpFyXWFBURQOZ7n/4x1qEZKRGgCeLQY3
/Gdo5BKyQi7b9GVka8eyQ8Q=
=27kk
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
