Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTDUOCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 10:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbTDUOCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 10:02:20 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8832 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261294AbTDUOCT (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 10:02:19 -0400
Message-Id: <200304211414.h3LEEJtb002870@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept? 
In-Reply-To: Your message of "Mon, 21 Apr 2003 13:19:34 +0200."
             <20030421131934.1f6e29b0.skraw@ithnet.com> 
From: Valdis.Kletnieks@vt.edu
References: <mail.linux.kernel/20030420185512.763df745.skraw@ithnet.com> <03Apr21.020150edt.41463@gpu.utcc.utoronto.ca>
            <20030421131934.1f6e29b0.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1671983278P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Apr 2003 10:14:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1671983278P
Content-Type: text/plain; charset=us-ascii

On Mon, 21 Apr 2003 13:19:34 +0200, Stephan von Krawczynski <skraw@ithnet.com>  said:

> I can very well accept that argument. What I am trying to do is only make
> _someone_ writing a fs listen to the problem, and maybe - only maybe - in _hi
s_
> fs it is not as complicated and so he simply hacks it in. I am only arguing f
or
> having a choice. Not more. If e.g. reiserfs had the feature I could simply
> shoot all extX stuff and use my preferred fs all the time. That's just about

So what do you do if your mythical file system supports bad block relocation
but doesn't support something else you need, like journaling or quotas or
whatever?

Nobody's mentioned the most obvious reason why it doesn't belong in the
filesystem, but needs to be in something like the 'md' layer like (I think)
John Bradford suggested:

No amount of code wanking in the filesystem is going to save you if you hit
an error on your swap partition - but an 'md'-like driver might be able to
save you.


--==_Exmh_-1671983278P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+o/y7cC3lWbTT17ARAmJRAJ9wROT130q6knXVgzZ3OWPA5dpGigCgkcpr
ef+M5vWUBQCHwrNMxFfxt90=
=vZso
-----END PGP SIGNATURE-----

--==_Exmh_-1671983278P--
