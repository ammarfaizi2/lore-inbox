Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263189AbRE1WWQ>; Mon, 28 May 2001 18:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263185AbRE1WWG>; Mon, 28 May 2001 18:22:06 -0400
Received: from pc1-camb6-0-cust57.cam.cable.ntl.com ([62.253.135.57]:11406
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S263190AbRE1WVz>; Mon, 28 May 2001 18:21:55 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: "Vadim Lebedev" <vlebedev@aplio.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Potenitial security hole in the kernel 
In-Reply-To: Message from "Vadim Lebedev" <vlebedev@aplio.fr> 
   of "Mon, 28 May 2001 23:43:38 +0200." <003601c0e7bf$41953080$0101a8c0@LAP> 
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1306962384P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 May 2001 23:21:49 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E154VOX-0002jj-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1306962384P
Content-Type: text/plain; charset=us-ascii

>Suppose the signal handler modifies this context frame for example by
>storing into the PC slot address of the panic routine
>then when handler will exit  panic will be called with obvious results.

You can't execute panic() - or any other kernel function - in user mode.
The application can write what it likes into its sigcontext, and the worst 
that will hapenn is that it will crash itself.

p.



--==_Exmh_-1306962384P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

>Suppose the signal handler modifies this context frame for example by
>storing into the PC slot address of the panic routine
>then when handler will exit  panic will be called with obvious results.

You can't execute panic() - or any other kernel function - in user mode.
The application can write what it likes into its sigcontext, and the worst 
that will hapenn is that it will crash itself.

p.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 (debian)

iD8DBQE7Es99VTLPJe9CT30RAmfxAJ0Sjtu31TsBYYQpnY0uGyfkW+1vgQCeLDq+
VHXbmqAhFJYxuPHyLSaFlJA=
=+Lbc
-----END PGP SIGNATURE-----

--==_Exmh_-1306962384P--
