Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129853AbRBYWlE>; Sun, 25 Feb 2001 17:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129856AbRBYWky>; Sun, 25 Feb 2001 17:40:54 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:6390 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129853AbRBYWkp>; Sun, 25 Feb 2001 17:40:45 -0500
Date: Sun, 25 Feb 2001 22:40:39 +0000
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: timing out on a semaphore
Message-ID: <20010225224039.W13721@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="2F7AbV2suvT8PGoH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2F7AbV2suvT8PGoH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm trying to chase down a semaphore time-out problem.  I want to
sleep on a semaphore until either

(a) it's signalled, or
(b) some amount of time has elapsed.

What I'm doing is calling add_timer, and then down_interruptible, and
finally del_timer.  The timer's function ups the semaphore.

The code is in parport_wait_event, in drivers/parport/ieee1284.c.

Can anyone see anything obviously wrong with it?  It seems to
sometimes get stuck.

Tim.
*/

--2F7AbV2suvT8PGoH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6mYnmONXnILZ4yVIRAlWEAJ97NiWiFb6bDGd+ZFYtdgk7Z4zWfACfUNpq
wb68SnMgjcPgXBEO6KZmeaI=
=W8Fn
-----END PGP SIGNATURE-----

--2F7AbV2suvT8PGoH--
