Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWBVCOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWBVCOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWBVCOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:14:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:59994 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932542AbWBVCOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:14:11 -0500
Date: Tue, 21 Feb 2006 21:14:01 -0500
From: Jeff Bailey <jbailey@ubuntu.com>
Subject: Re: [klibc] [PATCH] initramfs: multiple CPIO unpacking fix
In-reply-to: <20060222104525.affda1df.mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       hpa@zytor.com, "miltonm@bga.com" <miltonm@bga.com>,
       Al Viro <viro@ftp.linux.org.uk>
Message-id: <1140574441.5304.37.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.5.91
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-jZxEf6tlb3kI5nhUK05d"
References: <20060216183745.50cc2bf6.mikey@neuling.org>
 <20060217160621.99b0ffd4.mikey@neuling.org>
 <20060222104525.affda1df.mikey@neuling.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jZxEf6tlb3kI5nhUK05d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le mercredi 22 f=C3=A9vrier 2006 =C3=A0 10:45 +1100, Michael Neuling a =C3=
=A9crit :
> The following patch unlinks (deletes) files, symlinks, FIFOs, devices
> etc before writing them when extracting CPIOs.  It doesn't delete
> directories.  This stops weird behaviour like:
>  1) writing through symlinks created in earlier CPIOs. eg foo->bar in
>     the first CPIO.  Having foo as a non link in a subsequent CPIO,
>     results in bar being written and foo remaining as a symlink. =20

I've tended to think of this as a feature, actually.  In Ubuntu, for
instance, we might have 2.6.15-8 and 2.6.15-9 which represent different
ABIs from security updates or other changes.  If I have a module that is
intended to be compatible with both, I might setup /lib/modules/generic
to be a symlink to /lib/modules/2.6.15-9/ and unpack the modules after
the symlink is expected to be there.

(I don't think we use this feature right now, but I had tested it and
noted it before.  It's very convenient, since it's the exact same
behaviour that dpkg itself has)

Tks,
Jeff Bailey

* Canonical Ltd * Ubuntu Service and Support * +1 514 691 7221 *

Linux for Human Beings.

--=-jZxEf6tlb3kI5nhUK05d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBD+8jpkNAc0s37a3gRAnfyAKCQwb7T3qJm6zJsgRDJTUo/ImxQ6QCdEU/k
aO84Eq3EjdY/JC7HAYdOuiY=
=Clzz
-----END PGP SIGNATURE-----

--=-jZxEf6tlb3kI5nhUK05d--

