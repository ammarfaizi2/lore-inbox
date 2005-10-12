Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVJLJ6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVJLJ6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 05:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVJLJ6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 05:58:23 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:35225 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932422AbVJLJ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 05:58:22 -0400
Date: Wed, 12 Oct 2005 09:24:02 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, security@linux.kernel.org,
       vendor-sec@lst.de
Subject: Re: [vendor-sec] Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20051012072401.GI4237@rama.de.gnumonks.org>
References: <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org> <20050930184433.GF16352@shell0.pdx.osdl.net> <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org> <20050930220808.GE4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509301514190.3378@g5.osdl.org> <20051010174429.GH5627@rama> <20051010180745.GT5856@shell0.pdx.osdl.net> <20051011094550.GI4290@rama> <20051011231054.GA16315@kroah.com> <Pine.LNX.4.64.0510111639500.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x0KprKst+ZOYEj2z"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510111639500.14597@g5.osdl.org>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x0KprKst+ZOYEj2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2005 at 04:44:41PM -0700, Linus Torvalds wrote:
> I _think_ I fixed the disconnect thing too, although I think Harald's=20
> naming for the disconnect structure was cleaner, so I wouldn't mind havin=
g=20
> a (tested) patch on top of mine..
> [...]
> But for 2.6.14, the most important thing would be to verify that the oops=
=20
> cannot happen, and that you can't send signals to setuid programs by doin=
g=20
> an "open(usb) + fork(keep it open in the child) + exec(suid in the=20
> parent)"

I'm busy giving a netfilter tutorial all day, but I'll do the
incremental patch + testing tonight.  So I expect some kind of reply on
this at about 11pm (GMT+1).

Sorry once again for the delays, but as I said initially: I'm neither a
core kernel / scheduler nor a USB developer.  If somebody else had taken
the bug, we'd have had way less round-trips...

Cheers,
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--x0KprKst+ZOYEj2z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDTLoRXaXGVTD0i/8RAisAAKCgGyKNM1pMasUUHlckfeT7un2+2gCgpRPY
DriH6MppsMEUjOmjVkScsrI=
=65VZ
-----END PGP SIGNATURE-----

--x0KprKst+ZOYEj2z--
