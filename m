Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266475AbUBLP10 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 10:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266478AbUBLP10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 10:27:26 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:49309 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266475AbUBLP1Y (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 10:27:24 -0500
Message-Id: <200402121526.i1CFQXL7018236@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andy Isaacson <adi@hexapodia.org>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.) 
In-Reply-To: Your message of "Wed, 11 Feb 2004 18:45:32 CST."
             <20040212004532.GB29952@hexapodia.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040209115852.GB877@schottelius.org> <slrn-0.9.7.4-32556-23428-200402111736-tc@hexane.ssi.swin.edu.au> <1076517309.21961.169.camel@shaggy.austin.ibm.com>
            <20040212004532.GB29952@hexapodia.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1366536276P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Feb 2004 10:26:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1366536276P
Content-Type: text/plain; charset=us-ascii

On Wed, 11 Feb 2004 18:45:32 CST, Andy Isaacson said:

> Does JFS on AIX have the same buggy behavior?

Nope, it's been tolerant of all 254 bit patterns except \0 and '/'
since at least AIX 3.1.2 back in the early 90s.  It doesn't even have
a concept of "UTF-8 filename" - it considers that a userspace issue.

Now, over the last 15 years I've tripped over a number of *userspace*
things that did really stupid things when handed non-ASCII filenames,
but that's a different issue...


--==_Exmh_1366536276P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAK5spcC3lWbTT17ARAmdwAJ9B0yMRGJMlDU+ZbO1tLdn+8UWJEQCeMC5A
jup9F7SJNvFAcjA6WjXGWGQ=
=ecXv
-----END PGP SIGNATURE-----

--==_Exmh_1366536276P--
