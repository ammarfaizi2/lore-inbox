Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUAaR5C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 12:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbUAaR5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 12:57:02 -0500
Received: from wblv-36-186.telkomadsl.co.za ([165.165.36.186]:25732 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264971AbUAaR47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 12:56:59 -0500
Subject: Re: [ANNOUNCE] udev 015 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040131031718.GA21129@vrfy.org>
References: <20040126215036.GA6906@kroah.com>
	 <1075395125.7680.21.camel@nosferatu.lan> <20040129215529.GB9610@kroah.com>
	 <20040131031718.GA21129@vrfy.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-u3PpNr1WVm7/Z+qXsK2s"
Message-Id: <1075571697.7232.11.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 31 Jan 2004 19:54:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-u3PpNr1WVm7/Z+qXsK2s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-31 at 05:17, Kay Sievers wrote:
> On Thu, Jan 29, 2004 at 01:55:29PM -0800, Greg KH wrote:
> > On Thu, Jan 29, 2004 at 06:52:05PM +0200, Martin Schlemmer wrote:
> > > On Mon, 2004-01-26 at 23:50, Greg KH wrote:
> > >=20
> > > Is there a known issue that the daemon do not spawn?
> >=20
> > Hm, I don't know.  This code is under major flux right now...
>=20
> Hi Martin,
> sorry, the code in the tree doesn't work.
> I decided to try pthreads, cause I gave up with the I/O multiplexing,
> forking and earning SIGCHLDS for manipulating the global lists.
>=20
> The multithreaded udevd takes multiple events at the same time on a unix
> domain socket, sorts it in a linked list and handles the timeouts if
> events are missing.
> It executes our current udev in the background and delays the execution
> for events with the same DEVPATH. So we serialize the events only for
> different devices.
>=20
> I've posted the latest patch to the list a few minutes ago.
> If you like, I'm happy to hear from your testing :)
>=20
> If we decide not to stay with the threads model, cause klibc doesn't
> support it now and ..., we at least have a working model to implement
> in a different way.
>=20

Thanks - I wanted to have a go at it, but after not working, wanted to
check if it might be my setup, or known issue ...  I will see if I can
get time to test your latest patch - anything specific you need testing
of ?

--=20
Martin Schlemmer

--=-u3PpNr1WVm7/Z+qXsK2s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAG+vxqburzKaJYLYRAtr3AJ9utHjv0pIBwyA+jUCTdnNm6ymdZgCghM29
Gg1GoKmCoACDHWJ79kk8Aw0=
=dsYb
-----END PGP SIGNATURE-----

--=-u3PpNr1WVm7/Z+qXsK2s--

