Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVI3Kry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVI3Kry (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 06:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbVI3Kry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 06:47:54 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:6049 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1030236AbVI3Krx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 06:47:53 -0400
Date: Fri, 30 Sep 2005 12:47:49 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sergey Vlasov <vsu@altlinux.ru>, linux-usb-devel@lists.sourceforge.net,
       vendor-sec@lst.de, linux-kernel@vger.kernel.org, greg@kroah.com,
       security@linux.kernel.org
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050930104749.GN4168@sunbeam.de.gnumonks.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local> <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local> <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zsp0GYBMzHfleR3l"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zsp0GYBMzHfleR3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2005 at 10:02:16AM -0700, Linus Torvalds wrote:
> On Tue, 27 Sep 2005, Sergey Vlasov wrote:
> >=20
> > The initial patch added get_task_struct()/put_task_struct() calls to
> > fix this - are they forbidden too?
>=20
> They are sure as hell not something that a _driver_ is supposed to use.
>=20
> > It at least has sigio_perm(), which prevents exploiting it to send
> > signals to tasks you don't have access to.
>=20
> And the point is, you can do that _too_.
>=20
> Do it right. Don't cache pointers to threads. Use the pid.

So what happened to this thread?  Was I simply removed from the Cc, or
did the thread cease?  Or is there a "secret" fix on vendor-sec?

I'm probably the person in this thread who understands the least about
the USB stack and the scheduler, but if there is no implementation of
Linus' suggested "PID approach" yet, I'd be willing to write a patch and
test it. Please let me know.

Please also understand that I never argued that my initial patch was a
good solution, or that I wanted it to have merged.  I just wanted to
show that there is a real-world problem, and it somehow needs to be fixed.

Cheers,

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--zsp0GYBMzHfleR3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDPRfVXaXGVTD0i/8RAle0AJ9vWRUaXN8CIm6ngi8B8y+Yr0e0oQCgopVt
mbHuWwcYCHh2Q7Fi8Jhl2fY=
=UMox
-----END PGP SIGNATURE-----

--zsp0GYBMzHfleR3l--
