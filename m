Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266921AbRG1Qjy>; Sat, 28 Jul 2001 12:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266929AbRG1Qjp>; Sat, 28 Jul 2001 12:39:45 -0400
Received: from pc2-camb6-0-cust223.cam.cable.ntl.com ([213.107.107.223]:49536
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S266921AbRG1Qj2>; Sat, 28 Jul 2001 12:39:28 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Robert Schiele <rschiele@uni-mannheim.de>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.4.8-pre1 build error in drivers/parport/parport_pc.c 
In-Reply-To: Message from Robert Schiele <rschiele@uni-mannheim.de> 
   of "Fri, 27 Jul 2001 10:12:41 +0200." <20010727101241.A15014@schiele.swm.uni-mannheim.de> 
In-Reply-To: <01072619531103.06728@localhost.localdomain>  <20010727101241.A15014@schiele.swm.uni-mannheim.de> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-666839274P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 28 Jul 2001 17:39:22 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E15QX7a-0000gl-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

--==_Exmh_-666839274P
Content-Type: text/plain; charset=us-ascii

>Hmm, these functions are multiply defined, namely in the c source and
>in it's header file. I see no reason why someone should do this. The
>problem was hidden in older kernel releases by the fact that these
>functions were declared "extern __inline__" which is absolutely
>nonsense in my opinion. So the solution should be to just remove these
>inline functions from the c source file, which can be done with the
>following simple and stupid patch.
>
>This should be the correct solution, or did I miss the vital point?

I think you did miss the vital point: this will probably break with 
CONFIG_PARPORT_OTHER.

Declaring them "extern inline" in parport_pc.h is exactly the right thing to 
do.  What do you think is wrong with that?

p.


--==_Exmh_-666839274P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 (debian)

iD8DBQE7Yuq6VTLPJe9CT30RAqD2AJ9Z80DI5FlP08PxtMruZ2VWYrh8UwCdHfz6
buNAlPfpnXM5CCqvEzC5EmA=
=zRDp
-----END PGP SIGNATURE-----

--==_Exmh_-666839274P--
