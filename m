Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318143AbSHLPvN>; Mon, 12 Aug 2002 11:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318734AbSHLPvM>; Mon, 12 Aug 2002 11:51:12 -0400
Received: from ppp-217-133-217-5.dialup.tiscali.it ([217.133.217.5]:5800 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S318733AbSHLPvC>;
	Mon, 12 Aug 2002 11:51:02 -0400
Subject: Re: [patch] tls-2.5.31-D5
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jakub Jelinek <jakub@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Alexandre Julliard <julliard@winehq.com>
In-Reply-To: <Pine.LNX.4.44.0208121939260.22188-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208121939260.22188-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-YMDRLls9mN9QXPaR13Qt"
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Aug 2002 17:54:44 +0200
Message-Id: <1029167684.4531.88.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YMDRLls9mN9QXPaR13Qt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> well, i think i have to agree ... if it wasnt for Wine's 0x40 descriptor.  
> But it certainly does not come free. We could have 3 TLS entries (0x40
> will be the last entry), and the copying cost is 9 cycles. (compared to 6
> cycles in the 2 entries case.) Good enough?
Or we could leave 0x40 fixed to 0x400 and use only 2.

This loses flexibility but anyway the only 2 apps that could use it are
dosemu and wine and I think that they already need to have it mapped at
0x400 for vm86 (no one uses 16-bit DLLs anymore).

Of course this is only valid if Win32 doesn't use it because otherwise
we would lose the ability to do null-pointer checking in programs using
Win32 DLLs (e.g. mplayer).


--=-YMDRLls9mN9QXPaR13Qt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9V9pEdjkty3ft5+cRAhtUAKDh/rFbCm/egDWR4OPDLG9Fmnje7gCgpaPw
HRLMk6HrR5e+Gow2fUKeYZU=
=z12f
-----END PGP SIGNATURE-----

--=-YMDRLls9mN9QXPaR13Qt--
