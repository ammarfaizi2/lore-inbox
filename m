Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbQKBXFJ>; Thu, 2 Nov 2000 18:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129349AbQKBXE7>; Thu, 2 Nov 2000 18:04:59 -0500
Received: from 209-164-222-32.iglobal.net ([209.164.222.32]:36483 "EHLO
	liu.fafner.com") by vger.kernel.org with ESMTP id <S129193AbQKBXEl>;
	Thu, 2 Nov 2000 18:04:41 -0500
From: Elizabeth Morris-Baker <eamb@liu.fafner.com>
Message-Id: <200011022245.QAA08323@liu.fafner.com>
Subject: Re: scsi init problem in 2.4.0-test10?
To: mdharm-kernel@one-eyed-alien.net (Matthew Dharm)
Date: Thu, 2 Nov 2000 16:45:25 -0600 (CST)
Cc: eamb@liu.fafner.com (Elizabeth Morris-Baker),
        chen_xiangping@emc.com (chen xiangping),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <20001102145320.A27745@one-eyed-alien.net> from "Matthew Dharm" at Nov 02, 2000 02:53:20 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 

	You need to send the TUR first, but yes, 
	START_STOP will guarantee that you are
	ready to rock and roll.
	The first fix I wrote did a TUR, then
	3 tries at a START_STOP, till it worked.
	
	cheers, 

	Elizabeth
	
> 
> --8t9RHnE3ZwKMSgU+
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Thu, Nov 02, 2000 at 03:58:24PM -0600, Elizabeth Morris-Baker wrote:
> > 	Basically the problem is in scan_scsis_single.
> > 	Some scsi devices are notoriously brain dead
> > 	about answering inquiries without having=20
> > 	recived a TUR and then spinning up.
> > 	The problem seems to be the disk, not the controller,
> > 	if this is the same problem.
> >=20
> > 	The problem appeared in the test kernels because
> > 	the TUR *used* to be there, now it is not.
> 
> Strictly speaking, shouldn't we send a START_STOP, not a TUR to get the
> disks (or other devices) to spin up?
> 
> Matt
> 
> --=20
> Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
> net=20
> Maintainer, Linux USB Mass Storage Driver
> 
> S:  Another stupid question?
> G:  There's no such thing as a stupid question, only stupid people.
> 					-- Stef and Greg
> User Friendly, 7/15/1998
> 
> --8t9RHnE3ZwKMSgU+
> Content-Type: application/pgp-signature
> Content-Disposition: inline
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.4 (GNU/Linux)
> Comment: For info see http://www.gnupg.org
> 
> iD8DBQE6AfBfz64nssGU+ykRAiG4AJ9d96tbBNs6zCwR8qIkGs5fJGs6EQCeLtO9
> khi+5UEoM5/apYkaEBBgnow=
> =/YMd
> -----END PGP SIGNATURE-----
> 
> --8t9RHnE3ZwKMSgU+--
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
