Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTIZROL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 13:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbTIZROK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 13:14:10 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4736 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261522AbTIZROA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 13:14:00 -0400
Message-Id: <200309261713.h8QHDwXL002422@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] updated exec-shield patch, 2.4/2.6 -G3 
In-Reply-To: Your message of "Fri, 26 Sep 2003 14:28:54 +0200."
             <Pine.LNX.4.56.0309261410130.14571@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.56.0309261410130.14571@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1288573740P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Sep 2003 13:13:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1288573740P
Content-Type: text/plain; charset=us-ascii

On Fri, 26 Sep 2003 14:28:54 +0200, Ingo Molnar <mingo@elte.hu>  said:

> against vanilla 2.6.0-test5:
> 
> 	redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test5-G2

Ingo, you rock. ;)  I'm using a fairly current Rawhide here (within last 2
weeks or so).

Applied with 2 or 3 minor conflicts and a few fuzz/delta messages against
-test5-mm4 (I have a refactored patch if anybody is interested).  It booted
OK, seems to be working well enough that e-mail and XFree (even with the
evil binary NVidia driver) are functional.

>    = 0   exec-shield disabled
>    = 1   exec-shield on PT_GNU_STACK executables [ie. binaries compiled 
>                                                   with newest gcc]
>    = 2   (default) exec-shield on all executables
> 
> value 1 is recommended with glibc and gcc versions that support
> PT_GNU_STACK all across the spectrum. (Fedora Core test2 [released
> yesterday] includes all of this and all applications were recompiled to
> have valid PT_GNU_STACK settings.) On other systems the value of '2' is
> recommended, use setarch for those binaries that cannot take exec-shield
> [eg. Loki games].

I'm assuming it's this GCC change in Rawhide:

* Wed Jun 04 2003 Jakub Jelinek  <jakub@redhat.com> 3.3-4

- mark object files with .note.GNU-stack notes whether they
  need or don't need executable stack

(and another at 3.3-5).  Has the current Rawhide been recompiled with this
support, or should I stick with '2' and use setarch for things that fail?

Now to go build a testcase program and try to shellcode it. ;)


--==_Exmh_1288573740P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/dHPVcC3lWbTT17ARAmOEAJwNJvYXd/QDy3hKizae0CPLXa42LwCgoOFk
KCp6vN3ygdDL+1nekRRg2HE=
=pJWj
-----END PGP SIGNATURE-----

--==_Exmh_1288573740P--
