Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWFFV4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWFFV4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWFFV4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:56:35 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:16069 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751182AbWFFV4e (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:56:34 -0400
Message-Id: <200606062156.k56LuWFD001871@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quick close of all the open files.
In-Reply-To: Your message of "Wed, 07 Jun 2006 03:15:43 +0530."
             <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149630992_2972P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Jun 2006 17:56:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149630992_2972P
Content-Type: text/plain; charset=us-ascii

On Wed, 07 Jun 2006 03:15:43 +0530, vamsi krishna said:
> Hello,
> 
> I found that the following code is closing all the open files by the
> program, do you think its a bug in kernel code?
> 
> ------------
> fp = tmpfile();
> fp->_chain = stderr;
> fpclose(fp);
> fp = NULL;

strace that, and see how many times close() gets called.  If it gets
called once, it's a kernel bug.  If it gets called once for each open
file, it's a userspace bug.

For bonus points, how did you verify that all the open files were closed?

(Hint - what does that fp->_chain = stderr *really* do? ;)

--==_Exmh_1149630992_2972P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEhfoQcC3lWbTT17ARAi9+AJ4kPoO6InAO79ZSzGof4mOqH82KSQCgt1vW
TDbQIU29R0pADEP/Zuou/Bo=
=mKdC
-----END PGP SIGNATURE-----

--==_Exmh_1149630992_2972P--
