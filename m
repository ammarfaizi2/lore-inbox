Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbTAFUZ3>; Mon, 6 Jan 2003 15:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267115AbTAFUZ2>; Mon, 6 Jan 2003 15:25:28 -0500
Received: from ppp-217-133-219-133.dialup.tiscali.it ([217.133.219.133]:55425
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S267029AbTAFUZ2>; Mon, 6 Jan 2003 15:25:28 -0500
Date: Mon, 6 Jan 2003 21:26:54 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Set TIF_IRET in more places
Message-ID: <20030106202654.GA8379@ldb>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
References: <20030106181737.GA6867@ldb> <Pine.LNX.4.44.0301061046180.13284-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301061046180.13284-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> vfork and clone do not work at all with sysenter due to user stack issues.
I actually meant CLONE_VFORK, that if used without CLONE_VM can go
through sysenter (if CLONE_VFORK is not used TIF_NEED_RESCHED is set
so there is no problem).

I also think that vfork() could be used with AT_SYSINFO by switching
stacks around the call (with care about recursive vfork and signals
calling vfork inside the vfork stack).

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+GeaNdjkty3ft5+cRAlnJAJ9SIoebjKHtvCM4AFblf3PnvoxBIgCg09NL
+9Bf2S7F5S7S0Yp2tHVMGSM=
=XZrW
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
