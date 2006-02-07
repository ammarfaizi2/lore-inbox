Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbWBGNzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWBGNzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWBGNzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:55:13 -0500
Received: from sipsolutions.net ([66.160.135.76]:12296 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S965089AbWBGNzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:55:12 -0500
Subject: Re: [RFC 4/4] firewire: add mem1394
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
In-Reply-To: <43E60989.5080600@s5r6.in-berlin.de>
References: <1138919238.3621.12.camel@localhost>
	 <1138920185.3621.24.camel@localhost>  <43E60989.5080600@s5r6.in-berlin.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iJtN9bx3753uzsDYeTaD"
Date: Tue, 07 Feb 2006 11:41:36 +0100
Message-Id: <1139308896.25972.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iJtN9bx3753uzsDYeTaD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-02-05 at 15:19 +0100, Stefan Richter wrote:

> > +	 * But I need advice on this. It'll probably works this way
> > +	 * but most likely not once this interface stuff gets more
> > +	 * use; I can imagine using it for scanners instead of raw1394
> > +	 * so that the kernel can validate that a user can only
> > +	 * access a certain scanner and not all 1394 devices on the bus.
>=20
> Probably not. All devices (except perhaps custom embedded devices) which=20
> implement one or another high level protocol will always be accessed=20
> either by a protocol driver in kernelspace (like sbp2, eth1394,=20
> video1394) on top of a struct unit_directory, or by a driver or library=20
> in userspace on top of libraw1394/ raw1394. This is because such devices=20
> and protocols all implement the ISO/IEC 13213 CSR architecture.

You snipped too much :) At this point I was thinking of the raw1394
replacement that has finer grained access control which we talked about
in other threads too.

> > +	 * In other words some 'raw1394intf' instead of 'raw1394' which
> > +	 * creates one character device per ieee1394 node for finer
> > +	 * grained access control.
> > +	 * That would definitely want to have debouncing etc.


> When a node represented by a node_entry leaves the bus, the node_entry=20
> is "suspended" and "put into limbo", which is both the same for the 1394=20
> stack. The node_entry is only "removed" when forced by userspace through=20
> ieee1394's sysfs interface or when the ieee1394 driver module is=20
> unloaded. A unit_directory is either "suspended" or "removed", depending=20
> on what the protocol driver bound to the unit_directory implements.=20
> This behaviour of ieee1394 is currently not extensively used, but I plan=20
> to implement capability of sbp2 to survive transient disconnection on=20
> top of it.

Thanks for the explanation. I'll have to test my driver under the light
of this.

johannes

--=-iJtN9bx3753uzsDYeTaD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ+h5XqVg1VMiehFYAQInGg//XOxWXTtWpkJB5RJeQAJUWUHzZafraMq5
rmcHQhoZ3cCKiFWnRxMOIBONDsDekEzSYehs+SPnVTTu5kMC1hPlsbfdIP2UuPB6
BNCa+RA2UY/SI8uMM+jqIN2mzXwuJ7wDNl8SDMYni53OwRGnz1Dnp7EeoySZM5QL
2W0Bg43E+KchSMQnCrlLXQB11KH8r+l9FQ/vV7vw/wNhCsNeM8gIfZ4oug9snuoE
RqUk9Uh2iU0BzDK+mR4SNo8XBaxPh0blfCUaVZn3wtoxLvRfi6DG8mjkYtm+Efyp
8un0KOsG5ZCSE2NbcNUywubLdA1ZvYkHuJPSCNKpRmSfVP8cwZ7sF4bJ2mfDn7ww
wZ3YXAB7LQ6NYNjxOXmDUS8UcDAPrkLTtdiKWr1zRMnWLVMunpujnvpCXMrccLcS
v7ZBrCn9UDKP8zy9SuEmOJ3LVvmVZu7tGbtDG8J424yYijMIXBBksXKm//zCIjXQ
c1J9UxdRfU61EjaDH4MZRhnY1bPay97ZPUE8bXUOCk60QD+gdJNbj3JHLPUCUF1E
+Mh4w63OJIiwGzRneZpmCXh+P9T/pUBnfGN9oTK5ptBB3I6SJXsIlaAY+NpmuGh1
nVGKnjDbmpnuOkr26hjsVX3NygXf8KgFwFuPzzBDzumI9tUstrTOraAmQPSD/SDe
66F6y1s0izY=
=gxMA
-----END PGP SIGNATURE-----

--=-iJtN9bx3753uzsDYeTaD--

