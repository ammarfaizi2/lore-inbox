Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129517AbRB0OkK>; Tue, 27 Feb 2001 09:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129564AbRB0Oju>; Tue, 27 Feb 2001 09:39:50 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:48681 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129563AbRB0Ojt>; Tue, 27 Feb 2001 09:39:49 -0500
Date: Tue, 27 Feb 2001 14:39:42 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: timing out on a semaphore
Message-ID: <20010227143942.C13721@redhat.com>
In-Reply-To: <20010225224039.W13721@redhat.com> <3A9990EF.8D4ECF49@uow.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="rVbcdceMkFY6fDyG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A9990EF.8D4ECF49@uow.edu.au>; from andrewm@uow.edu.au on Sun, Feb 25, 2001 at 11:10:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rVbcdceMkFY6fDyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2001 at 11:10:39PM +0000, Andrew Morton wrote:

> I think there might be a bogon in __down_interruptible's
> handling of the semaphore state in this case.  I remember
> spotting something a few months back but I can't immediately
> remember what it was :(
>=20
> I'd suggest you slot a
>=20
> 	sema_init(&port->physport->ieee1284.irq, 1);
>=20
> into parport_wait_event() prior to adding the timer.  If that
> fixes it I'll go back through my patchpile, see if I can
> resurrect that grey cell.

I haven't been able to confirm that it works around it (can't repeat
the problem here), but what would you say if I said it did? ;-)

Tim.
*/

--rVbcdceMkFY6fDyG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6m7wtONXnILZ4yVIRAmlTAJ9DtkvvtSqbqTBjX13xJ2BXV9cynQCeLUYI
BAKfhIMbqucDaigKWm4Ax88=
=+lLK
-----END PGP SIGNATURE-----

--rVbcdceMkFY6fDyG--
