Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316023AbSEZM3P>; Sun, 26 May 2002 08:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316025AbSEZM3O>; Sun, 26 May 2002 08:29:14 -0400
Received: from ppp-217-133-218-67.dialup.tiscali.it ([217.133.218.67]:19689
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S316023AbSEZM3N>; Sun, 26 May 2002 08:29:13 -0400
Subject: How to send GnuPG signed mail to linux-kernel and maintainers?
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-8iU2O/H4rXF9rRhGgwdt"
X-Mailer: Ximian Evolution 1.0.5 
Date: 26 May 2002 14:29:07 +0200
Message-Id: <1022416147.4072.14.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8iU2O/H4rXF9rRhGgwdt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Until now, I have sent mail to linux-kernel using an unmodified version
of Ximian Evolution with PGP sign turned on. 

However, I've noticed that this causes the message to contain some
escape codes that, after reading a few RFCs and the source code, turn
out to be caused by the fact that Evolution, in compliance with RFC2015,
sends PGP-signed bodies as quoted-printable unless they are already
tagged as base64. 

The rationale is that quoted-printable avoids any modification by
gateways that would obviously cause the signature to be invalid. 
However, both the cs.helsinki.fi archive and Linus' scripts (he is
quoted in the L-K FAQ saying that he only wants unmangled text/plain) do
not properly support MIME transfer encodings. 
Furthermore, if a gateway modifies a message, patches should also be
adversely affected, so this shouldn't be a problem.

Thus, among the possible solutions, the best one (and the one I'm
currently using, by patching Evolution) appears to be violating the RFC
and sending as 7-bit rather than as quoted-printable, risking
invalidation of the signatures by gateway modifications.

Not using digital signatures is obviously not an option since there is
no way to prove that a message was not authentic (if it contains a
trojan patch, for example). 

Is this solution the best/recommended one? 
Shouldn't this be added to the FAQ? 


--=-8iU2O/H4rXF9rRhGgwdt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA88NUTdjkty3ft5+cRAuZUAKCOQTlr4Le8qLMUM1Y+Q7RtQVSSfACdF6Nl
JpCK/e61InLbynmov/I7Olg=
=ipHf
-----END PGP SIGNATURE-----

--=-8iU2O/H4rXF9rRhGgwdt--
