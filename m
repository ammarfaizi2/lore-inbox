Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTDNTIo (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbTDNTIo (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:08:44 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43136 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263880AbTDNTIk (for <RFC822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:08:40 -0400
Message-Id: <200304141920.h3EJKTIO014891@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4+dev
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: KML <linux-kernel@vger.kernel.org>
Subject: Re: Oops: ptrace fix buggy 
In-Reply-To: Your message of "Mon, 14 Apr 2003 20:58:06 +0200."
             <20030414185806.GA12740@wohnheim.fh-wedel.de> 
From: Valdis.Kletnieks@vt.edu
References: <200304121154.32997.m.c.p@wolk-project.de> <Pine.LNX.4.44.0304140713510.22450-100000@cafe.hardrock.org> <20030414134603.GB10347@wohnheim.fh-wedel.de> <1050330667.4059.27.camel@workshop.saharact.lan> <20030414144709.GE10347@wohnheim.fh-wedel.de> <1050343825.4757.17.camel@nosferatu.lan>
            <20030414185806.GA12740@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2061338080P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Apr 2003 15:20:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2061338080P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Apr 2003 20:58:06 +0200, =3D?iso-8859-1?Q?J=3DF6rn?=3D Engel s=
aid:

> Module load sounds unrealistic for .[123...], as you shouldn't change
> any interfaces with fixes. But it might be a real problem for -ac.

I'm reading this, and looking at a patch from Russell King that entirely
nukes several functions, and adds several new ones:

-static int setup_socket(socket_info_t *);
 static void shutdown_socket(socket_info_t *);
-static void reset_socket(socket_info_t *);
-static void unreset_socket(socket_info_t *);
 static void parse_events(void *info, u_int events);
+static void sm_init(socket_info_t *s);
+static void sm_exit(socket_info_t *s);

And yes, that's in something that could be a module (pcmcia/cs.c).

(Yes Russell, I'll test it when I get home - the offending card is there
and I'm here at the moment.. ;)

--==_Exmh_-2061338080P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+mwn9cC3lWbTT17ARAvBMAJ0deOMeeO7lcpB8SHLkmBKfJqwYHgCglYJ1
GeF+MwJyXX4YmNPi8BTCbRY=
=bQne
-----END PGP SIGNATURE-----

--==_Exmh_-2061338080P--
