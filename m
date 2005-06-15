Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVFOMlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVFOMlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 08:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVFOMlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 08:41:03 -0400
Received: from h80ad267a.async.vt.edu ([128.173.38.122]:56585 "EHLO
	h80ad267a.async.vt.edu") by vger.kernel.org with ESMTP
	id S261434AbVFOMky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 08:40:54 -0400
Message-Id: <200506151240.j5FCeO6l027298@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: RT : nvidia driver and perhaps others 
In-Reply-To: Your message of "Wed, 15 Jun 2005 10:21:45 +0200."
             <1118823704.10717.129.camel@ibiza.btsn.frna.bull.fr> 
From: Valdis.Kletnieks@vt.edu
References: <1118823704.10717.129.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118839223_11523P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Jun 2005 08:40:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118839223_11523P
Content-Type: text/plain; charset=us-ascii

On Wed, 15 Jun 2005 10:21:45 +0200, Serge Noiraud said:

> 	I try to compile the nvidia driver for my RT kernel.
> It does not work anymore.

You aren't going to get much sympathy here on that one...:)

> Isn't there a better way to avoid these modifications ?
> for example to have the external fonction the same than non RT kernel.
> and have an internal link to the new one or something like that ?

However, he *does* have a point here - GPL'ed out-of-tree drivers will
have these same issues.  Yes, I know the standard "get them into the tree"
refrain here...

> These drivers are proprietary, so I can't modify them.

Fortunately, NVidia supplies enough pieces to make things work..

> I think we should change :
> 
> 1 - local_irq_* to raw_local_irq_*  : is it always true ?

> 2 - spin_* to raw_spin_*  ?

Ingo et al - what *is* the recommended magic to make a driver compile and
work cleanly with or without RT?  Hopefully there's a simple "will work correctly,
but possibly sub-optimal latency" cookbook scheme....

> and other in two files ... too many modifications.

The C preprocessor is your friend - we *should* be able to make a change in one .h
like '#ifdef SOME_RT_FLAG .. #else ... #endif' to do most of the work...


--==_Exmh_1118839223_11523P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCsCG2cC3lWbTT17ARAtSIAJ9gZcnrLb2m3SJ/02VXE0ldO+Hm7gCguhfH
2wHxwAKtFi8l2aV8wop9IUI=
=y4lu
-----END PGP SIGNATURE-----

--==_Exmh_1118839223_11523P--
