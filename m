Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTLVK7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 05:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbTLVK7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 05:59:22 -0500
Received: from populous.netsplit.com ([62.49.129.34]:17599 "EHLO
	mailgate.netsplit.com") by vger.kernel.org with ESMTP
	id S264389AbTLVK6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 05:58:46 -0500
Subject: Re: udev LABEL not working: sysfs_path_is_file: stat() failed
From: Scott James Remnant <scott@netsplit.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20031222092329.GA30235@kroah.com>
References: <1072054829.1225.11.camel@descent.netsplit.com>
	 <20031222092329.GA30235@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4hTocWRUJWzrs47VkYdy"
Message-Id: <1072090725.1225.19.camel@descent.netsplit.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 10:58:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4hTocWRUJWzrs47VkYdy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[I am not subscribed to linux-kernel or linux-hotplug-devel, please Cc:
me on replies.]

On Mon, 2003-12-22 at 09:23, Greg KH wrote:

> On Mon, Dec 22, 2003 at 01:00:29AM +0000, Scott James Remnant wrote:
>=20
> > I'm having a problem getting udev to honour my LABEL lines
>=20
> There is also a problem with udev beating the kernel.  It can easily get
> the hotplug event before the kernel has created the sysfs file.  I'm
> currently working on fixing this in udev, should have it done by the
> next release.  You can tell if you are seeing this race by just running
> the test.block script in the test directory in udev.  If your device
> node is created properly with that script, but not when you plug the
> device in, you have that problem.
>=20
> And people tried to tell us that the hotplug interface was slow without
> ever testing it out...
>=20
It looks like this is what's happening, after tracing the code I added
some stuff to print out everything in the sysfs directory at the time
udev was running, and it is devoid of the vendor & model files which
turn up shortly afterwards.

On the slower laptop, it works as expected.


One question though, it only ever seems to create a device for the
actual usb-storage disk and not the partition.  Is there some magic to
create the partition device instead?

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?


--=-4hTocWRUJWzrs47VkYdy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/5s5kIexP3IStZ2wRAo4MAJ94D9f6reQ277jV4iHX43sgnoTB6wCeL70F
sSBxZ4kFyX/HEzizZNUPzP0=
=+Fa7
-----END PGP SIGNATURE-----

--=-4hTocWRUJWzrs47VkYdy--

