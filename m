Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264036AbTJ1QhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 11:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264038AbTJ1QhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 11:37:18 -0500
Received: from h80ad275b.async.vt.edu ([128.173.39.91]:3989 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264036AbTJ1QhQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 11:37:16 -0500
Message-Id: <200310281637.h9SGb5xF026894@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: Boszormenyi Zoltan <zboszor@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Autoregulate vm swappiness cleanup 
In-Reply-To: Your message of "Tue, 28 Oct 2003 10:54:56 EST."
             <Pine.LNX.4.53.0310281048130.21561@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <3F9E707B.7030609@freemail.hu> <Pine.LNX.4.53.0310280936550.20004@chaos> <200310281539.h9SFdixF024951@turing-police.cc.vt.edu>
            <Pine.LNX.4.53.0310281048130.21561@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1054703216P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Oct 2003 11:37:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1054703216P
Content-Type: text/plain; charset=us-ascii

On Tue, 28 Oct 2003 10:54:56 EST, "Richard B. Johnson" said:

> I keep hearing 'pollutes the global namespace' all the time, now. Do
> you mean that 'C' code designers actually intend to use the same
> name for different procedures or objects in different files?

Right. Exactly.

That's why you need to have module1_debug_level, module2_debug_level,
module3_debug_level and so on, rather than have a 'debug_level' that's visible
in module1, another that's visible in module2, and a third that's visible in
module3. Note that you *CAN* do that if module1, module2, and module3 are all
*single* .c files simply by declaring it 'static int debug_level;'.  But if you
decide to splt module1 and module2 into 2 .c files each, suddenly you need to
rename *both* variables....

And I'm *positive* that *nobody* on this list has done that, forgotten to
rename the variables, and then wondered why module1 has 'debug_level = 1;' in
it and the debugging output starts and then mysteriously stops some random time
after (because module2 has 'debug_level = 0;' in it...)

Yes, C does not have a C++ idea of "private data".  My point is that quite
often, the use of 'static' to simulate it is the reason for very large .c
files....


--==_Exmh_1054703216P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/npswcC3lWbTT17ARAgOvAKD+kekXVBcFjzF/zMdUp17hQe50bACeNq25
vmMzwVgvFNyEhHUHNjNtvug=
=+pMV
-----END PGP SIGNATURE-----

--==_Exmh_1054703216P--
