Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266332AbUAGSTm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266278AbUAGSTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:19:42 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:6341 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S266332AbUAGSS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:18:28 -0500
Date: Thu, 08 Jan 2004 06:16:55 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: udev and devfs - The final word
In-reply-to: <200401071439.03915.roro.l@dewire.com>
To: Robin Rosenberg <roro.l@dewire.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1073495815.2286.7.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-7tvXol2ML7I+V1DJLKAF";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <20040103040013.A3100@pclin040.win.tue.nl>
 <200401051201.58356.roro.l@dewire.com>
 <1073306368.4181.103.camel@laptop-linux> <200401071439.03915.roro.l@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7tvXol2ML7I+V1DJLKAF
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Ah. Well if you've unmounted filesystems prior to suspending, I would
expect you should be fine. The device numbers might change - if they can
change between mounts - but that won't be any different because of
suspending. If you're talking about suspending with the file systems
mounted, that ought to work to (once the appropriate power management
support is done). If the user fails to reconnect the device before
resuming, they should expect the same problems that they would encounter
if they pulled it out without suspending. Of course I'm saying 'should'
a lot here. Let me use it one more time... in my mind at least, the fact
that we've suspended should be irrelevant to how things work.

Regards,

Nigel

On Thu, 2004-01-08 at 02:39, Robin Rosenberg wrote:
> m=E5ndagen den 5 januari 2004 13.39 skrev Nigel Cunningham:
> > Hi.
> >
> > The suspend to disk implementations all assume that devices are not
> > [dis]appearing under us while we're suspended. If you do go adding and
> > removing devices while the power is off, you can expect the same
> > problems you'd get if you removed them without suspending the machine.
> > It would be roughly equivalent to hot[un]plugging devices.
>=20
> Yes. It's very unclear unless you do mind reading, but I had in mind moun=
ted filesystems
> such as /home on a USB stick or firewire Reasonable? yes! But such device=
s have to
> be rediscovered and allocated in such a way that the user can resume usin=
g the device
> as soon as it has been found. And it should not fail miserably if the use=
r forgets to connect
> the device before resuming the machine. As you cannot unmount /home (usua=
lly) the
> kernel must remember the device somehow or make mounting file systems mor=
e loosely
> than today.
>=20
> -- robin
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-7tvXol2ML7I+V1DJLKAF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA//D8HVfpQGcyBBWkRAnvFAJ9ynWsZjSfXO/ChKSD3jrci33ycGwCfaRUK
4rJZmRAwlkJt7xIBYKyO8xc=
=EYF+
-----END PGP SIGNATURE-----

--=-7tvXol2ML7I+V1DJLKAF--

