Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUDSUaF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUDSUaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:30:04 -0400
Received: from mh57.com ([217.160.185.21]:25568 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S261937AbUDSU37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:29:59 -0400
Date: Mon, 19 Apr 2004 22:29:43 +0200
From: Martin Hermanowski <lkml@martin.mh57.de>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm4 (hci_usb module unloading oops)
Message-ID: <20040419202943.GA5557@mh57.de>
References: <20040410200551.31866667.akpm@osdl.org> <20040412101911.GA3823@mh57.de> <20040412220353.GC23692@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20040412220353.GC23692@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::1
X-Spam-Score: 0.0 (/)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2004 at 03:03:53PM -0700, Greg KH wrote:
> On Mon, Apr 12, 2004 at 12:19:11PM +0200, Martin Hermanowski wrote:
> > I get an oops when I try to unload the hci_usb module.
>=20
> {sigh}  I'm hating that driver right now...
>=20
> There are a number of pending bluetooth patches for that driver that fix
> a number of different bugs, so I'm leary of trying to see if this is a
> different one or not at this point in time.  Care to apply all of the
> bluetooth patches and if this still happens, can you report it to the
> linux-usb-devel and bluez-devel mailing lists?

I can try these patches in the next days, can you point me to an url?

> > What other useful information can I provide?
>=20
> CONFIG_DEBUG_DRIVER might be good to set, and then we can see if we are
> not trying to remove the same device twice for some odd reason.  If you
> do duplicate this, please include all of the debug log entries that
> happen from when you unplug the device.
>=20
> Also CONFIG_USB_DEBUG might help out.

I just tried 2.6.6-rc1-mm1 (patched with mppe and iscsi), same problem.

I compiled with CONFIG_DEBUG_DRIVER and CONFIG_USB_DEBUG, after booting,
I activate the usb-dongle (Fn+F5 on the IBM T41p), then I run `hciconfig
down' and `rmmod hci_usb', which triggers the problem

I uploaded both the config and the whole syslog file from the boot until
shutting down:

http://mh57.de/~martin/config-2.6.6-rc1-mm1
http://mh57.de/~martin/syslog-2.6.6-rc1-mm1

> > Apr 12 12:07:48 localhost udev[22216]: removing device node '/dev/hci0'
>=20
> Nice, glad to see udev is working for you :)

I'm using udev 0.024-2 from debian, and it is working quite well :-)

LLAP, Martin

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhDa3mGb6Npij0ewRAoRiAKC4Q3VOfIc+nCzh7uczqrZQKZKLCwCgtOun
UlCJKs0PYs+TiZzmI+tSAJE=
=0vaA
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
