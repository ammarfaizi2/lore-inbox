Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268090AbUHFPLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268090AbUHFPLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268085AbUHFPLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:11:50 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:46026 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S268091AbUHFPLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:11:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] cputime (3/6): move jiffies stuff to jiffies.h
Date: Fri, 6 Aug 2004 17:10:28 +0200
User-Agent: KMail/1.6.2
Cc: alan@redhat.com, arjanv@redhat.com, chrisw@osdl.org,
       Jan Glauber1 <jan.glauber@de.ibm.com>, linux-390@vm.marist.edu,
       linux-kernel@vger.kernel.org, mulix@mulix.org, tim.bird@am.sony.com
References: <OF45879196.98545410-ON42256EE8.003A9AD5-42256EE8.003B151C@de.ibm.com>
In-Reply-To: <OF45879196.98545410-ON42256EE8.003A9AD5-42256EE8.003B151C@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_p95EBYa6grPQ2Rs";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408061710.34015.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_p95EBYa6grPQ2Rs
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freitag, 6. August 2004 12:45, Martin Schwidefsky wrote:
> The times man pages says that the struct tms is defined in sys/times.h.
> This doesn't make it necessary to have a linux/times.h header file.
> These are kernel headers and not user space headers. Does anybody think
> it's important to keep the user/kernel header files names similar ?

I suppose the main point is that stuff like klibc it is better to keep
the existing obvious implementation of sys/times.h instead of changing
it to a less obvious one. Right now, all non linux specific=20
klibc/include/sys/foo.h files start with #include <linux/foo.h>, which
just makes sense.

	Arnd <><

--Boundary-02=_p95EBYa6grPQ2Rs
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBE59p5t5GS2LDRf4RAj9sAJ9Zmxdmy0h7L0l4vaTn5VBVWDZzKwCfdV6d
pkbCT9f2FdsEu6k/wiIYSaE=
=IKwH
-----END PGP SIGNATURE-----

--Boundary-02=_p95EBYa6grPQ2Rs--
