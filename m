Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbSIZAlD>; Wed, 25 Sep 2002 20:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbSIZAlD>; Wed, 25 Sep 2002 20:41:03 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:24077 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S261757AbSIZAlA>; Wed, 25 Sep 2002 20:41:00 -0400
Date: Wed, 25 Sep 2002 17:46:12 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andi Kleen <ak@suse.de>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       greg@kroah.com, mochel@osdl.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci and  usb
Message-ID: <20020925174612.A13467@one-eyed-alien.net>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
	greg@kroah.com, mochel@osdl.org,
	linux-usb-devel@lists.sourceforge.net
References: <20020925212955.GA32487@kroah.com.suse.lists.linux.kernel> <3D9250CD.7090409@pacbell.net.suse.lists.linux.kernel> <p73k7l9si6p.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p73k7l9si6p.fsf@oldwotan.suse.de>; from ak@suse.de on Thu, Sep 26, 2002 at 02:33:50AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2002 at 02:33:50AM +0200, Andi Kleen wrote:
> David Brownell <david-b@pacbell.net> writes:
>=20
> > > +	/* stuff we want to pass to /sbin/hotplug */
> > > +	envp[i++] =3D scratch;
> > > +	scratch +=3D sprintf (scratch, "PCI_CLASS=3D%04X", pdev->class) + 1;
> > > +
> > > +	envp[i++] =3D scratch;
> > > +	scratch +=3D sprintf (scratch, "PCI_ID=3D%04X:%04X",
> > > +			    pdev->vendor, pdev->device) + 1;
> >=20
> > And so forth.  Use "snprintf" and prevent overrunning those buffers...
>=20
> Hmm? An %04X format is perfectly bounded.

Technically, it isn't bounded.  The field will expand if the value exceeds
4 digits. =20

However, these values can't do that.  At least not now.

But, as a good programming practice, snprintf should be used.  Heck, PCI
3.0 might use 32-bit vendor and device values, instead of 8 bit.  So, if
nothing else, do it as insurance for the future.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9kljUIjReC7bSPZARAvs3AKDT+HwxRVufr7PO3aKyrzLe3I7uyACePruX
EMy0LeXlWRSVAhX/pNjfhuY=
=qip2
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
