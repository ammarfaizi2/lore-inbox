Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbTKZVey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 16:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTKZVey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 16:34:54 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:14987 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264309AbTKZVew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 16:34:52 -0500
Subject: Re: Fire Engine??
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20031126113040.3b774360.davem@redhat.com>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	 <20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	 <p73fzgbzca6.fsf@verdi.suse.de>  <20031126113040.3b774360.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AfvByX5m7dtelqx36vds"
Organization: Red Hat, Inc.
Message-Id: <1069882450.5219.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 26 Nov 2003 22:34:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AfvByX5m7dtelqx36vds
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-11-26 at 20:30, David S. Miller wrote:

> > - Doing gettimeofday on each incoming packet is just dumb, especially
> > when you have gettimeofday backed with a slow southbridge timer.
> > This shows quite badly on many profile logs.
> > I still think right solution for that would be to only take time stamps
> > when there is any user for it (=3D no timestamps in 99% of all systems)=
=20
>=20
> Andi, I know this is a problem, but for the millionth time your idea
> does not work because we don't know if the user asked for the timestamp
> until we are deep within the recvmsg() processing, which is long after
> the packet has arrived.

question: do we need a timestamp for every packet or can we do one
timestamp per irq-context entry ? (eg one timestamp at irq entry time we
do anyway and keep that for all packets processed in the softirq)

--=-AfvByX5m7dtelqx36vds
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/xRxSxULwo51rQBIRAgC3AKCWFd5plGl3bRxwRWGFp3KLOa4angCdGfjs
aJFAxz3ugdodxVGZ+oHo6ZY=
=Kx1O
-----END PGP SIGNATURE-----

--=-AfvByX5m7dtelqx36vds--
