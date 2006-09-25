Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWIYBNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWIYBNE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWIYBNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:13:04 -0400
Received: from pool-71-254-65-206.ronkva.east.verizon.net ([71.254.65.206]:8391
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932194AbWIYBNC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:13:02 -0400
Message-Id: <200609250112.k8P1CTfZ019880@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Stas Sergeev <stsp@aknet.ru>
Cc: Ulrich Drepper <drepper@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
In-Reply-To: Your message of "Sat, 23 Sep 2006 19:47:19 +0400."
             <45155707.4010906@aknet.ru>
From: Valdis.Kletnieks@vt.edu
References: <45150CD7.4010708@aknet.ru> <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com> <45155499.4000209@redhat.com>
            <45155707.4010906@aknet.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159146748_16795P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 24 Sep 2006 21:12:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159146748_16795P
Content-Type: text/plain; charset=us-ascii

On Sat, 23 Sep 2006 19:47:19 +0400, Stas Sergeev said:
> Hi.
> 
> Ulrich Drepper wrote:
> > Definitely not.  The test should stay.  It does the right thing.  Yes,
> > some applications might break, but this is the fault of the application.
> But why exactly? They do:
> shm_open();
> mmap(PROT_READ|PROT_WRITE|PROT_EXEC);
> and mmap fails.
> Where is the fault of an app here?

'man 2 open' reports the following error code as a possibility:
       EROFS  pathname refers to a file on a read-only filesystem and write
	access was requested.

Are you suggesting that it's not an app's fault/problem if it tries to
open a writable file on a R/O filesystem?  Because it's essentially the
same problem....


--==_Exmh_1159146748_16795P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFFyz8cC3lWbTT17ARAnocAJoCeDx/9zrQ0TujdHm2f4bL/olGBACfRWk3
ho+RNpkBF6qqpbCJ4e7FFHo=
=TrdD
-----END PGP SIGNATURE-----

--==_Exmh_1159146748_16795P--
