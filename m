Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbQKBWy2>; Thu, 2 Nov 2000 17:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbQKBWyT>; Thu, 2 Nov 2000 17:54:19 -0500
Received: from ziggy.one-eyed-alien.net ([216.51.112.145]:54022 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S129144AbQKBWyJ>; Thu, 2 Nov 2000 17:54:09 -0500
Date: Thu, 2 Nov 2000 14:53:20 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Elizabeth Morris-Baker <eamb@liu.fafner.com>
Cc: "chen, xiangping" <chen_xiangping@emc.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: scsi init problem in 2.4.0-test10?
Message-ID: <20001102145320.A27745@one-eyed-alien.net>
Mail-Followup-To: Elizabeth Morris-Baker <eamb@liu.fafner.com>,
	"chen, xiangping" <chen_xiangping@emc.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD979DF6@elway.lss.emc.com> <200011022158.PAA08240@liu.fafner.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200011022158.PAA08240@liu.fafner.com>; from eamb@liu.fafner.com on Thu, Nov 02, 2000 at 03:58:24PM -0600
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2000 at 03:58:24PM -0600, Elizabeth Morris-Baker wrote:
> 	Basically the problem is in scan_scsis_single.
> 	Some scsi devices are notoriously brain dead
> 	about answering inquiries without having=20
> 	recived a TUR and then spinning up.
> 	The problem seems to be the disk, not the controller,
> 	if this is the same problem.
>=20
> 	The problem appeared in the test kernels because
> 	the TUR *used* to be there, now it is not.

Strictly speaking, shouldn't we send a START_STOP, not a TUR to get the
disks (or other devices) to spin up?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

S:  Another stupid question?
G:  There's no such thing as a stupid question, only stupid people.
					-- Stef and Greg
User Friendly, 7/15/1998

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6AfBfz64nssGU+ykRAiG4AJ9d96tbBNs6zCwR8qIkGs5fJGs6EQCeLtO9
khi+5UEoM5/apYkaEBBgnow=
=/YMd
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
