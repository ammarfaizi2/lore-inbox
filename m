Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274970AbTHPUuI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 16:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274971AbTHPUuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 16:50:08 -0400
Received: from h80ad24a3.async.vt.edu ([128.173.36.163]:33194 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S274970AbTHPUuD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 16:50:03 -0400
Message-Id: <200308162049.h7GKnwnP024716@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged 
In-Reply-To: Your message of "Sun, 17 Aug 2003 04:10:30 +0800."
             <200308170410.30844.mhf@linuxmail.org> 
From: Valdis.Kletnieks@vt.edu
References: <200308170410.30844.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-67522146P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 16 Aug 2003 16:49:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-67522146P
Content-Type: text/plain; charset=us-ascii

On Sun, 17 Aug 2003 04:10:30 +0800, Michael Frank <mhf@linuxmail.org>  said:
> Linux logs almost everything, why not exceptions such as SIGSEGV in userspace which
> may be very informative?

Consider this code:

	char *foo = 0;
	sigset(SIGSEGV,SIG_IGNORE);
	for(;;) { *foo = '\5'; }

Your logfiles just got DoS'ed....

(Your syslog will just print 'last message repeated 11934 times'? OK, put two
different signals in the loop.. ;)

And yes, I've worked on systems that will log SEGV... and the logs get ugly.

--==_Exmh_-67522146P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Ppj1cC3lWbTT17ARAhQxAKCo+KB0CToATsBZE8CllMjTF7wangCgiind
G09GDNe5+vMau7+mp6Qgc4g=
=14hF
-----END PGP SIGNATURE-----

--==_Exmh_-67522146P--
