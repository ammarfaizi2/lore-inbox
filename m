Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUASPqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUASPqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:46:40 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:36769 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S265139AbUASPqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:46:38 -0500
Date: Mon, 19 Jan 2004 16:46:33 +0100
From: Martin F Krafft <krafft@ailab.ch>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: failing to force-claim USB interface
Message-ID: <20040119154633.GA3797@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
Organization: AILab, IFI, University of Zurich
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.1-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am trying to make use of the usbfs USBDEVFS_DISCONNECT ioctl, and
I am failing. Here is the code:

  struct usb_device *dev;
  [...]
  sprintf(path, "/proc/bus/usb/%s/%s", dev->bus->dirname, dev->filename);
  int fd =3D open(path);
  struct usbdevfs_ioctl command =3D { 0, USBDEVFS_DISCONNECT, 0 };
  ioctl (fd, USBDEVFS_IOCTL, &command) < 0

However, the ioctl always fails. I am not sure whether I am using
the right values for the file descriptor passed to ioctl(), or what
the interface number (first parameter of usbdevfs_ioctl) is.

Maybe someone could offer me some advice or tell me to RTFM (but
please specify TM to FR).

Thanks,

--=20
Martin F. Krafft                Artificial Intelligence Laboratory
Ph.D. Student                   Department of Information Technology
Email: krafft@ailab.ch          University of Zurich
Tel: +41.(0)1.63-54323          Andreasstrasse 15, Office 2.20
http://ailab.ch/people/krafft   CH-8050 Zurich, Switzerland
=20
Invalid/expired PGP subkeys? Use subkeys.pgp.net as keyserver!
=20
click the start menu and select 'shut down.'

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAC/vZIgvIgzMMSnURAo2sAKDWVU2Rot/cRFqB0kt43xXtkA+0xACfXlS+
VyAyfkq2mF0JBZ0mdWsTgJE=
=erGc
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
