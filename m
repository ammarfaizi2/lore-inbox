Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267088AbRG1VGx>; Sat, 28 Jul 2001 17:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbRG1VGn>; Sat, 28 Jul 2001 17:06:43 -0400
Received: from pc2-camb6-0-cust223.cam.cable.ntl.com ([213.107.107.223]:39297
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S267088AbRG1VGk>; Sat, 28 Jul 2001 17:06:40 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Robert Schiele <rschiele@uni-mannheim.de>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.4.8-pre1 build error in drivers/parport/parport_pc.c 
In-Reply-To: Message from Robert Schiele <rschiele@uni-mannheim.de> 
   of "Sat, 28 Jul 2001 22:29:43 +0200." <20010728222943.A24586@schiele.swm.uni-mannheim.de> 
In-Reply-To: <01072619531103.06728@localhost.localdomain> <20010727101241.A15014@schiele.swm.uni-mannheim.de> <rschiele@uni-mannheim.de> <E15QX7a-0000gl-00@kings-cross.london.uk.eu.org>  <20010728222943.A24586@schiele.swm.uni-mannheim.de> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-625210863P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 28 Jul 2001 22:06:43 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E15QbIJ-0001kG-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

--==_Exmh_-625210863P
Content-Type: text/plain; charset=us-ascii

>The "extern" was only an escape for the case that the compiler cannot
>inline the function. Due to the fact, that current gcc has "static
>inline" it is better to use this, because with "static inline" we do
>not need to keep a global symbol just for the case the compiler is not
>capable to inline the function in some place.

The versions in the .c file are there so that the "ops" structure can point to 
them.  The ones in the .h file are purely an optimisation to allow you to 
short-circuit the ops struct if you know only one driver is involved.

Changing this stuff to "static inline" still offends my sense of aesthetics 
somewhat, but I guess it's okay if you have checked that it still does the 
right thing in the CONFIG_PARPORT_OTHER case.

p.


--==_Exmh_-625210863P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 (debian)

iD8DBQE7YyljVTLPJe9CT30RAnS9AKCrjl0qukvdt9pbsdfQMfvH77PMrgCeOTMj
1TSq0ueN00Hh4Pgu6BrmiY8=
=tYN+
-----END PGP SIGNATURE-----

--==_Exmh_-625210863P--
