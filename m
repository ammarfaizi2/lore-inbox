Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSKRIWP>; Mon, 18 Nov 2002 03:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSKRIWP>; Mon, 18 Nov 2002 03:22:15 -0500
Received: from ppp-217-133-216-163.dialup.tiscali.it ([217.133.216.163]:13697
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S261660AbSKRIWO>; Mon, 18 Nov 2002 03:22:14 -0500
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211181026090.29168-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211181026090.29168-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-FbiN7rpTcwVZbqL+bp2X"
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Nov 2002 09:29:07 +0100
Message-Id: <1037608147.1774.45.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FbiN7rpTcwVZbqL+bp2X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> problem Ulrich mentioned - it splits up ->user_tid into ->set_child_tid
> and ->clear_child_tid pointers. This way the clearing and setting
> functionality is cleanly separated.
How about making ->set_child_tid a parameter for schedule_tail, or even
directly using it in the ret_from_fork assembly?
It doesn't make much sense to have a variable in task_struct which is
used only at task creation.


--=-FbiN7rpTcwVZbqL+bp2X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA92KTTdjkty3ft5+cRAjf8AKCeaUw8ZBQHH/fNNcHEBRC+wKOlmQCeK70V
hVPx7UBRBhNA2x5kDF2+PAU=
=BV67
-----END PGP SIGNATURE-----

--=-FbiN7rpTcwVZbqL+bp2X--
