Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUAWDEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 22:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265859AbUAWDEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 22:04:24 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:11201 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S265139AbUAWDEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 22:04:23 -0500
Date: Fri, 23 Jan 2004 16:07:10 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: PATCH: Export console functions for use by	Software	Suspend	nice
 display
In-reply-to: <1074826188.976.185.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Daniel Jacobowitz <dan@debian.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074827229.12773.198.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-zN6e1Mw3KOQwqYx3xaDs";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1074757083.1943.37.camel@laptop-linux>
 <20040122082438.GV21151@parcelfarce.linux.theplanet.co.uk>
 <1074796577.12771.81.camel@laptop-linux>
 <20040122203529.GB13377@nevyn.them.org> <1074826188.976.185.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zN6e1Mw3KOQwqYx3xaDs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Fri, 2004-01-23 at 15:49, Benjamin Herrenschmidt wrote:
> Also, by using write instead of blasting the low level code,
> you will not have to worry about locking issues. (The way
> you tap the low level stuff should require at least the console
> semaphore held, write to /dev/console don't)
>=20
> Ben

Locking is not an issue. This is suspend-to-disk. Everything else is
stopped while we're working.

By the way, am I understanding the suggestion correctly? Do you
(collective) mean getting a fd for /dev/console from within kernel code
and using that? I've been looking at the way printk works and wondering
if con->write is equivalent (once I find the right console to write to)?

Regards,

Nigel

--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-zN6e1Mw3KOQwqYx3xaDs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAEI/dVfpQGcyBBWkRArxoAJ4pz9u5j18Ci9YuV7dmBF+v+27ucACgjBGL
ZmBLLV3KD8hEKRgS0cybMN4=
=as0n
-----END PGP SIGNATURE-----

--=-zN6e1Mw3KOQwqYx3xaDs--

