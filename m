Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTH1GBT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 02:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbTH1GBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 02:01:19 -0400
Received: from h80ad2619.async.vt.edu ([128.173.38.25]:28293 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263796AbTH1GBQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 02:01:16 -0400
Message-Id: <200308280601.h7S617ln030394@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Timo Sirainen <tss@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading 
In-Reply-To: Your message of "Thu, 28 Aug 2003 06:17:46 +0300."
             <3217CEE6-D906-11D7-A165-000393CC2E90@iki.fi> 
From: Valdis.Kletnieks@vt.edu
References: <3217CEE6-D906-11D7-A165-000393CC2E90@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1176510910P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Aug 2003 02:01:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1176510910P
Content-Type: text/plain; charset=us-ascii

On Thu, 28 Aug 2003 06:17:46 +0300, Timo Sirainen said:

> How about checksum[n] = data[n-1] ^ data[n]? That looks like it would 
> work.

Unfortunately, if you swap the contents of 'n' and 'n-1', the ^ remains the same,
as it's a commutative operation.

If you want to go down this route, you *really* want to use at least a CRC
here, and understand *why* the incremental computation of the IP header
checksum works at all (hint - the fact it's so simple puts a significant upper
bound on the error-detection strength of the checksum...)

1071 Computing the Internet checksum. R.T. Braden, D.A. Borman, C.
     Partridge. Sep-01-1988. (Format: TXT=54941 bytes) (Updated by
     RFC1141) (Status: UNKNOWN)

1141 Incremental updating of the Internet checksum. T. Mallory, A.
     Kullberg. Jan-01-1990. (Format: TXT=3587 bytes) (Updates RFC1071)
     (Updated by RFC1624) (Status: INFORMATIONAL)

1624 Computation of the Internet Checksum via Incremental Update. A.
     Rijsinghani, Ed.. May 1994. (Format: TXT=9836 bytes) (Updates
     RFC1141) (Status: INFORMATIONAL)

http://www.ietf.org/rfc/rfc1071.txt
http://www.ietf.org/rfc/rfc1141.txt
http://www.ietf.org/rfc/rfc1624.txt

--==_Exmh_1176510910P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/TZqicC3lWbTT17ARAkkTAJ9r63EGV7dyp6Fp8jYg2sa1i/FknQCfThED
Xb1LsCYFsL9uRihEZxxyMsM=
=/cjK
-----END PGP SIGNATURE-----

--==_Exmh_1176510910P--
