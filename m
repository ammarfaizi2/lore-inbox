Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263095AbSJGP1U>; Mon, 7 Oct 2002 11:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263096AbSJGP1U>; Mon, 7 Oct 2002 11:27:20 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:30702 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263095AbSJGP1R>; Mon, 7 Oct 2002 11:27:17 -0400
Subject: Re: wake_up from interrupt handler
From: Arjan van de Ven <arjanv@redhat.com>
To: Amol Lad <dal_loma@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021007142520.56164.qmail@web12406.mail.yahoo.com>
References: <20021007142520.56164.qmail@web12406.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-YG6wMCCi7rKuye7aGRG8"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 17:36:37 +0200
Message-Id: <1034004998.2815.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YG6wMCCi7rKuye7aGRG8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-10-07 at 16:25, Amol Lad wrote:
> In this code too.. lost-wakeup problem is not solved
>=20
> if (event_occured)
>   else=20
>     schedule();
>=20
> what if in check ' if(event_occured) ' goes to 'else'
> and before calling schedule() my ISR interrupted this
> thread and set the event..

that's fine; the wake_up() will mark your process as TASK_RUNNING at
which point the schedule() is effectively a NOP, at which point your
event loop just loops immediatly again ->  no problem

always keep interrupts enabled during this, no need to block them ;)

--=-YG6wMCCi7rKuye7aGRG8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9oaoFxULwo51rQBIRAnUqAJ9ird9Eyhh0te35p8ty0jzkvZWvPwCgoHW2
x8ms9MC+cyFH2DYfoKQzSEk=
=ohpW
-----END PGP SIGNATURE-----

--=-YG6wMCCi7rKuye7aGRG8--

