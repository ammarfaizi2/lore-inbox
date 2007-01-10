Return-Path: <linux-kernel-owner+w=401wt.eu-S932671AbXAJCoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbXAJCoJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 21:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbXAJCoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 21:44:09 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:46398 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932671AbXAJCoH (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 21:44:07 -0500
Message-Id: <200701100243.l0A2hZxH013254@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Hua Zhong <hzhong@gmail.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
In-Reply-To: Your message of "Tue, 09 Jan 2007 16:00:51 PST."
             <802696.41460.qm@web55611.mail.re4.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <802696.41460.qm@web55611.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168397015_27952P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Jan 2007 21:43:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168397015_27952P
Content-Type: text/plain; charset=us-ascii

On Tue, 09 Jan 2007 16:00:51 PST, Amit Choudhary said:

> What did you understand when I wrote that "if you access the same memory again using the variable
> 'x"?
> 
> Using variable 'x' means using variable 'x' and not variable 'y'.

Right - but in real-world code, 'y' is the actual problem.

> Did I ever say that it fixes that kind of bug?

The point you're missing is that you're "fixing" a failure mode that in
general isn't seen, and ignoring the failure mode that *is* seen.

> Dereferencing 'x' means dereferencing 'x' and not dereferencing 'y'.

And neither "x" nor "y" is "the set of all still-live pointers to already-freed
memory" - which is why your proposal doesn't actually do anything effective.


--==_Exmh_1168397015_27952P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFpFLXcC3lWbTT17ARAoDzAKDQi6zGAFISialMr+wkkBNjaQ9BvwCgtc6p
J2HFLU2pBlFURBKGk/1NZn4=
=yAju
-----END PGP SIGNATURE-----

--==_Exmh_1168397015_27952P--
