Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbRGMTel>; Fri, 13 Jul 2001 15:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267533AbRGMTeb>; Fri, 13 Jul 2001 15:34:31 -0400
Received: from cs666822-222.austin.rr.com ([66.68.22.222]:5514 "HELO
	igor.taral.net") by vger.kernel.org with SMTP id <S267532AbRGMTe1>;
	Fri, 13 Jul 2001 15:34:27 -0400
Date: Fri, 13 Jul 2001 14:34:26 -0500
From: Taral <taral@taral.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tty->name conversion?
Message-ID: <20010713143426.B7873@taral.net>
In-Reply-To: <200107131743.f6DHhGc186373@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <200107131743.f6DHhGc186373@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2001 at 01:43:16PM -0400, Albert D. Cahalan wrote:
> Taral writes:
>=20
> > I noticed that ps still relies on device numbers to determine tty, since
> > /proc/*/stat only exports the device number. Is there any way to get the
> > device name? I noticed that it is not present in tty_struct anywhere
> > (proc_pid_stat() uses task->tty->device, which is a kdev_t).
> >
> > This would be useful to consider if we ever intend to create real
> > unnumbered character/block devices.
>=20
> This isn't quite true, at least for the version shipped with Debian.

<snip>

Thanks for your reply. It still remains, however, that for processes
that you do not own, it has to guess, viz:

  319 taral    vc/1     S    Jul12 -zsh
  320 root     tty2     S    Jul12 /sbin/getty 38400 vc/2

Notice that the getty is listed as tty2, even though it opened
/dev/vc/2.

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjtPTUIACgkQ7rh4CE+nYEmx0ACg3BzluBcpENivYes4njlk+Cj5
laQAnRszbKvMLMyOeOwzlmKkY7yKfhvV
=NJ3T
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
